Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8DFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B737D20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bd+EtVfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B737D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeKLIH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:07:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40727 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeKLIH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:07:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id u130-v6so5692946oie.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRlUyHySzN9jx9Q+dq5DmAaps6Nq8TfbEccN/qrHhX8=;
        b=bd+EtVfWTTxoJUIy/R19ESkLdr9Eg5zJt4i0a3SVRPcYrFja53lXyljsPK+jgsVvTK
         pUTOs7mVUS/JX5t7bUpYDa9qyaFTBdXmOftYWplDWkVDBcy8BHJP0nUil3dvcrFKgzZL
         FpXWo64sslbSYHcHolScfoJAZdpQ2+ywDj9bYR3jB2IVSoWqf2yoEH6f38c/hnpGGwEj
         0oGQvaZ4A6LKgfLFsjHG8rrNotWW70f8Rb+KbIfQoCW5VRKMnKjctxv7jF2PB5piLkh+
         zbRh7y1d2AB4SqnrPlmgKUoVkrfkekmnfeX42CW8F1TWr/7ZUTndlHn/sf0X+k+rcVRA
         uqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRlUyHySzN9jx9Q+dq5DmAaps6Nq8TfbEccN/qrHhX8=;
        b=sxqP2Y+A5TMtmPIWrt+bos1kSraMgZwLvgHv94XcG2sRR/Cl21hfCCXclRsY+50S96
         q1FIZtkcvIN2YNmxbgSSZvIXif5/MfP6xFtAQGeH5UsK4LGDl20fFOgUCi8nkt1S/Qrw
         9sKcOrafZmL94HAom4YjJiwKcm3qLfvnGKopXn1un6IUDweWSQLN1KuFJgIfgYz5UwkM
         4e3iQcef4CRdDz5cuFXmc8wAzXy+RFWad8I8xAsbZtYtacvgSL3Xs5+nk887oiktRzZc
         etxEum3742vcgwGfh45Ta3aJEzkviPRfyHn4n/vkSpL3GN0LyffLxz1/VFKk2ULCYt/l
         i+Yw==
X-Gm-Message-State: AGRZ1gKzAxTjLdvt7HIMerzY7CwkOGsmgRD/5YYaLU8QQ+ieSU2k4hcR
        MV2xVY6wUaRwMX3EebsSVJ2YTEB3uOWI6f7VGXE1RQ==
X-Google-Smtp-Source: AJdET5ch0cj/0DLVesNIVSug9OC+eta1iDUJGTfr06T0E92i+KQlUr1QD+Nk322JbpsWQj6luC7x53CUqwkRyPoWkRk=
X-Received: by 2002:aca:745:: with SMTP id 66-v6mr9464872oih.280.1541974685179;
 Sun, 11 Nov 2018 14:18:05 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
 <20181111193208.GB8332@kroah.com> <CAPcyv4hofCTYMNN=Ow=o4RRuUPM=GLWajNAT9q6WWkuV47te_w@mail.gmail.com>
 <20181111203541.GB16871@kroah.com>
In-Reply-To: <20181111203541.GB16871@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 11 Nov 2018 14:17:53 -0800
Message-ID: <CAPcyv4hw0YS3XgdsDNL6MGqZs1bMhFxxQZC1UJT3gzpD4Ym7QA@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexander.h.duyck@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:35 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Nov 11, 2018 at 11:53:20AM -0800, Dan Williams wrote:
> > On Sun, Nov 11, 2018 at 11:32 AM Greg KH <gregkh@linuxfoundation.org> wrote:
[..]
> This would be a great time for some other people to do that review :)

Message received, I'll block some time.
