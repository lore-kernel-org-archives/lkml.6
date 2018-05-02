Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1143910-1525285323-2-14704986659320110047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525285322; b=IsXh727WDZWhg8+mbghYTNFeeXvUg/+nfUNszZ8o3NfWiW3MaP
    Tjbvfx7PYNuowfGBkgz0yehaolJLz79UK4I3C5RtV8XPPX0s/Ldupch/QwJ+vzhf
    7JDABs7jmREYkXyUjJATLIy/Ee7qcx+3ziyELo76YlEmLsAR+EDhs3ky5IX+iMxG
    S3cZoLw+GHdygoHqJljX3d9tUsUI6b0Ci65V8KQyTbgyu2z7ojLewI9VK2l9SjKh
    gwjB4+BWet9RGWyTTla09WzXn2znnut8KovkKbs5DPdVjEVB/NzKG2UjE3H6iTpZ
    xFMmKu/46uWn6z6gWOvyKm9cv49yCATp8Kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525285322; bh=39bvf
    Dk/GBFlEEXPutpN7ZaBxnNX49uq/PmizVEb3oc=; b=RXMwgJ9GATKeikI1RJn2e
    PrbMvl69BEm+24JkGT/LoiTX1byb/d7vcK1+EG5+wfujG7eHDCsIAdq98mjMwdl3
    hfJpN6yuPk5B2KALfANIR2COQLH7hfvpRFsAZo1U6XsrCltQIj5CcHRYLmUM4ZHn
    2m7U0fIHNQo2fShS0CC6zZFE3Sc3bGsFUbIfIx3ZnRPAl62SXs00/kuUzV6IzOu4
    S8gMGWGTS4QZGrQMoMjZ2D9u6CUrIevJ4IF8VzXLXI7Z5apJ+ZLOJXaEgKJniHHd
    OwXFpiFhb0WqyKB0lTsi0aZ/p7aY96LjlOpEuIcqp5Ky1eoQXlk9SCWUQBbLkMY0
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPl1Bq09m2M5S0+Uf0NygXtmS+imlMlvTT72oQwt+Py2fWkw+gxoBObkzvS6W5HRX/4XDwWJdLnyEJdn2obht/BuOMq1aD+mhsyvc03T+IR8czHYfnRP
    +xLTSKh81ajmvKQctTEwycv6YZ3tyFNNdByB6WlqrVaRUh/ShYiYYcBJNF9ev596IGsXfw7oCWrZczQunimVrBaEaGTcbNNR41h93fyDqJty3qZVglAPCARJ
    //aBrfxmnJD4FRT6DUpNrA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=nhO6SZ1-xRM643X4H_YA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, Lai Siyao <lai.siyao@intel.com>,
 Jinshan Xiong <jinshan.xiong@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 2/4] staging: lustre: obdclass: hoist locking in
 lu_context_exit()
Date: Wed,  2 May 2018 14:21:46 -0400
Message-Id: <1525285308-15347-3-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
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
Cc: "John L. Hammond" <john.hammond@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "John L. Hammond" <john.hammond@intel.com>

Hoist lu_keys_guard locking out of the for loop in lu_context_exit().

Signed-off-by: John L. Hammond <john.hammond@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8918
Reviewed-on: https://review.whamcloud.com/24217
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Jinshan Xiong <jinshan.xiong@gmail.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index 04475e9..4e4dd58 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -1711,10 +1711,11 @@ void lu_context_exit(struct lu_context *ctx)
 	LINVRNT(ctx->lc_state == LCS_ENTERED);
 	ctx->lc_state = LCS_LEFT;
 	if (ctx->lc_tags & LCT_HAS_EXIT && ctx->lc_value) {
+		/* could race with key quiescency */
+		if (ctx->lc_tags & LCT_REMEMBER)
+			read_lock(&lu_keys_guard);
+
 		for (i = 0; i < ARRAY_SIZE(lu_keys); ++i) {
-			/* could race with key quiescency */
-			if (ctx->lc_tags & LCT_REMEMBER)
-				read_lock(&lu_keys_guard);
 			if (ctx->lc_value[i]) {
 				struct lu_context_key *key;
 
@@ -1723,9 +1724,10 @@ void lu_context_exit(struct lu_context *ctx)
 					key->lct_exit(ctx,
 						      key, ctx->lc_value[i]);
 			}
-			if (ctx->lc_tags & LCT_REMEMBER)
-				read_unlock(&lu_keys_guard);
 		}
+
+		if (ctx->lc_tags & LCT_REMEMBER)
+			read_unlock(&lu_keys_guard);
 	}
 }
 EXPORT_SYMBOL(lu_context_exit);
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
