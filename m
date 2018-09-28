Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170CBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6BE206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTDYcYma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6BE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeI2FHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:07:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45591 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeI2FHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:07:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id h6-v6so7977458eds.12;
        Fri, 28 Sep 2018 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9HAneqscgxRmyIPxTWk7qdAigmDI+TdnbpHMjwarxhQ=;
        b=mTDYcYma3l4RaQ3HsvUtl64RI7vyZd1CApDAna2zuoRFdFXHzHcMcsSvEu/Za++1co
         uj8GO926pVe1tRfXhDpWT1ki62ywRwQFvM1XVU89eFYe0A2LqRn0rUn/sKxmDqgPkSqK
         MKV470beFFkYBjPw5RLVTHF+DkdBKM42NTORoTGW1pnGoYj5atUzkzfOlkw/s0VHxNf5
         SWp87kzM8hecVmYYmmy1fYSWz0ArJAyJ0cPV8aNFmpTFpC+Mwtc/6LiltrcX6a/kvJvT
         QVLDVkncYfHLYMyzYbAgDgNsENFwe1qh624AkMnGQd+9jmGdduL1GAZ1QeXWAxYjyAxl
         /gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9HAneqscgxRmyIPxTWk7qdAigmDI+TdnbpHMjwarxhQ=;
        b=DLLWZ0r9FTZWnSvhzMdqpNdlvupQjZ8syVAEwPwgEGIjrML4AoKw04yK+23EILk5YU
         4LIv7re7B1hC/gEXtSeohAqgbE82g47BtyfAyWe8cnV7DkjGvfarzJvHlOFIVhCEFEsv
         xa4UwApSmIL8YYHt5dH7nq7zdfa+RMhF8kR12qaQ0wdLh381xL5ziwmnIiIiAkdGPXa5
         JjiLpZwrwQwgrXEKu7LH5cgfWix2tzoyllvCLMhRIn/dzcoJZu+pgd+5iRnVuVEF/Rx0
         P8M7qbGal/bnabSO6461+//ETZhqEwGnC6bP46pmdXBF8LPumwR3O482sBD0IF/icODg
         +t4g==
X-Gm-Message-State: ABuFfoiLirU+ua2uFXbaEfdKHcWpA59D/fzloTnEKqrhBvkQw2ONvBGD
        9sKH3A2faHD2MG1VgGG0b6a0889H
X-Google-Smtp-Source: ACcGV63QBzh7Y+4iekznbAv0/7LISIaSvC8jY191XM+rm40UwGPVJuMW4JoyENkYCST33Y42gwAklA==
X-Received: by 2002:a17:906:f1c4:: with SMTP id gx4-v6mr4663577ejb.44.1538174494590;
        Fri, 28 Sep 2018 15:41:34 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 38-v6sm1031474edz.33.2018.09.28.15.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:41:33 -0700 (PDT)
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
References: <20180920191646.18198-1-f.fainelli@gmail.com>
 <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
 <fa91f7eb-3405-4607-9391-f043b73e7af6@ti.com>
 <3d4b406b-4fa4-9248-a0ab-d4eeea808034@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <58d4992a-a06e-60e7-1856-5cd87741a771@gmail.com>
Date:   Fri, 28 Sep 2018 15:41:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3d4b406b-4fa4-9248-a0ab-d4eeea808034@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 09:12 AM, Florian Fainelli wrote:
> On 09/24/2018 11:19 PM, Kishon Vijay Abraham I wrote:
>>
>>
>> On Friday 21 September 2018 12:49 AM, Florian Fainelli wrote:
>>> On 09/20/2018 12:16 PM, Florian Fainelli wrote:
>>>> Hi Kishon, Tejun,
>>>>
>>>> This patch series adds support for the SATA AHCI and PHY found on the
>>>> ARM-basd BCM63138 DSL SoCs.
>>>>
>>>> It would probably make sense for patches 1-3 to go through Kishon's
>>>> tree, patches 4-7 through Tejun's tree, and I would be merging the last
>>>> two patches through the Broadcom ARM-SoC tree.
>>>>
>>>> Let me know if this is not a workable plan, thank you very much!
>>>
>>> Looks like I had left patches with the incorrect subject, please
>>> disregard the following patches:
>>>
>>> [PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built for
>>> DSL SoCs
>>> [PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to be used
>>> [PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings
>>>
>>> since they have incorrect/inconsistent titles, the other patches are
>>> fine though. Sorry about that.
>>
>> merged the first 3 patches to linux-phy tree.
> 
> Thanks a lot Kishon!

Tejun, are you good with picking up patches 4-7 and I take the last two?
Can you make sure you pick up the ones that contain "ahci_brcm" in their
subject, I had incorrectly formatted them initially, sorry again about that.

Thank you!
-- 
Florian
