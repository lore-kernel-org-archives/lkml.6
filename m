Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtWZAPYQ35qpm4bV2Qsptg6b8Ouw1gZ3sFXQu1e7XUCK97JLWttRIBoskE9Zx5hX22anG7G
ARC-Seal: i=1; a=rsa-sha256; t=1521483714; cv=none;
        d=google.com; s=arc-20160816;
        b=ShBIr2NtyfsZMsHNxJfqAg+PfTjp91/wNCC9Vk6uIQ/0AZE7AnGyoVNenlp63VlbMF
         gdR0IRwAsslL3/e/YaOkK/+gShuGCAVAOHoDxpdCEetFXDCIB9/wXSTzii02pvmH6SFC
         QdQn6aC1vNjhdECLS+TDU2tcDVuUm40qfYvzS8vH3GwsUU79h4itX7QSuNuAinXkfzoa
         UwYySca9SA7E4fjilaEusauxxvaKbzeZHDVe04yCvfeiMbFxiiUSQv7dhd186on4oBi3
         +OgyYaRlH9EmzKTvrYa4k5HHi2JOpxVcAozQpNIdUUeJ5g14bcq3XSG10e0kxWRs0TTz
         OihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oiKnKUTUPFNPnG/kzAs9n4Jsdizeg6iGF8hKnvF65Pc=;
        b=za61i/YPcIjZJIdAhLG+sxXwjtlyvuEzSwHt8cygdcdYMIdOVkq3+OTYrBATDP/8oZ
         DnmtmSuw1hL9BASdxrXDn6SvEQ2sQha21CVaEDZM5acXA44XpXTMeZ+7MWaQJ3AYiNAx
         8zbJ6VHtuNbUten8bKeHPgflCQlFBtpgdAT+/MOtEJSfSX7InIC6r+ddeF/Dv3Ysgc+3
         iu7KyXe87yBXckAvEKtiZHsPUpYN54JZZvmdbcbXD+E8RsdnHZP5Mbie1tb0pGYMUXqs
         w+yHMSj0fVfu5TDD4Nvxb3t8mkIXsboT1mQt2XoZaCsAjK7CLcDDpjSSszEnA+VQFS+u
         Bkjw==
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
Subject: [PATCH 4.9 090/241] NFC: nfcmrvl: Include unaligned.h instead of access_ok.h
Date: Mon, 19 Mar 2018 19:05:55 +0100
Message-Id: <20180319180754.934089300@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390791667093020?=
X-GMAIL-MSGID: =?utf-8?q?1595391307643155311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
