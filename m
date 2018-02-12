Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x224SYJnWPZvlnDZRYQsTqDKY955hKC3zjCkOJsLx02KrQN9gGkT49qulApLHVQjPf4dHVg8P
ARC-Seal: i=1; a=rsa-sha256; t=1518395677; cv=none;
        d=google.com; s=arc-20160816;
        b=v/HPTkOheFhFKFzz3obXw04ulG7Lkp5+B1sHc0vGrAiB5LpaxE0bV3NRfRZMi2FSFT
         ORKUG+vobLI/GBR+7SaKOnzmKrk/O9YOrTSFG2cgvHuyeC1TLBmUpE+UshIDhVdqoLGQ
         vcVwqk2wN/9b9qarZfDxxrLG/QVEfesQbnmk5NgnZ+I568fuwVXOo1uTlh0PbUqHx/hg
         irf1Ach2PS+3tCYVSyQdJNiz/SAFlwysRU/8Ex6Y2o+y5Z7TaNktl46JEa1s+y+HywXQ
         pWUGqcUtuaZTbPhjjzSsHRnxFnrZD5PP7fzgAXQ7HcNdpyFq4nG08gnXExmQ64ZUgxFx
         LNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=+/GgxZnFIgacNqJ88LemCh+O42g5A0Glo1muLKTt2W4=;
        b=Xg9xGZUQvUMvAehKxHPSCI8492ldjN1Q21lEPjs3quR2GC42DUGBBDeviRGPz9ioS/
         PNX6dablNXxgJPWfHHO0CCX9RERy39Ri7vQZ5EbvdrL0MAooF3BOl0XjRb1vIP+2GKm7
         cqaJf5CjfPRAVgDIjUaZp8Ffo+1dNRVkg20cpKLFfOZSncfjIh1DI84LP/hYG0SdKML+
         qV6uZytdH7ELdFCuVnYh2Wlekost9PT3KnFpD3Zy7+Rz3dmnWf0kEW4E0eB3zw7/4HYu
         2rWC0zxRXXTPtPR1I/qsHwmnnz7gMwKfoLf/saBrlfN68rgfUxo8z7Ks9xUvzgNsh/1y
         0hZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 05/12] tools: hv: include string.h in hv_fcopy_daemon
Date: Sun, 11 Feb 2018 17:33:13 -0700
Message-Id: <20180212003320.6748-5-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212003320.6748-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfHWyA3bWQpJbWP7paxsWZ4WiegLdr/MCrqMhpnf7IdDAdEuAh6/GiOfoWsqrWthZGN1Q6iHsE4nVKVe2t61vUyTUCdWp7KO9aUtm4q3xEZB1IdJQoC0D
 2oTVvnveXmhDvGMxe6D6fuzerbUchQHVpcunCNRdpeZyU4xBkwQ1/yGrRC8klBUXRdnaYXW0vZQPqfRhGjaT1oQWhmHmXbf8Fw50ljgXSSNzkw+8BkWnGWVl
 eCKPGsjK6MCjhu5YTENeBLTDVizshgCi706n9R2AuZjXAWh3xVtCiR9ivlhEFBamv2hJFLSMmgWMo0DhZtbCNP91txkRvYzcQLrEAz39eZgfEufCTR0U7bk1
 8ajqMT+bcsRd4u6wJ5jYl5TOmlOIC3I7k0+whxCuAfune6Qw3kndOFsEP2gFCS3u/oRC8n0mqa5V+9YA0NcwJCmUqZHXwoKq5JEF6o/j7hMrT/cHUhNPBFNy
 rJvf+PJOottjupHDiio76RHyN9RiaWnp5h/6kCPRu/ZrFxSZfM4/PLrzO1idrjkmJKMQ5+F/qP2AyR7+zbitfNq9Zis8nrlJsQQiiw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153265313594683?=
X-GMAIL-MSGID: =?utf-8?q?1592153265313594683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Olaf Hering <olaf@aepfle.de>

The usage of strchr requires inclusion of string.h.

Fixes: 0c38cda64aec ("tools: hv: remove unnecessary header files and netlink related code")
Signed-off-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 tools/hv/hv_fcopy_daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
index 785f4e95148c..d78aed86af09 100644
--- a/tools/hv/hv_fcopy_daemon.c
+++ b/tools/hv/hv_fcopy_daemon.c
@@ -21,6 +21,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <string.h>
 #include <errno.h>
 #include <linux/hyperv.h>
 #include <linux/limits.h>
-- 
2.15.1
