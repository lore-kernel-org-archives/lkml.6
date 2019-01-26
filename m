Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E3BC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AF321872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tobiasvoegeli.ch header.i=@tobiasvoegeli.ch header.b="OF3JktBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfAZUuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 15:50:01 -0500
Received: from mail.tobiasvoegeli.ch ([94.130.103.102]:21473 "EHLO
        mail.tobiasvoegeli.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfAZUuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 15:50:00 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jan 2019 15:49:59 EST
Subject: Re: [PATCH] input: elan_i2c: Add ACPI ID for touchpad in Lenovo
 V130-15IGM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobiasvoegeli.ch;
        s=2017; t=1548535451; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAe0SNXjf7/HwUD+yzQj5qXqSN3p4nk5PC+x2xRnep4=;
        b=OF3JktByHT3U/B9A7zUbHF2gwkaWNx5NPzVBGrHo5EXOo5joxLNdBLKmwK0dMcmA6Gz0WR
        dcxhBx8/ScqBFnHz2GbpM8r9Ac+wjHLYUJN/xcchy7DKp6TUXbaZNYmlA0Lghwx3jqVLD+
        j+x1Et7kd50JldFClV8NSUApQkxPMRVUp5vblr3/M96TMj+NJl/fOZqSwA16HobXB3Nxjh
        lJhf//ohSez09Z1KoI/PfX9aaM51fw8y7Fl/ZQ0L22bmqUXrC97Kz8AUNfu+JEC9jg0JI6
        6OnIswBnLXb2CSvRSTqgeGqzapxltFWOFglGy7pC+6GgpWDvhIj6+mkNaiVRdA==
To:     =?UTF-8?Q?Tobias_V=c3=b6geli?= <tobias@voegeli.com>
Cc:     linux-kernel@vger.kernel.org
References: <20190126154856.14060-1-tobias@voegeli.com>
From:   =?UTF-8?Q?Tobias_V=c3=b6geli?= <maillist@tobiasvoegeli.ch>
Message-ID: <4f204934-9b2d-110a-da0b-22bf5d92d9bc@tobiasvoegeli.ch>
Date:   Sat, 26 Jan 2019 21:44:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190126154856.14060-1-tobias@voegeli.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=tobiasvoegeli.ch;
        s=2017; t=1548535451; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAe0SNXjf7/HwUD+yzQj5qXqSN3p4nk5PC+x2xRnep4=;
        b=yul+ywAlw8m05ZGDZ1igVylX7bk2RO61P0FqIGpOhzpD5/VgKvLejfFQOKkVnSDJdPc0z2
        9AuPk9EddCkC+sbox68T1xc6QCRhz78gtL0fxpZa8fXMkz1Ok15bYZszpccu+g472fZ8mi
        gXMe6mHkcpXNM6q+nQvGPoooBklX68aW1aN92ldVLVAOylh0om7ZJyZ3AsiRURJn+k4y74
        SoPtyMnYay3h537nOLIO/49wWASxeVHAQO9+wqfG2kkPv0mVfbFNvgsdR/a5DiLVBR+1gq
        8vLiwSmEiC6NhpeMrHn89BzLoY3QXGxiI0rmk/6cpuQBqCZD2s2sC8owG+BL2Q==
ARC-Seal: i=1; s=2017; d=tobiasvoegeli.ch; t=1548535451; a=rsa-sha256;
        cv=none;
        b=gpw7/hyon7zk+XCxfJDFm5JfCLE8nWglzl2JrD//ew5QU4IED+SX6zGkdR/KVbdulACf/M
        JcCyKlmeozSLiNYP59NTIzp3gNgYTitpNEYt1qR2gbEZ/g9FJa70274B3TlRUTq2XQMI4O
        D3ECgyFBisLQ6J3wQWhcIq/pZp+7IdMhIp8+zaHx1/sVMoKmi7VUB2xU2FP+T7pQewHIZa
        InpMhVAGLPNUsFQSpBWIG/KtvEm/Wlp8fHSHLn7PDuNBo/oXXYkorzB2tVIjBPk6DImEwR
        zi0I65g32Iu0st2ejDweRDw4veqGBlo5H1fHG7VyEzbSOsdg9KDQ3X7fSjh9nw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=maillist@tobiasvoegeli.ch smtp.mailfrom=maillist@tobiasvoegeli.ch
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=maillist@tobiasvoegeli.ch smtp.mailfrom=maillist@tobiasvoegeli.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
