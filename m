Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851834-2-6213404963933752487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851834; b=eL+5IIWisJ5H96jbTSA/Y55CIeu+SYzYwE57gWWol2dLVZ4mER
    HlT8fkVAqQ+OgHqy1ZAWEkrrNt1KxI7TbMdWsKV6iwzkBVlKJFjy1lyOv2HLmgWS
    5lmysYofA2l9c5j6FR7lqo1ySPgUpxy/XBt7MlSeb0C+gd8FE2+s54xhxdYd7T6n
    lS8PktFyrDECq8/ObzQ3+UeJQkPfGM+wiuiB0ljrx+0HLkGTnQ826AU/6cQzgGYX
    6CufrSVbW4FDoS+DpioHn4BcMezAIhs5j7UO69uhD+ITJecV+brIsek8vYu4sHVu
    uW10VVfyyyNJh7V/YJiHBXBauC8YuqGhUHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851834; bh=lX3Do
    PSAbvGj6N0Hfxvp+O++QIAeSSaLmlCAEoaUDFY=; b=Dnoqp2nnb5dC5k1FVi1xL
    gibgVSsdy6LkWSTIoHMH+P/Nnodl+TPvBXp31D6Q6zXdarj8s8z7lhr+Kok4mrYD
    apR1ixAAVhpWm2bkcCu7z0oBJhKqwyCg8ifeT2U+QnL98VhsWpjexEiixbOK+i8K
    Qy7RSwhzGxeZPmBb3gMREZrS4EbonoAbWedgy8n0zPrhdklfmgJxP2PZ5SGBW6M3
    XrR9YmnqqBYmDidLEXsebXah1U+L5xG1e5zB/4bqaOsYK0dJP7gycAHKSmoe3Rry
    +L+iPhSK4q6LVbzuaBkJSLN7nGWfc9Y2uxop8TNKBwSRBCDvHbwZ+E1TXfNVoced
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLYRg6dHQbPFLVhvIgVn+3/6MMclZMJfdV52Pdie8874XVgUpbTaCO/73CS/0VrEmQkiloZo7aIPQ8/i0BXNs2R2GNeFMiD5m9LY6JuUwhrW6Kq4Zbka
    TVGO4NYwDZfviWMnS9CQg95NghufvavbNvLYwUn05Y+sNeZyOTP/MzIlILpRNoL20h4wF06D4G0UJU2LKmcCr58P9LHgUEnj1jcqZbjTfweij22ndwj6qJNS
    8PhA0MelGEknP98pztF+1w==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=eJfxgxciAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=kYcOqd_WnoFtyF432M8A:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=xM9caqqi1sUkTy8OJ5Uh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 11/25] staging: lustre: libcfs: invert error handling for
 cfs_cpt_table_print
Date: Mon, 16 Apr 2018 00:09:53 -0400
Message-Id: <1523851807-16573-12-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
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
Cc: Amir Shehata <amir.shehata@intel.com>,
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

From: Amir Shehata <amir.shehata@intel.com>

Instead of setting rc to -EFBIG for several cases in the loop lets
initialize rc to -EFBIG and just break out of the loop in case of
failure. Just set rc to zero once we successfully finish the loop.

Signed-off-by: Amir Shehata <amir.shehata@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
Reviewed-on: http://review.whamcloud.com/18916
Reviewed-by: Olaf Weber <olaf@sgi.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index bbf89b8..6d8dcd3 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -158,29 +158,26 @@ struct cfs_cpt_table *
 cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
 {
 	char *tmp = buf;
-	int rc = 0;
+	int rc = -EFBIG;
 	int i;
 	int j;
 
 	for (i = 0; i < cptab->ctb_nparts; i++) {
-		if (len > 0) {
-			rc = snprintf(tmp, len, "%d\t:", i);
-			len -= rc;
-		}
+		if (len <= 0)
+			goto out;
+
+		rc = snprintf(tmp, len, "%d\t:", i);
+		len -= rc;
 
-		if (len <= 0) {
-			rc = -EFBIG;
+		if (len <= 0)
 			goto out;
-		}
 
 		tmp += rc;
 		for_each_cpu(j, cptab->ctb_parts[i].cpt_cpumask) {
-			rc = snprintf(tmp, len, "%d ", j);
+			rc = snprintf(tmp, len, " %d", j);
 			len -= rc;
-			if (len <= 0) {
-				rc = -EFBIG;
+			if (len <= 0)
 				goto out;
-			}
 			tmp += rc;
 		}
 
@@ -189,6 +186,7 @@ struct cfs_cpt_table *
 		len--;
 	}
 
+	rc = 0;
  out:
 	if (rc < 0)
 		return rc;
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
