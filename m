Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFADC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB2F214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcjdSKaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB2F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeLDXQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:16:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDXQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:16:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA9F20879;
        Tue,  4 Dec 2018 23:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543965364;
        bh=GoqsxmlGrXzCU+dKPz7GO6DbC1GjrXIeWZxZuViDcOU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kcjdSKajaR0+jH9NAD8DVeW/rDf268KurfJ2Mt4VzcRGNWrOuLwFewyhiEI9Fkat5
         cuP3wC7GsiJu8QiniWN54n0l3vCcylnaKVqXnF1xwK/01s47K/wQ+pc6L+ua3LLQp7
         Ly+yRSJ2D5+mhKARw3s6JgFBXw2gsZqsnH6+BEbs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204052119.806-8-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-8-rnayak@codeaurora.org>
Message-ID: <154396536335.88331.9265777410326926096@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 7/8] arm64: dts: sdm845: Add rpmh powercontroller node
Date:   Tue, 04 Dec 2018 15:16:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-03 21:21:18)
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/q=
com/sdm845.dtsi
> index b72bdb0a31a5..a6d0cd8d17b0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1324,6 +1325,56 @@
>                                 compatible =3D "qcom,sdm845-rpmh-clk";
>                                 #clock-cells =3D <1>;
>                         };
> +
> +                       rpmhpd: power-controller {
> +                               compatible =3D "qcom,sdm845-rpmhpd";
> +                               #power-domain-cells =3D <1>;
> +                               operating-points-v2 =3D <&rpmhpd_opp_tabl=
e>;
> +                       };
> +
> +                       rpmhpd_opp_table: opp-table {

This table should go somewhere else? I don't understand why it's in the
rpmh node because it's not an rpmh device. Does it go to the root? Or
does it go under rpmhpd itself? I'm not sure.

