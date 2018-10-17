Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DCECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D854208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZwEr7fC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D854208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJREOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeJREOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:14:14 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C84132087A;
        Wed, 17 Oct 2018 20:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539807413;
        bh=6uS8qxv84gXii5oCsFhQlxC9wIWv+MFbTAoVic9TDiQ=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=MZwEr7fCMBJJ1PS9lBw58/NXXiQssnGmsYmcBgNypIVK4Yem95LFj4AZz7ndEEZKD
         o6AvenjF0Bjc++VkT2+lnNMDNeFjRCS7vEIKEDxrS/7vr5K8mOqSkVifiEhYhY1nLd
         KTbxPLWrSVO9KBE8n94jnqCqdSV5YTrGBwBxjmaE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
To:     Craig <ctatlor97@gmail.com>,
        Sricharan R <sricharan@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux@arm.linux.org.uk,
        linux@armlinux.org.uk, mark.rutland@arm.com,
        mturquette@baylibre.com, niklas.cassel@linaro.org,
        rjw@rjwysocki.net, robh@kernel.org, sboyd@codeaurora.org,
        sudeep.holla@arm.com, thierry.escande@linaro.org,
        viresh.kumar@linaro.org
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <2ae96741-94c0-ba4c-fc19-05d33179683c@codeaurora.org>
 <d682580d-5070-0271-197f-29d988172937@codeaurora.org>
 <D8FC68C0-2572-4A86-81D9-D0099D314A45@gmail.com>
 <F5A89365-C613-4FE2-AD32-DC0AC6DF380B@gmail.com>
 <fb81b8d5-3d24-b413-8d59-33cb70e46f8b@codeaurora.org>
 <153979105280.5275.841088095583550635@swboyd.mtv.corp.google.com>
In-Reply-To: <153979105280.5275.841088095583550635@swboyd.mtv.corp.google.com>
Message-ID: <153980741313.5275.10376918222904341760@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH V12 00/14] Krait clocks + Krait CPUfreq
Date:   Wed, 17 Oct 2018 13:16:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-10-17 08:44:12)
> Quoting Sricharan R (2018-09-20 06:03:31)
> > =

> > =

> > On 9/20/2018 1:54 AM, Craig wrote:
> > > Yup, this patch seems to have fixed the higher frequencies from the q=
uick test I did.
> > >
> >       Thanks !!. Can i take that as =

> >           Tested-by: Craig Tatlor <ctatlor97@gmail.com>  ?
> > =

> =

> Is this patch series going to be resent?
> =


Nevermind. Looking at it I think I can apply all the clk ones and we're
good to go. If you can send a followup patch series to change the
registration and provider APIs to be clk_hw instead of clk based I would
appreciate it.

