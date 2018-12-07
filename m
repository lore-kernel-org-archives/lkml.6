Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F9BC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5333720882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544202477;
	bh=jVnn829p3Ktwkb+LVkEHBreDVHJ2BP/XXESryK4brLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rvc8y/hJ0N0MeGj61ZdQFFhSvB9PXwfDR8JDSCEyboYDoHB3/0Q5l2Y/oo8Qh6Rh3
	 /I2f0M5jb+hljP31Y68etASr+U4SML2mvw7wb8M1/udBhoBI9HddJvJnU+QCJOVhSA
	 EHHiivfKJNCiQCs3q9PeC0/rKsMtF19QXuXOOEe0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5333720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLGRH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:07:56 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45684 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGRH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:07:56 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so2150044oie.12;
        Fri, 07 Dec 2018 09:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lx3yKme3a+tKbsh1NaWS0ZPEmLxq4q3lshnPeKDTnEs=;
        b=VYnrI+TZSUVBB7WNUsoLG/6MAZch6IIzknSIz0j+oogq4P3HIwALGfVdPfiRj/SsYg
         ll5NdxPFjMT4ILu0jR/MDWuKLHiRoxdB4v7AoKrf6nNptgCQQG/t38PfCKnDbDrQT8MV
         W0cdVqbu6ULg1rNKMaeISSNC5fBQqDbY3pVhsfl4nNDMwXO8gJ0ika/s2J9t25oPMLY1
         9SJBVsxVpCt7qJp9dfyniL8MCukeqwlaIM6JnQ9O4DCduAqK4lw1eGAwnJcrjvd+rF0n
         H83OA/gLPq10YF1kFD6IHe/mmraUSQiHjRnyv4uFfQ0lH+M+3GVY/rcyCdyLmXyAQWZj
         u+Fw==
X-Gm-Message-State: AA+aEWYZz1ezxlrYNyugaycfiQn/Ow3gtXJPbNJNEudiPw7zoTr+drn1
        3htwSnsaC4Iv/VIyZDnh17w4N1g=
X-Google-Smtp-Source: AFSGD/XxeP0ne3uPJO1FYn1uZmujKx3jfq30ZzHbVBgB9jM+R5yCzUDhf+jOh2Jc2gcM/WNPbijHtQ==
X-Received: by 2002:aca:b05:: with SMTP id 5mr1758011oil.258.1544202475153;
        Fri, 07 Dec 2018 09:07:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h16sm2214507otl.29.2018.12.07.09.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 09:07:54 -0800 (PST)
Date:   Fri, 7 Dec 2018 11:07:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        broonie@kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 4/8] pinctrl: lochnagar: Add initial binding
 documentation
Message-ID: <20181207170754.GA6499@bogus>
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
 <20181120141631.18949-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120141631.18949-4-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 14:16:27 +0000, Charles Keepax wrote:
> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform. This driver supports the board
> controller chip on the Lochnagar board.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  .../bindings/pinctrl/cirrus,lochnagar.txt          | 141 +++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
