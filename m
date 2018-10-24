Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0B9C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE9120833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE9120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJXXST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:18:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36675 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeJXXSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:18:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id x4so5290843otg.3;
        Wed, 24 Oct 2018 07:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1VTMeIgOjkcfviWoXdDa2dmwTJYTGHkNjhjvPTvXim4=;
        b=q/smIv9ERC71Q1KhjWzT6IIi1gSWfRxkjkMCSGxliR8ev0tUbh91z8V8m/97gwbWyK
         XECiNDbeHAisECHX7MkXxPbh/gqCmIFHpdc+EAotvSCvftTD5wGlCVfEPqHSFdTkXlxr
         LuaIz/nDb3K0/ny7/NAlonuJXmZsC9QX6NYKp4hXpn92T4n2CYttD2AcrSLK16iw09Bj
         UlrHYtwkM8XjhuVQw0kaLvkNkB8uNUk/kHwENSP2xGOewDttRiCMA/g0DoXCwD839eJU
         JmDxIRTs1Q0xYeJyL+cWEv1pN/h2hDpumJn0H6A4Qr6T6Tz07obJtnq8irBKjGJ9hCZX
         Q9fA==
X-Gm-Message-State: AGRZ1gJ//JNlgpiGFc9iGOu3z2TGelzLPdl6mWMIC91CansAb4SA5Jeb
        Y52IRCJBH3/WY3fgFDQ30A==
X-Google-Smtp-Source: AJdET5cHFg6MwjOvqH9TYIaKg+Z3CXRYATxtsXnt1VRhNBbGrq7963EZSFYP4Uf6VybX3sYtZbredA==
X-Received: by 2002:a9d:6150:: with SMTP id c16mr1962076otk.310.1540392593574;
        Wed, 24 Oct 2018 07:49:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm38098otj.59.2018.10.24.07.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 07:49:52 -0700 (PDT)
Date:   Wed, 24 Oct 2018 09:49:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
Message-ID: <20181024144951.GB9327@bogus>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023170623.31820-2-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 12:06:18PM -0500, Dan Murphy wrote:
> The LM3697 is a single function LED driver. The single function LED
> driver needs to reside in the LED directory as a dedicated LED driver
> and not as a MFD device.  The device does have common brightness and ramp
> features and those can be accomodated by a TI LMU framework.
> 
> The LM3697 dt binding needs to be moved from the ti-lmu.txt and a dedicated
> LED dt binding needs to be added.  The new LM3697 LED dt binding will then
> reside in the Documentation/devicetree/bindings/leds directory and follow the
> current LED and general bindings guidelines.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v4 - Squashed removal and addition of the dt bindings into a single patch - https://lore.kernel.org/patchwork/patch/998703/

Still not really the sequence I'd like to see and what I think would 
help the discussion move along.

Patch 1: move all the devices out of ti-lmu.txt into the grouping which 
makes sense. IOW, no functional changes. Probably only strict 
sub/supersets of each other should be shared.

Patch 2-N: Make binding changes. Then we discuss things like ramp time 
properties separately from binding structure.

> 
>  .../devicetree/bindings/leds/leds-lm3697.txt  | 98 +++++++++++++++++++
>  .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +----
>  2 files changed, 99 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
