Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA86AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6433D2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u33Zxmww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6433D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeHaHTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 03:19:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43158 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeHaHTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 03:19:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so9797418wre.10;
        Thu, 30 Aug 2018 20:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=prmcs1ybNaRt7vVURutttZfZqHiXQBn2K1Q2wJXCB5Q=;
        b=u33ZxmwwFP0tMuouZIr47FFDvJ2J3NdvOz/H791hftWedM15Hr9fuZYqg0wzjsmOcS
         gkb9NNiES8FEMX5Mi437pGK1ex4EHEihuOhf6cVTP7JV6k22y8kCsbHZf7kGicfnPRUG
         N08KbnqVJe7LEX9dCX9Bnrflehx+/iUOXEd4IhlMf39cpMia9c8Iphf8LrYK99LwmMyy
         TSDvaW6Md0XbDZuW9TSW6dmeHeSkhxxa3G/oKs2AmleEqtHjvvsBBveFGA3GatTY5W/m
         6Nqgr0sh9G5TXnF7PMeSXtH519u5/smOFIFFsezrMrbcH0dfPjwjmhIRX63ue5fpW/gi
         FLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=prmcs1ybNaRt7vVURutttZfZqHiXQBn2K1Q2wJXCB5Q=;
        b=C866ePgRUMCjADWOC+bDmLTtnJ0O9rHMUYf5Oi7vOvfZZ2X212Cl4umu5/oEwqnANF
         hPU2uMdET9SR7jpp7rfnRPbFytWje7SQCsT7M647Nbh2hd/bNg3JTv4i5yig+33X+h1e
         L0G9oc7/ASLo27xl2X+jLAH1cMjw7itBbAX8pTfDmg6uLe8LjfWN8sr8Rr1umS1VcxGb
         8TbYJqXy5GE3K4kvGDDeYyaS9cGRDyCTmwMRIdOTA7pO/SySCxbvtia56+/9aOFkzxhs
         sQDp7cnNRf3GGduEG6Nw7+JJT91Q4fesSmzcfy/damrdoYMPJ7xnKXMu8qw7ba3bHP5D
         5PHA==
X-Gm-Message-State: APzg51DjKBFRUrZt2vTcHnqr9FwdfbLnj2mMlYjRWGdF52svQnmJ7naG
        nWFkgyHN5u2841prPOAODoY=
X-Google-Smtp-Source: ANB0VdbFqcUTaH6TfDZupL4N5QM2Gxi4pDwSDnQt5XcosT4Z5rqzoY6fKbxor+VHBIOlzPIB+YZxHw==
X-Received: by 2002:a5d:5248:: with SMTP id p8-v6mr9432799wrv.198.1535685268720;
        Thu, 30 Aug 2018 20:14:28 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id a9-v6sm3898919wmf.28.2018.08.30.20.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 20:14:27 -0700 (PDT)
Subject: Re: [PATCH 0/2] ARM: dts: socfpga: Add support for PMU on
 Arria5/Cyclone5
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Florian Vaussard <florian.vaussard@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Alberto Dassatti <alberto.dassatti@heig-vd.ch>,
        linux-kernel@vger.kernel.org,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1488297132-21553-1-git-send-email-florian.vaussard@heig-vd.ch>
 <d723d5df-a700-3781-e8a5-4e57185585f8@kernel.org>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b575b848-ffaa-43cd-ee70-8538ede3eca8@gmail.com>
Date:   Fri, 31 Aug 2018 05:06:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d723d5df-a700-3781-e8a5-4e57185585f8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2017 04:19 PM, Dinh Nguyen wrote:
> 
> 
> On 02/28/2017 09:52 AM, Florian Vaussard wrote:
>> Hi,
>>
>> These patches add suport for ARM Performance Monitor Units on Arria5 and
>> Cyclone5 SoCFPGA. This was tested on a Cyclone 5 SoC DK board.
>>
>> Side note: the same change can be probably applied to Arria10 as well,
>> but we do not have the hardware here to test.
>>
>> Regards,
>> Florian
>>
>> Florian Vaussard (2):
>>   ARM: dts: socfpga: Add labels for CPU nodes
>>   ARM: dts: socfpga: Add support for PMU
>>
>>  arch/arm/boot/dts/socfpga.dtsi | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
> 
> Applied!

I have to wonder how this was tested. I tried this on 4.14.y, but when I
do "perf record -e cycles", I get no samples. Moreover, when I check the
PMU interrupts, "grep pmu /proc/interrupts", it shows 0 interrupts from
the ARM PMU all the time.

Why am I not getting any PMU interrupts when using perf ?

-- 
Best regards,
Marek Vasut
