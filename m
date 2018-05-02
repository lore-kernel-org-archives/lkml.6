Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-507227-1525252629-2-7222657248620343044
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525252628; b=di77Y/Xn1Jl8oNkqhj2zTBYnjTFLQ3Gigsodt9l5AZUMSe5Os3
    ujVvWP7XRLZUGv96GQZ4HPuCUdgsQf0N+HaWd5QN5FDbxSPFw+SNJg6dQ5lFL681
    Z6P1/o+Yi5kApPpbeFfZI+5H+YN8YCPMHpadLyiy1kBtDPx0+0fG2MQI2kmzDGb2
    y6icVsIzaI9b8KBnH3sXpHYK5+gyVzkkD2AHZ3G4Y1wRrLn3ub3KGPV4drF9xexf
    FSb+zeP4Mjr3M39ttjMP/ebzvTb6TJ0bk9zTBbSLOgnGLflRsm4jX55UrEOCQvH6
    BZwt2p6jNO+xivUvnN7eZdomWfJPlVqg3W8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525252628; bh=hiPu/
    FTnZcz4YeSJtWUTJQVn2LbgzTFyMYi6/B7oGtA=; b=Xz2hKQMEqt+x16X7Uh3Nj
    brdQlbHp+2gZab0FyYG/DwbnkVIQ90PyoyKnHvEuf7mHOPknTHAdTCyT5LJKVOgj
    aaggb5G3aPkDyXII0LFZjUW0HqNFMQs2y4muUVvlMCtxot9wbCnT/ko2lLjvC86B
    R+Yv2gnqREq/HmgnfBBhKPtcltzbI8leTMQLkKNmUCYCWOH/gMRnzc4UGEhH/8lE
    ZhJAb0oFJwQZBVGtFbzPEGyN+z1P2oUJqe1kml7kwe3wFgMFlng8iYfmbJ83qLfn
    o46/WrvEfdDhg+30aSQrlq1WcAKleU/a4mxNpc8RZXTBd+TXy6zw947ECR0DGyAY
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHRffVGUznWFBWHRHyictgjUFv727u4GVpnuMPDvHu8EURoe3PTJuUSkmq6jWObj1ATytiu+8ZQIgT+8kE/LEbtD7c3YeoAKIwBc2kjBP3QbGsCZuSB3
    s5JaZdQD8H0Sj9kMNSSBiZaIwTpcB8w0fGAOJHihlWrMQOtwLYx1ZbXArdiEByNBnW6S8bGpe2Z1p+pIsX59h/AYODlpWnLo8eQ2ss9rEQLzp+6Ssrjs4FFT
    k1rqffZ4oQA3aJWoKVQX+A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DfNHnWVPAAAA:8 a=DDOyTI_5AAAA:8
    a=ylFe79CpHciaR5Zzz28A:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH][media-next] media: davinci_vpfe: fix memory leaks of params
Date: Wed,  2 May 2018 10:16:58 +0100
Message-Id: <20180502091658.17110-1-colin.king@canonical.com>
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
the exit via the label 'error'.  Fix this by kfree'ing params in
error exit path and jumping to this on the copy_to_user failure path.

Detected by CoverityScan, CID#1467966 ("Resource leak")

Fixes: da43b6ccadcf ("[media] davinci: vpfe: dm365: add IPIPE support for media controller driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
index 95942768639c..3e67ee6e92f9 100644
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
 
@@ -1275,7 +1275,7 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 		if (to && from && size) {
 			if (copy_from_user(to, (void __user *)from, size)) {
 				rval = -EFAULT;
-				break;
+				goto error;
 			}
 			rval = module_if->set(ipipe, to);
 			if (rval)
@@ -1287,7 +1287,9 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 		}
 		kfree(params);
 	}
+	return rval;
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
