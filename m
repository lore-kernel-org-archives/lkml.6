Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZozolr6ncnCCg3N8bkgxxhUwFakrgwmHkWEydCRKwT1eA3asN7aAaciib8EcgUUC2Mh4nQD
ARC-Seal: i=1; a=rsa-sha256; t=1525116378; cv=none;
        d=google.com; s=arc-20160816;
        b=ptggSRdbzt5tuT/E+Z6QrZm5S5ipE/M9EKaan2KSezowq9sFX2aGQ4huITVRsYy5qz
         hJeZAs/ox4eMcx0sDahkN+fJtp+832xGiEclBMLUz1J5+/2FmyQAx96x8a05AFOLBgxl
         YnZIP1VbyGeiO5Og+qtmuVMgcxs7ZDTdc3g9X5UTZEMXHriroVn2FrgLUpyRlTpQP3HY
         bhHhDlCM0xgxeRvoBq8oSpp3t/dW4D7bzfFlt4c7bCQdboeKP2VFPwoSIen4sl5uoPzv
         eTXg6pbQiQ3Xaje1fPicvC9zks3w3qsQkY4A8mk/cPMmNEELauug0/vGLntTA7tj1Lff
         sjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=axahxGLTgHHqFUrJvmtJTVAY57fwH/abmLrwHhAYSPU=;
        b=m3Hd6G8mV27+vNtx9VD9LLfgoWhMfQntqScvb2Gk6M2KUr+4PqywYZyA3U1CUTtDmi
         xBdsX8eR1MeIncALuJ7zujJ+IMBHmS8T2YtBWYwbVrJa3fNUz+sRED8bardAJNeqSm0/
         ra8bMNn0k7fPPX0d5HRMSqD3Z62nqpL/yO3XIhVD0+Vdr6KLQRSuOjrA1/SXFx86HXyE
         a4R2oo9nou1Gm5ody1HN3o9ormIiTxensJ0IaYlID+IoVhTjIc7RoMJWIsCZYMYCutJX
         AnNzKrzEPCCD9HiD6eINrT5xFlQRGjVjyRe6E9UbgJ1J6+Ix+6ZwpPpZ8MHm1jiqgkb1
         7sFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C5122DC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kyle Roeschley <kyle.roeschley@ni.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 13/61] USB: serial: cp210x: add ID for NI USB serial console
Date: Mon, 30 Apr 2018 12:24:16 -0700
Message-Id: <20180430183952.363046666@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200291501783641?=
X-GMAIL-MSGID: =?utf-8?q?1599200431126899894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Roeschley <kyle.roeschley@ni.com>

commit 1e23aace21515a8f7615a1de016c0ea8d4e0cc6e upstream.

Added the USB VID and PID for the USB serial console on some National
Instruments devices.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -211,6 +211,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x3195, 0xF190) }, /* Link Instruments MSO-19 */
 	{ USB_DEVICE(0x3195, 0xF280) }, /* Link Instruments MSO-28 */
 	{ USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
+	{ USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial Console */
 	{ USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
 	{ } /* Terminating Entry */
 };
