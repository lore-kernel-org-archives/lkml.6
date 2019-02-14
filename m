Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B923DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF2F222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="FVdSqcUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbfBNJN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:13:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34423 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfBNJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:13:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id l5so1153698lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7GxNjqQBu79dZwNGLXUWieDcr/g08J3T4LacRdZmsK0=;
        b=FVdSqcUkXAW/B+2dIDAKIkYMPkbBN2d57b7exbGprpsILErKuaQSJ/q6buCCFhuUZD
         nly4zlhvJ/AR4np/YGRPt2hHW7xzZHFjoWvDlCmUKJkMN1kLO3fLmSlM3hx4Lzym7L0x
         d9JQSjbNURwYJT4iZyIaKqrnaA+03BtY3NUTCvJyXH6Clr5Et0TUlO8ARk8CzGebrnLw
         BlJR1V4vJ3QHHgZ4Rb0WS/5sWD5+dSCeX4AuZDNLSCtkiOKS+U8fPRhoLHbz81pDA//d
         Dp3ukRhfYQtAP9LKiF5avrY4x7TirMpDWoc8YAm02pa/Y3f365S2kKtcewCPx11nyDa8
         x73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7GxNjqQBu79dZwNGLXUWieDcr/g08J3T4LacRdZmsK0=;
        b=jhjDYiCYWle680CBy9N8a8wO2fcFFztI0AiXnihSUpl0OanZ94YxtmvbdMT//jTIad
         vzJmepPq1Nk7BIj5z+2nG2gZxgpqFKKi0QInllD0gTPnJPvW03yXtJitwc0WLzhGrnzc
         1JOpO8e0ShgauEIObwua9BRvM36G9DlpDEEfTnc6nH1I5OHxlk+5xI88o9i3OsW5Izsd
         oOlnSohiZInsEw2Iwe4dvXBQIsqHBTfHjhURmxpzqkgjQ8DTkKa3CmO7jsa20HBpqckx
         Y3iJ1dx+ybcQGDDFnFXZ6WJQ5nZFrHwZo2INueekdHs5JEnuhJkBoBNcYRAA4LBtRR3B
         tGrw==
X-Gm-Message-State: AHQUAuaj7+wZFKZF7QkCjvvx+k2JpCOEH6CI4QWG3ZsNlaDu/5jQg2qM
        olWnNd7jQuyco5sUei7Y+l76aA==
X-Google-Smtp-Source: AHgI3IbflHxZ0yoXKAnLtMcfCYl9J8iToGG9a1Gb7EkoLkwrQ5Fl62SD9gZpmH9VWqLIMxj2NY39jg==
X-Received: by 2002:a2e:8803:: with SMTP id x3mr1620416ljh.27.1550135605399;
        Thu, 14 Feb 2019 01:13:25 -0800 (PST)
Received: from [192.168.0.199] ([31.173.84.50])
        by smtp.gmail.com with ESMTPSA id f140sm353688lff.41.2019.02.14.01.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 01:13:19 -0800 (PST)
Subject: Re: [PATCH 2/2] net: Replace dev_kfree_skb_any by dev_consume_skb_any
To:     Huang Zijiang <huang.zijiang@zte.com.cn>,
        linux-net-drivers@solarflare.com
Cc:     ecree@solarflare.com, bkenward@solarflare.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn
References: <1550126533-28462-1-git-send-email-huang.zijiang@zte.com.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <c523a131-3177-00d8-099f-023c949d6932@cogentembedded.com>
Date:   Thu, 14 Feb 2019 12:13:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550126533-28462-1-git-send-email-huang.zijiang@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 14.02.2019 9:42, Huang Zijiang wrote:

> The skb should be freed by dev_consume_skb_any() efx_tx_tso_fallback()
                                                   ^ in?

> when skb is still used. The skb is be replaced by segments, so the
                                   ^^ will?

> original skb should be consumed(not drop).
> 
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
[...]

MBR, Sergei
