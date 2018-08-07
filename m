Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D1DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141B521A03
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSgh2gFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141B521A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbeHGJ4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:56:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33718 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeHGJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:56:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id u14-v6so10956952lfu.0;
        Tue, 07 Aug 2018 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omdZqfutPZ16RnM0rLKihE/eIq/+PgGpIY13c/+Cwk0=;
        b=vSgh2gFDPArWChSoSZFDPbnsGRgAxoMtmSRNX67AYgfEzX//BlY2jR3ka3jhD0pbc9
         Ovr/A8Y5yZJQAmsLjFQYL9yAOygh/PQGcVyEKZSVxNzd9EPJ8bp2G8Wdp3uRhMGIdhqz
         Xn2bWB+jCyP51l9BmiFxDC4dcP3kCsS0KesJlGD+AnKSAZ8taLENYXU8bbiAU4ObBumC
         twbvoNoVXQGC3XjdFMhCl9/IlMVdsAF5AIGVyeKasxCitfN7WL/8HR4KgwdhsC9bcx0f
         0BGBEo0vlDzSyYH0jBJbeebQehooqIAEgdmWfEd7QV2ZyIGyd/WocSbI0b6IQqywoMMe
         TiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omdZqfutPZ16RnM0rLKihE/eIq/+PgGpIY13c/+Cwk0=;
        b=rS3ouzFX6/Y/+gJoVNgT6XsCd9n35PhFbS6AWynhhPyo7I7ivVmHIzKHLqAJPJ2nhh
         IsnVEnfvmRl27OL0ifg6Jg82ytseMLuxCYNTNXWw/irUAq5CSemGrueDIxCbBO6i+Ms2
         gma2ypKSVT+2RPT5cWZb9cd2tmrEc2bJMfW3K6B5e6VnxTyryB/g0YgOOO1fvlk3BgLs
         8V5X/FgEjnsLPKQHrnlCwBp1IYJ0I8uuL0SdpGej2hUF0vLCO00boWQLqP+r7uc81ZOq
         t6wGJxMhsiGuDQwYrWmQdCvnPf43HgIqBFjrSVdPz2Z7Uwf+eM7XAFZ8xez2gr5ppIjJ
         NalQ==
X-Gm-Message-State: AOUpUlGALCoVHbvfSf87lSQLnEIB/CMIFnknFYKbrBfamafbCUSrFMsI
        Zme4GpgXHh5AdZavTfGAnhzjVN86QORdWv2yggY=
X-Google-Smtp-Source: AAOMgpeVP3u3IARnoNGQjZVwwI72/UKJW3CK2QFmiPEzm5xmr7tgLWVCKH+ojdcc1SS2TImhw0bKKnr6WNjPnXosqyM=
X-Received: by 2002:a19:a685:: with SMTP id p127-v6mr14215255lfe.4.1533627783738;
 Tue, 07 Aug 2018 00:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180718202235.GA4132@amd> <20180718235851.GA22170@sandybridge-desktop>
 <20180719110149.GA4679@amd> <20180719132003.GA30981@sandybridge-desktop>
 <20180720102532.GA20284@amd> <1532346156.3057.11.camel@suse.com>
 <20180723162302.GA4503@sandybridge-desktop> <1532590246.7411.3.camel@suse.com>
 <20180806075754.GA12124@chenyu-desktop> <1533550820.15815.14.camel@suse.com> <20180807073840.GA17894@chenyu-desktop>
In-Reply-To: <20180807073840.GA17894@chenyu-desktop>
From:   Ryan Chen <yu.chen.surf@gmail.com>
Date:   Tue, 7 Aug 2018 15:49:06 +0800
Message-ID: <CADjb_WTrJ_yjsNk79XYJyA5VB3dwK5cUadCumYRkzogOzm_nPA@mail.gmail.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation encryption
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     oneukum@suse.com, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>, jlee@suse.com,
        "Theodore Ts'o" <tytso@mit.edu>, smueller@chronox.de,
        denkenz@gmail.com, Linux PM list <linux-pm@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kookoo.gu@intel.com, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 3:33 PM Yu Chen <yu.c.chen@intel.com> wrote:
>
> On Mon, Aug 06, 2018 at 12:20:20PM +0200, Oliver Neukum wrote:
> > On Mo, 2018-08-06 at 15:57 +0800, Yu Chen wrote:
> > > Hi Oliver,
> > > On Thu, Jul 26, 2018 at 09:30:46AM +0200, Oliver Neukum wrote:
> > > > On Di, 2018-07-24 at 00:23 +0800, Yu Chen wrote:
> > > > >
> > > > > Good point, we once tried to generate key in kernel, but people
> > > > > suggest to generate key in userspace and provide it to the
> > > > > kernel, which is what ecryptfs do currently, so it seems this
> > > > > should also be safe for encryption in kernel.
> > > > > https://www.spinics.net/lists/linux-crypto/msg33145.html
> > > > > Thus Chun-Yi's signature can use EFI key and both the key from
> > > > > user space.
> > > >
> > > > Hi,
> > > >
> > > > ecryptfs can trust user space. It is supposed to keep data
> > > > safe while the system is inoperative.
> > >
> > > Humm, I did not quite get the point here, let's take fscrypt
> >
> > While the system is running and the fs is mounted, your data
> > is as secure as root access to your machine, right? You encrypt
> > a disk primarily so data cannot be recovered (and altered) while
> > the system is not running.
> >
> > Secure Boot does not trust root fully. There is a cryptographic
> > chain of trust and user space is not part of it.
> >
> Okay, I see. So if we want to use secure boot mechanism for
> hibernation encryption, user space is trusted.
s/ is trusted/is not trusted/
