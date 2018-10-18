Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A201C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052242145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052242145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeJSEiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:38:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44560 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSEh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:37:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so25112523oia.11;
        Thu, 18 Oct 2018 13:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+yddQhupXDbPuGP93wdK6HRSQ89ti/nB9Kyq52n+QUQ=;
        b=UcUTGYtaFNlibz7Gf7Hd4fIiu5jNGcUeSZqQC8fBU7RKS+9PdvmpBNKxABoiCeoy8g
         CAT+Ojjc4f3hE01G3qe1gfxpVQAVnM13eXJ3mGf14yMjgYq00uWr4BuREEvQ8BISfr1d
         0dEemhllPOGLxatV9OnkCNQTqQNDwQ6hj44UxeTgTWgR2lM6bXEjbEyQD3CyEklxS3PZ
         8BhH1Bsdrs/SitPH827ukkNKFJD8UXh37wN9sZW439+Wujei6LnVIV65CQR6mDZ8/QbH
         DSsSnNcjB2dK9AUQeHzXl+45YdbmaTdVGNj0Tjl/RDOebn7ueqv3DTAyHBEZ/PszhLac
         dqXA==
X-Gm-Message-State: ABuFfojsztpF/l2IHkcZCZV4e+h0BQTKlEU3syi1Ur0FkIQQrQHVFBrl
        ZxrFvdPttrtBcFoDceRBrA==
X-Google-Smtp-Source: ACcGV63WP+Oe2x5TrQICqPSJG9aqfL0fkXiARr93kaCT9b+bhIXJIcX1TcmQOerM1DmSF4e9R1stGA==
X-Received: by 2002:aca:5107:: with SMTP id f7-v6mr17943426oib.223.1539894915274;
        Thu, 18 Oct 2018 13:35:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h70-v6sm8027519oic.17.2018.10.18.13.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:35:14 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:35:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: input: touchscreen: sx8654: add
 compatible models
Message-ID: <20181018203513.GA21155@bogus>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
 <20181017125116.20077-4-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017125116.20077-4-richard.leitner@skidata.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 14:51:11 +0200, Richard Leitner wrote:
> As the sx865[456] share the same datasheet and differ only in the
> presence of a "capacitive proximity detection circuit" and a "haptics
> motor driver for LRA/ERM" add them to the compatbiles. As the driver
> doesn't implement these features it should be no problem.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
