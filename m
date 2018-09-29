Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25269C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 20:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9B0206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 20:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+/Qu1H7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9B0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeI3DHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 23:07:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32907 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbeI3DHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 23:07:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so6562196pfn.0;
        Sat, 29 Sep 2018 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=awZeOWUUJUFiOvMWD50ugWEZmOrrDPJgRdQk1h12lkc=;
        b=o+/Qu1H7IcVE1ERebPMGscgic9A4NLRFHUmSZjCafxmOuK0D4UPYkzN3KMx5Qsbkzk
         lT9KIFXl8c/m7p1mGbZKaYw5VH6pxylYSVQaQlPAsCy8H1H9otdXSHcdObuvBv3fa0+Q
         adjOC2kR42pvkiLxdl6tGWokCMKVunqm0XPblzgDwAUhVnLIOxMDl1Q/eGCZqsGVPJhE
         2WUCH5cd0zsbbpMwiIaM/mvQ+lbm3leNzDrbzUmNHZeunzhnr3o01ZrZNqLm4PfLKswR
         pZa7kl/YLEKyFK3MDUpUjdMu6jn4RkDvIJS0jow0QVS8Envu3QMwNekpF8J2F+LvH5uG
         X6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=awZeOWUUJUFiOvMWD50ugWEZmOrrDPJgRdQk1h12lkc=;
        b=HB6eEfKKF7OEZ0UR22wQ3845TdHgO4BwBZ3tX6twPBG0912hLnprWit0fKllpNGl5c
         /WAwq7HjzE1Zv2NFIBrQ/anjfF5/3SvzHmM7F6no+L7VM0ZmY5eyFqqynuLIlnyehhpH
         EzxvtcORe5i1lHYAuexWxWgevmJlIgEGZ4wei8sPZk2GFeqCE/lTvxaP2dGNtHT6NRn5
         QmQRLEEtz2sN548Jftiqjag070WQIKnyRHjbnXsyp0C8qT+ffqToH/Wl6I7dSUNkeUFx
         /LvXTeAC0EvDP///p/djnIU5epIUtSlFfhs9xjTyOlGiYGh1jdhFifyOZssCad+oCfEv
         EYSg==
X-Gm-Message-State: ABuFfog7lzVZEM9i7hc3pzWE0sGgYLVG4yDjGqpenCjFk9cquRdgh/9e
        2HMsEV7SQNDP3haTXaDuaYw=
X-Google-Smtp-Source: ACcGV619193Az7kvIPgzcM2UhOyQttOegeOWBVbUpSoVsbV6SJbTc+z/2vuG27qWLfDGCs9ra+JfcA==
X-Received: by 2002:a62:8a91:: with SMTP id o17-v6mr4498968pfk.184.1538253438024;
        Sat, 29 Sep 2018 13:37:18 -0700 (PDT)
Received: from [192.168.14.54] ([12.70.68.218])
        by smtp.gmail.com with ESMTPSA id s23-v6sm13930445pgg.67.2018.09.29.13.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 13:37:16 -0700 (PDT)
Date:   Sat, 29 Sep 2018 13:37:13 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMuHMdVgpf2b8gOeygij7MGjTwxgBv8-Y0M5ggBBhNE0pS07pA@mail.gmail.com>
References: <20180928223947.20751-1-f.fainelli@gmail.com> <CAMuHMdVgpf2b8gOeygij7MGjTwxgBv8-Y0M5ggBBhNE0pS07pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] i2c: brcmstb: Allow enabling the driver on DSL SoCs
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        M'boumba Cedric Madianga <cedric.madianga@gmail.com>,
        kramasub@codeaurora.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        eajames@linux.vnet.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        manivannan.sadhasivam@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <34253924-54D8-4CB1-822E-21123EB503CA@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 29, 2018 12:55:08 AM PDT, Geert Uytterhoeven <geert@linux-m68=
k=2Eorg> wrote:
>Hi Florian,
>
>On Sat, Sep 29, 2018 at 12:40 AM Florian Fainelli
><f=2Efainelli@gmail=2Ecom> wrote:
>> ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses
>the
>> same controller, make it possible to select the STB driver and update
>> the Kconfig and help text a bit=2E
>>
>> Signed-off-by: Florian Fainelli <f=2Efainelli@gmail=2Ecom>
>
>Thanks for your patch!
>
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -432,12 +432,13 @@ config I2C_BCM_KONA
>>           If you do not need KONA I2C interface, say N=2E
>>
>>  config I2C_BRCMSTB
>> -       tristate "BRCM Settop I2C controller"
>> -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>> +       tristate "BRCM Settop/DSL I2C controller"
>> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST || \
>> +                  ARCH_BCM_63XX
>
>I think it would be good to keep the "|| COMPILE_TEST" as the last
>dependency=2E

Makes sense, v2 coming, thank you!
--=20
Florian
