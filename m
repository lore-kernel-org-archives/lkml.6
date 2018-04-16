Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523852135-2-11173968531046546704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852134; b=MeMzq7dVewvuUFGATfbRaPKs0HYGP6P9TrInRFgOqLNfXNIkwk
    KnEL+xwNrezV/TD52iDwSZVaXccqvgsSsHg9tZd4n8uT8rEb9JdR2riZxxTRiD8o
    QoCI4RPzMrcYsTyFQvHm3SBxYyzwmK65ue3GH8xe5i3CxIHfII1F3y1rkAfn60PI
    tgO2I5cwnCbuNSgtyqnFbjuR5G1GgP6cNv6pMlcAeXvhhdQpocQfGNs4MU6Nmu/V
    63j7Xh9NyEm6xhVNkUkukPRUlcFuP/VwGzwq2NuFjqZw/DLWy83R+ZVnEtwdkg7O
    GExaOQ/CXgU347usBJwV4l9MpJ2e1RTN2wYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852134; bh=4EWl1
    VvKxSDx/yHrAUG0KewnpdIfSzErq2HDRQkcvtk=; b=FzmclXXwKhiVDoFBCmvwF
    xp/1qztPpKsugw8k68qXqMOTiW06eFMieRSj8B1LuLaWu5+Iq+H6p5OjVNg3PDTQ
    O/8hG6iG6Lbut66j78n7HwLu1FPd7PXVjPmblQOEU0NZcVrSr3u01PJl3+REYHA1
    7IRzfeCeF/87oohF0ftEFqxHyFPAMS3ZH1ffoIzugLyf6IB8YwIDlkOfASeEQsi7
    0AeyFyt7k5dhxEtCKdPNUXnuqzik9iEpXkdZx3YLcF/mNF1hbtyqMB6UrNP4/HL9
    40VEUWbCPYJqHyiILSiMgaytEDwmmy4mvPZrPhW9JqQyWceQ8/ZjD1gxmQwhrC2M
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
X-CM-Envelope: MS4wfNWvYUDGBvBHrx/wS5RDUpCFKLc9RbVSJLYA8iPKaUD4nR12JYPeoiCq79MClMbfUX1nfBqfCAtM56IEa8EDP6htE7ff9TbCJmHAG1akFLLU/xEniR3+
    MT8z3rcR2xIHpHCsNFeXrx0ytIs6V4owy4A19ufHYX+PWcxil/jIAsBYQKWa6TcOG+HIBFKGgGctkm8Q0nxDhCrq7renXk2dadM0NLftV/CWzy9gDFdWICF+
    y2rNwAWYQaPbzuejo4+WGg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=CjxXgO3LAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=lB0dNpNiAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=EZTR2bPUbft1CpHv6JkA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=c-ZiYqmG3AbHTdtsH08C:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 14/22] staging: lustre: llite: record in stats attempted
 removal of lma/link xattr
Date: Mon, 16 Apr 2018 00:15:03 -0400
Message-Id: <1523852111-17321-15-git-send-email-jsimmons@infradead.org>
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

Keep track of attempted deletions as well as changing of the
lma/link xattrs.

Signed-off-by: James Simmons <uja.ornl@yahoo.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
Reviewed-on: https://review.whamcloud.com/27240
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Bob Glossman <bob.glossman@intel.com>
Reviewed-by: Sebastien Buisson <sbuisson@ddn.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 4b1e565..3ab7ae0 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -296,7 +296,10 @@ static int ll_xattr_set(const struct xattr_handler *handler,
 		return ll_setstripe_ea(dentry, (struct lov_user_md *)value,
 				       size);
 	} else if (!strcmp(name, "lma") || !strcmp(name, "link")) {
-		ll_stats_ops_tally(ll_i2sbi(inode), LPROC_LL_SETXATTR, 1);
+		int op_type = flags == XATTR_REPLACE ? LPROC_LL_REMOVEXATTR :
+						       LPROC_LL_SETXATTR;
+
+		ll_stats_ops_tally(ll_i2sbi(inode), op_type, 1);
 		return 0;
 	}
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
