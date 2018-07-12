Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1870C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504E620C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="SBqRF8Hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504E620C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeGLK3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:29:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33515 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeGLK3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:29:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so17791309edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3OSh101nTRurP7tTicCFD2kYDrrWvHtJz2dikbrwRwE=;
        b=SBqRF8Hg2umjd1QHLLHo8XnVpFiLxBxEq+v4pACdJMbvOLRRUB4qbUu54unISzqDSQ
         YPfdx1M67xEBnO4jpKfjTnZE1qPl6yE42cTEN738NWTAd2bJ8GblzuYGRQj7bCaTyW58
         9O3IMf8R3PxnfOkdgBCBIUWa7WOP+1lysbmFtf2BOovqZJgGBg7GC7s9JAY5ohFaLplh
         YOjG3Dgc7rss4CY1jBRA4m68n87aFev8WoDKPm0oJVcAEaQjEa8PnsIdo0q40dpLAccu
         dyOqDAN0RCfOWi4CTaMnZfBrUx9HWbHh/wcVZ28q666zGsA9Qy1f4gnELcrtN9xh133Y
         oNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3OSh101nTRurP7tTicCFD2kYDrrWvHtJz2dikbrwRwE=;
        b=lG41bJdgfU2xyHWQKM+PgAYJs3jhGcPclJAU6yevADialVZjA4qro64DSlt0OcWXjg
         NjnI+kCvj5vLU5C7oVujPf6eYFjK/l8oGER5n9eG60jDLtf9t1x+30SF8dOXHLnxahFn
         +eUIfcvXq41wWnBxH53fwWtAMkz0OAx1CYX7NKhR6/TETpaI9y0eOmjw6d9J8fGNpBUt
         IWDHD3Y2lCkf4lBRX5c+EZM/Q+JKBeBAOfBpBeG29VOUkbwCtYZ2acg+aolXzvAgw3Yp
         dqW38EpL2Zoa7pDbZkDY5oWjC9vMap/s6oCHplZmUY8vGx9e4wGaPyBGWUDt5QyvsC5f
         JSow==
X-Gm-Message-State: AOUpUlHRJhvvwVLvX8hg2QlmuwY5p6BgU9i0v9pOEhfESM45NeE5epra
        w52ZA3NqPo3fxQ6FUJvQsTPBFQ==
X-Google-Smtp-Source: AAOMgpcerqWUUxDlsG6H6uo+5j305zp6jrox07WkzmZezNhtznTMQVTAgo7Le1oSiHcQbpZw01mgIw==
X-Received: by 2002:a50:db8d:: with SMTP id p13-v6mr1994924edk.298.1531390805863;
        Thu, 12 Jul 2018 03:20:05 -0700 (PDT)
Received: from [172.20.0.13] ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id r25-v6sm6953628edb.45.2018.07.12.03.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 03:20:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.15\))
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
From:   Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <CAOCHtYhENAEiUPPzTVLDUt-eZgexEo7UqpxJg_5-Q=xTtxqtCQ@mail.gmail.com>
Date:   Thu, 12 Jul 2018 12:20:04 +0200
Cc:     Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E23BA518-A33A-418D-B539-55345F1DC517@dominion.thruhere.net>
References: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
 <1531294352-27385-3-git-send-email-koen@dominion.thruhere.net>
 <20180711133137.GM99251@atomide.com>
 <CAOCHtYhENAEiUPPzTVLDUt-eZgexEo7UqpxJg_5-Q=xTtxqtCQ@mail.gmail.com>
To:     Robert Nelson <robertcnelson@gmail.com>
X-Mailer: Apple Mail (2.3445.100.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Op 12 jul. 2018, om 05:08 heeft Robert Nelson =
<robertcnelson@gmail.com> het volgende geschreven:
>=20
> On Wed, Jul 11, 2018 at 8:31 AM, Tony Lindgren <tony@atomide.com> =
wrote:
>> * Koen Kooi <koen@dominion.thruhere.net> [180711 07:36]:
>>> +&cpu0_opp_table {
>>> +     /*
>>> +      * All PG 2.0 silicon may not support 1GHz but some of the =
early
>>> +      * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
>>> +      * to support 1GHz OPP so enable it for PG 2.0 on this board.
>>> +      */
>>> +     oppnitro-1000000000 {
>>> +             opp-supported-hw =3D <0x06 0x0100>;
>>> +     };
>>> +};
>>=20
>> Is the above valid for new boards or should it be just
>> dropped? Or is the comment just out of date?
>=20
> For SanCloud, this can be dropped, they got normal 1Ghz parts from TI.
>=20
> and they aren't using the Octavo SIP which didn't have the 1Ghz efuse =
set..
>=20
> So just the normal am335x errata, nothing special required in it=E2=80=99=
s dts...

Thanks for the info! I=E2=80=99ll send a v3 with that bit removed =
shortly after I figure out what trips up kbuild.

regards,

Koen=
