Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x227ATCKx+bxx97Vidowds+i7c3qcnJfk1z4Q5HxFF4dHIB11lub+gR6nMjAE0p17mzuawuTG
ARC-Seal: i=1; a=rsa-sha256; t=1519035281; cv=none;
        d=google.com; s=arc-20160816;
        b=AqS/z7IZGl4OAWl3u41Mvs0/FdFnRjE7JqiffZ7xutWTywkIyjQBbd6bqYOG67afxf
         xF/a9g5awi578pM3k1GBACewlPtw/wjepBQEHN0qLSEDbre/Gutm4RcCQJEnidcNEBBk
         +L1pW4sX8dT/7E9vZFETAUe6o6oGiNzAMpeXFm7SwgcqqvprdDu9kRDs86m/KY1NO4XS
         f/oWNe6ZOj9cjwCKOprOoiabhtice6UtU3thGwpBwNGE3gs2zIGbfYxE1oT7nkFrLFzr
         ItqU9CsyTxcd51j3aQl+gfhrCvKrC6BuDZAppbjaMqBmc5WP2iRAatyfjYiGo99EvO+f
         Xv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3EXdaR8klswLR8IkrfgcsX4O2930oPg7dMD1Fm2rf48=;
        b=IdiziSamazzQ9+EMfyjfvd3YbcBnYMtDqSayfZgKUTn+7b08MGtkyqUXyuFvwFZs1E
         Yw5IGG5ch754Wgquyc2bQA7yhxcrlCx4sTne2HrWOcKXWwJNXFJFnPMd5oxSyCfpvwuw
         ObBDfohLjP2A89za790TDdwwL7p+kLh7iqNiTML0rZNBJVaK5tqeY4l+R6OWT/aPK2JE
         Vz6ogoXVB4MIhpcnsMwWnUAcfCPsCPAJTDdkkUZOAqcWlQsfEI4FN/1lumOtyJVE+HtT
         k5ifeTuG5rFJYSDvW1kryITY2GsznyduyJ1xf+SKE6coSwgMGUntKIAM8bBDXRsFTpCX
         k9Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [4.9-stable 4/9] binfmt_elf: compat: avoid unused function warning
Date: Mon, 19 Feb 2018 11:13:23 +0100
Message-Id: <20180219101343.2922561-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
X-Provags-ID: V03:K0:a7vjXUQbrfLAs8RrB/FR6oKJwbxpj3OpY3fqd2uZTcuqz0pmMmO
 uCeETK/I3J/yklsDp5aZM5vkmgVzNK6BYygow0iowzqxca11SQmDUs7RuXdIayEvQVy9iKy
 B/eEqCoc/a8HSX/jNMoeCyq8cyoMiA8AHlidWvGaWXqr+gz0gsZA1bvJxLEIBqQzvWNxKsk
 y4oKoMH3Gtz6w6Hdv+fhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S7avwsTmh4Q=:DnZ0WXJgMnPCo+nCmBCX0M
 xfZTMdg3l0qCJAnseO4sF7IMg36CC5Q5U9taziUEIgiQeWVTFc70QFnZbonkv6mDfoAae5AZy
 xK4FDWXXWN0qyKYfIghuVIRQIKbqPitdFeNav+oQDpiiw4487LNS+xm1xvldogRrLkuBX4Dfs
 famku1grCL3y6ZBvQJao5cIveY+hD9BC3pRrfSjyYiKXi7Mu/u1XL1le/LuyykUBkDCxPmpzQ
 LvjBUiI7B8rQlO7Vy5DkzwVXaZ7WnBrqExP3Q6tvka7GO5Db4Oz2oGKJAl3An5fpFZh5Bv3Zo
 xWDkNK/1625AInuwwjaF2UaHrRErdpnKVWE0ZFpLBMpF6oFnc3OjEQrDkBv/ScBCA4/YDWgK1
 M3VUMF3/F/Sp9y/Pi+7Otkt4lDANmrmVMb3C0sKyMjJ9H2CkD8owNPVqEhnr6iVBdVD95MMQ8
 NfNe79sokfqX3HBsaRuG72E43pq47h4PKprPIvAkRwhhYMJYlggv7jb1mRDxWa7VCjmM17sHm
 h7ivSoeS5z6VkWDS90v4fHsYqnutusTUs77wflSqO36wh2B9KR6OHpvbkocJe03q1U4Tt6xVn
 mRAaGotAwEfeIpwLM3GDSVvctnSRTeJZEIkx7KF04y4tTtIjvY2SGXGUiiHZCvcgdzqIW2OsH
 068tDTe3rVD+fRtYeiMVhoJ5cDK8GbkbW+FfA6CSqPqeoTrP0pl5C7xwagV26OXv3vdkPCGfd
 AfblSubCEVe6S/iaJ8l/h1W3Cq3o6e5zlY4JgQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592823939768715590?=
X-GMAIL-MSGID: =?utf-8?q?1592823939768715590?=
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
