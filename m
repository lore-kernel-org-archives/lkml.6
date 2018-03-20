Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-463642-1521525534-2-1480847725977826874
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521525533; b=iD3o1YKIY55aNuTzejFv6k2FgVZON48cNjGO69KGr0EoZGe
    SivfhwKMKxzMxp19/n6vAjV+YN1SdinfbegYbFoL9l1BpOzIJtIbh5Wf9kj+2eFh
    o7wEFJjV+IOSnO4aXceOeMjyGb8MGYN6m9v1nWCh/bGJu0N0KdtIQeIWop3nJ4h0
    FPEHa3r2GOJgcmy0mPkjNwFB/x/ckLrZvxwHhT/EAmDRT7vZAG8iQGgGeT2QNxP/
    U2ZO0BWzDUYZIHlOg//hIAw5tQibnWjNQIQM0AYxOkbDHa9WKyHtHCJ9HFEb1pf8
    e3odVWkRug6VgxrK/Nuz0WDP8CT4DZkB7pfjaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521525533; bh=U
    /O4Ss1NFkeaYUoRZOrkyQlbSmSkJPN6WATF8V8lD5w=; b=PXgDyzGhw6JHGQlW0
    I1VmGdi4VtbGm+DPAAkHXt9dfAFfCOrCYtHLk+gYJhxNn6sebZnYxoCsMUu/dIqH
    nj4NoM/pWx1afKzZMmzUwGx+8noydU3TznfbCSgQ19Z7ZWFPCRNrg7X3jm1tT/EC
    pBf3sPP3nCdgSAY+0nl1AM9DnJ4TN+k/ktk5BPUvEAd9CrPRDom1blwzqFe4oAuq
    OaP/j0fjUkpWOObtvCUOboKKI70zapkxHJU+W1pIATvZeXQ94CivLxwaYhw5cKCy
    McZ8JAbjt1m+uzfakEd5x2Je2OGFyecTDaUH5W6oFFrpY1hf7Q0gwzfqZ9yKtszj
    zvn1g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 5/6] staging: ks7010: Fix line over 80 characters.
Date: Mon, 19 Mar 2018 22:58:14 -0700
Message-Id: <20180320055815.32651-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320055815.32651-1-quytelda@tamalin.org>
References: <20180319185125.GA13209@kroah.com>
 <20180320055815.32651-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:QMXjJ/nhljDP0A+vz4YRWt9VS+0xdHdXVEjKT1liemc6WkEs7OE
 6OvNNw6QJIGX09LqoAr11e3nDpwxe6uwTSyICwpMCwdsCbOZjw5bUO8HDLdE/EMzomoqLyE
 LRe5U/AR4e1x6WR8kQ8GL0Yj/0Z6orZpzDwhTwz9OI5sm3PiRqJC5sfjFIrYiSGZHTXqc3L
 zmLV325PMK1zYuFcOPStQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cD9lz0RNrw4=:z/GwvRfYaXyhKw9POxwNsL
 G5wLGAX18lSMxCZvNHC3vZg4zfrVGOilmYzh9mnYZ+6N86CLpZTLUtLe66PIoN5a9jb1VAMFT
 QyAEUq5dVdCLRKlhU3MqEEO6vOAzKCEvqH/K3wToFqZX7tbFoE/R4LHLFY7ZOsCTk00wNnbuy
 AA89cWmgNpyeLarbPkaCSNy3UtGDrnxXNUytlMuJhITte6hgD1gyVlFrlkqYNpzajjYQ1XhS3
 KkyqSicq66scODm8k1Tn5sHwOiU50P393l5diwZdoAdXHfKT5Mhuzeb61Z7K628H0voR/YC/9
 xcrtQRU0mZl2QYtJp3q1XCNpvAJdxzjvE75j0ZTYjAVJzuro0v0XBu8Qfaeo83zZVKCm5UeH8
 5nZjM6wh7TUyTa3LVJyVaRNFNSbc1RU7qbQjYTSRJyYAeQL68iwcVUoGojEOEPbn/evN1iVX3
 MbLc0Uk9A4xwtPyIrAUeqnhWEfQ0n0dgV9GgxwW3qVgxJ4TX/E/iWiZnv8Rc4BHNoLUHXaZGy
 GRvIsC3snKRzPeWg9DUsoVE1Eag9f0P7DFr0sMYJY8u8dz+By5ZNdRBtEhr7u7WAlsHkY4JCf
 R0VlVki58i69oQ01yBNjuQLLa+wlnPuen7CnF+168OzPVmw4m5OUhgjdtJr/u3JI7nAM9WNIY
 2PrgkgQyo61y6KQ4UyCyLirVEKPuwVYDzZT/jxo6I12lF4/2Oh6fap7dqQ0CabCUsccgj7amE
 ribMaXuYbv5CMIXriEjtZUOeXYxVW/4VfsxRzA==
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

There is no reason for comment describing the BSSID check for loop
to be spaced so far to the right.  Move it above the for loop.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 2de4dbbcd9de..6fc2c3647908 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -844,7 +844,8 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 	ap_info = (struct ap_info_t *)(priv->rxp);
 
 	if (priv->scan_ind_count) {
-		for (i = 0; i < priv->aplist.size; i++) {	/* bssid check */
+		/* bssid check */
+		for (i = 0; i < priv->aplist.size; i++) {
 			if (memcmp(ap_info->bssid,
 				   priv->aplist.ap[i].bssid, ETH_ALEN) != 0)
 				continue;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
