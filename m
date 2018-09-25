Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185DDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD767206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD767206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeIZAdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:33:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42141 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIZAdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:33:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id v198-v6so2336685oif.9;
        Tue, 25 Sep 2018 11:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7fAupeQf+sAC/AoPlwQsuQQUeIjNktglglCMANpWKoI=;
        b=pG97/60gLNUHCR+biKb+MukJ4mRuEzOq+v8sQcB+3gczNcduoqpFcnBqddqGQyRijC
         u1jpNKZzd/68oouBQE4/aCg0RCCrhKIxl0vb3VtHjGMzbyOSZ2wJr0d1vKC4VO1nH9rz
         LfRXYUk/4p9ssnMZ8GxEL3AQkbxbn3mHHg7bgN7zXxoBEL6J74FVNl6tox9IK2ogTJ3w
         Q+Nr2PJ1u9yH29/qWdqgB0fVzgFJO6a2LRfYXPuTtNaXkh54QHG49kptSsnh8u84Nz8f
         pDqX/2bRBG9HKTj4E/anfVU4/iI80tx6W5Y0tIX1Uz0m9qAMatYaSmkIA3YyDZw8gHHz
         NQLA==
X-Gm-Message-State: ABuFfohlLiuK0eTU99ATJB66IKNSFvl4T1rb7rR4tgs15aKfJcm5bDBC
        tR1wxfUvzXGK6+JbfOH8tg==
X-Google-Smtp-Source: ACcGV63I8gGbN2Uhwv80RMvZpYfmMMTCVHmi+BoF2kELHQtVvzMbJ+TBu1UFpXVBf2cCmyNdZnTiBQ==
X-Received: by 2002:aca:e155:: with SMTP id y82-v6mr1436364oig.90.1537899900442;
        Tue, 25 Sep 2018 11:25:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o9-v6sm964131oia.21.2018.09.25.11.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:24:59 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:24:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Johan Hovold <johan@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 26/34] dt-bindings: add broadcom (formerly plx
 technology) vendor prefix
Message-ID: <20180925182459.GA21710@bogus>
References: <20180831163817.23970-1-marcel@ziswiler.com>
 <20180831163817.23970-27-marcel@ziswiler.com>
 <ed2ffc72-68d6-476a-d589-6738fcbf1d7c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed2ffc72-68d6-476a-d589-6738fcbf1d7c@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 08:01:01PM +0200, Andreas Färber wrote:
> Am 31.08.2018 um 18:38 schrieb Marcel Ziswiler:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > PLX Technology meanwhile got bought by Broadcom Corporation but the
> > vendor prefix plx is still used in 8 current device trees. This silences
> > the following checkpatch.pl warning:
> > 
> > WARNING: DT compatible string vendor "plx" appears un-documented
> >  -- check ./Documentation/devicetree/bindings/vendor-prefixes.txt
> > 
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Sounds sensible,
> 
> Reviewed-by: Andreas Färber <afaerber@suse.de>
> 
> You may want to tweak the subject though, it is slightly confusing as
> Broadcom already has a vendor prefix.

Yes, please.

With that,

Acked-by: Rob Herring <robh@kernel.org>
