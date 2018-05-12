Return-Path: <alexander.kapshuk@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526115732; cv=none;
        d=google.com; s=arc-20160816;
        b=MShIYjp+xWcVpaixFjl91fHbVC0fptgE6WGy0VjjGrVWwwUBQomIyEKXAcW5aaFWPl
         vtWD/BGGuVziOkxFgImKtdOe+DJtKdz0Mp0gqND2QDT34Got9OWbttvXKz8lAL81GpYJ
         htzCFWTa8iApt1oszID6c53SDqPACAmxh1ZmxvAA/hOWQeAy38iGdlYgFmlpkM5+Fat3
         0VsLBVcbODYc35vG6cXVRGeutAT06zltAzZrIZpidSNRl2ZfTozCWvGbfYzzTkiW3AU9
         n6Ye5OfMXcqBaAatqYM1d8i3lFfdTaFslW5KXc5pTZqdeBLNGMSF6IHsW4BBhkETXGPe
         NkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hyzJJAk0LhGbEUTujWkb9QEGhGEKrDg3GwYAsQUQ//Y=;
        b=XetiAncmTf2MbYWoMrVfP3MjDX/j5XEjtA4N/kcVdNEHJTBiE3u3IGxO8jYBn0XHpz
         JQLiUUWk5818xVNmHTcGZSN88TzyMos9n4LUqylGMuajuaDofh6LSEe+OeyP/d2eQZeY
         IvkN3O1VLAOKZiWvrY1WKzergQ+tpjn9XwlpZWX55dvAZFr91jQVQFdEYzFYLpQkSKLW
         8zUuF9unSXmrZlFgh4SSVeqaQHNZVhplr1mz5gKukzcoI2q/luZzErvfvi8ZQuZ+NSa0
         wGRENWgSBz2VHkOpKiNaNkZSd7t2MBqoR0OJoGRFXS5HUa9NN1WoW2IF5UbDHqd3GcpH
         bhqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nsZiK1x7;
       spf=pass (google.com: domain of alexander.kapshuk@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexander.kapshuk@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nsZiK1x7;
       spf=pass (google.com: domain of alexander.kapshuk@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexander.kapshuk@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqZ+7gCWa+meYFEqV1MJkAryZCpLeTEUxB6fHmkSqib0O0lOxncnKk+rtVywygwpx7wOjAePQ==
From: Alexander Kapshuk <alexander.kapshuk@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	alexander.kapshuk@gmail.com
Subject: [PATCH 1/2] ver_linux: Move stderr redirection from function parameter to function body
Date: Sat, 12 May 2018 12:02:30 +0300
Message-Id: <20180512090231.4596-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600248330082145118?=
X-GMAIL-MSGID: =?utf-8?q?1600248330082145118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove stderr redirection to stdout from all the parameters to the
version() function, and put it with the body of the version() function
instead.
This improves code readability.

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 scripts/ver_linux | 53 ++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index 545ec7388eb7..0b301bd1637d 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -13,23 +13,23 @@ BEGIN {
 	system("uname -a")
 	printf("\n")
 
-	printversion("GNU C", version("gcc -dumpversion 2>&1"))
-	printversion("GNU Make", version("make --version 2>&1"))
-	printversion("Binutils", version("ld -v 2>&1"))
-	printversion("Util-linux", version("mount --version 2>&1"))
-	printversion("Mount", version("mount --version 2>&1"))
-	printversion("Module-init-tools", version("depmod -V  2>&1"))
-	printversion("E2fsprogs", version("tune2fs 2>&1"))
-	printversion("Jfsutils", version("fsck.jfs -V 2>&1"))
-	printversion("Reiserfsprogs", version("reiserfsck -V 2>&1"))
-	printversion("Reiser4fsprogs", version("fsck.reiser4 -V 2>&1"))
-	printversion("Xfsprogs", version("xfs_db -V 2>&1"))
-	printversion("Pcmciautils", version("pccardctl -V 2>&1"))
-	printversion("Pcmcia-cs", version("cardmgr -V 2>&1"))
-	printversion("Quota-tools", version("quota -V 2>&1"))
-	printversion("PPP", version("pppd --version 2>&1"))
-	printversion("Isdn4k-utils", version("isdnctrl 2>&1"))
-	printversion("Nfs-utils", version("showmount --version 2>&1"))
+	printversion("GNU C", version("gcc -dumpversion"))
+	printversion("GNU Make", version("make --version"))
+	printversion("Binutils", version("ld -v"))
+	printversion("Util-linux", version("mount --version"))
+	printversion("Mount", version("mount --version"))
+	printversion("Module-init-tools", version("depmod -V"))
+	printversion("E2fsprogs", version("tune2fs"))
+	printversion("Jfsutils", version("fsck.jfs -V"))
+	printversion("Reiserfsprogs", version("reiserfsck -V"))
+	printversion("Reiser4fsprogs", version("fsck.reiser4 -V"))
+	printversion("Xfsprogs", version("xfs_db -V"))
+	printversion("Pcmciautils", version("pccardctl -V"))
+	printversion("Pcmcia-cs", version("cardmgr -V"))
+	printversion("Quota-tools", version("quota -V"))
+	printversion("PPP", version("pppd --version"))
+	printversion("Isdn4k-utils", version("isdnctrl"))
+	printversion("Nfs-utils", version("showmount --version"))
 
 	if (system("test -r /proc/self/maps") == 0) {
 		while (getline <"/proc/self/maps" > 0) {
@@ -42,7 +42,7 @@ BEGIN {
 		}
 	}
 
-	printversion("Dynamic linker (ldd)", version("ldd --version 2>&1"))
+	printversion("Dynamic linker (ldd)", version("ldd --version"))
 
 	while ("ldconfig -p 2>/dev/null" | getline > 0) {
 		if (/(libg|stdc)[+]+\.so/) {
@@ -53,14 +53,14 @@ BEGIN {
 	if (system("test -r " libcpp) == 0)
 		printversion("Linux C++ Library", version("readlink " libcpp))
 
-	printversion("Procps", version("ps --version 2>&1"))
-	printversion("Net-tools", version("ifconfig --version 2>&1"))
-	printversion("Kbd", version("loadkeys -V 2>&1"))
-	printversion("Console-tools", version("loadkeys -V 2>&1"))
-	printversion("Oprofile", version("oprofiled --version 2>&1"))
-	printversion("Sh-utils", version("expr --v 2>&1"))
-	printversion("Udev", version("udevadm --version 2>&1"))
-	printversion("Wireless-tools", version("iwconfig --version 2>&1"))
+	printversion("Procps", version("ps --version"))
+	printversion("Net-tools", version("ifconfig --version"))
+	printversion("Kbd", version("loadkeys -V"))
+	printversion("Console-tools", version("loadkeys -V"))
+	printversion("Oprofile", version("oprofiled --version"))
+	printversion("Sh-utils", version("expr --v"))
+	printversion("Udev", version("udevadm --version"))
+	printversion("Wireless-tools", version("iwconfig --version"))
 
 	if (system("test -r /proc/modules") == 0) {
 		while ("sort /proc/modules" | getline > 0) {
@@ -72,6 +72,7 @@ BEGIN {
 }
 
 function version(cmd,    ver) {
+	cmd = cmd " 2>&1"
 	while (cmd | getline > 0) {
 		if (!/ver_linux/ && match($0, /[0-9]+([.]?[0-9]+)+/)) {
 			ver = substr($0, RSTART, RLENGTH)
-- 
2.17.0
