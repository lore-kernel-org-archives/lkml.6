Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF8421533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF8421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeI0Cok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:44:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34294 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeI0Cok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:44:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12-v6so338996otl.1;
        Wed, 26 Sep 2018 13:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/VC23nXcvBqDn6gRWFu3FESK+npQhpU2Dybt5oTGjb8=;
        b=HKQdpPKbysnjiUOtNdfAVIAMMwiyeKkp9LyVxuxHIVb6L+8tDBXFIJUpjxDa279EKf
         PGr0rWv3e0ha/xrKIQ/qNx6m7BY/AsPN3Z+Mhg5Muf2LFiSVBhB/dWBfZx0sAUzfWfee
         FSc2YFlxQ3XVf0ezcQHP4kFCJ7GjkkEc/AyluV3Q+ccef07czD4E0T9Ep3ug4W9nUjaG
         5MNVU4BN47Ayi7V2itNtDME7h2tmcYdzFQ0Q5M0ITwaRCWF8qPK6XVcUuZXPcaFnTFMw
         WjT2TDozLt0T66nuhFkV2mShbGrcbGyhJxeBR2LL7Mf6JKmdjq6kBodHrwC0uY0gZp2a
         LDqw==
X-Gm-Message-State: ABuFfoigrSfbTPFFFpLrYhm2eyEHQotYO+HUFMWZdhPyxF6xfqc8lf9L
        H1IaXtYUUiRO96auuFBvdA==
X-Google-Smtp-Source: ACcGV62pe1dK/phSh33XNzEZaq6xMnLVwQyclFx5YVTxVrgnDgSScHTbKlyebqUm/xHZR8XP9GpA8Q==
X-Received: by 2002:a9d:2c89:: with SMTP id p9-v6mr5204177otb.164.1537993798459;
        Wed, 26 Sep 2018 13:29:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f15-v6sm1370otf.34.2018.09.26.13.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:29:57 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:29:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: media: add Amlogic Video Decoder
 Bindings
Message-ID: <20180926202957.GA23380@bogus>
References: <20180911150938.3844-1-mjourdan@baylibre.com>
 <20180911150938.3844-2-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911150938.3844-2-mjourdan@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 17:09:36 +0200, Maxime Jourdan wrote:
> Add documentation for the meson vdec dts node.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  .../bindings/media/amlogic,vdec.txt           | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
