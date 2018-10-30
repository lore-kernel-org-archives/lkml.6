Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B7C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA5D20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YONJhjbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA5D20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJaCRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:17:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36205 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeJaCRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:17:14 -0400
Received: by mail-io1-f66.google.com with SMTP id o19-v6so7766132iod.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W69Ysj+KsdByGhoUS05ydH30bam0iYtu6zyhnLvVXsM=;
        b=YONJhjbJhXtbMlH/dcnwl2Kd69RBFPDErXlmAGYBOsyfCmXe8STtyiVj6kDtG9ETYE
         4xXi0GdzZZFD/McqXYayRTxCRWUJmfL7oxV3spVk9XBs3BAjp2WSPwN9Osd340Zw6e+K
         +UIkK4bnSkBF/OjyIEwK0blsxy14cYaLy62uPGmacQwWQdZk9IYrntpFNGSyicDMfAxU
         A8QWca1JK5o4C8Mu5QuHHefMigY5F7/Mw4rZQzldzF5776qan905cvQc7nOEly9jcszg
         uiAymt15gQuvJkQHyR3/REaV35ypH8Cx7JWNC2BWmVr9lIf+cAT8mDGYTEWmoU6c9JiP
         6wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W69Ysj+KsdByGhoUS05ydH30bam0iYtu6zyhnLvVXsM=;
        b=OQ1w7zkO5JRUsTKRXeATnYqYSx7cMOyWkKLTDK1zUnN85px1CPZXHP2JSPlvRaAzRM
         6MbVWleZO9uwBfmhHW6ovT+oWfw8dTHO2f7TTdf9rwRrHEol+GzkcRm7RAYfHrPwHIW7
         1qYUL4Iqp2q7bpSnOsgRFU5sMhWDRqImqvzgDnmBqgU4OcOR7w/YMs1IJiM6DhlBpw2b
         xf1RnerqQZil2JhHy403JTSm04K6NnRidMGNAKGcxcxO4uE2BpaN9041tuT3Ar8/3raU
         kyoMbuZlvogPa3zd8iaWWgUAw4GV7xNIcNdFUz3E5bKFouJ3wEr/HIIqtKpqKQaBPIzz
         XL6w==
X-Gm-Message-State: AGRZ1gLtYJwHGuxG+prwjPAo77KDHd3YkPBJKurJKGOBId0KceAnxCnw
        sd5GcAT7teJjBEpNf/p7MLBHw8yQhSE=
X-Google-Smtp-Source: AJdET5dbxXSeYnHy5qm/AHx5sg+wz3WOzgSQssI/0RJRlS4FiJkkzzk+Es3vh/8ctcz7QhuG/L1scg==
X-Received: by 2002:a6b:ea13:: with SMTP id m19-v6mr11232524ioc.18.1540920172074;
        Tue, 30 Oct 2018 10:22:52 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm4665446itc.38.2018.10.30.10.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 10:22:50 -0700 (PDT)
Subject: Re: [PATCH 09/14] blk-mq: ensure that plug lists don't straddle
 hardware queues
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-10-axboe@kernel.dk>
 <1540841278.196084.84.camel@acm.org>
 <2e8ae405-6cc2-ce7b-a6a3-ca2e19549e40@kernel.dk>
 <32904af4-90b1-1762-5c46-4d52808cb601@kernel.dk>
 <20181030080856.GA13582@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ab88ae2-9b04-9ffb-a837-c1d386f3bb5c@kernel.dk>
Date:   Tue, 30 Oct 2018 11:22:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030080856.GA13582@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 2:08 AM, Ming Lei wrote:
> Requests can be added to plug list from different ctx because of
> preemption. However, blk_mq_sched_insert_requests() requires that
> all requests in 'hctx_list' belong to same ctx. 

Yeah, I tried to get around it, but I think I'll just respin and keep
the 'ctx' argument to keep that perfectly clear. It'll work just fine
with different ctxs, but they will end up on a non-matching ctx which
isn't ideal.

-- 
Jens Axboe

