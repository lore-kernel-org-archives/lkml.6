Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932130AbeBGRRN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:17:13 -0500
Received: from zimbra.linuxprofi.at ([93.83.54.199]:45626 "EHLO
        zimbra.linuxprofi.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbeBGRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:16:32 -0500
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>
Subject: [PATCH 1/3] hid: logitech-dj: fix various style issues
Date: Wed,  7 Feb 2018 18:07:58 +0100
Message-Id: <20180207170800.15015-2-christoph@boehmwalder.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180207170800.15015-1-christoph@boehmwalder.at>
References: <20180207170800.15015-1-christoph@boehmwalder.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some problems regarding comment/whitespace style.  Mostly reported
by checkpatch.pl

Individual changes:
* Remove paragraph about writing to the FSF in GPL header
* Fix several spelling and grammar mistakes in comments
* Fix various misalignments
* Remove some unnecessary blank lines
* Adapt comment style to fit the kernel coding standard

Signed-off-by: Christoph Böhmwalder <christoph@boehmwalder.at>
---
 drivers/hid/hid-logitech-dj.c | 240 ++++++++++++++++++++++--------------------
 1 file changed, 124 insertions(+), 116 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 826fa1e1c8d9..530d10b5a404 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -14,14 +14,8 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
  */
 
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -53,13 +47,13 @@
 #define REPORT_TYPE_RFREPORT_FIRST		0x01
 #define REPORT_TYPE_RFREPORT_LAST		0x1F
 
-/* Command Switch to DJ mode */
+/* Command to switch to DJ mode */
 #define REPORT_TYPE_CMD_SWITCH			0x80
 #define CMD_SWITCH_PARAM_DEVBITFIELD		0x00
 #define CMD_SWITCH_PARAM_TIMEOUT_SECONDS	0x01
 #define TIMEOUT_NO_KEEPALIVE			0x00
 
-/* Command to Get the list of Paired devices */
+/* Command to get the list of paired devices */
 #define REPORT_TYPE_CMD_GET_PAIRED_DEVICES	0x81
 
 /* Device Paired Notification */
@@ -74,7 +68,6 @@
 /* Device Un-Paired Notification */
 #define REPORT_TYPE_NOTIF_DEVICE_UNPAIRED	0x40
 
-
 /* Connection Status Notification */
 #define REPORT_TYPE_NOTIF_CONNECTION_STATUS	0x42
 #define CONNECTION_STATUS_PARAM_STATUS		0x00
@@ -85,7 +78,7 @@
 #define NOTIF_ERROR_PARAM_ETYPE			0x00
 #define ETYPE_KEEPALIVE_TIMEOUT			0x01
 
-/* supported DJ HID && RF report types */
+/* Supported DJ HID & RF report types */
 #define REPORT_TYPE_KEYBOARD			0x01
 #define REPORT_TYPE_MOUSE			0x02
 #define REPORT_TYPE_CONSUMER_CONTROL		0x03
@@ -127,38 +120,38 @@ struct dj_device {
 
 /* Keyboard descriptor (1) */
 static const char kbd_descriptor[] = {
-	0x05, 0x01,		/* USAGE_PAGE (generic Desktop)     */
-	0x09, 0x06,		/* USAGE (Keyboard)         */
-	0xA1, 0x01,		/* COLLECTION (Application)     */
-	0x85, 0x01,		/* REPORT_ID (1)            */
-	0x95, 0x08,		/*   REPORT_COUNT (8)           */
-	0x75, 0x01,		/*   REPORT_SIZE (1)            */
-	0x15, 0x00,		/*   LOGICAL_MINIMUM (0)        */
-	0x25, 0x01,		/*   LOGICAL_MAXIMUM (1)        */
-	0x05, 0x07,		/*   USAGE_PAGE (Keyboard)      */
-	0x19, 0xE0,		/*   USAGE_MINIMUM (Left Control)   */
-	0x29, 0xE7,		/*   USAGE_MAXIMUM (Right GUI)      */
-	0x81, 0x02,		/*   INPUT (Data,Var,Abs)       */
-	0x95, 0x06,		/*   REPORT_COUNT (6)           */
-	0x75, 0x08,		/*   REPORT_SIZE (8)            */
-	0x15, 0x00,		/*   LOGICAL_MINIMUM (0)        */
-	0x26, 0xFF, 0x00,	/*   LOGICAL_MAXIMUM (255)      */
-	0x05, 0x07,		/*   USAGE_PAGE (Keyboard)      */
-	0x19, 0x00,		/*   USAGE_MINIMUM (no event)       */
-	0x2A, 0xFF, 0x00,	/*   USAGE_MAXIMUM (reserved)       */
-	0x81, 0x00,		/*   INPUT (Data,Ary,Abs)       */
-	0x85, 0x0e,		/* REPORT_ID (14)               */
-	0x05, 0x08,		/*   USAGE PAGE (LED page)      */
-	0x95, 0x05,		/*   REPORT COUNT (5)           */
-	0x75, 0x01,		/*   REPORT SIZE (1)            */
-	0x15, 0x00,		/*   LOGICAL_MINIMUM (0)        */
-	0x25, 0x01,		/*   LOGICAL_MAXIMUM (1)        */
-	0x19, 0x01,		/*   USAGE MINIMUM (1)          */
-	0x29, 0x05,		/*   USAGE MAXIMUM (5)          */
+	0x05, 0x01,		/* USAGE_PAGE (generic Desktop)         */
+	0x09, 0x06,		/* USAGE (Keyboard)                     */
+	0xA1, 0x01,		/* COLLECTION (Application)             */
+	0x85, 0x01,		/* REPORT_ID (1)                        */
+	0x95, 0x08,		/*   REPORT_COUNT (8)                   */
+	0x75, 0x01,		/*   REPORT_SIZE (1)                    */
+	0x15, 0x00,		/*   LOGICAL_MINIMUM (0)                */
+	0x25, 0x01,		/*   LOGICAL_MAXIMUM (1)                */
+	0x05, 0x07,		/*   USAGE_PAGE (Keyboard)              */
+	0x19, 0xE0,		/*   USAGE_MINIMUM (Left Control)       */
+	0x29, 0xE7,		/*   USAGE_MAXIMUM (Right GUI)          */
+	0x81, 0x02,		/*   INPUT (Data,Var,Abs)               */
+	0x95, 0x06,		/*   REPORT_COUNT (6)                   */
+	0x75, 0x08,		/*   REPORT_SIZE (8)                    */
+	0x15, 0x00,		/*   LOGICAL_MINIMUM (0)                */
+	0x26, 0xFF, 0x00,	/*   LOGICAL_MAXIMUM (255)              */
+	0x05, 0x07,		/*   USAGE_PAGE (Keyboard)              */
+	0x19, 0x00,		/*   USAGE_MINIMUM (no event)           */
+	0x2A, 0xFF, 0x00,	/*   USAGE_MAXIMUM (reserved)           */
+	0x81, 0x00,		/*   INPUT (Data,Ary,Abs)               */
+	0x85, 0x0e,		/* REPORT_ID (14)                       */
+	0x05, 0x08,		/*   USAGE PAGE (LED page)              */
+	0x95, 0x05,		/*   REPORT COUNT (5)                   */
+	0x75, 0x01,		/*   REPORT SIZE (1)                    */
+	0x15, 0x00,		/*   LOGICAL_MINIMUM (0)                */
+	0x25, 0x01,		/*   LOGICAL_MAXIMUM (1)                */
+	0x19, 0x01,		/*   USAGE MINIMUM (1)                  */
+	0x29, 0x05,		/*   USAGE MAXIMUM (5)                  */
 	0x91, 0x02,		/*   OUTPUT (Data, Variable, Absolute)  */
-	0x95, 0x01,		/*   REPORT COUNT (1)           */
-	0x75, 0x03,		/*   REPORT SIZE (3)            */
-	0x91, 0x01,		/*   OUTPUT (Constant)          */
+	0x95, 0x01,		/*   REPORT COUNT (1)                   */
+	0x75, 0x03,		/*   REPORT SIZE (3)                    */
+	0x91, 0x01,		/*   OUTPUT (Constant)                  */
 	0xC0
 };
 
@@ -314,16 +307,17 @@ static const char hidpp_descriptor[] = {
 	 sizeof(media_descriptor) +	\
 	 sizeof(hidpp_descriptor))
 
-/* Number of possible hid report types that can be created by this driver.
+/*
+ * Number of possible hid report types that can be created by this driver.
  *
  * Right now, RF report types have the same report types (or report id's)
- * than the hid report created from those RF reports. In the future
- * this doesnt have to be true.
+ * as the hid report created from those RF reports. In the future
+ * this doesn't have to be true.
  *
  * For instance, RF report type 0x01 which has a size of 8 bytes, corresponds
- * to hid report id 0x01, this is standard keyboard. Same thing applies to mice
- * reports and consumer control, etc. If a new RF report is created, it doesn't
- * has to have the same report id as its corresponding hid report, so an
+ * to hid report id 0x01, this is a standard keyboard. Same thing applies to
+ * mice reports and consumer control, etc. If a new RF report is created, it
+ * doesn't have to have the same report id as its corresponding hid report, so a
  * translation may have to take place for future report types.
  */
 #define NUMBER_OF_HID_REPORTS 32
@@ -335,7 +329,6 @@ static const u8 hid_reportid_size_map[NUMBER_OF_HID_REPORTS] = {
 	[8] = 2,		/* Media Center */
 };
 
-
 #define LOGITECH_DJ_INTERFACE_NUMBER 0x02
 
 static struct hid_ll_driver logi_dj_ll_driver;
@@ -343,7 +336,7 @@ static struct hid_ll_driver logi_dj_ll_driver;
 static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev);
 
 static void logi_dj_recv_destroy_djhid_device(struct dj_receiver_dev *djrcv_dev,
-						struct dj_report *dj_report)
+					      struct dj_report *dj_report)
 {
 	/* Called in delayed work context */
 	struct dj_device *dj_dev;
@@ -373,7 +366,8 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 	struct hid_device *dj_hiddev;
 	struct dj_device *dj_dev;
 
-	/* Device index goes from 1 to 6, we need 3 bytes to store the
+	/*
+	 * Device index goes from 1 to 6, we need 3 bytes to store the
 	 * semicolon, the index, and a null terminator
 	 */
 	unsigned char tmpstr[3];
@@ -408,8 +402,8 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 									<< 8) |
 		dj_report->report_params[DEVICE_PAIRED_PARAM_EQUAD_ID_LSB];
 	snprintf(dj_hiddev->name, sizeof(dj_hiddev->name),
-		"Logitech Unifying Device. Wireless PID:%04x",
-		dj_hiddev->product);
+		 "Logitech Unifying Device. Wireless PID:%04x",
+		 dj_hiddev->product);
 
 	dj_hiddev->group = HID_GROUP_LOGITECH_DJ_DEVICE;
 
@@ -464,7 +458,7 @@ static void delayedwork_callback(struct work_struct *work)
 	spin_lock_irqsave(&djrcv_dev->lock, flags);
 
 	count = kfifo_out(&djrcv_dev->notif_fifo, &dj_report,
-				sizeof(struct dj_report));
+			  sizeof(struct dj_report));
 
 	if (count != sizeof(struct dj_report)) {
 		dev_err(&djrcv_dev->hdev->dev, "%s: workitem triggered without "
@@ -490,33 +484,37 @@ static void delayedwork_callback(struct work_struct *work)
 		logi_dj_recv_destroy_djhid_device(djrcv_dev, &dj_report);
 		break;
 	default:
-	/* A normal report (i. e. not belonging to a pair/unpair notification)
-	 * arriving here, means that the report arrived but we did not have a
-	 * paired dj_device associated to the report's device_index, this
-	 * means that the original "device paired" notification corresponding
-	 * to this dj_device never arrived to this driver. The reason is that
-	 * hid-core discards all packets coming from a device while probe() is
-	 * executing. */
-	if (!djrcv_dev->paired_dj_devices[dj_report.device_index]) {
-		/* ok, we don't know the device, just re-ask the
-		 * receiver for the list of connected devices. */
-		retval = logi_dj_recv_query_paired_devices(djrcv_dev);
-		if (!retval) {
-			/* everything went fine, so just leave */
-			break;
-		}
-		dev_err(&djrcv_dev->hdev->dev,
-			"%s:logi_dj_recv_query_paired_devices "
-			"error:%d\n", __func__, retval);
+		/*
+		 * A normal report (i.e. not belonging to a pair/unpair
+		 * notification) arriving here, means that the report arrived
+		 * but we did not have a paired dj_device associated to the
+		 * report's device_index, this means that the original "device
+		 * paired" notification corresponding to this dj_device never
+		 * arrived to this driver. The reason is that hid-core discards
+		 * all packets coming from a device while probe() is executing.
+		 */
+		if (!djrcv_dev->paired_dj_devices[dj_report.device_index]) {
+			/*
+			 * ok, we don't know the device, just re-ask the
+			 * receiver for the list of connected devices.
+			 */
+			retval = logi_dj_recv_query_paired_devices(djrcv_dev);
+			if (!retval) {
+				/* everything went fine, so just leave */
+				break;
+			}
+			dev_err(&djrcv_dev->hdev->dev,
+				"%s:logi_dj_recv_query_paired_devices"
+				" error:%d\n", __func__, retval);
 		}
 		dbg_hid("%s: unexpected report type\n", __func__);
 	}
 }
 
 static void logi_dj_recv_queue_notification(struct dj_receiver_dev *djrcv_dev,
-					   struct dj_report *dj_report)
+					    struct dj_report *dj_report)
 {
-	/* We are called from atomic context (tasklet && djrcv->lock held) */
+	/* We are called from an atomic context (tasklet && djrcv->lock held) */
 
 	kfifo_in(&djrcv_dev->notif_fifo, dj_report, sizeof(struct dj_report));
 
@@ -529,7 +527,7 @@ static void logi_dj_recv_queue_notification(struct dj_receiver_dev *djrcv_dev,
 static void logi_dj_recv_forward_null_report(struct dj_receiver_dev *djrcv_dev,
 					     struct dj_report *dj_report)
 {
-	/* We are called from atomic context (tasklet && djrcv->lock held) */
+	/* We are called from an atomic context (tasklet && djrcv->lock held) */
 	unsigned int i;
 	u8 reportbuffer[MAX_REPORT_SIZE];
 	struct dj_device *djdev;
@@ -555,7 +553,7 @@ static void logi_dj_recv_forward_null_report(struct dj_receiver_dev *djrcv_dev,
 static void logi_dj_recv_forward_report(struct dj_receiver_dev *djrcv_dev,
 					struct dj_report *dj_report)
 {
-	/* We are called from atomic context (tasklet && djrcv->lock held) */
+	/* We are called from an atomic context (tasklet && djrcv->lock held) */
 	struct dj_device *dj_device;
 
 	dj_device = djrcv_dev->paired_dj_devices[dj_report->device_index];
@@ -567,8 +565,8 @@ static void logi_dj_recv_forward_report(struct dj_receiver_dev *djrcv_dev,
 	}
 
 	if (hid_input_report(dj_device->hdev,
-			HID_INPUT_REPORT, &dj_report->report_type,
-			hid_reportid_size_map[dj_report->report_type], 1)) {
+			     HID_INPUT_REPORT, &dj_report->report_type,
+			     hid_reportid_size_map[dj_report->report_type], 1)) {
 		dbg_hid("hid_input_report error\n");
 	}
 }
@@ -576,7 +574,7 @@ static void logi_dj_recv_forward_report(struct dj_receiver_dev *djrcv_dev,
 static void logi_dj_recv_forward_hidpp(struct dj_device *dj_dev, u8 *data,
 				       int size)
 {
-	/* We are called from atomic context (tasklet && djrcv->lock held) */
+	/* We are called from an atomic context (tasklet && djrcv->lock held) */
 	if (hid_input_report(dj_dev->hdev, HID_INPUT_REPORT, data, size, 1))
 		dbg_hid("hid_input_report error\n");
 }
@@ -626,7 +624,6 @@ static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
 	return retval;
 }
 
-
 static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 					  unsigned timeout)
 {
@@ -647,8 +644,8 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 
 	/*
 	 * Ugly sleep to work around a USB 3.0 bug when the receiver is still
-	 * processing the "switch-to-dj" command while we send an other command.
-	 * 50 msec should gives enough time to the receiver to be ready.
+	 * processing the "switch-to-dj" command while we send another command.
+	 * 50 msec should give the receiver enough time to be ready.
 	 */
 	msleep(50);
 
@@ -672,19 +669,17 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 	buf[6] = 0x00;
 
 	hid_hw_raw_request(hdev, REPORT_ID_HIDPP_SHORT, buf,
-			HIDPP_REPORT_SHORT_LENGTH, HID_OUTPUT_REPORT,
-			HID_REQ_SET_REPORT);
+			   HIDPP_REPORT_SHORT_LENGTH, HID_OUTPUT_REPORT,
+			   HID_REQ_SET_REPORT);
 
 	kfree(dj_report);
 	return retval;
 }
 
-
 static int logi_dj_ll_open(struct hid_device *hid)
 {
 	dbg_hid("%s:%s\n", __func__, hid->phys);
 	return 0;
-
 }
 
 static void logi_dj_ll_close(struct hid_device *hid)
@@ -714,8 +709,10 @@ static int logi_dj_ll_raw_request(struct hid_device *hid,
 		if (count < 2)
 			return -EINVAL;
 
-		/* special case where we should not overwrite
-		 * the device_index */
+		/*
+		 * special case where we should not overwrite
+		 * the device_index
+		 */
 		if (count == 7 && !memcmp(buf, unifying_pairing_query,
 					  sizeof(unifying_pairing_query)))
 			buf[4] = (buf[4] & 0xf0) | (djdev->device_index - 1);
@@ -740,13 +737,14 @@ static int logi_dj_ll_raw_request(struct hid_device *hid,
 	memcpy(out_buf + 2, buf, count);
 
 	ret = hid_hw_raw_request(djrcv_dev->hdev, out_buf[0], out_buf,
-		DJREPORT_SHORT_LENGTH, report_type, reqtype);
+				 DJREPORT_SHORT_LENGTH, report_type, reqtype);
 
 	kfree(out_buf);
 	return ret;
 }
 
-static void rdcat(char *rdesc, unsigned int *rsize, const char *data, unsigned int size)
+static void rdcat(char *rdesc, unsigned int *rsize, const char *data,
+		  unsigned int size)
 {
 	memcpy(rdesc + *rsize, data, size);
 	*rsize += size;
@@ -783,13 +781,15 @@ static int logi_dj_ll_parse(struct hid_device *hid)
 	if (djdev->reports_supported & MULTIMEDIA) {
 		dbg_hid("%s: sending a multimedia report descriptor: %x\n",
 			__func__, djdev->reports_supported);
-		rdcat(rdesc, &rsize, consumer_descriptor, sizeof(consumer_descriptor));
+		rdcat(rdesc, &rsize, consumer_descriptor,
+		      sizeof(consumer_descriptor));
 	}
 
 	if (djdev->reports_supported & POWER_KEYS) {
 		dbg_hid("%s: sending a power keys report descriptor: %x\n",
 			__func__, djdev->reports_supported);
-		rdcat(rdesc, &rsize, syscontrol_descriptor, sizeof(syscontrol_descriptor));
+		rdcat(rdesc, &rsize, syscontrol_descriptor,
+		      sizeof(syscontrol_descriptor));
 	}
 
 	if (djdev->reports_supported & MEDIA_CENTER) {
@@ -822,7 +822,6 @@ static void logi_dj_ll_stop(struct hid_device *hid)
 	dbg_hid("%s\n", __func__);
 }
 
-
 static struct hid_ll_driver logi_dj_ll_driver = {
 	.parse = logi_dj_ll_parse,
 	.start = logi_dj_ll_start,
@@ -833,17 +832,17 @@ static struct hid_ll_driver logi_dj_ll_driver = {
 };
 
 static int logi_dj_dj_event(struct hid_device *hdev,
-			     struct hid_report *report, u8 *data,
-			     int size)
+			    struct hid_report *report, u8 *data,
+			    int size)
 {
 	struct dj_receiver_dev *djrcv_dev = hid_get_drvdata(hdev);
-	struct dj_report *dj_report = (struct dj_report *) data;
+	struct dj_report *dj_report = (struct dj_report *)data;
 	unsigned long flags;
 
 	/*
 	 * Here we receive all data coming from iface 2, there are 3 cases:
 	 *
-	 * 1) Data is intended for this driver i. e. data contains arrival,
+	 * 1) Data is intended for this driver i.e. data contains arrival,
 	 * departure, etc notifications, in which case we queue them for delayed
 	 * processing by the work queue. We return 1 to hid-core as no further
 	 * processing is required from it.
@@ -854,15 +853,15 @@ static int logi_dj_dj_event(struct hid_device *hdev,
 	 * layer. Return 1 to hid-core as no further processing is required.
 	 *
 	 * 3) Data is an actual input event from a paired DJ device in which
-	 * case we forward it to the correct hid device (via hid_input_report()
-	 * ) and return 1 so hid-core does not anything else with it.
+	 * case we forward it to the correct hid device (via hid_input_report())
+	 * and return 1 so hid-core does not anything else with it.
 	 */
 
 	if ((dj_report->device_index < DJ_DEVICE_INDEX_MIN) ||
 	    (dj_report->device_index > DJ_DEVICE_INDEX_MAX)) {
 		/*
 		 * Device index is wrong, bail out.
-		 * This driver can ignore safely the receiver notifications,
+		 * This driver can safely ignore the receiver notifications,
 		 * so ignore those reports too.
 		 */
 		if (dj_report->device_index != DJ_RECEIVER_INDEX)
@@ -903,17 +902,19 @@ static int logi_dj_dj_event(struct hid_device *hdev,
 }
 
 static int logi_dj_hidpp_event(struct hid_device *hdev,
-			     struct hid_report *report, u8 *data,
-			     int size)
+			       struct hid_report *report, u8 *data,
+			       int size)
 {
 	struct dj_receiver_dev *djrcv_dev = hid_get_drvdata(hdev);
-	struct dj_report *dj_report = (struct dj_report *) data;
+	struct dj_report *dj_report = (struct dj_report *)data;
 	unsigned long flags;
 	u8 device_index = dj_report->device_index;
 
 	if (device_index == HIDPP_RECEIVER_INDEX) {
-		/* special case were the device wants to know its unifying
-		 * name */
+		/*
+		 * special case were the device wants to know its unifying
+		 * name
+		 */
 		if (size == HIDPP_REPORT_LONG_LENGTH &&
 		    !memcmp(data, unifying_pairing_answer,
 			    sizeof(unifying_pairing_answer)))
@@ -934,11 +935,11 @@ static int logi_dj_hidpp_event(struct hid_device *hdev,
 	    (device_index > DJ_DEVICE_INDEX_MAX)) {
 		/*
 		 * Device index is wrong, bail out.
-		 * This driver can ignore safely the receiver notifications,
+		 * This driver can safely ignore the receiver notifications,
 		 * so ignore those reports too.
 		 */
 		dev_err(&hdev->dev, "%s: invalid device index:%d\n",
-				__func__, dj_report->device_index);
+			__func__, dj_report->device_index);
 		return false;
 	}
 
@@ -999,8 +1000,10 @@ static int logi_dj_probe(struct hid_device *hdev,
 	dbg_hid("%s called for ifnum %d\n", __func__,
 		intf->cur_altsetting->desc.bInterfaceNumber);
 
-	/* Ignore interfaces 0 and 1, they will not carry any data, dont create
-	 * any hid_device for them */
+	/*
+	 * Ignore interfaces 0 and 1, they will not carry any data, dont create
+	 * any hid_device for them
+	 */
 	if (intf->cur_altsetting->desc.bInterfaceNumber !=
 	    LOGITECH_DJ_INTERFACE_NUMBER) {
 		dbg_hid("%s: ignoring ifnum %d\n", __func__,
@@ -1029,10 +1032,12 @@ static int logi_dj_probe(struct hid_device *hdev,
 	}
 	hid_set_drvdata(hdev, djrcv_dev);
 
-	/* Call  to usbhid to fetch the HID descriptors of interface 2 and
+	/*
+	 * Call to usbhid to fetch the HID descriptors of interface 2 and
 	 * subsequently call to the hid/hid-core to parse the fetched
 	 * descriptors, this will in turn create the hidraw and hiddev nodes
-	 * for interface 2 of the receiver */
+	 * for interface 2 of the receiver
+	 */
 	retval = hid_parse(hdev);
 	if (retval) {
 		dev_err(&hdev->dev,
@@ -1046,8 +1051,10 @@ static int logi_dj_probe(struct hid_device *hdev,
 		goto hid_parse_fail;
 	}
 
-	/* Starts the usb device and connects to upper interfaces hiddev and
-	 * hidraw */
+	/*
+	 * Starts the usb device and connects to upper interfaces hiddev and
+	 * hidraw
+	 */
 	retval = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (retval) {
 		dev_err(&hdev->dev,
@@ -1071,7 +1078,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 		goto llopen_failed;
 	}
 
-	/* Allow incoming packets to arrive: */
+	/* Allow incoming packets to arrive */
 	hid_device_io_start(hdev);
 
 	retval = logi_dj_recv_query_paired_devices(djrcv_dev);
@@ -1096,7 +1103,6 @@ static int logi_dj_probe(struct hid_device *hdev,
 	kfree(djrcv_dev);
 	hid_set_drvdata(hdev, NULL);
 	return retval;
-
 }
 
 #ifdef CONFIG_PM
@@ -1129,11 +1135,13 @@ static void logi_dj_remove(struct hid_device *hdev)
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-	/* I suppose that at this point the only context that can access
+	/*
+	 * I suppose that at this point the only context that can access
 	 * the djrecv_data is this thread as the work item is guaranteed to
 	 * have finished and no more raw_event callbacks should arrive after
 	 * the remove callback was triggered so no locks are put around the
-	 * code below */
+	 * code below
+	 */
 	for (i = 0; i < (DJ_MAX_PAIRED_DEVICES + DJ_DEVICE_INDEX_MIN); i++) {
 		dj_dev = djrcv_dev->paired_dj_devices[i];
 		if (dj_dev != NULL) {
-- 
2.13.6
