Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224yvTLvmhI4FmxnBTo/sLbJarsr+4wUBOR7syGeqMXn4kTJQnSsSivuN0BXFUpTectWeYND
ARC-Seal: i=1; a=rsa-sha256; t=1519411131; cv=none;
        d=google.com; s=arc-20160816;
        b=JwVOpdUwaacWp7MFDlBt9uiHNkBQBGL9eZhVFz/JNX7r81KM3bIFVko8Br6Gz0PAg4
         gb1x/Y3UqwKbc+gcnV3J/L4NOCkulN5kYh5IQLhzoL1QuXkQRLq+XUtvYCoiIW5C5APJ
         ExM27eI3Z6pVjzqMS742AOlSAFBr/zitGNCxJupCH+mk0X3SRsXQKlzbvjw6+6riDe6M
         ZRKsrnD9qf9kR7KLgMvd0NcUQJpwy4WvzOBlTaz2Mp19KZZGvZ5eBivO0ksNCHLoILsg
         wqZpV+Eh9lk1zfv2wbGtbNxNXzKZS9nv8M0jgCVGxUjXNBsl43jHEuyf/HlvDqzIHn7e
         JaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QkcxbfOr/ThANRBUI0+gaz85WssDHxZq2IypOXYRXaQ=;
        b=C1yOAG6RZHaULhT63ObCdfdnvwBQeWvD0uAY22ajotHMo/cjxGvqoJ7nGcfHaHR/O1
         8SQdwHna6iGB8ssJwjF3wegZOuZXD02Ji2E7oNoXfw8Tr0RaFcwJwTCBi43YRJdXlMgn
         myq7LkUpF5AJTqJwwBZJtB1ZX/whwY27yR0FMd0Xjo3brVzPdIWbKJG+vZ5nUgkwgxPt
         C9Sy3MgSvY5yjK1cQxSj7HqXNCUE+XGREYrc3Pg7cHjhrIDAFFQ078fhZNGbkcFPlMKg
         f/WR0l2t0dXxVkuPFZwe+YwVWnHP77AJhhyWN69WAqEWp/FTxTtEp1/mbmxmACvP9Qk6
         r7iw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kbuild test robot <fengguang.wu@intel.com>,
	Glen Lee <glen.lee@atmel.com>
Subject: [PATCH 4.4 115/193] staging: wilc1000: fix kbuild test robot error
Date: Fri, 23 Feb 2018 19:25:48 +0100
Message-Id: <20180223170343.908482739@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218046863650995?=
X-GMAIL-MSGID: =?utf-8?q?1593218046863650995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Glen Lee <glen.lee@atmel.com>

commit b22fa80cdbf4ff1056ecddb4efdcc0ede5f5f422 upstream.

This patch fixes build warning and error reported by kbuild test robot.
It is fixed by including netdevice.h.

>> drivers/staging/wilc1000/wilc_wlan_if.h:940:27: warning: 'struct net_device'
 declared inside parameter list
    int wilc_wlan_init(struct net_device *dev, wilc_wlan_inp_t *inp);
>> drivers/staging/wilc1000/wilc_wlan_if.h:940:27: warning: its scope is only
 this definition or declaration, which is probably not what you want
>> drivers/staging/wilc1000/wilc_wlan.c:1954:5: error: conflicting types for
 'wilc_wlan_init'
    int wilc_wlan_init(struct net_device *dev, wilc_wlan_inp_t *inp)

Fixes: 30135ce ("staging: wilc1000: wilc_wlan_init: add argument struct net_device")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Glen Lee <glen.lee@atmel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wilc1000/wilc_wlan_if.h |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/wilc1000/wilc_wlan_if.h
+++ b/drivers/staging/wilc1000/wilc_wlan_if.h
@@ -12,6 +12,7 @@
 
 #include <linux/semaphore.h>
 #include "linux_wlan_common.h"
+#include <linux/netdevice.h>
 
 /********************************************
  *
