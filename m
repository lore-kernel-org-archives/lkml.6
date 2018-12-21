Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0600021903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbeLUAt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:49:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36060 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388162AbeLUAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:49:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AEE651499203C;
        Thu, 20 Dec 2018 16:49:55 -0800 (PST)
Date:   Thu, 20 Dec 2018 16:49:54 -0800 (PST)
Message-Id: <20181220.164954.1492087150966785483.davem@davemloft.net>
To:     semen.protsenko@linaro.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        g.nault@alphalink.fr
Subject: Re: [PATCH v2] ppp: Move PFC decompression to PPP generic layer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181220182920.4208-1-semen.protsenko@linaro.org>
References: <20181220182920.4208-1-semen.protsenko@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 20 Dec 2018 16:49:55 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 20 Dec 2018 20:29:20 +0200

> Extract "Protocol" field decompression code from transport protocols to
> PPP generic layer, where it actually belongs. As a consequence, this
> patch fixes incorrect place of PFC decompression in L2TP driver (when
> it's not PPPOX_BOUND) and also enables this decompression for other
> protocols, like PPPoE.
> 
> Protocol field decompression also happens in PPP Multilink Protocol
> code and in PPP compression protocols implementations (bsd, deflate,
> mppe). It looks like there is no easy way to get rid of that, so it was
> decided to leave it as is, but provide those cases with appropriate
> comments instead.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Fix the order of checking skb data room and proto decompression
>   - Remove "inline" keyword from ppp_decompress_proto()
>   - Don't split line before function name
>   - Prefix ppp_decompress_proto() function with "__"
>   - Add ppp_decompress_proto() function with skb data room checks
>   - Add description for introduced functions
>   - Fix comments (as per review on mailing list)

Applied with Guillaume's suggested adjustments made.

Thank you.
