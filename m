Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1300C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6ECA20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6ECA20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeJFDhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:37:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39459 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:37:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id c20-v6so13962598otl.6;
        Fri, 05 Oct 2018 13:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i79tB/ETtdpFTIGkCuRtKupAtpmR1clFsCRNsLOncoI=;
        b=VA/Oak2UyPuYHRgYzCQMuVO67Xic59SapMi7aE5r3vzbprDZPEr319dht2+aNbfvYY
         PWkY2cEgdDQWWn4MXVWa/rxbrJsXSPeDS6zLaTTTAFJ/OK1y289Gzqj2by5H/KOB7qne
         1+cil9xRFiWzHg2lXnwGadeTHkdGTTv7p9t1Atsf0AsPMa3aiKDHEyEWKyC0bt/5irIm
         EH7g7ykXq2bm85aupMFctMWvU7VAYcVwmYl1FzHb50iVOudLzhbPL68ISzSeoK8dMFIl
         kqXQvad1Oo8IjRklHyBFwETHNObdv7lQmYBrR6/vJBmy8GDeYla0CDRHaGyihDDlstI+
         Q4FQ==
X-Gm-Message-State: ABuFfogSMr6wIHlLmrqds9ZXem6tzSxk3yYAd/SzfuyvLMl7jdbNflPY
        tptw9pvu4AkoWYnF5A3hEA==
X-Google-Smtp-Source: ACcGV630bUf7Ct9FW/Y4ygFO28UliSC8vBIytk0g3gPSk83dA28tXCwH+pSqgoo8ekPLsgmPWHO9Lw==
X-Received: by 2002:a9d:5108:: with SMTP id c8mr7379343oth.220.1538771813448;
        Fri, 05 Oct 2018 13:36:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2857837otl.56.2018.10.05.13.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:36:52 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:36:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/6] [media] ad5820: DT new optional field enable-gpios
Message-ID: <20181005203652.GA12732@bogus>
References: <20181002111356.32298-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002111356.32298-1-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Oct 2018 13:13:56 +0200, Ricardo Ribalda Delgado wrote:
> Document new enable-gpio field. It can be used to disable the part
> without turning down its regulator.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
