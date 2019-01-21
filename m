Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52354C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2258220870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548085842;
	bh=zc0wcLeAduwp78cRkVxhWlbvmk2E2Xlg6QcfpL/71WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0RgdB4KchFm0z7v0HncM5T4qjHgIAcrdRNoCKxFM8GAvHuapFbVVXPfmNbcMs2HBs
	 l2NMEDSC+HDQFxJRrS7AyC3N9lXT/Q+TzSJhBGkyZnOHT3fxfjZHGMtYVoWufrjQIn
	 H96fiWCXxXH0FbuYRmC5AFM15r3SUus5MkkJ7T08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfAUPuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:50:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40424 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbfAUPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:50:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so20899437oth.7;
        Mon, 21 Jan 2019 07:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iq+/bLYjYOQFTGBsWMeESxmK/uNouPHVdUiAadG+hoA=;
        b=ILGkNu1zWFtHa9IgD0h2ywjIngHE5YH0eb0WowdlrGgBRWeoyZ6ycZ8kmwS+Ri1ILs
         /laBW4Z5Wus9JrISNaMAshWBOfpenGbXebqXGT1bKrU7bNrRf0JJaLoISz2BmPppZjZ1
         HvRjzQ8nUzx2IDd22pBHpFkyF4n4d8tSxsjhE3qg6Xf7Q4GYVQzJxhTfkgZnq5WHRBGY
         XnVXebktjYsfYaFjeYTvB472VCq+46xtJH1b+ZYN87ODG9K4bQDeveS2k31lds1i2FYz
         UT5TDp37Hr9BvycUvRwYzhVTSxK8dbaRLK02TB8I7klYKRS91SuCW9wTFe1OFZ5Gz5yA
         q8fQ==
X-Gm-Message-State: AJcUukeXh4S1yskNEM/4p7RtufDqki+Z4aIXlM/vnLihoHq0Fkk3yxR3
        bbfuoVOIt/48mvlyh5ZagA==
X-Google-Smtp-Source: ALg8bN73nQEM542DW0JcUvXY8ztyZ2JJ5R5bGcjEWGyn+Bh6cLoInwXGL4eax+O1/7ZVp10w7cmRwQ==
X-Received: by 2002:a9d:6a4:: with SMTP id 33mr6663260otx.347.1548085838045;
        Mon, 21 Jan 2019 07:50:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m89sm5754236otc.35.2019.01.21.07.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:50:37 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:50:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
Message-ID: <20190121155037.GA5115@bogus>
References: <20190115184406.3164-1-f.fainelli@gmail.com>
 <20190115184406.3164-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115184406.3164-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 10:44:05 -0800, Florian Fainelli wrote:
> Add a binding document for the Broadcom STB reset controller, also known
> as SW_INIT-style reset controller.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/reset/brcm,brcmstb-reset.txt     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
