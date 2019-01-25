Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F14AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38F2218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFHFOXob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfAYQeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:34:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37376 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:34:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id t33so11320592qtt.4;
        Fri, 25 Jan 2019 08:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=j49pleS7H82CMHb/I7p3NPx+Vf7fKXPU6rxbQ8wBGqM=;
        b=sFHFOXobg+YrS+NX4MkqZ45OBY9K3nRGwyV0TC/wQ9/Ip3R+G5zofNY8DDbgO6eA9G
         X5Y8YwEKptvoL4yXPoxNx0p3vzQYxEzyFhQT/XvLbXwSUg5T2VuGrbY0uRznMRysfelA
         d2LAkWX4u91VDA4fN8IbUkJLnXKaYM1vb+h+6tPaDuNDYiXtn0LhQ6gH55UlBFNej7Q6
         yDLAip+EcjaqxlRCOOziDWhXiISMa2OigP7AByzu0+s3B0JKoJJN4zy7DVX/dJV+V32R
         jlpg4heysKJxeXLBRQ/wBMUPv0UPHB/+5Ydh2OvssvS7rEW+lhTgM7SPY5S1mTX2b2mo
         7CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=j49pleS7H82CMHb/I7p3NPx+Vf7fKXPU6rxbQ8wBGqM=;
        b=Cxnq3BcGkCP+bdfyNU+HtZvByAG75anykg8jtCpi43HNodKIdVeRQT3xYIE7AxKSZg
         f2CHE+RAnIMZwSbAtRIuTqnn8YyL9QtJo4PuFgAZ1FBEtSoIoS+fYqAz9MpCJ7TGU5nW
         yaE/84/f+6XQW62ALWfeW1ttCICGHWCwIIzvy6SxZI6x6io2dg6zhdQNwQ3o9z02eGVs
         sLmxrtV/VsId0qAKBymK3zsazNKty1v31xLTaTvH7xKS4nLJVtcWoW686FxSBeSHEUrJ
         bP25UIziGS+/hIpWuQH4LEEYO1nxSVG7ZyxOwet3ZCPv8KUL0vu0yhxWQ1/hPxNDVhOW
         n1sw==
X-Gm-Message-State: AJcUukcXCcbVMvld9wmwMakvQvej8i7jVS9z1Ksn2a7gUM/sRqclaiZE
        UL6qDVMdO49QyLPjO9viU94=
X-Google-Smtp-Source: ALg8bN5OLedcjme1w2aZcnk3uj7+PFmk8RMU9ekTgejD+bYLwP1oSlkNmdvMzJU+TDitLv//4mqS0g==
X-Received: by 2002:ac8:6151:: with SMTP id d17mr11560451qtm.194.1548434039078;
        Fri, 25 Jan 2019 08:33:59 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id m20sm52730514qkk.66.2019.01.25.08.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 08:33:58 -0800 (PST)
Date:   Fri, 25 Jan 2019 11:33:57 -0500
Message-ID: <20190125113357.GB21150@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/2] regulator: mc13xxx: Use lowercase regulator names to
 match the DT
In-Reply-To: <20190125153705.29921-1-robh@kernel.org>
References: <20190125153705.29921-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 25 Jan 2019 09:37:04 -0600, Rob Herring <robh@kernel.org> wrote:
> Since c32569e358ad ("regulator: Use of_node_name_eq for node name
> comparisons") Vivien reported the mc13892-regulator complaining about
> not being able to find regulators.
> 
> This is because prior to that commit we used of_node_cmp() to compare
> the regulator array passed from mc13892_regulators down to
> mc13xxx_parse_regulators_dt() and they are all defined in uppercase
> letters by the MC13892_*_DEFINE* macros, whereas they are defined as
> lowercase in the DTS.
> 
> Fix this by using a lowercase regulator name to match the DT node name.
> 
> Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
> Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
 
This fixes the boot with arch/arm/boot/dts/imx51-zii-rdu1.dts,

Tested-by: Vivien Didelot <vivien.didelot@gmail.com>


Thanks,

	Vivien
