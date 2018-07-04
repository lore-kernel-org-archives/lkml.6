Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B2C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E15A2466F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E15A2466F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeGDDKk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:10:40 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35259 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932396AbeGDDKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:10:38 -0400
Received: by mail-pg0-f44.google.com with SMTP id e6-v6so701852pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 20:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4FdpAysbBu9MBsmb7ESPJyIqjpk1t0QeuPO7ywLOr7U=;
        b=FX1ev8QA0a1fzkc6aFVrCYQxVpvJ5sBmgW1U6XsXSsTYh6HXKN08C70V1PsqqjFpZL
         bMlnxFjkqdHGC9VD0ZKi82335lkfanOjPucfwYkSOa4NiDZ+Zdqx/yrq2/x2S88HFt4s
         xEhCuPeBxlHTM9Mvaf9XYDW0Rxa+XWfj5xWV9UY4mcrdfspxVfPWq+tbsDuUcaT6tyAl
         9UYinLPqMpUWNMzwLIp7cRmIEKdbcixzLz15HUgF/bDQEWl0pcbza+n0868KaNbTJkQ2
         7OXN2RlAoAtBXoHiiArH7KIddrFl+JgghZYNgG7FNdwG6nXNOuHFujhSADSzqpNCBZ1L
         3Tag==
X-Gm-Message-State: APt69E2NeuozUG8Wz8zWN4H/CvnVePyaIM2JD0vtSZ17wyhbLjE075h+
        1fPDRz8vlHWAzWN/FRyXo5BYCg==
X-Google-Smtp-Source: AAOMgpfWxgfp6I9v18TvFkCs3083LP1Y9cWKStloeFwfpXTy38RuHy96vWr75kAiX1lvCVIfOvBgTw==
X-Received: by 2002:a63:5143:: with SMTP id r3-v6mr279403pgl.11.1530673838194;
        Tue, 03 Jul 2018 20:10:38 -0700 (PDT)
Received: from trogon.sfo.coreos.systems ([2604:2000:80c5:4400:140c:73de:b623:c90])
        by smtp.gmail.com with ESMTPSA id z10-v6sm3770368pfh.83.2018.07.03.20.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 20:10:37 -0700 (PDT)
Date:   Tue, 3 Jul 2018 23:10:27 -0400
From:   Benjamin Gilbert <bgilbert@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Gabriel C <nix.or.die@gmail.com>, linux-x86_64@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180704031027.GA24835@trogon.sfo.coreos.systems>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 05:21:50PM +0300, Kirill A. Shutemov wrote:
> I don't know how to solve it. As far as I know we don't support compiling
> kernel with LTO in mainline.
> 
> Any suggestions?
> 
> Benjamin, do you change LDFLAGS or CFLAGS when compiling the kernel?

We're using the standard build flags as far as I can tell.  In particular,
we don't enable LTO, and I've verified that -flto isn't in the build logs.

Here's a sample image:

https://users.developer.core-os.net/bgilbert/4.17/vmlinuz-4.17.3-coreos
https://users.developer.core-os.net/bgilbert/4.17/vmlinux-4.17.3-coreos
https://users.developer.core-os.net/bgilbert/4.17/System.map

--Benjamin Gilbert
