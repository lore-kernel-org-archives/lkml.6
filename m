Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A879FC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6BB20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6BB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLCXqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:46:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35293 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCXqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:46:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so13461666otj.2;
        Mon, 03 Dec 2018 15:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FG2b64yFhWWkGEmcz8JbLICmpHFoLD88sfjCdvcsDV4=;
        b=pja8GCPIf8mdwgrJO+EZbnRgcPqawYBSSWX7MVvBTioUZbtAQg8VY9LiGUkQhWnsA1
         Z848YCTSNQejzZKdD6upX1BbL93Jtn1cfoigjugwIk3bihlrF32t/3ESI90p9p/nmLd6
         UPs2G4xHQGb4iadjLcLUnHCFO2XQ4y0LMVXYg98kNdygkeco/Rfge9gAq+31xmbBgd8r
         x9oDnbymzkrlMu3j0scWRFchevsA4Jj1d+7iFpsToW0I8rcb9ekQtdvtB3SSJ8u9yrK6
         YdCy4b4cwZLMVrYfPYlsDe5HLfoqRBj795IS78T8Uc9fqh+VmVm7OoGHffLK5VYhwXav
         Rlow==
X-Gm-Message-State: AA+aEWZFl2jslFNp1hvv1D3d5BzGB2/avcbRzyxq+Vj87cFxD7MnLC29
        cth3YA18tZhWyJ/B3LPNZuOT/8U=
X-Google-Smtp-Source: AFSGD/VKIECK8mM2QoYUPh0pWl7KpeqLF/QzF3FctSBiLOIWdTCXJQHFO9wgODlJyEkhcwUTogComQ==
X-Received: by 2002:a9d:14e:: with SMTP id 72mr11980870otu.54.1543880759749;
        Mon, 03 Dec 2018 15:45:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e8sm4442419otq.17.2018.12.03.15.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:45:59 -0800 (PST)
Date:   Mon, 3 Dec 2018 17:45:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: rtc: Move trivial RTCs to rtc.txt
Message-ID: <20181203234558.GA10722@bogus>
References: <20181111193114.24307-1-alexandre.belloni@bootlin.com>
 <20181111193114.24307-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111193114.24307-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 08:31:14PM +0100, Alexandre Belloni wrote:
> Move trivial RTCs to the rtc generic binding documentation as they all also
> support at least 'start-year'.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc.txt | 34 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.txt   | 24 -------------
>  2 files changed, 34 insertions(+), 24 deletions(-)

Okay if I take these 2 to avoid conflicts with trivial-devices.txt?

Rob
