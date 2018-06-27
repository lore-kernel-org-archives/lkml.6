Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E003C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A13023D5B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrXIKl+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A13023D5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934781AbeF0REY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:04:24 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:37337 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934411AbeF0REV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:04:21 -0400
Received: by mail-vk0-f65.google.com with SMTP id h22-v6so1604737vke.4;
        Wed, 27 Jun 2018 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Eb2CDgcTxJ/3wGjZRxkI3B7IMLAzT9G+KhUVn1k1mnk=;
        b=HrXIKl+JXN44kBDxaS1ExBwgmRd7rO/eCeWT1gIsfXNd5g0Do+r9n5UwjGBaam7JA0
         8Go5H03JNi5HsfI0E0+RvFQxSNHvHlzYRWVLEW5/FXVnqrRHFUT8dxqGu2kFFIxGnFVT
         PI6HcDrSUP9xsgvL3ejRlKfETPN0Wisz/2WIrm2nMnW6a82R4O8CxtIsOOLz4XZWAd6v
         HNJzoluCTQjZgvXp6xeFWV+ylyI2LtK8SE/5OC0osr1WJ9Vp6zj9bX+eTQIEVyajAV6x
         xbVMYsxttSaP80Uo+3Ru6wq1DnoiEp/N8Xs4hd8wL4VORIo1681teDG5PiMsPqzGWKEQ
         ymYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Eb2CDgcTxJ/3wGjZRxkI3B7IMLAzT9G+KhUVn1k1mnk=;
        b=L47RyggVN7E2/bfT9wwAcC/3sKn4IsIYvHclNp1O/OMiXeYcHeStYv019WNdsRgiwC
         T6YRXxbC4P8dOBK08foE7PTwlydfV15Ev8dtjSXlvdoWPFwl2NGdTwZHdYNpdBApJwse
         bYXInSSEOm1iS1ePtCA5YSB9H+l5L0SLwUigUSYUEgMQOe7DfMnsrf+0AmJKLJbcVE3p
         6hS/DMs72nYzD1LTW4tnNKpjooSIMrthIXIGQB+fAWbPafsUYX0f6tZsMP/8m6vUeNb5
         Qv9A3WGDRKQxI02tqSr5UTyWmqnbHz7ub8hgcq3uol5TyPkb7+Pgen91RBeFa5LGLJG/
         S4gQ==
X-Gm-Message-State: APt69E3QUBi8hSpj/C0sP9+AMgLWAFqEoumJsjovPbYFwQ3C8ys9fEob
        NpzRBulsiO48U76ZGw0ONhYzKEw5UR2WA0N1EVE=
X-Google-Smtp-Source: AAOMgpevG5dlOOfrjVhbmSDiSWER/jM+Q9J2Lg6IPiG8fAfRaYbuySIEEi6JIKrIlYO3G42dXHIHQo5Bdb3MaBPBalk=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr4428918vkd.161.1530119060260;
 Wed, 27 Jun 2018 10:04:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 10:04:19
 -0700 (PDT)
In-Reply-To: <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
References: <cover.1530004712.git.sean.wang@mediatek.com> <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
 <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 20:04:19 +0300
Message-ID: <CAHp75VedHLw52J_ymh3iYf2w=r8d+Kqg=fJZmBGnaCrEbNEPdQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
To:     sean.wang@mediatek.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 7:59 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 27, 2018 at 8:43 AM,  <sean.wang@mediatek.com> wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>
>> +config BT_HCIBTUART_MTK
>> +       tristate "MediaTek HCI UART driver"
>> +       depends on BT_HCIBTUART
>
>> +       default y
>
> Perhaps it's an overkill for users which would like to have less
> amount on stuff in kernel.
>
>
>> +#include <asm/unaligned.h>
>> +#include <linux/atomic.h>
>> +#include <linux/clk.h>
>> +#include <linux/firmware.h>
>> +#include <linux/module.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/serdev.h>

Perhaps alphabetically ordered?

+ blank line.

>
>> +#include <net/bluetooth/bluetooth.h>
>> +#include <net/bluetooth/hci_core.h>

>> +       /* Enable the power domain and clock the device requires. */
>> +       pm_runtime_enable(dev);
>> +       err = pm_runtime_get_sync(dev);
>> +       if (err < 0)
>> +               goto err_pm2;

Should be err_pm1 here.
Yes, that's correct.

>> +err_pm1:
>> +       pm_runtime_put_sync(dev);
>> +err_pm2:
>> +       pm_runtime_disable(dev);

>> +#define MTK_WMT_CMD_SIZE       (MTK_WMT_HDR_SIZE + MTK_STP_HDR_SIZE + \
>> +                                MTK_STP_TLR_SIZE + HCI_ACL_HDR_SIZE)

It would look slightly better if you start on new line like
#define FOO \
 (BAR + BAZ)

>> +struct mtk_stp_hdr {
>> +       __u8 prefix;
>> +       __u8 dlen1:4;
>> +       __u8 type:4;

>> +       __u8 dlen2:8;

u8 already 8 bit.

>> +       __u8 cs;
>> +} __packed;

-- 
With Best Regards,
Andy Shevchenko
