Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345E1C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E387B207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E387B207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeJWKqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:46:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39714 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJWKqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:46:21 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0E5C4146C93F3;
        Mon, 22 Oct 2018 19:25:08 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:25:07 -0700 (PDT)
Message-Id: <20181022.192507.2264639269160412648.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3] isdn: hfc_{pci,sx}: Avoid empty body if statements
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181019011103.32087-1-natechancellor@gmail.com>
References: <20181018034935.16819-1-natechancellor@gmail.com>
        <20181019011103.32087-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Oct 2018 19:25:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 18 Oct 2018 18:11:04 -0700

> Clang warns:
> 
> drivers/isdn/hisax/hfc_pci.c:131:34: error: if statement has empty body
> [-Werror,-Wempty-body]
>         if (Read_hfc(cs, HFCPCI_INT_S1));
>                                         ^
> drivers/isdn/hisax/hfc_pci.c:131:34: note: put the semicolon on a
> separate line to silence this warning
> 
> In my attempt to hide the warnings because I thought they didn't serve
> any purpose[1], Masahiro Yamada pointed out that {Read,Write}_hfc in
> hci_pci.c should be using a standard register access method; otherwise,
> the compiler will just remove the if statements.
> 
> For hfc_pci, use the versions of {Read,Write}_hfc found in
> drivers/isdn/hardware/mISDN/hfc_pCI.h while converting pci_io to be
> 'void __iomem *' (and clean up ioremap) then remove the empty if
> statements.
> 
> For hfc_sx, {Read,Write}_hfc are already use a proper register accessor
> (inb, outb) so just remove the unnecessary if statements.
> 
> [1]: https://lore.kernel.org/lkml/20181016021454.11953-1-natechancellor@gmail.com/
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/66
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
