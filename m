Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F3EC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4D02087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4D02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJMDsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:48:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45071 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeJMDsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:48:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id u22so13486487ota.12;
        Fri, 12 Oct 2018 13:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CiuyprSBtwCZvTcg0gjXzWG3a7ixhh5nKD3WMvStGmE=;
        b=fGrZJV3feDGaYdK1qW0t6aZ75tqwYmzTahULfsktPq46ZWomx175tEPHcxX3j+fsG2
         ZAP78EpF80Mk86gTRgQraTVphVyIRg5p0UcfoH0aCbK5Lr9F5BIeUSBcg5IAF+YUUdwe
         rkkiL3c5Hig+XSG0PZlloTZo8UQYUd5bn6qny00tlUgfXFdDZTg09NTrkEsSqLh+VS5E
         1+89m86wtA8Irins4LeLpFZBGweslYryNa/V38ToEZCBThs2iTfp5gNszoee61o6J2YW
         Ppodk7ZMq/4u1zTghKfKKUht04OCaDRgXIJ9C6QJdYl4qb+nMJG+fp4YnWs0zn4x6+dJ
         zfRQ==
X-Gm-Message-State: ABuFfohM1N8GIDZc5D0C866HC0fWclwuG3dEPT9Uj8fVJeTzmai0/YvE
        NIDD0Ci/bnd0zEfALO7B9A==
X-Google-Smtp-Source: ACcGV6247K4GCNZ4FAk1swkUAfUOCEEXFCbOLdhsMXuedYNviD4hEid2TfagCQfj2CX5VXkevWUnVA==
X-Received: by 2002:a9d:8a4:: with SMTP id 33mr4434060otf.269.1539375280219;
        Fri, 12 Oct 2018 13:14:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w37sm648318oti.77.2018.10.12.13.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:14:39 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:14:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org,
        Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 4/7] dt-binding: timer: Document RTL8186 SoC DT bindings
Message-ID: <20181012201438.GA21356@bogus>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
 <20181001102952.7913-5-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001102952.7913-5-yasha.che3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 13:29:49 +0300, Yasha Cherikovsky wrote:
> This patch adds device tree binding doc for the
> Realtek RTL8186 SoC timer controller.
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../bindings/timer/realtek,rtl8186-timer.txt    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
