Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CEBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC2E2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YPOyfrwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfBTRW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:22:29 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53293 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfBTRW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:22:28 -0500
Received: by mail-it1-f195.google.com with SMTP id x131so17123304itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 09:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDvpq+KwTZ2rtXo19yuIW5EnqLoicFRkDJnWKKfh1gg=;
        b=YPOyfrwUmrj72HNJHEDHnPmiQpMmWBQ02db9AvHGeB/vjWhStM1AwZNWEtuuoCY5J3
         1GLKxvNwGlZkTAIPLuLdK9AOh6ptLJ1Uois81TMvmblYeyanRXuxTB8xRUUpLLtR0Ycl
         KJZp1UC5xgFzLR3TpbRwhbZhEmhcrK5BqNpP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDvpq+KwTZ2rtXo19yuIW5EnqLoicFRkDJnWKKfh1gg=;
        b=bchy2d3NK2IjnXZqa+qZU2lr2hm55vYVwQxmfJwS1Qpi0q/koo4E/QXCQYXq0cxWDs
         sTzNOzrckcpsT6StLwDJCd0qYLnPcj2gheh9i9MfVX2W5pILCMkXTzmJvKWBnzi+1hnL
         JIw0EMgm5HbefdBRzIO1qFKJy7GETFBZTJ2b+Y6RxksyQwq4rTA29F+ivb00SI+qBs57
         hWwdnSPXdg2q/uQntwy273aPWd0IMHmJZG61lAO8IB1EbXX5aC4yl98lQj+rLMnKRvDv
         kj3XCI3oW3bxVc8Tx+72o4stdl94xYdac9eJT/ioCDNFBw/n6BGchxtizN9wzjXO3wRm
         3dhQ==
X-Gm-Message-State: AHQUAuZXiwrYNTrfY4OZIKajpOUqUozI+pPlPH9tsw/sM5XaSMktFrjP
        tDuhOUFTBrs+h4BM+QOUIdwaFIGdMVqdYyTuFjIlFw==
X-Google-Smtp-Source: AHgI3IaVEAaUTEQCW6EGWlDIP+DgIuG7rR9zMO/1A6zDiYAccYyz5QngSLbJhsSS0C9XBfCK87q4KnF7AWRN1tAJABs=
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr22353383ios.267.1550683347931;
 Wed, 20 Feb 2019 09:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20190212113808.3040-1-jagan@amarulasolutions.com>
In-Reply-To: <20190212113808.3040-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 20 Feb 2019 22:52:16 +0530
Message-ID: <CAMty3ZBaOZoj+xV+e+4BtYdaWA2biwENmngOa9vbbMB=_vbB1w@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: hwmon: Add missing documentation for lm75
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 5:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Add missing dt-binding documentation for lm75 hwmon sensor.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> -  Add all compatible nodes available in lm75.
>
>  .../devicetree/bindings/hwmon/lm75.txt        | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt

Any comments on this? It is blocking some dts changes to get merge
into Mainline.
