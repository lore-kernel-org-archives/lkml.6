Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227132-2-10735660372071923495
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227131; b=GzR8wqqt0w0FIo7srSbZcgRpAjVZ3EgrLBYlfA/ju3W4eTo
    Vz9BHcJr6GNdie0MHZ1+1sreKVUKJ/hiiaGuq84EfeaAbzffaHlM4iVl7kl4Itiu
    SJs+K13YCXdUtuzMgMG0yht1XHKt4qMD8ysxSnWxgOm4q78QwBIGsxYgx4izSW/C
    vJvFqgEuaF6sl9ZMBiUadceA2IoPJboCLQrKoqJ1p4fDCmVmwREf48lptuZoQGvI
    fR1SxaSz+FNZEMiD0gMagr8ABIiHUNGb2rvvQ6fblmjR7w7dkDuDdnqTJkF9WnBS
    vTCpW7Sjga7TCcIC08YShakx3RgrINprWzlo/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227131; bh=8FEhf/ujUNNnHO3pPO4yD/CMXzUGGFTZr39pV3YfKfY=; b=e
    1S+/8iSdRMhQB3BSYvFBJJNCylKb+xBS7YCvNulb+vdZZVw/tp2ffWVkfKbecFL3
    60TNGZKVpZn0eEy0bJZWYC+bY/F5H4GRliDKpNpbxwilX/THNXbeJVTGRProENjG
    reDRPNPWZ+YnDxy63eXboNgjpvujfb8gBxkHuDRiyjfj4OLHZZLK8QiLsNWJ0s71
    F7shAkJH1wVRgdMxZBYk+tenOjIgNG0cbg2FtL+LybsCWMQB+b6J5RbnsOdSX39n
    3kbHe0zR46IvGksI6f4bKL5snLLrCy8UMZvXLEd3+bBXb0Mkt7O3J1UV9EiF4hsW
    /MBL69yV4SMmhLQT0XWAw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 04/12] tools: hv: fix compiler warnings about
 major/target_fname
Date: Sun,  4 Mar 2018 22:17:14 -0700
Message-Id: <20180305051722.19157-4-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfO3FmTSGDr+t1J2VpC6dCIL02eaZf0GUknKOk79IuzofJAxlSZ8x1gdyY9DxeXTIbeFY9CYZSt2hYaNqcAm2MYNYiaW1RdDgOZLqbXf9llZEKVRJAe6W
 +BCV7ExcHDOTn/qi6fLa60yqntcP4MwXB4Ao6GAgzylHDf3ZMXyZQMQG5fFhrhy2n1mItxCh9Uy91f55os9dkQnS1mvbVIiZxnJS8sWIMY0X4f2vyYW/kwbd
 651Bv2KZwOuhE/tvPRgm1wwyhUZ7NtQ+rbU1AqM+9quTU0Vwt5UAbnsdxelYTuZcenypaC4rXapMTLjXuIaWVtHH0HTVrE1Wscl4dqF/rgr85j6VDea+L1WD
 orNDv69kFf1vTdh2yQ5aZ96LkSqD36qQ/XWyEZqNoq2e5c8nuyRcnmeePRf9nudZpI2jiVBjqvjzP0SaKSHM2GvLAVj5FKhC2UEBRgH55+jA+d5DA1PPGbpM
 YUa2HmaSjsIWSPxocnN4hv6ZwNN5/VKdaUEhUZydQwz/x69wEVGhFwcgC4RxtmnUpf1GcLRSVN69HllCUWwn3iT1snykX90YX2B+VWVdomhZQsAInfGLG6yt
 iDx6qcqdXJLhV3X9XZFXQcvU
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dexuan Cui <decui@microsoft.com>

This patch fixes the below warnings with new glibc and gcc:

hv_vss_daemon.c:100:13: warning: In the GNU C Library, "major" is defined
 by <sys/sysmacros.h>. For historical compatibility, it is currently
defined by <sys/types.h> as well, but we plan to  remove this soon.
To use "major", include <sys/sysmacros.h>  directly.

hv_fcopy_daemon.c:42:2: note: 'snprintf' output between 2 and 1040
bytes into a destination of size 260

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 tools/hv/hv_fcopy_daemon.c | 3 ++-
 tools/hv/hv_vss_daemon.c   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
index 457a1521f32f..785f4e95148c 100644
--- a/tools/hv/hv_fcopy_daemon.c
+++ b/tools/hv/hv_fcopy_daemon.c
@@ -23,13 +23,14 @@
 #include <unistd.h>
 #include <errno.h>
 #include <linux/hyperv.h>
+#include <linux/limits.h>
 #include <syslog.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <getopt.h>
 
 static int target_fd;
-static char target_fname[W_MAX_PATH];
+static char target_fname[PATH_MAX];
 static unsigned long long filesize;
 
 static int hv_start_fcopy(struct hv_start_fcopy *smsg)
diff --git a/tools/hv/hv_vss_daemon.c b/tools/hv/hv_vss_daemon.c
index b2b4ebffab8c..34031a297f02 100644
--- a/tools/hv/hv_vss_daemon.c
+++ b/tools/hv/hv_vss_daemon.c
@@ -22,6 +22,7 @@
 #include <sys/poll.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <mntent.h>
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
