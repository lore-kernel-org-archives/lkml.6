Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7A6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4F32175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4F32175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbeHNAsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:48:37 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54598 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbeHNAsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:48:37 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MVVCo-1fNQKY3i3i-00YfOv; Tue, 14 Aug 2018 00:04:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>,
        Jeremy Cline <jeremy@jcline.org>,
        Kees Cook <keescook@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: hci_h5: avoid unused variable warnings
Date:   Tue, 14 Aug 2018 00:04:13 +0200
Message-Id: <20180813220419.4168133-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:8xLmc/XImooT8UUp+5ub3w2ddoGDcCp6RfI+gHJVs7fYu0Aks2E
 O3gqX4pZBRwgZh5j0JAJFwMw0aouFKFXhDw9dxlSBRzqldVFGl6PWbdm9t4ged40PbgNNyD
 wsoAOwkns3A0jmnIiVLf+Ck/sLGvzMkgaTlYQ59aUFFBzkckDGAFT+EpKZZajJ80vZ2vrmZ
 ayq5zK/7N7YWCEBfYEOvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LuFrXdvL3pU=:PhXi+3Aw0y+PJ8OfHZrnPK
 uGaC0+FdxvKyf8GW6+hkxWhlFZ5DbBhRJdq8g1WQQ5YqzK3nitVVPdF8kXWsLulqpEPaxzDgI
 u4VmFnfkDWoM5ionn/TfnVFGcM23h8DUBi1ztnLCp+H1JeYqSxg8hCjeuS3anCtfaTxP+Gx0g
 MSBck6A5vKt0lT4wj+52rDnH4De4NagRBYqcjXynodKvRXg7nbN8dQqAYVUhVPQ/oSyramG31
 EOpHTeUrjerui2OtiTj30nhHK6jyUq5LqZYXS7MNS0aO4v1DlT097tXfF0TkgzVthyqPkb39o
 aSbIa66EIMqsgIhuLB7ZOkz/Ls+uczjOh33UWYS2STAlp0n7fOdtj16faAkCQ/lKG91Hn3x3i
 W4dpUb0+R9y1cGq12CLcI3YOhTXFeyvk2FglziyOfxOJsKRL44JyRU/OIlsgoAKa8K7ReDaSO
 1PVD8Y3WPxRs0f/G6ucJHRuqZrbPXURZN73BPYF67wHy1p+DCB80xbu+0twBgV4K8g49XIDSs
 /pr6HmClHbwfkHrHHaMo9IIgd4BbNUX9C2rXAPkHVMyaRyGf1vwJtEAAim5qvYZHcG2/NqQo7
 rh9eVT/jTiyZ7F36/CS6EquBWazOAibLXcvnv+KoshPZJVNeMyVg4LbZnO+zq0Mbmss4tgJfv
 uiqCwTSJcX3vU25lYcQXNUTNmmtqA4K4Qugm316RNCIvtjD5XrXQOhwf/k/tmuoamsCE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BT_HCIUART_RTL is disabled, the hci_h5 driver produces a build
warning because of an incorrect set of #ifdef guards:

drivers/bluetooth/hci_h5.c:920:22: error: 'rtl_vnd' defined but not used [-Werror=unused-variable]

Replacing the #ifdef with an IS_ENABLED() check shuts up the error
and simplifies the logic.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/hci_h5.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..b10e64ba0ff4 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -841,7 +841,6 @@ static void h5_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&h5->serdev_hu);
 }
 
-#ifdef CONFIG_BT_HCIUART_RTL
 static int h5_btrtl_setup(struct h5 *h5)
 {
 	struct btrtl_device_info *btrtl_dev;
@@ -923,24 +922,21 @@ static struct h5_vnd rtl_vnd = {
 	.close		= h5_btrtl_close,
 	.acpi_gpio_map	= acpi_btrtl_gpios,
 };
-#endif
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
-#ifdef CONFIG_BT_HCIUART_RTL
 	{ "OBDA8723", (kernel_ulong_t)&rtl_vnd },
-#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
-#endif
 
 static struct serdev_device_driver h5_serdev_driver = {
 	.probe = h5_serdev_probe,
 	.remove = h5_serdev_remove,
 	.driver = {
 		.name = "hci_uart_h5",
-		.acpi_match_table = ACPI_PTR(h5_acpi_match),
+		.acpi_match_table = (IS_ENABLED(CONFIG_BT_HCIUART_RTL) &&
+				     IS_ENABLED(CONFIG_ACPI)) ?
+					h5_acpi_match : 0,
 	},
 };
 
-- 
2.18.0

