Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBD7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F44B20818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7ol3zBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfBVFof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:44:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39603 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVFof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:44:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so576285pld.6;
        Thu, 21 Feb 2019 21:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/MwFcr/mrencmG4j9QvYt7gaSST4xEENfp4QhJNVzXw=;
        b=L7ol3zBFXRsUFM5BgqMHlCwNzyNonFdEPHVD7yMLeop8PY8qvvFtkS6JzlJYnUuovO
         lrXHLCZ3duBoSRo+q3CpMOGkgL7/4TSlCp/4vfriJNV6EFqOKhk4BaEs6+zoar36ocpN
         m2mtHR656MZUtfacHQ8N6jTTdeU5JUJFkQG+4Bnz1xqPGfmlcDIzkYFKaIJx83AHDpmf
         2Aejqz/LxWtiqs0Mc0nLR1DY28YRD5MSx2DHZ5LE6mII2F48z9OIyC21ctBxzyOuMfvL
         KG9z3alE+g27yN6gQP7sJD1PXaLmyu4SuA9lx3g6BmeN62I3/RzMjqiLVCFFjmxbk4//
         TAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/MwFcr/mrencmG4j9QvYt7gaSST4xEENfp4QhJNVzXw=;
        b=AVkvgKJV2pdQcw7760+ZeLRPc7MedAebf+hj44opkkTRbqfkoAdLI+eY2PjgiJum/f
         ZqghGJyVymWFT0LHWbxW03D2RdOtRI93PPg9CLzurbp/dmaNIfRAhVQHXh4aIiNV9LAZ
         FiYKgsbueToIe12ZvG5JSuFaxzkxskjz/rBNt7RKkrCZODCHI1TGY73G7yMFRQXF5X4b
         8wW7yB9OaWXdHIGCACyGXDuWRfOFah68+ODTF8njLuGbpRC8PZ83evmpv1M8VKRTCbmd
         UZWoBb8Ep7HcXugmUne4sIJAUldaBCbcoRZqNryvW6qtI2mqs/Q3N5XbBtnsEXrGaXrO
         jtpA==
X-Gm-Message-State: AHQUAuZLDxN+m7DdB7hC7JRJHg2iWK+MU4JJlsjVVSMRU6tMDIp8faYp
        NGeyfa9sPZSxyNamJ5XZWuA=
X-Google-Smtp-Source: AHgI3IYkGYxb2n30TJI+ah6sjCnoKDc9lEvxa6iwmW6pzDmj6kPQll4xyOlpHZJcAGFithT4TSpizg==
X-Received: by 2002:a17:902:1027:: with SMTP id b36mr2452341pla.339.1550814273977;
        Thu, 21 Feb 2019 21:44:33 -0800 (PST)
Received: from ?IPv6:2001:b011:1004:3cc9:341c:4ec1:3641:ebe0? (2001-b011-1004-3cc9-341c-4ec1-3641-ebe0.dynamic-ip6.hinet.net. [2001:b011:1004:3cc9:341c:4ec1:3641:ebe0])
        by smtp.gmail.com with ESMTPSA id b26sm970877pfe.91.2019.02.21.21.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 21:44:33 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] [V2]r8152: Add support for MAC address pass through on RTL8153-BD
From:   David Chen <david0813@gmail.com>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <91332458-c2c1-b7c3-5135-ab0741108020@suse.cz>
Date:   Fri, 22 Feb 2019 13:44:31 +0800
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        hayeswang@realtek.com, mario.limonciello@dell.com,
        bigeasy@linutronix.de, edumazet@google.com, f.fainelli@gmail.com,
        david.chen7@dell.com, kai.heng.feng@canonical.com,
        zhongjiang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <507B7885-3219-4C9A-B709-6B85F70F4F6E@gmail.com>
References: <20190218140057.17030-1-david0813@gmail.com> <91332458-c2c1-b7c3-5135-ab0741108020@suse.cz>
To:     Jiri Slaby <jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thanks for your comments.  BND_MASK and BD_MASK are defined separately, and I=
 have tested RTL8153-BD and RTL8153-BND devices, both work as expected.

Thanks and Regards,
-David


> Jiri Slaby <jslaby@suse.cz> =E6=96=BC 2019=E5=B9=B42=E6=9C=8818=E6=97=A5 =E4=
=B8=8B=E5=8D=8810:22 =E5=AF=AB=E9=81=93=EF=BC=9A
>=20
>> On 18. 02. 19, 15:00, David Chen wrote:
>> From: David Chen <david.chen7@dell.com>
>>=20
>> RTL8153-BD is used in Dell DA300 type-C dongle.
>> It should be added to the whitelist of devices to activate MAC address
>> pass through.
>>=20
>> Per confirming with Realtek all devices containing RTL8153-BD should
>> activate MAC pass through and there won't use pass through bit on efuse
>> like in RTL8153-AD.
>>=20
>> Signed-off-by: David Chen <david.chen7@dell.com>
>> ---
>> drivers/net/usb/r8152.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index 60dd1ec1665f..86c8c64fbb0f 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -557,6 +557,7 @@ enum spd_duplex {
>> /* MAC PASSTHRU */
>> #define AD_MASK            0xfee0
>> #define BND_MASK        0x0004
>> +#define BD_MASK            0x0001
>> #define EFUSE            0xcfdb
>> #define PASS_THRU_MASK        0x1
>>=20
>> @@ -1176,9 +1177,9 @@ static int vendor_mac_passthru_addr_read(struct r81=
52 *tp, struct sockaddr *sa)
>>            return -ENODEV;
>>        }
>>    } else {
>> -        /* test for RTL8153-BND */
>> +        /* test for RTL8153-BND and RTL8153-BD */
>>        ocp_data =3D ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
>> -        if ((ocp_data & BND_MASK) =3D=3D 0) {
>> +        if ((ocp_data & BND_MASK) =3D=3D 0 && (ocp_data & BD_MASK) =3D=3D=
 0) {
>=20
> Can you ensure that BND won't have the BD's bit set and vice versa? I.e.
> should the check be something like:
>  if (isBND() && (ocp_data & BND_MASK) =3D=3D 0 ||
>      isBD() && (ocp_data & BD_MASK) =3D=3D 0)
> instead?
>=20
> thanks,
> --=20
> js
> suse labs
