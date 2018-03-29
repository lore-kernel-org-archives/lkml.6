Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+VMB1lIDIIAYxLT+aGIUWNWDtRG5Qjcc5neLeWCKJvMFevrb1vxNJcRoM9cQljl/Q5MmvD
ARC-Seal: i=1; a=rsa-sha256; t=1522346615; cv=none;
        d=google.com; s=arc-20160816;
        b=WPS9VyCz73Pu00ZLdFC5eReHB/Ng1fI7zG3h8w998z8xgcdrmnByFh2GKdFa+tDE/0
         tWptAuBDYcrynK2PABq0uFRgK/SL9xgrqVuGh9605QnQqZ4B5HwKalKCr3n1e5+uWsVZ
         ocqHj8+XXPw+DpjMIDPzuq8qfZ1Vvnk3rUBA36huw0oBOAZ75akLgyegpGzyWbHZZcNG
         egs+4XMJipLF0Q2XqATc0XShAobKlhy6dPnJkPWaZVAQFJsvPrwQFpSk7NBHySJmV/YV
         pJIDBpAfbpnWBmFX5JfDt0s18ElLybjmRICAewAGmmGwxmN809pLj1+trOMlpD4ZnogM
         MPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KRCh+LBVn7+kcp84Ozw9tGpNQjWpkxT4xn4YGqHH/bc=;
        b=bKZT9rVMdNJIDw2Js/8//4ubvyDjZbSnwjQpqpFMqSSMpjEZI6ASCyHcqso1grR0Dc
         yKremFKelrFqvWgzcguQTf9Fkcniz9KcPluido4pL9MLeHOe+SBtFqWMxxzalZD4RTGJ
         LB26IilxCbXgnodxfcpIHKQTVRliyFAzogDjr9KbDgJbHXMJJpnTUFPVbEHezuzkW4A4
         UIe11ynVjeHcuIDD/5Oc7uSkQVBYNLkioyXp4B6zBvGtgEWdEO0Obn17yZ4Sz8480tMk
         rJUKh3pq9IKnrd3wIv5mZcNhj1jQY0koFn2A0dh0zy4qKmCT6vKnCGSuLBxw/Epgmd+q
         vXSQ==
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
Subject: [PATCH 4.15 11/47] ipv6: old_dport should be a __be16 in __ip6_datagram_connect()
Date: Thu, 29 Mar 2018 19:59:52 +0200
Message-Id: <20180329175729.950436079@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296124821816513?=
X-GMAIL-MSGID: =?utf-8?q?1596296124821816513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
