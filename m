Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E07C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6B20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544751181;
	bh=K00Lrc3GKoKq+4s3zox31cIyCwz/5o6A2f36b6jDGBc=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=Ud8QUhezWcDszjtJ6E3VoyT6I3jAReLtoZ9xJmiUAO+wul/9yvzhWaZwVWg6I1062
	 SE2N7IOH7CAdgKsmLgKLdqjFMY/z31fpjco2v3xn/RY/OqOw33S1eedxFx89DdtOzb
	 Q7kqmmzjFmWUgRQ1v4xP7BnJnIqGKWvytWePSfVk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF6B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbeLNBdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:33:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbeLNBc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:32:59 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4942075B;
        Fri, 14 Dec 2018 01:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544751179;
        bh=K00Lrc3GKoKq+4s3zox31cIyCwz/5o6A2f36b6jDGBc=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=Aoj4LBuQey3ql1SIBr/oWUtjbsiGvEp+v56KbXybfStI5CzU+cHPm90KlIWY0390C
         oITW70a+vIN0rDYeaOIXdSN04B1bCzPyW8H2HJqeE37bhNdlv2Z4T1pX1tl4D6hOy1
         tD9NP25PufTvXtiXufTBwyiT12lqNGjYABhlamaI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d7ac2e27-8e9e-7ee1-430d-ed0f61d98171@codeaurora.org>
Subject: Re: [PATCH v2] clk: qcom: Drop unused 8998 clock
To:     Jeffrey Hugo <jhugo@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com
References: <1544720949-18404-1-git-send-email-jhugo@codeaurora.org> <154472988944.19322.6557891989616167911@swboyd.mtv.corp.google.com> <d7ac2e27-8e9e-7ee1-430d-ed0f61d98171@codeaurora.org>
Message-ID: <154475117840.19322.15245180996092285862@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr
Date:   Thu, 13 Dec 2018 17:32:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-13 14:32:12)
> On 12/13/2018 12:38 PM, Stephen Boyd wrote:
> > Quoting Jeffrey Hugo (2018-12-13 09:09:09)
> >> gcc_lpass_trig_clk is not used downstream, therefore there is no reaso=
n to
> >> expect it to be needed for clients.  Let's remove it because messing w=
ith
> >> the clock has been observed to cause Linux hangs when the qdss_clk is
> >> initialized by rpmcc.
> >>
> >> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> >> Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> >> ---
> >>
> >> v2:
> >> -corrected commit text per Marc
> >> -added Marc's reviewed-by
> >=20
> > Please slow down. There isn't any need to resend for such things.
> >=20
>=20
> Sorry.  Used to other maintainers.
>  From your v1 comment, would be
> Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
> I'm assuming from the above, you'll just apply the tag when you apply=20
> the change.
>=20

Hmm I already marked it as 'changes requested' but OK, I can pick it up
and add the fixes tag now.

