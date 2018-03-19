Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtdySvDKc2fNagq3AFrE3KuOoycEGC+kuwrK+Q4i1Ub4DPzGFvJnbXqz3wMzdUIKqWoZitG
ARC-Seal: i=1; a=rsa-sha256; t=1521483222; cv=none;
        d=google.com; s=arc-20160816;
        b=Z+9EiQO4HPq2yDfxDyBJBbwlf7xKd2ZnXbm0Q0MYyLtwmcu6qDLDIExDBvSAIq37kS
         zJW8RbpIIrBI3X5sEhvAxioRQwshA6y3Ro+gFPAlaKRwREHo17WU2OB/9n+rFFYiz9ml
         viW669hBIut9FLa6E2JnQ0peCyMmAqENfP5dPTUSlA74VjI48jXYkSQySlv0rEfbllRr
         3LdOCFAO03qXuPg8jMa+AQq49oPtxWgDdpWkQPNNyfWc/KRMeZVQobHgD7nIG6oYOPMm
         6OWITjP82s2vqRmHHUOyw/+mehlGHoMH/aswomhIZJo7NqnM2lUp9r2Kj9ZnWrbwqQAg
         e0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Mh2HkyhudG/Qu17OeipN4bRXizBGlrdbOSQHjg2jTSQ=;
        b=tE0gLf1eZvRv/03c6OM6h2C+di75jLZf4lVErMPHDsM3/h5pgz+27urwbL/mj+fOGO
         ei0MAE6e+raP0SZrnUR2ngf7h4Lb+fWP3xS3hC0DHJVUSL1B7C2uvNIHePN5uegR/Ek0
         XRTbpPk/YkDd5miKqkrnZHt9xKGoxHYTV+/dvUyTE8n/Z5pwEfz0z0xPSZsXs3g4hycm
         +0wGMT01L6490PWaSUrYh9KY+xtZ+CyhX3O1XL+C4Ap543bH7BgysFhAim1k9HFtgz9W
         BHgNJq9pLhWQeG0fcho23srU4Chj/DFX8erUUzBOt0CrQU3Wg0MlZrH9uChM/AU3LErt
         epYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kbuild test robot <fengguang.wu@intel.com>,
	Vincent Cuissard <cuissard@marvell.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 045/134] NFC: nfcmrvl: Include unaligned.h instead of access_ok.h
Date: Mon, 19 Mar 2018 19:05:28 +0100
Message-Id: <20180319171855.867401530@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390791667093020?=
X-GMAIL-MSGID: =?utf-8?q?1595390791667093020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Klauser <tklauser@distanz.ch>


[ Upstream commit d916d923724d59cde99ee588f15eec59dd863bbd ]

Including linux/unaligned/access_ok.h causes the allmodconfig build on
ia64 (and maybe others) to fail with the following warnings:

include/linux/unaligned/access_ok.h:7:19: error: redefinition of 'get_unaligned_le16'
include/linux/unaligned/access_ok.h:12:19: error: redefinition of 'get_unaligned_le32'
include/linux/unaligned/access_ok.h:17:19: error: redefinition of 'get_unaligned_le64'
include/linux/unaligned/access_ok.h:22:19: error: redefinition of 'get_unaligned_be16'
include/linux/unaligned/access_ok.h:27:19: error: redefinition of 'get_unaligned_be32'
include/linux/unaligned/access_ok.h:32:19: error: redefinition of 'get_unaligned_be64'
include/linux/unaligned/access_ok.h:37:20: error: redefinition of 'put_unaligned_le16'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unaligned_le32'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unaligned_le64'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unaligned_be16'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unaligned_be32'
include/linux/unaligned/access_ok.h:42:20: error: redefinition of 'put_unaligned_be64'

Fix these by including asm/unaligned.h instead and leave it up to the
architecture to decide how to implement unaligned accesses.

Fixes: 3194c6870158 ("NFC: nfcmrvl: add firmware download support")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Link: https://lkml.org/lkml/2016/10/22/247
Cc: Vincent Cuissard <cuissard@marvell.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/nfcmrvl/fw_dnld.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -17,7 +17,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/unaligned/access_ok.h>
+#include <asm/unaligned.h>
 #include <linux/firmware.h>
 #include <linux/nfc.h>
 #include <net/nfc/nci.h>
