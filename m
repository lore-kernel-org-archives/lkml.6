Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B895C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D324820827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D324820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbeKGEl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:41:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51118 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387928AbeKGEl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:41:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 443D21455115A;
        Tue,  6 Nov 2018 11:15:14 -0800 (PST)
Date:   Tue, 06 Nov 2018 11:15:13 -0800 (PST)
Message-Id: <20181106.111513.858603892736758550.davem@davemloft.net>
To:     suraj1998@gmail.com
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: net: ipv4: tcp_westwood: fixed warnings and
 checks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541425985-31869-1-git-send-email-suraj1998@gmail.com>
References: <1541425985-31869-1-git-send-email-suraj1998@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 06 Nov 2018 11:15:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suraj Singh <suraj1998@gmail.com>
Date: Mon,  5 Nov 2018 19:23:05 +0530

> Fixed warnings and checks for TCP Westwood
> 
> Signed-off-by: Suraj Singh <suraj1998@gmail.com>

I asked you yesterday why "staging: " appears in your subject line
and you have failed to respond and explain.

There are also functional issues with your patch:

> -		tp->snd_cwnd = tp->snd_ssthresh = tcp_westwood_bw_rttmin(sk);
> +		tp->snd_cwnd = tcp_westwood_bw_rttmin(sk);
> +		tp->snd_ssthresh = tcp_westwood_bw_rttmin(sk);

This is bogus, now tcp_westwood_bw_rttmin(sk) will potentially be called
two times instead of once.

The existing code is fine, please do not modify it.
