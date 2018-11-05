Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67873C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AF42085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AF42085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbeKFE4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:56:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44592 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbeKFE4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:56:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id z33so9024637otz.11;
        Mon, 05 Nov 2018 11:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yb130KbG0i0J+uDFVTAIFLJyS2WXRzV4IKg0+gm6MT0=;
        b=i2gVf2dnyybyD9yvI5VcwxNKgkVmGr0HL38ompGtfwa0z1Vns5o9QKn/OXIQeVbzhY
         FT/o9mVTcsgWWPnANLA3yLCDF8nVlbUjwmhq+al0Nid5fqevgBwtnrYZ8HYB8QrIDDCc
         /3epkelOWN7NBNfy7irKQYfltsKcV9Q+vwFsWnGemrOSvEyGW4IIMWax4/0vCbA/diVt
         k1pqNw8TAB+CDPMR9DvzAMGlVABhCSnHTOVW+iCo/4E7wnTkkUYM2Y65yFnsWsucGshN
         Cs1G9jE3/dRSjwHE/gE6MOK1k2PDwcrGo2VUl1DkerI2LUSDwV6+A9s9vhXhO4SPQLwf
         RMRg==
X-Gm-Message-State: AGRZ1gLKXVKz7+bv78Uim4011nP4jk7P2HXZ9ZBUc2UH8b3gq3GBvVhI
        6v7s12ITTCB+1GME0GEkdw==
X-Google-Smtp-Source: AJdET5eVqguy47y8DKtWQa8H5b+AeoW/yZDFI0EyvuEM6T4WF+Qus//+UorGg6gPwrP1XddwyolfVA==
X-Received: by 2002:a9d:41ca:: with SMTP id v10mr15317340oti.101.1541446518071;
        Mon, 05 Nov 2018 11:35:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r62-v6sm7148961oig.14.2018.11.05.11.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:35:17 -0800 (PST)
Date:   Mon, 5 Nov 2018 13:35:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "GitAuthor: Lars Poeschel" <poeschel@lemonage.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] nfc: pn532_uart: Add NXP PN532 to devicetree docs
Message-ID: <20181105193515.GA22755@bogus>
References: <20181101100216.613-1-poeschel@lemonage.de>
 <20181101100216.613-2-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101100216.613-2-poeschel@lemonage.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Nov 2018 11:02:10 +0100, Lars Poeschel wrote:
> Add a simple binding doc for the pn532.
> 
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

Reviewed-by: Rob Herring <robh@kernel.org>
