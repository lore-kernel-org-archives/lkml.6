Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF66C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8862082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8862082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIDVzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:55:51 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34713 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeIDVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:55:50 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LymAB-1frJvI0h5L-0168EC; Tue, 04 Sep 2018 19:29:39 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 2/4 next] net: lan78xx: Drop unnecessary strcpy in lan78xx_probe
Date:   Tue,  4 Sep 2018 19:29:10 +0200
Message-Id: <1536082152-3669-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536082152-3669-1-git-send-email-stefan.wahren@i2se.com>
References: <1536082152-3669-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:TdohkElw0k24Z76YVoYY5v1Z1T15qULO/vptTLPe8f7DsAqu3g6
 aO0VSMyGN9LT5RT9V2WGGHsOTfRCTr/VT4k+eb4P5OxVpGoYEU6UkumAOnEaB9gA3vKW4yU
 xxW7zsgK1FJoOFRobyA5cxEqUYvUBA9kfe7WRgMH/ZqZdBXN73leQOrGlPHbuJNwgx3MvVo
 +SHsnDmGx/9u4lrIM7BRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z5UlGmUwGOU=:V4qEObedI1q6XIO6Akcqd/
 AEDlx50j71tKMlj5JCS9PLLkRBG2QZ/8yfPgEGw5hoLVNpS8Ls6MZkNcKmPJyu1M61X0SxT4P
 XkwPZa8ZGYUM2eoJkn7mXLZV/HhD467SYSwf8IZJOjvMSddBngjUHKmxn1m430LGyhbx3UDBO
 HcIFE+PdgtG2uSu39qzC0Q9wFth3okFIFXp/X5Oz3D0AvHAw16moMuwghALQVpQu7gMfHzdQb
 PcpW08g0TjLuZ4hioUI6yYEHTwlgUjXM/3W+i3IF1cmTUIH0PDrgaPBk9/wspcerEWIBenB7B
 dW23qveMd1c8zlnmGd2cffj6QkENVY0fWEUqtbCtdwghIG77QQALdq9zDTN96zAZTsUX4rTet
 wFXoQWYjbW4K8IPIstUSAmM4+Lmf2raqMbb7lInJXCWXHDGgwIL9u3/4Y9OkI4hinV6vBtCjq
 3C6QR1VytEbbX+ahMlNEeG/iAT2/HQyxN69u9VtMYgTttoU7W1F0t4p9Afdp2gdIH91kEB7Mc
 34+a02PtRZpjWXc3Gla+O04Rv4eZ3WhHmogf0EUOAaj9Vj6aMPOsoKttE0/7fSDc5ugA4gv1X
 m8+5r+dwC+S19pfIPMlv2eEtSF9wpuo+JeujB6zfDyWzvm0E/J7HkoZnCM7hh1q+p9lIbNgkW
 z+gcvHfpj+y74pmXyKG2rzG6wuIM1/KSmmhoFZTnQxSQKfQe9lJdZRgCyMp/UpNNII3s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for this strcpy because alloc_etherdev() already
does this job.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Raghuram Chary Jallipalli <raghuramchary.jallipalli@microchip.com>
---
 drivers/net/usb/lan78xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 3f70b94..3d505c2 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3766,7 +3766,6 @@ static int lan78xx_probe(struct usb_interface *intf,
 	ret = lan78xx_bind(dev, intf);
 	if (ret < 0)
 		goto out2;
-	strcpy(netdev->name, "eth%d");
 
 	if (netdev->mtu > (dev->hard_mtu - netdev->hard_header_len))
 		netdev->mtu = dev->hard_mtu - netdev->hard_header_len;
-- 
2.7.4

