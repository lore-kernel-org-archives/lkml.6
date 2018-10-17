Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD770ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B5C2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B5C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeJRDf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:35:58 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32892 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeJRDf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:35:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id a203-v6so22096403oib.0;
        Wed, 17 Oct 2018 12:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gwM3Pnl5Mt2Cd4znkk9LM9F06bMSPMIguHdR9xeJQF0=;
        b=d2GJCEXvYU4hZbGkVMYz+9cYzkcOyE5XvEGdH5aKZzZICjc2W7pocSQVEfcMAXRUS/
         2p5dPUPKI8RR4F4pxtkgXptTEGvlyTOIOPxDNKVXd8Bwj/Hzswbed5r5VM81a3LePKf4
         80t6CwuejjlyY6mvkkkhv1T0f9CP2yEOEE8hotqPeRrjhao8LyYhh7rYMnJxZIvYu5Xi
         0zfcRhw6IF22WVGp7JIbQmgT6caQf+ecAq9pT68iuA6B+XQoMRU8lAfgSIwxcg4UeNIf
         cTvnyJERGclE7RNL08lfDB7LrxWaSGZLv3Py43fqlYe5Xvd58n7wRYDn15x9JEQ5w1nj
         yL3g==
X-Gm-Message-State: ABuFfoj8dlln5qQbcm10t09RlpVp3SZig+UpYX4+zQ7RXwlDuDNmpS69
        3qwISl+8NNY/JvjXnEo0tA==
X-Google-Smtp-Source: ACcGV60UVq9cOISQyVANC5RDrgl2NGRv6R0od9L7A6Y8snl/xXrNhFior+LX4seSQsaG5SmLbeKreg==
X-Received: by 2002:aca:b357:: with SMTP id c84-v6mr15343665oif.266.1539805126230;
        Wed, 17 Oct 2018 12:38:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p185-v6sm5750154oic.36.2018.10.17.12.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 12:38:45 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:38:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 10/15] dt-bindings: olpc_battery: Add XO-1.5 battery
Message-ID: <20181017193844.GA17316@bogus>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-11-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-11-lkundrak@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 19:22:55 +0200, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/power/supply/olpc_battery.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
