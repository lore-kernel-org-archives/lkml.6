Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73395C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3315B20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549404366;
	bh=w81ITJMN8u+b48e9VWxQXXngvjnJaSMFPdzCoNer34w=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=iHy1vs+RzLC8ppHLyC44yE4C8SVzrYdue4U3UlePKAChl37uE3xICz5lf0T1ejtds
	 e74BA8FKBP+Pg9zvnlML1yFp6IAF+OWMoir5+sNv6MgXGzvIhM3lMiTH68MN0qCnQp
	 CMqZR/kLmtmYPgVVdgLz07B/7baM2tSw94Vd3KPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfBEWGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEWGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:06:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F5C20823;
        Tue,  5 Feb 2019 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549404363;
        bh=w81ITJMN8u+b48e9VWxQXXngvjnJaSMFPdzCoNer34w=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=F72GfywqCJD21WGno8EeI3vBg+Rz30zNXog6KIi0uqqzqx3HwTlZF5Be2sI+dfKTx
         DnQKrYxE/RkB8zhWjORYQ0fdo2ANlKL40tT8kmiV0B0hX9rp5Dtd84ZeBgaDcAURSk
         GfsyDwbEncaKGg2/0gbKWW7ukCw2SWnHoby/ZJ1Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/4] clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940436246.169292.7591382350282828249@swboyd.mtv.corp.google.com>
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org> <1548866171-30341-1-git-send-email-jhugo@codeaurora.org>
User-Agent: alot/0.8
To:     Jeffrey Hugo <jhugo@codeaurora.org>, bjorn.andersson@linaro.org,
        mturquette@baylibre.com
In-Reply-To: <1548866171-30341-1-git-send-email-jhugo@codeaurora.org>
Date:   Tue, 05 Feb 2019 14:06:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-01-30 08:36:11)
[..]
> +};
> +MODULE_DEVICE_TABLE(of, mmcc_msm8998_match_table);
> +
> +static int mmcc_msm8998_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       int i, ret;
> +       struct regmap *regmap;
> +       struct clk *c;
> +
> +       c =3D devm_clk_get(dev, "xo");
> +       if (!IS_ERR(c))
> +               dummy_xo_init.parent_names =3D
> +                                       (const char *[]){__clk_get_name(c=
)};
> +       else
> +               return PTR_ERR(c);
> +
> +       c =3D devm_clk_get(dev, "gpll0");
> +       if (!IS_ERR(c))
> +               dummy_gpll0_init.parent_names =3D
> +                                       (const char *[]){__clk_get_name(c=
)};
> +       else
> +               return PTR_ERR(c);

Urgh, my parent mapping series can't come be merged fast enough it
seems!

> +
> +       regmap =3D qcom_cc_map(pdev, &mmcc_msm8998_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mmcc_msm8998_hws); i++) {
> +               ret =3D devm_clk_hw_register(dev, mmcc_msm8998_hws[i]);

I think we should make this common to the qcom_cc_desc now. Can you
throw in an optional list of clk_hw pointers that also get registered as
its own patch and update the existing drivers that are all doing this?

> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return qcom_cc_really_probe(pdev, &mmcc_msm8998_desc, regmap);
> +}
