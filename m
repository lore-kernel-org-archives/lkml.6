Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B969C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0262C208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544689689;
	bh=tOMKDE3cNugN9dRPWFrgyKEAFi87eIaC4ZInHdC+j6U=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=Vxv78B8fZMbEfarjY+m9bZT3Sy+rFtxmETHtndHPAEcajbglXyrtXimy/sVaC2nSE
	 4oobb/sKJGiJT+yv4vpIsNWgmvmhAzEaiB/jXmM/9JoS+DVEkpW2udci/3dipGQFYP
	 FwU8YMeUOtHu1G7XrsSUUBxeSbamlbIZ0AOCQrc8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0262C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeLMI2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:28:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbeLMI2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:28:07 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03FA520811;
        Thu, 13 Dec 2018 08:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544689687;
        bh=tOMKDE3cNugN9dRPWFrgyKEAFi87eIaC4ZInHdC+j6U=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=pr9hHsg0V2cKUgmmbLfBUBGK0Cz2uIW5+sshUgAThMqsaSJkPcqGlmDyJYCPchePN
         MJXB8Z/ZcGk9o8dpiLuKSVOJQ1IWK4WfYp1eo1JKO8q/+QNvf4C0gp/BUdAsYFIJuM
         vrc/eI4mTXgdbtL4lpQ+t0ZldGyNQB2S8ugrxqsU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544687394-331-2-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v12 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware bindings
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-2-git-send-email-tdas@codeaurora.org>
Message-ID: <154468968610.19322.9386616050590076502@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 13 Dec 2018 00:28:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-12 23:49:53)
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.tx=
t b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..2b82965
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,172 @@
[...]
> +- reg-names
> +       Usage:          Optional
> +       Value type:     <string>
> +       Definition:     Frequency domain name i.e.
> +                       "freq-domain0", "freq-domain1".
> +
> +- freq-domain-cells:

Should be #freq-domain-cells? Or maybe #qcom,freq-domain-cells?

> +       Usage:          required.
> +       Definition:     Number of cells in a freqency domain specifier.
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" propert=
y with
> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT nod=
e.
> +
> +
