Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64694C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A2E2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VYJXLZ4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A2E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJYW2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:28:24 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:39069 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJYW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:28:24 -0400
Received: by mail-lj1-f173.google.com with SMTP id p1-v6so8309263ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pF6Ntyek8lzhI14RsHZQtcUKXPUe3XVye+Z+HZsCvU0=;
        b=VYJXLZ4fNBBbs0hP5YoWWqI7Z5nJSveS2c1i8xY6/FuT494OAmyNGOig2YQW0m4VVX
         SBDn1JoWNmqrtVE7zt9ufP/S8BdntMeEluxMN43QG4WY/M7dDsbZXxT7a0raZEGJ492/
         G7CizwGBieTnGOFNuhP0pm+dCKRFIYswZzi4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pF6Ntyek8lzhI14RsHZQtcUKXPUe3XVye+Z+HZsCvU0=;
        b=JgjveIVSiPKEycJVto9ce4933MqW9z8V+Z8cefpmVCZQ0zhMZmGXKYOwT/L5y5jbpA
         SpjWDP3QvUNLtagSm4adHmEYx3Vy90g2ejQram9wIVfbd0JS01AbUGZxvuPZPGkJzTqb
         PsWtIYkYn4Ap+muCyjhOAFOAkKvvQktGkKHoinho1IVk9Zttw03UUS5K1dLnpoBUBQva
         HoHZtQ0p/24DZ+8NmRsYKoghrb8jEnL59mVd5CeAlw5cqZ0j80OdUmBLDsv7PWiB5CEI
         Su/3yoV4KRvbMgEvrvB/fE3PVNlftehthErFMd1K9ivjly2vK8R8+WP1I++lhhOcRInJ
         KMUg==
X-Gm-Message-State: AGRZ1gIDWDIP++zsMhFpERCbm3tnJrItYHSm3m0MaxEASB6/Ajum8N4W
        ym4esQAV9iOBAHfg0ja4pqcDpdWMZUmB3scz
X-Google-Smtp-Source: AJdET5cIVZCmaV+qxGVP/vzu5KVUBJgCc1mqvTIhbsjLd1Q+783Lv4z2GlvylopJM/4wfYeVw4k9hg==
X-Received: by 2002:a2e:8989:: with SMTP id c9-v6mr1408876lji.124.1540475729919;
        Thu, 25 Oct 2018 06:55:29 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p1-v6sm1132403ljc.85.2018.10.25.06.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:55:28 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c16so6855651lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:55:28 -0700 (PDT)
X-Received: by 2002:a19:111b:: with SMTP id g27mr1293580lfi.135.1540475728189;
 Thu, 25 Oct 2018 06:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 06:55:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTnb=o9JomnD68ob-6wNKHbBsYKKD1XmNwDBW0NjvkPA@mail.gmail.com>
Message-ID: <CAHk-=wiTnb=o9JomnD68ob-6wNKHbBsYKKD1XmNwDBW0NjvkPA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.20
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lorenzo.pieralisi@arm.com, Greg KH <gregkh@linuxfoundation.org>,
        bvanassche@acm.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:39 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> PCI changes:

Pulled,

                        Linus
