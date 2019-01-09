Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25CAC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3482075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547062114;
	bh=6U1KDrcsevcvwGfBKYeJgIPM7++biLKhzOrw9JS7jkA=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=ie5fcXcQEaRKsb0ybKJAkv492ep3kpVqH7g8OsIbbXZDOgZ6hqdHfbHoyGsYZ2yhh
	 9dTt9pMDoYG7mkR2ykxT8NFPJZESbhdnzVZLoWIMYPxLoUoGx9lCqFCtmL12jr1EyP
	 XCmeh3idnsvOcU+fheRz+G1yeZ8VRnM/KQZgjCwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfAIT2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfAIT2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:28:33 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B8A206BA;
        Wed,  9 Jan 2019 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547062112;
        bh=6U1KDrcsevcvwGfBKYeJgIPM7++biLKhzOrw9JS7jkA=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=wq46CGzb1bPdE9VvCLq/4GnDuGS5rm/SQUegpW13B/zxlqTCBmhyquq9KI2xlEmi+
         MZbfVm3bZbwqO53q6kIXQNBvf+REIMe54j0V6AF4Tdknto3XtCX/4PxJ4ZUDLmXVwA
         DnW+fkEUcxKudUJoOLsVz1Vk57fk7oEctIfmD8Z4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] clk: qcom: clk-rpmh: Add IPA clock support
Cc:     David Dai <daidavid1@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        tdas@codeaurora.org, elder@linaro.org
To:     David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1544754904-18951-1-git-send-email-daidavid1@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1544754904-18951-1-git-send-email-daidavid1@codeaurora.org>
Message-ID: <154706211110.15366.8008755843113316822@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 11:28:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Dai (2018-12-13 18:35:04)
> The current clk-rpmh driver only supports on and off RPMh clock resources,
> let's extend the current driver by add support for clocks that are managed
> by a different type of RPMh resource known as Bus Clock Manager(BCM).
> The BCM is a configurable shared resource aggregator that scales performa=
nce
> based on a preset of frequency points. The Qualcomm IP Accelerator (IPA) =
clock
> is an example of a resource that is managed by the BCM and this a require=
ment
> from the IPA driver in order to scale its core clock.

Please use this commit text instead:

   =20
The clk-rpmh driver only supports on and off RPMh clock resources. Let's
extend the driver by add support for clocks that are managed by a
different type of RPMh resource known as Bus Clock Manager(BCM). The BCM
is a configurable shared resource aggregator that scales performance
based on a set of frequency points. The Qualcomm IP Accelerator (IPA)
clock is an example of a resource that is managed by the BCM and this a
requirement from the IPA driver in order to scale its core clock.

>=20
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  drivers/clk/qcom/clk-rpmh.c           | 141 ++++++++++++++++++++++++++++=
++++++
>  include/dt-bindings/clock/qcom,rpmh.h |   1 +
>  2 files changed, 142 insertions(+)
>=20
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 9f4fc77..ee78c4b 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -18,6 +18,31 @@
>  #define CLK_RPMH_ARC_EN_OFFSET         0
>  #define CLK_RPMH_VRM_EN_OFFSET         4
> =20
> +#define BCM_TCS_CMD_COMMIT_MASK                0x40000000
> +#define BCM_TCS_CMD_VALID_SHIFT                29
> +#define BCM_TCS_CMD_VOTE_MASK          0x3fff
> +#define BCM_TCS_CMD_VOTE_SHIFT         0
> +
> +#define BCM_TCS_CMD(valid, vote)                               \
> +       (BCM_TCS_CMD_COMMIT_MASK |                              \
> +       ((valid) << BCM_TCS_CMD_VALID_SHIFT) |                  \
> +       ((cpu_to_le32(vote) &                                   \

Why?

> +       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_SHIFT))
> +
> +/**
> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(B=
CM)
> + * @unit: divisor used to convert Hz value to an RPMh msg
> + * @width: multiplier used to convert Hz value to an RPMh msg
> + * @vcd: virtual clock domain that this bcm belongs to
> + * @reserved: reserved to pad the struct
> + */
> +struct bcm_db {
> +       __le32 unit;
> +       __le16 width;
> +       u8 vcd;
> +       u8 reserved;
> +};
> +
>  /**
>   * struct clk_rpmh - individual rpmh clock data structure
>   * @hw:                        handle between common and hardware-specif=
ic interfaces
> @@ -29,6 +54,7 @@
>   * @aggr_state:                rpmh clock aggregated state
>   * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
>   * @valid_state_mask:  mask to determine the state of the rpmh clock
> + * @aux_data:          data specific to the bcm rpmh resource

But there isn't aux_data. Is this supposed to be unit? And what is unit
going to be? 1000?

>   * @dev:               device to which it is attached
>   * @peer:              pointer to the clock rpmh sibling
>   */
> @@ -42,6 +68,7 @@ struct clk_rpmh {
>         u32 aggr_state;
>         u32 last_sent_aggr_state;
>         u32 valid_state_mask;
> +       u32 unit;
>         struct device *dev;
>         struct clk_rpmh *peer;
>  };
> @@ -210,6 +248,91 @@ static unsigned long clk_rpmh_recalc_rate(struct clk=
_hw *hw,
>         .recalc_rate    =3D clk_rpmh_recalc_rate,
>  };
> =20
> +static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
> +{
> +       struct tcs_cmd cmd =3D { 0 };
> +       u32 cmd_state;
> +       int ret;
> +
> +       mutex_lock(&rpmh_clk_lock);
> +
> +       cmd_state =3D enable ? (c->aggr_state ? c->aggr_state : 1) : 0;

Make this into an if statement instead of double ternary?

	cmd_state =3D 0;
	if (enable) {
		cmd_state =3D 1;
		if (c->aggr_state)
			cmd_state =3D c->aggr_state;

	}

> +
> +       if (c->last_sent_aggr_state =3D=3D cmd_state)
> +               return 0;

We just returned with a mutex held. Oops!

> +
> +       cmd.addr =3D c->res_addr;
> +       cmd.data =3D BCM_TCS_CMD(enable, cmd_state);
> +
> +       ret =3D rpmh_write_async(c->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
> +       if (ret) {
> +               dev_err(c->dev, "set active state of %s failed: (%d)\n",
> +                       c->res_name, ret);
> +               return ret;

Again!

> +       }
> +
> +       c->last_sent_aggr_state =3D cmd_state;
> +
> +       mutex_unlock(&rpmh_clk_lock);
> +
> +       return 0;
> +}
> +
> +static int clk_rpmh_bcm_prepare(struct clk_hw *hw)
> +{
> +       struct clk_rpmh *c =3D to_clk_rpmh(hw);
> +       int ret;
> +
> +       ret =3D clk_rpmh_bcm_send_cmd(c, true);
> +
> +       return ret;

Just write return clk_rpmh_bcm_send_cmd(...)

> +};
> +
> +static void clk_rpmh_bcm_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_rpmh *c =3D to_clk_rpmh(hw);
> +
> +       clk_rpmh_bcm_send_cmd(c, false);
> +};
> +
> +static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                unsigned long parent_rate)
> +{
> +       struct clk_rpmh *c =3D to_clk_rpmh(hw);
> +
> +       c->aggr_state =3D rate / c->unit;
> +       /*
> +        * Since any non-zero value sent to hw would result in enabling t=
he
> +        * clock, only send the value if the clock has already been prepa=
red.
> +        */
> +       if (clk_hw_is_prepared(hw))

This is sad, but OK.

> +               clk_rpmh_bcm_send_cmd(c, true);
> +
> +       return 0;
> +};
> +
[...]
> @@ -217,6 +340,7 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_=
hw *hw,
>  DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 1);
>  DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 1);
>  DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 1);
> +DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");

It's really IP0?! What was wrong with IPA?

> =20
>  static struct clk_hw *sdm845_rpmh_clocks[] =3D {
>         [RPMH_CXO_CLK]          =3D &sdm845_bi_tcxo.hw,
> @@ -275,6 +402,20 @@ static int clk_rpmh_probe(struct platform_device *pd=
ev)
>                                 rpmh_clk->res_name);
>                         return -ENODEV;
>                 }
> +
> +               data =3D cmd_db_read_aux_data(rpmh_clk->res_name, &aux_da=
ta_len);
> +               if (IS_ERR(data)) {
> +                       ret =3D PTR_ERR(data);
> +                       dev_err(&pdev->dev,
> +                               "error reading RPMh aux data for %s (%d)\=
n",
> +                               rpmh_clk->res_name, ret);
> +                               return ret;

Weird indent here.
