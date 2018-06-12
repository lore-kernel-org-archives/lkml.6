Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D941DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC9A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX+WEYQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC9A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933934AbeFLNqc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:46:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39371 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933228AbeFLNqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:46:30 -0400
Received: by mail-oi0-f66.google.com with SMTP id t22-v6so21136951oih.6;
        Tue, 12 Jun 2018 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m+1IZgUTfR9tXW6jxWQEO0Juc4VyWTra852j/2UchTc=;
        b=IX+WEYQXJWtELNrwxP1fuJhaMKU6N3cd/zaSaQxiKU1q7MLWLE0SnCbeR4AYfiFil3
         zr82uJl7ANCmUtECv2sX5z4EABK6CA8swk6dZcC9GQc3KahYBbBAI2QyHRU1v5pWpT+N
         xQNUawMKolZtDAsygil7R7kN2Tdt3vpYql0v6WI5heZlI2jVFDfj4vWhwG+KVgOarlOi
         qiVbkjwp1tgrGc+0MazOWfcUnWzr4e1R34UnVkQ+vykHjCpyOr7DTmbtdVW0/2P64Jdt
         7yyKUn7Q+liI51gbz5StkNwoRYC8MTqWT79Tu1q4Uxv59BwSZFa35OjNB1Qc7EbpfVCp
         m35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m+1IZgUTfR9tXW6jxWQEO0Juc4VyWTra852j/2UchTc=;
        b=rwlmCN7rU+cVxbbaQhCVoJyw+83YI1dgObh5gBSj7mTDUhMR0phixDCFVM6PYRqqi4
         sR2dvEkphJz1Lh4qmBoMBuKDqay+f2vjjffCPFafdqlwjTJ1vsL57ck0xE6bTUo6OmWm
         fceg9PZhBuzH7YzOTT7Up3iDlL+TPEs0LyXD+6c1pI+Tm7TbtMf9fPRxl0J5wmfXC43W
         MHIQYviWdb0UUWHPrcPEI0i540EMrX+5aI4jvnYuJ0RgPbe/ORWWCgKs0l09n54oUNGj
         5xN45Nww0WB4uN7rWhh0vTj0o+iBvqIp+5eP66DupObpKyF4KbfQw9OmtkqFgG+G8yDy
         UH7A==
X-Gm-Message-State: APt69E0kOpMlGKyRRk3/SpgvcptY/UXUb5mSP8Ly9GIhQUR6m6VROJWr
        cKlkqfwHbhzlR5zjOtQKTByeH3bkj1fbVJyOqzY=
X-Google-Smtp-Source: ADUXVKKwui9y57Yn7iS4Ijqg14wZ/NA4PrSC0FxhRdRKTvtxxtp8C0Ajbsk6CH/Im9jc+Mf1SF5PTwogdPqeytNMUOs=
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr2083824oii.198.1528811189381;
 Tue, 12 Jun 2018 06:46:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 06:46:28
 -0700 (PDT)
In-Reply-To: <20180611052608.GB16091@dragon>
References: <20180517191923.16212-1-nikita.yoush@cogentembedded.com> <20180611052608.GB16091@dragon>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Jun 2018 10:46:28 -0300
Message-ID: <CAOMZO5AHbPOS_3ShrMAoiXMxRWR6M16khDZM_9V4mRxM2MbnGQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: add rave-sp subdevices
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marco Franchi <marcofrk@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Mon, Jun 11, 2018 at 2:26 AM, Shawn Guo <shawnguo@kernel.org> wrote:

>> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
>> index 0c99ac04ad08..98cc107098e0 100644
>> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
>> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
>> @@ -581,6 +581,14 @@
>>               watchdog {
>>                       compatible = "zii,rave-sp-watchdog";
>>               };
>> +
>> +             backlight {
>> +                     compatible = "zii,rave-sp-backlight";
>> +             };
>> +
>> +             pwrbutton {
>> +                     compatible = "zii,rave-sp-pwrbutton";
>> +             };
>
> Where are these compatibles documented?

Currently they are documented in linux-next at:

Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt

They should land in 4.18-rc1.
