Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELusZz4PsgQWemTieNvIlxMTpXkA2UdgBjVwjVwqOCXstQzDsiOjTkSdkkdtYzT7tcSQX0XA
ARC-Seal: i=1; a=rsa-sha256; t=1521483919; cv=none;
        d=google.com; s=arc-20160816;
        b=EZ2wvm0QgChA5qpys1OBXcNC+AyqHBfFezmsfg+aXyF1Yoq/uEXfmbBdo5FpetmPfI
         9318sr/PDBz1D4n5r5AZkholEN0a7b31cfoRCgdEGOesINWncFq6Lun+bX3LcfzOEvYF
         nuG3wiEctY6qS5c8o8AFaT0H/Q6BOcqDb+QMAJyZ0bJ6vZcFagYoOwjBUUgo+bV8DCQ6
         Qldp0r3jp1VOIQRtFuATIdPCcWMFFPX8zG/7hizDnjU70nmiBfIluQ9WEM3tZFIJefYY
         ey2KsKaj02YCOw9nDuXdBQoHVTrVlFD8unZDEAxPTX4sU4U1/Su4M4MjTVlaq59cOSBQ
         TsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A7TL4Ln21idy2fMq2lWmaK7+3XyhxJzst7cFJ2OFgcM=;
        b=yjW05/lYoNLCpDnU5vD4zNAZmDqBXdni1TQHylet1IYXzpuy6ui62fb+C5IF5eon7z
         Fe/Hw8Ja52mYXA7rWkqD3quyyNAjNhT3ix59+PP+eb0ncMyf8l8ygDCLpTWIyqzMc9N5
         lhrVEz8nsGu31K3Tor3gK0A6z/mCwUG2nJjFFFiHcbDk4ZRjmK6oXwpFvS90DOVlyhlD
         2tEOgSaHT5ooCRiNna2cN+8AWcGPHnjclTA/lf+Og9OdpSstlqNFrC1wOzZOwJZaq0QD
         Ovr/rAy288tJ+d7WwOmjOt37f2gP1xDaCrAfHbiBsO7BNDHR3zrdNCycwZShE9KCvEVn
         C3Fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shashank Sharma <shashank.sharma@intel.com>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	linux-media@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 165/241] video/hdmi: Allow "empty" HDMI infoframes
Date: Mon, 19 Mar 2018 19:07:10 +0100
Message-Id: <20180319180757.993140301@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390990648022019?=
X-GMAIL-MSGID: =?utf-8?q?1595391522875413418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Ville Syrj‰l‰" <ville.syrjala@linux.intel.com>


[ Upstream commit 593f4b19a094c4426bd1e1e3cbab87a48bd13c71 ]

HDMI 2.0 Appendix F suggest that we should keep sending the infoframe
when switching from 3D to 2D mode, even if the infoframe isn't strictly
necessary (ie. not needed to transmit the VIC or stereo information).
This is a workaround against some sinks that fail to realize that they
should switch from 3D to 2D mode when the source stop transmitting
the infoframe.

v2: Handle unpack() as well
    Pull the length calculation into a helper

Cc: Shashank Sharma <shashank.sharma@intel.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-media@vger.kernel.org
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com> #v1
Signed-off-by: Ville Syrj√§l√§ <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171113170427.4150-2-ville.syrjala@linux.intel.com
Reviewed-by: Shashank Sharma <shashank.sharma@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/hdmi.c |   51 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -321,6 +321,17 @@ int hdmi_vendor_infoframe_init(struct hd
 }
 EXPORT_SYMBOL(hdmi_vendor_infoframe_init);
 
+static int hdmi_vendor_infoframe_length(const struct hdmi_vendor_infoframe *frame)
+{
+	/* for side by side (half) we also need to provide 3D_Ext_Data */
+	if (frame->s3d_struct >= HDMI_3D_STRUCTURE_SIDE_BY_SIDE_HALF)
+		return 6;
+	else if (frame->vic != 0 || frame->s3d_struct != HDMI_3D_STRUCTURE_INVALID)
+		return 5;
+	else
+		return 4;
+}
+
 /**
  * hdmi_vendor_infoframe_pack() - write a HDMI vendor infoframe to binary buffer
  * @frame: HDMI infoframe
@@ -341,19 +352,11 @@ ssize_t hdmi_vendor_infoframe_pack(struc
 	u8 *ptr = buffer;
 	size_t length;
 
-	/* empty info frame */
-	if (frame->vic == 0 && frame->s3d_struct == HDMI_3D_STRUCTURE_INVALID)
-		return -EINVAL;
-
 	/* only one of those can be supplied */
 	if (frame->vic != 0 && frame->s3d_struct != HDMI_3D_STRUCTURE_INVALID)
 		return -EINVAL;
 
-	/* for side by side (half) we also need to provide 3D_Ext_Data */
-	if (frame->s3d_struct >= HDMI_3D_STRUCTURE_SIDE_BY_SIDE_HALF)
-		frame->length = 6;
-	else
-		frame->length = 5;
+	frame->length = hdmi_vendor_infoframe_length(frame);
 
 	length = HDMI_INFOFRAME_HEADER_SIZE + frame->length;
 
@@ -372,14 +375,16 @@ ssize_t hdmi_vendor_infoframe_pack(struc
 	ptr[5] = 0x0c;
 	ptr[6] = 0x00;
 
-	if (frame->vic) {
-		ptr[7] = 0x1 << 5;	/* video format */
-		ptr[8] = frame->vic;
-	} else {
+	if (frame->s3d_struct != HDMI_3D_STRUCTURE_INVALID) {
 		ptr[7] = 0x2 << 5;	/* video format */
 		ptr[8] = (frame->s3d_struct & 0xf) << 4;
 		if (frame->s3d_struct >= HDMI_3D_STRUCTURE_SIDE_BY_SIDE_HALF)
 			ptr[9] = (frame->s3d_ext_data & 0xf) << 4;
+	} else if (frame->vic) {
+		ptr[7] = 0x1 << 5;	/* video format */
+		ptr[8] = frame->vic;
+	} else {
+		ptr[7] = 0x0 << 5;	/* video format */
 	}
 
 	hdmi_infoframe_set_checksum(buffer, length);
@@ -1161,7 +1166,7 @@ hdmi_vendor_any_infoframe_unpack(union h
 
 	if (ptr[0] != HDMI_INFOFRAME_TYPE_VENDOR ||
 	    ptr[1] != 1 ||
-	    (ptr[2] != 5 && ptr[2] != 6))
+	    (ptr[2] != 4 && ptr[2] != 5 && ptr[2] != 6))
 		return -EINVAL;
 
 	length = ptr[2];
@@ -1189,16 +1194,22 @@ hdmi_vendor_any_infoframe_unpack(union h
 
 	hvf->length = length;
 
-	if (hdmi_video_format == 0x1) {
-		hvf->vic = ptr[4];
-	} else if (hdmi_video_format == 0x2) {
+	if (hdmi_video_format == 0x2) {
+		if (length != 5 && length != 6)
+			return -EINVAL;
 		hvf->s3d_struct = ptr[4] >> 4;
 		if (hvf->s3d_struct >= HDMI_3D_STRUCTURE_SIDE_BY_SIDE_HALF) {
-			if (length == 6)
-				hvf->s3d_ext_data = ptr[5] >> 4;
-			else
+			if (length != 6)
 				return -EINVAL;
+			hvf->s3d_ext_data = ptr[5] >> 4;
 		}
+	} else if (hdmi_video_format == 0x1) {
+		if (length != 5)
+			return -EINVAL;
+		hvf->vic = ptr[4];
+	} else {
+		if (length != 4)
+			return -EINVAL;
 	}
 
 	return 0;
