Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1216624-1525708410-2-12117154060019772952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525708409; b=TIhNJNhZWdccgfwoXISq8D8FEHuItA03+tTXNShGtI+ZcwFFjD
    klKxohKFl2mSAhJCODZF6viocUABrYXdwjZOGvWvybrERU+iGBZocpF0KHXhZh+b
    3+4U3iQEudtw0iUW+VHmzRLWnP6jbQe4yZo+wkoIc4bdfu5LcE2zxKTGdEyAmgBJ
    fWr21HewnRQNngZvwXvZNqxefOtFwihAe0SBY8qVlzBHYNfstsoaZVZxIQg50X81
    iT/hUeQfPIxbJ+yY9eeW0BXShwCNE8hxoM5dfbthCxuyDqGqVWxkJjZuezHSWg3E
    ikBJ2hf5diE7FnYmqiJyWdqxK19p3y/3Ibdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525708409; bh=1JklxkNU7llLEoJiRsBlvo8KgDYTPf
    AH8GCXUAN+ud4=; b=AWaK4Upp2XDJAVk5eQ43bP5JJwoVq4yPeT6Xl4OiT8fJE7
    oEhkGQVDMgNGUgvFlWm1qaiqrlf0XL4r3ZnfA3CNZPrTxReYVz80/aYPE+U+kmo4
    hRAXTTa8yBB05+KUo9AMZXN+zFD3eRgvSQRj9oHlthuZaeTB6e+YiKhxezmQC/8i
    y/O8CliCJbltUbU1R12N391ZNFi/lradAXLdIkdWu9Zw5eYq4tw2YfbHy5nzSrMr
    LrkEyUsrQw/U01cUf7nTxMCFWa7lbRIVto/Dksa8RNRna9ngqw+wXwMCwyA0qZRd
    q3osGNTjlxIBpbrQ4GubWNBYRBn1g37f+eIC6FhA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Ki3/Mz2P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Ki3/Mz2P;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIPCe4YCIkKVA5B4/rbUQVcoQxfq+ucWer7dpuTjQcDOSM8Ba706jmX9E+P2Rp8icgmoKhw5fQBEgSwm+8VmYpvLE9ZrJmK6RoQu5Zgh5+phYV7XQbCM
    Kl9lLtDvirblI4visrlb4ObLacxW7DQTl1u1CAjrlbbZ81SzR3+qjYONT9eExP9PQ8ia47+2gt0Itdq70sAwTCgIY2GMIrBqqKR5zWSboqPPcMJTowLAMOwL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=1kutLOL7GHHINXGAJQgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeEGPxR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 11:53:17 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40004 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeEGPxP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 7 May 2018 11:53:15 -0400
X-Google-Smtp-Source: AB8JxZrNjzvHiNQHfVmKLpCcCVygNXz5hksO13ZHhA+0pvOa7Fx5ZsjE449AkzYrPdrBQDbiuWtbYg==
Date: Mon, 7 May 2018 10:53:14 -0500
From: Rob Herring <robh@kernel.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 6/7] dt-bindings: phy-qcom-usb2: Add support to
 override tuning values
Message-ID: <20180507155313.GA9696@rob-hp-laptop>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
 <1525295174-15995-7-git-send-email-mgautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525295174-15995-7-git-send-email-mgautam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 02:36:13AM +0530, Manu Gautam wrote:
> To improve eye diagram for PHYs on different boards of same SOC,
> some parameters may need to be changed. Provide device tree
> properties to override these from board specific device tree
> files. While at it, replace "qcom,qusb2-v2-phy" with compatible
> string for USB2 PHY on sdm845 which was earlier added for
> sdm845 only.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom-qusb2-phy.txt     | 23 +++++++++++++-
>  include/dt-bindings/phy/phy-qcom-qusb2.h           | 37 ++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> index 42c9742..03025d9 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> @@ -6,7 +6,7 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
>  Required properties:
>   - compatible: compatible list, contains
>  	       "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
> -	       "qcom,qusb2-v2-phy" for QUSB2 V2 PHY.
> +	       "qcom,sdm845-qusb2-phy" for 10nm PHY on sdm845.
>  
>   - reg: offset and length of the PHY register set.
>   - #phy-cells: must be 0.
> @@ -27,6 +27,27 @@ Optional properties:
>  		tuning parameter value for qusb2 phy.
>  
>   - qcom,tcsr-syscon: Phandle to TCSR syscon register region.
> + - qcom,imp-res-offset-value: It is a 6 bit value that specifies offset to be
> +		added to PHY refgen RESCODE via IMP_CTRL1 register. It is a PHY
> +		tuning parameter that may vary for different boards of same SOC.
> +		This property is applicable to only QUSB2 v2 PHY (sdm845).
> + - qcom,hstx-trim-value: It is a 4 bit value that specifies tuning for HSTX
> +		output current.
> +		Possible range is - 15mA to 24mA (stepsize of 600 uA).
> +		See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> +		This property is applicable to only QUSB2 v2 PHY (sdm845).
> +		Default value is 22.2mA for sdm845.
> + - qcom,preemphasis-level: It is a 2 bit value that specifies pre-emphasis level.
> +		Possible range is 0 to 15% (stepsize of 5%).
> +		See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> +		This property is applicable to only QUSB2 v2 PHY (sdm845).
> +		Default value is 10% for sdm845.
> +- qcom,preemphasis-width: It is a 1 bit value that specifies how long the HSTX
> +		pre-emphasis (specified using qcom,preemphasis-level) must be in
> +		effect. Duration could be half-bit of full-bit.

s/of/or/

But I'd just make this a boolean instead: qcom,preemphasis-half-bit

> +		See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> +		This property is applicable to only QUSB2 v2 PHY (sdm845).
> +		Default value is full-bit width for sdm845.
