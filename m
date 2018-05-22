Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3037658-1527019940-2-1813733429443614202
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
    1527019939; b=kWUmlqV/4g9du2LsjeaodceiWC/y2fpj2Y9qJohCx0LCgZxiB0
    KNauZnBsZNor4rZv6TI2xKLNXhH4+C8jHQRwbZOgYwNLslSmgnd2xlwMCWz/4+tK
    UAs7Mf9NcBTUgN9NJXiE4Fizg7P/cSukyeuVl9NmmIxdeDH/XoEoLnZ9RfpBAXLs
    D0lURF78kZBKG080qsRMjsgpEVAM8/cyz4Hz+xEtFtpLcmGd/6plSkRDuSMXoKLw
    U0M6jFpAa3BpbgM01NRqA1WR/X+Su5B5I3KGmedFP9jo6DTv0hwCrDEAOk8zVc2+
    kEHi+3pKnmqMtcVuV67Ii0Hjg4/nvNNPWw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527019939; bh=1FLmbvo9lANpxpYaG5oCkY7og2Iyn9
    39STM0Ysgp1Jc=; b=CdLu1eKEtNuQZEr7oZ9/BuAMWw2Qai0evVFBb0QjW0dqRL
    MVPtOObIZN5x4A4mAxS0qxaPMqW7b1t2/9o/32jZvynbserAhrWZz56MGG4rWoKY
    mgHpAN3M57w6dkrkVTxfdf+YRB8lXUNVQcSxcObZbpmFAcvf+fS3plAnQlTRqJp5
    iaBb7J5t7jd4wak7dsmcLrbtvnkuk/wFaaVjgs8QW8/jIPP1TsWZE0qjw7HoQEbm
    lVf/u3i7XUQfSwJuneZlx3TJj/zZAbjEArhv2TiMjNpWbarT7igjFOaBp2mL+TI+
    YqaHTI2iYhH6kfQ4T3H/1h3YXwQxDiS3CoNOpOqQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=OzM1IxnB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=OzM1IxnB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLQY9X4FsLsMM08iduDyw8cx45ffu3ZjxRkVWAr4ige/zlWEcQd3QAredtzHVB8wbc+sqiceKNsnIhY0BajQGSl/gXbwCY0GMUhGGdhEDtxXeAN4FXlH
    q7+99tR1A71udOprQNxmB3PMiSHWOleqk+GGwZJjME23GyYeENVImoAV2AnfsbY1TeP4mESkd6Nvegq6NNr0xqpXObfb/RaulNbN0dhPCE5q9KG4zewQZGF6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=zBlYfVPRuHc4MID77dEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeEVUME (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:12:04 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44504 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeEVUMD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 16:12:03 -0400
X-Google-Smtp-Source: AB8JxZoSq9/HBcbqX2aMMWW0ucd0hQLWkaVxggXbVx7R1n6/j06xwbqwSErI+YD6WvuHFJNVE3ywEQ==
Date: Tue, 22 May 2018 15:12:00 -0500
From: Rob Herring <robh@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/5] phy: allwinner: add phy driver for USB3 PHY on
 Allwinner H6 SoC
Message-ID: <20180522201200.GA17465@rob-hp-laptop>
References: <20180507151817.55663-1-icenowy@aosc.io>
 <20180507151817.55663-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507151817.55663-2-icenowy@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 11:18:13PM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
> controlled).
> 
> Add a driver for it.
> 
> The register operations in this driver is mainly extracted from the BSP
> USB3 driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/phy/sun50i-usb3-phy.txt          |  24 +++

Please split bindings to separate patch.

>  drivers/phy/allwinner/Kconfig                 |  13 ++
>  drivers/phy/allwinner/Makefile                |   1 +
>  drivers/phy/allwinner/phy-sun50i-usb3.c       | 195 ++++++++++++++++++
>  4 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>  create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> new file mode 100644
> index 000000000000..912d55f9f69d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun50i USB3 PHY
> +-----------------------
> +
> +Required properties:
> +- compatible : should be one of
> +  * allwinner,sun60i-h6-usb3-phy
> +- reg : a list of offset + length pairs
> +- #phy-cells : from the generic phy bindings, must be 0
> +- clocks : phandle + clock specifier for the phy clock
> +- resets : phandle + reset specifier for the phy reset
> +
> +Optional Properties:
> +- phy-supply : from the generic phy bindings, a phandle to a regulator that
> +	       provides power to VBUS.
> +
> +Example:
> +	usb3phy: phy@5210000 {

usb-phy@...

> +		compatible = "allwinner,sun50i-h6-usb3-phy";
> +		reg = <0x5210000 0x10000>;
> +		clocks = <&ccu CLK_USB_PHY1>;
> +		resets = <&ccu RST_USB_PHY1>;
> +		#phy-cells = <0>;
> +		status = "disabled";

Don't show status in examples.

> +	};
