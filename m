Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF899C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4D7213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4D7213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbeGKUjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:39:22 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36402 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732556AbeGKUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:39:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so51724004oie.3;
        Wed, 11 Jul 2018 13:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYCKY5iqU/5jPiUclgHFydfl1mxgm4fWpQfIaRqCYdk=;
        b=mNtABTmLdYUVJHn95pcmw+Li0kaNbYKepu3EfNx0CVo+BoDtFGgWyCfG/PS3lM/3so
         RTL4SfRpjZ1P5x3dvDH5QQMKRA9J1eGQdukup7eaVwz0/Wq+5lkMj/zaDNLPmJWhyHUo
         Uij69PhVB0Bxpxez8op62txETrL6m4hc1qm2tV74J+LujTM7n1fMTcxKXqvvd6+jTCMf
         WSiH0IyDb43kIv8LoTf8lbx0Q+TqlwCycClkVLgI9ko43jz5zidk0KxoX+PIJwwIbUl2
         REfoucVEHYvVzvCp9CtbBnWKlIQNO3bat/jh4jvc+7BHse1vsXOs6dDo68IOVwo/Yr0I
         vtVQ==
X-Gm-Message-State: AOUpUlEAFUb3EfCsafBmUSumtJFWSSA/OkMjIZqTFgxz9GP9HKyvNv3O
        LXlIeTS3VOCS27PWX8mSjw==
X-Google-Smtp-Source: AAOMgpdbvrkOyrLP8dAcemlZYrR3utJ9I5J4mzN3AGSkw8jglGSek27wrOia6ZIHlhtnE2TorOO9ug==
X-Received: by 2002:aca:6206:: with SMTP id w6-v6mr152107oib.201.1531341198692;
        Wed, 11 Jul 2018 13:33:18 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n6-v6sm15021529oib.27.2018.07.11.13.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:33:17 -0700 (PDT)
Date:   Wed, 11 Jul 2018 14:33:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Asutosh Das <asutoshd@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/9] scsi: ufs: add option to change default UFS power
 management level
Message-ID: <20180711203317.GA14983@rob-hp-laptop>
References: <cover.1530880006.git.asutoshd@codeaurora.org>
 <ff2b648007a400c60ba804a0c5cab0166bd268e7.1530880006.git.asutoshd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2b648007a400c60ba804a0c5cab0166bd268e7.1530880006.git.asutoshd@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:00:31PM +0530, Asutosh Das wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> UFS device and link can be put in multiple different low power modes hence
> UFS driver supports multiple different low power modes. By default UFS
> driver selects the default (optimal) low power mode (which gives moderate
> power savings and have relatively less enter and exit latencies) but
> we might have to tune this default power mode for different chipset
> platforms to meet the low power requirements/goals. Hence this patch
> adds option to change default UFS low power mode (level).
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      | 11 ++++++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c                   | 14 +++++++++++
>  drivers/scsi/ufs/ufshcd.c                          | 29 +++++++++++++++-------
>  drivers/scsi/ufs/ufshcd.h                          |  4 +--
>  4 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index c39dfef..f564d9a 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -38,6 +38,15 @@ Optional properties:
>  			  defined or a value in the array is "0" then it is assumed
>  			  that the frequency is set by the parent clock or a
>  			  fixed rate clock source.
> +- rpm-level		: UFS Runtime power management level. Following PM levels are supported:
> +			  0 - Both UFS device and Link in active state (Highest power consumption)
> +			  1 - UFS device in active state but Link in Hibern8 state
> +			  2 - UFS device in Sleep state but Link in active state
> +			  3 - UFS device in Sleep state and Link in hibern8 state (default PM level)
> +			  4 - UFS device in Power-down state and Link in Hibern8 state
> +			  5 - UFS device in Power-down state and Link in OFF state (Lowest power consumption)
> +- spm-level		: UFS System power management level. Allowed PM levels are same as rpm-level.

What's the default?

I assume these are minimums? The OS can pick higher power states. This 
seems to be a bit Linux specific (as 'runtime PM' could be considered 
Linux specific). For every other device, we don't put this type of 
information in DT, but is user controlled. So really, wouldn't 1 
property be sufficient for cases where a mode doesn't work due to 
some h/w limitation. Otherwise, it is an OS or user decision.

> +
>  -lanes-per-direction	: number of lanes available per direction - either 1 or 2.
>  			  Note that it is assume same number of lanes is used both
>  			  directions at once. If not specified, default is 2 lanes per direction.
> @@ -66,4 +75,6 @@ Example:
>  		freq-table-hz = <100000000 200000000>, <0 0>, <0 0>;
>  		phys = <&ufsphy1>;
>  		phy-names = "ufsphy";
> +		rpm-level = <3>;

Why specified if 3 is the default?

> +		spm-level = <5>;

These seem like sane defaults. When and why would you use some 
different?

Rob
