Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001C2C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE3420850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE3420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLGGYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:24:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49778 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGGYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:24:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 269CD147E6BB3;
        Thu,  6 Dec 2018 22:24:12 -0800 (PST)
Date:   Thu, 06 Dec 2018 22:24:09 -0800 (PST)
Message-Id: <20181206.222409.551374562843523036.davem@davemloft.net>
To:     pabeni@redhat.com
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com, pjt@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: mitigate retpoline overhead
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1544032300.git.pabeni@redhat.com>
References: <cover.1544032300.git.pabeni@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 06 Dec 2018 22:24:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed,  5 Dec 2018 19:13:38 +0100

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

Series applied, thanks!
