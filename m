Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E4CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC5320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544117789;
	bh=isQkKi+0poTy0HrhEO1/V0MEhuYKBhPdzi+LFXWdkqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uPDrJezsqm04phT4Uoa82WDQhDB6V8bQYP3NZYTvMTkjN3JZxwTYBgvpntH+O428q
	 midE/NzuSiD1CM8a08nMjFxFoWFUcgJ2A/g/bu4e/OxZ7DcwS126ESIMPijeXPCBOq
	 pdyFFXEUGfUOvDguRffj1924bjTWCGkhOZZPrKxw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC5320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLFRg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:36:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55019 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeLFRg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:36:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id z18so1807935wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RipILcQUpcH8GUSH9/CuTptFulrcCQEOXLwS1tPYpEc=;
        b=IfwL/StQPm7N8olcHNWcUOamvmzRs9EXsPcINNOPtIa5ele76oSjmmaGLSQFcVnPY5
         8VsoK4m8RJh88xr1cjgHELc+g66OsTqnTrF+/PxWCYI5hCuCK/ffv3eQZT6FPOWApZdy
         lIVis1h/sNwvweZnzoyqRoX4QlowgcZZvjy/yhoXTrUaCfwmgdumoaZiAJOdUQtv3Tuq
         d94qZRdvKNVE/t7mKNH9SnzWKFKBhqCpfwSPdCQfNclF3A0dxUecJWrIjploBW1u2y79
         7pDM/N6xIAwqN6iChwoKGvOqzQgpOv1Q3n4j0R3b/Ty8c5nXbl1nYPgsYtIl/ulh0fTG
         cuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RipILcQUpcH8GUSH9/CuTptFulrcCQEOXLwS1tPYpEc=;
        b=ldqk5DJthMHjHQOPBIx3fxPJLl4SoOgl2plOTnCQaNGI+hqV+oiUmzhykCFkTDugun
         JRBdL17AgYIulU2WSZiGegHFs7Igl7DYADXWRRw7Zk+IxJXINEZOysCpm4Lo9hMmYkpe
         Kv4Z696Tb2o59LHDwFzvOcz4o6DOkr3q2fdTIgNladKG7jLkXMjmGPvfZ7rVBtvFt8C3
         xp8HaD86jGbCUBUAF/di3TF+6cQFlY15j2Y1FwGDZMNI6nRO95NoigtCPZxK2T7Beqbu
         Jagp6az4LZ/VzPd86zGSrZ3eUsc/XLTS/ZSjiMEOS6DWaDsmuSB260L9qIxMG4F4uP2X
         1ytQ==
X-Gm-Message-State: AA+aEWbiHAMBNiKf64I+Y2yQGndOTWHQpExTkTXk+nAP5+WRt4NXNHRO
        54N/6rNDpxvNA3PnPrS4IveLySsu
X-Google-Smtp-Source: AFSGD/WMHBu6ooyZ1FYMOl1cAYUcG9Cb9bmy64dX/8RmpOHGDpqt9fzCfvh3gPeDCyK87vO+FxKBSA==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr7082223wml.102.1544117784797;
        Thu, 06 Dec 2018 09:36:24 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h127sm2076839wmd.31.2018.12.06.09.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:36:24 -0800 (PST)
Date:   Thu, 6 Dec 2018 18:36:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder
 some more
Message-ID: <20181206173621.GA31884@gmail.com>
References: <20181205163624.1842-1-sean.j.christopherson@intel.com>
 <20181206073409.GA64887@gmail.com>
 <20181206155336.GC31263@linux.intel.com>
 <C1F7477E-70B1-4F26-9457-EA6D825501A6@amacapital.net>
 <20181206164710.GA119529@gmail.com>
 <EF7E7857-B4DF-4C14-85F5-114B03D5295D@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EF7E7857-B4DF-4C14-85F5-114B03D5295D@amacapital.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@amacapital.net> wrote:

> That’s why I suggested “read,” in lowercase, for reads.  Other than 
> that, most of the unset bits are uninteresting. An OOPS is so likely to 
> be a kernel fault that it’s barely worth mentioning, and I even added a 
> whole separate diagnostic for user oopses.  Similarly, I don’t think we 
> need to remind the reader that an oops wasn’t an SGX error or that it 
> wasn’t a PK error.  So I think my idea highlights the interesting bits 
> and avoids distraction from the uninteresting bits.

Ok - all good points.

Thanks,

	Ingo
