Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeFDHD1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752720AbeFDHDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:03:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.16 16/47] Input: synaptics - add Lenovo 80 series ids to SMBus
Date: Mon,  4 Jun 2018 08:58:28 +0200
Message-Id: <20180604065550.163262810@linuxfoundation.org>
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

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit ad8fb554f04e38f155c9bc34bbf521fc592ceee7 upstream.

This time, Lenovo decided to go with different pieces in its latest
series of Thinkpads.

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

Cc: <stable@vger.kernel.org> # v4.14.x, v4.15.x, v4.16.x
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -172,10 +172,12 @@ static const char * const smbus_pnp_ids[
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
+	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
 	"LEN0092", /* X1 Carbon 6 */
 	"LEN0096", /* X280 */
+	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
 	NULL
 };
