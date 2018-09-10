Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6EFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F7E20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OE4WfZ6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F7E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeIJXkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:40:08 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34503 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJXkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:40:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so42292990ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Qvwr3QOaRV/iVskEPg2kkyfws95ww1noIv4G/PK07w=;
        b=OE4WfZ6Wp5HBID5wabhokcvhaatPloTyz35OwuuBqYp8JW8gil9+mnsupCgshZ9IRh
         eaxV4eAFe69gxaHaOxD9F9Vvnr+1sCIs208v4hVuxi2OL0mlKYYWf5NdixF052s9tOkN
         vSAD20UOvaRe4wtLExtEveB/4iXSjbaJ/7NBYHlZNcxNbArhpa2+q4PFRb6JHUux464p
         pKpM9sz4o8bYi05yYYnvebl3LHWdFZMAgl25gYl/rg3wRkEI8GJqhRBCQLRjYyoodKnP
         TFrXusPvq2OXBd73OuyIlh0JtFpk5CJ70eKpWGYzfGGmFGIy+lHLFUWJ8MenERg45hN+
         vhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Qvwr3QOaRV/iVskEPg2kkyfws95ww1noIv4G/PK07w=;
        b=RPDbPd710/418gU/6nM+bQlc6FrpdUwooinFOaAQ22aRGwZW7Ifajn0isJI4k1Pigd
         ZARjdQ7pzXsTw3HBzKmhudSrYeX6lKspWx4W+mqbkxxW0mGR8S1Nwa33tdLuKAWaCkYK
         9ftEdCSKPpFDspxyQujhfZVC7sE07HVnMCuRra4DMHBsBk3Wmsys+OHKZBhVAyS/KW1s
         jF+uLOxLCh+AcpkOmVMUEtMivm/lYcVUxpYqOOkufFnp6/5Ykf4bIlllnf61zQ8+PhLf
         25ob7H3oYJ35xI9yp77zT7eV+NsaTfUFwgCxjK82A1M5hBoqbLHPJYln5WSIVxtpVxuN
         6wTg==
X-Gm-Message-State: APzg51BWWmT6Wg2OYGbQZ2ksPxgmFCYFkTRh4R5avR5FVBPjs4yH12UG
        myCey49X+yyZ/xXDjtfsvHRiAFZ4JOXVt7Kru9A=
X-Google-Smtp-Source: ANB0VdbqyfmP2cqJoJYtCxqGqDQYx6O3EGIF2Og8LJ81/GxlL1FTcC9UW8lT84lFaW/lI0oRWQIF23svvtcb2WIdrMk=
X-Received: by 2002:aca:36d7:: with SMTP id d206-v6mr21226630oia.63.1536605081594;
 Mon, 10 Sep 2018 11:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <1536604750-32621-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1536604750-32621-1-git-send-email-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 10 Sep 2018 20:44:30 +0200
Message-ID: <CAFBinCB2GAR7OKbiPM5DaiG-gdBvcOq7qo=97qK-Hi1LGnKQ8Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-axg: use the proper compatible for ethmac
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 8:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Use the correct compatible for the AXG ethernet mac node.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I wonder if you should add a "Fixes" tag. apart from that:

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
