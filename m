Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpdu0KBorCf9KWetmhIJn6pK2NqoJIaSzRQfVBkUnxppXyrQ7bDHjv8AE3M/I90gku32TFV
ARC-Seal: i=1; a=rsa-sha256; t=1525116480; cv=none;
        d=google.com; s=arc-20160816;
        b=0YPRNNFMRiDP7rDCHnFP7NpSaT6lHinUPvbAlcQLSM0hffVA4U+PH+JJXK/TI81nYQ
         1NUrS1semuIkKiLiBsWFZtVPmHZUY/9q9pWJ0WV0XXhL+Yw/rZGpTnEDRKOeeX99dqXK
         S4YCAUX3GR7NarRGhmQrRBwKLDjONtxTggdXsPjmIkGOutPlKw9GuxrNcRq+641DwJX2
         BrZaYppNxaa/hyxOzZ0rTm70MOdwzg7rr9LTKFFYG3BkIegrBQp3hnxhZ+nt06W/yhct
         lLCE8qSGrQue1CQFOimDEOSrjHkycDYxUxhj419R6nVVD+NjGi1FJa7fwDuWvctE4xgY
         uOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=AG2t1M9CRYlNRMO0qJDqZqavFQpzuKf7AbbLugNPDVM=;
        b=tHuSdBYrUHEjBdEVJen8AK5UYX39vdl08TAbI/91FPqalaSLnH9Xz9W8Pzi5US+0tt
         vAyfSH5YqxYMgXUK8rJr8eVkuZTnDm9whHzVjISnFPCkx6XZzshEKtSE8Mhx+Rh0y1Qh
         EWFmtjDxHeUlPU75lJiLkr2ZxwAZhNOr5MHXnKe6SSwOD2Hr28X4p7XKMeRgAW20slql
         5aVLy2KJMfyUV8IFuaOMp/YAIE59K1vU85UxWQsqYMYf5tMxkn8v9bxeDuHDH962Hslu
         vN7nzv0NPS35yOX5HiXT6y9r1TrNJaW9spB5A6edDhGHTrq5ZSh30Pe/oeXmFwatSJP9
         6P1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A7922DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamil Lulko <kamilx.lulko@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 4.16 021/113] usb: core: Add quirk for HP v222w 16GB Mini
Date: Mon, 30 Apr 2018 12:23:52 -0700
Message-Id: <20180430184015.973229828@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200291962669964?=
X-GMAIL-MSGID: =?utf-8?q?1599200539054260995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamil Lulko <kamilx.lulko@intel.com>

commit 3180dabe08e3653bf0a838553905d88f3773f29c upstream.

Add DELAY_INIT quirk to fix the following problem with HP
v222w 16GB Mini:

usb 1-3: unable to read config index 0 descriptor/start: -110
usb 1-3: can't read configurations, error -110
usb 1-3: can't set config #1, error -110

Signed-off-by: Kamil Lulko <kamilx.lulko@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -40,6 +40,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x03f0, 0x0701), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
 
+	/* HP v222w 16GB Mini USB Drive */
+	{ USB_DEVICE(0x03f0, 0x3f40), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Creative SB Audigy 2 NX */
 	{ USB_DEVICE(0x041e, 0x3020), .driver_info = USB_QUIRK_RESET_RESUME },
 
