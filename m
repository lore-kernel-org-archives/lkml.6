Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77792C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446E720863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="n+dLEfQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBKIii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:38:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35152 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfBKIih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:38:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id j13-v6so8019411ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sb8NaGm2k/XwWwVVppweFWt8LA6VpiYcLXVpJw5XySQ=;
        b=n+dLEfQliRHulGENEzjiPtUKTF95uOEQRIZxdgLtLbSute1MpTPKXHmCZKPYS4qqOA
         0JTJ50wGKXwJcyvr1eqiNb1Nk1U4k9uhLLE/wWx5ka1A+z1kAReKU4RpJogimUwe8sFu
         mbCjYrXBDH722WdOw5bH2HBemQyYTssoVdChqEoBw4INCjmr0rHGP1MEW4F8KDOBHowG
         3ewz/IkFwz6SoHpV0DntU33sIvvRmK5QpGO/DMBdNjrKDs/fGOmfEJQg9msPkuAFcRYT
         ZYJoeeOAai/MoHBg+41quwhHYJV+e8vzayEeYZBG+eWqremf8lSSGX4eC7nF+rxOwt6Y
         s8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sb8NaGm2k/XwWwVVppweFWt8LA6VpiYcLXVpJw5XySQ=;
        b=ip3Njy7zvOIvbNvRehC2Jm15u1stCnIbgj/+dXwVlJAjqZaVoHI0pG96lZSTeOLJuv
         DULOzLYI/hL6GTtY9JGAUwYxNtbt57RBP9FVNlIv67wSZkjidkCSiRXPZLrJE1lOK6i8
         5ITHtMLwOwoEu9Ma7p6wS5Z3wgCKS6h7ZfIANEVQfL9z5ChlG45kn8jm8tgJFJm7hjIn
         HQQvs9Tr/kxp8vORlaM6uw12zZtJvKR61Ul5lXVykio/QcXBHbbyUaz2nCiDbOUEaHXr
         Msk45oOmwo0SNqDqAePU4C6Qx+ZZvwYrjL+ZBbYhmOaxiSTVaTvYmg4GGbBxiOjxSo+y
         gz6g==
X-Gm-Message-State: AHQUAuaYbKtQOODDBvOjQTMTCEan1ACjrqYDJt8oJ1T5RjzvEubnTMGb
        rMqOjsmFRRiP0Gkp5tD3bYtkkQ==
X-Google-Smtp-Source: AHgI3IalEdsHrVsZ51LARQNXZQ3spxRW/+BJSSq0JtR6ias3E4teg7bp4KSsBkjIRY67D/TlcAq7vQ==
X-Received: by 2002:a2e:8ece:: with SMTP id e14-v6mr1768934ljl.64.1549874315029;
        Mon, 11 Feb 2019 00:38:35 -0800 (PST)
Received: from [192.168.0.199] ([31.173.84.177])
        by smtp.gmail.com with ESMTPSA id l27sm1519023lfk.6.2019.02.11.00.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 00:38:34 -0800 (PST)
Subject: Re: [PATCH] mt76: change the retun type of mt76_dma_attach()
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Roy Luo <roychl666@gmail.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <228fdddb9ca96e8ce861e324eb9039722cf18f49.1549850911.git.ryder.lee@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f65c85c2-ef47-d141-d78e-db2a138a1daf@cogentembedded.com>
Date:   Mon, 11 Feb 2019 11:38:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <228fdddb9ca96e8ce861e324eb9039722cf18f49.1549850911.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11.02.2019 5:13, Ryder Lee wrote:

> There is no need to retun 0 in mt76_dma_attach(), so switch it to void.
                           ^ r missing :-)
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
[...]

MBR, Sergei
