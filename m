Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6ECC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292E520856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4g5X+Ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292E520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbeGYC3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:29:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42776 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388420AbeGYC3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:29:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so5714048edp.9;
        Tue, 24 Jul 2018 18:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dkMIfzMFxDG7ymfXEy9AaeD536y4PEikiOZOFf+8W0=;
        b=Y4g5X+TyfX/KwzWF1WyJZFF9WCBwBW1xa15QaArEXE4QcN7NLzg2efM6HWHbWYm0Me
         hzUPQciXvGwGL3SJIdgqpHhoa903P+84vw//7nE2NZgJxJQtvsl+Oo9qIg6Z5DizTs44
         JXfIo3DbAZaBVvZTNJ5IJeRZRbUdpr9b/3GO9Tc9EQ9eNFCX7Hv7rhwZxGi4hzC2Edsg
         VqIot9S/dgwzTCS13VY0hENzqccGyNJm/ziCzbZGPLow1/T3iZs6x84LcNJW3ub0cOau
         NG27ZY35ILpXkJH8EG2dXCxJspTgVjGu6fC7rfKg9Gce7tnnv2aZt0Ctq6yYGEWXCXrA
         hkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dkMIfzMFxDG7ymfXEy9AaeD536y4PEikiOZOFf+8W0=;
        b=FUymgCoAtlIKJVP0Y6U8YSiSvGPtGmQA+k3uwgZzaWEoSrGT0tz4OT6UYlOUjaasfp
         QgytJKoYjzzOeB/MQqDHRNXpFAX/xQQo2H18mLj9vlotdYsjGoKXXOytSkGHdoLd9M8q
         kEiWnK2+ARnwUvTiyzclyncMI+9cpxbBzesGFYn8xOzS4LEl9raZ7sUeuCWbZPaYvfLk
         Aw8iWRipF5CB/6z18ANJnx8VI6L5xYgO/RgyV27JyI9QD7ZOTFS6KpSRShRMkQRWo0nv
         ltbL9x/4PdwHKvVdd31ZFvPLSEOyrBWfybXi/SBl5dSTq7ujNpqeViQcwaW7L1hoW4c6
         NJcg==
X-Gm-Message-State: AOUpUlGOr/X9/bpual/P1qTkFYpDXRkNYsZRH5MCMlpijl27LdABdQ+b
        jrbLCv0p77IvUK2NyYOYKZd08fkb
X-Google-Smtp-Source: AAOMgpdgaAwn+ievUuOej/DrDa42z7ZT5UZB3bRvf45bWjszBvU9T9pvVbY6SNezrLrcix08/rAfGA==
X-Received: by 2002:a50:8cd1:: with SMTP id r17-v6mr21046882edr.113.1532481631773;
        Tue, 24 Jul 2018 18:20:31 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id i63-v6sm5874287edi.16.2018.07.24.18.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 18:20:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] media: staging: tegra-vde: Replace debug messages with trace points
Date:   Wed, 25 Jul 2018 04:20:29 +0300
Message-ID: <1779889.gZoAajBteF@dimapc>
In-Reply-To: <20180724213733.6c8b6b4b@coco.lan>
References: <20180707162049.20407-1-digetx@gmail.com> <3929419.8vW2TRoUPb@dimapc> <20180724213733.6c8b6b4b@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25 July 2018 03:37:33 MSK Mauro Carvalho Chehab wrote:
> Em Wed, 25 Jul 2018 01:38:37 +0300
> 
> Dmitry Osipenko <digetx@gmail.com> escreveu:
> > On Wednesday, 25 July 2018 01:06:52 MSK Mauro Carvalho Chehab wrote:
> > > Em Sat,  7 Jul 2018 19:20:49 +0300
> > > 
> > > Dmitry Osipenko <digetx@gmail.com> escreveu:
> > > > Trace points are much more efficient than debug messages for extensive
> > > > tracing and could be conveniently enabled / disabled dynamically,
> > > > hence
> > > > let's replace debug messages with the trace points.
> > > 
> > > This patch require some work:
> > > 
> > > $ make ARCH=i386  CF=-D__CHECK_ENDIAN__ CONFIG_DEBUG_SECTION_MISMATCH=y
> > > C=1
> > > W=1 CHECK='compile_checks' M=drivers/staging/media
> > > 
> > > ./include/linux/slab.h:631:13: error: undefined identifier
> > > '__builtin_mul_overflow' ./include/linux/slab.h:631:13: warning: call
> > > with
> > > no type!
> > > fixdep: error opening file: drivers/staging/media/tegra-vde/trace.h: No
> > > such file or directory
> > > 
> >   CHECK   drivers/staging/media/tegra-vde/tegra-vde.c
> > 
> > /bin/sh: compile_checks: command not found
> > 
> > Upstream kernel doesn't have "compile_checks" script and I can't find it
> > anywhere else.
> 
> This is just a call for smatch/sparse:
> 
> #!/bin/bash
> /devel/smatch/smatch -p=kernel $@
> # This is too pedantic and produce lots of false-positives
> #/devel/smatch/smatch --two-passes -- -p=kernel $@
> /devel/sparse/sparse $@
> 
> However, the problem here is that you're doing a 64 bits division.
> That causes compilation to break with 32 bits. you need to use
> do_div & friends.

The tegra-vde driver code is fine, it is a known issue with the kernels 
checker [0]. Unfortunately the patch for the checker haven't been applied yet.

[0] https://www.spinics.net/lists/kernel/msg2824058.html


