Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46613C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1395220C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550504744;
	bh=SWM9HvWEfVBcNWpLYSBRkD6Ca+zne/Oge9/BMoqVVQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YTHZKhXe0J+iFAb/QqjlCkc8BrCDdK4ZkC6gQ64+q1Cj6o8CmBYMLLAQerLHMp/Rh
	 7hSKUqFKVSKWaWi+oKbFTw828PtvWIRTIurThCdKxYtDeiuCg+sXlXC6kay4+CmGK6
	 1lwnkoOjMTfK+mYTQVI1ZcxyxIeg+WgaR+Y0ul8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbfBRPpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:45:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40147 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbfBRPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:45:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so28969587oth.7;
        Mon, 18 Feb 2019 07:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9d5KTNYlqKLdM80e7VFTFOD0NSCi+SOpMQQrL5Ar+Jo=;
        b=SqX+Ion4e7f8ohOWN6fgzpmCGF/lpMyxPibWUWLS2rFemtC2VOPiUJFTpkcsHEvD6q
         H4FLKYYQNqvxNXpM1iZAv7xDEnF8YyypDxOnCRuHrmBTHCxXDZ1ewAI53hebKWr7aRvd
         CbS4KW7sYCpA9mtiKAeq/0jD9q9HLCdfq26ucrRupxc6Lre/0ws+mTofwpX0ggyoIH1a
         YlEm+omfvz7YJZ5SFUbmmSqVVJRAGxPWexvB6AcWz9rdTx1D88LYc0orQi9PNZKlE2km
         m2XJNowkYGKyDnZYyJvU4S5udL42Gj59JbiAPjQMCYODUj8UBdqku2X7hYTeJR7UlQ6d
         v/Zw==
X-Gm-Message-State: AHQUAuYd3tA7x69gXu15FT52wIrk+SuzOrNzX2nJyDlbIBrFUbt8gjHA
        eKgAsTKIJaGwlbIxC4cYa39n3ks=
X-Google-Smtp-Source: AHgI3IZjSL/iDlsKybOrcdiV2Ks+t5V5QXPo7X+CbaE196HL5k75+xGZmkUCLEcdzHLY6ExyJcrNpw==
X-Received: by 2002:a9d:5c82:: with SMTP id a2mr9767882oti.3.1550504741188;
        Mon, 18 Feb 2019 07:45:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q10sm5742847otl.15.2019.02.18.07.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 07:45:40 -0800 (PST)
Date:   Mon, 18 Feb 2019 09:45:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: input: touchscreen: goodix: Document
 regulator properties
Message-ID: <20190218154540.GC28558@bogus>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
 <20190217091436.3702-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217091436.3702-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 02:44:33PM +0530, Jagan Teki wrote:
> Goodix CTP controllers support analog, digital and gpio regulator
> supplies on relevant controller pin configurations.
> 
> Out of which AVDD28 regulator is mandatory supplied regulator in most
> of the board designs, so document AVDD28 as required property and
> rest marked as optional regulators.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../devicetree/bindings/input/touchscreen/goodix.txt       | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

