Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F997C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E158E20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YYCbkuuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E158E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967148AbeFSQMD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:12:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33600 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966661AbeFSQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:11:59 -0400
Received: by mail-io0-f193.google.com with SMTP id d185-v6so733802ioe.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0E/HdTpBUqErhsAm+CTxZqHkr/R4BC2BSk+pEx5CcMo=;
        b=YYCbkuuFxvwYfULe2Kj0rzNLxHxBwaGL2KRmeLZ4nSrXPSD3cCBH/Fc1ZYllu8w+rn
         ODaRa2TAamVipZDpvn2I+VRm44NI2NamARh3gQaZXcO2NBsL2hIi4SwrWrHaKPjhIFNu
         06N1QI3uXOfndElxUcJ8EHosOKQxIS9Ed0NIWniO/ORTuhXE3cpXuEysMkAWinIcx9hE
         Xom8fpmL7sTm7JfRt40DCibSsxgy1SP9ho8l4rRSwqc7zTAGYVOc+eY3Tc+490fuIpa2
         6ujpfb3FJVSLhtQDvlFGGzu0ox5Eu8Ng4mcgxRZEnRhL21TYJEScp0eehxHmRet6kmAn
         Dr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0E/HdTpBUqErhsAm+CTxZqHkr/R4BC2BSk+pEx5CcMo=;
        b=WiVUtpHFqGOYUWxMvrnePinYVC83TwTdVoIKqAezngTS0a2OwJ80M1Be2S/MR/25q2
         mn7lTYSc+AxMmv38y/vkvs6EloT52XVKyIaSY4DPLqruZDFh4p7fQr4qxUnoHurMbvpv
         1gtphjVQLLUoZt7e2lANSp0dDHoddSX5zyl+IVI5g0KZUgeA+hbTGMhOZ1aTlPHJLMLp
         ViWpFPnGTOBeYJ/bsn7uweTTJH1Q+VkhTeRhaxKf2oXacyrW3xm6Hsn6/eIwhRQERAIU
         gn4WdwzRm8kqzo4QplloG7TFmsN+V6Zc+/VM9S5nc0lu9DQo4dM2XMsXxeQ+JWZtDMEq
         wnkQ==
X-Gm-Message-State: APt69E3vrDZuMN3FgtbDQR3fzTG1ppjLeOfLkUecIQgFpMR/Q29rfBi8
        9B3p5nc3nb8cM/bARh0p+x3Xf7UR2PmaWDnp9E0+prrD
X-Google-Smtp-Source: ADUXVKLp5AT/I0Z//VgRkV3IZICxtTDivGDFTKWPe0MHAPnE6XlTZaK1ExO5JU+O/KOJ3Mr/6fMum3ifeLQB9ad84y4=
X-Received: by 2002:a6b:c80f:: with SMTP id y15-v6mr13982218iof.187.1529424718971;
 Tue, 19 Jun 2018 09:11:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 09:11:58
 -0700 (PDT)
In-Reply-To: <20180619135219.GA7312@wunner.de>
References: <20180619124400.11878-1-brgl@bgdev.pl> <20180619135219.GA7312@wunner.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Jun 2018 18:11:58 +0200
Message-ID: <CAMRc=MdR_3aEk+8v5hV45k3hkCR16K6NGr8VNQ93DOyLrYq4yw@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: fix suspend/resume in davinci_emac
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-19 15:52 GMT+02:00 Lukas Wunner <lukas@wunner.de>:
> On Tue, Jun 19, 2018 at 02:44:00PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This patch reverts commit 3243ff2a05ec ("net: ethernet: davinci_emac:
>> Deduplicate bus_find_device() by name matching") and adds a comment
>> which should stop anyone from reintroducing the same "fix" in the future.
>>
>> We can't use bus_find_device_by_name() here because the device name is
>> not guaranteed to be 'davinci_mdio'. On some systems it can be
>> 'davinci_mdio.0' so we need to use strncmp() against the first part of
>> the string to correctly match it.
>>
>> Fixes: 3243ff2a05ec ("net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Acked-by: Lukas Wunner <lukas@wunner.de>
>
> My apologies Bartosz, it wasn't clear to me that the driver deliberately
> only matched against the prefix of the name.  Sorry for the breakage.
>

No issue. I submitted a follow-up series with additional changes
required to make suspend/resume work. Please leave your Acked-by there
as well as I forgot to pick it up.

Thanks in advance,
Bartosz Golaszewski
