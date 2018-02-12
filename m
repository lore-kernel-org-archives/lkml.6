Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x2245MppTA9V5nHuGd4YEINkWDkBo8IByI0yY37uYoBSW5javCcr/41d0M5OCSXN8IA667m3g
ARC-Seal: i=1; a=rsa-sha256; t=1518395677; cv=none;
        d=google.com; s=arc-20160816;
        b=PMKd2j9tcjN6ccGYPRdSB7PutTZhf+f8SxYiudz6WjllfwP/69qBZUnrV44w0i3HH/
         uB2FCLkKntVbVyqZz0R2/Fy6R377Uvy8V6RO2XK4OnVD+rKq2KOTPM2ZljPlpAYKQ8dE
         jpvX4aq/65VorNKvjFXoAPBjj2jBDORoBZPEE0lGoQfdOd6acau3CVzfCK/6nnPWe71a
         CiYS2bkFpkjEX+PZHWoDJNy7/zIxtWhUc4hYk90vpP9QgeTBdH4t+8bojRmklEO+/jSp
         V3CcyE9qBwcLtIwBgICqo4oJoDt1cS/xBpxxZ8JosAGbJ5A03K5Wszn85u3bJX7F0Ba3
         S4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Le2ACXnjdA7T+MNmnFQkKLrRyG8nOx9bpU5FmFBdoFo=;
        b=l10lpE+Bj0y2JmBQOESHgLs8Q7GAb3lbtVEOl/FwCu9583zn1KnMQHEKzub4oGbZ5e
         rdMfnDEejTqyNjKo7JRh24ajv1e3JykS8Z7OPoqjU/QgbTBOP9P1vcVjAPzjfA694XzF
         tEqzvYgxe7dLjLep9QaT7Szy7KA9ROWL1SAUhdGLXuz0k2Ulbxa3QPHXtbkAaSVaZauR
         heiwjI5aqdwPwfDuEnbkcBSX425dL+EHyJMMZidumXI9BA5SHcDALgux003B7tMJ2rQP
         72aODLtAA5FlcO5HZtKiQ3KRPyRt90aNdl9rt1Rjoyi2xo//jMjdUrrOBXR5UfRyy2Oy
         Socw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
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
Cc: Dexuan Cui <decui@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 04/12] tools: hv: fix compiler warnings about major/target_fname
Date: Sun, 11 Feb 2018 17:33:12 -0700
Message-Id: <20180212003320.6748-4-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212003320.6748-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfGfLzs+4lIQQWJS3NtKpuQDQuHn6mJDvI/GoOSSpt2MSgqIXmewL8IWLJmo6NT35dOTufmrQS9/yvCCZHM96bNQSVvdUsFqUepL8T+h4MZqkl5VZYetC
 z4ixOdZdd5j28Q7tUcvxTKEEtpKJ8bcgRypNjPQIQrxYV4Y6igIOQF/QP7GkLKf6MH3zarw+UQ61dn1S2Dp/ShBX22sH496kCVTjQKleuvtN0oNwM3U0z1yQ
 qE7NysJ3Ta2HIA8Kh7rU8lW546b7pkq8wyfwGFxVHUpKgtDs7h3UWC1WxJr5d5QXdBDTZLZ1c8Q3nRB3zxAAEABUWF//LD9p5A02cp/qgibeWyIocHXKSTJA
 8yfsOZkXbPmBX0fon5F9pETaMZsjRyvrF4ISpMR0GjocZdQL9SZXuY88AyhURQxuP90DIgdZAx/WGP4x/Na+VgsS9cKCKFlnSgfh9sdIehTyYS2FjHaD9Kyj
 36feUfyFiFysgR5/EW5i1AIl747Io7CKsCEUxjbKUxR8EcREreVi9nfqwspko0+gbjuqAnLjHslk53OqV9s3vFiPFGpRQMpS3H38cFEfMQR7Ic+qpxRdTXLU
 1DdkPTNGAcAygdwt7IkZOKYX
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153265140898818?=
X-GMAIL-MSGID: =?utf-8?q?1592153265140898818?=
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
