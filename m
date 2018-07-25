Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415F4C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7E020671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="deSWtuG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7E020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeGYKkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:40:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36720 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbeGYKkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:40:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so6080402lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=me9fM+mmxyRJ6Ojgqt6pQB6EEtcm3+xP9T9w3oeLyzc=;
        b=deSWtuG8AtHBs3AeUFKChm0Fu1SA9moEe9eO2ldewd7s4EVu7GVRpozLFbrRLvY7jP
         TRmRLtiwTfuQ1qmc/m8N2qMNYpGwaB7xAtu08pX5RoIEpyNdshDlpYJazfywCJld+Z1s
         LKLzc59Qo8RRdlvHqDcJKK38a1ZHaSls2CwjMQwTzLl0Rs/ZUIH2homyv3IzDZDoEbIQ
         JS5c6RRvE5VEIOq07AC88IqWmiA4u1wU8PnL83N6BQYcSsWLNtOerQlI49esqQXWtY4f
         LpAcqF8yk2vNsDrOcJf7J08QNg8Bs4MK/v7/znyvwI88cmpuGQaciFQ+MR4vORwhY+lw
         I5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=me9fM+mmxyRJ6Ojgqt6pQB6EEtcm3+xP9T9w3oeLyzc=;
        b=FKGQb+0Ym1Jix9L0UQEKFC1h6UJtDMU4IegN4qWoVDv1d6m9vzHRqVK2/T5vh+HUgN
         WORnpN0qSGFnwBVnj+hadwaJCqaE4Un6n0iI0u7/q2BDmQImAwGf1q7C6zx7zqFbyj2T
         H9f/GS8K6rZuJyQnD9inLhA7FzIBzl279hlADxCU0+tI3kuiSMP4fbrOme+U77201u35
         MFerzm8K7ZYU3WhNVZCUJkHFs2JH6x9OS71sjntKkpmZK9bnUZK/VMfz3IVlvmRmnqIb
         aMEZnPKf4ZSAUVzNWLSWTba4Ausgi5fXVvw9O68bWlWCwu8pIi7fkaDg7J1immzbDISr
         YlRA==
X-Gm-Message-State: AOUpUlFEZ8kv+aScDGIAX7KckP5X4xAELndsl4Ho8ptZrsktvGNCYbMD
        1sbSB1rQzWNlJkZU6DCLgmLVwdTx+S0=
X-Google-Smtp-Source: AAOMgpfncEKunmP6XkBZ593ZGec10pNNyuxeGQPl3NXvoBat6zJBtujP01C2KPDNNq40cuyTqTx4DA==
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr14319831ljf.36.1532510951879;
        Wed, 25 Jul 2018 02:29:11 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.217])
        by smtp.gmail.com with ESMTPSA id m8-v6sm2710895ljj.10.2018.07.25.02.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 02:29:11 -0700 (PDT)
Subject: Re: [PATCH 1/4] docs: bpf: Rename README.rst to index.rst
To:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180725022926.8993-1-me@tobin.cc>
 <20180725022926.8993-2-me@tobin.cc>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0141716c-e909-1429-68fe-6da71d4c6677@cogentembedded.com>
Date:   Wed, 25 Jul 2018 12:29:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725022926.8993-2-me@tobin.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/25/2018 5:29 AM, Tobin C. Harding wrote:

> Recently bpf/ docs were converted to us RST format.  'README.rst' was

    s/us/use/?

> created but in order to fit in with the Sphinx build system this file
> should be named 'index.rst'.  Rename file, fixes to integrate into Sphinx
> build system in following patches.
> 
> docs: Rename Documentation/bpf/README.rst to Documentation/bpf/index.rst
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
[...]

MBR, Sergei

