Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2DEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33E12075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33E12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mba.ocn.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbeIFTkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:40:08 -0400
Received: from mfdf018.ocn.ad.jp ([153.128.50.74]:48871 "EHLO
        mfdf018.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:40:08 -0400
Received: from mogw1033.ocn.ad.jp (mogw1033.ocn.ad.jp [153.149.231.39])
        by mfdf018.ocn.ad.jp (Postfix) with ESMTP id 24BD7B81310
        for <linux-kernel@vger.kernel.org>; Fri,  7 Sep 2018 00:04:11 +0900 (JST)
Received: from mf-smf-ucb026c2 (mf-smf-ucb026c2.ocn.ad.jp [153.153.66.167])
        by mogw1033.ocn.ad.jp (Postfix) with ESMTP id 868F180023A;
        Fri,  7 Sep 2018 00:04:08 +0900 (JST)
Received: from ntt.pod01.mv-mta-ucb021 ([153.149.142.84])
        by mf-smf-ucb026c2 with ESMTP
        id xvpIfNQqaZVYwxvpIf38J0; Fri, 07 Sep 2018 00:04:08 +0900
Received: from smtp.ocn.ne.jp ([153.149.227.135])
        by ntt.pod01.mv-mta-ucb021 with 
        id YF481y0012vuoep01F489c; Thu, 06 Sep 2018 15:04:08 +0000
Received: from localhost (p935071-ipngn2102funabasi.chiba.ocn.ne.jp [180.56.175.71])
        by smtp.ocn.ne.jp (Postfix) with ESMTPA;
        Fri,  7 Sep 2018 00:04:08 +0900 (JST)
Date:   Fri, 07 Sep 2018 00:04:07 +0900 (JST)
Message-Id: <20180907.000407.1493498061297805737.anemo@mba.ocn.ne.jp>
To:     dingxiang@cmss.chinamobile.com
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: txx9: fix iounmap related issue
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1536207559-31543-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1536207559-31543-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Sep 2018 12:19:19 +0800, Ding Xiang <dingxiang@cmss.chinamobile.com> wrote:
> if device_register return error, iounmap should be called, also iounmap
> need to call before put_device.
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  arch/mips/txx9/generic/setup.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thank you for fixing this long standing issue.  It looks OK for me.

Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
