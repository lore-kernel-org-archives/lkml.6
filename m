Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30276C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B3F21765
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B3F21765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeHMNro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:47:44 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:41547 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbeHMNro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:47:44 -0400
Received: by mail-ed1-f47.google.com with SMTP id s24-v6so8010479edr.8;
        Mon, 13 Aug 2018 04:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o0VuoszIGJmAOA3WXydk++9pXcZM5d/wP3VZ0bztxZ8=;
        b=jmj1O8fPjgSekZb1dCnAsSZxMLFLRRklLdCsgczkwSocbyZiXLHBNY59OvjIDCCDlg
         oFhsz3jE9iDsCDghQ/85XfX6RZhJzgIdDUwUReua+XZHP5hSXiC2wbeobqhdA2Yd8uEl
         HtJaPmBMw3uoBIdXNIN67z251vSx/vBvAaeegF0Bd0anUmo456xLtozMyuyFQbmaYYgb
         CPpttT35xCWWiMcZCscB/H2pVwvQtNMQEEMzwGi+60VlJaYpG5M664np1jLgOFJQpu+7
         l9/r+xUiFKMvxQXVwiIEc8BmC1/2S9kXbTqFpttkfbPMMjW6nqgjAmDZDJuU96hRkv56
         Vk8Q==
X-Gm-Message-State: AOUpUlGw6Fm7PLTK8OV5/AxGUnkWSNzn8uP2oU9MsU60DPoaSO5k87Ae
        7JxPYujUOyfIhViY4M1/n6BOOUep1Eo=
X-Google-Smtp-Source: AA+uWPxjNQwO4w/0gXuMAAMj29h5iHjl9snhlCWucLv7GSqMjSA2uDPGPlEhQ0x4VyX2YnM0emlNuA==
X-Received: by 2002:a50:c082:: with SMTP id k2-v6mr21354699edf.294.1534158356665;
        Mon, 13 Aug 2018 04:05:56 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id x13-v6sm25522083edx.17.2018.08.13.04.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:05:56 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id g6-v6so13912505wrp.0;
        Mon, 13 Aug 2018 04:05:56 -0700 (PDT)
X-Received: by 2002:adf:d207:: with SMTP id g7-v6mr10233372wri.91.1534158356191;
 Mon, 13 Aug 2018 04:05:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a101:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 04:05:35
 -0700 (PDT)
In-Reply-To: <CAMty3ZDG5sbM2w+Mymvm8JZ8vgmP-mvtXEzT4j8vqWsap+T4DA@mail.gmail.com>
References: <CAMty3ZDG5sbM2w+Mymvm8JZ8vgmP-mvtXEzT4j8vqWsap+T4DA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 13 Aug 2018 19:05:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Zh1JUk2Sg_CNTtyBFTszDoaCBeRvvbQGSkVW1ixNFDw@mail.gmail.com>
Message-ID: <CAGb2v65Zh1JUk2Sg_CNTtyBFTszDoaCBeRvvbQGSkVW1ixNFDw@mail.gmail.com>
Subject: Re: BPI-M2 Ultra boot hang, with linux-next
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        devicetree <devicetree@vger.kernel.org>,
        inux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 3:40 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> I'm observing boot hang 'Starting kernel..." with BPI-M2 Ultra,
> disabling de2 status on dts seems booting.
>
> Was it an existing issue or did I miss anything?

A few of the R40 DRM patches didn't make it in with the others. Right
now the DRM driver doesn't know how to parse the R40's complicated
display pipeline graph, and it crashes.

ChenYu
