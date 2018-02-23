Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2273KBAJXXJsFqCZu05AMANpo8EjV3fFtHk3ArBF8CAYAz6SBOlZNrcOB9XFur+oMjgRmP3i
ARC-Seal: i=1; a=rsa-sha256; t=1519410998; cv=none;
        d=google.com; s=arc-20160816;
        b=lPZZFk24BYLKUYIwVfWVqCli5osqcCd/8c+4jouXtKJHfRP5CRx3Noz0dYxShbVPQf
         gwRmFwx7r4OrGSsYlA71qcMv9M70jNq2SAADAIS5p312Z56FHD7/Rynf8NZWiHnxXD8o
         yf3O3+pXqO5z5fuzkcPjyzxD4TAyIULSWyePZpRfOgcw69uLfaYlSee9FkWufDKiATUy
         TseHXHPuOk9gBooBZCe1Ft4kRkHkBdLP7P6P4pG3tv6sdKseXgRx4UAbRDQciwNj3T8Q
         z+uX3nb2WDSA4TVooC9fhB8p9vNp4zfmEZqUylFJEqeXRs+p6U0AV5Mk6KsRrtnmEJvh
         Pntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b6g0MjW5z8RgS+rT64HfVNwIP4ATOSgaA3tPbrqTraw=;
        b=reui68RdiRvgSeKGRGYR4GBPO/fkO+9EYsJtGetMT469NZkASb1XW2+Vfr8qUJ9HJD
         3UVG+/VFf3y2uW9xhdKjd/XHlnrrX0uWlLhiBlkxcJP8Y0cR6auAwexA3JPMsWxM3gre
         rXxr8fgg32jBurv9aAuuLO+mE8N/NxEscMquaEGZLUJynnCpONVn5KfUe2C2AhBUARvJ
         7LLaG9Q1uRZGznUls6hnKITnyNAMSTXmE5hlXFYsCAg+9bcnuD18g7lCLyf0uucjE91J
         /nQlcUbtXraVfQGQ5phJFleaF6u2R//o321Gj9ouOzOUkHOobRG8qgs/W9TETUznIeWx
         In8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sudip Mukherjee <sudip@vectorindia.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 086/193] dpt_i2o: fix build warning
Date: Fri, 23 Feb 2018 19:25:19 +0100
Message-Id: <20180223170339.568458230@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217907193505454?=
X-GMAIL-MSGID: =?utf-8?q?1593217907193505454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit f50abb9b63b1d8773e1ce32115701c06416e6f91 upstream.

We were getting build warning about:
drivers/scsi/dpt_i2o.c:183:29: warning: 'dptids' defined but not used

dptids[] is only used in the MODULE_DEVICE_TABLE so when MODULE is not
defined then dptids[] becomes unused.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/dpt_i2o.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -180,11 +180,14 @@ static u8 adpt_read_blink_led(adpt_hba*
  *============================================================================
  */
 
+#ifdef MODULE
 static struct pci_device_id dptids[] = {
 	{ PCI_DPT_VENDOR_ID, PCI_DPT_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{ PCI_DPT_VENDOR_ID, PCI_DPT_RAPTOR_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{ 0, }
 };
+#endif
+
 MODULE_DEVICE_TABLE(pci,dptids);
 
 static int adpt_detect(struct scsi_host_template* sht)
