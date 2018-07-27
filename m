Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE7BC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588C520671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNq5ka2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588C520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbeG1ANf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:13:35 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:37553 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbeG1ANf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:13:35 -0400
Received: by mail-oi0-f44.google.com with SMTP id k81-v6so11776329oib.4;
        Fri, 27 Jul 2018 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OzwtOWeZ9fmVshGPhll6qH9rCqIr3ZY8ENCUjKnLPts=;
        b=DNq5ka2c6gm050hmAhr5NZPe7q8bWWsCC3FrZRZk5mZxT5d6fp5lBbnWxMTzUW73ki
         ZJDKDjWBhFsa/kLOWm9SVjqw8hHIns083nu6nRkO0u9pAqi6e3577CL5oXSViwROnmTK
         hWKLho9S7rr7BJ3Xb9vY4lusGvbxTCTcQryJ8Vjf83GJPo9WOsVjEnB0f14TfH5I4LaZ
         SadBmqY0jnm/YmxFIjbS+e3FZpRLkxHZdogF6RD1mQXYqjFpZDtTEtTuPagXrWT8eZsD
         NieSdFqd8cMe5JUACkAbMD9GW9SVBptEumSFYAZIvu/UTb5k6No9wzZw485En9FnJqEi
         2yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OzwtOWeZ9fmVshGPhll6qH9rCqIr3ZY8ENCUjKnLPts=;
        b=B2WBY049budnyDVOXI1k5OiSnSMSDLlpWjne2GLsOKgNP8vHGpNaaQGmQHQsOpbaZu
         4cubFljkySjZ4XQjsAR1cOth0tC0BwkNqPtLzLp02/ubxCcmTl9DDyFKanUOCJYEqZ5C
         wpbahV8/ty6L943HMCJVsWliIDmfIOWmzIGIg+/bcdzji6xszebrdb1mrQP6oKKYwMH2
         B9cqqeMWFz8YM8wuuSSx2jF8KM1flB2lpIGD0io0845wK6KtsN4G1tux6vGGxGtHRt22
         qlNA/UHfuBqhdfUk7GS9qjTBZCTupduhFDm7+KqT0t8gs2RDiLRKwiYWvxIgTsOzHyA8
         bOUg==
X-Gm-Message-State: AOUpUlGXsIPD5uGlOhq+2OKfsM/s6qvOEYVp2Y5kaSixeF+CTD2Xtke5
        kmBd5lwSFpx7FWzU4DIjGvc=
X-Google-Smtp-Source: AAOMgpfyH4BnOGzr3gHDRVV0XPtuc0ZhlOeCpORuEd3wWb1zECZ7Tlnbfzunqs6VEAiVuJ/9Dg2zrQ==
X-Received: by 2002:aca:665b:: with SMTP id a88-v6mr8881050oic.101.1532731773800;
        Fri, 27 Jul 2018 15:49:33 -0700 (PDT)
Received: from localhost.localdomain ([12.251.228.178])
        by smtp.gmail.com with ESMTPSA id x23-v6sm2894262oie.0.2018.07.27.15.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 15:49:33 -0700 (PDT)
Date:   Fri, 27 Jul 2018 15:49:26 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos
 platform
Message-ID: <20180727224923.GE4450@localhost.localdomain>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
 <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
 <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
 <CANAwSgRFehdmYZvPL3yD1=Ng_w1Yhtij=nvZEOqkof7zj8fcwA@mail.gmail.com>
 <CAJKOXPfRBPgmGc17XEzW5+MK80JcudCbhBfLeMFTQYjWLJ3JeA@mail.gmail.com>
 <CANAwSgSmUFYjE1VyqFM87M-6JZH140P9VpnXP2sG6Mw=_1J3Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgSmUFYjE1VyqFM87M-6JZH140P9VpnXP2sG6Mw=_1J3Tg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:22:21PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 


Please send a new version of the series with applied fixes
and also get reviews from the samsung devs. Thanks.

> 
> Best Regards
> -Anand
