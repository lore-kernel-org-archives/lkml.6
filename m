Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeFDHWo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbeFDHCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:02:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 16/52] Input: synaptics - add Intertouch support on X1 Carbon 6th and X280
Date: Mon,  4 Jun 2018 08:58:11 +0200
Message-Id: <20180604065607.182986518@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit 5717a09aeaf62d197deba1fc7ccd6bc45f3a9dcc upstream.

Synaptics devices reported it has Intertouch support,
and it fails via PS/2 as following logs:

psmouse serio2: Failed to reset mouse on synaptics-pt/serio0
psmouse serio2: Failed to enable mouse on synaptics-pt/serio0

Set these new devices to use SMBus to fix this issue, then they report
SMBus version 3 is using, patch:
https://patchwork.kernel.org/patch/9989547/ enabled SMBus ver 3 and
makes synaptics devices work fine on SMBus mode.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -174,6 +174,8 @@ static const char * const smbus_pnp_ids[
 	"LEN004a", /* W541 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
+	"LEN0092", /* X1 Carbon 6 */
+	"LEN0096", /* X280 */
 	"LEN200f", /* T450s */
 	NULL
 };
