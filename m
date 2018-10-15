Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDA5C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860522089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860522089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeJOWek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:34:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36948 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbeJOWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:34:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id e17-v6so15265054oib.4;
        Mon, 15 Oct 2018 07:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSAFFE3e4fZ9btKP3CoocZ/Xd37CXCSblsbDn6qPpII=;
        b=AEWidTtBruFCOeb6XQezGlEhM2dC++O4C52pMyqkaEtGRndb87eOaf4FhpFPPlzRxA
         lxBPJwyicoQbCkJl2XiKnhvWc0u18MKCKxZOTTdAbJasD8ZPxjtz1Kdedb2MiE/iTLzK
         a45m2X4iPzJq3XvQAmL7p06RriJGLUSNDULDNu7E8FpmEi3fmy1hKqPByiyFjbClazK2
         yCdKG60kLn8qUrIIx8MS1MKYZlNOrJ+JiwhFndecTnbR2lrcaZUPTSc+cCqkeYR0aMi0
         iJqIQYRw6mwSA1zJOHG6/kegraJ8rIvO09ZBLMJijUW8G3ku+zOvIHuSD+Q5P3Ae0iBZ
         OzEg==
X-Gm-Message-State: ABuFfogeLB2+Qg0phSimrL+B2HvAC3x8+0HYqSGuwdYtI72jpcFl3zkn
        H8h9OBCniBy8bUKVVC4AisMwD+Q=
X-Google-Smtp-Source: ACcGV60a93tJ20Pm/KtQ/Q/NGpJe5uYYLAzD7sxrUGVNeGB8K50yr9IslAju0+C5OxJC/kOSce/55A==
X-Received: by 2002:aca:c244:: with SMTP id s65-v6mr5506465oif.161.1539614944656;
        Mon, 15 Oct 2018 07:49:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f84-v6sm3236318oia.44.2018.10.15.07.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 07:49:03 -0700 (PDT)
Date:   Mon, 15 Oct 2018 09:49:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 1/8] dt-bindings: rcar-gen3-phy-usb2: add no-otg-pins
 property
Message-ID: <20181015144902.GA9982@bogus>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1537530804-19399-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537530804-19399-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 20:53:17 +0900, Yoshihiro Shimoda wrote:
> This patch adds a new optional property "renesas,no-otg-pins" which
> a board does not provide proper otg pins.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
