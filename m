Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B190DC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647DF2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkZ+Nc3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647DF2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbeIVUvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:51:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38054 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbeIVUu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 16:50:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so7232459plq.5;
        Sat, 22 Sep 2018 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tZBnKO0lue3B9UGX2EJYflYY8VaEuWEi9BK26TWvboI=;
        b=RkZ+Nc3sABpM1CeTDagVFdv6hee3X3RYOIH8B7adbE2zC9npCWH8oqS8a8+VRMNEp9
         yQ70iHWDpgnhgm6fvatosmZfZlJOCbJk1p7qxwRmIrsTJp++uajIJDt9v9eqo1lnaKnT
         UvUwYgJHotfNF5B2iMoX7U7c+djOuccZFNAR+Q0JgZwpfPxlgs3U2HacjWFP0WupnMUF
         4TfA/h2ywrcO50cJg7wEsGormd5WH0T3+6gADqJxEIFjOGJdfrVm19g5awwpCptnLAVr
         s+lk8JhL9rqBQd4hO1koqTOx6RRu9d5CHxr5z8w/gVyX1r9Oqj5ajS+OE7ILVfHcX9np
         ujMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tZBnKO0lue3B9UGX2EJYflYY8VaEuWEi9BK26TWvboI=;
        b=isix7BpwqK87NkDuOuGOr055rOjLJmfh5ZF1WJv8BaWBPYw9gkREjmlyN2JdrNpIdD
         82ynRCFv1lyO2VxXPzKG9jgw283tTivrLw4U8y2qcOLoalf8k62fXQyNCEE0g31SPSqF
         C4cpo6Cp9jwBToCzrgobYqR60GI3/+6M8SGpJPPjeWTjqA2g25w9CFFoix0IwWKgR69a
         MtN4k2XyzKx2D8sE/c8CrKZdeHQJ1rU2Cr4M8ewFfsvCHry2x/83ciL8HNQwTs950AW4
         mpUBWXx5djSJaUlvORfNHRFYvmHlvcf0x0T4eBEznDR/2XwuoDUgNjNfZ6rXCVjUQg7J
         GgGQ==
X-Gm-Message-State: ABuFfojHak1Q0KrH6ZoFHOrjw8R/+IhZaPxlULhh1kEuJgF4xibQ9FVL
        90X2qT4sk53Rll81CBrG3/s=
X-Google-Smtp-Source: ACcGV60X0l+GeUJUiLrMmxh4sm+LDG2UWe303ZlJWGi0vPvUUL8M/ql+/VxXVdDYljOiEg/m3CivOw==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60-v6mr2940216plc.11.1537628227995;
        Sat, 22 Sep 2018 07:57:07 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id p4-v6sm41100234pgs.75.2018.09.22.07.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 07:57:07 -0700 (PDT)
Date:   Sat, 22 Sep 2018 20:26:58 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Song Qiang <songqiang1304521@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, andriy.shevchenko@linux.intel.com,
        matt.ranostay@konsulko.com, tglx@linutronix.de, ak@it-klinger.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Message-ID: <20180922145658.GA4443@himanshu-Vostro-3559>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180922154658.752f2fbf@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922154658.752f2fbf@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 03:46:58PM +0100, Jonathan Cameron wrote:
> On Tue, 18 Sep 2018 16:24:21 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
> > This driver was originally written by ST in 2016 as a misc input device
> > driver, and hasn't been maintained for a long time. I grabbed some code
> > from it's API and reformed it into an iio proximity device driver.
> > This version of driver uses i2c bus to talk to the sensor and
> > polling for measuring completes, so no irq line is needed.
> > It can be tested with reading from
> > /sys/bus/iio/devices/iio:deviceX/in_distance_input
> > 
> > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> There are a few bits and bobs in here, but as they are all minor and
> one at least was me giving you wrong advise, I've fixed it up.
> 
> Please check I haven't made a mess of it! 
> 
> Applied with changes to the togreg branch of iio.git and pushed out
> as testing (where it should be visible now) for the autobuilders to
> play with it.

The SPDX license identifier is inconsistent!

> +// SPDX-License-Identifier: GPL-2.0+

> +MODULE_LICENSE("GPL v2");

216         For 'GNU General Public License (GPL) version 2 only' use:
217           SPDX-License-Identifier: GPL-2.0
218         For 'GNU General Public License (GPL) version 2 or any later version' use:
219           SPDX-License-Identifier: GPL-2.0+


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
