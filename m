Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523852121-2-727912368562178464
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852120; b=ngYOL7/H+E2ewAegj7myQ5rsHUTTw5CN7TSsjrW4+boxFiZfyw
    NMVJ0btIp568EazoB02M0XOhsv1X58MuuiRWgqF/QAWFcfKFSqs0mY8COUCD/bfM
    XE6g6FrP5UEhaC0Cx75va703A3VaTgYCBKut+X8LDrppJakhexLCnE+/GpxteRh3
    kRokwCzKL/3x6HVfueCx2Vt99JHIUZDcTDT0/ICV+xsPTa9ImBpcXVOwefkrHl0A
    sZl0qj+Ua6Y0qqsJSmiOUn4MLOFhnGqGK464XuFiqWUS62OxilpGFY3Zy8FwxoFd
    lDg8MH6PvZXmmQ5JiL8LWUHNqoLvgyxbjiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852120; bh=Vvlk2
    vuYheUJ2tkSgSbZy6mz31IUMqFB5O9BhI62c7g=; b=cEqRv7bPFc8JYgO2+XPbu
    Yg3sIir0L7oq2k8yF0UQtBz/RofBgGvwK7Svks2Z8hNnnNaaSl7Ia8lGusGuQCCj
    hh1gqjXSrRSsO5gsJnzokrY/M7Xh929US7/vwU+bfs5I1mYUauPt4EekYlG3YDNb
    0y/aD2jFG1kuNywQOEFH+bCM8lEu2eIYmu71LukspBI9fJ8N40s6DtwBIdry4EnE
    q6nqW4glmWaJeZl2Vis6uGsiWFKzn2wrhidhPjZrDgQ43bk5CecVFxpsw0lefUG1
    BRkjdeXmOERakQWMJlpU1o4c6nPgqDvsFjDFx4rs7Bcrun98qIitrei0PBVma7B0
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfInTEkwav+MZ4tac87+EeJxw4hz7R7FWD0qcB6aeniZd2M42ua5Dt5uBGWRF4+MaZTXhaAWGrBdkktjoBjjOTzHGD4BG6LtH5hMReew+xqdHiSSekW+g
    1ke3gJ8qxy/Gje7DsfExa6ggArPX3WLBsBWh55U77RCqM4XsRPr6g0577ioQMiDo+PXjSAbFrk8kSY9COcywhZxl1Tb3gc4LHKQhuqP4PNO6fFSjM84ZBYc1
    67O3+tstfj0au234wbJVZA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=G_A3yXZcoxKKsCrDv1YA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 01/22] staging: lustre: llite: initialize xattr->xe_namelen
Date: Mon, 16 Apr 2018 00:14:50 -0400
Message-Id: <1523852111-17321-2-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
References: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the allocation of xattr->xe_name was moved to kstrdup()
setting xattr->xe_namelen was dropped. This field is used
in several parts of the xattr cache code so it broke xattr
handling. Initialize xattr->xe_namelen when allocating
xattr->xe_name succeeds. Also change the debugging statement
to really report the xattr name instead of its length which
wasn't event being set.

Fixes: b3dd8957c23a ("staging: lustre: lustre: llite: Use kstrdup"
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr_cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr_cache.c b/drivers/staging/lustre/lustre/llite/xattr_cache.c
index 4dc799d..ef66949 100644
--- a/drivers/staging/lustre/lustre/llite/xattr_cache.c
+++ b/drivers/staging/lustre/lustre/llite/xattr_cache.c
@@ -121,10 +121,12 @@ static int ll_xattr_cache_add(struct list_head *cache,
 
 	xattr->xe_name = kstrdup(xattr_name, GFP_NOFS);
 	if (!xattr->xe_name) {
-		CDEBUG(D_CACHE, "failed to alloc xattr name %u\n",
-		       xattr->xe_namelen);
+		CDEBUG(D_CACHE, "failed to alloc xattr name %s\n",
+		       xattr_name);
 		goto err_name;
 	}
+	xattr->xe_namelen = strlen(xattr_name) + 1;
+
 	xattr->xe_value = kmemdup(xattr_val, xattr_val_len, GFP_NOFS);
 	if (!xattr->xe_value)
 		goto err_value;
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
