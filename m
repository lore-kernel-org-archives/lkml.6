Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C318C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B952084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kj+il6zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B952084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeLJMHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:07:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39548 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeLJMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:07:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBAC6klv060754;
        Mon, 10 Dec 2018 06:06:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544443607;
        bh=SoIHMtUTNlfSVDIq9B3xkSQBtFVNdE1rVVqkyNUwkbY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Kj+il6zEk3LprbloS0GylZFl7IlYxPosj43YMYau3UDWeaJCa4d7/5sbzgBDXJ1SC
         A/tPzsk0cU6ab3ciGAA8U3vlHKfwFFoawA68DKvR3u9BS7xhKG0ZhZO6S8RmNHxYxa
         bUALwwsiz+51xzUt6+yuMqf4zwEDapQrMXBEy6ik=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBAC6kgf081800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 06:06:46 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 06:06:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 06:06:46 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBAC6kT9008560;
        Mon, 10 Dec 2018 06:06:46 -0600
Date:   Mon, 10 Dec 2018 06:06:48 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>
CC:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>, <kishon@ti.com>,
        <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
Message-ID: <20181210120647.i3ply3p7umvedb3u@akan>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
 <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:33-20181210, Sekhar Nori wrote:
> On 08/12/18 9:24 PM, Nishanth Menon wrote:
> > On 14:12-20181207, Faiz Abbas wrote:
> > 
> >> +
> >> +&sdhci0 {
> >> +	status = "okay";
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&main_mmc0_pins_default>;
> >> +	bus-width = <8>;
> >> +	non-removable;
> >> +	ti,driver-strength-ohm = <50>;
> > 
> > ^^
> > 
> >> +};
> >> +
> >> +&sdhci1 {
> >> +	status = "okay";
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&main_mmc1_pins_default>;
> >> +	ti,driver-strength-ohm = <50>;
> > 
> > NAK.
> > 
> > $ git checkout next-20181207
> > $ git grep ti,driver-strength-ohm Documentation
> > $
> > 
> > Nada.. And.. I think "new phy binding" probably introduces this.
> > [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=53185
> > 
> > If your patches are'nt really ready, please send them as RFC, I am not
> > really in a mood to track the status of every single driver subsystem.
> > 
> > If your binding is not in linux next at the baremin, as far as I am
> > concerned, this is not ready, and should be RFC.
> 
> No, RFC does not say "do not merge" or "this has dependencies". RFC is
> used to invite a stronger review when introducing a new concept. Its
> fair game to apply patches marked RFC if maintainer is okay with the
> content.

True, fair enough.. RFC is request for comments. Anyways, that is
besides the point.
> 
> Dependencies are either noted in cover-letter or below the patch
> tear-line. With what you are asking, looks like patches need to be
> resubmitted once dependencies are cleared, even if there is no change in
> the content itself. This will be additional work.

Yes please. There would be other dts changes that are probably ready and
I really wont be tracking everything happening on other drivers. If the
binding is present at least in next, it is a good indication of things
clean and ready to go.

> 
> That said, if it makes life convenient for you, you can impose such a
> rule for patches you need to handle. But I think it will take some
> getting used for developers who send patches to you as I don't think
> this is a norm elsewhere.
> 
> Adding Tony and Arnd as well, in case I have missed some recently
> accepted convention.


I have'nt looked at any conventions, The style I prefer to follow when I do
submissions: It is my job to get the bindings in, until then my actual
dts is just "request for comments". Only after the bindings are merged
do I formally submit dts - simply because I dont expect dts maintainer
to track what happened to my driver's binding and discussions there of.

Seriously, is'nt it really reasonable for dts maintainer to check every
single driver's development status in 15 different mailing lists?
Because, it sounds like what you are asking. At least I wont have time
for it..


I really am curious how Arnd / Tony actually pull this one off.. If they
have continous cron job for checking if your patch is ready... I doubt
it..

-- 
Regards,
Nishanth Menon
