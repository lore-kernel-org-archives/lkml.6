Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322FFC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F248020879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548085912;
	bh=1XUjjwuIITCt+3sOauttNdpJNP7kPz5owFVqRUy35vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UMpX2srEIeAwTXGhlZGg5kEb7xiol0wyRs+e6C+AYizN6/p46KG64PE1ccAA4+igI
	 Obl5GENaINnLZpGytcRwWCESkzchTxj2lvwCbdIqGTdI7cAM18CmM8FIrIeUZQJQUI
	 gou1N1etLUte4arrhCWYha5h0nYybu5c6oMROMjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfAUPvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:51:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35365 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfAUPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:51:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so20954436otj.2;
        Mon, 21 Jan 2019 07:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5cJlApinZk5e8sSAj3t8iwGI2cGG0qydhmxq62sYzTA=;
        b=gvsoOnnPE4kRmKhDCROlJAdLe+pm5T0ks29kbM5PrJiNJzcD81WWpBpdSQ/oH7lfJ9
         gCgHe0DZuNwLUoFizdhd7Pgy/xKO+lZnEgzV4upwGOnRPrcBp9owH4oK3YJo7+HLyifn
         NUxnwVXmh9Uq6FG54yXZxx4LdTnLDWVvFZrnlf8e52sTu5eMlUgBJVNxLgqqVajs5AbP
         Po6H4GD1Yg27uOMsK145U+PTeEDsJqvl6yX2dIq7qrIOK7DFYT0schRuEhAYMoYgxzIA
         qcI+9udhBZ6RINz+C5X1EOd1zXjnZ037S4ZMc6BPnTWRK6iuczIHLT9Rc5rAzulF2uLF
         Jy8g==
X-Gm-Message-State: AJcUuke0oXykr5+46pnLApBhqSJ08KHVTYivmzHe/1lwMYq2ZQtd4ndj
        YjC1sewfh2Mj/fMcazZFrQ==
X-Google-Smtp-Source: ALg8bN7KtxifRvc0HqhQ7yc83zGASGeeCs9aE8wKqVx8oavdSiDB+4dsPqe8mwwNTZJZ3j8U/fXyKg==
X-Received: by 2002:a9d:620f:: with SMTP id g15mr18658363otj.296.1548085908597;
        Mon, 21 Jan 2019 07:51:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a12sm5801438otl.39.2019.01.21.07.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:51:48 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:51:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: pwm: kona: Add new compatible for
 new version pwm-cygnus
Message-ID: <20190121155147.GA7190@bogus>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547669716-20070-2-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547669716-20070-2-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 01:45:13 +0530, Sheetal Tigadoli wrote:
> From: Praveen Kumar B <praveen.b@broadcom.com>
> 
> Add new compatible string for new version pwm-cygnus
> 
> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
