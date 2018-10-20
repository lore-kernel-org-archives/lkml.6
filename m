Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108F7C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A521712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 21:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BvF9D/Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5A521712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeJUFwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 01:52:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40296 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeJUFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 01:52:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id o14-v6so1560937pgv.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pfUELqGAO8tyN+6luWoipK/YwX6LKz5afJWhLWbYcIg=;
        b=BvF9D/WhAwCF2st9Orth5F4rXLJnwgAikIUe70RprUBmmoLALwnN1GMw1b1c767hoO
         ru+OVmPghxYipwmY4WUl2r3b2w66UP70t9U1cUlqtvyXtT8M90ANjlzq1TT1jLBDoTQ2
         N3oarcI9nug1p6g9elP/IMTjhCn9WA2Nbt0JBjFM3ccew/6raYNXX4DKaHhXIQDeAFkU
         0394JjMfL6jFCK2XHJXM6Zrni96UXlBAxlpLTdNjKW0EPf2c3+SnMO1fofjP8iMe/Wpg
         /mDhHAjEmSQPHBrrkLkjIUzflJGwW7TNyWq3awPWkjgCc8YqXxAdbuQxIOVbao6MSMWO
         jnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pfUELqGAO8tyN+6luWoipK/YwX6LKz5afJWhLWbYcIg=;
        b=IOFNeKuBmvTtq2thtjEd/8fVx0ygoV/B/plq6lF1v5SW2X7KhRK6ndz31jLUViTzy8
         rKHQmb64268fFBvnw19uB2+U/oME9dCBXzV+y9wrLFlUqYJWTVF9B9WEwQTtBGzjTMzc
         BvHVBgVvN67RB4KN/naV0OXtcH2B2COpcaDZJLo3aRTCSec5l1tS1NrrzGmaaA5znOyt
         mQi31fT8BbscnvWcKwHB+oTURAwmno8E3j9mt4obMQquuDlikJiy3yO0HqZRSmm9njNV
         6FMQPBKlxvSBy31pAr6jnTqG5Db6MnvDblko4AaIciIGQlNy1W1eRzOzEt0y1Rnu6wEx
         GpoQ==
X-Gm-Message-State: ABuFfogDSso7t/n3iGFu2DfoliGO3Aih6y3R5+coj7xOWMTREj+tLC3s
        pzMsMAGKL810nqyCaC6r2OkHKGkF1Fk=
X-Google-Smtp-Source: ACcGV62tjhZaYpNSRyDePqCR1uHvrcZD5EU3fyt9ZFNUCL5mFTmAifLuGRQ/sDY5PvXa2ouOdSiQJQ==
X-Received: by 2002:a63:9304:: with SMTP id b4-v6mr36491101pge.36.1540071624392;
        Sat, 20 Oct 2018 14:40:24 -0700 (PDT)
Received: from [192.168.89.171] (50-207-252-210-static.hfc.comcastbusiness.net. [50.207.252.210])
        by smtp.gmail.com with ESMTPSA id v83-v6sm51265542pfa.103.2018.10.20.14.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 14:40:22 -0700 (PDT)
Subject: Re: [PATCH 0/2] block: fixes for always associate blkg
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181020185612.51587-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bcc8829d-e7ba-1f4b-e4eb-32deed97ffa8@kernel.dk>
Date:   Sat, 20 Oct 2018 15:40:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181020185612.51587-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/18 12:56 PM, Dennis Zhou wrote:
> Hi everyone,
> 
> It was reported in [1] that blk_get_rl() cleanup patch was causing a
> null pointer dereference. After some back and forth debugging with
> Valdis, it turns out I wasn't properly handling association with
> recursive calls to make_request().
> 
> Another issue was identified with the blk_get_rl() update as it is
> possible under certain circumstances that a blkg cannot be allocated
> when called in blk_get_rl(). This could result in the blkcg_root being
> returned. However, the blkcg_root is a special case where all blkgs
> share the request_queue's request_list.
> 
> The original series can be found at [2].
> 
> [1] https://lore.kernel.org/lkml/13987.1539646128@turing-police.cc.vt.edu/
> [2] https://lore.kernel.org/lkml/20180911184137.35897-1-dennisszhou@gmail.com/
> 
> This patchset contains the following 2 patches:
>   0001-blkcg-fix-edge-case-for-blk_get_rl-under-memory-pres.patch
>   0002-blkcg-reassociate-bios-when-make_request-is-called-r.patch
> 
> 0001 addresses an edge case where a blkg cannot be created and can
> possibly return a blkg associated with the blkcg_root. 0002 fixes the
> stale association when make_request() is called recursively.

Thanks Dennis, applied.

-- 
Jens Axboe

