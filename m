Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1939A20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1939A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbeGWSPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:15:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38459 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeGWSPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:15:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so1600656edr.5;
        Mon, 23 Jul 2018 10:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrk4FeK2+scMA5/u4hXNWgztzYnXI+z1oPqDS5Pap/Q=;
        b=s+PluJ4lcFXiTV+qzChKnvPbQ4d535gvC6DZTIjSnT+f/bxKgoJg3AjvQ6NTN76uLz
         MYcG40xs9eR8EErFrdEMU/yMyjOlv5Zb3AXaUdBmKmis1ic5hpkOt5R6loi2NLY9w9ZB
         lBctD/bOiCryku2DTn4nSJEsGq/R42BbcmoJxKkVy5Fn7Jly0yDzsP1Qf0qAIUZj5b/O
         WIPua08biiIK+Gu6MG730dUdbvas2EdnIDhd9Q97mtLw39T25SyhxiIPkMVwhvMFCkxK
         cv77tw6K5ZexpphVDLDMvYDijZk1tIzoXs3vYmTOxkyohCGyvL0efocA60mfkuymUTKs
         IXLQ==
X-Gm-Message-State: AOUpUlHGSk5LupbcKC27D6HhKXP/cR+e1O/XwD+oPGZJYXsMnxgPWykC
        0gfpGDoVS3RGlLnAtOrq3uI=
X-Google-Smtp-Source: AAOMgpfYEwI+BGSluN2lIwCEYl4dDXNDSPPPxFQNtxa+j7x/KaYgm05QXz0Oc0atRkOm2Vgb0u1LXA==
X-Received: by 2002:a50:9aa4:: with SMTP id p33-v6mr15274754edb.218.1532365984890;
        Mon, 23 Jul 2018 10:13:04 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id u12-v6sm4542279edj.37.2018.07.23.10.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:13:03 -0700 (PDT)
Date:   Mon, 23 Jul 2018 19:13:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Simon Shields <simon@lineageos.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: dts: exynos: add pinctrl for midas fuelgauge
 irq pin
Message-ID: <20180723171302.bybggn3kdkegigwi@kozik-lap>
References: <20180721125128.31498-1-simon@lineageos.org>
 <20180721125128.31498-4-simon@lineageos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180721125128.31498-4-simon@lineageos.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 10:50:51PM +1000, Simon Shields wrote:
> This pin is externally pulled up, so we should disable the SoC's
> pull down resistor in order for the interrupt to function properly.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

