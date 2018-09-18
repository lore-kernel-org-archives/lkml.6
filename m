Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2CCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9B2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF9B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeIRNw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:52:56 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:57102 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbeIRNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:52:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B766B606D4A4;
        Tue, 18 Sep 2018 10:21:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id f9BEhzn9Zirp; Tue, 18 Sep 2018 10:21:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 55B4F606D49F;
        Tue, 18 Sep 2018 10:21:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rlf6aj3qA7TM; Tue, 18 Sep 2018 10:21:23 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id EB61260A3592;
        Tue, 18 Sep 2018 10:21:22 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org, David Howells <dhowells@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] samples: disable CONFIG_SAMPLES for UML
Date:   Tue, 18 Sep 2018 10:21:22 +0200
Message-ID: <2024081.XhWFmWp6tJ@blindfold>
In-Reply-To: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
References: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 18. September 2018, 05:58:33 CEST schrieb Masahiro Yamada:
> Some samples require headers installation, so commit 3fca1700c4c3
> ("kbuild: make samples really depend on headers_install") added
> such dependency in the top Makefile.  However, UML fails to build
> with CONFIG_SAMPLES=y because UML does not support headers_install.
> 
> Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_install")
> Reported-by: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Is there anything UML can do better?
Not sure whether an arch like is supposed to install headers at all,
I guess no. :)

Thanks,
//richard


