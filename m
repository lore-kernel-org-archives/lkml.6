Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqtOCzTu4o8340ziTHGF6h/mK09euJJGnEN+7rVTGjX3fL/0EfEeOVTTnIFXBpE2pjGuOPA
ARC-Seal: i=1; a=rsa-sha256; t=1524838028; cv=none;
        d=google.com; s=arc-20160816;
        b=uNYKf1cCW9XmUU+BoO6y/eO1E+DipmNjBU3fz4q122l4jfcIcg0SVHzc9Up4wIQXq1
         GZX0l/2A/nCAmnellD015eRt3w5HPDzZSVESaFgK3eZJqAMWf7MgBBPl4CA+iW2cGnc9
         bPKI/Ram86+2tqS/WfqiJ6WXkRn7b8u80e7apnw/MUdQr4Tlz9TgM1te6NUFz9VRIwVR
         xu1vMODFAam75yzi3poJ+mnFOF5Cxqsk5iMYwafV4SmZX+X4Ns/Dx/2myB6WAISgDPRD
         DRthZie57oZ2y85mwWLklgsbo6hH+X48PSjFe4OSPeR6LNXFukHCH+e21aWA1v9sIbLm
         zY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=s9x3202xR3rUwXvdGD9K1mOUXozwLOQJYzKsjY9aDxQ=;
        b=byR4Vkde2OKGr2q92yuUiXIWngZUQJ9x/cR3wAETo9epEpOZ4Gu0zYRDpmCjHsEy6e
         iS8IZhsqMrixxebQnobdlosKi8Dx86ff7ceK7WF4JVvH6eCeP6UaNTLwrW9/0umlwMfE
         Cr8sDvbbiqZeY6kEHrdr1ds1IPFD4AbaR6Rsv/LjwWgEIDpDMN+uGOQdyuDmT7GWYRXd
         SB4WrSBAsCzgYo0JB6GosbMNPi357587NaGzVlwg1uxjJbQhUKQK93S7YD8XlQvpDWpJ
         LoCE2dZ6tXs+GYOBGkPq9BbiSqN1auLtI6kjWDOj4gCBd5O6lVsbIWpirBDMGtl25PGl
         6rYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD7C21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Aring <aring@mojatatu.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 32/80] net: sched: ife: signal not finding metaid
Date: Fri, 27 Apr 2018 15:58:25 +0200
Message-Id: <20180427135734.608327344@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908426646306967?=
X-GMAIL-MSGID: =?utf-8?q?1598908560807211356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aring@mojatatu.com>


[ Upstream commit f6cd14537ff9919081be19b9c53b9b19c0d3ea97 ]

We need to record stats for received metadata that we dont know how
to process. Have find_decode_metaid() return -ENOENT to capture this.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
Reviewed-by: Yotam Gigi <yotam.gi@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ife.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -605,7 +605,7 @@ static int find_decode_metaid(struct sk_
 		}
 	}
 
-	return 0;
+	return -ENOENT;
 }
 
 static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
