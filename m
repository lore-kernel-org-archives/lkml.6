Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C52086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Meo8wotY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3C52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeGDNWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:22:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37446 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeGDNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:21:58 -0400
Received: by mail-pf0-f194.google.com with SMTP id h20-v6so2632004pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eQg1r1nlBTr1cbMu+2HoXY9Y5POBG5inMvVZVHTiprc=;
        b=Meo8wotYbqPT9+8hE8V9DTnfjklmNYu5ML/s22coCS7e/40JA+U+VGK2Q6OLwUeUPV
         4Glepe3BLTzp2zDyBkCJg4C5l5BIEN1NTyDx8mxP+odQZAKQeOIFd0v21+09flSsR7uh
         xcZYubsreCu27jblAcyagHAeERGcz6iQkKjo0CZ6nN/w3MCnnv6IDPc82VA1e+ENL+GZ
         QySC0F9qBrmOmKoh1Bs3KknFVxEZu/7b4UdiN+tFJ7UFjKi8f8rkE7qs0VMXjfzQ5JpG
         VCmW/Rq0f9GHrrboKHUBH+M1UpTAeMxu5wnEIPMcxGvEGkJ3fhbRU9q8K88zsp9ESXKB
         5m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eQg1r1nlBTr1cbMu+2HoXY9Y5POBG5inMvVZVHTiprc=;
        b=nNwMGh9zOEM4tqTe+0JjFlwhzXkcV5zCiwGXuvItIDEvXiluGZ0WoVdY/mRFl7vt1E
         UW0jKWN41YSFPmjm9gRZokH6UnwZr6NVb82Rm9sfGCZtF/+J+fsnyQlKvfDoSfTT6Y4R
         Tr+qU+cCLwK0EJPnnDFFj7l7TNuhhpOkfyL9eRZ8L9qcMdAgVNpJ5nTOgangYbNpmhX3
         1YeWhM6d7Agl4LPi6fqMjVVO5Yuh8UdD86KkvsZNXK8+ZKFjRg1jiKAdXEs7Vsgf8jii
         YxB61hcSjxs5YuLy/CkyGD0M4rZrEJtTF93qSduwlpLsTLu52eRrNA6u9bHY9FdDE1UZ
         XNMg==
X-Gm-Message-State: APt69E0qKoySfbjQgeLTRXxZf+s7vqDrURc3Mt7OkB2BhIVn98S4beN3
        iZaOySH1Vat6rXne+xpc6DI/JQ==
X-Google-Smtp-Source: AAOMgpcBwhiDc3cqFNd3eeMrPuCdVFLaRgw5SzKXaAlVUbKmU+MbST4pXMl01oH9AimugFSv6Ok9ZQ==
X-Received: by 2002:a63:f948:: with SMTP id q8-v6mr1890624pgk.292.1530710518272;
        Wed, 04 Jul 2018 06:21:58 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id j23-v6sm6702886pfh.45.2018.07.04.06.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 06:21:57 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5DE8730003D; Wed,  4 Jul 2018 16:21:53 +0300 (+03)
Date:   Wed, 4 Jul 2018 16:21:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Benjamin Gilbert <bgilbert@redhat.com>
Cc:     Gabriel C <nix.or.die@gmail.com>, linux-x86_64@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180704132153.nfqun2t2tfvcc3gz@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704031027.GA24835@trogon.sfo.coreos.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704031027.GA24835@trogon.sfo.coreos.systems>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:10:27PM -0400, Benjamin Gilbert wrote:
> On Tue, Jul 03, 2018 at 05:21:50PM +0300, Kirill A. Shutemov wrote:
> > I don't know how to solve it. As far as I know we don't support compiling
> > kernel with LTO in mainline.
> > 
> > Any suggestions?
> > 
> > Benjamin, do you change LDFLAGS or CFLAGS when compiling the kernel?
> 
> We're using the standard build flags as far as I can tell.  In particular,
> we don't enable LTO, and I've verified that -flto isn't in the build logs.
> 
> Here's a sample image:
> 
> https://users.developer.core-os.net/bgilbert/4.17/vmlinuz-4.17.3-coreos
> https://users.developer.core-os.net/bgilbert/4.17/vmlinux-4.17.3-coreos
> https://users.developer.core-os.net/bgilbert/4.17/System.map

It's basically the same issue. We have immidiate load instead of
RIP-relative address load.

You can make the vmlinuz bootable with this binary patch:

echo -en "\x8d\x05\xa9\xa9\xff\xff" | dd of=vmlinuz-4.17.3-coreos seek=$((0x005d1fc1)) bs=1 conv=notrunc

Now we need to find out how linker gets it wrong.

Please, *after* complete build of the kernel with your toolchain do this:

touch arch/x86/boot/compressed/pgtable_64.c
make V=1

And share your build log.

-- 
 Kirill A. Shutemov
