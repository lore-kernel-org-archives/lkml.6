Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8809BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C8D222D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="cWBbF337"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfBPIRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:17:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34674 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfBPIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:17:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so6911162lje.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 00:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UwKg6lAUAHmUWtD97HsnVvOS9TLzLzFe+nliVxQzXvY=;
        b=cWBbF337z7MXOvEzPl4MHbg2cmn8t1/44lAwKxtDd8GG3EOs7M6hs/WQ/wycPYfQYJ
         +yzLDripSaeRgXWnUbJvj/V4x/PxRN8Ma9ArY2HuYak5qgGaWGu6q+HJlpEiBKouAXPH
         6MkJniAN9DzGoeab5IDgkkPIbhDkRc//nUxbrSn0uGJ3CpjVNT1zLKX5Ynn7uOFybFR+
         lyTkn0E3uD2lmylVgE2Qzx01B97r6HwH8Hc8+ys7FOu9Av7brvubX+AXpMXSmv2LvbnH
         ddbhtRsZC5Uar63cg8FWAU8UFDsqhS4PpWMDKMewf9qjR2M6VsLZa8xreE2yqNTBH/fk
         qryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UwKg6lAUAHmUWtD97HsnVvOS9TLzLzFe+nliVxQzXvY=;
        b=fvkqXc9tdFjuTmgnTxU2P9N//JgSOoEOqzKevaT9Q0UK5ButBm4dra2yol+t/BRRFd
         EQdxvVbT8a85YZnv4YCPeRR2PgVH+5NsRGxgFqLBdVfDXrlNY3K8PIwciycuoEaGKecH
         BGA3l3m1fitLyCO7jPuGEIPAw2S7klIgXaqkaupyZ/1G1V+uqn9yEmi1SR5ZzpGF1BMQ
         JvDvv2rH0Ivd45dj0rvb9twWx1EBva3Tu5U7Mvu5A+d6Hv5+NwvgHQ9Vmy2/SQ9f2jGu
         pGGVoe3zWs5TgBy0jC16aypmY34X7VPzTo/yecFbQF1ZE66cAlR/urj+6H83uF3mgqvC
         iYQQ==
X-Gm-Message-State: AHQUAua8u/sJIiqaWlsTGzOJkrPuubVSTqRAuAq81M2HRrSDBEX052Jc
        yEJjPPlzy6pZXERWStpJqpukzQ==
X-Google-Smtp-Source: AHgI3Ia2ChMcnc5pS/c0XvtfS8cESMzFsgcV+danaID+WebIU86vji2bLiopd1dBqFy0xjwubfjGZw==
X-Received: by 2002:a2e:918d:: with SMTP id f13mr8755988ljg.151.1550305068669;
        Sat, 16 Feb 2019 00:17:48 -0800 (PST)
Received: from [192.168.0.199] ([31.173.80.82])
        by smtp.gmail.com with ESMTPSA id m25sm423952lfl.93.2019.02.16.00.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 00:17:47 -0800 (PST)
Subject: Re: [PATCH] net: mv643xx_eth: disable clk on error path in
 mv643xx_eth_shared_probe()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <1550265654-6626-1-git-send-email-khoroshilov@ispras.ru>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f736a332-a81f-2e1a-bc04-8870deac5065@cogentembedded.com>
Date:   Sat, 16 Feb 2019 11:17:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550265654-6626-1-git-send-email-khoroshilov@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.2019 0:20, Alexey Khoroshilov wrote:

> If mv643xx_eth_shared_of_probe() fails, mv643xx_eth_shared_probe()
> leaves clk undisabled.

    Enabled, that is? :-)

> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
[...]

MBR, Sergei
