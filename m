Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EDDC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB42020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB42020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbeGYROn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:14:43 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54544 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbeGYROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:14:43 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so9409862itb.4;
        Wed, 25 Jul 2018 09:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=72B/WctQ8yigRW9oPwK3IwErAExvALF5lKkmW+DitzA=;
        b=A4LLayNiEYwZdAtMadhmXk73eOJsa/Ev+BZUGKD1qtI/OtrfPAQloYaeINqc5CFyLU
         7EXXgt3DIPxfmtPA/KXR8miwvsBXG3Qh6PGbOFqysBtfhsqpXH3PU+v1O+CuKVOYxUUW
         /E3s6bmIs00C9oYNsjZqA686PvFqyxXLFY0a3NBqpuvVdmxPCD9RWqRj6vXquHqR4JJ2
         itHkmrR4yUtngZA12lhuSjwWcR8KxYED5ZFyBKp2BhaCpoCzgZA674jZR95OthylLuD/
         PAiadK8dziZpPV+tW+CtRfLp0TRPVcsSPwuFl20tAdctGl+K7Ff1Tnt5wpsWh0rdgW/Q
         sw1A==
X-Gm-Message-State: AOUpUlEwxlqBpDGf16bbmVpE0ABuJ2zKELLUQ81AFunMRw/dIROOb1Wl
        Kmg/i6c6VjLYupQsBZIqNQ==
X-Google-Smtp-Source: AAOMgpe5C+7xiiWfN5UJUTZdjhmT9fvOYjr2DMsie5h7cXrg0AmCt9W9iP3sJV7v7N+CnBn/Te1JkA==
X-Received: by 2002:a24:c2c2:: with SMTP id i185-v6mr7030573itg.76.1532534544882;
        Wed, 25 Jul 2018 09:02:24 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b90-v6sm4073914itd.18.2018.07.25.09.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 09:02:24 -0700 (PDT)
Date:   Wed, 25 Jul 2018 10:02:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     nick@shmanahar.org, dmitry.torokhov@gmail.com,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: atmel_mxt_ts: Document optional voltage
 regulators
Message-ID: <20180725160223.GA19907@rob-hp-laptop>
References: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531851386-17840-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531851386-17840-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 08:16:26PM +0200, Paweł Chmiel wrote:
> Document new optional voltage regulators, which can be used
> to power down/up touchscreen.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
