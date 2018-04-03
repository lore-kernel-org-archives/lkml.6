Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeDCTCa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:02:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:43451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752788AbeDCTC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:02:29 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] checkpatch.pl: false positive: space prohibited before open square bracket
Date: Tue,  3 Apr 2018 21:02:14 +0200
Message-Id: <20180403190214.23082-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.16.3
X-Provags-ID: V03:K0:2FpmNCEYr3DvE8t0MMbPOv3TsQfiSHBHt7HlXJ0EruoM3++FnJF
 klkY6o/S+34NKBxOCuitSjo+HY7qvxPkFyqhRKXyC3oWUN3BsM3a21Z9MfXJwzBa4mkL7lY
 seB+P7+n/wxrL4Hcr+pUA0Eh2SUsROU6Ww8UHc3SsTrdcVBL08XEd/i8F8lk+E5fyUspG8e
 v51RK6xag0w8jHdTW+o5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LOz43aeYYtE=:3n9okpqaBYeFnh7oSki5re
 XnHzwZXdDlqGX2mlGU6eoscH3hwTt2tRbRW1jny75ljKAk4eoFz8tmej67NwnT/X5eLNTtIXB
 idLz5BGvsrTkTMoBaElS14S1D0SJBkD/AdxaaF3tAo4wqTEAXlfX1KivFYrAJo+x9huc+xcRX
 f7t9l5IWSSOujjoIxitRsi9mFOTZ5b3Xrafh3vnp773qsU5qmSUEdi+r6/4fFa4VxnA5W3j7E
 6r21KsgX4daou6ZB5e86BxjZQYV7bMWLN2WDRoD47I+iSVoX8GQ1pIzR9Ass1FxOKOCt9QKTH
 a146fSXQ0YGNo/0sCH+lpcE6yTkav+P8JLy/lNo/LJFFWrFdycP43d4UoRYfnx1SOeuAc3szx
 hBhYSDNVggi4Eg8ShZOJjNXCsLWfNG+U2AbprQk17ailZSz8PIamm2cwbnT0Fh0rGELedJeYd
 lmpwDea+VTP/jwCnidiyUrlqLvLMhK0C3UFL8ExbWu/m8UFfhBc5AKtHeqY2pTopRQgv+wzRw
 OpGGINrYGdq18w0RwK3KI+GUO2wLokNIfU1B/bUWkQ7kLF4C72DgtkegHbu1jv/bqLbRwrU4x
 kM1krCV6ENHsjhLG00LXeWRsWU/nJrMxpKMYDE06rDHkgojUns9G7QivFcq54UqFQsrfE7yRr
 i29oS/skiin0cfWMBuY62jYbg2FqDsL6pmWwEzWD3IrzJxMqR3lttP96S8Vy9Y3FeiX0mE5Fq
 sW+m0iNChDvXFngizWkIC0OowkM8qY1wyFfn6CL+2LOEyxSQEqyKN0jCVuwe1UMl2A0VVIpnj
 W2aHZ2ibqMbUAEO4Yyk2ZVouAZQ3Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch leads to errors "space prohibited before open square
bracket '['" for the asm statement.

In the inline assembler statement the bracket is not used for an index.
Adding a space after a colon or a comma should be allowable.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 foo.c | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 foo.c

diff --git a/foo.c b/foo.c
new file mode 100644
index 000000000000..7f0ed923f997
--- /dev/null
+++ b/foo.c
@@ -0,0 +1,11 @@
+static inline u32 deref(u32 *addr)
+{
+	int ret;
+
+	asm(
+		"ldr %[out], [%[in]]\n\t"
+		: [out] "=r" (ret)
+		: [in] "r" (addr)
+	);
+	return ret;
+}
-- 
2.16.3
