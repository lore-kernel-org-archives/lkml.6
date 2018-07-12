Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E09ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B421E2148C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOD4Ejhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B421E2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbeGMABy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387709AbeGMABy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:01:54 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94F0C20BF2;
        Thu, 12 Jul 2018 23:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531439400;
        bh=tLHjJxvJ5FcVUy/UQJlfY3F2FRgRvMFndwIxdIosTvQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=iOD4EjhdHqbdz5ETRB65Y2FnU5irBMdu3lz9Hm4DiTLs3sewwZWwd+BVGCZhJLfNw
         w/e/U+kr+DNu8MtzQEVQX583P/hEkkbcfD1Rse7ylHtbbaaWHbj/pXe6fqC1vjf0VS
         VgMKOWWwxhbsoPf+CjAWEVLqarzaVSuixUR/xmww=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531418745-19742-2-git-send-email-tdas@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com, Taniya Das <tdas@codeaurora.org>
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153143939986.48062.4653224503139250796@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware
 bindings
Date:   Thu, 12 Jul 2018 16:49:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-12 11:05:44)
[..]
> +                       compatible =3D "qcom,kryo385";
> +                       reg =3D <0x0 0x600>;
> +                       enable-method =3D "psci";
> +                       next-level-cache =3D <&L2_600>;
> +                       qcom,freq-domain =3D <&freq_domain_table1>;
> +                       L2_600: l2-cache {
> +                               compatible =3D "cache";
> +                               next-level-cache =3D <&L3_0>;
> +                       };
> +               };
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

It seems that we need to map the CPUs in the cpus node to the frequency
domains in the cpufreq-hw node. Wouldn't that be better served via a
#foo-cells and <&phandle foo-cell> property in the CPU node? It's
annoying that the cpufreq-hw node doesn't have a reg property, when it
really should have one that goes over the whole register space (or is
split across the frequency domains so that there are two reg properties
here).

