Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-675218-1525261692-2-2571678382315732849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525261691; b=JG6j9YK1E620zJtxqXj4gP8O4y3kWrmd6Cu/mnfVDFmMIp3bRi
    msgFb43nHJhxGEyBFjLrRy9MvJRhYSSeg/gw5tR3bbCWE3ELkAnq7ELQn4vF/s/G
    QstKNi47+hKz9v+NLK0N06ZDTigAf38TdYIZ8Zuyni9q6n5oERzRaL6ajeEN+18X
    NzOs2o5Sq6zmAm1XNuf9ZN8pNECqmugyAbkwkOcCThRIdt7cDdrnhS75C4LIx1XM
    fxXCiwXNwKfZH2HTShixiRU9z+xtENbcP4ggLT9zP+LzpeQ8vJmgorc2x7lJ+ycD
    e6OJjva11uh++EFPE8bmuOQNMqCU+RtKJ9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525261691; bh=HwCaN
    Z8RWMzLtjAPTxQhedtUYWxmBTqoPO05UCSUVEE=; b=AerODrIpdCqn1BuDh2uNV
    Qshsfg82aBYxTXKYi/86u3/L2HgWYLYs+Nk1yHy+qfxgEFfmBH7wSPyXKIkwWF/Q
    EqnUs9yU9owf9VIrib1IrI98AbDKA1QyPaV0cBOvejZVURgti5iBRGEKbrjMPfGl
    G9C7toNEZ4ymM9LgBuan6FEzoOh/5YeBCHI9m4CoFO/972nBiE6tKqeDIts4IaPK
    Z33yX+qTGu4oup74axFeiEJBZFAiPWoDBJoeBj4sajaXmuNidkKQJg3M4FIpMPUp
    wM+706q1hvcGGinBQcXGvSN4MMQjA3AowvaA5Baam0vaDgV6+mo3CfZOj+wtGBKi
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN8mGpCNIHK+XjT+juD3veOX4mdIax6gWCpD0+ZmliyoxPLdyDX0exa4ilLXvQZSwWaI4UGIsQLLilGB2+9/S5KCRHa5U30x6aKnaL/6NlOfSPyQzRlT
    naTkByF5Q7878GKz2Tbe5e56jDHyXs8ExlulDNaRpOZ/EjN1fw5JAm3LvZusUq9kf1xPR//C5U8urKDVb3N6wm5xKSylocNHtTInJZ2JqzAIg8CJPa6jFNF1
    hCZOl1S1Su1wgntMvGvihg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DfNHnWVPAAAA:8 a=DDOyTI_5AAAA:8
    a=Frf6XfRpuPrtAsMFoH4A:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH][media-next][V2] media: davinci_vpfe: fix memory leaks of
 params
Date: Wed,  2 May 2018 12:48:00 +0100
Message-Id: <20180502114800.28004-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

There are memory leaks of params; when copy_to_user fails and also
the exit via the label 'error'. Also, there is a bogos memory allocation
check on pointer 'to' when memory allocation fails on params.

Fix this by kfree'ing params in error exit path and jumping to this on
the copy_to_user failure path.  Also check the to see if the allocation
of params fails and remove the bogus null pointer checks on pointer 'to'.

Also explicitly return 0 on success rather than rval.

Detected by CoverityScan, CID#1467966 ("Resource leak")

Fixes: da43b6ccadcf ("[media] davinci: vpfe: dm365: add IPIPE support for media controller driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Add checks on allocation of params.  Remove bogus checks on
    pointer 'to'. Explicitly return 0 on success. Thanks to
    Dan Carpenter for the suggested improvements.

---
 drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
index 95942768639c..b135e38a18b3 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
@@ -1252,12 +1252,12 @@ static const struct ipipe_module_if ipipe_modules[VPFE_IPIPE_MAX_MODULES] = {
 static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 {
 	struct vpfe_ipipe_device *ipipe = v4l2_get_subdevdata(sd);
+	struct ipipe_module_params *params;
 	unsigned int i;
 	int rval = 0;
 
 	for (i = 0; i < ARRAY_SIZE(ipipe_modules); i++) {
 		const struct ipipe_module_if *module_if;
-		struct ipipe_module_params *params;
 		void *from, *to;
 		size_t size;
 
@@ -1269,25 +1269,31 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 
 		params = kmalloc(sizeof(struct ipipe_module_params),
 				 GFP_KERNEL);
+		if (!params) {
+			rval = -ENOMEM;
+			goto error;
+		}
 		to = (void *)params + module_if->param_offset;
 		size = module_if->param_size;
 
-		if (to && from && size) {
+		if (from && size) {
 			if (copy_from_user(to, (void __user *)from, size)) {
 				rval = -EFAULT;
-				break;
+				goto error;
 			}
 			rval = module_if->set(ipipe, to);
 			if (rval)
 				goto error;
-		} else if (to && !from && size) {
+		} else if (!from && size) {
 			rval = module_if->set(ipipe, NULL);
 			if (rval)
 				goto error;
 		}
 		kfree(params);
 	}
+	return 0;
 error:
+	kfree(params);
 	return rval;
 }
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
