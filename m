Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC19C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67853208AF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/PFF2QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67853208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbeHDBpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 21:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731925AbeHDBpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 21:45:18 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DED6208AF;
        Fri,  3 Aug 2018 23:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533340011;
        bh=b/83xKUMTPC1OydhM1J+PFsJlYfcgx9J6v6v1JQyL7c=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=V/PFF2QS8V7xQ1NFSAX1uj93rX/+ixCBXE6/RmG6TDHHMD2L2YLHYLLAwo8ZHfFHW
         z19+qRWGcapUm2yCC5/095jnJdcrrE8mimj0jiveXQ0xjtlvDoBQoJKOz4wVsPG8iH
         5G/IYhjJQ4n+l+1MAnoLKqa/9Xhj8NNaAMf38l0w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com, Taniya Das <tdas@codeaurora.org>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153334001055.10763.8002698033760154254@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware
 bindings
Date:   Fri, 03 Aug 2018 16:46:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-24 03:42:49)
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.tx=
t b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..22d4355
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,172 @@
[...]
> +
> +               CPU7: cpu@700 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "qcom,kryo385";
> +                       reg =3D <0x0 0x700>;
> +                       enable-method =3D "psci";
> +                       next-level-cache =3D <&L2_700>;
> +                       qcom,freq-domain =3D <&freq_domain_table1>;
> +                       L2_700: l2-cache {
> +                               compatible =3D "cache";
> +                               next-level-cache =3D <&L3_0>;
> +                       };
> +               };
> +       };
> +
> +       qcom,cpufreq-hw {
> +               compatible =3D "qcom,cpufreq-hw";
> +
> +               clocks =3D <&rpmhcc RPMH_CXO_CLK>;
> +               clock-names =3D "xo";
> +
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +               freq_domain_table0: freq_table0 {
> +                       reg =3D <0 0x17d43000 0 0x1400>;
> +               };
> +
> +               freq_domain_table1: freq_table1 {
> +                       reg =3D <0 0x17d45800 0 0x1400>;
> +               };

Sorry, this is just not proper DT design. The whole node should have a
reg property, and it should contain two (or three if we're handling the
L3 clk domain?) different offsets for the different power clusters. The
problem seems to still be that we don't have a way to map the CPUs to
the clk domains they're in provided by this hardware block. Making
subnodes is not the solution.

