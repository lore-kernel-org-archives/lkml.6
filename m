Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+lU1TBnT5HenDkL/i88hM9bCIb+C7T9Pu4qKdRkO3KDBzFkSjxkfqX7L0RjEnyDlSaRMaf
ARC-Seal: i=1; a=rsa-sha256; t=1522346697; cv=none;
        d=google.com; s=arc-20160816;
        b=viO5HbHN+HPf/8tLXXj3bnH3u71JT1nX3foCg5BQuV1oubS7cc1+c5Fu1VMNWGXS8F
         dOf/nfN54QwZcPBXV5XHi/CoE3J6rq//ESfcmJjK4ftyn83WU/NJFYU4ndo/VXJ4mbyL
         sfiGaeNjHb0S65s1E8RqpPXNTkKZLpZbX35ecyUzLDieaOkVRhYl4lwmeO8m1ekhtu9P
         2GElHBdL4xBOulIYMIYZ2dBaNobgXkwCmirSkrzdmkfN6Gt38tFGeVFWBcX91bZYpMHe
         Js3YSn21oCOxh+tBQZXdyq6xwFLedw2Y0MlbinsDriGImCEVCX0AP2ZyGWYjB/P/0Jee
         YBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J/uvxtcf/9Ak7Sl/r/ILvVAEEKJiQEqZIsajbQ1pDoE=;
        b=zN+L+1cMsG+bAsjSLQXTBtaoa4xfMvqgovsKglf4M91gH9omc+1Ph/g3tvZqb7T4Y0
         C1M+//vh0kzsNOxbLlgGWn9I5ywIQ1xpbAe54CA6EdroPlvDNN+DYFDWcWAX4TkCH6en
         E4nMPdnG444yplGwfLmLZeOgxRsr+DgCh/ID1f4cLjAO23f3VukmrF9FgtpdtAlec4qQ
         kQ3c5X5bfBhnkZYdv/QGubsnwSHt/FJKNdsxMLpxIVTA86QiO8mLMV+eg45Fhywf9Rrs
         TPXFcwdmWJHTrnq43uISdZd/QshvLxXHcGt0HdRy68B62WCKr0C/ajwcZip9KNy1q3W6
         30NA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefano Brivio <sbrivio@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/43] ipv6: old_dport should be a __be16 in __ip6_datagram_connect()
Date: Thu, 29 Mar 2018 20:00:04 +0200
Message-Id: <20180329175731.074305003@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296124821816513?=
X-GMAIL-MSGID: =?utf-8?q?1596296210534306741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>


[ Upstream commit 5f2fb802eee1df0810b47ea251942fe3fd36589a ]

Fixes: 2f987a76a977 ("net: ipv6: keep sk status consistent after datagram connect failure")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/datagram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -149,7 +149,7 @@ int __ip6_datagram_connect(struct sock *
 	struct in6_addr		*daddr, old_daddr;
 	__be32			fl6_flowlabel = 0;
 	__be32			old_fl6_flowlabel;
-	__be32			old_dport;
+	__be16			old_dport;
 	int			addr_type;
 	int			err;
 
