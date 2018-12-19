Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E49DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC8021873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545192577;
	bh=9z1vdxsKHK1NMWKam1ZY98y9lqdHp7yfFFZgwu4/YfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=COaS6NTumsp51Y0iMfBVcJ9KsMHVxdysHhs2hN3AkMCAQ7rDKULZ+t5mruCDFlS3f
	 DON9flYn4Kcuc7L7MwjKD/sTAJKwV5itKI6Nk3JNW+f6Y+H9DoyIB/krPVYjEJ5b+g
	 lmnVcJ2gfU1caVUFSHOH1fSlXbeVprdzPVOMXGs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeLSEJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeLSEJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 23:09:34 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90721217D6;
        Wed, 19 Dec 2018 04:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545192573;
        bh=9z1vdxsKHK1NMWKam1ZY98y9lqdHp7yfFFZgwu4/YfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+HpzBzIZD7dUtvJxdIFUC9B8zCGWlMasPebNqFun5kPEF1N9u6Pw8Tpz/M0opzJb
         g8+w6QpT9oRmM1O4J9xwd6KipPj3QqV5uMz2rLXF3UgvXRbfo2Ofs6l/GPjdcaiHAi
         6XfFpBWlEjVvxLIlPbIiaR7hK1pAb+sD4ngnzyFk=
Date:   Wed, 19 Dec 2018 12:08:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: nxp: ls208xa: add more thermal zone support
Message-ID: <20181219040820.GA13728@dragon>
References: <20181031044742.26327-1-andy.tang@nxp.com>
 <VI1PR04MB433351E63826CC2128153943F3BD0@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB433351E63826CC2128153943F3BD0@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 07:01:32AM +0000, Andy Tang wrote:
> Hi,
> 
> PING.
> 
> BR,
> Andy
> 
> > -----Original Message-----
> > From: Yuantian Tang <andy.tang@nxp.com>
> > Sent: 2018年10月31日 12:48
> > To: shawnguo@kernel.org
> > Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; rui.zhang@intel.com; daniel.lezcano@linaro.org;
> > Andy Tang <andy.tang@nxp.com>
> > Subject: [PATCH] arm64: dts: nxp: ls208xa: add more thermal zone support
> > 
> > Ls208xa has several thermal sensors. Add all the sensor id to dts to enable
> > them.
> > 
> > To make the dts cleaner, re-organize the nodes to split out the common part so
> > that it can be shared with other SoCs.
> > 
> > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Please take a look at patch below.

https://patchwork.kernel.org/patch/10685815/

Shawn
