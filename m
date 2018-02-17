Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1614509-1518834363-2-5574714605472190229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518834362; b=lbuPfXkppqzzHqPmeUbOrb4wSS1Mj04ezslUfeHGDMPC0+T
    DqGQ+PdJDL4rhO+G+bp/6XG2Ju2wKx023v/x//4NAouX4n7SXduQIZ3sltzjOuRO
    mH8LgAIjJFBtlw0G1RDX5pHW8jc9VQ41wfLt70nHaF7D4mpZrsv+BVT8WaPDSuSC
    4xuJwJfFEGBronZUOnM5SGh6n1708NkJs/21YnPzWusxAa1jfOMt4SaRKnT3ly4i
    tV29RNpM60uiI/XAjrxzLvSWMY4uO2F5Zi/I8Zw4ZC80wHP8pfSouu3SnydV5kX7
    nVW+DPk2botu/+VlIwYs/mfntr/NfghJaCNOi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518834362; bh=O
    O3GmS5Aer6w/YSViZt1MLwwdo4MLnkqgFa9vORQzEA=; b=uWHknwjdug5kZ/riC
    EBrJkVr7Z+0Vc8Uex8pwDp1ezVgDsxYie4I6I/BuWxj1KesYEyR1xJxoaGBpVYWi
    W+MowXKO6Dklpmjn+CfWMqA90IJmKFrSVxXvJjFL4ysVz/pHj2GbbC71pygOrq/K
    iPkbH9D33081JwvEFoS4yel/pdo4QrrUliIz78zWDNuZFNiPK9Js5bJb+JniqK5i
    BlYaFH0inxYnOYSb2WNhSTIzWgGpYSl02PsEvgb0eOQ+9SZBQKIj4MgK7S2NPEDR
    qE9cnpDYfY6h1PdZh42JRNKCXLTpLu/1tCG13P5pMHF4xUol0Ew7JeeEwo6AlMZn
    HxarQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 4/4] Staging: ks7010: hostif: Fix multiple use of arguments in
 ps_confirm_wait_inc() macro.
Date: Fri, 16 Feb 2018 18:25:03 -0800
Message-Id: <20180217022503.24982-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217022503.24982-1-quytelda@tamalin.org>
References: <20180217022503.24982-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:wbi28CcRn2hImfZqDy7pByH7KJtG9Z4lvITLCgVMCdir9Pkp5v6
 5EAB/YoBA3UyTFnhUv2ASPrMdBHZqrF0BoBqDBZIdF0XF9ta1rzydlDmWZ4REYEAsJCN5zE
 7uQ7VO2fGcSwVqIMb8b8y1vCkdWq2woZWk3qVis3+ewGL92Afh1Qs4pb82gDJCdojPmkfP7
 fJ7QrkP6yEUwu6kJjjeJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ltYgGuMpeNw=:7yUz8cMuNRoN/tWwQYgOE4
 WR9FUZMR/UeunLtOPQlEql6s4q6H1ARTb92u8WH4VHr4m2QcvzSs8/l57jFt8kS/+HhA1n+To
 AwN4wGMJOT0JE/rqyu3yPEC7XtJ/UeGbZAr4K8pocLpJHoBYBeuqRqhfcoD56aB6qUjWNMqZk
 r2rL4MvR2m5XfzlB419EhGXglVyw+MEVMTDykupwpYaURPNegd9F7nX4zT0Z+Muxm5lLHoAFK
 7gJ2cOfTVihutfDybQMG81yA94OuY6UIPPQfqZvKMCajb+3hz4wVHC7qhXIBhiAv6cQqGmJE0
 lA47p+h8c1OTw59cePkLM7vR1eQ+V7hbRVFuC9cXcpJlNvuA0WUQJHt0AKCdQUuXQnYMH/5Ts
 i0BoqOYnAy84ymlaNSNSODKuvogsnOKfOeScLIT2+WjDrd73wroLWMie5dYEMoNWSmxhzwtzi
 frEYMFtscwnRh+FHQrwaQY/m/T0jGSJgHG8U+IAK4acKCPB+3sq/DTfTmo74VHtzGAj5sZsvS
 gBrg6stZKanZ4p+aa1iGm467k7ZUNscbVCxg7AmsR/INa7slkibHIXW+DLHBgANRiu0x1FiXU
 CJe4IxTPa0Od8PQSCwwLYsS31yfpoYoB3VhyfmzDlhBJoQp2v5uETL/xFuSSJ4X72IC6k2PWE
 wGHJyKKnMAE3cR29LbAhJQ+woKFCJVcDiC2hMBX4F7jTa/dRPhP6qZUIaOFq8LfjQixQ02N+2
 nu4TBJ/q9uBxZGcIj6L182Wf5tkTkS4/7lgJIQ==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use GCC extensions to prevent macro arguments from accidentally being evaluated
multiple times when the macro is called.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 30c9592b3a00..92035e8ac843 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1306,11 +1306,10 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	return ret;
 }
 
-#define ps_confirm_wait_inc(priv)					 \
-	do {								 \
-		if (atomic_read(&priv->psstatus.status) > PS_ACTIVE_SET) \
-			atomic_inc(&priv->psstatus.confirm_wait);	 \
-	} while (0)
+#define ps_confirm_wait_inc(priv)					\
+	({ typeof(priv) priv_ = (priv);					\
+		if (atomic_read(&priv_->psstatus.status) > PS_ACTIVE_SET) \
+			atomic_inc(&priv_->psstatus.confirm_wait); })
 
 static
 void hostif_mib_get_request(struct ks_wlan_private *priv,
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
