Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 73466C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F0320693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHoZ4KIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F0320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933385AbeFLFlf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:41:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46158 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933315AbeFLFl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:41:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id h79-v6so19985509oig.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tJ4jdwvPUrp3AeUGyA8/sIBOF/VP5L9MvL+gcMiCWAc=;
        b=UHoZ4KIvekNSRvpnDBprHsqL0BKaWpWkWS7Yt7khsiZxyV3CbMNwRt9pzwoShTDyuE
         fIoXJX5WWwu3Bgu9eY+rD9ifaT4VOQJ/JNiCcOoEkxn0TUUFBcm/p8qT4WxgZD5hc7cb
         xInj6WxTjJgO0RlgNi8sY/EHLbz/Hzk+KFIfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tJ4jdwvPUrp3AeUGyA8/sIBOF/VP5L9MvL+gcMiCWAc=;
        b=qxBm+uVx7CAkmYZO6hr77qVPJT99K/5e0EfY+jK/x4qxW2125lyA7IVv0w9XqDPIpj
         mqXl2NzWfOnH703usMnxxyU1iS6jgsoFTZt4FL8HnMMyWZs6MzcdcLAHhW/eCvqTLYiN
         soZIFdNCQKg2j9ujXhlCzDxqiAjPucd61WTjBm2eMdjh/Yj6Yd+fWDJLLo8o85tUzRQu
         ECze8m2lR3jO4461uIwANJJdsOTo0OUDLljvt9VVhuvgAypS5D7fvM6IJ2JIzpi1pxYf
         62fL69KL9fTChWahh+/Y8QkOL6Jayfcy2KQgisgtrDH+Bx+611jKx9n2y4VNgIE2VGhJ
         varw==
X-Gm-Message-State: APt69E2V4RJ4Xeb93onRR8baogXh/R2znWRJphUsO326SurD1QMnZjo8
        JcnmvtkGRiung8iGi7bmYMzuGHAVv5oQVFsbsgCg1A==
X-Google-Smtp-Source: ADUXVKKWtulYLt1xE7hW+jf0Of+KDbNxq39zQ9EpGunv4NDlaO2eRlLR0XmjlU7TeA9fl9ge1eW8YbHNrimjmbHpLP0=
X-Received: by 2002:aca:60c4:: with SMTP id u187-v6mr1080648oib.177.1528782087986;
 Mon, 11 Jun 2018 22:41:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d44:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 22:41:27
 -0700 (PDT)
In-Reply-To: <70fffa09-5c70-be61-49b8-e78015fff547@infradead.org>
References: <0a5444dd0646f4e1f1d8ce51870afe6cc864219e.1528780670.git.baolin.wang@linaro.org>
 <0ebf526fa755231c8871a57baab641cebaed7820.1528780670.git.baolin.wang@linaro.org>
 <70fffa09-5c70-be61-49b8-e78015fff547@infradead.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 12 Jun 2018 13:41:27 +0800
Message-ID: <CAMz4kuKmDYBgtqNfWtbB+vLAufR1r7oXtEZGp76H8cyWONyxfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvmem: Add Spreadtrum SC27XX efuse support
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, freeman.liu@spreadtrum.com,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 12 June 2018 at 13:27, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 06/11/2018 10:24 PM, Baolin Wang wrote:
>> From: Freeman Liu <freeman.liu@spreadtrum.com>
>>
>> This patch add the efuse driver which is embeded in Spreadtrum SC27XX
>> series PMICs. The sc27xx efuse contains 32 blocks and each block's
>> data width is 16 bits.
>>
>> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/nvmem/Kconfig        |   11 ++
>>  drivers/nvmem/Makefile       |    3 +-
>>  drivers/nvmem/sc27xx-efuse.c |  263 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 276 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/nvmem/sc27xx-efuse.c
>>
>> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
>> index 54a3c29..3dca608 100644
>> --- a/drivers/nvmem/Kconfig
>> +++ b/drivers/nvmem/Kconfig
>> @@ -181,4 +181,15 @@ config RAVE_SP_EEPROM
>>       help
>>         Say y here to enable Rave SP EEPROM support.
>>
>> +config SC27XX_EFUSE
>> +     tristate "Spreadtrum SC27XX eFuse Support"
>> +     depends on MFD_SC27XX_PMIC || COMPILE_TEST
>> +     depends on HAS_IOMEM
>> +     help
>> +       This is a simple drive to dump specified values of Spreadtrum
>
>                            driver

Sorry for the typo and will fix in next version. Thanks.

-- 
Baolin.wang
Best Regards
