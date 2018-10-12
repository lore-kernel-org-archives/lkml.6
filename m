Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F71C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB2D2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB2D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeJMDF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:05:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43197 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeJMDF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:05:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id k9so13401449otl.10;
        Fri, 12 Oct 2018 12:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XcM8JEM5fApOvt1PNqKt26Nq5HS9EUXp4oFNTEwbIME=;
        b=kHpK47IDlSgQJ7CNCrv8CtCZ99q61OIJio1m73nrHb/oktudeZeaGb+diFeF6iI8Lk
         G3pnJXjyB1E2bmAN1jDnMCKdzKXvAwPZ+X/nS+fy2ZOZDgBrQ+tujuMBMOoR1ESYqUqI
         LMG6tNR9kVeHcUiasZk7c7vgUu+QLY4O9GH5VvInSoeY6Kl1Fa8bUOgHlht5wcW6cdNf
         +GaMqD4/qk0hKe4TvFZw0rawj9r3Wnb0A4NYD5G9OuoAe/9yeY/0AlihizA/VyZ3zXaT
         Y1PZ9teYNhLmR28uvUp31O11u3G2FySnP7YS7g8iilCbFcCKtrupng9VD7DKH4mGgrFG
         zB0w==
X-Gm-Message-State: ABuFfoglQee1rdmogi3WU7v76bycFQsALiEecT6hdrTzjJATI5m8Me7+
        eQavE/NIan2BbXWl9GujMQ==
X-Google-Smtp-Source: ACcGV61mchkNu/QzKPwq7e+djHUTnsS8xG/NSID6UDq7m2sXb3Fj74/GXCZZoBTSDF74kn0Ak1HzUQ==
X-Received: by 2002:a9d:40f7:: with SMTP id t52mr4273145oti.311.1539372688400;
        Fri, 12 Oct 2018 12:31:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 110sm619165otj.19.2018.10.12.12.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 12:31:27 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:31:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh@kernel.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.reichel@collabora.co.uk,
        mark.rutland@arm.com, masneyb@onstation.org
Subject: Re: [PATCH v2] dt-bindings: input: pwm-vibrator: correct pwms in
 example
Message-ID: <20181012193126.GA26994@bogus>
References: <20180927004858.32529-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927004858.32529-1-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 20:48:58 -0400, Brian Masney wrote:
> In the example for the pwm-vibrator bindings, pwm8 is the direction pin,
> and pwm9 is the enable pin. The pwms on the vibrator node has these two
> values swapped so this patch corrects it.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v1:
> - Swapped the pwms values instead of the pwm-names values since enable
>   is required and direction is optional. Based on feedback from
>   Rob Herring.
> 
>  Documentation/devicetree/bindings/input/pwm-vibrator.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
