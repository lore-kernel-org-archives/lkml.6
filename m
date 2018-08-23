Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6233C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5563B208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="aiBFfDiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5563B208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeHWTLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:11:36 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:45158 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbeHWTLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:11:36 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2018 15:11:35 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3373841900;
        Thu, 23 Aug 2018 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:in-reply-to:mime-version:user-agent
        :date:date:message-id:from:from:references:subject:subject
        :received:received:received; s=mta-01; t=1535038336; x=
        1536852737; bh=wrzkmJ1WVBAkt2tfQoFCcBRgcUhOrApMLmTCQ61Hmz0=; b=a
        iBFfDiXAHUPlbrNkB54g3hQEH3bYdtMlxLSQh5q1aAdBT2Hud1t87zwTlZaCd8+x
        aMMBvl6YSHikjP3zrfJTTv1x4hSNKRTfwQfAcPN7d2jbavp1QiP8RgVjZf71GUrn
        0Aqrtk9yUPRssnV7MedXiXBSFpp8hjQ7SCEBqOMZCk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8jvLDnePbAme; Thu, 23 Aug 2018 18:32:16 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id F18E5400FD;
        Thu, 23 Aug 2018 18:32:13 +0300 (MSK)
Received: from [172.17.14.168] (172.17.14.168) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 23
 Aug 2018 18:32:13 +0300
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
To:     Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>, <Eugene.Cho@dell.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        <stewart@linux.ibm.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
 <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
 <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
 <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
 <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
 <1532045276.1219110.1446722072.546C1F9D@webmail.messagingengine.com>
From:   Alexander Amelkin <a.amelkin@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=a.amelkin@yadro.com; prefer-encrypt=mutual; keydata=
 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
 dTYsE5wSxM06T2l/MILupCNZ7A==
Message-ID: <81f3d73a-acce-6dad-2e65-49f499c60eb9@yadro.com>
Date:   Thu, 23 Aug 2018 18:32:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1532045276.1219110.1446722072.546C1F9D@webmail.messagingengine.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="iM8iBkc75YSfqsLQktDfdMLnrPLa1OPFd"
X-Originating-IP: [172.17.14.168]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--iM8iBkc75YSfqsLQktDfdMLnrPLa1OPFd
Content-Type: multipart/mixed; boundary="c0lFkrzp2zFaEVZ5fFUL92XCceQeTff0s";
 protected-headers="v1"
From: Alexander Amelkin <a.amelkin@yadro.com>
To: Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rob Herring <robh@kernel.org>, Eugene.Cho@dell.com
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 stewart@linux.ibm.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 linux-arm-kernel@lists.infradead.org
Message-ID: <81f3d73a-acce-6dad-2e65-49f499c60eb9@yadro.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
 <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
 <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
 <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
 <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
 <1532045276.1219110.1446722072.546C1F9D@webmail.messagingengine.com>
In-Reply-To: <1532045276.1219110.1446722072.546C1F9D@webmail.messagingengine.com>

--c0lFkrzp2zFaEVZ5fFUL92XCceQeTff0s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

20.07.2018 03:07, Andrew Jeffery wrote:
>> Andrew, can you start with a list that shows what you expect us to nee=
d
>> on our systems ?
>>
> Okay, our Witherspoon and Romulus platforms containing the ASPEED AST25=
00 currently need the following tuneables exposed:
>
> From the SCU:
> - Debug UART enable
> - VGA DAC mux
> - VGA scratch registers 0-7
> - LPC SuperIO decode enable
> - VGA MMIO decode enable
>
> From the LPC controller:
> - iLPC2AHB enable
> - SuperIO scratch registers 0x20-0x2f
>
> (The LPC controller is just as much of a collection of random bits as t=
he SCU)
>
> Lastly, our Palmetto platform uses an AST2400 which has fewer features =
compared to the AST2500. Its tuneable list is the same as the above with =
the exception of "Debug UART enable".
>
> Tuneables that we may need to expose in the future include:
>
> From the SCU:
> - PCI VID/DID for the BMC PCIe device
> - VGA device enable (may need to be disabled if the platform contains a=
 discrete graphics processor)
>
> From the LPC controller:
> - UART mux
>
> Alexander, Eugene, can you chime in with your platforms' needs?
In addition to what you've mentioned, we also need (and I believe you nee=
d it too) the SCU3C register (reset control/status) to determine the BMC =
reset reason and only perform certain actions on cold boots (see https://=
github.com/openbmc/openbmc/issues/3031). Although, this could probably be=
 handled by a separate driver, don't know which though.

Alexander.


--c0lFkrzp2zFaEVZ5fFUL92XCceQeTff0s--

--iM8iBkc75YSfqsLQktDfdMLnrPLa1OPFd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbftN9AAoJEOiTWHtbdBeNIXQQALW1FcU7PGgQzkQKjRy1gDYI
Q0UM3LRiQ+iw5qVlgR265yGXRBRiio+cjUJqEc7pA5TRo56eoNg4jRXq9oHiGFTZ
qI0WQSESP/kYwcyVqEPyudbKzL+Itu3KdnDLz2FFFwxq+IXSpFuNPB28hAFBdkvY
ev3Mf3Zo9vwPDP84E/6xR2E5uKNYICTEEhDcFvFCgrd4g4NFo/gAMJ9VnU89c/9J
VnlKOZxzn4AnmKUcAZFN82nDMCLmPnUJfjz6wayKbb+P2ZDiz31DxC2O8OzUn2uZ
uZfZWoP91xoF9hSn/IBO7UvWyne8+uE0ynal7vliqUPSKMkapjDPCpYZfnxEosKB
2K1wgzbcs7FPkP56ualqhGNUmh6ygmvbf8lB/TNhI5NUmNqraYjP2Z3CcvAx/T/y
tw55AiMAXSAoqgGxhzg4tt3hnP8uKKBqQJ8XbR/PzF3vmddYxhSrp7h2wEYl3V1/
yNDBsnbJjcTzfyztKggpz7NYNPpLmmJ7tr3pz8A4RPaPOiaJRDIkCRbNlTuO9d/w
dKPU4u02iPb3n/aiStVNzG9licu0dLXP4UGlYpyq8azd94OLUy8wm5p3j8EP9sTf
GyJrH+gpmLjekXs8KID/SLyYuONmJHnZb6rxTeB4CW1Gym/7q81jW5wy8U9qbu0h
YgZRlXeLcCvU6xV8nc7M
=ifRg
-----END PGP SIGNATURE-----

--iM8iBkc75YSfqsLQktDfdMLnrPLa1OPFd--
