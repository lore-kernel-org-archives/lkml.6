Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18144C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE72D20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544042797;
	bh=HcYbkHNtEjd1cFP688ozN14Y+b17a8MOkC2JJTvTDZU=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=JXPLaK7wTKphqpxJUev7d7853+it8GmLZSDXaKeXwpGIEO8mKBHJn6n/R6SGqRz7g
	 bLncnpUQYJJIA8RmolnzQuxYU4SUThewNu6tiaG19020b0zI0F+jTxaCOXhaLdLUiJ
	 AKolkk7eLN1zgVPp/jL7bx9mdp1kuFVgkEs8FFU8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE72D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeLEUqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLEUqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:46:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3190020892;
        Wed,  5 Dec 2018 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544042795;
        bh=HcYbkHNtEjd1cFP688ozN14Y+b17a8MOkC2JJTvTDZU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=zeCvrVCpVdbmnfK4uGQpQghFJir0jVY0Bzp/w8zr3uLme5HXO27avbuRj1PVBNZi8
         2swFLz/miIi7Sq6DDGuKwCC9vGTkMj/X4BuOTvtXpPcAT+MWySjd8SozB8i9z0Q5wZ
         9TSIpJrysRZEcYmdZyMpzT8IWtyDowtGgFcgiwJU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <c1676ab0-5981-52be-18f3-44ee266e195d@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-5-rnayak@codeaurora.org>
 <154396526967.88331.13652897075952274639@swboyd.mtv.corp.google.com>
 <d9317471-fb81-482a-22c1-4a7b466a1df4@codeaurora.org>
 <c1676ab0-5981-52be-18f3-44ee266e195d@codeaurora.org>
Message-ID: <154404279451.88331.7119708379799744446@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 4/8] soc: qcom: rpmpd: Add support for get/set performance
 state
Date:   Wed, 05 Dec 2018 12:46:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-05 02:11:22)
> =

> On 12/5/2018 12:33 PM, Rajendra Nayak wrote:
> >>
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A00;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of_node_put(np);
> >>
> >> This=C2=A0same=C2=A0code=C2=A0exists=C2=A0twice.=C2=A0Perhaps=C2=A0a=
=C2=A0helper=C2=A0needs=C2=A0to=C2=A0exist=C2=A0for
> >> qcom_rpm_get_performance()=C2=A0to=C2=A0pull=C2=A0the=C2=A0number=C2=
=A0out=C2=A0of=C2=A0the=C2=A0DT.
> > =

> > Sure=C2=A0I=C2=A0can=C2=A0make=C2=A0both=C2=A0drivers=C2=A0use=C2=A0a=
=C2=A0common=C2=A0helper=C2=A0instead=C2=A0of=C2=A0duplicating=C2=A0it.
> =

> which would mean I will need to create a new file just to define the
> common helper. Does that seem like an overkill?

Maybe put it in the genpd code and let it take a const char *name
argument that picks out the property that drivers want to look at? That
way other OPP properties can be picked out with a simple call to the
function but it's generic enough to be used in other places.

