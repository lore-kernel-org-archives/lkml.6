Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523852144-2-362438969701153386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852143; b=scg2duVh7aahHoxRswpebv3Rvj1eJlNA6uPpmOwhcHJF3FIF1g
    I0V8Tv/i9US6JgxAV7lxrQTJ/TfDDzwc27vABGvNy2iD2iKOgXozbCIXsejdePTX
    mHr3Bi65InpvOP0oNOkqFh+qkL2jd16XVfNWLOJkDu6HpweKEiYqI+JnENPPuq6h
    fmrSwFPuEHczBp3lg0nNV2VRSFrRmpqtVvzv/LsfU57Or8b+tuCt50vjB83LZiBf
    7zsoA2VtcV5BvfWWCCv7TU63qYPIEUs994n+84UIC6rwmEQIpzRKefCjmUXVqjcH
    6+4SdzxrpFKGLD7317XwkEZSyXriFHwqAgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852143; bh=hQ0Re
    7w9UjsYqxkQEtnFIkLFyyUs6gYcL94tzXNlPgo=; b=MtgOrm0AnLV32/d08iXx5
    52tB08q9dtMJrf/41P6/N4xoiz8P57S4hocF/42pCCWZn7HJWjNGStFmc194VL2K
    xEcNMuUWYbZNt3JZbH176eyvQBYGDLHuefC9O/5y+kEOufdn5pXMFoQJdvpiQIQX
    TIWo+oXKebFLbQPeaOHdLd0lXczQ8darOH2GSOEB/TSvkHkz6+Hy5OkE5iECoWnH
    WtW2BL7CKNPD8XadYhFsPh+cQSzeeyj766z41bitnpLib8z/Gh4rmfZKWdNbgYIL
    z/5uOYjg+06G6P7OkwqhdCgOmWtYSsdzdzG4L1WADeaUzYE9rtAEi5zQfQ2MOw95
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfPSBwRfljuLCDr5oXMah1EWbIGKwCOLzKK5Fx8eWwu2dfGqbpZEs3X4kGtiYCfYmcCL8EVyiq0nqGHwTYj5IAnCYpXfSATNBw8Rc/Nl6fVdljPRV2ZhX
    fM2Fxkf/SDfRaaDKeeiiT+2nTjyV/k4Dfl2zU6lXL5NRGXEF8i0ql8rQ1nRFtd+UwARdm1GQxgHupv9cLgFF5pGC4PQkAmXU91i75fvCJuI2+zlK8+sIPgpg
    6I0c3jLzLc538++Drdt/TA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=K6p6VKlL2JPSnN8yU6MA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 11/22] staging: lustre: llite: eat -EEXIST on setting
 trusted.lov
Date: Mon, 16 Apr 2018 00:15:00 -0400
Message-Id: <1523852111-17321-12-git-send-email-jsimmons@infradead.org>
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
Cc: Bobi Jam <bobijam.xu@intel.com>,
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

From: Bobi Jam <bobijam.xu@intel.com>

Tools like rsync, tar, cp may copy and restore the xattrs on a file.
The client previously ignored the setting of trusted.lov/lustre.lov
if the layout had already been specified, to avoid causing these
tools to fail for no reason.

For PFL files we still need to silently eat -EEXIST on setting these
attributes to avoid problems.

Signed-off-by: Bobi Jam <bobijam.xu@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9484
Reviewed-on: https://review.whamcloud.com/27126
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Niu Yawei <yawei.niu@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 56ac07e..69c5227 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -254,12 +254,20 @@ static int ll_setstripe_ea(struct dentry *dentry, struct lov_user_md *lump,
 
 		lum_size = ll_lov_user_md_size(lump);
 		if (lum_size < 0 || size < lum_size)
-			return 0; /* b=10667: ignore error */
+			return -ERANGE;
 
 		rc = ll_lov_setstripe_ea_info(inode, dentry, it_flags, lump,
 					      lum_size);
-		/* b=10667: rc always be 0 here for now */
-		rc = 0;
+		/**
+		 * b=10667: ignore -EEXIST.
+		 * Silently eat error on setting trusted.lov/lustre.lov
+		 * attribute for platforms that added the default option
+		 * to copy all attributes in 'cp' command. Both rsync and
+		 * tar --xattrs also will try to set LOVEA for existing
+		 * files.
+		 */
+		if (rc == -EEXIST)
+			rc = 0;
 	} else if (S_ISDIR(inode->i_mode)) {
 		rc = ll_dir_setstripe(inode, lump, 0);
 	}
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
