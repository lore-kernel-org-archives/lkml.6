Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A57C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548A620865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="pA+bEi7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548A620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393388AbeKVUB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:01:29 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:41058 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbeKVUB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:01:29 -0500
Received: by mail-lj1-f179.google.com with SMTP id z80-v6so7335805ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 01:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmguwe4ju6fB4lCa5EdFqgJTdKbMYnW+NlkjHxTaa9A=;
        b=pA+bEi7I8TwBKtg2txXIA1QqwIh8mlv03SM1ztE81ncuca1lMMZw7RUsZ01K+orMt2
         +eMIe8+zaiIV8ufFLymHAN0gSk/wupCaTS6bMqXrFFGL1OQcvBdARZ4oTukik6veZbAD
         DWacDmlVBAycPdhQAQRFhWZiTstJFbMgrvSWJ+wgB66iZVPjukw0+QG0RB0mv2XV9KiK
         jcDenx3c2P7Q2NNd2ZVBY8tGg7/hUMMLmX/jTO/sFPpsJbATVN7HMmviwAAx7y2urB3y
         ndkUzQqg8tTs0lqViVSTmtA9CO7nF5ADnQzbiwdYcrk/+mINGPhsmgaeRcbBMhE+Lv2V
         OW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmguwe4ju6fB4lCa5EdFqgJTdKbMYnW+NlkjHxTaa9A=;
        b=dG5Q5Opak3cgmAD+T9OySksTFZ1zHK1KLOoXq8Hs1YN+9myMhdZB2BSxlT3FaNQ5e0
         hUXqAZMpJ4GgMPzodjWOp6Qsn3OUllKwHj520UNTaTOJKTI8KZKn4frwMpLhWuIqlKsS
         QEHHgq3N820Xjg5oTVDgbQJEopBv0IuGfQq4VIZwdWEPl+H7cmcfHtJNrpQFt0Z4nrim
         6T+PiZ4oiVCqTp/969006AqhBjT829cwQCUIB9FSwP1DIQC1W5tZKxhXHaxy1Bw8EJxv
         FEbqYpFzJ9ItB5dvgwZKD9pq+H9hLqfh2xkCU1kM76OweEoUB3lNM36MxOtsKkTTsG6c
         EYOw==
X-Gm-Message-State: AA+aEWb+654lS5uq0pYGZiLkgtVZi2J6eG6Y4xWxjy8sjLu9uwhnnAKk
        jzpTEQCUbrDcZ7e+OTCvezMnKzdJrF4=
X-Google-Smtp-Source: AFSGD/WqaBp2DRHgo1UX0tAHnPpdFoOpUUskptUcVOjQgzBzZF9ZwByPVYZKM4uMuuSOUoL6AsptYA==
X-Received: by 2002:a2e:2f15:: with SMTP id v21-v6mr6337049ljv.56.1542878569477;
        Thu, 22 Nov 2018 01:22:49 -0800 (PST)
Received: from [192.168.0.200] ([31.173.80.84])
        by smtp.gmail.com with ESMTPSA id m63-v6sm8023115lje.81.2018.11.22.01.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 01:22:48 -0800 (PST)
Subject: Re: [PATCH][net-next] net: hinic: fix null pointer dereference on
 pointer hwdev
To:     Colin King <colin.king@canonical.com>,
        Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181121195956.2730-1-colin.king@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7fe07c86-35c7-46d1-2d6e-dd3d4f0ff156@cogentembedded.com>
Date:   Thu, 22 Nov 2018 12:22:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121195956.2730-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 21.11.2018 22:59, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer hwdev is being dereferenced when declaring hwif , however, later
> on hwdev is being null checked, hence we have dereference before null
> check error. Fix this by assigning hwiw and pdef only once hwdev has

    It's hwif, right?

> been null checked.
> 
> Detected by CoverityScan, CID#1485581 ("Dereference before null check")
> 
> Fixes: 4a61abb100c8 ("net-next/hinic:add rx checksum offload for HiNIC")
> 

    No need for this empty line.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
[...]

MBR, Sergei
