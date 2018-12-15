Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE02C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22342084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeLOVXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:23:35 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55950 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeLOVXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:23:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4B39214E8EDFF;
        Sat, 15 Dec 2018 13:23:34 -0800 (PST)
Date:   Sat, 15 Dec 2018 13:23:33 -0800 (PST)
Message-Id: <20181215.132333.867660599141318055.davem@davemloft.net>
To:     pabeni@redhat.com
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com, pjt@google.com,
        linux-kernel@vger.kernel.org, ecree@solarflare.com,
        dwmw2@infradead.org
Subject: Re: [PATCH net-next v3 0/4] net: mitigate retpoline overhead
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1544784419.git.pabeni@redhat.com>
References: <cover.1544784419.git.pabeni@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 13:23:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 14 Dec 2018 11:51:56 +0100

> The spectre v2 counter-measures, aka retpolines, are a source of measurable
> overhead[1]. We can partially address that when the function pointer refers to
> a builtin symbol resorting to a list of tests vs well-known builtin function and
> direct calls.
> 
> Experimental results show that replacing a single indirect call via
> retpoline with several branches and a direct call gives performance gains
> even when multiple branches are added - 5 or more, as reported in [2].
> 
> This may lead to some uglification around the indirect calls. In netconf 2018
> Eric Dumazet described a technique to hide the most relevant part of the needed
> boilerplate with some macro help.
> 
> This series is a [re-]implementation of such idea, exposing the introduced
> helpers in a new header file. They are later leveraged to avoid the indirect
> call overhead in the GRO path, when possible.
> 
> Overall this gives > 10% performance improvement for UDP GRO benchmark and
> smaller but measurable for TCP syn flood.
> 
> The added infra can be used in follow-up patches to cope with retpoline overhead
> in other points of the networking stack (e.g. at the qdisc layer) and possibly
> even in other subsystems.
 ...

Series applied, I'll push this out after a build check completes.

Thanks.

