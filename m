Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE8BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351B5206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgF2Jn5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbeLQQm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:42:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35606 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeLQQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:42:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so13289981wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 08:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KNJiciN4Z5HdYmPVHnsvuK/wmO67+z/RGnkWjVK6wa0=;
        b=bgF2Jn5JVjdLeyomVyQS5SzHzSkStrfolSOHunxhMg6j4/yLX2F5KnJMa04RYmqdo0
         KkgoBohCprxUMCNiR6ouP6jESXq6t+G4Mu2dpGZFsk9ZiPPp4kkUagfE3ol/oYSHF/Eg
         P4LqTvIPqGEx38q/vs3kJV1LwlyO9EjzzJ11E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KNJiciN4Z5HdYmPVHnsvuK/wmO67+z/RGnkWjVK6wa0=;
        b=d6mlo/KhDD77zQ+Xl9OjnSmfru3R3E9UyvuwXCxXmx+ZSC5rbBQ7r2jZ6L6opkjruT
         DEZx6rAopIOeq0nP5l7/Z+GyGsQKojsPtXMuJ2/ixmTBS9jg+ERPlM0a8500gwFGFT5g
         8HytJvzzPOrhTT9limdK45pQzuCsprXbvjqc1dE9ptYcFgvwUf7/0AqynkOM7Wng27Gk
         wM4eT7DE+imXtq4O16E1nnf3UriOvjvO/MKNVZzK1Hec+6NeUt13+3L6rL8m3y7iTw6U
         xunDMx0kHo7dkv5eNrkh9xcR/yvwMWShiGrD+y0wcLIRPQN1xwGV/cfer6NGwYEVemKd
         npKw==
X-Gm-Message-State: AA+aEWajex/oh6/YOnqdjAieImayJydELRVnDYzrmKfUzBA6u0ZVrdQR
        WA2Sx0NI3IIwUIhKAFzAnNBC1/QEI/FmuA==
X-Google-Smtp-Source: AFSGD/XM29Vhj8To1W7os27+oFNjScIgH+yxwKtph7ldTvp41kg/iufl5FPDkXG03A2DBEEwtvuDbA==
X-Received: by 2002:a1c:c583:: with SMTP id v125mr136864wmf.132.1545064976156;
        Mon, 17 Dec 2018 08:42:56 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g188sm11796134wmf.32.2018.12.17.08.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 08:42:55 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:42:53 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: linux-next: Add secondary kgdb tree
Message-ID: <20181217164253.5ficzs4zr4dxbemu@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

Is there any change you could add my kgdb tree to the roster for
linux-next :

https://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git kgdb/for-next

I'm currently collecting kgdb patches for v4.21 together and at the
moment it looks like the PR for kgdb will come from my tree this dev
cycle.

This will leave you with two kgdb trees in this list which I assume
isn't great for you (although Jason's tree isn't really changing much
at the moment so I guess merging it is a nop). Anyhow I've made a diary
note to follow this up in two kernel cycles time and decide which one
we want to keep on the roster. Is that OK for you?


Daniel.
