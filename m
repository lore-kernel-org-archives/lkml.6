Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48U0BQCPgaCWgZ1R1IGSsCgbVjXSrqTK0VWktlEVC5pnXK26dDz5U5ykRHG1wFKTn/JKSj4
ARC-Seal: i=1; a=rsa-sha256; t=1523473036; cv=none;
        d=google.com; s=arc-20160816;
        b=e2mMB6V5rZdoPNa7aFuSEu2YPsX8JDXjsN0On0bnEkRLKwKQpiNQhSDd+Udkifxrev
         6SbfPhVAlRuZii3uoU3B9M/slVmUj0zFWy+JoyELqJOOzNOPpmaxfdTWVWKaBgF5Fdcb
         pq/4/EmDCQpvagB8rnYksaJC/IdxGwjkqMg8K6zYDmyqmR48tGXITs+50PxDn9izbm7Y
         s4wsRtX+YsVY5s5sZAn1gG+GjYcLRF4HKe8T1Lk4Yiq9+yztEnFKJ4rVS5uVFlCFI1YY
         uCwWXlmjqlxfabnonetxex8sm/k+q58Kzyy5d53ZXA9d60gYQyFw6hZ7I9KrxMN99IhH
         TrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KNc3BLRitxE4EJIbNSVPammJqPl6egt6AcDGjfwaEhI=;
        b=s30Sy7Bsgc4QqDr+9pXazvXLduNjxvZgckX5JgSZ/CVm+M2kc/+sKPrD6JzY4Bc14E
         AwpZi5tAJUNd9CJuy54tq6n4PNvEst/sZndXi0t1ghURCV7NvYtADx3vgtSfZHfwoAE+
         reh+VrjVNR17iKFTZ8RzOEZmQaUrPRSdlRws+lGb6zgXbHFhY2IHvS6zem9kE5eoaFGH
         idvstMIGegkrzJ3G9HVMOV6dvmL7ytX++E1VGYiew+Kobdk/nlbbDAxyLNMizm3m9dHd
         fUSUml+E4EOTmAnNWGBlqeRcvMsdboU+T2bFKtwdLNmtmWXUemVt4qCv/N4HPtCnWqYU
         KRDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Holger Brunck <holger.brunck@keymile.com>,
	Zhao Qiang <qiang.zhao@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 072/310] net/wan/fsl_ucc_hdlc: fix unitialized variable warnings
Date: Wed, 11 Apr 2018 20:33:31 +0200
Message-Id: <20180411183625.405667765@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477262701073863?=
X-GMAIL-MSGID: =?utf-8?q?1597477262701073863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Holger Brunck <holger.brunck@keymile.com>


[ Upstream commit 66bb144bd9096dd5268ef736ba769b8b6f4ef100 ]

This fixes the following compiler warnings:
drivers/net/wan/fsl_ucc_hdlc.c: In function 'ucc_hdlc_poll':
warning: 'skb' may be used uninitialized in this function
[-Wmaybe-uninitialized]
  skb->mac_header = skb->data - skb->head;

and

drivers/net/wan/fsl_ucc_hdlc.c: In function 'ucc_hdlc_probe':
drivers/net/wan/fsl_ucc_hdlc.c:1127:3: warning: 'utdm' may be used
uninitialized in this function [-Wmaybe-uninitialized]
   kfree(utdm);

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Cc: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/fsl_ucc_hdlc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -454,7 +454,7 @@ static int hdlc_tx_done(struct ucc_hdlc_
 static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 {
 	struct net_device *dev = priv->ndev;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct qe_bd *bd;
 	u32 bd_status;
@@ -1002,7 +1002,7 @@ static int ucc_hdlc_probe(struct platfor
 	struct device_node *np = pdev->dev.of_node;
 	struct ucc_hdlc_private *uhdlc_priv = NULL;
 	struct ucc_tdm_info *ut_info;
-	struct ucc_tdm *utdm;
+	struct ucc_tdm *utdm = NULL;
 	struct resource res;
 	struct net_device *dev;
 	hdlc_device *hdlc;
