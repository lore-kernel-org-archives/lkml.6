Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C826ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C02920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8wsmF0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C02920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbeGXFqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:46:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51615 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388166AbeGXFqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:46:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so489234wma.1;
        Mon, 23 Jul 2018 21:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sC4SQDyIyxl6bynJvKrer2oi2lbP52PPzgNkBtRyhwU=;
        b=i8wsmF0R9lZs+3rfv4QENN6glqhHMzIEbu03+lmdo9pLMDH5KBFGLy7FlJN5eh27WJ
         3RpICo7PMcMA027kA33ENVIAp0ea9mMb8tbCm8w15bvZKvtkXeVlYaV2AF2Xyc7BKdPZ
         qyEeuRxGJif6+9Fy72oUrTatE9zxDJYLiFKH9oLz9op8YMFiICYSJj3wJrHrzD4WBSxF
         s8jTBfmnCa5HkeBEITBlCvF4H2/ls45EBeLkre0aMtvcAztQ61GclEmu08bi7ttWlmEE
         fPya22Ts6i9IrPj2cSyYwjwJvgUD3kdmjy1TEvOcdvIszFD+ZYxZG9pUgL1PiqzMHRun
         nRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sC4SQDyIyxl6bynJvKrer2oi2lbP52PPzgNkBtRyhwU=;
        b=NvKKc1xJ7vKwy/tVXJrRkUyIkeNlPbs4TdPB2/CzfyxjcVWiYPBcRlqKXd0QdhGqrs
         DS7g3fttQw86pPorv7kIZkS6fg1CssGp6p69JXwOgBzHKUC5VS9AnQNI0Ug7rfupszom
         NixA/xROMVlJ7IF18aqHbXlNjdGiFT0VvKCoLNuzTpXWSLKFCJZO7aB1ndv/GqHmRN5J
         N65/JRoK2WsWBvAG0yr7A9CkQMLJCCC6V2EA23TePPGspLWdQxro5aIPGAuj8E21kQqd
         deiff9E3+MIgUpNa5gHqV6MgpmQExfn29x4pjnVwWJ4bpnprfDSpbUfG2FytIWNvXfW/
         CDgA==
X-Gm-Message-State: AOUpUlHkLnfnAhgZgyYlaxk1V1yWnG2WlLqo44FXYVX+7cLxvoikx7tY
        Kx/Ezi+UpbHtphIyacSsya0PrzKdSDXAMH1GYwa9Qw==
X-Google-Smtp-Source: AAOMgpe7OsjUv61Dop6kjtaYuB3ncJX9dL/f6KDko4Zn29ZXgVkPnRRrJZT5SpRzGJzHiyaLbR6aVCJIVXQMrmVJEHM=
X-Received: by 2002:a1c:6a0b:: with SMTP id f11-v6mr848792wmc.107.1532407333634;
 Mon, 23 Jul 2018 21:42:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ad76:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 21:42:13
 -0700 (PDT)
In-Reply-To: <20180723.094332.1263746631250670875.davem@davemloft.net>
References: <1532335127-10683-1-git-send-email-shubhrajyoti.datta@xilinx.com> <20180723.094332.1263746631250670875.davem@davemloft.net>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Tue, 24 Jul 2018 10:12:13 +0530
Message-ID: <CAKfKVtGbdnGTfGPH-_x=EPOExcA2OJiuSROUCBWP0WzEgsXqjw@mail.gmail.com>
Subject: Re: [PATCH] net: axienet: Fix double deregister of mdio
To:     David Miller <davem@davemloft.net>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        netdev@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Jul 23, 2018 at 10:13 PM, David Miller <davem@davemloft.net> wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Date: Mon, 23 Jul 2018 14:08:47 +0530
>
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers=
/net/ethernet/xilinx/xilinx_axienet_mdio.c
>> index 16c3bfb..757a3b3 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
>> @@ -218,6 +218,7 @@ int axienet_mdio_setup(struct axienet_local *lp, str=
uct device_node *np)
>>         ret =3D of_mdiobus_register(bus, np1);
>>         if (ret) {
>>                 mdiobus_free(bus);
>> +               lp->mii_bus =3D NULL;
>>                 return ret;
>>         }
>
> Your patch was corrupted by your email client, in particular it has trans=
formed TAB
> characters into SPACEs.
>
> Please fix this, email the patch to yourself as a test, and please do
> not send the patch here to the list again until you can successfully
> apply the patch you receive in that test email.
>
>> This email and any attachments are intended for the sole use of the name=
d recipient(s) and contain(s) confidential information that may be propriet=
ary, privileged or copyrighted under applicable law. If you are not the int=
ended recipient, do not read, copy, or forward this email message or any at=
tachments. Delete this email message and any attachments immediately.
>
> This is inappropriate for postings to this mailing list, please disable t=
his footer
> if you would like to post here.
>
> Thank you.

Apologies for the same.
Resent now .
