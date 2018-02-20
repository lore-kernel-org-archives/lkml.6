Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1920138-1519108605-2-16849401283241914091
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519108605; b=M/AgQOGGOYF1AtkdvQQcCu6G4XA9a+LOiyNxYvqxp4f5zF9
    jiDRHU3XgoGJ+cVzoeR62K28tzYq+9EeYitXyXpKooq4czG2VRqk2lHF88qomyZL
    l0dOQSnoFA+cewx6NbD/ECq7zTwejO4eT24oNXI/Mu+qZ7w0ifEKB/3zq541G1Zp
    hXkeITr7MuUWRisPOTRatWEhuxYevDkAIlCfhbxAJ0k76i3g84aXjuxcWBwCQ98k
    a8fQCVomCKzyc8GCqfBmPqEu/Izh1Yrl/TfGf1zb/teOl7Xmt/nZIX5eYynsKlR8
    suwh+EN3iglA3/IvMxQZ36qF2Z/RADST5qvHcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519108605; bh=N
    JvAc8mdwFyyQTr/gx6KXJWarW05iLRam2pZcW+as0g=; b=kMzf4c4A0d2GTr+FV
    WoSPzUH5S9i3fzccJFcnViMG3YHkJaOsaLQc/fkSHN8A/nhu5DwAlm7leszZIl5G
    xoutmwYU3Rd1WeUpQfXIYPXeNTzMFn7/1reWuopQfJb4fRYZr55dzibTfvg2pOHH
    qtq1PAQQ6ctWLM+Qr27uROxmscoK1O86y6pXGx6PK4nq1iXKN99UIirYHIdghnJe
    /kh9o9D9CSvDsofBxRkT1OY0LaXyGUHE0ak1lmg0vmdDhUPzvL7nU0FRFJEj8tuv
    20q5uIINJucvhuoOHNc4vgwPQtPk2GT68O/5uN+8fWYyNUh9eOdQxtGevXyxS5+X
    KCimw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
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
Subject: [PATCH v2 3/3] Staging: ks7010: hostif: Convert the
 ps_confirm_wait_inc() macro to a real function.
Date: Mon, 19 Feb 2018 22:35:38 -0800
Message-Id: <20180220063538.6471-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180220063538.6471-1-quytelda@tamalin.org>
References: <20180219170839.GA3632@kroah.com>
 <20180220063538.6471-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:gEzLloa6Is4+PHLDExk6kc4yKdA5r0h6vduYE3R8MG+O1tvLhC3
 qr549SL67YNDd14UdNWdTGF1KPAog94WvMWAWJAtNZnT0TQhT9VAmBOnoLdrkHcy4YyI4b/
 BW+v4EADUQwGdtE46iSO2yKxSne7Vmm+9WPiZWut5te4WvpdJLdHQc3Qt98rvqtS+y7JI6s
 Dtr+GOIZZLVOG5n2b5yBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uztnACXpQ1k=:dUhbSv+kRst35nrfW8YHZO
 Ikf1E4MfgN3Esu5qsb7JqoGp5yfyTXGD/TtWi9Me4jS04xVhXQBOMlmEI2jDBejh78ZCSC8bx
 qO20TOfPSX1Goz34zhP5vQD9qKXrNLmsGL+eGhaq/1RyS9ayumiM23bq5aZORGV+YIDrZRTQD
 jtPFw2bAEkVBEq5PGpKlLDUgZD52HnRXUCNR8IoSBJgMhNBZ05txWbfZ5mnP9ywy3SxENd/c1
 6pAuXToxOF4jyeLA91AMZgVPMb/IuGe+xYUQ+S0UXLC9/QFk8x9dfaaOCQ8Me0G9Rn9BPd+bL
 UVt3yVXZZ1LIQ3AYqHTy74VSsxkHL+yp7/jx4gBxi6gZQTf6yAVQNtd2DXZvXq+KKaI5t39oN
 1a3BFFF+Cz7Db5F7tT26bj6OKuQb0iFt6QSJ3yZgvKMGMzXSukRts50Pp6EBqitXlE7U1hj+y
 HuofnAKcCTnKFHtAMU6KRUrwNrf+JP0aRIn7tfE2zbnpGNno02DTPcluHqLA4t89XHBfWvjWu
 L92NvVEqw1YNHxXb/ROY72vZymlXCwf6mpI1X3hxGSpgMeiXaXpvmSwiNAWWXV4tjxA6WjEXM
 YkYoWVXpWrrk/e4YQgNMPFFKM1h0sU67o6BCFfWG4TC7MXMgaNgXbDwip2PnVue6zY9cOwvOH
 JntOz9pvEgNDjMbfWu8aC2ETo4VKlobJ3nmne2bJuhusnqfGY66RaAqxl2VBaMnTRA/BndxG7
 plpyvBLgx7metT2PCGYnW213uVzIKAFJlZNUSg==
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

Convert the unsafe macro into an inline function.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index f554477fe6bc..74a08417bd0b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1308,11 +1308,11 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	return ret;
 }
 
-#define ps_confirm_wait_inc(priv)					 \
-	do {								 \
-		if (atomic_read(&priv->psstatus.status) > PS_ACTIVE_SET) \
-			atomic_inc(&priv->psstatus.confirm_wait);	 \
-	} while (0)
+static inline void ps_confirm_wait_inc(struct ks_wlan_private *priv)
+{
+	if (atomic_read(&priv->psstatus.status) > PS_ACTIVE_SET)
+		atomic_inc(&priv->psstatus.confirm_wait);
+}
 
 static
 void hostif_mib_get_request(struct ks_wlan_private *priv,
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
