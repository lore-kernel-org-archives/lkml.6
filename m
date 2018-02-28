Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELscIXoPps8F4XK3MSP69uTFwUEsmjCpaxQw7nf/wFxRdpxlag0UY7T1Pexh0Lpf/AN/v2VB
ARC-Seal: i=1; a=rsa-sha256; t=1519831345; cv=none;
        d=google.com; s=arc-20160816;
        b=pD8xajAqW7Uwm86/98gZHHFqLeYR7nTGQ7zRmcHy2hEths6XQAEJOA0UkDSMAlXdzQ
         BEb7CTWJ2z9x4Pf5Dxr364QJuvum3QBtH62wb+qYf/faG1Q63EtPp/BEZYXfcS19OAQs
         Y7UfXNvjSYL0O3gIMIW461IlPxGCCJCUrLu+VXEn0nE1xpx0sqyug8BejHCAnwuMRZAk
         co2Ehpp1qC44BJa2Ciro6IcYjsx/nhHrvcUlWrElXp76HIUCp05HLDN9D3XrQhee+lDX
         ouNO9sXJGeNky+F59ape6iXL7Ryay40BTIbjqBQZscsL1tbjuoUmDYCxH3G9e3jCpseE
         aAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=0aqxCRq9hXo16T6uFI+XDiQQZ7UxxVtBdm99yJByfyw=;
        b=1JboLoFscaZxALdOPB/eNOIXRM9o7RjceOiWnBT1Bfr4BbdF44Wxc6+G+rZHANgniS
         3K4rxBHLjKh86SYEnYMGxZhV9lNy5+I6IaGMAW6Udl2YC1UE/XHRt1DNZ6h06L4f4rjx
         fiDL7lkb4/+KbDBHIf8lfoDdWLbQ52MEXIDJHEiH3P/lDurOB4idjug9o9/21p3dVI7a
         kjkzVWUL4ymMAy1YeK0rYoL1lnOPVddpObW2CXIa1vGgjG4y6RCkQ/zzN+yw7BpgmCm5
         3SFjDMBSMyI9JGp34l5wuyNlgxrotTCVdG2v3ulljMrAXWSykvjQlSyMPINuKpYLntf3
         99CA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Oliver Neukum" <oneukum@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.464370818@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 131/254] usb: add RESET_RESUME for ELSA MicroLink 56K
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658665862784090?=
X-GMAIL-MSGID: =?utf-8?q?1593658672995707190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit b9096d9f15c142574ebebe8fbb137012bb9d99c2 upstream.

This modem needs this quirk to operate. It produces timeouts when
resumed without reset.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -151,6 +151,9 @@ static const struct usb_device_id usb_qu
 	/* Genesys Logic hub, internally used by KY-688 USB 3.1 Type-C Hub */
 	{ USB_DEVICE(0x05e3, 0x0612), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* ELSA MicroLink 56K */
+	{ USB_DEVICE(0x05cc, 0x2267), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* Genesys Logic hub, internally used by Moshi USB to Ethernet Adapter */
 	{ USB_DEVICE(0x05e3, 0x0616), .driver_info = USB_QUIRK_NO_LPM },
 
