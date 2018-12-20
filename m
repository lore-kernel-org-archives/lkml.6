Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26530217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V5w+19Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbeLTSBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:01:46 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43384 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbeLTSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:01:45 -0500
Received: by mail-io1-f67.google.com with SMTP id g17so205509ioc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AyBdSrvRm/wXdYjkLX3yiCw+a2axnClN0AxiBCiOLEY=;
        b=V5w+19DiqFjF82f9mJOguqNmB5ULUfX3NSO9Gd4pmcWo1o/0sNsADluJ90Ui1MIJPG
         xvcrSJDG4rTvfsF3XIPNrHSVpt7Hb4XmyGSlJUT0gZCtvgLN+j2NtLiLJ/tWYdFNAf0l
         vNUuJMI1ZcrhfL4nAN1Bovquu54dl+BikazqIhA3ZLEMSrwkl/CUjYVrF5V/SdlkXvFQ
         IIm6IDIqUNNvJDhSZfxJ9BKP1Q8h4YPAea0EIm8NXeJo7nmepZgpVOmVAHCq84Z90B0T
         iPeqWxO6r64toNmyGjl4+Hs2cfDgHMUffen2w5iHQ7tASGF4/OcbhnIsZ3gf6+RTMsEw
         HoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AyBdSrvRm/wXdYjkLX3yiCw+a2axnClN0AxiBCiOLEY=;
        b=m8TMeSkF9VSEWVFzVNLKRRNgwa5yMy1cy7+3lE/rOj1sYx31IfacOEnL4vzFS0Ivp7
         s2631BSpH2trKVbxb0hQenI5Hrus/1EZrwiFihw8zzQpJuV2LI7H2/smySIslinDrrh0
         7yDARHFr3FlNgCnsoK6x2RBs66trQpg/fDmymXK8dC98idyeMOUBl95cJey4Y73kjzWF
         b/AD5ELjLHsVoNKpo02Atz8/pK53Vc/ONoLn8b5vf+JgACjlRV5iv/KfVhlIbv22rLeD
         Xm9GUnaIF597W565XMY4eTpiT8mk6WFxxgzE5M5fWSrybZL8oR7WvYGfsM2brj9HPjRt
         MBJQ==
X-Gm-Message-State: AA+aEWatk5UYVoU2L0uSQFT7S7kz5APh66xJJB1+wTO1Q/mh6TCGYh2z
        c0l4tXZbviqBLSquFllhgmXl83V+AtI0MQ==
X-Google-Smtp-Source: AFSGD/Xdns9FRVRuLIYrLuo6ErtHwQg/grhogJe4no8pEK3KT+VNsBGiXQg0YnQI0iiIBHBubX0COw==
X-Received: by 2002:a6b:9355:: with SMTP id v82mr22437020iod.40.1545328903923;
        Thu, 20 Dec 2018 10:01:43 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k7sm383400iop.0.2018.12.20.10.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:01:37 -0800 (PST)
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20181121130510epcas3p4498edc67a02f61a6aa8e55efa9349681@epcas3p4.samsung.com>
 <20181121130439.22255-1-tiny.windzz@gmail.com>
 <b3331d3f-3bfd-f3ce-cea1-30c4b13e6374@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a925d66a-09ea-b6db-8043-df58548da192@kernel.dk>
Date:   Thu, 20 Dec 2018 11:01:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b3331d3f-3bfd-f3ce-cea1-30c4b13e6374@samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 10:03 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 11/21/2018 02:04 PM, Yangtao Li wrote:
>> of_find_node_by_path() acquires a reference to the node
>> returned by it and that reference needs to be dropped by its caller.
>> bl_idle_init() doesn't do that, so fix it.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Yangtao, were you going to resend this one?

-- 
Jens Axboe

