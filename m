Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E2C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E81A218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338126;
	bh=rFyw9wzfwhrOXv31IQbgV4kDWP+G3l1GBOYtg1RVk9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TIQMAUvikdC53ZXsleDPSx+55VF+LpXkcP6SnH0nswipWm8sLOOhOg3umn4CcSohu
	 G3fSQrybONj2GYpvjjZtAbxldmKaB9RvDRnWQpu/18vcqEYhMPRNuer27QRGzWAyFC
	 N2NlYRJH3/uvktIfCWXHlfpYZBi4Opwnt25aPJCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbeLTUfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:35:25 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35222 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeLTUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:35:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so3011772oif.2;
        Thu, 20 Dec 2018 12:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NTFJUVPQghivUHhiPHuLrBOSdI7uTrC9xfUu6pjHapo=;
        b=MZcXV2j3BVd2Zb5iFsY4I8CJ6I9EAV/KiBoSWPnGBdS8esiZW9oy+G+0m56eOUwuRn
         jWLEFw61DYqmOuXUZJpeuVcWgo9O7Gho5ZMe6K76NgvfdqjOjWUIWjyO0l5d06fZwoT4
         fMZW+RkDlHS0KOYMWTMqLPD2FF1dY1XwafgodAbUt3OcUb1pcx5GFuY12IMAfL9m++4s
         6LBr80nIAGeLekAGyEDlHkSZqxMfrTIcD6YznYPvNfxtDefJr6nX6HLhnveNjxtar6hk
         rMC+XsW1G3cqyw1rBa+lP2eSx3c02AMgE0CWhjPeOSompljDOkphXb6Wie6dMJ7Uy4FU
         na2w==
X-Gm-Message-State: AJcUukdFb2zwkUmxZUIXYnFytExM8HQc+lBslEFiGnSyMvoPdo04FjjG
        qzqNzwNBHAGQBXklB+1pAA==
X-Google-Smtp-Source: ALg8bN7hCa3lpXKAtU8bcgK8UOJe44fE9gaKeezZBZLrGKM+47KpOxfveoRaY/OaB1AqikpmdyaPrQ==
X-Received: by 2002:aca:cc8b:: with SMTP id c133mr160013oig.256.1545338124082;
        Thu, 20 Dec 2018 12:35:24 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id j5sm22159341otc.54.2018.12.20.12.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:35:23 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:35:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a774c0
 support
Message-ID: <20181220203522.GA17057@bogus>
References: <1544732333-6086-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732333-6086-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 20:18:53 +0000, Fabrizio Castro wrote:
> RZ/G2E (R8A774C0) watchdog implementation is compatible with R-Car
> Gen3, therefore add relevant documentation.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
