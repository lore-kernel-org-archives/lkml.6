Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B72C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0E72083C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0E72083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeHNGbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:31:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38182 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeHNGbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:31:51 -0400
Received: from localhost (unknown [172.58.41.230])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6E56812173DBF;
        Mon, 13 Aug 2018 20:46:38 -0700 (PDT)
Date:   Mon, 13 Aug 2018 20:46:37 -0700 (PDT)
Message-Id: <20180813.204637.1084503075030488749.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     jchapman@katalix.com, g.nault@alphalink.fr,
        lorenzo.bianconi@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] l2tp: fix unused function warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180813214341.3333789-1-arnd@arndb.de>
References: <20180813214341.3333789-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 20:46:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Aug 2018 23:43:05 +0200

> Removing one of the callers of pppol2tp_session_get_sock caused a harmless
> warning in some configurations:
> 
> net/l2tp/l2tp_ppp.c:142:21: 'pppol2tp_session_get_sock' defined but not used [-Wunused-function]
> 
> Rather than adding another #ifdef here, using a proper IS_ENABLED()
> check makes the code more readable and avoids those warnings while
> letting the compiler figure out for itself which code is needed.
> 
> This adds one pointer for the unused show() callback in struct
> l2tp_session, but that seems harmless.
> 
> Fixes: b0e29063dcb3 ("l2tp: remove pppol2tp_session_ioctl()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
