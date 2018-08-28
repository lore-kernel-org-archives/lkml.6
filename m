Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36A8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8530820658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="EMi6W8an"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8530820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeH1NOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:14:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38833 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeH1NOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:14:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so807996ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R1rchi/xUoM3U0XMY2Jpdg0Knk5tFhzuAuRdVpDqur4=;
        b=EMi6W8anq8iFVPlLLD3C//wjRwNUJQhab+gIjf22WQggzEKStnwNf2KZgqwM3+kJbB
         2F0I+TuT2QBxasEuxh/bBdyfswzaepwpX67yr6CvMMAvsNSW+D+eVJgEOVY3xJqKraFm
         ifItz/dfoASmspc/5maYOvYMi20PhIvXEPNB+F+4Bs1p11TQ9MmaLgY5gafU1evAQd5n
         z/Nu1U6xbpIcf7Vj24+0RG/bErJZN6NSXXtz3PjJ+Rdrc6W5cfbO/8QinMCgGQr8aRKq
         wGkqfJTVGKj7JQd8giG7unGuF8xyBSDFHoP41ELAUchkk9ctIAJlalcvX4cNLvUQ4noL
         DdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R1rchi/xUoM3U0XMY2Jpdg0Knk5tFhzuAuRdVpDqur4=;
        b=pOGifojDCwMsdS6UQ2KJN2H5wU5QQRUBbi3xkvN9dH9LcTzxfUZwqIvREgWIULFgAc
         ZdIG0C8d24iQCUmTqfT9hA1VeZazXs9RSomhBvkWFs+eZ4rGc1ToPI2GBPD1qiHyx+hA
         daI3xFjebd6XHntq/HHXGFGG69ZKJFdvLj1yjbdJzLv+dccwyO0W4HMOjAQDV6cpL4FQ
         2Iy9mqp0/i3avIZ0NxFza+GQ8yg70C1NfeaH5hGy9RjGn0AS6P5kvJnF0zRzXybUsyo1
         K1BycMLEjOiR39NfZ1cYbjvLNb6vOIo6wsE9xy7/dCTUllHh1p1K9SsKcezVMkLHwX9d
         gPEA==
X-Gm-Message-State: APzg51B5VjM7nFUPr/EDSrOidJSYlbwFZ+WuLXwoDD9phhWnAuHruML7
        iSWyOUKkvgZboCbwA+5hvjgQbEgO2R4=
X-Google-Smtp-Source: ANB0VdYNtmvAXMLNGfkfcoRdUz7TMZyv4OzIAPLOYW9J5RPsXbmJLpPZ/VmNN6qD+1QzSBZ408TUdg==
X-Received: by 2002:a2e:8346:: with SMTP id l6-v6mr677375ljh.72.1535448216505;
        Tue, 28 Aug 2018 02:23:36 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.84.111])
        by smtp.gmail.com with ESMTPSA id 4-v6sm114311ljf.60.2018.08.28.02.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:23:35 -0700 (PDT)
Subject: Re: [PATCH] mac80211: fix to follow standard
To:     Yuan-Chi Pang <fu3mo6goo@gmail.com>, johannes@sipsolutions.net
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535423074-130862-1-git-send-email-fu3mo6goo@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <9cedcd76-2a05-00dd-2651-3b42d98a3692@cogentembedded.com>
Date:   Tue, 28 Aug 2018 12:23:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535423074-130862-1-git-send-email-fu3mo6goo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 8/28/2018 5:24 AM, Yuan-Chi Pang wrote:

> IEEE 802.11-2016 14.10.8.3 HWMP sequence numbering says:
> If it is a target mesh STA, it shall update its own HWMP SN to
> maximum (current HWMP SN, target HWMP SN in the PREQ element) + 1
> immediately before it generates a PREP element in response to a
> PREQ element.
> 
> Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>
> ---
>   net/mac80211/mesh_hwmp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
> index 35ad398..6c21a26 100644
> --- a/net/mac80211/mesh_hwmp.c
> +++ b/net/mac80211/mesh_hwmp.c
> @@ -572,6 +572,11 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
>   		forward = false;
>   		reply = true;
>   		target_metric = 0;
> +
> +		if (SN_GT(target_sn, ifmsh->sn)) {
> +			ifmsh->sn = target_sn;
> +		}

    No need for {} enclosing a single statement.

[...]

MBR, Sergei
