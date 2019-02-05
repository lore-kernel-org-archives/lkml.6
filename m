Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFDC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254FD2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha7m6H4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfBEUXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:23:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33792 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfBEUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:23:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so2017457pfg.1;
        Tue, 05 Feb 2019 12:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kChSWcBLaJCo4t2/gyrWviE3L7hgYWbjCBloEWevwyQ=;
        b=Ha7m6H4e041hzT4W4sBnJqpU+f056ALD26f7X8JLN4jMud+WMNYV+4tAkNckT3Ub1Z
         zjC1qKi8dLcK18bjsOC5/8Ak4FQbgVSRCX08wS8hw1NB5fGhtfImKKI9udOc7FQ4yDIw
         SvlUwdiKRAZEXyh1Lt1rb6blbmb4ny1H0rZ7sf8DUg2EehPumSkXCpt8XcUVUsjb9qi7
         NETANJbsJlWYlrTvuEtO+rAnP8F8mTJnXHfspjfwbm4UWLDFJ6x4pU1Apxz6fPk7YWNm
         rMdX/EGZGHS5hOP3o/Mu7cSXzfcIfy0snk7CojGjI0K5VAcAPkHIHBRi1n9HSbyH8ntf
         cfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kChSWcBLaJCo4t2/gyrWviE3L7hgYWbjCBloEWevwyQ=;
        b=V4LpRapS+v31Szy1CmvJCbw3fUaa4Sn++onIummzPgEhOht0mS3fsxCoEC2RyG97ES
         wKQ2UaiUnpOrU4zwt3tbPs8ZRqRuOn92ftF7xIiKpGqOEmS3xkXcX08xnIFcTX6wDkIa
         h88TSZRjs86b1cvYax7m2Ce9DurD1X8Az4arJi8UGCuvY1IBIHwug6OFaKuXEvrr6Y4u
         RhRiAFUe++EP8h0NsqQPwgBzWYZttJhA1QC8VEw3SvEC2mPKDoj70Q+aypbnDC7eZEDO
         YD1Chchw9lK9hb73SGjyjeEXemsF6Th9vK1QKeQjCPnrkcCD52nWZZTO13XCtpejZ34x
         eTmw==
X-Gm-Message-State: AHQUAuYZwXLo3E0HaR6SiKhh6c1UKx5MsdcGIgVoLAQtSolf1WVLoVyx
        Xqp49TJN4+KU2SnuKOp9WOYORruG
X-Google-Smtp-Source: AHgI3IbCzlIqV+g3XzyafIfQ/7az0nFmOjDnd1QpPF9Q2yAmUTHrhVfCsfmus4cPJvF61DsDwG3/yw==
X-Received: by 2002:a63:1a4b:: with SMTP id a11mr6226175pgm.254.1549398200104;
        Tue, 05 Feb 2019 12:23:20 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id t24sm4921430pfh.21.2019.02.05.12.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 12:23:19 -0800 (PST)
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
To:     Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>,
        thierry.reding@gmail.com
Cc:     hkallweit1@gmail.com, andrew@lunn.ch, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190204164213.30727-1-thierry.reding@gmail.com>
 <20190204164213.30727-2-thierry.reding@gmail.com>
 <20190204.192040.1074738183781998611.davem@davemloft.net>
 <8553086eaec167846992f1cff12aa388cee81767.camel@perches.com>
 <ca6ca816-af03-e1f9-739a-a06cc4837b80@gmail.com>
 <4aea523a3bc5be0d944f7ed9fadac276b7115002.camel@perches.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <efc77e73-914b-3b9b-16f2-1ca5353f5210@gmail.com>
Date:   Tue, 5 Feb 2019 12:23:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4aea523a3bc5be0d944f7ed9fadac276b7115002.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2019 12:18 PM, Joe Perches wrote:

> I still think adding __align(<even#>) is unnecessary here unless
> it follows something like a bool or a u8.

This would be some historical side effect, and we do not want to rely on that.

A security feature could in fact ask a compiler to perform random
shuffling of automatic variables.

( a la __randomize_layout )


