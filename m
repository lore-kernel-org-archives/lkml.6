Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D47C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7075F24897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="lRZXh2r+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7075F24897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeGCU0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:26:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43818 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752976AbeGCU0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:26:15 -0400
Received: by mail-pg0-f68.google.com with SMTP id v13-v6so1459506pgr.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HKJ+A2gEnnEEKmjjIjn3Ppw2FxcDHrIxFvt1ORGMcRQ=;
        b=lRZXh2r+S8WOb55Wm1YSojw7lySmsZBaDGO1Sy9LU7fqq72/D2Tc7ZoFUMnVLJZqu8
         qDY4F6W2NVApsMiZ7fNFGiUe56P6xWGiKB0vpnQb8Ozvwev42eo/nKDRXUfOw3TYEH1b
         nXMqXreFiMMDTEiSPe2jRoyqIv1LKKGeNab8ZDdd7QhVaRSd6Okaj3gbt3nP9m79c3Ca
         W3T/tfIiN875WrQZFde7WP9pveIG8+AcjfZ5hr3lK6U94NbXGqN0WhS30ScWA/UKhaH+
         Kv+Wv+R4v3nNK5mdG1R306raXzykCzy6nAE51desk3k1R8ZDqP9b0MJlr2pJ9XPCciB7
         LDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKJ+A2gEnnEEKmjjIjn3Ppw2FxcDHrIxFvt1ORGMcRQ=;
        b=F6d+rMMTX1CTNbDy+hwtMg/VZsZzZe83enWt+LBxso7rvp8EmTmqDvVTgiztgWrZ6H
         UHE88TFM2Cor7I6kuDnjljSn8je81xL7cFRcGofgGF6OZDqKIQEF+/nkkIcDl5ROkmSh
         tmHmp5R4clTm36WnhQxP1oe2G+Z3nmJHkirgXq0jugjS1AgFfo3qkgkLvNVA+GobWLGr
         ECkqoQ1tBk6MH7cz79gJyHOdoAzetIBg8N3eIbZQeOabtIVz/sp79H5z5s6zxo+jcm8E
         01hhHmnoeLinzsRKcd8qpqWSJX0kjmllZBO1JYG3+gXDUMbZOalBS9afpW64dkpwbj0b
         Esnw==
X-Gm-Message-State: APt69E0hu5Fg7oQiexG98MBsTEipEtV3m+pWTd+Oj9rCJMIXR/hHgHpy
        YASHsZq2LweogXAsClsTHSi+7A==
X-Google-Smtp-Source: ADUXVKJ/xycjS497eIsVJGjvFV5yjIR99vwcnNjnW1BfwqUoEw/dTtKb2bLIQ4AA5Ws22nVndnqhhQ==
X-Received: by 2002:a63:735d:: with SMTP id d29-v6mr27080548pgn.156.1530649575282;
        Tue, 03 Jul 2018 13:26:15 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id g75-v6sm4366700pfg.145.2018.07.03.13.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 13:26:14 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 461EE30003D; Tue,  3 Jul 2018 23:26:09 +0300 (+03)
Date:   Tue, 3 Jul 2018 23:26:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Gabriel C <nix.or.die@gmail.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180703202609.k2zxwduhvlynfsbw@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180703180307.GF17013@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703180307.GF17013@tassilo.jf.intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:03:07AM -0700, Andi Kleen wrote:
> On Tue, Jul 03, 2018 at 05:21:50PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Jul 03, 2018 at 03:44:03PM +0300, Kirill A. Shutemov wrote:
> > > On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
> > > > 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> > > > > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > > > >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
> > > > >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
> > > > >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
> > > > >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
> > > > >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
> > > > >> config for reference, and am happy to test patches, provide sample QCOW
> > > > >> images, etc.
> > > > >
> > > > 
> > > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> > > > 
> > > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> > > > too with the same symptoms
> > > 
> > > I tracked it down to -flto in LDFLAGS. I'll look more into this.
> > 
> > -flto in LDFLAGS screws up this part of paging_prepare():
> 
> Where is that coming from? The LTO patches are not upstream.
> 
> And I don't see any LTO usage in the main line.

Apparently some distros try to hack it around:

https://bugzilla.kernel.org/show_bug.cgi?id=200385

I'm amazed that it kinda worked for them.


> > 	/* Copy trampoline code in place */
> > 	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
> > 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
> 
> 
> > In particular, relocation for trampoline_32bit_src solved in the wrong
> > way. Without -flto, we have rip-realtive address load:
> > 
> >   982d30:	48 8d 35 09 cc ff ff 	lea    -0x33f7(%rip),%rsi        # 97f940 <trampoline_32bit_src>
> > 
> > With -flto we have immediate load:
> > 
> >   982cf0:	48 c7 c6 f0 f8 97 00 	mov    $0x97f8f0,%rsi
> 
> Strange.
> 
> Can you add some RELOC_HIDE()s and see if that helps?

Nope. No difference in generated code.

-- 
 Kirill A. Shutemov
