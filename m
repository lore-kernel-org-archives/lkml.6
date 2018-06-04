Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeFDHTQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753404AbeFDHDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:03:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edvard Holst <edvard.holst@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.16 14/47] Input: synaptics - Lenovo Thinkpad X1 Carbon G5 (2017) with Elantech trackpoints should use RMI
Date: Mon,  4 Jun 2018 08:58:26 +0200
Message-Id: <20180604065550.080137980@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edvard Holst <edvard.holst@gmail.com>

commit 15e2cffec3aa0d47a8d75ae80e1b136bfb5dff30 upstream.

Lenovo use two different trackpoints in the fifth generation Thinkpad X1
Carbon. Both are accessible over SMBUS/RMI but the pnpIDs are missing.
This patch is for the Elantech trackpoint specifically which also
reports SMB version 3 so rmi_smbus needs to be updated in order to
handle it.

For the record, I was not the first one to come up with this patch as it
has been floating around the internet for a while now. However, I have
spent significant time with testing and my efforts to find the original
author of the patch have been unsuccessful.

Signed-off-by: Edvard Holst <edvard.holst@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -173,6 +173,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
+	"LEN0073", /* X1 Carbon G5 (Elantech) */
 	"LEN200f", /* T450s */
 	NULL
 };
