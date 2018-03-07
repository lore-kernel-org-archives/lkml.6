Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTp93CmpE/WqpE0Bs48D5j14nfoDzbPqbro+xPHukMSpIbEsMVDdAXCwCZLA/N0KHncBfH
ARC-Seal: i=1; a=rsa-sha256; t=1520452061; cv=none;
        d=google.com; s=arc-20160816;
        b=DeDSwqoEu2hZs3zYQHl/TUNBoSmK/O4/nxJGEvPDVCGmTEO4HGrwMdjG6QkK0AU5j/
         xUsVIv1smEUrhq6RLWCEt+JMbD1hrR+IcvqaC1KHRY7zkt9+bOeLRR9IhDoTA/7mSVwk
         M+LbrlN4w6H7kg5YYlznTiIBgCE4CEXgcoD3Egcx55Tumexs0SYN7wE/qOMZ5ordaHWp
         cpq1RaxqdeaeuVfBnIPtdm4LMrl7guX1xTze26mL8q7pI1XNMaSjgQR7laZ8fZvI5xiu
         uOaxYFE4obVPhXnlj+Ek5Y83HROAw0g49Qe/tjQMdlH9VhOGLTtmxSnMS7yn4BIbXu2u
         OM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j34lhTM6j0/LHGa/Uh7gO0y95QHMHXoj8VydIAKVW7w=;
        b=mRUj0fpUgfqiYWHhq0abkxy0bkxN0R5dRnXRKMvWjfKukQI+Xltsp3ocFrqwhNXi7W
         yUXn42EUhVFveJ6NAs/iJCOnkps8eVh2dU++meNK+QqB45+m1/Rd9VAQ4tAycFbN7//y
         Rljy9/HX/QjUWu9zFLRLqOoA8dsbDSfyXaqE/qvOukytD/HSO87Oug6hgZ+o+B64bD3c
         knv3hh5yMO7aZdJs4i4rjET/5+l2KWUc8LpF/je9mmcbQlZluIJv4+nhJNyy7ns33KHY
         CZb9FHD/ayuz+Qu4YI3qJfchIlQfwijUjX/zluuvzwHIvzy89t+4Zaj+rTT9RvE9Lw2k
         mmKA==
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
Subject: [PATCH 4.14 055/110] doc: Change the min default value of tcp_wmem/tcp_rmem.
Date: Wed,  7 Mar 2018 11:38:38 -0800
Message-Id: <20180307191046.687342513@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309163240228221?=
X-GMAIL-MSGID: =?utf-8?q?1594309540654607311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
