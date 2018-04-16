Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217916-1523852129-2-8031276900081134495
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852129; b=ct8JoRMdNPlzlzta4/7emUaGwA/U7mnzozoLxF7C6E3jT95c/4
    HiwyPawftRR+1fkAr3EeC6zx2bd/Coaur/08KBh1WHlY2WeGXC7KmFUhl9ylho17
    swefkLydeqcUsyur1ZAct9MCtVeY1/CcbTE9JrdUdd7/YlrI5a0aUwNVk0wny0jh
    7IWb+U3IhZXMOI0kc23x880ctGOkJ2w98XNLMcGzOohwq8UVAgf5OEWa13uZnSwY
    Wr6vA0HTvrDPpOnVdmbXj2eeW+oJSue1vvB5vwu7xm78ARZ25SQnZAXXjxN/s6vE
    pOtum0TJQ8h1bFY5R1IFqWRj5+UA+t75nWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852129; bh=Nt44r
    QHXW6831WT/XSLd9DXFoiSdW25NqplmMOeRW9g=; b=VZGci5xgvd86GkrIFG+PF
    /OM8JCGI5WJOTxffbMecL6yAiBoPuUgufc56HvX5deU/2QmhZYeQs3Tbx4qD/Geq
    EKhg43mGdjcymXm0Uwwrv+6yoiTHkI9d3Ac4SAhKEXA75wbxaZX/9V9Yel6bAFG3
    hBaXJAOxZ4Rheilc+WtdMr3ak+YjXK2UKQ4cMOJ/UGpWVBRMZaeoNjzT4w6ePEmI
    0wcnWY9xDIPFN0eFvDS9FvBCu+i3z9MMLLr+L56FyP57OBI21a+F2pM5Wa/jJLQ4
    ev61Afs2wCrP7oKchxYDfzyMlsbOcY4QU03YWV+FleURlaghD0k55S5beiQV5gwi
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFQamdh5OkgvP8DQ8JcJZnfOunpQH8G1EItFo8FPrnIerc0gjoW/27HUFPCKyr7sfQz4TfpnjidUF51ZJTnfBWBgjhVJ+NLGF6cZqsQ3FPb8HWTBOwSu
    fT9bxf5AByvfieaNQgfnWAGS3+UBWVPln/hq/qW9H/fFMP7tMezzqa/FIppeDpP/a/JPvlf4+ATcbU5bTC7tTiFegPXu5KczffIs8kz6OgyTM3wxqv1Kb6lA
    Rt4eH4LCJHNyivyufnDalQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=C_FLGjQtIuCgZPq3FqQA:9 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 05/22] staging: lustre: llite: handle xattr cache refill race
Date: Mon, 16 Apr 2018 00:14:54 -0400
Message-Id: <1523852111-17321-6-git-send-email-jsimmons@infradead.org>
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

In ll_xattr_cache_refill() if the xattr cache was invalid (and no
request was sent) then return -EAGAIN so that ll_getxattr_common()
caller will fetch the xattr from the MDT.

Signed-off-by: John L. Hammond <john.hammond@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10132
Reviewed-on: https://review.whamcloud.com/29654
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Lai Siyao <lai.siyao@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr_cache.c b/drivers/staging/lustre/lustre/llite/xattr_cache.c
index 53dfaea..5da69ba0 100644
--- a/drivers/staging/lustre/lustre/llite/xattr_cache.c
+++ b/drivers/staging/lustre/lustre/llite/xattr_cache.c
@@ -357,7 +357,7 @@ static int ll_xattr_cache_refill(struct inode *inode)
 	if (unlikely(!req)) {
 		CDEBUG(D_CACHE, "cancelled by a parallel getxattr\n");
 		ll_intent_drop_lock(&oit);
-		rc = -EIO;
+		rc = -EAGAIN;
 		goto err_unlock;
 	}
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
