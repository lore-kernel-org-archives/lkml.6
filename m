Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217916-1523852139-2-4450531467139549682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852138; b=fJPsz9++6U/k1apJ4U+l1niBt8g/YvVmOK3JKuBtWWiG9utBgB
    XCmUROK2A/iekmVSr4LMzeXEMV4qZcTyXIK7LTYIFyGe07uK/cSD08a9T+p8zz8c
    VJZjIuCkR1k3dMINbTW6NKtoNbIaOjWWKro/Hh1LVak0C7iZhLqz7pbdjwvX7rcH
    qxK2W8sxy+e9pYuVqcTSVFSJ6P1bWxXtUAj/JNxuTh0ToH4d/xMqmSI+xneYGyqW
    gkCfQzOGqNcBSbzLdANHWuQPUwziRDR+NjtKgoiRX+k/9SCEwcxJ1p8VVMKVEV/k
    8Eb7Lw2o5DHd/ZKm5e2S/u+6wCbR8shtQiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852138; bh=XFxX+
    u7ZG7vnVt4LtvGwhhSDl3nGUtXvwxIDV9CEJmU=; b=Lhwfp1wni1tqJ6jK4KzRD
    R8bm5RWzqD4clHNQaf7VerEWIa6+/cA2/LUzvyhu6RnCcgcm1a29BGpPfZSRiJzE
    UIoQ16Lv2/Nlpekq51r6Ah8FoayLc6gcywGx4DITGmJNHzKHmyU7hVFOflFpvuz5
    5XDwYYF0xMpkEhHJuLC1zOHEl6R3ZnRrevlp8v6Dr9Qae238OAhAOVNLfaExrWhT
    HRAnJYEFh9v1o7EyiDG/tTf99loznS8cnKUGYOWfAlb+/FTeyqguZH8vdXOrNE6j
    QCp6doLmpr/uISPiJnxbiEUUMKAKmCP0pHM3rVmR9VwhKKeHuJhXbtsF+LeZQfTF
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfIUXxbQthrtiV8+DmTSBlWToecF3+vyi8nYKwrPyJL3Ikv+gD1MMooTifuVsgVp0Be63rfCGeNfVIiPgsfQJF9Bm0txvYTdESTu/wy7iPRzafy9mi4jD
    mDtAMaDBu+RnEYzv4QxaOhLMJAWMLqZIRdPAaOS5LRGfm5J0s87g5wlew/1r/D+uuc3GR9IVRLnfZXA7u7jPZu5uz5sIbBNMNUZb+c0PxcaHLB2yXwEOmIfB
    z8um0WMnSmXAmL7wJdSXTQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=CjxXgO3LAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=lB0dNpNiAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=7gJlR-9D1uUywZSEeTwA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=c-ZiYqmG3AbHTdtsH08C:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 12/22] staging: lustre: llite: fix invalid size test in
 ll_setstripe_ea()
Date: Mon, 16 Apr 2018 00:15:01 -0400
Message-Id: <1523852111-17321-13-git-send-email-jsimmons@infradead.org>
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
Cc: James Simmons <uja.ornl@yahoo.com>,
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

The size check at the start of ll_setstripe_ea() is only
valid for a directory. Move that check to the section of
code handling the S_ISDIR case.

Signed-off-by: James Simmons <uja.ornl@yahoo.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
Reviewed-on: https://review.whamcloud.com/27240
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Bob Glossman <bob.glossman@intel.com>
Reviewed-by: Sebastien Buisson <sbuisson@ddn.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 69c5227..42a6fb4 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -234,9 +234,6 @@ static int ll_setstripe_ea(struct dentry *dentry, struct lov_user_md *lump,
 	struct inode *inode = d_inode(dentry);
 	int rc = 0;
 
-	if (size != 0 && size < sizeof(struct lov_user_md))
-		return -EINVAL;
-
 	/*
 	 * It is possible to set an xattr to a "" value of zero size.
 	 * For this case we are going to treat it as a removal.
@@ -269,6 +266,9 @@ static int ll_setstripe_ea(struct dentry *dentry, struct lov_user_md *lump,
 		if (rc == -EEXIST)
 			rc = 0;
 	} else if (S_ISDIR(inode->i_mode)) {
+		if (size != 0 && size < sizeof(struct lov_user_md))
+			return -EINVAL;
+
 		rc = ll_dir_setstripe(inode, lump, 0);
 	}
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
