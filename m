Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255FDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E642154B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="vDpwD1q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E642154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbeGFQ3h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:29:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33092 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbeGFQ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:29:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so3109458plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5GleeQ03/yrXz7D4DkckWgUSEGmGDU0ALVXgr0xqNoI=;
        b=vDpwD1q0hOaSRLAG1j+DXW8LTF/WiDV4Cuek54IpeDodiN0R56JhtM2DVGXnngIDxc
         1DCPN12o78wVv1I+VtuZ08PiIe9LwsV7udYaw5hpn8rui+oNL9Ws6l4xeJdqb0bMkc0K
         rMobP9sxAXV9rh4Fec7qeNyrjwy+f30jP+qQ2nYewt1sQAmaCH/NZgVTCHwmJ7ZNLWYK
         03GTZcgl32EhnhVhnZ2O8LKHLUJK6zOSK9bMVWXj7DbnHDzvupiN4Gc0UqZK5mqvnrtP
         S7h7ZBnz0Lh7c1K0xsGK3c2GVNiSw+PvCrPQrDK/RnwT659Oe+28OkDBTmh4LkHA2DGr
         hNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5GleeQ03/yrXz7D4DkckWgUSEGmGDU0ALVXgr0xqNoI=;
        b=GLdsiGSempPByalE62YRyGWvFunEb5ry5J5D4/HIfhkrXGHijCNXGVyP4+QEwekirj
         JZ6CqnsjL7/hz2czIkMGfV+d4+leqVuCCp+c4+RDaTUI6yiDkYMfKys9s2+GUrk991h4
         yGwmtqXDh7qDlaTKebYIowupkTLW7n7ngE6jwIC3x7ADqYtLXUD5D0eOeWe6B1vOB4XA
         TUVN06THA4Y9hawECwFc8APWaU0ct+dG5ViLwD0G+MXovsK7vvj3wJxCc/aUxXwCRxOu
         YG83swHNYh4frDnWqLLUNrBjF+6oQGuLvBZabWIj50oepdm98NQFP4W73B6bAYPvACe1
         1qEg==
X-Gm-Message-State: APt69E0IWLWKIi2VN4ayx6jsgaXYqkGinLFmvrwmaqYcA478TbXdaafi
        TgTtYHEk3BR8OpmhwlK2RePjpw==
X-Google-Smtp-Source: AAOMgpca9VRXmRdp/ldnSSmzAP3fwq3dGK/7580TxCwnfU7HmgPjrbTqRr9KPpe7DuIr7ACNparFgA==
X-Received: by 2002:a17:902:b596:: with SMTP id a22-v6mr10766120pls.154.1530894573390;
        Fri, 06 Jul 2018 09:29:33 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id i89-v6sm26036690pfi.170.2018.07.06.09.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:29:32 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4B9FF30003D; Fri,  6 Jul 2018 19:29:28 +0300 (+03)
Date:   Fri, 6 Jul 2018 19:29:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Gabriel C <nix.or.die@gmail.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180706162928.73jfqtdwdcwtagui@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
 <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1>
 <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:13:02PM +0900, Masahiro Yamada wrote:
> >> LDFLAGS is for internal-use.
> >> Please do not override it from the command line.
> >
> > Can we generate a build error if a user try to override LDFLAGS, CFLAGS or
> > other critical internal-use-only variables?
> 
> Yes, Make can check where variables came from.

I think we should do this.

> >> make LDFLAGS_KERNEL=...  LDFLAGS_MODULE=...
> >> will allow you to append linker flags.
> >
> > Okay. It makes me wounder if we should taint kernel in such cases?
> > Custom compiler/linker flags are risky and can lead to weird bugs.
> 
> OK.
> So, what problem are we discussing?

Users set custom LDFLAGS/CFLAGS and break kernel. Then report bug that
hard to debug. See

https://bugzilla.kernel.org/show_bug.cgi?id=200385

and start of this thread:

https://lore.kernel.org/lkml/20180701213243.GA20180@trogon.sfo.coreos.systems/

It took me a while to track down the issue. I blamed linker for a while.

> > I've got it wrong. *Any* LDFLAGS option passed to make this way:
> >
> >  make LDFLAGS="..."
> 
> In your previous mail, I thought you were asking me how to pass
> custom linker flags.
> 
> If not, we do not need to think about that case.
> Just say "Do not do that".

At least we need to make user aware about risk of setting custom flags.

-- 
 Kirill A. Shutemov
