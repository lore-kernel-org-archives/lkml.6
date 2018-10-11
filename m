Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C57AC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EE82098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YsuBOeXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EE82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeJLBO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:14:56 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:50689 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeJLBO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:14:56 -0400
Received: by mail-it1-f180.google.com with SMTP id k206-v6so8695202ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oTlgpaRAxwdinROadk6CmluxB4aHAyZnJ1nqE+Wlkss=;
        b=YsuBOeXV5yGM5wwjCHQHYm0i3GUWAu29wn1Eru8pox5hhy4UxYGKlueo7ZYgoBVVUo
         QDGNw3InqRtAJILSgMItYbc07CzbTaugDm+njJZXQFYBr6FQsWHx7M2ShoLbldhJh4YG
         R4SKzoEkFwtqp9gtAzRE8j3/tDGHZkVCnGnf5sa4wr4szG8Id1Zwr9vJGuG0OyRsp2zQ
         QpzlISp6YkbSxKtCqJFchIaTmNeTCf+SUI2Fd+ifTMODUl74UADysqQ8SiMhsFoIPwre
         6XEQDO/twXQv035tTjHuG9KZx98WQ/tseNe+1ZLlDsmpY+55kZ19YgQ6ukemT81h1Orv
         Sa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oTlgpaRAxwdinROadk6CmluxB4aHAyZnJ1nqE+Wlkss=;
        b=WWELupTNYpAW90uUZwN40GvIupgdhHSA0QPKgR+3ZJUWg4/91GWPe7/EEFeunSUZh3
         7yoNbgPPzgOFsPPQ6Y0ghSEgprWZAdPXBCgUSC5VhL3ljhgzYWrOAaZvplifvn8FlOFd
         usr+sQBU5fuVzWe0PDzoftlZtB4EHze9ny634MvW0kx69qIbrSbJERYtnp2aFUaR6U/D
         MqNFhYJSFUqQQzQMzcUtPrMK4nBTJCQxJgeHPcQJ8fuqBRt7aQjuQQ8RKkb7REs6EaQh
         6NfWRGcB5KCriZn6tkv1kY4PlaHgPCHVs3j6hHPR4ATxnl+7/4MGTXmU8GK7Qq4p/cJG
         e/ow==
X-Gm-Message-State: ABuFfojCJYxBv6auPMBUrrKYtiS9ED8BCMkeNQdx8lpLu35ToJC8xxLy
        XWY8LAT91eWyTiTyatMlwohkpcLxP0Y=
X-Google-Smtp-Source: ACcGV60jdSS5cWQlRSBLv2axbVP+nDkq5PBj9m35eKMjr0uWIPcLU4Kd9mdYmZBbFtPJUBZvnyLJOQ==
X-Received: by 2002:a24:455c:: with SMTP id y89-v6mr2160758ita.67.1539280000361;
        Thu, 11 Oct 2018 10:46:40 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h2-v6sm8509922iok.85.2018.10.11.10.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 10:46:39 -0700 (PDT)
Subject: Re: [RESEND][PATCH v2] cfq: clear queue pointers from cfqg after
 unpinning them in cfq_pd_offline
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Caspar Zhang <caspar@linux.alibaba.com>,
        jiufei.xue@linux.alibaba.com, Tejun Heo <tj@kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <befb45da-2a7b-8dff-30e7-59b441f604fe@maciej.szmigiero.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3abb177f-d6ba-7f7b-e8a6-d27e8cf388a0@kernel.dk>
Date:   Thu, 11 Oct 2018 11:46:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <befb45da-2a7b-8dff-30e7-59b441f604fe@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 3:16 PM, Maciej S. Szmigiero wrote:
> BFQ is already doing a similar thing in its .pd_offline_fn() method
> implementation.
> 
> While it seems that after commit 4c6994806f70
> ("blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()")
> was reverted leaving these pointers intact no longer causes crashes
> clearing them is still a sensible thing to do to make the code more robust.

Applied, thanks.

-- 
Jens Axboe

