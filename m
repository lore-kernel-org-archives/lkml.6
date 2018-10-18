Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAF9C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28A2208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="foNBEShO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28A2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJSEBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:01:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35871 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJSEBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:01:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so35028786wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CUHbBBIs86046FIj+aeLo3wHi3IRnJfFN0kbp+rk9Js=;
        b=foNBEShOoW/1kh65jLpe/gzYbs78DoEVfHuEXCoIPnxmheDb50sESn+GpcRlnT5Nbn
         AGTs0nFtSkrd0yWcwCPimHi9gJ9tU3JwRQgx6RDAH2HSin4uRDdh1vmmt3FW3LPFgyZE
         GgxbhV2QGoyqJUSNwZSAeb+mDz4X0vwKwuEWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CUHbBBIs86046FIj+aeLo3wHi3IRnJfFN0kbp+rk9Js=;
        b=SEV4I8QVzEh/TduZePi2L5rx6mvivBs+qrEOiwAColmJUNeBXtIo7F1kKU5INzBS+o
         4GYDX/xU6MU1/xfjQG9AVBrKIChiohi7m5t99GU1497PMH8vhF4/c4RA8KpTbvjd8OO8
         DHcYfW5LCvsNtH0raTBo7/WvZJxJZmIOrSYAQWmxOaZq4EbSIMIwLQqMWE1fUBmD6mXK
         Rk1yjVJt0LgV73zSsHZfyTYXskUttjPz1TyleYlo6eMKoUH1ZhpScRmDrtSvlPLu6CrL
         M1vsiLFfcnDkxe0qYiHS0kI/z5gHjnCT+1y9NL7Cl+EKHxG+RI7zKLwQ9YJYczCmQ6FC
         v3ww==
X-Gm-Message-State: ABuFfogANdb20XYRhBtHR0N9BuLhezQrvzt4hvBhfjpSKb0lKbX6ROTG
        FvRmhT3OwBuaTl8umd8A33ofHg==
X-Google-Smtp-Source: ACcGV61fYoYVyaifKQY9TiQBS0OnOe88UwkCkaJ8T/QWrtngpWMFgwTB9IPFmnNBFJpSiLmzh85fIA==
X-Received: by 2002:adf:bc84:: with SMTP id g4-v6mr32101352wrh.250.1539892708623;
        Thu, 18 Oct 2018 12:58:28 -0700 (PDT)
Received: from [192.168.0.40] (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.googlemail.com with ESMTPSA id l70-v6sm1948757wma.0.2018.10.18.12.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:58:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] Linux 4.19-rc8
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
References: <1539892357-16810-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <62bafed9-4ea0-5b06-435e-2f242dc8e095@linaro.org>
Date:   Thu, 18 Oct 2018 21:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539892357-16810-1-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2018 21:52, Daniel Lezcano wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sorry I did a wrong copy-paste when git - sending the email. Please ignore.

