Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 19:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E6520815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 19:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqhKdGhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E6520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeKRGJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:09:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36672 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRGJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:09:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so24392935otk.3;
        Sat, 17 Nov 2018 11:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ixQhn+oP2nSNDSflkp1f+ch9IdWJwhyZzpqumAzH0Vc=;
        b=MqhKdGhiAXFHetQwooWX/E35NGhA6btLDqDeNOLG+aH4z24eddk2UIEP6SztuztoVL
         xfw+5Tajwp8imz6Om41boO3pEPAR96KfggNHUSetCChi4Q5FXxoYIguEwgdNsssU2SCP
         SVZUPIxgtjT7SqLxVTx9EN6SRFoVkFSpC9riwzskFtj3uJkkIzNQHLbmbh3gDIa00G0x
         5bim4IzHDDpsOGIQjRKpqxaRP9hwtcQZX355SBYmuwEQ62j/KEdBQO2/SOjAvvp6wpQv
         ln67u2K4ZKP2ttoz9XOTKh8Qs6SX37nkq8Ej5NvhGfWGPKZLgMRz4dKb1mSGcxDOOJtH
         H9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ixQhn+oP2nSNDSflkp1f+ch9IdWJwhyZzpqumAzH0Vc=;
        b=rHm/FmVLVxJnZ3xJmmoExHP+zyFM8rUvbEys8IFS1OMQmkkrwoH0C2aYvYhW4O/4hP
         sUlaNGJ15ViATjTc7Ac+F41laHfpWklAPYGx9OxH3afQPvzvplJxV55wxKa47emjMO5g
         a1lrdr/5l4afbOU1VcCDH0G/wQ9/DKO1YMzdJf3hSOu8G9Cv1p/h/3dEyHHExiur8+LK
         2nUwdGs5qL0NGrGIvpynMqM1zKGxOyxoMdmgrAw+35sN3McD2X3vZF+gsMNJIE3QqZJZ
         4q7t7uSe07iwgtfHMMlsNFvrqSUmN5iciTPdiuu6T2ZqWU+TDJ3AIY23vo534AwcW2eI
         o8ew==
X-Gm-Message-State: AGRZ1gJcH8ioYP3zwrHC8Qh0EXQ9kGpmYEWcBvplpK/9S/ntYK6kgxkd
        Q12QW5aHB0FcId0FTOc348k=
X-Google-Smtp-Source: AJdET5e2+NeWypOQQu4G2+1hr5nbj8rohTCXtvqXSN4ZWfreQlC+eIrkwHm+l7IcBiTdw7I8ypRlcQ==
X-Received: by 2002:a9d:5a81:: with SMTP id w1mr9948600oth.317.1542484315791;
        Sat, 17 Nov 2018 11:51:55 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id 21sm1290154oie.24.2018.11.17.11.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 11:51:54 -0800 (PST)
Subject: Re: [PATCH net-next 1/2] net: bcmgenet: code movement
To:     Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
References: <1542420022-30251-1-git-send-email-opendmb@gmail.com>
 <1542420022-30251-2-git-send-email-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e6d154ea-2551-375b-fee8-f7aeb5a3d63d@gmail.com>
Date:   Sat, 17 Nov 2018 11:51:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542420022-30251-2-git-send-email-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2018 18:00, Doug Berger wrote:
> This commit switches the order of bcmgenet_suspend and bcmgenet_resume
> in the file to prevent the need for a forward declaration in the next
> commit and to make the review of that commit easier.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
