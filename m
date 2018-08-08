Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B4EC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B613E21708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGG0pOcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B613E21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeHHIdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbeHHIdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:33:12 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0679D21708;
        Wed,  8 Aug 2018 06:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533708903;
        bh=UzacX+8z50w+Zs5knR2gyYQzkQ38DlPT9/dEbKpUhrM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=uGG0pOcvXh4k//ejrLkxx5NO89Hcx4WdwJu2P1sSUjqZWJOK5Jn9sQDdOpotVCDuf
         Cau143Y4sQaw8LyevAl8oN1z7sbhaPexqbH3/zyaNiMLiyT1Mt83qNPQqoMljHzZFG
         kcj+W0WIg9udjom8AbOVCzCooA3Fdp2q7sZlLz9U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Taniya Das <tdas@codeaurora.org>, skannan@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1aa8b42d-721f-1f5b-b1be-a6b4f220d023@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
 <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
 <b362d9f769fde3ce1a2dcd89f20eb476@codeaurora.org>
 <20180807111237.GA1588@e107155-lin>
 <74d27daca2bb03716fc84f9c57118af0@codeaurora.org>
 <1aa8b42d-721f-1f5b-b1be-a6b4f220d023@codeaurora.org>
Message-ID: <153370890232.220756.13782706852981763402@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware
 bindings
Date:   Tue, 07 Aug 2018 23:15:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-08-07 19:46:01)
> =

> =

> On 8/8/2018 12:54 AM, skannan@codeaurora.org wrote:
> > On 2018-08-07 04:12, Sudeep Holla wrote:
> >> On Mon, Aug 06, 2018 at 01:54:24PM -0700, skannan@codeaurora.org wrote:
> >>> On 2018-08-03 16:46, Stephen Boyd wrote:
> >>> >Quoting Taniya Das (2018-07-24 03:42:49)
> >>> >>diff --git
> >>> >>a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> >>> >>b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> >>> >>new file mode 100644
> >>> >>index 0000000..22d4355
> >>> >>--- /dev/null
> >>> >>+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> >>> >>@@ -0,0 +1,172 @@
> >>> >[...]
> >>> >>+
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CPU7: cpu@700 {
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_t=
ype =3D "cpu";
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatib=
le =3D "qcom,kryo385";
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D =
<0x0 0x700>;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable-m=
ethod =3D "psci";
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next-lev=
el-cache =3D <&L2_700>;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcom,fre=
q-domain =3D <&freq_domain_table1>;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L2_700: =
l2-cache {
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "cache";
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next-level-cache =3D <&L3_0>;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 };
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>> >>+
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcom,cpufreq-hw {
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 compatible =3D "qcom,cpufreq-hw";
> >>> >>+
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 clocks =3D <&rpmhcc RPMH_CXO_CLK>;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 clock-names =3D "xo";
> >>> >>+
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 #address-cells =3D <2>;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 #size-cells =3D <2>;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ranges;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 freq_domain_table0: freq_table0 {
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D =
<0 0x17d43000 0 0x1400>;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 };
> >>> >>+
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 freq_domain_table1: freq_table1 {
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D =
<0 0x17d45800 0 0x1400>;
> >>> >>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 };
> >>> >
> >>> >Sorry, this is just not proper DT design. The whole node should have=
 a
> >>> >reg property, and it should contain two (or three if we're handling =
the
> >>> >L3 clk domain?) different offsets for the different power clusters. =
The
> >>> >problem seems to still be that we don't have a way to map the CPUs to
> >>> >the clk domains they're in provided by this hardware block. Making
> >>> >subnodes is not the solution.
> >>>
> >>> The problem is mapping clock domains to logical CPUs that CPUfreq =

> >>> uses. The
> >>> physical CPU to logical CPU mapping can be changed by the kernel (even
> >>> through DT if I'm not mistaken). So we need to have a way to tell in =
DT
> >>> which physical CPUs are connected to which CPU freq clock domain.
> >>>
> >>
> >> How about passing CPU freq clock domain id as along with phandle in
> >> qcom,freq-domain ?
> > =

> > Now sure what you mean here. There's no such this as CPUfreq clock =

> > domain id. It has policies that are made up of logical CPU numbers. =

> > Logical CPU is not something that you can fix in DT.
> > =

> > -Saravana
> =

> Sudeep,
> =

> Earlier the design was the freq_domain would take the CPU phandles
> =

> freq_domain:
>    cpus =3D <&cpu0 &cpu1....>;
> =


I believe Sudeep is recommending something I recommended earlier. It
would look like:

   cpu7 {
	   qcom,freq-domain =3D <&cpufreq_hw 1>;
   }

to indicate that cpu7 is in cpufreq_hw's frequency domain #1. That
should probably be called clk domain BTW.

If that was done with a phandle and a single cell, then we should have
something similar on the cpufreq_hw node side indicating how to parse
the cells in qcom,freq-domain. A property like #qcom,freq-domain-cells =3D
<1> to indicate that one u32 follows the phandle.

