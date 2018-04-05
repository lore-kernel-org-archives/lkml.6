Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeDENZv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:25:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751361AbeDENZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:25:48 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/8] Input: synaptics - add Lenovo 80 series ids to SMBus
Date: Thu,  5 Apr 2018 15:25:30 +0200
Message-Id: <20180405132537.3218-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This time, Lenovo decided to go with different pieces in its latest series
of Thinkpads.

For those we have been able to test:
- the T480 is using Synaptics with an IBM trackpoint
   -> it behaves properly with or without intertouch, there is no point
      not using RMI4
- the X1 Carbon 6th gen is using Synaptics with an IBM trackpoint
   -> the touchpad doesn't behave properly under PS/2 so we have to
      switch it to RMI4 if we do not want to have disappointed users
- the X280 is using Synaptics with an ALPS trackpoint
   -> the recent fixes in the trackpoint handling fixed it so upstream
      now works fine with or without RMI4, and there is no point not
      using RMI4
- the T480s is using an Elan touchpad, so that's a different story

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 60f2c463d1cc..14a1188561aa 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -173,6 +173,9 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
 	"LEN200f", /* T450s */
+	"LEN0071", /* T480 */
+	"LEN0092", /* X1 Carbon 6th gen */
+	"LEN0097", /* X280 -> ALPS trackpoint */
 	NULL
 };
 
-- 
2.14.3
