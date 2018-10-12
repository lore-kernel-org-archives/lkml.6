Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169E5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD1C206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHMGLZg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD1C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJLNeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:34:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40691 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeJLNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:34:11 -0400
Received: by mail-io1-f66.google.com with SMTP id w16-v6so8423463iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FQSCKuIkAaAiYuE6GiVmfbP6AtGw3cssKcsN9qB8Qk=;
        b=cHMGLZg2CJbHkP3UAjzfRu2ZT4KGXWUp1r4Wif05y1ZPapPKZqvIA3AZaTC1mN6TPC
         0MAu4PRrUc8OvVYJsjFrMOpwtEuSrl6w30Uvx6GabqL3sF3PZ6TnAtV4DDwdes28q+Vl
         ypvJ1p4xp7cQRWwWSfaxsWFoN02c1VD4g83UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FQSCKuIkAaAiYuE6GiVmfbP6AtGw3cssKcsN9qB8Qk=;
        b=ibEmlQGdqvh2mOAWn6RL/DPOGrzvepeeBvymFyV0jJBes/O5k+Lt7DNuBRvfaPHz+k
         yOazrrP1qcF7wiGOSipQRIpw08p0e6eihMVDpLrNBEv2ZcuP/CypRZF9WCcAadjfgZ28
         xPv1t+jaQHoWGmxwKNTyjWpj3XOAgFxN8gbZpZI/X7msnMO1g4nLJSSiOmioepQm+gm9
         nB0tknDwS3ZP1oouMeDIAP69VRfnG5+zWVN8mwvGk3Dw5M0+mZ4WH1DqGD1eXPjBiCmF
         1IEETq2ZZqULgwV5EFG1UcWPa0BminjzRy1LGm2BKGMnc4PpeB1ezpvbs4Og5yPKoaIn
         jxDQ==
X-Gm-Message-State: ABuFfogGMdEeYtfNN+vLLt871hj0sSNtX7wb53crK7T0GG6YrC+b8YSA
        OK/Agv6JPzmoLN9GRXZwunrUprmUWVZw+3PKbkEDDw==
X-Google-Smtp-Source: ACcGV60fl/83PhNMUbhLPOF6Xc+oGl/0+S81iWKTCmSZiAH+8UPu8qkFSjfiekxwxzWjAePopzCYMJ9b9hwDYKPhrNw=
X-Received: by 2002:a6b:6302:: with SMTP id p2-v6mr3042350iog.175.1539324201274;
 Thu, 11 Oct 2018 23:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
 <20181005065300.22882-3-ricardo.ribalda@gmail.com> <9746eba6-63f5-feaf-e63f-7e0ea7638942@ti.com>
 <CAPybu_1PuRqOx-Fsmba4XCcRsJA0A9tdob1R=8N72-699cxomw@mail.gmail.com> <8d180cc7-d7cb-66eb-001d-f2a5c371d179@ti.com>
In-Reply-To: <8d180cc7-d7cb-66eb-001d-f2a5c371d179@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Oct 2018 08:03:09 +0200
Message-ID: <CACRpkdYkhm16i7BiUsr0iemS7EvZZoy3ZvfLL6FJtCxBvNrqjw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] gpiolib: Show correct direction from the beginning
To:     Vignesh R <vigneshr@ti.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        timur@kernel.org, Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jhugo@codeaurora.org, Linux-OMAP <linux-omap@vger.kernel.org>,
        ext Tony Lindgren <tony@atomide.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 7:59 AM Vignesh R <vigneshr@ti.com> wrote:
> On Thursday 11 October 2018 07:12 PM, Ricardo Ribalda Delgado wrote:
> > Hi Vignesh
> >
> > Ups, it does not look too good :S . Can you check if this change fixes it:
> >
>
> Below diff works for me. I no longer see crash and gpio-hog seems to be
> working. Thanks!

Ricardo can you send a patch with a Fixes: tag and Vignesh's
Tested-by/Reported-by?

Yours,
Linus Walleij
