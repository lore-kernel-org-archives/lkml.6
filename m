Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CD2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA58208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tks45sSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA58208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbeKOIlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeKOIlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:41:35 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2341208E7;
        Wed, 14 Nov 2018 22:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234987;
        bh=wboetNNDa5EjVI+Fey9HYR7pdOO6vMD1/BcaGPAem0M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Tks45sScnNBYwl/gPyorEjTWNRZdML6khCGKSb+rikBo5ik+2LmdUX/WcS/gnt4Kv
         jEGtMK39qaH7kocS25e4eASVn6NGbOxIOL8tf2cO8olsxPxg7R3wNqOBaN7POTaEfd
         KGQmEQxCXopPr4y5+NuMK89GYc4VTlrfoT3T8mGQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Janek Kotas <jank@cadence.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1B94C733-F941-4403-9498-4BBB35B25345@global.cadence.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1B94C733-F941-4403-9498-4BBB35B25345@global.cadence.com>
Message-ID: <154223498711.88331.11553475442681784637@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: clk: Add bindings for Fixed MMIO clock
Date:   Wed, 14 Nov 2018 14:36:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janek Kotas (2018-11-14 07:24:21)
> +
> +Required properties:
> +- compatible : shall be "fixed-mmio-clock".
> +- #clock-cells : from common clock binding; shall be set to 0.
> +- reg : Address and length of the clock value register set.
> +
> +Optional properties:
> +- clock-output-names : From common clock binding.
> +
> +Example:
> +sysclock: sysclock@fd020004 {
> +       #clock-cells =3D <0>;
> +       compatible =3D "fixed-mmio-clock";
> +       reg =3D <0xfd020004 0x4>;

Unfortunately this looks wrong and seems to be a way to split up a
hardware IP block into many little DT nodes to describe clks inside of a
clock controller. We don't do that style of clk drivers anymore.

