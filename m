Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB31ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CE4204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0HkZJ6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CE4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbeGXToE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:44:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51308 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXToE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:44:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so2908736wma.1;
        Tue, 24 Jul 2018 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=upenDyBNdq+oBF8mNoVp5lY50pNMgP0QyFah3H7X5CI=;
        b=S0HkZJ6Sz7EgWZkalnEPpB0/MIOdX/qsRkELsjEvqDmWGMRs2IkNQbfp/SrILU50Al
         Wr6fkLK+8zaSnKI95QgsMn52xgv++EvY0oDn3lTQO8wji8jKvwqfNwi0zr8BQpGjTWMF
         JZ5gE27lO96c5zHAQbmzmcw0Dw8q57zsH2fjS1zvNRbXtJiK3C4abyOZ37UiKGneRI73
         eIytU+QK79oarU+jp64YZ5CJUBhJy4dmrU44AfqSr9m3SDFiGWNxirhURFFfms4ztIp6
         fMNy/9nPzW5k5YpZ/OJb7C/Tml8LeU1R7EezrQiPI6yTrkiXgRbOrYk8iDHTvXHDdaBR
         JMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upenDyBNdq+oBF8mNoVp5lY50pNMgP0QyFah3H7X5CI=;
        b=HRwtXkyU4SbC1HgyqukZN8Vc2i1KkWLzNeTQbXXQmKv9xfiE1nBgwYMdm2DBND70gz
         OJLTGdix+JW7jGv8SU4fLh2ImqoOMcP4HnqjOPkgV9Yf4foabxP/aUb0mjugbmIkwCzZ
         axp1ke3HYwHBlnW4gTprEnpkTnHDfdVMXFCaUWIK8Zm5smCIrNFcFznLdJiRmv2fG4dD
         B/IUwuKP8UImGO2nj9L/7DRYtLtgTeXN0DiOn631J7I5zQLHPFyxD/trcfue0/gcXdmw
         mScQeK7XwDNVQs5nFgaVoy7guxkohwoYcWxYlRNHyv8H7mETX92tFesAtSKFEVN7ZugJ
         GrTQ==
X-Gm-Message-State: AOUpUlF3Z3QSrb6b91QfaIOaAbncQmdQhB2PbPdDl58c2s97WrGquYWQ
        M7nYy66I7pErt6EtjiCOxN8=
X-Google-Smtp-Source: AAOMgpf/YTm9f3u+Np+udFpcXwhzRtN4gMSJitJMbzFeE8/XPtOhL8rPw7P/PULA/zsyaqKxj+ApfA==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr2669023wme.20.1532457376585;
        Tue, 24 Jul 2018 11:36:16 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5B2E2884.dip0.t-ipconnect.de. [91.46.40.132])
        by smtp.gmail.com with ESMTPSA id s16-v6sm11191877wrq.20.2018.07.24.11.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 11:36:15 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
        id 5F4F95D55F6; Tue, 24 Jul 2018 20:36:15 +0200 (CEST)
Date:   Tue, 24 Jul 2018 20:36:15 +0200
From:   Simon Baatz <gmbnomis@gmail.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to
 rebase on M2 Ultra
Message-ID: <20180724183613.GA10380@gandalf>
References: <20180724163655.61365-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724163655.61365-1-icenowy@aosc.io>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
> Banana Pi designs the BPi M2 Berry board to be software compatible with
> BPi M2 Ultra, so it's based on M2 Ultra with some function cuts,
> including:
> 
> - 2048MiB DRAM -> 1024MiB (this should be proceed by the bootloader);
> - dropped a LED;
> - dropped eMMC;
> - dropped USB2 and connect USB1 to a 4-port HUB.
> 
> Thus we can make the M2 Berry device tree based on the M2 Ultra, rather
> than write one from scratch.

Good idea!  I know that Ultra came first and then the cut-down Berry. 
But from a device tree point of view, wouldn't it make more sense to
take M2 Berry as the base and just add the hardware for M2 Ultra?
