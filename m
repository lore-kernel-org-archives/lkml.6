Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA92C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32DD22506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Evbz7ZiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32DD22506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeKMFZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:25:33 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:52891 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeKMFZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:25:33 -0500
Received: by mail-it1-f177.google.com with SMTP id t190-v6so14362401itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pFdWEy6L/wpBh/kv+SS3VaJUhrcx9veBghHtlmz36QI=;
        b=Evbz7ZiDrpZgp6rHzPkEUiQaoPUakZI+OU7CsikSYBSMcv5LMH8nO23lsx629mUdjg
         5iy7LAX0X5xYhcEc5+CajtnvTBSpr1rStyWcfI4wQ5mwGBYSNQrajNSfyh3XDg9I31KB
         cjzPgC0AotP3GKLDOhfxXmUuPwLaBKK66RE7V4LP+eVn60CfDDXaj1UTjPmUrWeUu4Ud
         ygA4zUCwd5CtQLWLdD3U7qe/589x4KPLZXn4odJt9/whqiME0hZvEqVR4mlvwp84ecJg
         JJiYujs9i7d7Yq/mColeWMdC73z8hB7WrESUNNrA44omSJw2EEoXoxGq3XWSts8v5VnH
         RkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pFdWEy6L/wpBh/kv+SS3VaJUhrcx9veBghHtlmz36QI=;
        b=K9OBG+ISrEuIDJ3Zee8EtrpKZ2S4/E4Vk3jS2NI2ZbdDwCAr5/07v37ZJmAA8y41Es
         tCC+D8Y/1vFRB55wfShLQbJbZYk6m8hNCP+y2o1x+TQ9TYGC3x2U1V4AAyYqrQTy8AkI
         zPQvX3QyA5zhBOuXeFtdLsDVhYRvHFTUfR3RuSyuXsU0hfToN0q+dsetgh0USX+/MXlH
         kBXPU/Q1ijMnUsQSK2jixW5Ck039cTvTLtZzobMv+rItYMaKUopnWQmzn1Czp+RIXvBt
         +A/EtFHWWum5ihmA9zv1HvjArngWhzgyl1PGTaUgcEbaISJ3Lq2xZeBcFVyvYlcNwArx
         uwlQ==
X-Gm-Message-State: AGRZ1gLs5vlcrC6vC2NUq4DstnOG7697ty1nJ1qRAAFUY4x9qS4XIcVt
        lvQEQRjMPPqpxkP13uadmEBtkA==
X-Google-Smtp-Source: AJdET5dSj6s/vVELbl/nnokXV5IEq4UbqvBSuFJNOIt8zK9mxhTrH4jXRxf1pAv5/k4t7wvm9EMdpw==
X-Received: by 2002:a24:1706:: with SMTP id 6-v6mr898356ith.169.1542051055122;
        Mon, 12 Nov 2018 11:30:55 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h128-v6sm5923024iof.38.2018.11.12.11.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 11:30:54 -0800 (PST)
Subject: Re: [PATCH RESEND] Blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
To:     Diego Viola <diego.viola@gmail.com>
Cc:     hdegoede@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20181112192252.3911-1-diego.viola@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ce81ea56-cdcb-c739-42b9-1d48188c86da@kernel.dk>
Date:   Mon, 12 Nov 2018 12:30:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112192252.3911-1-diego.viola@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 12:22 PM, Diego Viola wrote:
> med_power_with_dipm still causes freezes after updating the firmware to
> the latest version (DXT04L5Q).
> 
> Set model_rev to NULL and blacklist the device.

Thanks, applied.

-- 
Jens Axboe

