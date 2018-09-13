Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D96AC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20F20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qyomV8dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A20F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeIMJ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:28:47 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36987 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeIMJ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:28:47 -0400
Received: by mail-oi0-f67.google.com with SMTP id p84-v6so8103297oic.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbXXBZtus1WB5IMXP79PnyprVjPPB/aRzRwMwo7ziN4=;
        b=qyomV8dmDNwm1bQfMCwtLWEBAx1UOwmt+V9dJHuq5PqsKSEdR/Hs88GTGuqfDvGc3b
         nxgKBoB5iK1FiOnGYZnlYDNy6Lm5nGwbgRyumQ89+mD9o5cVVgfVzyiuszap3gc+abLR
         KBxAlQBxyouqD4bgJqEKExBamOf9W+5Yn/TIcm/XA7RLrPtVxlWRONQZD+Vc+KGFuExz
         +oxAZEN/4hu3CdMzb+TtCKnwrfCsiTfdkRb3y+ls3QRKyMANe2WjdQad+N/U1893B5cW
         7BO1oNf8ARonVXKP0ViirAzum++qonGfaffsJGUrxssW2LFgUzVKsD29b4aEKlEEstKF
         EYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbXXBZtus1WB5IMXP79PnyprVjPPB/aRzRwMwo7ziN4=;
        b=DNv4iLguJFofPlhdm/Tz08LkabfqhE3XQoOouLIUOQb3lt68NhpQmJzJCJGGfxYxdx
         u7z5XtByaCO2aaUn6U7AN+7PxZHavy2aNMy7zTSnm7IEdkCXW4uJwmzGoyAMObzR0q8N
         DiKLii9VkwHm7AD1Gkn/fF9MLGrMF0yNfe0O3J8haigZfp5FAeh0Pnr8WllQmZLqm+cD
         9zXA7rRYyHn/qGZS/dLelpbLKExsn6lYO26TnNt6/2IfzRZLUPPsi/Fw8oJ8XSFI2HZj
         g9IGj1myGNiM3kqTnO48B7oHgdCBOWGkchJESmJzVV0s/H6nnPojFfsx9DRQhdvD/ueb
         n/Yw==
X-Gm-Message-State: APzg51CxXcltHGVOKdNLjm6aVWVp3IP33609ItFR6sp8EfQ6ToRmu6ba
        QEShBk1mexw5rR71aLImB+rCiFSWA1hmONVYHw9JFA==
X-Google-Smtp-Source: ANB0VdbYqZRoxcnWWJHb2Iv/wL7zu94P7Y3ujUnpVgG3ImkRkBcssHWM/NxFC0YCTLa7/LwY65YL8O4QiVbASgwLo34=
X-Received: by 2002:aca:91a:: with SMTP id 26-v6mr4993945oij.33.1536812465175;
 Wed, 12 Sep 2018 21:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com> <7hh8iuxd1y.fsf@baylibre.com>
In-Reply-To: <7hh8iuxd1y.fsf@baylibre.com>
From:   Kevin Hilman <khilman@baylibre.com>
Date:   Wed, 12 Sep 2018 21:20:53 -0700
Message-ID: <CAOi56cVESykxXg4zcdLh89Rpyiyg587XCkvFG55FnMSro4vH2w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:59 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Neil Armstrong <narmstrong@baylibre.com> writes:
>
> > The order between "syscon" and "simple-mfd" is important because in these
> > particular cases, the node needs to be first a "simple-mfd" to expose
> > it's sub-nodes, and later on a "syscon" to permit other nodes to access
> > this register space through the "syscon" mechanism.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Applied to v4.20/dt64,
>

I spoke too soon, this doesn't apply cleanly on top of Jeromes
reorder/cleanup.  Please respin/resend.

Kevin
