Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521BEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9FA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9FA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbeGKPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:07:21 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45866 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732605AbeGKPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:07:21 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so24247423oic.12;
        Wed, 11 Jul 2018 08:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bo1JGjT/KPvL5h3k4VsAJyuIe/kDw8NlbNoXyDd0Rk=;
        b=aQaSsoj68Q0dRT8Acf6rPxAS3TdSWz6Pe6DxUTD0/989WG9YgDbvQTHFv6u39O4/4I
         tDSd6waPtUIXl+10BBz5siFAUBml5YEALBmdIBhLK7TimnGf7NI4IMRnTxkMI0WLpInY
         F7CBMC5b7P0iyJuh32LGm+WmtrjfucWlXBFTnzFN4Sw9zOiv5s9hF4c73pgEeuAfYknx
         3MyYoImnWXYVqKfU91BJTJXZVtxBW9a2iYN2sAMj/LQ3qe9DY7OArtVVzDbWjaCm8QGU
         zd5oODSUgsa/woXb1u3xG1yk30EaWnID/uqDHJXDH92/KLgSotbHHShGoEqnio+kzFu0
         gZ1A==
X-Gm-Message-State: APt69E3ZpL8fm5HJtwxaxTWEnM6Zvgi17vM5qM808tXc3NEBlCcfXBqd
        L8JK+fChWq8GxIlzSJWXYg==
X-Google-Smtp-Source: AAOMgpeDWVqeHGRhhyhARHBGMD45OawGGSqcJ1wOVLrhbS62/TbV5jd2KaPI4qA3JXS1As8kpdVlcw==
X-Received: by 2002:aca:5545:: with SMTP id j66-v6mr35152613oib.291.1531321356472;
        Wed, 11 Jul 2018 08:02:36 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 1-v6sm5772773oir.19.2018.07.11.08.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:02:35 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:02:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr
Subject: Re: [PATCH v4 2/5] dt-bindings: w1: document bindings for ds2760
 battery monitor
Message-ID: <20180711150235.GA24824@rob-hp-laptop>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-3-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706053552.11438-3-daniel@zonque.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:35:49AM +0200, Daniel Mack wrote:
> This patch adds the devicetree bindings for Maxim's ds2760 battery
> monitors.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  .../bindings/power/supply/maxim,ds2760.txt    | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt

Reviewed-by: Rob Herring <robh@kernel.org>
