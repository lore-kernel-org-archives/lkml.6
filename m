Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A747CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E6223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744E6223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbeKMNIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:08:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35592 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeKMNIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 08:08:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id n4-v6so5278369plp.2;
        Mon, 12 Nov 2018 19:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lUdnUi9zEt3zSVqXGj7zxuzQfBmkFenVow/aRVmuV44=;
        b=drMdaj0da7oZjA1sqYNka7h6NFPc+NnB5EOvGdGzI9zN7wv/ivWWav7DzFkUYLosuI
         m4x+VPUug8tV5eoP3O1N0jXqC18Gm3smqtfRmqAyck9EpS0r4NHpnESpkmbXxfyWcPc2
         Hp723GSr16G+3DltUtoKtlsgDxJJHA4DkTa2jirb7nVoMsPikS0+Ihd1WE4YbqUwRMEh
         iD63MoZJb1d06eu8l1YIc2kE8//HIAg1lVbvqGCD3AxChMBeokFZ9qhvlMLCBWU1/zUG
         NqMVkDW2JyrmZw8Lii2h9vvgoBc+xSlXkBbIsgfvZyQjIAjxJLSF2vMeaUyZwpajFfb/
         iJ5w==
X-Gm-Message-State: AGRZ1gJF8foQRDwyrLyU9/jklCfd8IXQu1EYTBZ7QUyowbCMtyzCd4fR
        6No3KlgT3x+lBJD/UdDcdZ06uBrvcsqB
X-Google-Smtp-Source: AJdET5c/Rg6K+SA66lnqwNzbokC35UNAhLG+WLvHlyaX5t25/mMojrdllr1+W5VfS+zj+SWKWapLjQ==
X-Received: by 2002:a17:902:8210:: with SMTP id x16-v6mr3391336pln.129.1542078716798;
        Mon, 12 Nov 2018 19:11:56 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id 83sm4460818pft.184.2018.11.12.19.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 19:11:56 -0800 (PST)
Date:   Mon, 12 Nov 2018 21:11:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alan Douglas <adouglas@cadence.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Document cadence Sierra PHY
 bindings
Message-ID: <20181113031155.GA12431@bogus>
References: <1542040921-10187-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542040921-10187-1-git-send-email-adouglas@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:42:01PM +0000, Alan Douglas wrote:
> Add DT binding documentation for Sierra PHY.  The PHY supports
> a number of different protocols, including PCIe and USB.
> 
> The PHY lanes may be configured as single or multi-lane links.
> Each link is treated as a separate sub-node.  For example, if
> there are 4 lanes in total the first 2 might be configured as
> a multi-lane PCIe link while the other two are single lane
> USB links, and in this case there would be 3 sub-nodes.
> 
> There are two resets for the PHY block (one for APB register
> access, one for the PHY link) and separate resets for each
> link.  For multi-lane links, the reset corresponds to the
> reset line on the master lane, the resets on other lanes
> have no effect.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-sierra.txt | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt

Please add acks/reviewed-bys when posting new versions.

Rob
