Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225yVBb2t6z2iuQLp0ub6FUAxxaMRSqrstKBOBBA9FsX8784grS99HC3U/LZv5q3YwT/c02M
ARC-Seal: i=1; a=rsa-sha256; t=1517590902; cv=none;
        d=google.com; s=arc-20160816;
        b=j1RDlUmcW+zVmnEFTuxL0I/hDShegFWwktsJ2AORzdxBqW+mXlJYf04FCrCS4Y6qN6
         8kY0HrvihmffAR/hKZ6KCDVJG30ZnGpyworOD7UBdNng4m5iHYpRg746BAjWWlW6QK5N
         KY1+dRLu6CHIFBMazHEKHcIKzK8Dik2t5CvHRMqfMSaeNak1pmE159YOTQxd8NsfUezr
         OY1NRcHPmDbo78AldwmS6KCtRYem12aPi/uPUi+nkountNMEWvsrJiexslHubteup9V5
         +cEUdNq/+GJQKJK9ug4NzTAE7BSkWO3Su/UDATl9zwDWsx0PkHuVa1xrxbK1W2iKHuOI
         DABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NYEEVs7zP96e6c2lMp3kU49cVH1OuLh/IwAStBBPwR4=;
        b=ZKyS+wNuoe7OtJAmUu5PXSDnAW+EO8/9Ko9XjxG+rFa7dRronIw91Cc+DWAP3/AdFj
         lP7au6l98on9erLznUqbKIb6M/gbsCW4HpIeFSS+D+MdK9iQkeSWwpKODYlcVKcAqdoV
         iK9/LBrycDK3NbswaFRYebcC/0JNsvTCuybe0/IrHPcdKNs+NkhoCbHbemtoFRtCmElN
         PdHRjQ6BC4oH9iXKNjV65JvTWXouv7aXxt2oU0LVKD8bASEw9r1en0M6xUVUjOTEyxYN
         HRePkUut4qCu5n8LQuzluIDTeByhMfbttWQ+8ZXYAUvl4Bno/Kg/qc63V3REpJ0YefyP
         Om/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Icenowy Zheng <icenowy@aosc.io>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 52/67] media: usbtv: add a new usbid
Date: Fri,  2 Feb 2018 17:58:21 +0100
Message-Id: <20180202140821.103086181@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309398323406308?=
X-GMAIL-MSGID: =?utf-8?q?1591309398323406308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <icenowy@aosc.io>


[ Upstream commit 04226916d2360f56d57ad00bc48d2d1854d1e0b0 ]

A new usbid of UTV007 is found in a newly bought device.

The usbid is 1f71:3301.

The ID on the chip is:
UTV007
A89029.1
1520L18K1

Both video and audio is tested with the modified usbtv driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/usbtv/usbtv-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -127,6 +127,7 @@ static void usbtv_disconnect(struct usb_
 
 static struct usb_device_id usbtv_id_table[] = {
 	{ USB_DEVICE(0x1b71, 0x3002) },
+	{ USB_DEVICE(0x1f71, 0x3301) },
 	{}
 };
 MODULE_DEVICE_TABLE(usb, usbtv_id_table);
