Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsOHofL50rhNKwC/+g9YSbWm+B0cRCRL9AHyrLsjBXEVTgf+j6SIX8kLLihHRTKOnwb9dxY
ARC-Seal: i=1; a=rsa-sha256; t=1521214398; cv=none;
        d=google.com; s=arc-20160816;
        b=b5HWtgfIjy3tgCXPkAt35cByvkKvOh5xl1n/W6g/PmTR9tPbi87+MJh3NG+CXwyPXZ
         zTXmdWXmu9+9sWrlbvaLN66N7dscNYukodKlJRPY/3Oc4NovYfcLHIl7p9nKh3G51Fj+
         IJ5pGe2iP6h6K3MBcpCrNSWaeB7JoDqUmI29hjLeMo7tsl3Jt5nIt1k4X0ATZJ4MEb+u
         GrETZUViy0uKRZE5RE8REjdaRdK6l9DvaA3mjElifCe67JnTjgCb+GZeJGrasKM68Xfz
         4F+nLK8YjHc5AjyiPz65NTZjax8PICFPsR42uh0JSqkQnpbMQXX/KtpNId9wFJvQgsUJ
         b0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JdUsJxq1E9CR94sOrWPOqGg2mI7NVLDQBHfP2AR8p1I=;
        b=ChOXdjHyqBv+eGIYjUuuWHPHEBPkn9Hg7CUyOgr6NjONDhnvwmCZbjbLaKK3rcjDjY
         /m1megqWVlqI04nNF+5aBeahVIPzl4ZQyFA5HqYXIJweRaWPppjT9z1j8MA9eclxtXkp
         AE2mRyK0aDldMpzPKBgjJSAQp7CtvO8IxbTrbv0sxnI0FdwdNpIWOBEtravf74SKGDue
         3lZ6A+YWkZKsRGkwHBUp4MSC39qJ5H6EbCBaXY3speAMxwE91xYlNCRyBQJF1ErUN5Bw
         v5MFdXzqwMMQbh1+gyhuVdVuGAbm+PeAwD4V0EFEorT6TavbuaaZ8YHDlNDCqg6ZeeIt
         Elgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Teijo Kinnunen <teijo.kinnunen@code-q.fi>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.9 78/86] USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h
Date: Fri, 16 Mar 2018 16:23:41 +0100
Message-Id: <20180316152322.592927108@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108644866552778?=
X-GMAIL-MSGID: =?utf-8?q?1595108908617463655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Teijo Kinnunen <teijo.kinnunen@code-q.fi>

commit 5126a504b63d82785eaece3a9c30c660b313785a upstream.

This USB-SATA controller seems to be similar with JMicron bridge
152d:2566 already on the list. Adding it here fixes "Invalid
field in cdb" errors.

Signed-off-by: Teijo Kinnunen <teijo.kinnunen@code-q.fi>
Cc: stable@vger.kernel.org
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_devs.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2137,6 +2137,13 @@ UNUSUAL_DEV(  0x152d, 0x2566, 0x0114, 0x
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BROKEN_FUA ),
 
+/* Reported by Teijo Kinnunen <teijo.kinnunen@code-q.fi> */
+UNUSUAL_DEV(  0x152d, 0x2567, 0x0117, 0x0117,
+		"JMicron",
+		"USB to ATA/ATAPI Bridge",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_BROKEN_FUA ),
+
 /* Reported-by George Cherian <george.cherian@cavium.com> */
 UNUSUAL_DEV(0x152d, 0x9561, 0x0000, 0x9999,
 		"JMicron",
