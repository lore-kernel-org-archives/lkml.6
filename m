Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7DB20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc3+H+4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7DB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeIJQmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:42:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35179 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeIJQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:42:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so21163019wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4enHsBG2ys9ELe47HYufkTEIiK+wA0mgno52ndG7lnU=;
        b=Hc3+H+4UoLfiOCryMySWMmc0nt6rLXH9H4qss+ptZXG0S5oXTLhiV6n7PnrlodLjy5
         XEqic8238Qr+fe4loXeJlGODS0gjLadhyMP+tVDPdQlqCHIln8DmHcKLjKGoH+7z0kTP
         x/4CkzYls8/XkHM3y26TEI691A8wJCbXFQeendRlsAWrfZyKstOg1dq529q1sPu3A8KG
         AiYsqkWynAml0mIYhjGuUxGKPJlvnzaGYMz+8rcUfhsdLpAhK4qZSgNCFCzfex+JoSlZ
         DrUNLc8TyYL065RsylDU9pmuqqBxIO1McFIeOBPQ9kLCVcO3QRpR+kWvCy5moGVSu2gf
         FGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4enHsBG2ys9ELe47HYufkTEIiK+wA0mgno52ndG7lnU=;
        b=A5Zp/QSNlVzrHfgdkPKndXvlA/sEMdklkQRUtWOw3zEzH23RwHISDoRpevfS5eduG3
         FGmIFOeONX+97uWOt+RHiuw2x2MH/BHKYLXYiXQKK7dt7qMJ0/9TRYwmXCYV901Lj0BK
         wQ0DQ0vUpoHgH42BMGiP8nRg887gfrPpyRvrkxEsSX4mmVbl3s38OYHQXzS1Gb6NJ0+U
         yCTYAnC8pblNJNgGQosQby7ukwRDf00ffarFkqaXvHZ+ow8M1XP+FmNCPSZJ56KTpdb7
         mnnqJoMJGnMeCBFkmkfb9ersZ7jnyX2a3QSp2nqM1g3XI67ptORMchw5udBJj5nosumf
         NR9g==
X-Gm-Message-State: APzg51AfrUQjKR+mbfvpG4G6bpS9ipN2aYmrJgEfcP/CegOy5W3nixG6
        GhM4OsxCMJAJ89AU9lWxALo=
X-Google-Smtp-Source: ANB0VdaKnfGq4OkUjhxta/yWNSnhb65vByW9Tk1ySNuUcIvTcuHg+3yvtmdsQ8SeTlb+zdGNWgnSkA==
X-Received: by 2002:a1c:dc41:: with SMTP id t62-v6mr463894wmg.137.1536580143647;
        Mon, 10 Sep 2018 04:49:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c15-v6sm10432973wmb.2.2018.09.10.04.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 04:49:03 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:49:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tools/lib/lockdep: fixes for v4.19
Message-ID: <20180910114901.GA48081@gmail.com>
References: <20180813190527.16853-1-alexander.levin@microsoft.com>
 <20180829000356.GA161312@sasha-vm>
 <20180906153020.GW16300@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906153020.GW16300@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> Ping?

Sorry about the delay - all applied now, thanks!

	Ingo
