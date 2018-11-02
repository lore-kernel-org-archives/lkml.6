Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC252C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558872082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+UKKFso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558872082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeKBQBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:01:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36088 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeKBQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:01:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id s15-v6so827009lji.3;
        Thu, 01 Nov 2018 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFD5aM2ikf/JqmpGlQ0Z8eh3qdhiC1JiaXgFQT9lgis=;
        b=h+UKKFsoQO2pOVp4U7PZc+hG90qGhTiHYraoEZznLFMTx5CIL2AMxWPuFADzBhgBB1
         FozIC4sosSw7Xyxa3tBvF9ki+w1U5WUF307TRVsuOc259qgD+3f0BL+csBEySvnqBKz6
         8Gwpww1rN+YBKPtunyKZoGQp5jP/EyDJNKjcTEF6Llq/DHQNucw4OX7a4ZNo3jKmPs1G
         CXqdQ+zMEK8sLxLgK6Yo8vxh4OZGOZM/3efiAAYw2B/eqk10zc/qu7eiE8Xu8t4R16k1
         RgnSYADU5dJc5u8j3bEowQGLeskmTXwhfjdO1IefEqOCmr7Xs6zLTgfjZSy/f65TP6+V
         1Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFD5aM2ikf/JqmpGlQ0Z8eh3qdhiC1JiaXgFQT9lgis=;
        b=nzGRUoO2u486jJP0ORUQ3qPnyU/OqkUP0BAvYoz1h4PQI8d3+hUWzCt5j73RWX1cXE
         IKb56fXV+kndXIthqdIri/iJfLa70H1yjvMP46tSLcBfqYJ0otNPXRtb3rErFhRpKtj+
         23uSaHjo4IBLuHWTLQwQc1doeFY8tvBeyO7Z0hLGZ8Y9E1wHjNEMaVIENPxE2ZNmJG61
         Ts/MVnvuFphgk7vgvzThzK2+e+srmzr4ThNvVyeSm+pUsKnTmCjknGB55Reee+VMq+kY
         SxvVDbc1xVPLmfGi1hpkUWCUguVEjBpGk/4ts7v/jOcv5g0NwCxFOnvSDOCj4NE1uJvi
         8wAQ==
X-Gm-Message-State: AGRZ1gIe+cEglT2fbIrJp41RTn2k0g3LyFaa5ChZHEutrLtO67Dn/nGJ
        0A2/k8xYZY8kROhMD2w5iRoCOIB99IMZz9mI6hfEqxxR
X-Google-Smtp-Source: AJdET5f7QEuR8tE/P+GHYih8MbtfeVhdOM1ixPPrbhqr80A41dTEuwtdttacZWJczLoV8ZQ/3YLNHSmzLYjptSqrUk8=
X-Received: by 2002:a2e:5555:: with SMTP id j82-v6mr7554664ljb.69.1541141707293;
 Thu, 01 Nov 2018 23:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181101144044.11495-1-ricardo.ribalda@gmail.com> <154111534593.88331.1129843003477644482@swboyd.mtv.corp.google.com>
In-Reply-To: <154111534593.88331.1129843003477644482@swboyd.mtv.corp.google.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 2 Nov 2018 07:54:50 +0100
Message-ID: <CAPybu_3AGAYx2YKSuRvaNVBFSVkRVoOEa7oPaOAwuTDWK6drjQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Implement devm_of_clk_add_provider
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Alan Tull <atull@kernel.org>, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen
On Fri, Nov 2, 2018 at 12:35 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Ricardo Ribalda Delgado (2018-11-01 07:40:39)
> > All Tull reported that there might be a great ammount of drivers with
> > imbalance on clk_add_provider. This is an issue for Device tree overlays
> > (and also a bug) https://lkml.org/lkml/2018/10/18/1103
> >
> > This patchset implement a devm_ function of of_clk_add_provider, and
> > fixes 3 drivers.
> >
> > Drivers like clk-gpio will be easily fixed with coccinelle if this set
> > is accepted. (I volunteer, I want to learn how to use it, just seen the
> > great presentations from Julia).
>
> We already have devm_of_clk_add_hw_provider(), so any instances of
> of_clk_add_provider() should be replaced with that, instead of
> propagating the usage of of_clk_add_provider() any further. I'll gladly
> apply patches to convert drivers from struct clk based APIs to struct
> clk_hw based APIs so that we can clearly split clk providers from clk
> consumers. So if you're interested in working on some coccinelle script
> for that it would be great!
>

Will look into that.
Can you take a look to 1/5 of this patchset? I believe that it is
valid even if we do not take 2-5.

Cheers

-- 
Ricardo Ribalda
