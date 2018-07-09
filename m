Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BAAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3031120882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Yc7dcXcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3031120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932571AbeGIKKQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:10:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35429 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754317AbeGIKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:10:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so12237682pff.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+unqR7OsmIMax24BqhQjWNvKeIdRqRg5/8E3S26mNLg=;
        b=Yc7dcXcFn3SyqT2wYEMO5VqJnXLtFydQglZwSuTuf6eyEoFpYPOZ65/J5mApcU2IHc
         7E+lI7ta+h1OQcu4oBSlC7KRJRgaJFIg2syI23PDdH7RtkxRSSyt5/fGcq/Lg6mHt+ui
         dmKy/9XRW3hw9c+N2bBm4VyZ/mXEzjavw8P61cLhPo38jPwlZASeG6lqQFYqtEe7PE9B
         hiUHailnwukTBDoLZMsNH8muEysMMarLklUAzKdp/vbetzm4agFDLCgDNI84rVBwwtES
         qEdKDODZsurI9GCirVJ2s2BXkLe9x4yzUYQ7H3/O9DJFRSxEJQ3Vq8N9hwffAOZkXSPq
         WYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+unqR7OsmIMax24BqhQjWNvKeIdRqRg5/8E3S26mNLg=;
        b=Iffkvoyb7CLDwt52XswtvLRQ/eMShR/Gcywbi8W9FqjM2kNkPIuPRh0EZ1ZMEMbAID
         h0TujOVB99/HIgxOl0HDXuSxG1vRmXaOb6W8aG6bFgBejGw/0EIyDmB50rhr70W0p3Ia
         zIuuHE5sz3SOjtdWeL2uJnp7IiB4g//RVbGLa5c0+bylsB8owNb6hDcYiECAcCAPKjIr
         sfxZvC2GcQtmkYINvo2oUzrNqQ9QGSBLx+Vb4zQtry+leZeRlOeApIrEzo/BQ9pst8+N
         TsX+ytffR/j25fnfL3nh9b1OqlltWu1oTWufJZJzjhisvHeNkezu9qZALMbfelT1XG4S
         OSJA==
X-Gm-Message-State: APt69E0glYpC5U5O7sVofjDunklbZ1T6O3MFOL+eZDlVAwV9aq50T4KF
        XPVA7EzkvAequDm3+1Vm3tVKqw==
X-Google-Smtp-Source: AAOMgpdEhFkJ7U1om7u5RhJ5cDxGEnUDq9RPppu05lEFLwGgyvnYqROt+21eLwzyFkRPGgQM5ttmpA==
X-Received: by 2002:aa7:8645:: with SMTP id a5-v6mr20486104pfo.247.1531131011591;
        Mon, 09 Jul 2018 03:10:11 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id a25-v6sm22032361pgv.51.2018.07.09.03.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 03:10:10 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8CA6630003D; Mon,  9 Jul 2018 13:10:05 +0300 (+03)
Date:   Mon, 9 Jul 2018 13:10:05 +0300
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
Message-ID: <20180709101005.43yp6b2g3b4dgg37@kshutemo-mobl1>
References: <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
 <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1>
 <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
 <20180706162928.73jfqtdwdcwtagui@kshutemo-mobl1>
 <CAK7LNAQKT8QnoOaoR4LckaAYpBws5MwBTRYMMQFpmxUCmuMWbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQKT8QnoOaoR4LckaAYpBws5MwBTRYMMQFpmxUCmuMWbg@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 10:21:47AM +0900, Masahiro Yamada wrote:
> 2018-07-07 1:29 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
> > On Fri, Jul 06, 2018 at 11:13:02PM +0900, Masahiro Yamada wrote:
> >> >> LDFLAGS is for internal-use.
> >> >> Please do not override it from the command line.
> >> >
> >> > Can we generate a build error if a user try to override LDFLAGS, CFLAGS or
> >> > other critical internal-use-only variables?
> >>
> >> Yes, Make can check where variables came from.
> >
> > I think we should do this.
> >
> >> >> make LDFLAGS_KERNEL=...  LDFLAGS_MODULE=...
> >> >> will allow you to append linker flags.
> >> >
> >> > Okay. It makes me wounder if we should taint kernel in such cases?
> >> > Custom compiler/linker flags are risky and can lead to weird bugs.
> >>
> >> OK.
> >> So, what problem are we discussing?
> >
> > Users set custom LDFLAGS/CFLAGS and break kernel. Then report bug that
> > hard to debug. See
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=200385
> 
> 
> CFLAGS is only used under tools/.
> Passing CFLAGS is probably no effect to the kernel.
> 
> In Linux makefiles,
> KBUILD_ prefixed variables are used internally.
> 
> KBUILD_CFLAGS, KBUILD_CPPFLAGS, KBUILD_AFLAGS, etc.
> 
> 
> LDFLAGS is an exception.  I do not know why.
> Renaming LDFLAGS to KBUILD_LDFLAGS
> will make the code consistent.
> 
> At least, it will avoid overriding flags by accident.
> 
> Of course, users still can change KBUILD_LDFLAGS
> if they really want.
> 
> The build system could add belt and braces checks for that,
> but it is arguable since
> there are lots of lots of internal variables.

I think renaming LDFLAGS to KBUILD_LDFLAGS is good idea.
Would you prepare patch?

-- 
 Kirill A. Shutemov
