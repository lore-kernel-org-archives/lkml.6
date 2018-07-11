Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD05C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FFC20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FFC20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbeGKNyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:54:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38714 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387759AbeGKNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:54:09 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so49359833oie.5;
        Wed, 11 Jul 2018 06:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UaDR7HD4fpxkgHoIwl8Z7xIz1zSqQZhHHh4fTa3227U=;
        b=nFq0nJ4PntRphvMzrEsikntekEp9LN5Azisrv/nxwieiJAW8i3B1I9PAxaZm4i1GXI
         qchIx8F5cp5s/OL81iyeU242ejM90YI/+6HabH85IOcG1jkRigYG+47IfRs431QM/qRi
         1K53ztCaDP0XSrGHw8rkjQkEhoq6X+b9dtzj9JO3sgErVq/oSkQaepYPM+UC0jsemw+0
         ARAxzEIfMS/Ww/toT0pdDLt1aSgNPdQ1rTNqwKf0Omzq9BCoMfwtWcQ/qj1w0mNuRsZW
         Js2hXiqW+GlITczsdIMZ5FlCy6P9lea0ZO6k1VtLjx9SoZNmTZrVu1IiI4990AIVKDPP
         Vwgw==
X-Gm-Message-State: APt69E3YN1DX3pAl8OWJlLEg7iWAxQBsAGU4VBSmIqAIfI0Dg0+uoo4J
        Dy3LUgzz8FAO3P9ZOCd2yQ==
X-Google-Smtp-Source: AAOMgpeQQlGrDkQo2eEajP/e+uXIxVdh32yhq9X7v3Eo0Pkp2yxlGMD7bfkUGHalzkYvS2ly1VSlCA==
X-Received: by 2002:aca:cd17:: with SMTP id d23-v6mr30389458oig.283.1531316982962;
        Wed, 11 Jul 2018 06:49:42 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id w84-v6sm5660625oie.40.2018.07.11.06.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 06:49:42 -0700 (PDT)
Date:   Wed, 11 Jul 2018 07:49:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        vivek.gautam@codeaurora.org, andy.gross@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 6/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
Message-ID: <20180711134939.GA10268@rob-hp-laptop>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:13:28PM +0530, Amit Kucheria wrote:
> We want to create common code for v2 of the TSENS IP block that is used in
> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
> most of the common functionality start with a common get_temp() function.
> 
> It is also necessary to split out the memory regions for the TM and SROT
> register banks because their offsets are not constant across SoC families.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 25 +++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
