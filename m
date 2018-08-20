Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B0CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B114B21756
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B114B21756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeHUBsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:48:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33007 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeHUBsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:48:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so28783554oip.0;
        Mon, 20 Aug 2018 15:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kKZYC95P0H9Hpu0ArNWv77tf0DeCLDupHNY5WEutHXU=;
        b=p3ouzMaw2I+f6NuxXJ/oOsI2a6tFsxuoPv1CfhSrfvV6V6aLDWg2qyx6WZuSt3QBsT
         SxZd05cs8gGuRfnkG622UHZjX86wJheIg9qBKwYN9n3izWpl7kYdYUKzPyHNwUcAo2kf
         Ot9wd6kKmHjlVNixpmBE7v4smw5FOyTFaCujrKhvUDtLQa4Xsx6p/DyijQvCXGqHU7zh
         hTGjDb/gDrXVcCTHbgDmUXVXAO7B4GL1I64NEE24YI+RQSGz5OXZR7nqKIWroIJxd7ur
         s+HBLFvmf+Us4UBgoUlCkM2kRj8ZlwuFr+sy2XBgsDNh1R0Bg2bKa4uENsjT7uAytYqQ
         YPww==
X-Gm-Message-State: AOUpUlHETUTmxfeoP/u7SEI+Jx59K76cc1e4LsKleWtKIgsSMbg5uYZi
        CZlSU3gB14zHeJLLlzc/MQ==
X-Google-Smtp-Source: AA+uWPwpoQddsvX05d7mUP135uLZ6f/hh5NaSoOXASFG/ZwieBhiDrxKeLia7XkzhAJwOUXMv5rGRw==
X-Received: by 2002:aca:c5d8:: with SMTP id v207-v6mr16565596oif.264.1534804275257;
        Mon, 20 Aug 2018 15:31:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w204-v6sm8075188oif.2.2018.08.20.15.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 15:31:14 -0700 (PDT)
Date:   Mon, 20 Aug 2018 17:31:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
Message-ID: <20180820223114.GA29387@bogus>
References: <1534516265-10059-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534516265-10059-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534516265-10059-3-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 15:31:05 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch applies on top of next-20180817
> 
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
