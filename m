Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59364C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A21B20700
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A21B20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbeJWGa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:30:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35374 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeJWGa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:30:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id 14so37693024oth.2;
        Mon, 22 Oct 2018 15:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zH3L1K9mexkLOzPckjmtOX9xWSo0reh3erJ9pjkkhqE=;
        b=R5Ld+q0f766khkEZmQpgwfx1MriIEDESjknb2ay184JfswJkBIZcl9mxqLRgNTSeLT
         kodQu9VB4o5cEiTb4/Rbahye0ABzjMyIRfxkVZmPQU2yfQa9051edwtasUTppn005AJH
         wvJCzQ/pEzqTIqfnjki5UGdvqR5+xJMQtCxmNCPb/OxEY+FLCmfS8UgvjAKHjW4OOwMC
         BlIzk9DBdjDcvh5ne2JWWd7oA+zPxozuy97ktbs16GJ3FRxp4HtjdEhjvpzPmE6Nilgj
         x3mG0tWdN/hlbRdbFwB+F7H04NCtVXi3DuMfx0CuINmxxEGfk+kUBQM0pKj/e5KoXLpP
         m7mA==
X-Gm-Message-State: ABuFfojf5mHaBW1twQhBBIHT1RjvjaMP68smBruD19mlUsYk+h3+o157
        rJJBpBMleyHCG2jk8cd1iw==
X-Google-Smtp-Source: ACcGV60KZB+4H5vShk6+YwqjaiXfARb1h8LkCQx6qpe3LTVlLKBsC5BynOHrS6GVclo718i74UZQBw==
X-Received: by 2002:a9d:2288:: with SMTP id y8mr27782162ota.331.1540246233322;
        Mon, 22 Oct 2018 15:10:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b185-v6sm10670403oia.12.2018.10.22.15.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 15:10:32 -0700 (PDT)
Date:   Mon, 22 Oct 2018 17:10:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v6 3/6] dt-bindings: power: Introduce properties to
 present the battery OCV capacity table
Message-ID: <20181022221031.GA31167@bogus>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1540189330.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1540189330.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 15:43:59 +0800, Baolin Wang wrote:
> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsius.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values.
> 
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v5:
>  - None.
> 
> Changes from v4:
>  - Improve the description of ocv-capacity-table-n to make the order clear.
> 
> Changes from v3:
>  - Split binding into one separate patch.
>  - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
>  - Add some words to specify the OCV's unit.
> 
> Changes from v2:
>  - Use type __be32 to calculate the table length.
>  - Update error messages.
>  - Add some helper functions.
> 
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
