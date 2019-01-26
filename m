Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54349C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016832133D
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=voegeli.com header.i=@voegeli.com header.b="xjVlJB7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfAZVOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:14:10 -0500
Received: from mail.tobiasvoegeli.ch ([94.130.103.102]:37984 "EHLO
        mail.tobiasvoegeli.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAZVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:14:09 -0500
Subject: Re: [PATCH] input: elan_i2c: Add ACPI ID for touchpad in Lenovo
 V130-15IGM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voegeli.com; s=2017;
        t=1548537247; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3QfhmGTzMnFBPnz9TKz9Hfhj3jTqxmt2EgPDWT/cds=;
        b=xjVlJB7wVOihdniefLgUJ7m6ctRRWp5cOJrV8+VLs28/WXzxJGaBFZsCS4sfotmo/6YAD2
        aTPNM1SV4oTgilFkDR2UcMvAU3sgBYpy9ZGO6UoKevr/i4cIwVU6DbgqsfqpbSbINHA8Ml
        j0ENt0z1jiztzfWSbpWvXMwbWJnP48yb5QTeL4CbtBas5coNr1Z9Nnfpw4LIwjeIRF88ms
        cRXOWSd4cJrUZ0JpZq0TgqMY4WimNLhNRuU9q7PZsqD/aW84DlhJpuRNqM/a/7wlHwUky2
        LrwPoeXXkApqsP1KH0jBJnSxs9g00vNWRwHn0YkDLx75a+snfUviES6w8mWAtA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?UTF-8?Q?Tobias_V=c3=b6geli?= <tobias@voegeli.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190126154856.14060-1-tobias@voegeli.com>
From:   =?UTF-8?Q?Tobias_V=c3=b6geli?= <tobias@voegeli.com>
Message-ID: <ebaf58f8-328f-9f3a-c5c8-086274063f2c@voegeli.com>
Date:   Sat, 26 Jan 2019 22:14:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190126154856.14060-1-tobias@voegeli.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=voegeli.com;
        s=2017; t=1548537247; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3QfhmGTzMnFBPnz9TKz9Hfhj3jTqxmt2EgPDWT/cds=;
        b=fzhHWgvg8hwHlVo3M/OKF55QlF7Mw6lfG/m/e40ggjXoMYaK4/uagbJ1qM09L6yNdC/wxz
        9vQtjYXBrqPWuz5nlUv9xNMewAH0q6DXpR0jXPfmDfsGXJOggrPRzgki2i8C9eA4vDwZHE
        AYX1ME1ZvnIWgdegu4LCKjWeakX7glS07Vz5bK6e32IAHTJJJIENA+EplDjRnpx+TmdVg1
        G373aCUva4c0Q6BZTOoYU9k5xmbtIbhd1gdRUyqD8f20tz/gXWjum4/8Bd7KspJJceMLnL
        6zloee2TZsl2tYV9kIHmEnbYP6whMyiv5Re4GtbJwtvVdygIpkD9pu9HcGbXFw==
ARC-Seal: i=1; s=2017; d=voegeli.com; t=1548537247; a=rsa-sha256; cv=none;
        b=Kt0bpgwzQjerqOQV5AwshbOPF1OKlheCNZ8D773QGEEiAOshj1aW5THFDAVCAgpmc/vf4M
        ekiU6cTrm4KGUvl2xA/wjRxKB3VNospdu+wzst2SOJhRKGr0jITM+tYf/sf8JwiHWVrlWS
        pErl6QQdsSAZUhMAGMp8Wuk7pZGK+TsnBxB3bu23KLtCO4Ql+vgMwOcTonzt0+Q8RgtzW5
        9jkul482aUkepOnJXzkTQQoV27Ghjz+7fPE4HIkfLJCSUrfrZ+zMiFfsEqCsCg6zMFdDG3
        F/6Pnafr4u0p+hF1kV11pfIj7vlleTCjF0OR5ZdceDTf1KglptUL6SO2wH21tQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=mail@tobiasvoegeli.ch smtp.mailfrom=tobias@voegeli.com
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=mail@tobiasvoegeli.ch smtp.mailfrom=tobias@voegeli.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if the last mail went trough, so here again:

Forget this patch, I did some further testing and even though the touchpad works, it generates some dmesg messages. I have to take a closer look into this.

Sorry for the spam.

Tobias


> From: Tobias Vögeli <tobias@voegeli.com>
>
> Add ELAN061A to the ACPI table to support the touchpad of the Lenovo V130-15IGM.
>
> Signed-off-by: Tobias Vögeli <tobias@voegeli.com>
> ---
>   drivers/input/mouse/elan_i2c_core.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index f322a1768fbb..4998b7007201 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1347,6 +1347,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>   	{ "ELAN0611", 0 },
>   	{ "ELAN0612", 0 },
>   	{ "ELAN0618", 0 },
> +	{ "ELAN061A", 0 },
>   	{ "ELAN061C", 0 },
>   	{ "ELAN061D", 0 },
>   	{ "ELAN061E", 0 },
