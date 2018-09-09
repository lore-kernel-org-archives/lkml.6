Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022CAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816BF20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="og5bkSmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816BF20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIIXZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:25:49 -0400
Received: from ned.t-8ch.de ([212.47.237.191]:52428 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbeIIXZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:25:48 -0400
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1536518111;
        bh=rUTn+GqloC2OMiTw/vrW2sS7NsJc1NdV2ycjIrbVuRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=og5bkSmjXTRvLcCZCRtxbRjkcgBng8jBsFLT72tMvfngU/sZTd75t5E0/U/zokGDV
         579Hvgb2wRD2CkrEwYzi7gCrggT1QJINNiKfrRyJAYOFlnajEBra4Cl8XadV46/7qT
         rF3/gsDuggNqLrnJ/5DyheU/FJ2SNqbStJQ6IkzQ=
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] MAINTAINERS: add tree location for staging/erofs
Date:   Sun,  9 Sep 2018 20:34:32 +0200
Message-Id: <20180909183432.9752-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <5c44a63b-041d-1fce-0748-53c0b44f5983@huawei.com>
References: <5c44a63b-041d-1fce-0748-53c0b44f5983@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao, hi Gao,

On Sun, 2018-09-09T23:16+0800, Chao Yu wrote:
> Hi Thomas,
>
> On 2018/9/8 11:28, Gao Xiang wrote:
>> Hi Thomas,
>>
>> Thanks for your new patch.
>>
>> It seems that this patch also introduces 2 new 'WARNING: line over 80 characters',
>> could you please fix it in the patch?

@Chao,Gao: For some reason there seems to be a problem when receiving mails
from you. The one I received now was the first one from you that reached me
directly. Before I only got your messages in the quotes from Dan and now in the
quotes from the mail I am responding to.
(I will try to investigate the reason for this)

Sorry for my slow responses before.

> It will be better to fix that.

A new patch will shortly follow.

> Some reviewed cleanup patches are merged before this patch, then I failed to add
> this one, so could you rebase on top of erofs dev branch in below link:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=erofs

I was not aware of this tree and worked off of staging / next.
A patch is attached to this message that adds the tree to the MAINTAINERS file.

-- >8 --

Currently this location is not documented.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..9087e0b74821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13747,6 +13747,7 @@ F:	drivers/staging/comedi/
 STAGING - EROFS FILE SYSTEM
 M:	Gao Xiang <gaoxiang25@huawei.com>
 M:	Chao Yu <yuchao0@huawei.com>
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git erofs
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 F:	drivers/staging/erofs/
-- 
2.18.0

