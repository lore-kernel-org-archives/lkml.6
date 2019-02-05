Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A61AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5CA217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549404093;
	bh=tSVh3Sl3VK8qd0dQtbdIttv/Jd9OeSHNmfP2fDL6QUk=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=PS9LfC5W8p7lVsFnnv15V/n8/1a7JB/FZ9kRhcdvgFEXvpG38/pKO15GhSushZO0a
	 vjpn04x2awWZ76SuEIcfmimyNjVULeoylAm00ZkB1JQXQJM+hEkzSch2u7SkRtFzly
	 IQnOR0nCS0C7+jHOHAItM68z696/sod13v3z3yiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfBEWBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfBEWBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:01:31 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B3A20823;
        Tue,  5 Feb 2019 22:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549404090;
        bh=tSVh3Sl3VK8qd0dQtbdIttv/Jd9OeSHNmfP2fDL6QUk=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=j74M2K0SnnGqVoxYLeHu62YJZEUZEVrESnf+wu549HOWwxBRO17kfCOaVhgE+qvvL
         ZQIzkjddi35pPmPFU/sS/45G2CXAsNZAxign46iNfr5612e+8UtMJGCm5MgntL+bTe
         pmFQgpHuPQ/JMlIQ6y5m3mwyXnY0TTkahG6O8T+E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/4] clk: qcom: smd: Add XO clock for MSM8998
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940408967.169292.15276398799323074789@swboyd.mtv.corp.google.com>
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org> <1548866144-30265-1-git-send-email-jhugo@codeaurora.org>
User-Agent: alot/0.8
To:     Jeffrey Hugo <jhugo@codeaurora.org>, bjorn.andersson@linaro.org,
        mturquette@baylibre.com
In-Reply-To: <1548866144-30265-1-git-send-email-jhugo@codeaurora.org>
Date:   Tue, 05 Feb 2019 14:01:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-01-30 08:35:44)
> The XO clock generally feeds into other clock controllers as the parent
> for a lot of clock generators.
>=20
> Fixes: 6131dc81211c (clk: qcom: smd: Add support for MSM8998 rpm clocks)
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

We've historically left out the XO clk because it causes problems where
the XO vote goes away during late init because nobody references it from
the rest of the clk tree and also because RPM defers probe of the system
and then the console blows up when it gets a clk that can't change rate.
See commit 54823af9cd52 ("clk: qcom: Always add factor clock for xo
clocks") for some more info on why we removed all the workarounds and
stuff around here too.

So are you sure this is OK to do?
=20
