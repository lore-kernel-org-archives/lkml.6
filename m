Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C8AECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BF82080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bgtfFerz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BF82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeJ2QyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:54:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46254 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJ2QyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:54:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so6821077lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ajaYwJF4Ljrrll4IuoXvlD3RjAFhr9gdHOnHhXAu5Zs=;
        b=bgtfFerzqxC6ZUuW/O5tRqis/zoiuS3TRapqRabfRAjRT6CbGF3xgSXW/A9SlH2G4O
         s/JXPY7DoPAYN0uosA05sDINjNfda8s2Nq6OapQWkAyjEuyKBqs10HB7CSvEe14F5iEW
         ZroMXJabEv34xiq5PH9zA7msP+7mqsRx2TqRJCOjq5I6oYTP/WDWWSzIYrjCkIl2ptTz
         UX4P25hpz71nbGq1MgfQfwCnRO64i/GrEXANeX6hTTT/fGunYPdkCMCIb217u0ypIPrm
         SPg9tGHE5M7ql0UsRWXrROLk3cCNHkiWOvY98Iuzbl6d1fjcwl3/ULZmjj0krWyOOi5K
         iQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ajaYwJF4Ljrrll4IuoXvlD3RjAFhr9gdHOnHhXAu5Zs=;
        b=B9jb7BE5dSt+F9eGKLFHKRbQ5c8MoiLzNhGThXtSHCsOruFEeKB06a37FlIgt10qA+
         65M7MtG9AHopwGN7Quo39od39K6uE8w3wbQRtK1jcsaZL7TX2q1SIq2EYgVUCAO03FJU
         0j+c/isqoYhYBLUrQpeqnUQ8WItfgIhhEebtsEo9Rg/b0+WHUnrRMs6J8JV4L4MCCPbJ
         XSWtWLog/Wn213GOo6APX8M4Bypxxul/DDXwyOgQ5PNfe4ltT89tgl50BZZ2NtHkEiky
         T4U6W7H5iAp49bdF8dYGHMkpQTeWNmDqoZySs43VEvD1XvUG1OD57EUsNmiNjuJursuZ
         rQTw==
X-Gm-Message-State: AGRZ1gIDfiIv0z4rsaEEih0a6OBmZeL555MBqUCPutw1smu9Cx8TrJen
        Jc83/cruVrraxTac3B7XXz3Wtg==
X-Google-Smtp-Source: AJdET5cKauyhWO1h2ZqTBuRWJK5O+Kd2QrHv5LHiQChZveprNqHnA11mW3b1cYjhThIm2NJUoLJRTQ==
X-Received: by 2002:a2e:215a:: with SMTP id h87-v6mr9407080ljh.102.1540800398714;
        Mon, 29 Oct 2018 01:06:38 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.80.69])
        by smtp.gmail.com with ESMTPSA id c22sm2922682lfd.88.2018.10.29.01.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 01:06:37 -0700 (PDT)
Subject: Re: [PATCH] clk: boston: fix possible memory leak in
 clk_boston_setup()
To:     Yi Wang <wang.yi59@zte.com.cn>, paul.burton@mips.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
References: <1540800277-24524-1-git-send-email-wang.yi59@zte.com.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5484fe07-5909-dc67-5de6-72e878060a54@cogentembedded.com>
Date:   Mon, 29 Oct 2018 11:06:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540800277-24524-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/29/2018 11:04 AM, Yi Wang wrote:

> 'onecell' is malloced in clk_boston_setup(), but not be freed

    Is not freed.

> before leaving from the error handling cases.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
[...]

MBR, Sergei

