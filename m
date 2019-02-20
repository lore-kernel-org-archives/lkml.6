Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9BCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10ED52089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgu3C/TT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBTJxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:53:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46527 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfBTJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:53:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id g12so7476553lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PzXl7HZONN4035fIPsM0lhsW6FZpjgMkeqMgrv9A4Q=;
        b=pgu3C/TTol1ilNPIOY1rtKDRXCawseSsW4U0HR/3Y2+y0jHI5gsebC92v1YuQJEcYw
         Hjm/ocy8py1zmSSPz5JqyAUZERF7BZjf7SjMrR+hqmepVHlP88B7T+L7b4gqoCbZ0otS
         UAcDfXdF2WgVTgETEIzf7vZ6NuTkJZBP6f7iuoEip1+0QDwwEl4ULqm1KDKhw2AUYha2
         ADbT84ujhlY9cUBCrZZs6/oaS1u2BPh62I7WLVN43NJ95VYeqd2d5kTAwgFD2brhgoRk
         jB0d43krntU3+gR7Z5ft/a5F/DH8b9tl7T3MYzqCWTgtSeyFviOTgkz/P6njaEe693vT
         elSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PzXl7HZONN4035fIPsM0lhsW6FZpjgMkeqMgrv9A4Q=;
        b=HdCD/9pmTeiN/8vNKdQSikTpbjspk3NnDucuOqPsRaEYLCdUcgHGSOOeBLEjvkYBWF
         z/iZq1c/g5yGt8hltcpaA1T/0A5v/0Ywark1iXCMEsX6EDink7VFhKFjuUs/xWszhy0n
         eWVjLA3QkscAsaPp28my2foc2bb1GoVElYtooL61Hb2tUsx09TY0jLsia5DZjJsgXdV8
         TNz3x08n0Lz1Xd9/QivN/csctU9a956Y0i+xjDw/YjmPRpAnfBjRaK2vXVR6J1zX3l04
         qvhYo3EDA0ccDgg9BNqy/sqPOIxqC6gFEY36kqbLnmbIkckDJDZbGI6UrOrNI9vQOQ0Z
         HnqA==
X-Gm-Message-State: AHQUAubPmISgC1qC0TJOMwMMnpTZz3ECsoVGZwMtflBoyb90X2mWA6+6
        +/1m9UpXOkLPWMtZWZWiNX26ZAJ7CtsNfnDaW7KlGg==
X-Google-Smtp-Source: AHgI3Ib3bG277c8Bai7doS0Z/elOaKF9LwTe7fQC/1cqsQc+uk2LP3pXYXk1ImA6G/dhIL5PMED8fju3xDwDm+cJa0I=
X-Received: by 2002:a19:7b0e:: with SMTP id w14mr19583160lfc.8.1550656395265;
 Wed, 20 Feb 2019 01:53:15 -0800 (PST)
MIME-Version: 1.0
References: <1550217696-3006-1-git-send-email-wdjjwb@163.com>
In-Reply-To: <1550217696-3006-1-git-send-email-wdjjwb@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 10:53:03 +0100
Message-ID: <CACRpkdbt6VSrzLNWEGSY2OnR8=DovhTVpsuUPGC17YtmWmVnyQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: fix possible object reference leak
To:     WangBo <wdjjwb@163.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wang.bo116@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 9:01 AM WangBo <wdjjwb@163.com> wrote:

> The of_find_device_by_node takes a reference to the struct device
> when find the match device ,we should release it when fail.
>
> Signed-off-by: WangBo <wang.bo116@zte.com.cn>

Patch applied!

Yours,
Linus Walleij
