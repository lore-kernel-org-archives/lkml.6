Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD17FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7057220833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7057220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeIZAml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:42:41 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:56177 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbeIZAml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:42:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 359CC100E86C2;
        Tue, 25 Sep 2018 18:33:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: money53_3ea61ce703163
X-Filterd-Recvd-Size: 1923
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Sep 2018 18:33:50 +0000 (UTC)
Message-ID: <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com>
Subject: Re: [PATCH net-next v6 02/23] zinc: introduce minimal cryptography
 library
From:   Joe Perches <joe@perches.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     Samuel Neves <sneves@dei.uc.pt>, Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Date:   Tue, 25 Sep 2018 11:33:49 -0700
In-Reply-To: <20180925145622.29959-3-Jason@zx2c4.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
         <20180925145622.29959-3-Jason@zx2c4.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 16:56 +0200, Jason A. Donenfeld wrote:
> Zinc stands for "Zinc Is Neat Crypto" or "Zinc as IN Crypto" or maybe
> just "Zx2c4's INsane Cryptolib." It's also short, easy to type, and
> plays nicely with the recent trend of naming crypto libraries after
> elements. The guiding principle is "don't overdo it". It's less of a
> library and more of a directory tree for organizing well-curated direct
> implementations of cryptography primitives.
[]
> diff --git a/lib/zinc/Makefile b/lib/zinc/Makefile
> new file mode 100644
> index 000000000000..a61c80d676cb
> --- /dev/null
> +++ b/lib/zinc/Makefile
> @@ -0,0 +1,3 @@
> +ccflags-y := -O2
> +ccflags-y += -D'pr_fmt(fmt)="zinc: " fmt'
> +ccflags-$(CONFIG_ZINC_DEBUG) += -DDEBUG

I think the -Dpr_fmt is especially odd and not
really acceptable as it not used anywhere else
in the kernel.


