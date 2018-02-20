Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x227sjq66ytxwtUj+LeBcw/+mMrqBsKVZZURXg79aaH9NFIplkmurr34ODyJ6iFDndDB/wqV7
ARC-Seal: i=1; a=rsa-sha256; t=1519127880; cv=none;
        d=google.com; s=arc-20160816;
        b=CZu2EVt7i359Lq+X0UHA3KxT3WU/XMuq4kFWwLiK/qbuVQYix8C0NOUYs7WI0yO2uH
         POQC2/i4Y0ZXdMwNK1IUw/cQ08MLkD/vVvGD52xvrC5ZmkcT41ltSErVxf6DC7eS/YlU
         /Dswd+X72aBeGQaQX0qr6AB7TJTFbPHKgPrHn4M5cH64WFfRaMChmuVYjAuKLFBRy9Io
         Do3Sd3/vbVk+bo5UjN0IDTN5jQxV0JbePxYQqx3TgbNIT7jkMZofbp5XTc/0MJ8fEfk2
         vQTwq7ROgjpzwYS3nm1SDvV+cfTjCa+TwIIljXVZ0d8iooU7ZWzDGP1yWIR31VQyYAQ0
         F/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3EXdaR8klswLR8IkrfgcsX4O2930oPg7dMD1Fm2rf48=;
        b=xaFqHq7ubYSwv9RBuZq5aandrsxfJ1t8bmMo6Jecxy6WsRsAC1dICx1y1TqcGZa5sR
         xJsP++vKSsY30JGkh1Hz3msqTOWmspmSS2LGhjtnBkMfy/DwkPQoRfYSCp+ow6icVMT4
         4iDij51QtEgI42BfTG6c4P9726myvFWoiomsNN96NUsdhsROmhLPIaVCK9eFcqHeYS6Q
         is4AqkK5/I7YHDDe+VhE5XviGmzesV7RTRVN2rv2iX5i5YxGfVgzc1+Oge0PVoskI7we
         W2yjZUE4A3uOaLyEk6UMfmpErzi7PxyqyS8Qek0+F/sI966rKlx10lHel+jFqBqFRN0M
         vzHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.13 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.13 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [4.4-stable 05/22] binfmt_elf: compat: avoid unused function warning
Date: Tue, 20 Feb 2018 12:54:52 +0100
Message-Id: <20180220115527.1806578-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:AQmQf7SU2ti+TA1dVDcOP0BrHcYYG4evrZ/sdFZm0KTWOpgYV7Z
 a6tyucQmqG+l63+TLuoFpUINwxUavsNI+66m2ej7sysNljkYzwVS8bwiv2+tuSww0GBSL+N
 M4Jcd2ml6ks3wlh9t8s2INe0tzF0uGqyjekZUsf6mIBO6oGUhmjScBfZzjfoGRUMQvM3aRl
 jwe2+nlsxGHLBxO1DobEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BbghsELhevc=:2zB/VW8D21kisme6mBC0x3
 raryyLwCn++w8c598KsLBvWDVfIKl6L9hgcDEoBjDmytDq/w19a1vccLhYQozQKvaZtTq8r+o
 Zd/k80DGooDW97KnSf90SweWuuHz97MB1P/bVHeKUolP5nGZkQq3leDhge0ba2LLynl1iLOHf
 B3aUH8jRTQCtReMXIFUAQnrnDJOwJ0FCORwfnOry65/MQE2ZzG05hkAkYGh9IIaUW6OSnhvxd
 mdl45APJDYVayudVvGdWvtowgUwGvvZmfS5L2UhrsdOi9Sn/XSVQ/n/oCY2uGASnuqCRdJPQf
 2EdFJCJWV0I/+u0y+YuRlHbYwTBXKYKiFyxgppShru0qdwE+hB8tvY2UGlMeA9udR+pPCl6oN
 sTWCxdkWRRPYkRlP8nKFXNNfa+c9Do+eRenKBZIYkMlxGrKvVEUxYvZamA/P/67k7lYRqwFy/
 T/2XwouGK6r3t1xAnWKmFtWGk5M6eOnX/FfdBeGBlg1qrV5vIvmb/vWibdVtjk6dk1rQpCZfc
 JSLZmwk5MnMF+zMEUEGc1ELgQSVORv30xAI6MXqYXTnhYKRyFtCM25MRbcG9YoDiW3jnjXJuC
 uHExB35utVIHCLiubCw+OQwJCp3RIKqzuwNO5npK+vHLlOMYMsXsWNKpQg2qRYFdyFRcmTiGD
 TkCPyQiEj4u3yvCAxVROZQQRp/ObplpR3CkwCTAVqeY31kfS3DMPcl0vXd+haGpTJ6MrkwGw1
 YoJ3VCQoY7DBP3AvSCA7itrdMWA++gNRbToDTQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921036246780350?=
X-GMAIL-MSGID: =?utf-8?q?1592921036246780350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When CONFIG_ELF_CORE is disabled, we get a harmless warning in the compat
version of binfmt_elf:

fs/compat_binfmt_elf.c:58:13: error: 'cputime_to_compat_timeval' defined but not used [-Werror=unused-function]

This was addressed in mainline Linux as part of a larger rework with commit
cd19c364b313 ("fs/binfmt: Convert obsolete cputime type to nsecs").

For 4.9 and earlier, this just shuts up the warning by adding an #ifdef
around the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_binfmt_elf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 4d24d17bcfc1..943be5ecfcd9 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -51,6 +51,7 @@
 #define elf_prstatus	compat_elf_prstatus
 #define elf_prpsinfo	compat_elf_prpsinfo
 
+#ifdef CONFIG_ELF_CORE
 /*
  * Compat version of cputime_to_compat_timeval, perhaps this
  * should be an inline in <linux/compat.h>.
@@ -63,6 +64,7 @@ static void cputime_to_compat_timeval(const cputime_t cputime,
 	value->tv_sec = tv.tv_sec;
 	value->tv_usec = tv.tv_usec;
 }
+#endif
 
 #undef cputime_to_timeval
 #define cputime_to_timeval cputime_to_compat_timeval
-- 
2.9.0
