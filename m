Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E91920663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551106455;
	bh=CmQ+CUmLxd7zmEvOnK/7uF3nO49dLT6iSJXDiTly44M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cuSxez6OB4D3nA+4s1/a7+I1fvc0TBSmn9zN21t8d0jS3fdUQp4OuooTI9ZNnpGui
	 BJsnJCBwbQFNy+SCYf/00y3MsMdmWQWzv2etIYJTwRzjY/0fYfFS+JMWRjgpXAk9Pi
	 tCnLow5/YcK1NJB0cYgqUOhiQXgdVrxM5OIj4o9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfBYOyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:54:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38517 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfBYOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:54:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so7451185oic.5;
        Mon, 25 Feb 2019 06:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Gl2EuzEqgGIyrDurt9KFiKnrmlZzEA+FdttOF+FPco=;
        b=VYLEdJclmbe8THTzgAwTqE7R48tKWjQBDEq87zRwKep38n9gBp1iuZhdUH7Ix/SYT7
         n1no85tgTHVLw0EsXMvG1eXuV9k3PMDvPfnGP5q5QZdSUMx8Sjaro6hPSdBxF6fAZ6Ja
         sEwwMPvaJomNZ4RJJoBW8/HThYiTb0aF8NPUSU8T47YkG0c3oc9qeQ7ejJM03owJ+Fl2
         emuVq9EdH4dhqS9wQ35Sc19xvqkLWrB4bbroFairfbppAvbPLwRRqK3DpxxIy/isq1N+
         EzucSBOt1yqONuEAV0X0i2iBROrTx7YVx/FTWMSoZM1YvrQsJ8U9Fko/uFlGxtnORmqt
         57OA==
X-Gm-Message-State: AHQUAuZ8Q/YznNdUP3OyxF6uXpFVQ9fuo0ZiZjrBBCW4nmSTdoyFaZfa
        0Fx7h+coPt38VFxYCDHKuw==
X-Google-Smtp-Source: AHgI3IZAIV1hZ83tg+08jkoMTdRqtz1QJp4uCHZK5C1W25F0+Rdub3PpfYNvkPnUzPyDhEI3JJXlfg==
X-Received: by 2002:aca:d403:: with SMTP id l3mr11345357oig.179.1551106450950;
        Mon, 25 Feb 2019 06:54:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm4541074ois.2.2019.02.25.06.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:54:10 -0800 (PST)
Date:   Mon, 25 Feb 2019 08:54:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 2/6] dt-bindings: mfd: Add compatible for the MediaTek
 MT6358 PMIC
Message-ID: <20190225145409.GA724@bogus>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-3-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548839891-20932-3-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 17:18:07 +0800, Hsin-Hsiung Wang wrote:
> This adds compatible for the MediaTek MT6358 PMIC.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
