Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x227sknN2re587NjkUwVwVWrQiWgDej1Ya0dD5viW6tfNYZHtMenXSjE20Lk4LU2kIBgLdG3o
ARC-Seal: i=1; a=rsa-sha256; t=1517584814; cv=none;
        d=google.com; s=arc-20160816;
        b=c7Wtg5SbgkV1WXIqLfXGt7v34PhrIMqKDa1z/lglDBML9vxJiwFjiOev14iYtyKuJQ
         5B5yrQsJ7Urz+zY/Orr29/lL/aP4oPueaUFPTSgLulgrCTDFMQI9g3mdXns0fiDMvI02
         WHoQnhndq96GF5gX7p5pUR9r+ULD+HC/yzUY8dvmiwqWmWckZ1lyhJKfW15UN2IzDW9A
         MtvK6Il+DcHKh7cTWC0/OLXW8khwzeWSbhHilUYlx1aWAFI5PwllQfXwg/+wG7ulOW15
         W9ZUJzPjeRhfN8xfZoRjedq3YRKi6s1SxRqzpH1VySZ0DODUIhgKA7yOF/Y4khef4A7B
         A0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Tab/4EQIA1+AmRIeqa+fCNEAjuGT++8pMGj4/SLwowU=;
        b=U0dqR8I2F35r9TU5ukFiZAFGujUQ1I9eMJuF7nNkEMmNiruqck8ffWnLN7dXPdtk2N
         7sE7UKZ9OpZAwLzbBuhyqHOfnVHtVpS+gAt8+OOcqLF9iprsMqQvGEVJSTI0oxDb0njI
         JGef4Bf4RirQor+yXU6xyyMYQhPy58Y9tNu1gOgxato99TMK6lyGuYqyPlO1z/l8psln
         wJYZcqP2m6n354pRwr461izCSMJW+L+rg2o8gtUySQH6xqraCsytuw7DC4AOsCp2Zx4q
         7ZlSyeEFi+VfFtUJl21XMAxtepK7r4p2tHS+ug9mpV8/hnnP3R2WRM8YKiKyADwMDj/P
         jwvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.75 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.75 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: Alan Cox <alan@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>,
	Sergiy Redko <sergredko@gmail.com>,
	linux-media@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: atomisp: remove pointless string copy
Date: Fri,  2 Feb 2018 16:19:41 +0100
Message-Id: <20180202152009.843231-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:YwOaRFH0AilTCNdPNOQMzYA7Jmbl3dUcB6knq81TLO9t3aXQ/Mi
 Kcwdn00c2u2opFWSHAX92GuLY2GfsBa5OTkS4ReGB7M936bGDkyR+UweNVC6zvo313MiVp0
 5c4hG1UojGhFrGvZAsTVzbnX6pT1GQhiUwHWi/y1VpE8+TZZmrBzGLUPhhRT6q6RW5zhsuG
 wqmlVn9KQxxAOoTcQ+d4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IdYRcOVakjM=:f9E+5x3G0tXpo7SSOOWGPj
 ZO56+7bLEoMBO5m7yI1dpYkCxlGHk9XvbmFf5z5+bfzAUuUsizgfdqKI9fbjLzzt5vCTPmDLB
 aXFWyN5oK3vw9Ns5uSvJ8FGiBh4wpI2YoC9I39fl4tlSnEjy/Vh3sUX+xE6o+qy8mlaP3AaUc
 vI3AbKnJRFsuzf3b6atfpOs3UNBYNRs1iJcVFlbqL+2lDyegxWFLOcHKXUfKWE4NlcpbUPh6j
 RRyIH3gPIQue5dIJZ+VaW57F7ag0mAXz6wonIcGqOl8mNT0aIpO9t75w/PZ3s+EcSe/luZW72
 TE4rqnENbSeN9yPsIuGwJh92VReRi3FwvhK5/PZ5lCGAsnVeTbI+aU5HuKXgoIObVbHS0dk7X
 O9naRLXzokiK/4nxGbyJHAj7YNaoMf4fjIqqYYJWqLPlcfE9AImtx8bKhqCgmgLLYyUIqvjnG
 FYLmOAdjM502kVu7RFAFh9xv4n76fdizshOrOgo/7MuImUVQxNQsCLYfeDi3yVU3+l8BaurMT
 t6SIdpgyhNpkS6cFANcncUyki3JD45RK1G89Zp8OP0tibtynfBhHMyFMp924DeLiYt5Xr3BFO
 BiSjO2Ecn/QIy6vN7R41i2WqlDhWgKiV35AHa0nW1YeRKBvB5xZdZg9Cd/Q6YPyAfnIDwLl8D
 2RtCzq0R5bWTK3wakOMGLbTaJ/pdP1bFxNijt3otvsbRavF3bzAmzisAj5L4h8KAGYxYtTDMa
 RJbc2C/MWAc2TygSnWDYArJ+tqB8b7dIUofNhw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591303014085060994?=
X-GMAIL-MSGID: =?utf-8?q?1591303014085060994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc-8 points out that a string is copied to itself here:

In file included from drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_include/platform_support.h:25,
                 from drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_include/memory_access/memory_access.h:48,
                 from drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c:16:
In function 'strncpy',
    inlined from 'ia_css_debug_pipe_graph_dump_stage' at drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_include/string_support.h:158:2:
include/linux/string.h:253:9: error: '__builtin_strncpy' source argument is the same as destination [-Werror=restrict]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This removes the bogus code, leaving the behavior otherwise
unchanged.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c b/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c
index f22d73b56bc6..60395904f89a 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c
@@ -2858,13 +2858,7 @@ ia_css_debug_pipe_graph_dump_stage(
 			if (l && enable_info[l-1] == ',')
 				enable_info[--l] = '\0';
 
-			if (l <= ENABLE_LINE_MAX_LENGTH) {
-				/* It fits on one line, copy string and init */
-				/* other helper strings with empty string */
-				strcpy_s(enable_info,
-					sizeof(enable_info),
-					ei);
-			} else {
+			if (l > ENABLE_LINE_MAX_LENGTH) {
 				/* Too big for one line, find last comma */
 				p = ENABLE_LINE_MAX_LENGTH;
 				while (ei[p] != ',')
-- 
2.9.0
