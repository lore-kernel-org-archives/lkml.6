Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu3uP5DGKyAYhZA+6ADUjQypslAoH39DlGU6w2+BJk8DkPLGsTrJm8iNcoRLN4BPC5Bv9qh
ARC-Seal: i=1; a=rsa-sha256; t=1520451701; cv=none;
        d=google.com; s=arc-20160816;
        b=0orelO3OO0nj8E5UHPJVt0rx3w2mDyLw+QkHNy2dbXT1s+ZsXrLdMp5Qak5hV9EmB5
         lu0ux69SaE0AxABWZ5MWd6G5OWN1uZtuf7PJ6tmxXJYCU7554t9MivZ3dShlxFAXi6V6
         qvPAR0UzN2HbSrUTZ52JZdgu869R65nplLfXfREFad5nFykR/VQq2EOjP8xFyyK698GL
         I0k0jPS3uMStd/rydU7AIJX1y9WM3a7xdwIK14mw2ZrqB4POS9yQPMqr/SMpl2KejrAx
         xyX7pD3ycvA60ecXa0OimvOgf9Zit19lAnpuABCGutWtF79j5tQPFkVF6/d8A6eMD5cK
         nxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3FL3MxMzoA9A4gMhi1GHAQ6WzzoBFAA1HY4WQq7XF1w=;
        b=b9lRLlve2ucjfJnUIbNP0u+jqNRpi2Igx0J5upChvDC3if3878yFNHGdz/kmFXoM0T
         T/ig6GGqMVIw/+3aIwSnPkZtOWU4KDiWvkLbzl2mdkzr/ZyJXWcZYbk4cMDhrV/uWjZH
         HnV0tOVugNTLfpWD74jdqc9xyFZzDd3q7FWjZjaO68WHmmpmxLX9h9Cf6hzYgneawFYF
         u6wI4BXe20xfYwbQYsrZOzInhLpke13GUk7WhqsA8fd9+svvsK9p0FUS+789qN4XhQiD
         YeJxzthsIygdTn/tVG8uYb5S/cfOVGbx5YTPv3vKvqJiMCl+RtycenBSDNP9r2317w8E
         AgpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Tonghao Zhang <xiangxia.m.yue@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 060/122] doc: Change the min default value of tcp_wmem/tcp_rmem.
Date: Wed,  7 Mar 2018 11:37:52 -0800
Message-Id: <20180307191737.951690072@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309163240228221?=
X-GMAIL-MSGID: =?utf-8?q?1594309163240228221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>


[ Upstream commit a61a86f8db92923a2a4c857c49a795bcae754497 ]

The SK_MEM_QUANTUM was changed from PAGE_SIZE to 4096. And the
tcp_wmem/tcp_rmem min default values are 4096.

Fixes: bd68a2a854ad ("net: set SK_MEM_QUANTUM to 4096")
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/networking/ip-sysctl.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -508,7 +508,7 @@ tcp_rmem - vector of 3 INTEGERs: min, de
 	min: Minimal size of receive buffer used by TCP sockets.
 	It is guaranteed to each TCP socket, even under moderate memory
 	pressure.
-	Default: 1 page
+	Default: 4K
 
 	default: initial size of receive buffer used by TCP sockets.
 	This value overrides net.core.rmem_default used by other protocols.
@@ -666,7 +666,7 @@ tcp_window_scaling - BOOLEAN
 tcp_wmem - vector of 3 INTEGERs: min, default, max
 	min: Amount of memory reserved for send buffers for TCP sockets.
 	Each TCP socket has rights to use it due to fact of its birth.
-	Default: 1 page
+	Default: 4K
 
 	default: initial size of send buffer used by TCP sockets.  This
 	value overrides net.core.wmem_default used by other protocols.
