Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF7BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1E02425F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Y/Ec6jr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1E02425F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753434AbeGCMoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:44:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40628 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbeGCMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:44:10 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so996208plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JDBMbZALN/I/SorKSYVW3eUwxgEkE72BD97VJFUm5VU=;
        b=Y/Ec6jr1EKGaWPKtaIdKZO1IS1+76lm7/gYhliZre/dwGq82txdfXZOkJU9QHkp/AR
         37nFIkA8zyJ8G1S1LJ/BnjKsHFuzCkXzji8lXN6DNWr+rIyUS/4+SXeNijyXI92IWEQ0
         w0/doKcBP6Jg22EykhScLEzKgZcOPX9qKrHMFiJKUAwR7scDL56czD7BLFqez+IHsCD7
         GUeIHRqF0YYkh3CcjNhFTGFRumMZbEw6ydlyzrcejf34R+fQeonB7HkPhRK5emGOHNuM
         SD53FQKl//tuA1wcChLxrSY7bfrZLTZBFDmfszPOBXy254Q8vpvtvSDEQ1xz84kOSXyi
         jpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JDBMbZALN/I/SorKSYVW3eUwxgEkE72BD97VJFUm5VU=;
        b=sGiuFOUQ8CFdaYcPBwgDq7o7kWwnOf2ftA30WrGHePlen1K/1FnRFOOcBzRok8e2eZ
         xRYrP2wfmSo6T34Qec6UIaFs4z4Fm6Z6dUqSS6nPa2OKdbYQyivOxYi1+yOt8y3yh6jj
         ZsSp8Xs8Jo2W8hY5LBw1MULSCNZSbG+oCRrSybBodl3P7YWNE02Z65kRphofxNP2JOtP
         w2bXc9XQlq6V93/UlO9d2OdQNm6XqnUDz5hUsluyL1rQkMCUPbf54HCth2A4spPZBCcI
         GByuc2tnYEcOc9OkmVKF0sxmB6bwyCUmpl7j88Y5npxGlyA7YYD9KtvzmXdBCl0nTMZe
         IQ7w==
X-Gm-Message-State: APt69E1UHbp4M/L0cagTA1Hczgqe8rRp3iEGVCfHQQRGXGmwBV9/HI8/
        3NA3Qw35QofD94KGIw5xH2lb4A==
X-Google-Smtp-Source: AAOMgpdfQuI/MZcwgwDALSSCezG6fFCQMisMd33TwvLd3n8/Nw6SH0PKLX2THp0tL4NHezYixuaF7w==
X-Received: by 2002:a17:902:7106:: with SMTP id a6-v6mr13117261pll.28.1530621848592;
        Tue, 03 Jul 2018 05:44:08 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id b62-v6sm2843781pfj.123.2018.07.03.05.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 05:44:07 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id F143530003D; Tue,  3 Jul 2018 15:44:03 +0300 (+03)
Date:   Tue, 3 Jul 2018 15:44:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
> 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
> >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
> >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
> >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
> >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
> >> config for reference, and am happy to test patches, provide sample QCOW
> >> images, etc.
> >
> 
> Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> 
> 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> too with the same symptoms

I tracked it down to -flto in LDFLAGS. I'll look more into this.

-- 
 Kirill A. Shutemov
