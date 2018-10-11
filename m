Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED0CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589BD2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC57ybGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589BD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJLDFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:05:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37545 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJLDFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:05:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id u6-v6so1969219plz.4;
        Thu, 11 Oct 2018 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l7ToRFdrb/9GJxkM06I5rmAqxSUBEYH5cNDOc++YDOE=;
        b=EC57ybGIrJ+5LGOQ35hCRP93FZ1hNP3hx1IF9Z1WX6pDCJX06YAsXxpy2dVIuubivs
         22SGx+2kCFuO3Yv4KVnXtjBkRDojZ8FHWRO7P1xVazWwidzes7Ujta0prApO1e9xEDze
         Tj0FYc93TltLEKP8cJHia+sabVIMlSXRZdhJpYjTqEXI3w5jyQaEZBO2X7AcPZuseF7U
         wojSpjG2OC+iid8aAXyPrMD9J3HBJ3QV/kkT2wIcX93S9Q7pHgzYCchDTDq56oZB7NIU
         YAobeHwYaZj3DCR1LI0L7DeaJGMYw4lwhbeVp6d9J3u294/B0RWBeYb6rt/HMhW00YyM
         1XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7ToRFdrb/9GJxkM06I5rmAqxSUBEYH5cNDOc++YDOE=;
        b=A7AJghd3hk8VFmp/TuRXFUj4m2dbHHjNyhjdZsb67bYsgGqTlhCXm1+RxoEoiR4ZKR
         foow4YmJ9K2AIGvM5+EfFcruUuearM+gHX/pgYQuEDJQvohvAqEuDvSFveu77I49qpAw
         V5+xXubJ87seXv/iKiQGrhQOCIrrDu4atYRvvhv1do2bnnv+xvJ5veU2DFjaebHdXvJS
         LGgClzuOb9lZLixBuhkcYXn23NDi3Kuo0narDiyfSiahV0K+h8uHfZHKY7dFlc42TuOO
         S/Vn2IuCCm8p9d2p63PJt7/KZmIxS96iXJgOzOJq9SDbKhmwuigOXYT2Wkio8u2BwAti
         ES7w==
X-Gm-Message-State: ABuFfoiEdgFPqhw8UxXs9+MLhG9zf3QvQG8JiTjUayKdAacGphdXi0fI
        u5YGEkeBLGuMokX7jIheAZ4=
X-Google-Smtp-Source: ACcGV62WWUzLN/iYc3zCyYWvG5TMzFIVBaUuySSEPL+XsvsXKnbbsMZAWkNkNK8i6SAGBH85lt+usA==
X-Received: by 2002:a17:902:7007:: with SMTP id y7-v6mr2783429plk.185.1539286623472;
        Thu, 11 Oct 2018 12:37:03 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id p4-v6sm30172893pfg.188.2018.10.11.12.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 12:37:03 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:36:59 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Add operating mode support
Message-ID: <20181011193658.GA3828@Asurada-Nvidia.nvidia.com>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-3-nicoleotsuka@gmail.com>
 <32c22986-544e-aca1-12bf-9080667cf499@roeck-us.net>
 <20181010230906.GB1706@Asurada-Nvidia.nvidia.com>
 <20181010234300.GA25480@roeck-us.net>
 <20181011002411.GA10379@Asurada-Nvidia.nvidia.com>
 <20181011193152.GA4854@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011193152.GA4854@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 12:31:52PM -0700, Guenter Roeck wrote:

> > One more question here, and this might sound a bit abuse of using
> > the existing hwmon ABI: would it sound plausible to you that the
> > driver powers down the chip when all three channels get disabled
> > via in[123]_enable nodes? :)
> > 
> 
> I would not call that an abuse, no.

Hmm..do you mean that you aren't in favor of powering down the chip
after all channels get disabled?

I was thinking about having pm_runtime_get_sync()/put() for channel
enabling/disabling routine of in[123]_enable.

Thanks
Nicolin
