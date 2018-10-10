Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD81BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8C120858
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR2P/1CF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8C120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJJTpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:45:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38642 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:45:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so5506496wrt.5;
        Wed, 10 Oct 2018 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KUtgjgh84pBHEsdGFr+PrRX3I1tGdmZZalV4HF4dWQ0=;
        b=mR2P/1CFJK6pZ1ekvNp19LgZTowr1IdHnppGE97ifAVO9cWmxG0/Nv7aewS0spKxBb
         5WtJcSNF90Lw3QK/G+Q0sbranE/Ilf00MTktO9xmjyPirAEM9Gc9/OggltZ3tawkJsvK
         Jspt/SSfYp3jCtfAg/6Vea/+Qad+k6aZ0hBh4fZldWYDEriNqLiCPrm0s+GPAi1CU9L8
         AjAzEBCgwJaYtpvQ2Y9u037CM6uuNWlg4EvCy7IyyQqLdiZo1xonZwuHwzqdSWN7mqSE
         TOK2wFb2EuqTnZ2JMO0UNbPjqsTEC3zq+bny6fFU9KA80OOE1AofRZyyGXZ05MRoeSs0
         lQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KUtgjgh84pBHEsdGFr+PrRX3I1tGdmZZalV4HF4dWQ0=;
        b=IB0FSFaXNLYBbWmB3X+aSAaO3yBOgXLmxs794aFSmqArkRYzL4q5pfmueVN+giC1C/
         KcsgT/+FlOSDqiRZxQym60XyvWb44YZa/G0+f4B9JKjnwQYKindICMbr/MOEkdm4XNeV
         kqtyiFUi3nxCcebEB7Tp4S5NSOQUVFHpt9LLo8GGLqBU/NRX45g/EIU22AZr9lrbrYOS
         WmytSfZegZzv7It3qmqZ/Vd9EPuyDqb7TLE/KHF/ZehYgtM1tuqJ8K5vr/6N6WG24ETj
         vI81YpV8CIIPfm8yNLC1YaKxBupXdJu7DxIiNSi3rBSneOLjH7dAROYCmwrdSgbeGDNm
         jpTg==
X-Gm-Message-State: ABuFfogftynQ4a0LxkY1lUDcotsAEFk+E1h6ArSdtVY8QkEurQ+SK0M8
        3DRDQvN3CWeU0ULWCZ3PJIs=
X-Google-Smtp-Source: ACcGV61crBgj4KKL92VboXC8lskgX3cA4AyeCTYOHLV0FWHMCmVnPWdVFrwKdMxOz8y9omM0GTNsow==
X-Received: by 2002:adf:9e09:: with SMTP id u9-v6mr22913105wre.51.1539174232573;
        Wed, 10 Oct 2018 05:23:52 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id m12sm15391240wrx.75.2018.10.10.05.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 05:23:51 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:23:48 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181010122348.GL9130@localhost.localdomain>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 14:04, Vincent Guittot wrote:

[...]

> The problem was the same with RT, the cfs utilization was lower than
> reality because RT steals soem cycle to CFS
> So schedutil was selecting a lower frequency when cfs was running
> whereas the CPU was fully used.
> The same can happen with thermal:
> cap the max freq because of thermal
> the utilization with decrease.
> remove the cap
> the utilization is still low and you will select a low OPP because you
> don't take into account cycle stolen by thermal like with RT

What if we scale frequency component considering the capped temporary
max?
