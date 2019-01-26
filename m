Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E6AC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A982184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=voegeli.com header.i=@voegeli.com header.b="A6E2ceJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAZUqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 15:46:25 -0500
Received: from mail.tobiasvoegeli.ch ([94.130.103.102]:27943 "EHLO
        mail.tobiasvoegeli.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfAZUqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 15:46:25 -0500
Subject: Re: [PATCH] input: elan_i2c: Add ACPI ID for touchpad in Lenovo
 V130-15IGM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voegeli.com; s=2017;
        t=1548535583; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0cu3+7VPOgDgAVoCRJ42z+pG76YbesCNK0cx5TfV/8=;
        b=A6E2ceJQR4RitMQwxLWGSG/ccLp9Xbv9wK1+eKqi9bUj1b3Udclh2LInO1TnpW1OMerWQO
        LkG5AM6XvN4+JXQmFJ59FK3lIT1ZigKaZbykMLmS4kmCBay1CbMWSnN/49/ly/nnsgnTXq
        n8LzfdXFrnP5lcy/7NdqLk9k49+l+5F/nc9M8n3RbDe1eTIZ9C2sG0SjIjjTE1930mVSDZ
        oi6gDKk5h9HWIw0dWcxIgJ+O0SHwy41/ScTtMx04K8u63DPGos5MGNggovo9XyEZzfubmY
        GnFfcqRGyeN99MbT+ZOjOWxcHomomnQm9zFAyucS7IJLhdtR7gF/moZTzcZa2g==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?UTF-8?Q?Tobias_V=c3=b6geli?= <tobias@voegeli.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190126154856.14060-1-tobias@voegeli.com>
From:   =?UTF-8?Q?Tobias_V=c3=b6geli?= <tobias@voegeli.com>
Message-ID: <7a392798-0c21-a44b-6964-0ba511324fff@voegeli.com>
Date:   Sat, 26 Jan 2019 21:46:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190126154856.14060-1-tobias@voegeli.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=voegeli.com;
        s=2017; t=1548535583; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0cu3+7VPOgDgAVoCRJ42z+pG76YbesCNK0cx5TfV/8=;
        b=J8JcIW3Bm9MId5yF4M3laxkp659YroV7RePR5r4v9s78CCWwUsO6CaGlkkTMqOXXb7LQED
        8uSUXWxoMMzBnUCy5TFgqwjy7IjjyGuqff/6GgXyhwSpaCuu4v7qL4DHTqXYG5SMqQK6Us
        5DMhcFInqgPhP1CyONsoA3GPQ8DpNeRvkbyoOi95h9adx3WLxdAHeNUscAyRma+tZdrVBp
        sknsZIO73bP9x92OLve020WULhgs+iqbQf8L5RCfr2dtgqvdjZlB4yMP3silV0rGzEIo5v
        IsnRLHxQusHDf76NX5N3GRnFO3SqjpqPaL28jOgvdRu4vzQBi9g0wfZaFhv65Q==
ARC-Seal: i=1; s=2017; d=voegeli.com; t=1548535583; a=rsa-sha256; cv=none;
        b=Eqf3wpKzDf6ZttOPjxBLK66be7vMM5giqZaL4oQuqWNuYgcpiomqn/gmig5s1gUlRGgbIf
        zuAN1/++IMuzZGpKnmwxqarZVrnjhdPC5p4X8dCBP97ZXRX0EdilZV07M+1GofBf+8//7g
        x1lftCmI60Pys558R3po2zCThPoNUwdXJ86EW2EqGDVXjT6jx9JdkCPcohxm8UgV6vLBjR
        +9ROMwkYoQK6VlYmXsekD7miSCQqkgf3cNBCwOhCf1YSO+Ix+rE6/OQMjVy172ghpeSUY6
        bsuMH5V00phb7eNO/m8o53ECRHBubuuqRWPq5Yux43SAUTwBUQXCC9V6NagAlg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=mail@tobiasvoegeli.ch smtp.mailfrom=tobias@voegeli.com
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=mail@tobiasvoegeli.ch smtp.mailfrom=tobias@voegeli.com
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
