Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC0C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192FE2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192FE2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeKCAqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:46:55 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeKCAqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:46:55 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpDRv-1flR37357H-00qhqj; Fri, 02 Nov 2018 16:39:06 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpDRv-1flR37357H-00qhqj; Fri, 02 Nov 2018 16:39:06 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vbox: fix link error with 'gcc -Og'
Date:   Fri,  2 Nov 2018 16:38:53 +0100
Message-Id: <20181102153905.1732199-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Umf2kNw7COZBQOvbe+abFdKI3dJdTojWXAeo3djbD4kLQ42Z23F
 fXPT6IYXybHsSZNWLXa917HTeNZ1HTgx4xSyNRtK1CNlHIz9VyXTnNbFgBbu1faiSQiFnET
 3bjEfCT+7khtgtBHohH5SxBnzqfforARVI1+r7lqAxM4LrOk7W+JjNNMEctFMr/rhEskgH6
 +UyEVMcew7n4ZTldQYS/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EHhyj7+A72o=:2dtkBaSOACqXyBBRWIqBnB
 JprbdWcA8EONWqPJt+fDWG8fjeZILS7+FhmyEUBARiQuQz2TMksvCffUqkwNzbhAJ2svQD3Gt
 +ofttZUArKzPHoj+GxI9QLSsaP91Nb+0Y+TWIpvzEDD+K02jNKkQzOieu4rJ1nTpBGcu5b9E8
 +wd7GeeXO8JPpvB77QM0wyORRVMcD5No7/fFLucYWg8qrZc7jgOQzyIM98HbKxhFogaPTw+f6
 Om7q4JJXVePoV+KgGOzJRrqmPC86ftDyQvV/doJKFmDTi1UYTcYMF5G7dp3iMSqEDG0FtAcHH
 V8+EWO2rHZ2inurINHYYePH3OB18dInUAD7Yky1ObGO987yq+duogXngGebUsWKK1DG2cS2RX
 i97471g8i2l1KsIHadK2UFYdiJxD1RFVkFkR5QlqwSWvf6BdaJKs3YSq+EG7XmUON57bENJrb
 P7XUlGI6mv7+sWgOIs4My3m3i4sv70jhmq9kBBxYlU6+jmqYnJP4ptFgh6YWnoiJ3TZ4LRiiL
 jyHWh2Kvb66FoJKWXAPJoLR7q0g+4Zeh0UnrH3jCptudfCGycj2MpXQyxCvjeum13z8G3PPGv
 2qHZVmS4eOH2BP/KU+vwm2TP8Q7t/FKwoa+VuaSiE9147DWkGH9pMhLKBQx4i/zD/63IDxXFX
 KUHmdHDgP0WqnYcGhJCCx9dV282OX2tlEDFnAZ686b6EUNtzOhQxHqoZnEjhgF4Kbqco=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new CONFIG_CC_OPTIMIZE_FOR_DEBUGGING option, we get a link
error in the vboxguest driver, when that fails to optimize out the
call to the compat handler:

drivers/virt/vboxguest/vboxguest_core.o: In function `vbg_ioctl_hgcm_call':
vboxguest_core.c:(.text+0x1f6e): undefined reference to `vbg_hgcm_call32'

Another compile-time check documents better what we want and avoids
the error.

Acked-by: Randy Dunlap<rdunlap@infradead.org>
Tested-by: Randy Dunlap<rdunlap@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/virt/vboxguest/vboxguest_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 3093655c7b92..1475ed5ffcde 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1312,7 +1312,7 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
 		return -EINVAL;
 	}
 
-	if (f32bit)
+	if (IS_ENABLED(CONFIG_COMPAT) && f32bit)
 		ret = vbg_hgcm_call32(gdev, client_id,
 				      call->function, call->timeout_ms,
 				      VBG_IOCTL_HGCM_CALL_PARMS32(call),
-- 
2.18.0

