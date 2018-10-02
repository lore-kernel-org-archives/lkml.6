Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF6FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F11B20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F11B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeJBNAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:00:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38196 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeJBNAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:00:49 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7DD0C1414D372;
        Mon,  1 Oct 2018 23:19:15 -0700 (PDT)
Date:   Mon, 01 Oct 2018 23:19:14 -0700 (PDT)
Message-Id: <20181001.231914.2200760830649337187.davem@davemloft.net>
To:     vakul.garg@nxp.com
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org, davejwatson@fb.com,
        doronrk@fb.com
Subject: Re: [PATCH net-next] selftests/tls: Fix recv(MSG_PEEK) & splice()
 test cases
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180928161808.10363-1-vakul.garg@nxp.com>
References: <20180928161808.10363-1-vakul.garg@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Oct 2018 23:19:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vakul Garg <vakul.garg@nxp.com>
Date: Fri, 28 Sep 2018 21:48:08 +0530

> TLS test cases splice_from_pipe, send_and_splice &
> recv_peek_multiple_records expect to receive a given nummber of bytes
> and then compare them against the number of bytes which were sent.
> Therefore, system call recv() must not return before receiving the
> requested number of bytes, otherwise the subsequent memcmp() fails.
> This patch passes MSG_WAITALL flag to recv() so that it does not return
> prematurely before requested number of bytes are copied to receive
> buffer.
> 
> Signed-off-by: Vakul Garg <vakul.garg@nxp.com>

Applied.
