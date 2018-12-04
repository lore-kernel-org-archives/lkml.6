Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5B2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC5B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLDUPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:15:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34993 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeLDUPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:15:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so16465590otj.2;
        Tue, 04 Dec 2018 12:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCAWXlexMzRWjYbVVXH69JqyARFgeoamhXRPr1RkWrs=;
        b=m++8ZZuYqzlERu2MSgGWpplT8oXA8pxLpFBtiLQnqUMDrTzk+H1VzRGKjUtmOTrO33
         vITFB4diAKD//pa6OEAHwnwOCmvbgqxHy7pVUVq22VHDkqmshDtQmwq6buStdytyEDEW
         CexpDJHP9Yv0Lu+aZd/YnDSea/62R2+3o4GZZsU7U8hxWUad+PSgrf4jDO/yjoJXu6Yd
         8dDFIY7yI1cwbMf1hYX0PmjAW+Z2zebAr4T4rfWghlRpmOVXv/JShy83iiAs1MfqM7Hc
         49p2QCaZwzzh4QnFIR6zWirrY9ohYCLmX5w5vfVD8uEBdQzCnXj8Uuj23aHdyIHi7COn
         3IkA==
X-Gm-Message-State: AA+aEWbdcqft+gD166nWfxVwQL7AhImWIbdwfC70RpsdfpWTaVqV1UT3
        BMz/CK/ahMFAbgFRxwG+3w==
X-Google-Smtp-Source: AFSGD/UZ+WO5CHuuUppM+3tVw/koSD89mAgjxr0OuEc9EqUnEhyC0ZfYDlxM1gLxIhd2uj03DJF7Hw==
X-Received: by 2002:a9d:309e:: with SMTP id s30mr14721489otc.132.1543954552118;
        Tue, 04 Dec 2018 12:15:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v6sm8752886otb.14.2018.12.04.12.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:15:51 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:15:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, Heiko Stuebner <heiko.stuebner@bq.com>
Subject: Re: [PATCH] dt-bindings: display: add binding for Innolux
 ee101ia-01d panel
Message-ID: <20181204201550.GA16947@bogus>
References: <20181113124205.29319-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113124205.29319-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 13:42:05 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> This is a panel handled through the generic lvds-panel binding,
> so only needs its additional compatible specified.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---
>  .../bindings/display/panel/innolux,ee101ia-01d.txt         | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
