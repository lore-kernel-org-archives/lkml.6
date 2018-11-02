Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C88C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F442081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F442081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeKBVaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:30:11 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:35674 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:30:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 52B7B609F82F;
        Fri,  2 Nov 2018 13:23:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id s8uI1ztIw_5M; Fri,  2 Nov 2018 13:23:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EA969606C479;
        Fri,  2 Nov 2018 13:23:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HONhuc48UhEE; Fri,  2 Nov 2018 13:23:08 +0100 (CET)
Received: from blindfold.localnet (089144197035.atnat0006.highway.a1.net [89.144.197.35])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 69D226089E20;
        Fri,  2 Nov 2018 13:23:08 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: auth: add CONFIG_KEYS dependency
Date:   Fri, 02 Nov 2018 13:23:07 +0100
Message-ID: <1918197.Mj5OQZhev6@blindfold>
In-Reply-To: <20181102111129.276496-1-arnd@arndb.de>
References: <20181102111129.276496-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. November 2018, 12:11:22 CET schrieb Arnd Bergmann:
> The new authentication support causes a build failure
> when CONFIG_KEYS is disabled, so add a dependency.
> 
> fs/ubifs/auth.c: In function 'ubifs_init_authentication':
> fs/ubifs/auth.c:249:16: error: implicit declaration of function 'request_key'; did you mean 'request_irq'? [-Werror=implicit-function-declaration]
>   keyring_key = request_key(&key_type_logon, c->auth_key_name, NULL);
> 
> Fixes: d8a22773a12c ("ubifs: Enable authentication support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied!

Thanks,
//richard


