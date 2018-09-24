Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353C7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C652145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aImLHIow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C652145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbeIYBXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:23:36 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:35005 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733021AbeIYBXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:23:34 -0400
Received: by mail-io1-f53.google.com with SMTP id w11-v6so18567832iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=V11HxGJSV4NsfO29qz2DLGMkhXDR/6A+HxNpla8+LJs=;
        b=aImLHIowLl4LJH/zfiKN6uFXfYWYRoMGVt72XLd8c/G6SY8aY80bzRXWomROCNd2At
         zoWvUVwPGLMYbEyneHAfah9AcJfWhqbeDt8uF3Y2YE7+CLunToO/XXmBiJZkenC6h561
         3P563YBWkTTzOOhQDT4bNLMBBd24DRfs8RjD5M+H5dob/WmXB2ifQu69hjRFy91ldvCI
         O0Q5oC0qCb55XW8sPyWa1ZQAwEkhxpZj65rd+R1kVLIL/Up8nvbDp5lNdDAiuGObNVVr
         T4OZSdnqE8xvDeK1F+Jx5+Gttm6rrydthExuQ5f9NiaGNXg99XcYc7zkryObwDKABrja
         rhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V11HxGJSV4NsfO29qz2DLGMkhXDR/6A+HxNpla8+LJs=;
        b=MSfpM2mgjiAo9gsERcVQe2lzFRcXuIwngHYULKcAyJqiB2hhI0GKYItxzc2nyTFARv
         tnYIP0xmpcZ1PybZlb8a82+HsU+prpl5xs1fY8/KnPxPIFYqho7b6DP1BQvxExXMiUBC
         o/YnmSF7Pp6GVGt2Dl2HGCAwJo7LDMl2dVFR0nEzljFn7ynrKYPleI/phRc0MoJtwDqk
         ANFX5+s1Z8oF0U8uP3DHqpbCCzWsy01y5H1XmKyY2iYEbtgemAgaiWESkOa8PzFpCNR7
         SL/D0J/wBvnSz7rkJufEQ72oqTCqjXNp1eSJLmFldVyJWOC06/Pj/GwZpCCGtM+w2jjC
         x8dQ==
X-Gm-Message-State: ABuFfogcaeAIqSQAmXJ642wt6W774+OYVwBu54sJFaBzzJNQtHZrpw6f
        3RlfS6DkKIHpjIiTUmmBUcDZdMcla2M=
X-Google-Smtp-Source: ACcGV61KTg/M1GQ4DUjsYUuvFjhCMiYqNTGlpEtndK14/9rpfp6FY3vV6zJ1Tzpn1SVY5dk1NXeuig==
X-Received: by 2002:a6b:671c:: with SMTP id b28-v6mr265170ioc.22.1537816795346;
        Mon, 24 Sep 2018 12:19:55 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l19-v6sm2734232iti.4.2018.09.24.12.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:19:54 -0700 (PDT)
Subject: Re: libata-core WARNING during boot
To:     Randy Dunlap <rdunlap@infradead.org>, linux-ide@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <b9b55c84-a90c-e7ac-add7-fdf1b7e13dc6@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d5420a4-dd7c-1810-2fbd-0840372a5ba3@kernel.dk>
Date:   Mon, 24 Sep 2018 13:19:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b9b55c84-a90c-e7ac-add7-fdf1b7e13dc6@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/18 9:34 PM, Randy Dunlap wrote:
> Hi,
> 
> I'm having (repeatable) problems booting 4.18 and 4.18.9 (latest stable):
> 
> WARNING: CPU: 1 PID: 1 at ../drivers/ata/libata-core.c:6677 ata_host_detach+0x6e/0x150
> 
> 
> It never completes the boot.  Could that be due to this eh warning?

Is this a new issue? Not quite clear based on your report.

-- 
Jens Axboe

