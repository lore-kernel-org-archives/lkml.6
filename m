Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96360C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8BC21534
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rywh5jDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8BC21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHBSt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731210AbeHBSt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:49:58 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CFC521534;
        Thu,  2 Aug 2018 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533229079;
        bh=+ibXAt/LSB9W+gBMRSXvMkuhPDAlPhg4fVUK3FpEu8c=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Rywh5jDeZDyy0IxUu0/hn7xR3u7X1BMzdtOt89LecKk9RTbwyY4qHQP2fHn8uFgNB
         HWvf5O2WHc3PHRYje8U04gaY/0h6Y0RfWM5NApVmGLi0tqblg/G55ZFWLimQr8Pzh6
         2no5SpxZMspMz+81fUUMF7UI6t7n4muX+6dzV9PI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <614e462b0294a1ece78b654ad3e4553f@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
References: <1532345193-18108-1-git-send-email-anischal@codeaurora.org>
 <1532345193-18108-3-git-send-email-anischal@codeaurora.org>
 <153262575082.48062.16264904338225269915@swboyd.mtv.corp.google.com>
 <614e462b0294a1ece78b654ad3e4553f@codeaurora.org>
Message-ID: <153322907852.10763.2149017059137432779@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: Add camera clock controller driver for SDM845
Date:   Thu, 02 Aug 2018 09:57:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-07-30 00:20:52)
> On 2018-07-26 22:52, Stephen Boyd wrote:
> > Quoting Amit Nischal (2018-07-23 04:26:33)
> >> diff --git a/drivers/clk/qcom/camcc-sdm845.c =

> >> b/drivers/clk/qcom/camcc-sdm845.c
> >> new file mode 100644
> >> index 0000000..61e5ec2
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/camcc-sdm845.c
> >> +static struct clk_rcg2 cam_cc_bps_clk_src =3D {
> >> +       .cmd_rcgr =3D 0x600c,
> >> +       .mnd_width =3D 0,
> >> +       .hid_width =3D 5,
> >> +       .parent_map =3D cam_cc_parent_map_0,
> >> +       .freq_tbl =3D ftbl_cam_cc_bps_clk_src,
> >> +       .clkr.hw.init =3D &(struct clk_init_data){
> >> +               .name =3D "cam_cc_bps_clk_src",
> >> +               .parent_names =3D cam_cc_parent_names_0,
> >> +               .num_parents =3D 6,
> >> +               .flags =3D CLK_SET_RATE_PARENT,
> >> +               .ops =3D &clk_rcg2_shared_ops,
> > =

> > Why are shared ops used in this driver?
> > =

> =

> As per HW design, most of the CAMCC RCGs needs to move to
> XO during clock disable so because of this we have used the
> shared ops.

Please add a comment to this effect in this driver and also mention this
in the commit text. I guess the camera firmware is also doing clk
control and so it wants the clk to be on at some basic rate in case
that's happening?
 =

> >> +
> >> +static struct clk_rcg2 cam_cc_slow_ahb_clk_src =3D {
> >> +       .cmd_rcgr =3D 0x6054,
> >> +       .mnd_width =3D 0,
> >> +       .hid_width =3D 5,
> >> +       .parent_map =3D cam_cc_parent_map_0,
> >> +       .freq_tbl =3D ftbl_cam_cc_slow_ahb_clk_src,
> >> +       .clkr.hw.init =3D &(struct clk_init_data){
> >> +               .name =3D "cam_cc_slow_ahb_clk_src",
> >> +               .parent_names =3D cam_cc_parent_names_0,
> >> +               .num_parents =3D 6,
> >> +               .flags =3D CLK_SET_RATE_PARENT,
> > =

> > Is CLK_SET_RATE_PARENT intentionally set on these RCGs so that they can
> > reconfigure the PLL frequency? Wouldn't that be a fixed rate PLL
> > frequency?
> > =

> =

> PLL2_OUT_EVEN requires to be reconfigure to 480MHz so clock sources =

> which
> are using PLL2 in their frequency table requires 'CLK_SET_RATE_PARENT'
> flag to be set.

Ok.

