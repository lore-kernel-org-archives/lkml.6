Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FBAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7515220936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S+46w3MB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YCzQPzmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7515220936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbeGJWdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:33:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732264AbeGJWdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:33:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8E33B60B3C; Tue, 10 Jul 2018 22:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531261933;
        bh=3p1kNccCejyqLE7T2cmrT/bytNU84C5uAKIG15ba12c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S+46w3MBCJyHR504DqSm2laG+3DaeNG1UTTtpeoNbTqu24r+mRAEjE6VQDrAkMUpU
         rvbsd1+NGn+Uf3QnHScvY4t0LhqUTz4aBv4+aZ19FdjxJmdULkLactUak2Uu84errO
         a/RpLAb3gEaCU8T+Ps24jzVI+8KMFlva0yjn663o=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC7C6601CF;
        Tue, 10 Jul 2018 22:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531261932;
        bh=3p1kNccCejyqLE7T2cmrT/bytNU84C5uAKIG15ba12c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YCzQPzmyoGGbsgdXDGRbLzcEEX2LoimAfaf+pqgTTC5ecjFYZ+AAG7wINEnWSykwc
         FX5ZY6Kjinqpp2DW5vDF/7Nbg0bSDSA/TXHyd/1SfCefH7S1GAr5ENQ+wVqBcdN/Zk
         WvwIALkdByvAH3AOMVTiHGn+e4mjaljwnxoO34wg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC7C6601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB
 regulators
To:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, swboyd@chromium.org,
        tfiga@chromium.org, Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180710220202.116404-1-dianders@chromium.org>
 <20180710220202.116404-3-dianders@chromium.org>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <0d334051-2ba5-075d-df8c-affe3e617e8d@codeaurora.org>
Date:   Tue, 10 Jul 2018 15:32:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180710220202.116404-3-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

On 07/10/2018 03:02 PM, Douglas Anderson wrote:
...
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +		vdd-s11-supply = <&vph_pwr>;
> +		vdd-s12-supply = <&vph_pwr>;
> +		vdd-s13-supply = <&vph_pwr>;
> +		vdd-l1-l27-supply = <&vreg_s7a_1p025>;
> +		vdd-l2-l8-l17-supply = <&vreg_s3a_1p35>;
> +		vdd-l3-l11-supply = <&vreg_s7a_1p025>;
> +		vdd-l4-l5-supply = <&vreg_s7a_1p025>;
> +		vdd-l6-supply = <&vph_pwr>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p04>;
> +		vdd-l9-supply = <&vreg_bob>;
> +		vdd-l10-l23-l25-supply = <&vreg_bob>;
> +		vdd-l13-l19-l21-supply = <&vreg_bob>;
> +		vdd-l16-l28-supply = <&vreg_bob>;
> +		vdd-l18-l22-supply = <&vreg_bob>;
> +		vdd-l20-l24-supply = <&vreg_bob>;
> +		vdd-l26-supply = <&vreg_s3a_1p35>;
> +		vin-lvs-1-2-supply = <&vreg_s4a_1p8>;

I would suggest not specifying any of these regulator parent supplies in
device tree.  RPMh will be enforcing all regulator parent-child
dependencies.  Therefore, handling the dependencies in Linux is redundant.
 It will result in additional RPMh requests as well as more time spent in
regulator framework calls.  Overall, it will lead to slightly lower
performance.  Note that while specifying the parent supplies results in
less efficient runtime behavior, it is not technically wrong so you could
keep them in place if you prefer.

Take care,
David
