Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E60ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4D02087E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLZj9q0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4D02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeIPCZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:25:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45849 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPCZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:25:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id x26-v6so5905297pge.12;
        Sat, 15 Sep 2018 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aVCA8w0qTqnZepwGgnWk7wASGey8vBP05GMzK9vjJuA=;
        b=dLZj9q0oKvdIas2Db9+EhcW7RjPeN6YQ0Ssg1LB1/uNXv7/4nrsP1VEh6XoaopPeU4
         gVPpsy3YFFfpIFwHxxtGzRPjWcMdbVrIjIyLuSOISXpdufVVRQkTdcO8IOtl7DIVhKt2
         LaBAxiMBfVOpl0zqYk8j8jOWCw3bJw0CSO6xUjAXCu5G2hbZDUWC0zTJK6WKmuqv6N6i
         uOFwRiJ5UlacE1hKc1MYGEznFea4DkNWLi/Yti4lJoP32p3yhXYhvWi2IqPD+5lsPz/L
         d8xjLVIKlFga8foAQMyUUESgTzd5WRnBdffNVn+0Htwcz97cgLwsWRdEiCfyFNJhBktY
         eP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aVCA8w0qTqnZepwGgnWk7wASGey8vBP05GMzK9vjJuA=;
        b=rtbIvTf2iXy9GQsjdlSm5Ixy2CMz2AHsQYg6lRSzGRt8mG5FGkMw5mb2TfaSZRrHEf
         W1c2pCjICqJIZPHvBlk5t6tZRvUSVgsc/HjIlOWyz+WLYvns2rCq+M7pK+204N8LklEt
         KtErB1iBjXvNOP8LeolPRqJ/Ru0hPK01v3pogIaM6o0bidZRaf3HxV6o1rOTd9GqFq6z
         VYQZYZf876DKhi5SiEOBTjaddTeMXN1Aofg7e1IUw6x6JGwWwgEvt4/ykHuaDttM7dnX
         O9Vfp8UjP5qcpYmnUgVfV9wBmb909NAZQpHNtiynWl/M/BfBq3I6g4DN3Y3LEkzZumLf
         ICzQ==
X-Gm-Message-State: APzg51AGxOwFzncB8KOsSicigrmZk4MXUAQYWyTORzXuVp19I+5XNyw1
        aVCz/63ZY2lMjTfQ8flhUig=
X-Google-Smtp-Source: ANB0VdaEaXM+LYV0kPsHrVE/3wrP2Kwt9TH7aFO4yCrNCFE5qOIda8E8JY2rHrCuZFoP7VNN9Lmv0w==
X-Received: by 2002:a63:a112:: with SMTP id b18-v6mr14855061pgf.384.1537045490764;
        Sat, 15 Sep 2018 14:04:50 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id x24-v6sm13416824pfh.67.2018.09.15.14.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:04:49 -0700 (PDT)
Subject: Re: [PATCH net-next v3 04/11] net: mscc: ocelot: move the HSIO header
 to include/soc
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <45bc0a8bd6a1dfc35adcedc3581124879fdb5a07.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <17213365-dac5-1dc4-b5a6-96560455c426@gmail.com>
Date:   Fri, 14 Sep 2018 19:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <45bc0a8bd6a1dfc35adcedc3581124879fdb5a07.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:16, Quentin Schulz wrote:
> Since HSIO address space can be used by different drivers (PLL, SerDes
> muxing, temperature sensor), let's move it somewhere it can be included
> by all drivers.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Nothing wrong with the patch, you likely would have wanted to use git
format-patch -M such that the diff would have been showing that the file
was renamed.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
