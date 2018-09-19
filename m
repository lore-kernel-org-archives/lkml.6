Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB65C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A4920880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4Fnxznv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A4920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbeITB2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:28:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45549 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732677AbeITB2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:28:15 -0400
Received: by mail-io1-f66.google.com with SMTP id e12-v6so5469378iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAO+KNdZNchbsqVqsAf/MjcippF+dq1WjAJw2DPmaZY=;
        b=a4Fnxznv6MneMJaUR/YX5LdlBjfOGb0CzB6EsC0Tl4QUuTxwHAjzCIp9F5SWeBMjXe
         gUmO8iPOmHIlVvnMzKyKx0vKkmHlqaygPPjN7KGNZVtV3HAlpVgXoIrcAtQN1KwgKZz7
         yamEXnbJsBeO7/Bihp8Em99SNMwgPYFs/jPuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAO+KNdZNchbsqVqsAf/MjcippF+dq1WjAJw2DPmaZY=;
        b=MwMuKj0XxXCDOlQ35JmDaXLdB0k31WjvigJ2qLabNOv6fqBK3z7tMaA/Sd5madmYyE
         ziTyLSApkqy5LxP4XR2HOdGsMUxqyfU2hE7b26RJmjb75kvq/K5BhaK9ur915gdvetgx
         AueeWkC7FUjvwjFCBzq+XBfkf2d1JyrBJssFKinIh2haD0dfZkmzvAv9Q06SiqXXfDCK
         rLY4QpRCxQKoKNCF41+xIy1uNUDie/Mu9TumnmBl8ruwqigBG51M2fDbhNg8umKT+qmC
         Qs4jEZ7pYWGSsQ5071MiuRv60hor5iI7Scp6uUtWgkiRzJBDIYzFx+mvzp5+q3yfl7iH
         KUGw==
X-Gm-Message-State: APzg51CEIMLTYl6GesI6H6QfCQgijA54pdu+wIZ3sSUf4OdQ9F8gMkxJ
        NqeKNSl7SLWXTeJQ3bW53lx6WRvC6DdGqdF9ivyN4A==
X-Google-Smtp-Source: ANB0VdYNUu5xcK40fbAYZuv1W8q3QEUFDXqsfqgySqrdz45atJxEPmK/VQ/q4ifjiLsaEXlabLNGfL34A1b0dl+EFSA=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr30266805iog.175.1537386529123;
 Wed, 19 Sep 2018 12:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com> <1537363669-25991-8-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1537363669-25991-8-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Sep 2018 12:48:36 -0700
Message-ID: <CACRpkdZupLGLGvum61GZ-Q_Q1+pDhfgPUgFfxhrqPouE6w+nig@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] ARM: dts: stm32: add orange and blue leds on stm32746g-eval
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> Orange (LD2) and blue (LD4) leds on stm32746g-eval are connected on
> STMFX gpio expander, offset 17 and 19.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
