Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x226HLO3VAnonG2imlL1wEhgv9jMkukcX835TCx6qKZbDFApNet1GZTd3Aq/x80aoTIrxraN+
ARC-Seal: i=1; a=rsa-sha256; t=1518323638; cv=none;
        d=google.com; s=arc-20160816;
        b=i3MDkcMg9wI3T4oSSiGUqFHkO9grp2RoxUkAKx4DxRbONsHbtwyaS1/npBt+Rhkvli
         cdhrDKQ98zqqAQvPUXx31/GWAec1QU6xdZKiVbLtETjL1eCfJS1bZA5RpnyJUiQ8v+hr
         FC3dfyN3eYZ/oUmX1MWXKhYV6dTwTHj5wlTgZHA2/P0SwYFCujVZZ7HkhD2h44TXqWJs
         yUB3RZva97XQiawd8IZgv1/Ra6VnUx5kCA+ijzwZOkYW0O4q9k6RKIsnQEWnehrbPcpR
         G4WweJ0xowhWZ5gp9/k18Iuog/pL4qqoLKKkF9KgPs3pA96pDdZ9hGyEMFq9oIGwdMvD
         M+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=qedEPz67TmCI7AsPk9F7aI0sVnTt/oajXMJuGMxHUXw=;
        b=b7yTD1Rkn9utkitS7P8NOsS1wAPA3iK+KhmrYz4THueeFvNubD5GHXiRb8eB+waMFt
         NLcVtq0YYQYW6ErjGa0wzm2L0+5S6WcZYEGv6fBzWEHgBCI2SpmGv3SXJbCbfl3bUSzp
         05hQlyx0ackU/z65hkFenJNBJ/r37qsXuUPx9o65Uxakaa0GauTPHcGPmHt7tmrBuZhv
         qHtQl1YQrUB4ARAaC47FEAM+bGRBU9GMJamMpFNBIYpPFtwe/KxUJaUmbHeKLD0kxe8n
         p7AdALIkZ6a3PN0nGG/7a9IzTV86dpINYHhUG3ryZi9IIx2ogCsXREbeGppEpvsl9jHP
         RkxA==
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
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Shuah Khan" <shuahkh@osg.samsung.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.693198305@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 008/136] usbip: tools: Install all headers needed for
 libusbip development
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077728316463503?=
X-GMAIL-MSGID: =?utf-8?q?1592077728316463503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

commit c15562c0dcb2c7f26e891923b784cf1926b8c833 upstream.

usbip_host_driver.h now depends on several additional headers, which
need to be installed along with it.

Fixes: 021aed845303 ("staging: usbip: userspace: migrate usbip_host_driver ...")
Fixes: 3391ba0e2792 ("usbip: tools: Extract generic code to be shared with ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/usbip/userspace/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/usbip/userspace/Makefile.am
+++ b/drivers/staging/usbip/userspace/Makefile.am
@@ -1,6 +1,7 @@
 SUBDIRS := libsrc src
 includedir = @includedir@/usbip
 include_HEADERS := $(addprefix libsrc/, \
-		     usbip_common.h vhci_driver.h usbip_host_driver.h)
+		     usbip_common.h vhci_driver.h usbip_host_driver.h \
+		     list.h sysfs_utils.h)
 
 dist_man_MANS := $(addprefix doc/, usbip.8 usbipd.8)
