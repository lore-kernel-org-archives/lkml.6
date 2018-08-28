Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4436DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F026220891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gHakl+HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F026220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeH1SaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:30:19 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40536 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbeH1SaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:30:19 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so1638053iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jS1PoApWUJqm3lFpYQQhNvpO3ekQP9bYp7KjkeMGN9g=;
        b=gHakl+HLnXHmaBGj6yrExFQdDpvFfJSnyusoKxpOUQObizp5+IBwzw71ljUQo3LC2u
         iZHzaVaPM6w4s9uFVqXz0+nXKETa3X91HtJjtLLYATWA+4iX+4X0q5CU+u6yOEGUmaAF
         AyvJcN7JSQRcU3cjzWe/qS8DqoVy/Xsm+ch21dFw+njnbUSSESkovhyahJ4V5hsYOiFv
         kd2x/JM0OLYj9nWYP0NTOq/SfK6jJWlhnkKQMJQgALVaEn1RoF6gAmRBKKoj1a3tlNjl
         Ocydn2GcO23YtWYOJLCc8hLn0pJP2KOw+MjIYEq//EOah0tucpKm2IxElutovI8Le/Qw
         kt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jS1PoApWUJqm3lFpYQQhNvpO3ekQP9bYp7KjkeMGN9g=;
        b=GX5p6XpjJBi3gD+/dAhqVV7H7hEUhaDoxztpIuWJfr0dRGNRIyRlv9vyYX0TkfLtlY
         IefIuG5l9IyN5kSd9z0pQnWeWc0zhy/R0NOTV7C9vhEOQeUWqYh+yuskMdF2QL6nQHHi
         LaUAZb8H2Mb+RygXeHarrTXL7m2yuxuAmyGmPc48tfyBzFRQfxY0vwN1qQmoDFF0/BLS
         9VFGrr/9CHnb8UOeBZ1Hlb6voa7QRHe3kcZWOth+EfKXNcxGoEOqbSBwEQyUpdZiXpqf
         VTzcyf6nm/OG2fCeV48VHuK7d+NU7XO7TZ4eRIiuas0KuE+8J8Xl3c2UYak62VRRPunz
         gMxg==
X-Gm-Message-State: APzg51BOMt3kvWjQts0kIlRK+9fowiyIJOyuog5VOzXyr6t/WbsM0r5b
        F8q/YylnT25fTCrO7DT5x8T0ORykbB0=
X-Google-Smtp-Source: ANB0VdbVA5Cf8ogiO2ZWHnfq7oyXGQsibhza0Ks0h+O+YZTHDH5FrjWQvDgGPoUHnu5PquFQZDelag==
X-Received: by 2002:a6b:1487:: with SMTP id 129-v6mr1678411iou.103.1535467100096;
        Tue, 28 Aug 2018 07:38:20 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k142-v6sm800932itb.0.2018.08.28.07.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 07:38:18 -0700 (PDT)
Subject: Re: [PATCH] block: Fix unneeded NULL check
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535441413-8583-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd7ff39a-fc3b-0938-ad3b-fc070d937aa7@kernel.dk>
Date:   Tue, 28 Aug 2018 08:38:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1535441413-8583-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/18 1:30 AM, Ding Xiang wrote:
> if icq_cache is null, kmem_cache_destroy will do nothing.
> So, remove the null check.

Identical patch is already queued up:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=62d2a1940709198a522a43ff8be8b8f6b3654dec

-- 
Jens Axboe

