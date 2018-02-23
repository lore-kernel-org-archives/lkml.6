Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2255AV0OJQpJJsZzN9tBj1gE4QgOoaBFhJVayZjyuOi0aSxClDp0VSfCRFhCuVEGwc5rXRhm
ARC-Seal: i=1; a=rsa-sha256; t=1519411157; cv=none;
        d=google.com; s=arc-20160816;
        b=Q/gru17Z/sEjqausKKS6EmVqe6n5FgG6SUxPrI3a4aBuOiBf2PC19sYtyaZEyQtm6L
         AyMstuj3hM98y+DOccRhjaEtGklZfYcWEEyjcVx21O/mJwe3eVeaILv4UP5D85FIBKWT
         KwK7WWz/8SWv6Nys+OYZLweZv2mrzaWtsMFVApLCU3gNvDQyGWS2ADn7QRcLjxY0opKG
         9mhMMG8/Um60p0eYXNC8m/vP32IaOSQ+6bNw1EKSoepSgQe+UuhSKTflrf3+fnIbdbhj
         kldzEYMlWFakQt3QNgZiCA1Mf1nyubgNPSymdeOG6zyRR4qiJF8fWAoDjs3yIJjKaxbA
         Rd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PScSqdmxyGvx3SX5suoaJeQU0F2t9BLOPcC5a8TXbY8=;
        b=PxmHo/jvwdHg/EaAemvmhFqIyvpU/i9zKy/U9rE2sF/gltZ3S9baGnDXw1P4rJHLFU
         pOjAKMShTZCCHuJ122iLAhsP96nKxHfcRmZ/8HaCt5gzaehHphzhKUxDBuYUjucH07HQ
         au0ZBRk+T3FaEkrEeupDeg6NgTTPizjwP59O/D53CUBi65DquFpFj/9UsR8vCfcaW4li
         1mgUk8SmRayE0TPH2if3Ij4rBEOlUjjkQo5LPxuOT4DgHaUf2+o3G/SHeW7/g1oWQ0ae
         i0REG1b1BR25WFs/6ohwIymP1rnTIFogRfpjGNL+nYND0jZKfcYGtX05rcVj0jNbXkob
         ygjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH 4.4 140/193] [media] hdpvr: hide unused variable
Date: Fri, 23 Feb 2018 19:26:13 +0100
Message-Id: <20180223170347.768919081@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218073839196180?=
X-GMAIL-MSGID: =?utf-8?q?1593218073839196180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b97baa3e22e18dac42001e665cf27ad1211bf878 upstream.

The i2c client pointer is only used when CONFIG_I2C is set, and
otherwise produces a compile-time warning:

drivers/media/usb/hdpvr/hdpvr-core.c: In function 'hdpvr_probe':
drivers/media/usb/hdpvr/hdpvr-core.c:276:21: error: unused variable 'client' [-Werror=unused-variable]

This uses the same #ifdef to hide the variable when the code using
it is hidden.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/hdpvr/hdpvr-core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -273,7 +273,9 @@ static int hdpvr_probe(struct usb_interf
 	struct hdpvr_device *dev;
 	struct usb_host_interface *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
+#if IS_ENABLED(CONFIG_I2C)
 	struct i2c_client *client;
+#endif
 	size_t buffer_size;
 	int i;
 	int retval = -ENOMEM;
