Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8984EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518EF218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNhSkegE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfBRIYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:24:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35179 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:24:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so8426508plo.2;
        Mon, 18 Feb 2019 00:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uZBWZxI0JTWy3C+qlC/6n45Fo7AqVKooep7hfl0kTXw=;
        b=DNhSkegE7IySdfoThqvnsmEmtQGrSGIRbos1RhXwIjryqd8Y5+dFWDho8acpYrDY3E
         7CHdPS9L36VMKdfX77Nb+q9/ElWFizcjgzt1lwT0/BKfxMtxYJakYiqLcOcXQC8diuNK
         vmY1Yak23tufpA3suqiEODc1VXPt4x4DhA4p1fkbipc7ich9ghsGzz/FkCRboHcN2XWl
         re6b33Kr3HkdmcGT1Cy/f0eZecfojqK+8S6NF9v1TcESTUPY6IrnXapWMFUjGm/AixrT
         y2DF00zL7Iwkb63uJHprOc8n6MsK1a1jif/QAC10UrKzOOgTb2k2ushzKq5gWUVr5ZKY
         m1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uZBWZxI0JTWy3C+qlC/6n45Fo7AqVKooep7hfl0kTXw=;
        b=jMPbiCXosMUUtV6ZQ928+glWNvToSbU0Hkm3GHfryWN3K9EI7b51BJGlPnsiNCBHAU
         fZyCD57vflFG0zHidDySgI4zVxitKW5zmiEsx1sX5Hejid7sQvnvZP2zjZBfoxslGDa1
         xss46nbaIA3DCFCQr0zl1OVSfpjXpgfBA6CNPs1mGnhgMduo0jqpkPTFJC+B/WsTAwkU
         aPoFBdiPNxW2MLTc7OoPTQOllp3kLrRhy49p4CkHd/qJ5h59ZNprpLBeBNSzDNtTkxaD
         JtqirMhi9k+ELQDAt/Dn/qPsMWbLPnwPqx8t7oUZt/awHOzcaEan8Sa3eeML1Q+5zIpx
         SxyA==
X-Gm-Message-State: AHQUAuYhapjdZf81JcAU5Ct+9gzyX1OAKS3aWF8S1KGzR7wkj7YrHmTy
        e3GC+0NWciwxLr3pTslvZug=
X-Google-Smtp-Source: AHgI3IZP4KUh16q5dXYju3Uxsp0WekSHJBCFrDvxyKC8VM/bdgY2XY81hKESYWfNr4C3preK7u6Vxg==
X-Received: by 2002:a17:902:b287:: with SMTP id u7mr15705684plr.69.1550478288633;
        Mon, 18 Feb 2019 00:24:48 -0800 (PST)
Received: from ?IPv6:2001:b400:e255:739:c164:877b:991a:a179? (2001-b400-e255-0739-c164-877b-991a-a179.emome-ip6.hinet.net. [2001:b400:e255:739:c164:877b:991a:a179])
        by smtp.gmail.com with ESMTPSA id q5sm17876823pga.71.2019.02.18.00.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 00:24:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] RTL8153-BD is used in Dell DA300 type-C dongle. It should be added to the whitelist of devices to activate MAC address pass through.
From:   David Chen <david0813@gmail.com>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <1550477077.11088.2.camel@suse.com>
Date:   Mon, 18 Feb 2019 16:24:45 +0800
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, kai.heng.feng@canonical.com,
        davem@davemloft.net, david.chen7@dell.com,
        mario.limonciello@dell.com, f.fainelli@gmail.com,
        edumazet@google.com, zhongjiang@huawei.com, bigeasy@linutronix.de,
        hayeswang@realtek.com, jslaby@suse.cz
Content-Transfer-Encoding: quoted-printable
Message-Id: <05F13E08-C930-439D-BDA9-6D6C282889FF@gmail.com>
References: <20190218034817.7515-1-david0813@gmail.com> <1550477077.11088.2.camel@suse.com>
To:     Oliver Neukum <oneukum@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

Thanks for reviewing.  I have made some mistake, will correct it and resend.=


Thanks and Regards,
-David

> Oliver Neukum <oneukum@suse.com> =E6=96=BC 2019=E5=B9=B42=E6=9C=8818=E6=97=
=A5 =E4=B8=8B=E5=8D=884:04 =E5=AF=AB=E9=81=93=EF=BC=9A
>=20
>> On Mo, 2019-02-18 at 11:48 +0800, David Chen wrote:
>> From: David Chen <david.chen7@dell.com>
>>=20
>> Per confirming with Realtek all devices containing RTL8153-BD should
>> activate MAC pass through and there won't use pass through bit on efuse
>> like in RTL8153-AD.
>>=20
>> Signed-off-by: David Chen <david.chen7@dell.com>
>> ---
>> drivers/net/usb/r8152.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index ada6baf8847a..86c8c64fbb0f 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -1179,7 +1179,7 @@ static int vendor_mac_passthru_addr_read(struct r81=
52 *tp, struct sockaddr *sa)
>>    } else {
>>        /* test for RTL8153-BND and RTL8153-BD */
>>        ocp_data =3D ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
>> -        if ((ocp_data & BND_MASK) =3D=3D 0 && (ocp_data & BD_MASK)) {
>> +        if ((ocp_data & BND_MASK) =3D=3D 0 && (ocp_data & BD_MASK) =3D=3D=
 0) {
>=20
> You are inverting the second half of the test. How can this possibly be
> right? Had you dropped it, I would understand. But this? Are you sure?
>=20
>    Regards
>        Oliver
>=20
