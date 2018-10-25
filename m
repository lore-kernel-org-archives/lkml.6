Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9389C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A70C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDtK7VvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A70C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJZDKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:10:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32911 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZDKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:10:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id w16-v6so5474680lfc.0;
        Thu, 25 Oct 2018 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjLdkWO5kl/kAahCNxU5ssT8CxsXjMsr5ouBEuduAnI=;
        b=fDtK7VvIVMMg3tiQUwlvtJQD50x/qCv7kzBoqov72Qx9TCa/8g4B8KGQLqcMekiktY
         s0/VrjDlQ3VaK59YZfZy5t5h1K/GTAf0Kt7EG4dt4zZS3j2qNSTsdXknjDQ9heg73VfK
         LJ+D7ivFuIlaV6koOB0G0rQ9KJBgy4Zsi0fBH9h5T0Mn6OL2l0RLKIVbguYYC6r6+JYi
         V5fCNM4t8LOSQ3sXcWYbO+hkMOctetJ8XVYM1bVd08yEHV0mN45WnBgu/LPMDJ4NYqWY
         9P9zGvtYYbpqCQeKX0/BNL8ck6i7rX98FdOcOkMtw5RVTui1NbxJexyw12bq53BqAiZO
         n/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjLdkWO5kl/kAahCNxU5ssT8CxsXjMsr5ouBEuduAnI=;
        b=KHMItqFzK7CTZ8P6LIJmxFl7C3sEVMcxJlJ5F/CE4xo+MBwlMk5dN7ytdOtf9Mo9/b
         PGjz92E1hMElOo1jYbsE/HeCQL7cce94dl5okVXg2JPALGwLoJ+E+PvI8u5OxCG6wQEo
         Wf9di2iTeIL6dp770oE/1EI9RKNGrw1biIeK+Pq0zbbkvYyqUQQUJ0a8Hy1rVrYkRVWR
         B5QSwYfGkFdM4e6BKwtxDCxlrl5TKBi/KWaCws+Q3YZLjVPeKy+b+hx2lQmbv1PUUdyW
         4iUDfNHiytLehDT8OEPpI6SEKBKr1uVFJvV722+78zHL4GHg4eNFe1v87swOD7/vCCry
         8BwQ==
X-Gm-Message-State: AGRZ1gIRjg3olrUaWsLkrhr1S7FvJesoZ6FPaobpAcY4j6ewp+pYJhxc
        4sFYIVR0xK511aElzzoxzIPwNEO/
X-Google-Smtp-Source: AJdET5e4bKNVoJ2q8DC9tyHnpSFP2UTXnrS4uXp5ajXJG/ICq1UdsMlpmaRnsZ1my/sWhP0Hbco/MA==
X-Received: by 2002:a19:4c02:: with SMTP id z2-v6mr228824lfa.48.1540492596114;
        Thu, 25 Oct 2018 11:36:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id v13-v6sm1464840lfb.70.2018.10.25.11.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:36:35 -0700 (PDT)
Subject: Re: [PATCH v6 8/8] memory: tegra: Introduce Tegra20 EMC driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-9-digetx@gmail.com> <20181025143853.GL21521@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <221ac544-b57a-e85f-79ac-0b914615c9a9@gmail.com>
Date:   Thu, 25 Oct 2018 21:36:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181025143853.GL21521@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 5:38 PM, Thierry Reding wrote:
> On Sun, Oct 21, 2018 at 09:30:52PM +0300, Dmitry Osipenko wrote:
>> Introduce driver for the External Memory Controller (EMC) found on Tegra20
>> chips, which controls the external DRAM on the board. The purpose of this
>> driver is to program memory timing for external memory on the EMC clock
>> rate change.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> ---
>>  drivers/memory/tegra/Kconfig       |  10 +
>>  drivers/memory/tegra/Makefile      |   1 +
>>  drivers/memory/tegra/tegra20-emc.c | 591 +++++++++++++++++++++++++++++
>>  3 files changed, 602 insertions(+)
>>  create mode 100644 drivers/memory/tegra/tegra20-emc.c
> 
> Applied to for-4.21/memory, thanks.

Thank you! 

> Though I did notice that there's quite a bit of code that's very similar
> between this and the existing Tegra124 driver, so I wonder if we can do
> a pass over them and refactor some of it as a follow-up.
I don't think this will really worth the effort.
