Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E48C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA66218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338386;
	bh=ncv9heIClqjrRvIQxsty/t2Yqq+Mcoa40Y+Z2QDODCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=URdUt6wNA+IHgEBl0kATeCimkVzcm/SR5xEQ7UeWKNZEv5DbaNSkxy0XUU9yrPcBc
	 v5V8m7+Wy5+jMGsLeJ4p6Je6oY+rpm/oRHbRQxyMmat7A0avmrL5mGZJ3hnfybgQL8
	 Aj/DB3OuorszFBmJYqEJ4hgwhyG432UFRyACNcQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbeLTUjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:39:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41322 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeLTUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:39:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so3166423otk.8;
        Thu, 20 Dec 2018 12:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Djh0yrrCYCyDXYppYvHHdRAWMSbgP+p1lcwNh+4uUBk=;
        b=UmW7mHhIXbXW5s96OHUd+y5QA3wInYhQJXDYBUevPPUOOzBt9mPv9OgcvBXghp5Ozi
         ejzUFAuaaKFwD4K6O755++Zip2NXfkMSosw4RZWEll2bZWbs7GgA4VF9e96I3zqRkyXJ
         lJoUZvB22HE6Y/BMG2ImNQJBrdd4uO2smFNrvppLHvBe9Hr9SuofRSIr9le96OoKNm95
         JO5Fntw0Srt5ZKBfoZzTGefJLYy/QF+GI4GKsznK2ssgBvHSnsXHT+eL51whGDg6u6FJ
         JSLN7QeO9CqrrSMzA2NiOnmICgfrsfIYcoy7tiKpsb3u+dDCZhZD172qcM4YdnHFsNB+
         ZatA==
X-Gm-Message-State: AA+aEWZ/Ux+jhgkPPdvyaDJCKJhPzfhOsqupWkIsN9/hKF2IXVWhGhri
        X2V7Gd8+4imGGm1Zolqpg15vKBM=
X-Google-Smtp-Source: AFSGD/Vk1iVi0yOvoQf8SzNxKG5E04W9dr7DqZCqkeX2za59M2xEnAYLsj+9/65Z1t74VZS6HL6W0A==
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr18681500otq.348.1545338380062;
        Thu, 20 Dec 2018 12:39:40 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id l1sm12209693oib.10.2018.12.20.12.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:39:39 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:39:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
Message-ID: <20181220203938.GA23828@bogus>
References: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 20:21:11 +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
