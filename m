Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C948C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B23C21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="kBtZyQmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfAJFbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 00:31:42 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:32254 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfAJFbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 00:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547098300;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8N6lYespEPyDCyHZjmKSILkug9GjXLIl+0aqj5JnK3E=;
        b=kBtZyQmnn2dIwlG0uugnizb4htGE7L+hdaFseC6T7dHcqXEFkG/UxpdAxpuyaIQFtI
        L/LZ0yoaZhQ8pYj0tJwIRv7UEMpB7tNTGEgbT00k6r+oY/XQeUlyoUNcjwXBwYR4yPMe
        NIyAppoejInLswfpn2tS+JGLH/bFeS/N6ENJF/xWfZ5nhUc6OB0TEdssQDzMzV5pVWI+
        EW5Bwf1qv8Sq3Nq3nOyBTDkWZXUZYSC66W1WT5zvfVBpaV8q/cPwV+FvhPpD+9xdLALF
        6R+ei/d6QgCPAAnf/PLos8fUmyV+PW/IzjeGNzsFo+EtXVDHg1d8Wiz6UKQeoPfTQACs
        hXQA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMmw4rtlQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v0A5VWT9A
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 10 Jan 2019 06:31:32 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] ARM: dts: omap3-gta04: Fix graph_port warning
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190109213903.GV5544@atomide.com>
Date:   Thu, 10 Jan 2019 06:31:31 +0100
Cc:     Rob Herring <robh@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8674356B-8688-49B6-AB72-16A991124A73@goldelico.com>
References: <97349a696b43af65d62b5d8e795ec3771b5e78bd.1547060514.git.hns@goldelico.com> <CAL_JsqLhGGx_amtDSZh3OJ+Tq-Oziu450NOt4Z+aoQMt-JY46Q@mail.gmail.com> <20190109213903.GV5544@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 09.01.2019 um 22:39 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * Rob Herring <robh@kernel.org> [190109 19:38]:
>> On Wed, Jan 9, 2019 at 1:02 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>=20
>>> From: Tony Lindgren <tony@atomide.com>
>>>=20
>>> We're currently getting a warning with make dtbs:
>>>=20
>>> arch/arm/boot/dts/omap3-gta04.dtsi:720.7-727.4: Warning =
(graph_port):
>>> /ocp@68000000/dss@48050000/encoder@48050c0 0/port: graph node unit
>>> address error, expected "0"
>>>=20
>>> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>=20
>> Acked-by: Rob Herring <robh@kernel.org>
>=20
> Nikolaus, care to reply with your Signed-off-by since
> you also edited the patch?

Sorry, I forgot (too busy with other topics)...

Here:

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

BR and thanks,
Nikolaus

