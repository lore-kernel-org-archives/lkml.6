Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpWHndwBoCWeUAR4NAGnNXX/nYG9JoN0Xe23S6OnOSbfj61qm77cMpbPNQzzRM3Iwe3zktn
ARC-Seal: i=1; a=rsa-sha256; t=1524838000; cv=none;
        d=google.com; s=arc-20160816;
        b=bflXTG64zBY30HameSMtXUZnFQ0C7Vq0gKE1v2WcupKA2MGWMu0PfMze7JeMKn0iZ2
         XkDJkjlReb3jcKVal+sOzQtEDwEaS9cbWdBgKEESYPk5IT/sgd0iCJ/Ym4J2qIYkrEBr
         PscbY1ywggiyBrc6UXwVnmJcK60H7EbDR60EUfUekE4G5+q5GRHwyJ3t02rqdZbr87AU
         ZkoC4czFPozWh/2uDYbgv+ygiWNxErqK3ZJjVAg49MRE1gwJPd7MJtw2PspNlCUJqrYy
         Zejz2hTJ/Zd+oPDZrCHYK89IJPmDqCDt5WX+nioF5wyIz+1IuX3eWKhrTK1LPRKWbu0Z
         DyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Cf+Pm9LfhKmqFtvRY8sxYbMjxt4ZGLWNBJbsdgICVcA=;
        b=HD38hZu/lqyjU3qYHckLOholve6siuxWK8V2qKNegLGaCYTcx3IjuZl3Aznun6NkNb
         VyxoiJtBMUDmSf670BfHziEXOhedZ2GbeW95ahsdNryMAsZzD40fqHDHoGj66d8RhjDF
         E4Bac1Tcg3Ft07wz6VkxNagLdOtQ5KlC4tUoC4MDqPNWEw7utDU4d1WZz1byaheU7NuV
         W+mCo7lkwvIrImentX35uG949PEi4pnI5knB2RjCFjVeP03G+xkTjg/utyU5S5q4kPa9
         0+hsAuk8Y/xGNSV0mFDtxZULZdrq1BVAg01E9pV8GgCzLrFBIq+jSYfdQDPRSpPCCSK/
         0Ufg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3E121890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jon Maloy <jon.maloy@ericsson.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 23/80] tipc: add policy for TIPC_NLA_NET_ADDR
Date: Fri, 27 Apr 2018 15:58:16 +0200
Message-Id: <20180427135734.128970961@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908243113314844?=
X-GMAIL-MSGID: =?utf-8?q?1598908531244480323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit ec518f21cb1a1b1f8a516499ea05c60299e04963 ]

Before syzbot/KMSAN bites, add the missing policy for TIPC_NLA_NET_ADDR

Fixes: 27c21416727a ("tipc: add net set to new netlink api")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Cc: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/netlink.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -79,7 +79,8 @@ const struct nla_policy tipc_nl_sock_pol
 
 const struct nla_policy tipc_nl_net_policy[TIPC_NLA_NET_MAX + 1] = {
 	[TIPC_NLA_NET_UNSPEC]		= { .type = NLA_UNSPEC },
-	[TIPC_NLA_NET_ID]		= { .type = NLA_U32 }
+	[TIPC_NLA_NET_ID]		= { .type = NLA_U32 },
+	[TIPC_NLA_NET_ADDR]		= { .type = NLA_U32 },
 };
 
 const struct nla_policy tipc_nl_link_policy[TIPC_NLA_LINK_MAX + 1] = {
