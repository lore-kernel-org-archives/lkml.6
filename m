Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995EBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511A920846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dykITeci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511A920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933376AbeFUPSO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:18:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45208 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933277AbeFUPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:18:09 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so3594202wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGT0s6adsXPEtoUeyvzeBpfvbh0u19LvCh1OPJVVasc=;
        b=dykITeciHe00dzFZRr/02rW9zZuJHidY8Z4ERBAAXEgMSDtoWsu1+T7SEaoIfVMGty
         qeUvYgEYTmbFfJnBMsQ61+WW8ov7cL0MQEFmpZOXXQio/zZIyAc4nuoSq+8btiulnjas
         G2Q5szRvnzD2orSgWIqL4MZKvpoLBCFFcRpYObwh/IFy/OBH8fM3MNq8bVp2VUMiu5jD
         utorBVrcb/UC1IkraftlM+mfo1KC+vDJa3XfEhdGG1ho3ylRTTuvb4zjgJgfChEr/LZx
         VEmL0Av4HQ0ZDIM8duHD2Nxy+kGBjca9q1iPP5ZAllS3V9I0lGXpoLTSax+Mpord3FLZ
         71og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGT0s6adsXPEtoUeyvzeBpfvbh0u19LvCh1OPJVVasc=;
        b=KhYW0El7h9arajfG4fR+BR7UoXexAXvctF/pfGw8HVznfgqsQy/MxDCIpmSH/rMoBv
         le04wFnbA/FdjOFavGQHOuld7KO1QKJ0JuBPd2jbaOvBaFSNtnkk+BM5LcFK2UtVYTZl
         noIIUC967CYrg9WSiiDL+DtjN3v+qKXFg0zC8hwE7vr/Tl+jZo+AekxjeTk4j+XKfYfN
         UYiHv5QQ0YxiybulUaWRqteBM1dYVKIw7dSKWoBfXcmNrQ4ScIUmv/vO3q+TDjiOTyv8
         zdoq1u76KotJSgt075VrwKQuF7cweCDR4t4x+CeWpVKW7wuji/qx2t3E/HFSYYH1Bp9V
         yUOA==
X-Gm-Message-State: APt69E0azZ09K9ukZgi0Iij7yhKcIFkKaPIyY+tlOYNw+n4Z64vQ/Ema
        3N6gD+MqgHRd3u9VhTeh/TQ=
X-Google-Smtp-Source: ADUXVKINZa76igxQAzEeX7fZWyEQZsPSH45v9zTM2+Lq9u8tKYAwAy+pflHQ6oBNctY87Ff1hI6muw==
X-Received: by 2002:adf:b502:: with SMTP id a2-v6mr23084145wrd.273.1529594288001;
        Thu, 21 Jun 2018 08:18:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z13-v6sm5729560wrr.71.2018.06.21.08.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 08:18:07 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:18:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Exclude 'top_pgtable' from
 relocation
Message-ID: <20180621151805.GA27636@gmail.com>
References: <20180502160816.35986-1-kirill.shutemov@linux.intel.com>
 <alpine.LSU.2.11.1805022001080.3096@eggly.anvils>
 <20180503083849.j42uzp6jjpauk475@kshutemo-mobl1>
 <20180503105205.qmosbbbbp5jssehj@black.fi.intel.com>
 <alpine.LSU.2.11.1805031017420.1259@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1805031017420.1259@eggly.anvils>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hugh Dickins <hughd@google.com> wrote:

> On Thu, 3 May 2018, Kirill A. Shutemov wrote:
> 
> > On Thu, May 03, 2018 at 08:38:49AM +0000, Kirill A. Shutemov wrote:
> > > The patch is bogus and I still don't understand what is going on.
> > 
> > I think I found the issue. Could you check the patch below:
> 
> Sorry, no good on either machine, immediate reboot as before.
> I'm gathering the info you asked, will send privately in an hour or so.

Hi, any update on this bug?

Kirill: mind (re-)sending a series of any resulting patches that you have pending?

If there's no fix, is there any list of SHA1's to revert?

Thanks,

	Ingo
