Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4526C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F31720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547582347;
	bh=y9qwtymLhtt5KIO2H3mStADQ6XNTauLyiD3AuXxUD8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NxmM8jec35uaGGhKGme0l45qQhuiYnXm8oDFsCgvsDziKcHVmb0+kXAT8aZP4z/Ea
	 IuHlCTRG74AhaW2DuIoMnONUZUzuxv5+eZSUFDnIogaYL2lvcdMsHMNcvbNShdDAvX
	 vG0QMgqA4O/u3bkJ9KX9B+WtraoaAYKSno1I55iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389561AbfAOT7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:59:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35949 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732180AbfAOT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:59:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so3147134oix.3;
        Tue, 15 Jan 2019 11:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6cvaXhF+m5MMZK9Hp/wipHqIYddrdvi4/onQTSvPygE=;
        b=OQV+SQdxt5g7XnvPp1ogAP7hx0CuN7g/UEBN0JvzflJWICy42hpO0KumE4Uwockq+1
         opkWMqWW3ZzNWHrb3gxWkXXQo/IepspyZnTFBsaf0sAM2BEcFqc7cneQIoz7gmjW++9W
         O0J8ECOIkmVRRxqolJEFoLAA/oNCgs5W0oSpY4mIOkkA6qBEeqOMGTixAxC3b/xsAHFl
         PU9jZrU7UiNGVW2kkxDgLTvYX8oHkpCFVTPKAUnUDQ2Tk9Cuk4IWcLTiLy8wxMsmj9pl
         860+HA1xw8l6/1TFAUqrY02YvCZIgBaG7lJnkMbKpzbM3efX/OLb2MSLhIdo23jOZ32O
         g8mg==
X-Gm-Message-State: AJcUukdS4mrqfkfFrbU0jvrIqPVB7gBM6mkX8/372nOHEe3dE5NXKSSO
        N5aaDAxt/sBDJNS6VEvnrA==
X-Google-Smtp-Source: ALg8bN6ikZuRMOoZdLrriMdvgGvRdGXc3i+dmRYtZkGmw8g3DNJFcJcCkOqXpnEpXPc7HAc5XMpRnw==
X-Received: by 2002:aca:100b:: with SMTP id 11mr2758776oiq.303.1547582343364;
        Tue, 15 Jan 2019 11:59:03 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id v20sm2065277otp.10.2019.01.15.11.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 11:59:02 -0800 (PST)
Date:   Tue, 15 Jan 2019 13:59:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "GitAuthor: Lars Poeschel" <poeschel@lemonage.de>,
        open list <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 2/7] nfc: pn532_uart: Add NXP PN532 to devicetree docs
Message-ID: <20190115195902.GA3106@bogus>
References: <20190111161812.26325-1-poeschel@lemonage.de>
 <20190111161812.26325-2-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111161812.26325-2-poeschel@lemonage.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 17:18:05 +0100, Lars Poeschel wrote:
> Add a simple binding doc for the pn532.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
> Changes in v4:
> - Add documentation about reg property in case of i2c
> 
> Changes in v3:
> - seperate binding doc instead of entry in trivial-devices.txt
> 
>  .../devicetree/bindings/nfc/pn532.txt         | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nfc/pn532.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
