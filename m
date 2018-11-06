Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1B8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C765820827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xnEPe17p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C765820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbeKGElt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:41:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34859 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387928AbeKGElt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:41:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15-v6so5527818wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 11:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pcUwBxDc1aUnql2XUzrbkeZwpflQ0RmvIs/O/e0efkU=;
        b=xnEPe17pHXdMfvDfYmcknFCLkMnh0R4kCPnRnybsTuLwHBS9m96P/04gzYZ9MqVOKF
         m8raApQFp2vftgAiYpCbfZ8yVqrI9oIci2vNfQCvPXjpdg5OpnKvCK+jaIwyZxF48LVV
         OR2Gjlz6heIZONWYXvBmTT8iU1d8IIM7/LIamyaTuB7VxFDx+mDyolfOBexXXv6NyqzA
         Na/+fNI+4vNuTuM8JwG0Oi4kHejaeOmrlTV3ZCp4Nr1V4ubCk/zJ8mzvEEwFvn1ygf7c
         4pWiD2TuU2yMMifcJ1JZ9qOglVR2JinaeAHIlCllBDxIWKFnBoAhRw16ZnIoomSDHN0j
         5eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pcUwBxDc1aUnql2XUzrbkeZwpflQ0RmvIs/O/e0efkU=;
        b=XcRjDUBd+uvXf6Qz1K54dbgBbCMJ6kZefTcoBcEMS+PRIcwkQVfzXYQlgzP/C1twZV
         AETeLlvoEuVc8Q34rR6d6MZeS/cgy5OqgUJ3ymQmTnnK3u4CYyaR6PBfxlrk8hjvh78C
         sCa8oQ34DAOWcYD/2punSLxObXkzODvqgA/2oPjjzjKPB/3DKQOrX2/xXqGYfhztMy+5
         slzfimEVUzgJePy/Dru35d/WYENc/RuKWf53yA+o8uMRtyotKE/JzrLjctWhxc85MvIA
         4CdE/dnta72Q6d39aWOYIrOBgfH5s3Sq/Ah8IvQsm+gOkibu+8Filu8qn3cYnPNejBwm
         Tr8w==
X-Gm-Message-State: AGRZ1gLcTXci+YHzS36ZBNtk22mKuWiQxGQx7BMsLXRxPfYY8MIROOAY
        9g75tfiS/WPBZPTaLTz6cTrKsQ==
X-Google-Smtp-Source: AJdET5f12r4PEchKVY6ncW232QFAJmiInKP38caB0Rig64Vet0VEFMedV33BoQB071v3aBIy2nOtxw==
X-Received: by 2002:a1c:95:: with SMTP id 143-v6mr3246281wma.4.1541530165389;
        Tue, 06 Nov 2018 10:49:25 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id m13-v6sm9473039wrw.14.2018.11.06.10.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 10:49:24 -0800 (PST)
Message-ID: <72269086b0ce0be5517c7ffb2bc979c4d17d5cc3.camel@baylibre.com>
Subject: Re: [PATCH v2] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
From:   jbrunet@baylibre.com
To:     Stephen Boyd <sboyd@kernel.org>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 19:49:21 +0100
In-Reply-To: <154152980131.88331.14307558394241579493@swboyd.mtv.corp.google.com>
References: <20181105230820.3562-1-jbrunet@baylibre.com>
         <154152980131.88331.14307558394241579493@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 10:43 -0800, Stephen Boyd wrote:
> Quoting Jerome Brunet (2018-11-05 15:08:20)
> > From: Christian Hewitt <christianshewitt@gmail.com>
> > 
> > On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
> > with reboot; e.g. a ~60 second delay between issuing reboot and the
> > board power cycling (and in some OS configurations reboot will fail
> > and require manual power cycling).
> > 
> > Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
> > meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
> > Co-Processor seems to depend on FCLK_DIV3 being operational.
> > 
> > Until commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
> > meson: add fdiv clock gates"), this clock was modeled and left on by
> > the bootloader.
> > 
> > We don't have precise documentation about the SCPI Co-Processor and
> > its clock requirement so we are learning things the hard way.
> > 
> > Marking this clock as critical solves the problem but it should not
> > be viewed as final solution. Ideally, the SCPI driver should claim
> > these clocks. We also depends on some clock hand-off mechanism
> > making its way to CCF, to make sure the clock stays on between its
> > registration and the SCPI driver probe.
> > 
> > Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> 
> I can toss this into clk-fixes?
> 

Sure, it would be great. Thx Stephen.


