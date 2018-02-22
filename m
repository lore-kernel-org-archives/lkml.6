Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1141254-1519337469-2-15208879821904900495
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519337468; b=E7i1BnEpKGFlIZI/p9l/ewJXPWSmr6MAfqZCKzGlGsePJaF
    Cu1LDuG00GzgdMkurO9pqYzxUfsQnnH33aNe7gubl2StDzYa2nq+fn40ksJe8D4r
    2/M5d5ygi4nhulfWRFM/KLCNvzOjgkoAo6fQBgA2GvPPsrg5qBR/K4hNqkVg6Uol
    ZIfLKoYZMccCenYf3cGYdhhcnSNiF/3BBWeJA6p+Gg8cw+68oD9sXnim8Ikamppb
    0Je6ibzARlLdlQO+BfDYEq3tassvtwNpSTzS5aEJl4NuT5lXsfI0mFSwMEmtBzUZ
    wrBkHgDbX/XDjh6Wdf0Wd1U8zxLK1xCMebTP9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519337468; bh=H
    UcPIbC2P8qpXurTk2JZRbK5p5R6T43CBPZndKVI4kE=; b=kurQs80DjWMefIVe1
    436mxwH504cVkUaO/3hwOYR8fXobwT+NNw6Tx5ucjtAPVm2aOdvotEb1DAybySvH
    5eyPyud6MskObOJG3VkPwGQ39x+u5VvIole1l+qxFqPXDVHUHpFHtUJ5R8Hi1w8J
    WptO5S5nDnQ0fz/R1x3Wj/caeCJzXbZCE6zX5nwNYVXl40pIzs0J+diGpu4OFWQC
    3F4nCVIjLWTPsd2vbQ8yCM2qPKeo716ZgpBH1T4EQB00hQm+8ddUR3NFgICR+q8m
    5C+TV6K6MeZVFJ8U5M34n2/F3fgRnew80HTR2sld4FX6IzfB6h/UJm3iSKpecp4O
    pKlKQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 23 Feb 2018 09:09:33 +1100
Subject: [PATCH 3/3] staging: lustre: lnet/selftest: don't ignore status
 from lstcon_test_add
Message-ID: <151933737388.16436.11922095105762928334.stgit@noble>
In-Reply-To: <151933726925.16436.9827896439357574011.stgit@noble>
References: <151933726925.16436.9827896439357574011.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If lstcon_test_add sets 'ret' (passed by reference) to 1,
then lst_test_add_ioctl() ignores the return value.
This isn't justified - the return value must be zero for 'ret'
to be meaningful.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lnet/selftest/conctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lnet/selftest/conctl.c b/drivers/staging/lustre/lnet/selftest/conctl.c
index 51497cf9a832..a2d8092bdeb7 100644
--- a/drivers/staging/lustre/lnet/selftest/conctl.c
+++ b/drivers/staging/lustre/lnet/selftest/conctl.c
@@ -670,7 +670,7 @@ static int lst_test_add_ioctl(struct lstio_test_args *args)
 			     args->lstio_tes_param_len,
 			     &ret, args->lstio_tes_resultp);
 
-	if (ret)
+	if (!rc && ret)
 		rc = (copy_to_user(args->lstio_tes_retp, &ret,
 				   sizeof(ret))) ? -EFAULT : 0;
 out:


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
