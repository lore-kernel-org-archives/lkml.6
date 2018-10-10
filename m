Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD80C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439292151D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJeKUxfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439292151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJJQC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:02:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44631 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeJJQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:02:59 -0400
Received: by mail-io1-f66.google.com with SMTP id x26-v6so3265077iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fcc3mQJLQGeOZR/rJDAa/pISBbYSbBj4Ef4Nq4qd2Q=;
        b=NJeKUxfUS3a7sqNcCwNMoL5mDIZaE4BbGWV+F0nzMJr4cKU5POaDMAic97SFsQVGzE
         XVL19v/2t+TIGMe1M1nrdGv7AN1hEzfHK/Ekh90vmdK3JwrR2B01IkoqH7AqaO7Ury1n
         Kea4AbbtuaBu0U0kibMUMIdCdee0PvYf9WsZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fcc3mQJLQGeOZR/rJDAa/pISBbYSbBj4Ef4Nq4qd2Q=;
        b=rEsDhv1xe6009yWno+wmRB7jWcL+ufyaj7qqwFtQkkeZv4kwsrkZ/wSEvX36Jnwt24
         dBEWUXbm6y9HFUbf2rerk7+Q4R/MVHSSNMrNU/dw0jO6D5JiJJnKxeE2qgpMrWLYYDxy
         fnU73xtkJoMkl1djBJtqW7vlN+pW2REkbx3MIuMHcDTGAAnTSuL7z0NFraobKKF4LTrt
         m5RyxHKx0cgKWUbivbLKPqNc7yb4v7dr2tHR/RA74yxR7Z+1Rf9tPx8pBA3XIKiqwfQg
         32pD8UdHQHkiBcv/seQOQf7N98rSllTEFOWXHpDqYRgoXEnlUsHnOK5d68VP6pORCBsP
         1zLg==
X-Gm-Message-State: ABuFfogRjKW1TVbHjgFS1aD20fyzigM3LJQoLjwrW4zQbXN5CumAVd/1
        MLynsrSJobhBY90bPH2H+2EZea1R5LIT+4W4Ru3Phg==
X-Google-Smtp-Source: ACcGV60s5H4ZHYD2rmnaROT7KXUn5R8RbO5Q9fWtAP6weZ0lAyBppjv7UG94iWauCThjz2YgG3I6xAOQMfXAEj/46DA=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr19776924ioa.277.1539160911234;
 Wed, 10 Oct 2018 01:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181008211205.2900-1-vz@mleia.com> <20181008211205.2900-2-vz@mleia.com>
In-Reply-To: <20181008211205.2900-2-vz@mleia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 10:41:38 +0200
Message-ID: <CACRpkdb9Lwshpt+haJur_7ESOD50t=8PE-ct-UO5yJFRfrM6Lw@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: mfd: ds90ux9xx: add description of TI
 DS90Ux9xx ICs
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-media@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandeep_Jain@mentor.com,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Oct 8, 2018 at 11:12 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
> From: Sandeep Jain <Sandeep_Jain@mentor.com>
(...)
> +- ti,pixel-clock-edge : Selects Pixel Clock Edge.
> +       Possible values are "<1>" or "<0>".
> +       If "ti,pixel-clock-edge" is High <1>, output data is strobed on the
> +       Rising edge of the PCLK. If ti,pixel-clock-edge is Low <0>, data is
> +       strobed on the Falling edge of the PCLK.
> +       If "ti,pixel-clock-edge" is not mentioned, the pixel clock edge
> +       value is not touched and given by hardware pin strapping.

Please use the existing binding in
Documentation/devicetree/bindings/display/panel/display-timing.txt
for this: pixelclk-active = [<0>|<1>];

Please reference the above document in your binding.

Yours,
Linus Walleij
