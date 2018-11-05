Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5067BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12100204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2l5LlHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12100204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbeKFFSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:18:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35064 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeKFFSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:18:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id v9-v6so2634245pff.2;
        Mon, 05 Nov 2018 11:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SnaBhYNavmPLLkKX9J6eGRiogIh+DRd/n3C8/erdFkA=;
        b=i2l5LlHPXvb1KWlr+5sj7Dhia75YlHReRF4wX2DDUBzCSUnPbEZahBG9s8shqJAW5L
         MxbZoc75ykypQ3Wue0+7mlTnVkgJco0nhUBjy1lrKK9hFpLo7tJ+lCe+t6YJi8jVA99v
         0vZLXsW4/x+2J3GIL9hjxcItXqU/b7bqDiHVmuHN5zkupWxTG8yxeQ/W7aRSLwK7pCVa
         sZdZYY0y07PQq4srCAxErDqwQJQjcFzewu1CtRN+HL0+ki5N791kCsWqYaC4YT8nf5ON
         gEFkk9ooCbpihVwT5ZL+xM1ZGf8inTZp67KCykEEOcMSUyjkKcHP8HVZoIFmrqRSSJ3d
         5yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SnaBhYNavmPLLkKX9J6eGRiogIh+DRd/n3C8/erdFkA=;
        b=kKMbTW+ZuDijEz+UblHsggBgCzodFg24WQp7rWNHYUFtlKsXiaiGorq3d8QnLQ/VBi
         775EJCu52+VZViY8U++05f94QLwPWWXWvIFVpylN1LakeXroSiEFuuqDFR5gHChS0SGx
         LWfuEpbhjPh3pQDMwFXBugGzVFQhB1FVW2ie2Rg8wKF0VOkKROlBydEzmGTJVzYI/WL2
         Lkb0ttQTJg1LaDzgdrMrA4BlU6C+fBe9OQHV56ZRGbnAWi3P01Hl/Z6QlxOEB/bVSbT+
         zRJ5AfVBHxgnvE5k3eYw68BsdTgk8AWuw38BSPUZ/bX/PnDr89Fa93lR0qqI9QyVHMRk
         Td8Q==
X-Gm-Message-State: AGRZ1gKmBQzvJd9iYLxO2/xue5FKK2TDiyM9O0kJ9h7LaSByb++O64pO
        UQsYpsziV18j2I1dvW+Gx/tkTmbu
X-Google-Smtp-Source: AJdET5crt4JaSPJkd43D+D0QGQ9SgtNi9EVO3eIFI7JHMrujaiDcsc7soTk9uk6d7t19xbcesuMWHg==
X-Received: by 2002:a63:7418:: with SMTP id p24mr21620938pgc.196.1541447844134;
        Mon, 05 Nov 2018 11:57:24 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:d185:62cf:7944:299b? ([2601:282:800:fd80:d185:62cf:7944:299b])
        by smtp.googlemail.com with ESMTPSA id v84-v6sm1720759pfd.182.2018.11.05.11.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:57:23 -0800 (PST)
Subject: Re: may I ignore "net/core/rtnetlink.c:3156:1: warning: the frame
 size of 1280 bytes ..."?
To:     =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        netdev@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <0cfb892c-b358-4bd6-f7c9-071a0039bc71@gmx.de>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <c4a54cac-89be-157e-d158-46ba3488ccc2@gmail.com>
Date:   Mon, 5 Nov 2018 12:57:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0cfb892c-b358-4bd6-f7c9-071a0039bc71@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/18 9:14 AM, Toralf Förster wrote:
> compiling recent kernel (4.18.x, 4.19.1) at my server I do still get :
> 
> 
> net/core/rtnetlink.c: In function ‘rtnl_newlink’:
> net/core/rtnetlink.c:3156:1: warning: the frame size of 1280 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> 
> with "gcc version 7.3.0 (Gentoo Hardened 7.3.0-r3 p1.4) " and do wonder whether it is safe to ignore it?
> 
> 

I believe the warning is coming from this part of rtnl_newlink():

        if (1) {
                struct nlattr *attr[RTNL_MAX_TYPE + 1];
                struct nlattr *slave_attr[RTNL_SLAVE_MAX_TYPE + 1];
                struct nlattr **data = NULL;
                struct nlattr **slave_data = NULL;
                struct net *dest_net, *link_net = NULL;

The heavy hitters are:
#define RTNL_MAX_TYPE           49
#define RTNL_SLAVE_MAX_TYPE     36

attr and slave_attr would amount to 696 bytes of that 1280. The earlier
defined:

struct nlattr *tb[IFLA_MAX+1];

Would be another 416, so those 3 are 1112 bytes of the warning.

I have been using CONFIG_FRAME_WARN=2048 for a while without a problem.
