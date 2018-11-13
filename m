Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA51C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70035223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh/jooX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70035223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbeKNEAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbeKNEAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:00:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20BF0208A3;
        Tue, 13 Nov 2018 18:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542132059;
        bh=J3uakpHh7fKeIIghnPM2AVAXKvYmkkCidCykd9D6JQ8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=dh/jooX4RltuT40Ow4QYJ9VcRWFPFBY9fBrhefh5ItjP229HQID5qGmUwRNJpvmR1
         18z3RP58qqA06LQThm4YRkenSdUd12GPBJlJ3WcBfgfSl6MqCSFpG7tOk4dijuMJ5J
         mHUX6Cy5WUzdw9I2sONPACLBRPx7wUYjhjGEksnQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Ryder Lee <ryder.lee@mediatek.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181113095210.mh3iy5tcsu6w6tem@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        John Crispin <john@phrozen.org>, kernel@pengutronix.de,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <20181113095210.mh3iy5tcsu6w6tem@pengutronix.de>
Message-ID: <154213205843.88331.7023190778461777093@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Date:   Tue, 13 Nov 2018 10:00:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2018-11-13 01:52:10)
> =

> I wonder if it would make sense to introduce functions like:
> =

>         struct clk *clk_get_optional(struct device *dev, const char *id)
> =

> that return NULL instead of ERR_PTR(-ENODEV).
> =

> Then the above would simplify to:
> =

>         pc->clks[i] =3D devm_clk_get_optional(&pdev->dev, mtk_pwm_clk_nam=
e[i]);
>         if (IS_ERR(pc->clks[i]) {
>                 if (PTR_ERR(pc->clks[i]) =3D=3D -EPROBE_DEFER)
>                         dev_err(...);
>                 return PTR_ERR(pc->clks[i]);
>         }
> =

> (added the clk people to Cc for this question).
> =


Such a patch is already on the list and not getting much review.

http://lkml.kernel.org/r/1535724443-21150-1-git-send-email-phil.edworthy@re=
nesas.com

