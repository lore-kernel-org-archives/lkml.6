Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572CDC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4DA20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4DA20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbeGaBCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:02:02 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51486 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeGaBCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:02:02 -0400
Received: by mail-it0-f66.google.com with SMTP id e14-v6so1754883itf.1;
        Mon, 30 Jul 2018 16:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3g/jaN+uEXeAyTQ3YZflKJHqL7zDsfnrXd5mT/1WmU=;
        b=EZSawt11LMAQwNaOWnbiueFrcJMZ8V1Koyax0gztGQ2mUaVFnQfsqw1nWIvaMzvrfM
         cd5/PC3FddLiK5txPMuEiJX9QW6UCW5FhcWrlaejRWWrNN3hIE+lRpZVYCaZGFBaTH9s
         rCUwXhMtWkt4IX48hDE8oHk7bQrlmIidYQT4P33bNVeGnyJ3zZAiq6g+FTJOrmN+aWNE
         Auaanat2VXtjwly+peHPb2yhv4oeWrh7qT395U3qjYFBlJYdEMDQDPt+vyZ/KdQslu2v
         anBVNyZ/0N7KPHnpXBovkA/yZdy4w+XB81OkanxzDGD0X82f4TxqVIU3sd1N7tjS2qI5
         UQEA==
X-Gm-Message-State: AOUpUlEIE2P27dtfxdrSoM7l+RrHsE7/xlznYHwI/ikadpEyM3gisED0
        Mgh3Ci9TAJjnQX2Lxm0NMg==
X-Google-Smtp-Source: AAOMgpfNFrlFilBCF2GJUj97pv0JgezviBpEes3MBTsa0lMzKDDJv9xBdQO2YDzZmHrQf1vzx+J21A==
X-Received: by 2002:a24:54d:: with SMTP id 74-v6mr1082262itl.96.1532993082764;
        Mon, 30 Jul 2018 16:24:42 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id f3-v6sm3834774iok.29.2018.07.30.16.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:24:41 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:24:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: mmc: tegra: Add nvidia,only-1-8-v
 property
Message-ID: <20180730232441.GA17560@rob-hp-laptop>
References: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
 <1532607560-11253-3-git-send-email-avienamo@nvidia.com>
 <484a31bdaad6d76b4fbb7d6fa80cbb8d@agner.ch>
 <20180727110555.1b7ad97d@dhcp-10-21-25-168>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727110555.1b7ad97d@dhcp-10-21-25-168>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:05:55AM +0300, Aapo Vienamo wrote:
> On Thu, 26 Jul 2018 15:05:55 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
> > On 26.07.2018 14:19, Aapo Vienamo wrote:
> > > Add a property to mark controllers which operate at a 1.8 V fixed I/O
> > > voltage.
> > > 
> > > This feature of the hardware needs to be signaled this way because it
> > > cannot be probed at runtime or reliably derived from other properties.  
> > 
> > Is this really needed? Can we not use vqmmc to determine which voltage
> > the controller runs on?
> > 
> > There is already some precedence in the SDHCI core to determine which
> > voltage levels are supported:
> > https://lkml.org/lkml/2018/7/5/342
> 
> This property is introduced to solve a slightly different issue. The
> thing is that supplying a fixed voltage SDHCI controller from a variable
> regulator is still a valid configuration. Which means that testing the
> capabilities of the regulator doesn't actually describe the SDHCI
> controller itself.

The regulator constraints should reflect this. The constraints aren't 
the capabilities of the regulator, but the limits on what it is 
supplying.

> 
> In practice this property is used to communicate whether pad
> reconfiguration and voltage switching needs to be performed or not. This
> cannot be determined from the absence or presence of the pinctrl
> properties either because they naturally won't be there on older dtbs.
> 
> The logic behind this goes like this: if this property is present,
> there's no need to perform pad or regulator reconfiguration and UHS
> modes can be enabled. If this property is missing then valid pinctrl and
> regulator properties are required to enable UHS signaling. This is
> implemented in tegra_sdhci_is_uhs_valid() in "[PATCH v2 03/10] mmc:
> tegra: Reconfigure pad voltages during voltage switching"
> 
>  -Aapo
