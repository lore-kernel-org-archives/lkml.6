Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D6CC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABC12146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM0TKQou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABC12146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeK3Kum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:50:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbeK3Kum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:50:42 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391452145D;
        Thu, 29 Nov 2018 23:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543535007;
        bh=VTOUSgoDohd/abdwpPGvBCJvuutkWiX3bs+Fq8bo6u8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=KM0TKQouq7rP6NYhfa9LQTV1uib0nNpUpnXNXQo3BzIfoZWcsWXIk7AModXxwnLXd
         yG3F/3gA8hbh9QQSJsK8HcttVzSf6/YqzJ0m9uginf/HskkjgKJFDEEuZM2CDOwlhp
         gIQBPCg1DI4faG2Id1oo81ag/IYc2W3OHRt4ORK8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181129164524.18670-3-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129164524.18670-1-jbrunet@baylibre.com>
 <20181129164524.18670-3-jbrunet@baylibre.com>
Message-ID: <154353500665.88331.5525788751558555940@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] dt-bindings: clk: meson: add main controller clock input
Date:   Thu, 29 Nov 2018 15:43:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-11-29 08:45:23)
> Add the clock input of the main clock controller
> =

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.tx=
t b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> index e950599566a9..79454869f96d 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> @@ -9,6 +9,8 @@ Required Properties:
>                 "amlogic,gxbb-clkc" for GXBB SoC,
>                 "amlogic,gxl-clkc" for GXL and GXM SoC,
>                 "amlogic,axg-clkc" for AXG SoC.
> +- clocks: phandle to the input clock of the controller, presumably the
> +         platform xtal.

Any reason to not have clock-names? I'd prefer to have them because then
we can easily hook up providers with their parents based on strings. I
suppose we'll have to support both modes of strings and numbers for
connections, but that may be more for legacy reasons that could be
avoided here if a clock-names property existed.

>  =

>  - #clock-cells: should be 1.
> =20
