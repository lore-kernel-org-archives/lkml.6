Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZocng2oUpjoqj5hi4pOJuq+BlMvive/M5acHtUUJm/H9vJORQDjMl9zF71HFecbFz/wFUei
ARC-Seal: i=1; a=rsa-sha256; t=1524837951; cv=none;
        d=google.com; s=arc-20160816;
        b=FncPzWJgra+QELuNXRWynRJnnleMhj+2H6ESj9jTBXbp+xtu+BUGbSRrifTVNX7r3V
         SI4qkPJNHeb9VQUN7xFHpWSQ2nQzSnkmduydK0Oz2ibPQe+rtKumQ4XsFcfluCC9y099
         rfYuzBaE5COOOP/fheq/sWsrGBMzKuiZdlHp1+IKLK76/L0vT0s3fbWIlH6jLf9GHvEV
         bxdJe88OoB6MkEr43zbPfHsKYmjW9FxvF12zCKgYHYzK7VheOzQ/FLeBCg3MQNAmvKbd
         NtBdZXu9r3/6WQDO04mQiwh5w1EHP88axI1FTso+GbkjjZkNXFpCt14+ayJM+lYP7kn8
         Lk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=mgjFfhGTzJud4lpMFjB+fXSN+3rxt/u8oNwKyAdvOqI=;
        b=NUH/DF3w1XMUMc7ijDGhonh0XE/XgIqU54sb9pLIFuW316UkloQDzJlf7i+hu5jRWU
         cTBVNl6CQJULDt9amrAEUDceUJhpaqOMXsvGcIqw+dHi9OsRyRTdLHVxD5MKheVQEkjq
         qxkXU1LoTaGYXkn2j/wvMIP6S8Iw54fvCvMCwdkQwY6wENW4Vy5wWo2tnb9DwsNoHXtw
         87wP6z1ZYrqw6PVSu9IHIHC966E7kiF5ui4QLwtrAySgIljJ9lJFrY2VtlrkQn1yIp1I
         0ulvDlN9zMF4OfFyFKzattb/VxM3Nn/QM8t4WIKQGHbQ5ol7kYP4mT7saoIxXEtYDlbx
         1lbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB2E21890
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
Subject: [PATCH 4.9 56/74] tipc: add policy for TIPC_NLA_NET_ADDR
Date: Fri, 27 Apr 2018 15:58:46 +0200
Message-Id: <20180427135712.254938417@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908243113314844?=
X-GMAIL-MSGID: =?utf-8?q?1598908480273591343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
