Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75115C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A7220856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGN+xllQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A7220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeICMXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:23:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34051 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeICMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:23:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id j25-v6so8215271wmc.1;
        Mon, 03 Sep 2018 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CXO4+Z9bmvMX+FtXFbcITJcPhFYJyx24Ym8/TbikV3E=;
        b=JGN+xllQsFPdbWKqr+cxJ3vRTjn3TnJmEBBmmqcj9Bx2JJYj334oVLhmY+hsq6lixa
         U+QMJCWxa0p6Jppk3eH0RIiykgYC3ViNxIKkKVA15Cq1E67Ks2PfhmMlefNSk95Rl4Rs
         QtUqcqnZv/SkYs07Wm0BBftg4wSB9zDmGnRf9nZuDd05OCZXN98CHhPcBHtUicJMlZwj
         dfNqeCBaZc/kmCfQQ2oC5oHuh0mYUS3A0FnTjGjBoZMQssewbZK0C0jGTEbsQ9f5oWge
         +h9QIfl8rdCqvQfGFn4dkGCk4OueNW9F6tG3xV9J3l7782vMi9jlK//IsEIH/Ihq9ZMo
         XLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CXO4+Z9bmvMX+FtXFbcITJcPhFYJyx24Ym8/TbikV3E=;
        b=K4JGOFBCZgIMROuoeJKYmOqqEtgwLy1wMJ6+KiWfiVO5Wk/UJ4mkhAM+kUGhiAN+2/
         TSiBBv34piBTpQUHCN3shuF1hoo5Elw5qLn1nMhtX8nIL6rakQLIkfgSxiSirKf/1gTq
         VLCC1Gx2GQXuLJNPIu8bbo/grVolAkOC2JfYFhrnJOi0DmiQVh5RhaUJyeOqu3bO3oXg
         JBJUa+eZJiu6UCb2++HUhzFCBlGwfvGsD9n5XXwlV57f6v3628MbM3Q9nZL57cH4YADC
         7KJANYFG2Vo+jypvcRAJZyMzPhb44wHBzJ3QyHPRJzaeK50mLKxn0chOSizd5VQ1sa+B
         DStQ==
X-Gm-Message-State: APzg51AwKW/CMhSCf+ezNAXk8F3Hk+CHrM4cLl203wYQsCh9URhULXA5
        Kj1lPfdLfWtI/s407lrPIc6vC0TqnZY=
X-Google-Smtp-Source: ANB0VdYWLr5E05KCT30SdfZOziHGdJ76fWa5Ul2yf4unq93y6I3pRJdYPzC2mJBRZ1uY9IHFJxT54w==
X-Received: by 2002:a1c:2108:: with SMTP id h8-v6mr4141871wmh.108.1535961863597;
        Mon, 03 Sep 2018 01:04:23 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f6-v6sm17682440wrr.68.2018.09.03.01.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 01:04:22 -0700 (PDT)
Date:   Mon, 3 Sep 2018 10:04:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Relax checks for sector size and media type
Message-ID: <20180903080422.ta3clnhr5bobv6il@pali>
References: <20180902131932.11558-1-pali.rohar@gmail.com>
 <87bm9ft5h5.fsf@mail.parknet.co.jp>
 <20180903074005.7e3guj24ksq2l44c@pali>
 <874lf7t3gg.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874lf7t3gg.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 September 2018 17:01:03 OGAWA Hirofumi wrote:
> Pali Rohár <pali.rohar@gmail.com> writes:
> 
> >> Just relaxing validation doesn't work. The block layer doesn't support
> >> smaller than 512, and lager than PAGE_SIZE.  (And in specification, fat
> >> doesn't support lager than 4096.)
> >
> > Hi! I just sent this patch for discussion, with links to (now open
> > source) Windows implementation. I guess that Windows driver
> > implementation is more "authoritative" then Microsoft's own
> > specification. It is known that Windows implementation does not match
> > Microsoft specification.
> >
> > I know at least 3 FAT specifications (MS EFI FAT, MS/SD card FAT,
> > ECMA-107) and you are right that Microsoft's one does not allow sector
> > sizes larger then 4096.
> >
> > If there is limitation by block layer, then:
> >
> > 1) Why we do not check for PAGE_SIZE?
> 
> That source seems to check power_of_2(size) and 128 <= size <=
> 4096. Rather why do you want to support larger than 4096? Or I'm missing
> something?

I looked into (Linux) mkfs.fat and it supports formatting disk also with
sector size > 4096. Therefore I thought it may be good idea for ability
to mount and use it (on Linux).

I could check what other operating system would do with FAT sector size
larger then 4096.

> > 2) Is check in fat driver really needed (if block layer checks it)?
> 
> Yes, isolating block layer error and fat format error to be better error
> report.

Ok.

-- 
Pali Rohár
pali.rohar@gmail.com
