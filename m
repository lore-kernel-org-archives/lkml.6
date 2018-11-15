Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C330214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUAIT6du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C330214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeKOODD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 09:03:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41621 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 09:03:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id g188-v6so15626493oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 19:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :autocrypt:subject:to:cc:from:message-id;
        bh=zcTVwqy3uExc7Ew8Oy0dI83mKGtQYRTYAmFBAaM2HeQ=;
        b=rUAIT6duhq0RJupPas0SE8GmS5QnnYVnExotf4ogQuWgCzt6T6yPjn6AKUzdYspNax
         C1A/N7RKRyIOPAX81LFZJPrONfWtAXkuNTZE3UTosE8Y4UcAOiyod1Hek/PbZ+kQT82J
         R15ktA5qXEzPvjosNGMMF4BwPOIvZgJ5qPbrHfBcFJnR1bbGAmdHtEqDqGavABJHOO9W
         TH7hEo4Qc4jkmlKpKDRFSjGwa3d2cQ/7oTnps/xVWgROONpJHXWKnqzPU9C6HUAxbqxY
         x+N0ZygUcdENDIymt4T28Ii4mxjHoEsVioMZaIpDTvc2shSV8liF4nvoAbB99TCewVzK
         TNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=zcTVwqy3uExc7Ew8Oy0dI83mKGtQYRTYAmFBAaM2HeQ=;
        b=ITzbiY5TiUiv8aKpEzzedievLcS9w6XVSk5ScSSwvw/mNDJbkKSSggaAaD7EpJq4vc
         Pez7jsLuGbM/UmpVC5PvYQoxUHbgmvkRTyiBQZbdbwB4LaWSFgeqcWNrQhTFl0E0ZRN0
         ct1GPQLyZQwBSw64uTtk5pUowZ6qcHJojcixHshqp9yCAdPHTS/WxX+cvY2s1AnR0s67
         ycpP9OxTahW1J/oM6sqj6XcedSdWoax5Oco3udhRLqfD2dgRsbt4yFSZUfa/QeVVfkCP
         Yty6AKve5mcYE/FEHwML7jJSJp84kC0Vm0/TlAws0f6BIfyDbGHi7INCkTsA6KWyy2an
         jE0g==
X-Gm-Message-State: AGRZ1gIRO8Po1vv5KDJAIob+2MstQY6Qj9md1B36509wPnE1KJXWmQOc
        Tz39zPDNUWYX4J/yavsCJNaGoyZO
X-Google-Smtp-Source: AJdET5cSaMNXGs7aSvnZIdnqJPozNCAZt11LW6ZQH0jDCOCi3krlV/SlRCckcH/Ks+LAY0s4oBSdEg==
X-Received: by 2002:a54:448b:: with SMTP id v11-v6mr2846276oiv.128.1542254214877;
        Wed, 14 Nov 2018 19:56:54 -0800 (PST)
Received: from localhost (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id e24sm11386956otd.63.2018.11.14.19.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 19:56:54 -0800 (PST)
Date:   Wed, 14 Nov 2018 19:56:47 -0800
In-Reply-To: <20181115011125.GA32556@roeck-us.net>
References: <20181115011125.GA32556@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 14, 2018 5:11:25 PM PST, Guenter Roeck <linux@roeck-us=2Enet> =
wrote:
>On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
>> It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
>> result in the inability for the kernel to have a valid console
>device,
>> which can be seen with:
>>=20
>> Warning: unable to open an initial console=2E
>>=20
>> and then:
>>=20
>> Run /init as init process
>> Kernel panic - not syncing: Attempted to kill init!
>exitcode=3D0x00000100
>>=20
>> Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
>> really is no drawback to defaulting this config to the value of
>> SERIAL_8250=2E
>>=20
>> Signed-off-by: Florian Fainelli <f=2Efainelli@gmail=2Ecom>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation=2Eorg>
>
>This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
>defined where it was not previously=2E Example mpc85xx_defconfig=2E This =
in
>turn results in boot failures for those configurations, with an error
>message of
>
>of_serial: probe of e0004500=2Eserial failed with error -22
>
>which wasn't seen before=2E

Do you know which Device Tree is being used here? The most obvious thing t=
hat could be done is to add a !PPC condition but this might be missing othe=
r platforms doing their own 8250 registration yet being OF aware (sparc?)=
=2E

>
>Not sure if replacing a potential problem with a real one is really an
>improvement=2E`

That comment is not particularly helpful though I have an appreciation for=
 when a change breaks things in unexpected ways and how frustrating that ca=
n be=2E
--=20
Florian
