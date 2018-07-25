Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D7220852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="eA/rlzu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D7220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbeGYPps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:45:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36165 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbeGYPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:45:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so6290084wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JsJmED17IbgmfarUCsIfFn4wJeMQKWuSjpicioM7C2c=;
        b=eA/rlzu0ZLJnArFNvZD+SHvUXWa2HZGs3w07BiKLicDwlhWQcETPerBVGleSTt3prc
         Ck3gB0AeB1krXhhAr62OOvjtmuJzv7TQel42B6b38uVEcaw7l8jxvjc5CSGy58nTAeGt
         DRFWhCR9MhAmRlLXCJXDJBIBwcu47q/bn7qaXqr3NwCCdYvkIVie8cz+AhQTWWAOKixM
         61OKqdy1joCIlDD9sGHlkWS3kYdPi0B4CQEo73TIezNN0BootAdvL5QiZZPb4fe9V9K3
         rcr5MsXc0vsU3W9Ur7Y3nVmNZa9mxBa6dQZiudbkCRNVuXvXUbN9VR2OM4zhdzEvRv7V
         RTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JsJmED17IbgmfarUCsIfFn4wJeMQKWuSjpicioM7C2c=;
        b=dx3yyDnvntOvpqN6um4J50zlOrYgAt0Gws4spCynegeGXpojPQgqSAQwp5v9bPawbU
         S3qUYKnhpGeXyI+0b+47zB1PMNH1/C1qEfMcgw258xW4Ysaav3dCF07ikQ/qpTfg0p4z
         OCqaGzRVI3d4ePLk3lDGH63tq/JWYP/j0JNUREcKxm9oUHWieaUHvvHusV+asGnj3sOD
         AwsB24BKyuqcyajd/Tpd7iE4py350MDVYMH0Ty9i9kUvtYU8SVGncUx1MbBJBdH6JG9+
         q9LRsiZP9tI7/rvDj51H96ssmcwaq4EvsFiigk5ImyiNg3w98ItamqT50BLQToewDRYg
         FyIw==
X-Gm-Message-State: AOUpUlHmujj+UmicI+15xgvbliosIKdeTH3OlOGjPGPqixEY4XfkvOhJ
        l12hS/JLclJRxcBJWykJ0CsyqQ==
X-Google-Smtp-Source: AAOMgpcuGoquIsF+jfb8UDKwntrJiFXkD9iL+L8eOvJSb1MoI7lgOVuoZ0WYtdjZL4zVb7fL2p/QHA==
X-Received: by 2002:a1c:545:: with SMTP id 66-v6mr5192338wmf.140.1532529229016;
        Wed, 25 Jul 2018 07:33:49 -0700 (PDT)
Received: from localhost (ip-89-102-139-36.net.upcbroadband.cz. [89.102.139.36])
        by smtp.gmail.com with ESMTPSA id d15-v6sm6664752wmb.0.2018.07.25.07.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 07:33:48 -0700 (PDT)
Date:   Wed, 25 Jul 2018 16:31:23 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jiri Pirko <jiri@mellanox.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: cls_api: fix dead code in switch
Message-ID: <20180725143123.GO2164@nanopsycho>
References: <20180725140724.GA23053@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725140724.GA23053@embeddedor.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 25, 2018 at 04:07:24PM CEST, gustavo@embeddedor.com wrote:
>Code at line 1850 is unreachable. Fix this by removing the break
>statement above it, so the code for case RTM_GETCHAIN can be
>properly executed.
>
>Addresses-Coverity-ID: 1472050 ("Structurally dead code")
>Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>

I'm just writing a selftest to test this path. Thanks.
