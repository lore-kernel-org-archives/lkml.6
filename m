Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A60AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1915220854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZUqJFy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1915220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeILS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:56:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44434 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILS4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:56:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id l82-v6so3773323oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BaSLFX2lpr69rLdyiRrdXU+tOD7HdC1lnJUvOJTGH80=;
        b=BZUqJFy4NYM7jAbDnwfaOFK7phxmifV6IcPnWdX0L6g6ayU0u1aYBdA/oT24cYPnmj
         drgNHslcZthlGV2hkFs8M8tSuvdTsrUy/WO2/+RIZ7VGFvSYt8R3gXlexNfOVmBvUU9k
         8D/ZhbVMEOhbQLiKzltZyF6zzB60C3pFMQWhRp3msXXADFeRo/8mpeOHTnvS7t4EhbMA
         KAyrsRZ5dcSaxQOK6/T7O+FUmEBhYWZu8GVZZcwqL9xWIwZZOjWeswLfNLdbOy3JS7KS
         FhWi79i/ijMu3Zbwe2hbY6VfWqoDTTXga/KS5i1VPDa0zECfmEdkCqHifkT4HvgRbydR
         v6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BaSLFX2lpr69rLdyiRrdXU+tOD7HdC1lnJUvOJTGH80=;
        b=Tc8c8OSW2208Ck1wlv23x2XcVRZDdGvKgpJ/M21Oiqw21f06eO6NiRDBOrAiTmBNC0
         XCYthoUwvad8DjGX6JxVkQuJEYXCmqNJHHqf5GS2rOsNBHbhOOrcW9wSEZ7fSPOhrUqd
         r2D2qNSBxYBUHYz2co8E0jF1trUInsoQzKWRp3Xsl/Yu6voY1R9JjYdnLPYIDHzSX8lZ
         d8rmfwWKXDCuU+vCNdJd6tvnZcxxyN0NLuvpypT90Ys92HPjl1h71b2T+Up5Q3rILfp7
         IdxjQXt6IJGTeM9Wb5W70cU0mlCvqsx0cW2zn1PfGCRQpcn/1WwvfK27yJ31xIL7QBKt
         HONQ==
X-Gm-Message-State: APzg51Aq1TpOB3eXCX44eiYar4Ogcxb8Amt77GfNH186sU3lKVB7V0rm
        AFfRb16/FQea/CFmMo82f06PBkIBDsglvCZhVPI=
X-Google-Smtp-Source: ANB0VdaH6726HSfWxyYhccP+zPaImFYUg0+6psru0HaI486jcbVovtkohTuZFG2lKzCvNec1WJsGn/ti+3yjySiohdY=
X-Received: by 2002:aca:bdc4:: with SMTP id n187-v6mr2029393oif.3.1536760294014;
 Wed, 12 Sep 2018 06:51:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:cca:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 06:51:33 -0700 (PDT)
In-Reply-To: <AM6PR04MB51581BE201C12160B7A7CC5AE31B0@AM6PR04MB5158.eurprd04.prod.outlook.com>
References: <20180823074918.641878835@linuxfoundation.org> <20180823074921.706703657@linuxfoundation.org>
 <1536694015.3024.141.camel@codethink.co.uk> <AM6PR04MB51581BE201C12160B7A7CC5AE31B0@AM6PR04MB5158.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 12 Sep 2018 10:51:33 -0300
Message-ID: <CAOMZO5CGyBq_J=aYqT-c+mDpUx4XpF6hqoONC2LZBc3VK1h51w@mail.gmail.com>
Subject: Re: Fw: [PATCH 4.4 40/79] ARM: imx_v6_v7_defconfig: Select ULPI support
To:     ben.hutchings@codethink.co.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        alexander.levin@microsoft.com, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> [ Upstream commit 157bcc06094c3c5800d3f4676527047b79b618e7 ]
>>
>> Select CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS so that
>> USB ULPI can be functional on some boards like imx51-babbge.
> [...]
>
> CONFIG_USB_CHIPIDEA_ULPI doesn't exist in 4.4 or 4.9, so I think this
> and commit 2ceb2780b790b "ARM: imx_v4_v5_defconfig: Select ULPI
> support" should be reverted on those branches.

Agreed and I have already sent revert patches for all stable trees.

When I submitted the patch I didn't have the intention to get it
applied to any stable tree.

One user reported a regression in 4.14 stable tree due to this commit,
so I would recommend reverting it from stable.

Thanks
