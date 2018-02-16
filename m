Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbeBPVCc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:02:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeBPVCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:02:31 -0500
Date: Fri, 16 Feb 2018 13:02:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] taint: Add taint for randstruct
Message-Id: <20180216130229.f3de3aced0c87fe31ad92000@linux-foundation.org>
In-Reply-To: <1518752264-47238-4-git-send-email-keescook@chromium.org>
References: <1518752264-47238-1-git-send-email-keescook@chromium.org>
        <1518752264-47238-4-git-send-email-keescook@chromium.org>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018 19:37:44 -0800 Kees Cook <keescook@chromium.org> wrote:

> --- a/Documentation/sysctl/kernel.txt
> +++ b/Documentation/sysctl/kernel.txt
> @@ -991,6 +991,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
>   16384 (L): A soft lockup has previously occurred on the system.
>   32768 (K): The kernel has been live patched.
>   65536 (X): Auxiliary taint, defined and used by for distros.
> +131072 (T): The kernel was built with the struct randomization plugin.

Uncle.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: Documentation/sysctl/kernel.txt: show taint codes in hex

The decimal representation is getting a bit hard to follow.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/sysctl/kernel.txt |   50 +++++++++++++++---------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff -puN Documentation/sysctl/kernel.txt~a Documentation/sysctl/kernel.txt
--- a/Documentation/sysctl/kernel.txt~a
+++ a/Documentation/sysctl/kernel.txt
@@ -967,31 +967,31 @@ tainted:
 Non-zero if the kernel has been tainted. Numeric values, which can be
 ORed together. The letters are seen in "Tainted" line of Oops reports.
 
-     1 (P):  A module with a non-GPL license has been loaded, this
-             includes modules with no license.
-             Set by modutils >= 2.4.9 and module-init-tools.
-     2 (F): A module was force loaded by insmod -f.
-            Set by modutils >= 2.4.9 and module-init-tools.
-     4 (S): Unsafe SMP processors: SMP with CPUs not designed for SMP.
-     8 (R): A module was forcibly unloaded from the system by rmmod -f.
-    16 (M): A hardware machine check error occurred on the system.
-    32 (B): A bad page was discovered on the system.
-    64 (U): The user has asked that the system be marked "tainted". This
-            could be because they are running software that directly modifies
-            the hardware, or for other reasons.
-   128 (D): The system has died.
-   256 (A): The ACPI DSDT has been overridden with one supplied by the user
-            instead of using the one provided by the hardware.
-   512 (W): A kernel warning has occurred.
-  1024 (C): A module from drivers/staging was loaded.
-  2048 (I): The system is working around a severe firmware bug.
-  4096 (O): An out-of-tree module has been loaded.
-  8192 (E): An unsigned module has been loaded in a kernel supporting module
-            signature.
- 16384 (L): A soft lockup has previously occurred on the system.
- 32768 (K): The kernel has been live patched.
- 65536 (X): Auxiliary taint, defined and used by for distros.
-131072 (T): The kernel was built with the struct randomization plugin.
+0x00000001 (P):  A module with a non-GPL license has been loaded, this
+                 includes modules with no license.
+                 Set by modutils >= 2.4.9 and module-init-tools.
+0x00000002 (F): A module was force loaded by insmod -f.
+                Set by modutils >= 2.4.9 and module-init-tools.
+0x00000004 (S): Unsafe SMP processors: SMP with CPUs not designed for SMP.
+0x00000008 (R): A module was forcibly unloaded from the system by rmmod -f.
+0x00000010 (M): A hardware machine check error occurred on the system.
+0x00000020 (B): A bad page was discovered on the system.
+0x00000040 (U): The user has asked that the system be marked "tainted". This
+                could be because they are running software that directly
+                modifies the hardware, or for other reasons.
+0x00000080 (D): The system has died.
+0x00000100 (A): The ACPI DSDT has been overridden with one supplied by the user
+                instead of using the one provided by the hardware.
+0x00000200 (W): A kernel warning has occurred.
+0x00000400 (C): A module from drivers/staging was loaded.
+0x00000400 (I): The system is working around a severe firmware bug.
+0x00000800 (O): An out-of-tree module has been loaded.
+0x00020000 (E): An unsigned module has been loaded in a kernel supporting module
+                signature.
+0x00040000 (L): A soft lockup has previously occurred on the system.
+0x00080000 (K): The kernel has been live patched.
+0x00100000 (X): Auxiliary taint, defined and used by for distros.
+0x00200000 (T): The kernel was built with the struct randomization plugin.
 
 ==============================================================
 
_
