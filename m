Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA01626201
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FctjJpqm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IXI5VBZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA01626201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeFYWj2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:39:28 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41032 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754284AbeFYWjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:39:24 -0400
Received: by mail-yb0-f194.google.com with SMTP id y187-v6so4853074yby.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Qy0nzhq6h9a6ngk12W0gfZRrfJe/NnEtt+o6RrGrr+A=;
        b=FctjJpqmt2NIlo8dd6yAw/xVrDOEdygCu9BGc0LXDdmL2+m/+x9aKZLf11VjcWy9UY
         6rl1zlUDDImDglNLHZz+OYP8PZd6zWC7mxs/Clbzqi6H9zGu9RfWBiBWWkAWScsQVlTs
         rFKTt1mV1uOx3dlpqjhIfwtviiCczS+x9RPtGMJBWn5lJV8U+7mn1ZaclYM/2+qXCrpJ
         7CymPD9TJ56YudrtL7jQgs7hJ3xM2bWUz9J6rgRsk8zTEjypUPn8XxfclrjzedUdDD62
         xDsX9wy5kVw2/ujUiI9zzCKJGKoTMTCJ+o1B50BgjMg7SfKRREDopPJe2F0NbgTrO8oF
         Hu6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Qy0nzhq6h9a6ngk12W0gfZRrfJe/NnEtt+o6RrGrr+A=;
        b=IXI5VBZpS2QIa1yq1as/HeYOL/ZYbhErAfAH1gp22oevUz6vLZDfIQbVaUlnv2kPYb
         XMer+82aLd9/xJuxMrM5c1xEHqUmw5IhP1AkCaVe++0HRo0sSy37AkyKURSRnfhfFiQt
         uRx3FQgyRyWR0T8WBRRbVQFRtpo8YovmWnS6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Qy0nzhq6h9a6ngk12W0gfZRrfJe/NnEtt+o6RrGrr+A=;
        b=RsHSY1NIQt/wbiUHIVUCFWm28yWvLdoYyochN1YVH1doSTREc5Ip1y8qQQEdxqroKJ
         GurJTkBKpC2KpFT580yYH1VSjUe5k3Qy0C3SJgn0OJn14XgTLXh2ia0wgN5At9dhvrpt
         yio8eve6pedV4JnMw9ZhkJZ5qP+RXu2RCpd29Nac6QqnWry9n9kCylYf12D2pSjQ5hYM
         eNAd9T1Sz6Fab1sIckoFmPF4q1niAdFCNK3Mq5FgyCw64QaVu58Pqy5ENoT3rRLBNpCC
         Nv1R+Th4F/OCecSfrvMdy7H/Bay5Mse/tAA5eqJMM8lFbbHXuy8pYtlUtnqSOXNooich
         ugKQ==
X-Gm-Message-State: APt69E2ST9lsFKksUUHjw4gxrIGaa4//2Tpq+Kk73s4sQRGSozlBA6qk
        aLOgIdZCF9HgFeYwvSPDjTSNAhuAOByDSbMxypF5WmEM
X-Google-Smtp-Source: ADUXVKJ7iJOeDJSZT7qWDmtKo9DYM6qr/8/Y6EAgOI7UeUu2KMkqVsdZG6HwWOpR3MhavH5shNP+204/qnoOOCKNWp4=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr7470530ybi.193.1529966363948;
 Mon, 25 Jun 2018 15:39:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 15:39:23
 -0700 (PDT)
In-Reply-To: <c892c7e7b271c9a269c78887777e691dce12f5c8.camel@perches.com>
References: <20180625220917.GA25022@beast> <c892c7e7b271c9a269c78887777e691dce12f5c8.camel@perches.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Jun 2018 15:39:23 -0700
X-Google-Sender-Auth: 4fdA_g2n6ERMy696lZPgthtiPTw
Message-ID: <CAGXu5j+Y0gJydvqtb0mo8oZPgtWYzqwm+5fYudiUw9V5nMqwqw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] mdio-mux-gpio: Remove VLA usage
To:     Joe Perches <joe@perches.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 3:23 PM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-06-25 at 15:09 -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> allocates the values buffer during the callback instead of putting it
>> on the stack.
>
> []
>
>> diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
> []
>> @@ -44,15 +44,21 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
>>  static int mdio_mux_gpio_probe(struct platform_device *pdev)
>>  {
> []
>> +     s = devm_kzalloc(&pdev->dev, sizeof(*s->values) * gpios->ndescs +
>> +                                  sizeof(*s), GFP_KERNEL);
>
> Isn't this supposed to use your new struct_size()

Why yes. Yes it is. :) When treewide changes meet in the night! :)
I'll send a v4.

-Kees

-- 
Kees Cook
Pixel Security
