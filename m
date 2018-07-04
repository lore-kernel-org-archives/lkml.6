Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D337EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B35623DE1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3JyXMM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B35623DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeGDHLt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:11:49 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:36135 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932363AbeGDHLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:11:46 -0400
Received: by mail-pl0-f44.google.com with SMTP id a7-v6so2242387plp.3;
        Wed, 04 Jul 2018 00:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zdsexB5+kHUXoxUWBsKT7q43FPvhF+9lFtI1Rv/zkZw=;
        b=a3JyXMM++HLWxpzBV6iRhOTKiorhaapSeT8CwHyynxNbA3UEZkp6ajzi+I3zf5kxmM
         GSrdXalDnmsd6MYB9FEAwQMOQDD/4xITpe9yUwThT5x2GeomceSnbpURh9+suKKRxs3E
         wWPYQrnEMuMIhviB7BNO4ro03AvQxG1mU41HKWqs49zIgEC219oOa+oOKqgGGzYpYkG6
         oZrW3eBpTymPIiWs0D4POlrXqYj37KdrMiF0SVLrTFmYJdnzo1uMyiQDchdaywnpUpmS
         h/A6SiMx4Cc1bNlh7uPfEBnSs95C20bi++pjoe1ias7NbqZJq5nE5CEX5M9JGgvem5P8
         grzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zdsexB5+kHUXoxUWBsKT7q43FPvhF+9lFtI1Rv/zkZw=;
        b=bQjnV4Pj9EoHTjD9zahRML8COHYEZI28mxvDBkgwIXhhcKeRmkWc6DLJCOhUKEKZVh
         QlNJ3+f7yBZQUxKnJsyiG6EFrSAwLImjKhnpcrn8hnBmuzKisxSwSpt8EybMJlWB6DoQ
         dBz5xI+GuHjzMves73J57U1O9BgiK8JQmmqmZ/1Di4PJbs8DvF4ARtd3yUezs3XYd/qe
         /So/HyIEykequ7k2MszCcrUz8Rex2rDXp3/anr267ztOsb5dJDV8lYK4/LdUSDAFkRpf
         o0gVRHdDkyOIWGd3Ia/upoyzIpfPIm2YIAOVwepaPADks9/ZQ4WPO/0FtUcCyZZftQpu
         Tt2A==
X-Gm-Message-State: APt69E3587R5TqckfHXwK9PgotcrfbTOIrz0fB8C7KhctxxTDBgXiXlX
        sy8+YB7a+iGDIu58fuIyvK8=
X-Google-Smtp-Source: AAOMgpfH/oBn5VZeLHgtwKOGTrzhAWaceMjaQ0Ugl0jWzaf3lotziTv4Zg2Dcz+Tpv9LILj64SQFSQ==
X-Received: by 2002:a17:902:599b:: with SMTP id p27-v6mr910240pli.191.1530688306282;
        Wed, 04 Jul 2018 00:11:46 -0700 (PDT)
Received: from [192.168.1.143] (c-67-188-237-104.hsd1.ca.comcast.net. [67.188.237.104])
        by smtp.gmail.com with ESMTPSA id h12-v6sm4734877pfi.114.2018.07.04.00.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 00:11:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
From:   chain256 <tonu.jaansoo@gmail.com>
In-Reply-To: <CAMty3ZAkSTO-GXK7tjMMY6fjWV=R_mvT_Qe=wO5iJy5NvLwBEw@mail.gmail.com>
Date:   Wed, 4 Jul 2018 00:11:43 -0700
Cc:     jacopo mondi <jacopo@jmondi.org>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <pza@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <24630740-5F47-458A-86A3-F84C151473D1@gmail.com>
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180531190659.xdp4q2cjro33aihq@pengutronix.de>
 <CAMty3ZCeR3uEx8oy18-Ur7ma7pciKUf_myDk6_SpWvxc6DvygQ@mail.gmail.com>
 <CAOMZO5AOpOSAx=L4tOU1Na6hm8Tex3PHNxCYDB81C0+NPHzTZQ@mail.gmail.com>
 <20180703184117.GC5611@w540>
 <CAMty3ZCWztkM2oEaKQRVmMkA0C1V6b9Oj59DBX9XAWAybZbRAw@mail.gmail.com>
 <588A2275-4D45-442D-8B38-7A17C27BED10@gmail.com>
 <CAMty3ZAkSTO-GXK7tjMMY6fjWV=R_mvT_Qe=wO5iJy5NvLwBEw@mail.gmail.com>
To:     Discussion of the development of and with GStreamer 
        <gstreamer-devel@lists.freedesktop.org>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, can=E2=80=99t do it for next two weeks. Is this platform =
developed in your company? Maybe you can blame the hardware guys... I =
have had problems with them getting it right in my past experience :)

T=C3=B5nu

> On 3 Jul 2018, at 23:59, Jagan Teki <jagan@amarulasolutions.com> =
wrote:
>=20
> On Wed, Jul 4, 2018 at 12:14 PM, chain256 <tonu.jaansoo@gmail.com> =
wrote:
>> Hi!
>>=20
>> Just to let you know, I have same sensor working on Variscite iMX6 =
DART.
>> Using Yocto Morty release (
>> =
http://variwiki.com/index.php?title=3DVAR-SOM-MX6_Yocto&release=3DRELEASE_=
MORTY_V1.0_VAR-SOM-MX6
>> )
>> Had to hack device tree abit and that was about it. Hope you find =
something
>> useful on that page.
>=20
> Thanks for the link. Can you confirm is your sensor working with
> Mainline? we are trying to verify mainline ov5640 sensor here.
> _______________________________________________
> gstreamer-devel mailing list
> gstreamer-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/gstreamer-devel

