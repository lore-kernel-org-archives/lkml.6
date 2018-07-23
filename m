Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B558520685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B558520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbeGWLrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:47:36 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44378 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbeGWLrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:47:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A74576089E00;
        Mon, 23 Jul 2018 12:46:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O-XhD6r3uH_u; Mon, 23 Jul 2018 12:46:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5172D6089E21;
        Mon, 23 Jul 2018 12:46:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rVToYyIkU6pA; Mon, 23 Jul 2018 12:46:59 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 28C016089E00;
        Mon, 23 Jul 2018 12:46:59 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: include architecture Kconfig files from top-level Kconfig v2
Date:   Mon, 23 Jul 2018 12:46:51 +0200
Message-ID: <8939171.tHQiqpY3WF@blindfold>
In-Reply-To: <20180708152004.21679-1-hch@lst.de>
References: <20180708152004.21679-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. Juli 2018, 17:19:55 CEST schrieb Christoph Hellwig:
> Hi Masahiro,
> 
> what do you think about the series below, which moves the includes
> of all the architecture independ Kconfig files to the top-level
> Kconfig instead of duplicating the includes in all architectures?
> 
> Note that this only handles the low-hanging fruite, there are a lot
> of other bits that should probably be cleaned up to be common,
> but those will be not entirely trivial.
> 
> Changes since v1:
>  - add back a remove source statement from arch/arm/Kconfig
>  - various fixes from Randy
>  - various UML patches to be able to use the common Kconfig

For the UML bits,

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

