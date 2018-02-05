Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ZgJU2sHNUoa+LHJRQk7P94nZTCZ5ZaoH5wBKi9N3CY90eiOOZuhl5JNm0OP33KkCKC8dh
ARC-Seal: i=1; a=rsa-sha256; t=1517855199; cv=none;
        d=google.com; s=arc-20160816;
        b=tqGKnV/k3E2y0BiOX2kZykRfzNr0SjlSqhfMv0MMYoP0Ziqc2arYhy+eXuTvSrIew2
         umbWXw+20DYDAppsXXIJrKrZU1gMWPLnYAXPQgTGSboG2bdTAYl64rETwk+1Uqys9eo1
         qgkfmsV0dNe4Aaip6gPOuN7b2gaKAz4OLiwal2DeqbzbQjNrx1n17pk7bmNLE2olpUra
         Eq36hOri6FuY9W7rGW2DwZ/NweclVy7Wjo7ZkJ7xKUFdstW1dGPVdG8FbH9fI3ReKqxf
         dimWUou+QVXZND5Ko3IVK5g4W5cdfpK4SOvOoZaCgUkSybiTx5W2vPflNyhTnVzigVsk
         2mZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4nfBtmBjo+wWFFlagVE9Mko577TjbW5qVc2yOmsEXQ8=;
        b=oLmpEsF280LvoLZpKS8NnN/C58MBDWDpwOtYIHBOLwkva0ygkoCb7RgmyFsVMCXJUM
         qIof4+kWkHF9nEEOe5Qxcrrx4U1/qo/mAfJlzqXE93blNt0P9nO/xQWLnrZcoZ58cYq7
         J5tVU+6P3f9ix9wAiSjHKPBBpLdMIx5er1vcYgNH+0DML01954gpHSsy/LeBrIjCu+SB
         mQXiAWrRc/jp8fjioiOA2YM5kpw9VMoLTDOCksplKEhfb4+liyFL0+TN8Iq3YAijpQlA
         vqONacvMGyrscmu+36a3+z9tKqczO4jAcXgGSWG6pjYX3/MKtpJTWWXpvJMMT5HcJtVy
         Hgfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Icenowy Zheng <icenowy@aosc.io>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 22/36] media: usbtv: add a new usbid
Date: Mon,  5 Feb 2018 10:23:50 -0800
Message-Id: <20180205182352.685325588@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586533859693591?=
X-GMAIL-MSGID: =?utf-8?q?1591586533859693591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
