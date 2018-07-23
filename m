Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249A2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE63820874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XsKyh+Hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE63820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbeGXAUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:20:00 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:44049 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbeGXAUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:20:00 -0400
Received: by mail-io0-f181.google.com with SMTP id q19-v6so1956483ioh.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvAMCvGBcwgXRL31YAhGvk4B+NBkJp8M7AtCPNQmyp8=;
        b=XsKyh+HbOQbRQVWPO8WjoLO8p5qC3yPvfI4pseXLRYy79y9SSNgdgUMgDvsjsGeWnf
         qPiEDZSC1M0Z6tJduzWvjPR/aO8AUoPDhDcqPx7FS7VZO1XYf6QThvds3nn3ImFYo3pw
         xA/jjmTVZBfWPAzRr/mM001CWkJ48/jT0lHGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvAMCvGBcwgXRL31YAhGvk4B+NBkJp8M7AtCPNQmyp8=;
        b=VdIrHXuq51aSKo+oVpPpZuFDf7Fdc2e//uxhm358MTfDOs8UzUFIq3wmRCRCEQvaKa
         mLi4AgDO2gVTwi57o2raHKKZJpdwLCEsBQc1irNkRaZ+c/ITy/qHIOfjPoc5mnruEABJ
         riBWZCghoW7tionrvMRmnTFkvs+GsYOm1SC5t9oPdtoHu28f3fhDdfFk1wT+hESpvSm0
         Mcf4pW54cAeHrsFcqz1xuFwjfjQQAVY9RePv+3CfJ8dVWMmuDfuGson+as31TRqvy2Dg
         M2VMvhwBx3hN+MEe2855wbKOrZ+gHD4QY2mgsQgXr+0tR7ei9wud+vbXS+yuApAj5ejt
         dAcA==
X-Gm-Message-State: AOUpUlGFupznDtQdlE63zTrpldKdCne6rsoUpdP+TIFtT8poBbTXUH1J
        stzcEssspDBAP3kWLZ1Z2fpBd/Uv3WWP1d5mUGI=
X-Google-Smtp-Source: AAOMgpex8RkOVbF99fXDogPDe+XWJfI/nFwSRRXSORrPSchxzC+U2gEYWH7lJcHGiDPU7t70nrb/ezF9VIirbJHrK/I=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr12137823iom.238.1532387789512;
 Mon, 23 Jul 2018 16:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
 <20180723204617.GA14487@roeck-us.net> <CA+55aFyuaEGGksOxv3aAp0THYkAapap-JY65A0A81S0qUE0S+g@mail.gmail.com>
 <20180723212330.GA7441@roeck-us.net>
In-Reply-To: <20180723212330.GA7441@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Jul 2018 16:16:18 -0700
Message-ID: <CA+55aFxhkUkqj81qysQF-KJOXvS5dvTAt18WWChfNpz3adJfjA@mail.gmail.com>
Subject: Re: Linux 4.18-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 2:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> My patch is also at
>
> https://patchwork.ozlabs.org/patch/937283/

Ah, ok, so that just adds the forward-declaration of 'struct page' in
the right global namespace.

Anyway, I'll just re-order the includes as I suggested, which I think
is the right fix and makes the forward-declaration unnecessary
(although not _wrong_)

                 Linus
