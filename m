Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D416C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7590820656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390054AbeLTVmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:42:16 -0500
Received: from zimbra.alphalink.fr ([217.15.80.77]:36792 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbeLTVmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:42:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 762DA2B52055;
        Thu, 20 Dec 2018 22:42:13 +0100 (CET)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5lChRjmE2B19; Thu, 20 Dec 2018 22:42:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id EC4872B52128;
        Thu, 20 Dec 2018 22:42:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DfON7dK03xSg; Thu, 20 Dec 2018 22:42:11 +0100 (CET)
Received: from localhost (170-0-140-95.reverse.alphalink.fr [95.140.0.170])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTPSA id 980792B52055;
        Thu, 20 Dec 2018 22:42:11 +0100 (CET)
Date:   Thu, 20 Dec 2018 22:42:15 +0100
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ppp: Move PFC decompression to PPP generic layer
Message-ID: <20181220214103.gq67pakntf4bqkrr@kdev>
References: <20181220182920.4208-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220182920.4208-1-semen.protsenko@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 08:29:20PM +0200, Sam Protsenko wrote:
> Extract "Protocol" field decompression code from transport protocols to
> PPP generic layer, where it actually belongs. As a consequence, this
> patch fixes incorrect place of PFC decompression in L2TP driver (when
> it's not PPPOX_BOUND) and also enables this decompression for other
> protocols, like PPPoE.
> 
Nice to see PFC implementation moving to ppp_generic.

> Protocol field decompression also happens in PPP Multilink Protocol
> code and in PPP compression protocols implementations (bsd, deflate,
> mppe). It looks like there is no easy way to get rid of that, so it was
> decided to leave it as is, but provide those cases with appropriate
> comments instead.
> 
Thanks a lot for taking care of all these particular cases.

Reviewed-by: Guillaume Nault <g.nault@alphalink.fr>

Just a side note, this is for net-next. It's better to make that
explicit by using a subject prefix like [PATCH net-next].

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
> 
Also, for networking patches, list of changes normally goes into the
commit message.
