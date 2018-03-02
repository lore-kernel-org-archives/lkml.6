Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625397-1519996452-2-14678008377804938978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519996452; b=okQ2k20g9CfVvsGz5ZlUB8gN/6LGgh/VtdwIi9PVJ62hHso
    JcUF5Du74X6r0znkBVYXSgREeZKU5o6dMcclNrwBNg3qbAVBEqN9OwcZ2bkBJ2uW
    HheiT2H13+5vja/eLdvFUV+1wCwMqz3gkECE2ACWiANJ1eO3p7p0cLTByseeBllc
    QwqjhvyYAgNVpO8WZi/CrWePmnaAHUEz6O2+qyCc7Lkfuwuar4+rIO+4aMJAGgDB
    ZLFFICnnrYxJUgmURYsoelFC8UB6g3yYzUpXz8NAcKByBrFh9G/C8v9ujtDyLZ+M
    aTIh2XIc7dMC1Q3nuzQnxyQUect1407HsSuu3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519996452; bh=JINeuJt1F4iESCD2g2nRYumkjz
    sk6IOZmOXAHibYS64=; b=fmffIoVBe5P3wo8L6sXl01EtVdnWra1YrOL6Tl9UVP
    pYctHxx/UDKL12HC07PuTI4bQTTd8+t9qtV5omdOlI+USsEUVlULmia1112hjDjv
    n1DntzZCPC9BhU3V0T6RFNwb+wOPosTDhNDBnMtHQWcxU6HoNxhfbispEuk2pCyE
    jAb+rIYtshlJZbLH0c7doFZpd3RE6059NCl1R4mwWQTAVgfsM69F8icMgipYJvwN
    kR15vRlvYIGpn3YpmZb+Kjkh1OkStpzGiOZxoKm3AsGZdz8/xIHON8WbfM3lWn6S
    77xXOeKyiYLkci6NRaI4Sbfaq/fmlloZ9YOT+7SsyLCA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423833AbeCBNNk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 08:13:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:5013 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423267AbeCBNNX (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 2 Mar 2018 08:13:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="34970996"
Date: Fri, 2 Mar 2018 15:13:15 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
Message-ID: <20180302131315.GA10598@kuha.fi.intel.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227071134.28063-2-a.hajda@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Tue, Feb 27, 2018 at 08:11:29AM +0100, Andrzej Hajda wrote:
> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
> +
> +ccic: s2mm005@33 {
> +	...
> +	usb_con: connector {
> +		compatible = "usb-c-connector";
> +		label = "USB-C";

Is this child node really necessary? There will never be more then
one connector per CC line.

We should prefer device_graph* functions over of_graph* and
acpi_graph* functions in the drivers so we don't have to handle the
same thing multiple times with separate APIs. Is it still possible if
there is that connector child node?

> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				usb_con_hs: endpoint {
> +					remote-endpoint = <&max77865_usbc_hs>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				usb_con_ss: endpoint {
> +					remote-endpoint = <&usbdrd_phy_ss>;
> +				};
> +			};
> +			port@2 {
> +				reg = <2>;
> +				usb_con_sbu: endpoint {
> +					remote-endpoint = <&dp_aux>;
> +				};
> +			};
> +		};
> +	};
> +};


Thanks,

-- 
heikki
