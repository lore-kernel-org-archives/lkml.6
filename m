Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24D5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982E021501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdr0Y7P4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982E021501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbeHBOv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:51:28 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39281 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbeHBOv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:51:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id m1-v6so1001993plt.6;
        Thu, 02 Aug 2018 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LLQSyWW3c/d9QVw2O0nU8deSZmFltLcDG7oBJpF2RPo=;
        b=Kdr0Y7P4RN1+SvLmBB2XgQGLCODcPto5nGbYJqRW+TXhS0Nod9X/RSxuwXmekDNl6Q
         tJqAZHAGed05cbvSFXapKxlLdHnx8NKdC9Mnc8h9YjfOVbH2E6Q4k5rd8eUhlZ4u0cED
         GZIObdzxj2ZkoaVgMAfwiO58l+61Jlc0kP1OEfaUVpvdLU2360ckSjhOyUr/+7yHKsaS
         A0AHQpM6LLyOUrS3ST22mtAWqXe417rWL6zBEFfuUZ4sF8oG/B4NK+U48UyJivRJQpiZ
         s80WOitr8JfrUlo/6qlf4xY2apftwCaJZPxK4IwENqyWuJ9BSBY2qM8M51OMlGQYpRti
         Bijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LLQSyWW3c/d9QVw2O0nU8deSZmFltLcDG7oBJpF2RPo=;
        b=nRpjkrAnESV3ZVqcme+y9EpypKkaUi/U/dfmA8RRiEU0/+ygraJmh6za831QWolWcR
         nqGsbhuE1qAbUgcb9hq+pR9tzCtJMtAl4uFZcI8gekfxkS8aISZbyP7zNAl9WZjNL5fc
         8GYS8kLHnXeWHJhXmRtRHF5QWdanEMxKcW/osfs787WhPh6caQ2iaCYsnTbVFzgQmz3Z
         7jcRsIOQT0PfLLil/Khc+XdViWFkPTRbSoaieuOcwQlzf5Qtkjv/Xm4pfihG33NtwYlo
         B17XXfx9A9NhXFfHCnXJcfQZ4v2ftZjTgzS3T++Cbqj0dXOh9F9gbkf6Li26jJoA5G/C
         +org==
X-Gm-Message-State: AOUpUlHYa4zL+d+J5GaHHXnDB0YEimsZHlf9GGwaXdVMLhZp4mnBv7+T
        /7fFwEHEYZJSJqKZpL/U/bR7JE0V
X-Google-Smtp-Source: AAOMgpcONuUqrQNmQhRivhsI0L/a8Un203pehOSx/d3RH9ZPsI//+1FWd7buHLoGH7MxtwJeJzc0Zg==
X-Received: by 2002:a17:902:b709:: with SMTP id d9-v6mr2350935pls.138.1533214821687;
        Thu, 02 Aug 2018 06:00:21 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r87-v6sm3519915pfb.1.2018.08.02.06.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 06:00:20 -0700 (PDT)
Subject: Re: linux-next: Tree for Aug 1
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
References: <20180801175852.36549130@canb.auug.org.au>
 <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com>
 <20180801234727.GA3762@roeck-us.net>
 <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
 <1533168205.3158.12.camel@HansenPartnership.com>
 <171b2cdc-2e74-2b3c-e5f5-c656a196601a@roeck-us.net>
 <e3e32fd801cb1270cddec6fc1ea3dabad4473b64.camel@wdc.com>
 <93cbb876-3a25-482a-a5b4-6e13d42ee535@roeck-us.net>
 <20180802125141.jyb2zz75jgrzibaq@linux-x5ow.site>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b1616769-b1d7-97c7-b197-9dc3d0f74a7b@roeck-us.net>
Date:   Thu, 2 Aug 2018 06:00:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802125141.jyb2zz75jgrzibaq@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 05:51 AM, Johannes Thumshirn wrote:
> On Thu, Aug 02, 2018 at 05:46:19AM -0700, Guenter Roeck wrote:
>> This is consistent across multiple test runs. In summary,
>>
>> - Boot from initrd fails
>> - Boot from SATA drive fails (this is with CONFIG_ATA)
>> - Boot from NVME fails
>> - Boot from USB drive fails
>> - Boot from MMC (SD) fails
>> - Boot from USB UAS drive passes
>> - Boot from various real SCSI drives passes
>>
>> Platform (pc,q35), CPU type, or SMP/NOSMP does not seem to make a difference.
> 
> OK. I try to bisect between next-20180727 (known good) and
> next-20180731 (known bad) with forced scsi_mod.use_blk_mq=1, but so
> far the only bad I've seen is next-20180731.
> 

Per my logs, next-20180730 is the first bad, next-20180727 is the last good.

Guenter
