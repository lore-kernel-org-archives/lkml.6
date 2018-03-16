Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs0Vejjt1oVlZ0QziTy7pPr0QRhAnSXFEHmXFLq9c6zojT/axeyt5c08qLe7OeHmQ/+gJzZ
ARC-Seal: i=1; a=rsa-sha256; t=1521214580; cv=none;
        d=google.com; s=arc-20160816;
        b=WJrEjGxoaMb2/NTl4beGFQdsIT6TMPGS1kNb2I/yKXaJKnoIr/ikegd+hJeE/orMv+
         KHUQIMKCGEO68j907zUw09un82Db8PLa0xDa8UYqQCUPCpKrH5UA38T/T2FFi3fJExpy
         TqgNYxuCuH6ovRCTscArNRTcvp19d/WSh6ecWfxMHLz4OpQin5fdQpjXXAEj7JOvCP9+
         3avU2SyX9aU7wmbast2xvt40KmhpU6lTLdR43yNvts5JZ5WhDt3uXNwyn1V7/Etgds5c
         17WZ0PPTV6JZKswROKHrQmya4FNLHf50A9L2k3DpHJP5xGNmeOpOxUN3Ax2LWLvaBi9E
         HiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pJ2mSn7oJJdCl5djzxAmWf/7xiXsDeNToVKB/E0m+oc=;
        b=B0y745BUuhWBN5F7my9nRzK8S0SGbk3gLxU3sG8E2A3DATfPIQp6noBV1z8NE+pI/q
         S/DT87c5fkAOH01p0PjiF6+xau9u2y4V9pWxYFC8IbEcMbZkCui9kAwEdXcY28k6Apq9
         Es+gVWsMBNTK6KrSrDuNdyCOgOeCuRKnZhOdFvNlcHGX1PNiAn+Vmu1gt+19mULqFrXQ
         pj9X+YyHayTN/jav+JIUTsPzG53kh/hUxe3MKKoZCylm9PW2J/WBf36nosgeBIXtJz20
         3xpo2Bipdg/a+aXCkiHIEUVKr2fov6rvli39DxXD1xNO8Jx4wNAUenQ4FmsRce2zV0iX
         xP6A==
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
Subject: [PATCH 4.14 029/109] video/hdmi: Allow "empty" HDMI infoframes
Date: Fri, 16 Mar 2018 16:22:58 +0100
Message-Id: <20180316152331.550240207@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109099207244373?=
X-GMAIL-MSGID: =?utf-8?q?1595109099207244373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1165,7 +1170,7 @@ hdmi_vendor_any_infoframe_unpack(union h
 
 	if (ptr[0] != HDMI_INFOFRAME_TYPE_VENDOR ||
 	    ptr[1] != 1 ||
-	    (ptr[2] != 5 && ptr[2] != 6))
+	    (ptr[2] != 4 && ptr[2] != 5 && ptr[2] != 6))
 		return -EINVAL;
 
 	length = ptr[2];
@@ -1193,16 +1198,22 @@ hdmi_vendor_any_infoframe_unpack(union h
 
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
