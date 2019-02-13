Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD687C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1EC222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jcwHCmRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfBMJc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:32:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33541 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfBMJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:32:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so1416321wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=umkFh3sTag7wcOVtRbwb7GAQcTXPyffr2EM4OfV+U/Q=;
        b=jcwHCmROVMEEkmR8QkE/h55GGYneRqjiGp5ldd0OUlncaNDXqYLOSSMw2CRkvxDaC8
         8eF89m0174a3JU1Y+/qaWzfdPFq/n3t0k8W1DTrJLw747vIa32BkYaMs85BOdjm7VpLC
         zEpwvhVFhtEw8tcRibk4XfW5ev4Z7FEDgz+WA+pZoHxbVH0b4/4c+bVvP8rofEm6QRje
         FyowH+OqUTXup4wDUXjT+tezhCeJzkEYY1od8l6rZm8B6FmnzHiB9T9FQE7T+3JBV3kC
         Q3+Uc2SJfCNYIl5cHRg4Z5qfCvEEmFotSLrsOqML+p0eRL5HYOhKRlqJfKnrkfdVmQta
         n/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=umkFh3sTag7wcOVtRbwb7GAQcTXPyffr2EM4OfV+U/Q=;
        b=NXCiCB1GPeRbeiJoLDlDReywdGshxPyNTEOFSls28vU+ZXGjtMX20mt9L5yQGrSYwi
         g/+/v4AgF5dd//yvEOHY76AbJZqOYw2ZWI8qiQrzgmV6m0MFo2zEL6BrG3epBjQOpKfU
         UFSQK324SgTsMiDcB7eriJ8iG6Rv4h1bAi2lDcjOrptbVDsr4iBzHb/J6lHxggzEeVpN
         LNhBHcF/E+bBJ4R5cn8FZLCvzI3Goez9NngwpiCzQku44sD+ECHkng8HqvtpqqomhqGo
         pPh2iqSme4zIEGMlah/S4zyEAiJQal1vleeXC/tMk0tk7oJETfKXmnxIYtfSktB5np5t
         QL5w==
X-Gm-Message-State: AHQUAuaxfLOdUSQXNKouio3s8xgfZ0H2o1i/gmaS5ir9Mr+/gP7bD5DR
        YkuOJ/G2f6TGa9tgJ87+gSZ+DQ==
X-Google-Smtp-Source: AHgI3IY0Tme/033Av9FLl5/k2u50Y94eEnG2p30A1X1++j0jq//zsx0AuXlEoj1vb8dcpaYZTellbQ==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr2464252wmh.46.1550050345629;
        Wed, 13 Feb 2019 01:32:25 -0800 (PST)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y20sm32630100wra.51.2019.02.13.01.32.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Feb 2019 01:32:24 -0800 (PST)
Message-ID: <121ae6212cd555bc784af675d63f6b190c0bee10.camel@baylibre.com>
Subject: Re: [PATCH 7/9] clk: Allow parents to be specified without string
 names
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Date:   Wed, 13 Feb 2019 10:32:23 +0100
In-Reply-To: <154878820913.136743.9860407353339842831@swboyd.mtv.corp.google.com>
References: <20190129061021.94775-1-sboyd@kernel.org>
         <20190129061021.94775-8-sboyd@kernel.org>
         <2f88e7fb1788f68f7b97d9806d56f9271663bdfc.camel@baylibre.com>
         <154878820913.136743.9860407353339842831@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 10:56 -0800, Stephen Boyd wrote:
> > > +/**
> > > + * struct clk_parent_data - clk parent information
> > > + * @hw: parent clk_hw pointer (used for clk providers with internal
> > > clks)
> > > + * @name: parent name local to provider registering clk
> > > + * @fallback: globally unique parent name (used as a fallback)
> > > + */
> > > +struct clk_parent_data {
> > > +     struct clk_hw   *hw;
> > > +     const char      *name;
> > > +     const char      *fallback;

One last nitpick about this structure, because I did not figure it out at
first.

'fallback' is what we known as 'name' in CCF so far.

What do you think about renaming 'fallback' to 'name' and 'name' to something
more obvious, like 'of_name' or 'fw_name' or something else ?

> > 
> > If I understand correctly, .name and .fallback will be ignored if hw is
> > provided ? Maybe this should be documented somehow ?
> 
> Sure. I'll add some documentation to the long portion of the kernel-doc
> here describing priority order.

Anyway, with this patch, I should be able to remove a lot of (ugly) code I
have been writting lately. I'll be happy to test it when you have a v2 ready.

