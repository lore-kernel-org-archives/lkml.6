Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851843-2-13457510103280619033
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851842; b=YST31HOtdQKpkEi+E5A660JciKWKvzTprGDJsCmdFS80Z5Y+0N
    bBnfrzYr1Frw4j2bhUHA0akleMEPTuoZg8IWwrwa5RpUJJ+UhoRKEfT4xuqccRsP
    yrsnh6BF0N9QxiHBb4aw9DD/oY13siU8FNw4hM13OXQaPHuyB8oENYk71WskT4pu
    6M9jHlgptoIChDDGyyse+SYYCFfo/W7Wclbr5yztpyeUXcTgRoANOzP2gy4K25o0
    oi8xy/TZYKr/rG34PrLAI9qLhAFW/qzGVZM1S4cW9Lf4rtkeZM+ta5iK2YQhKi4V
    PsHZNRLsOlChjLKUOEF9cLZA9oVXy9n87Gqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851842; bh=Altse
    XzdrcvPBbanElmXTbYYQrYTB4T45uMibEOGqjc=; b=rnH+xGZMi3bPSkb+ROrYy
    dPFtz2/bQIRod8MFzjhqpQWpn1eXqZWQAjkeUa9gYf9AC/UpF2I5EM9r3tmkq/s9
    wy3z6BB9beREFDm9De0KRciLE//rvECI1WRxTWGdR3M3y9JLf1kQpkzMy8+QCjAc
    aUc1wQZbe5lyjKegSq423Sa4BPhq49FXar1Hs8XFvrpyoggjcKsUZHKeNVy6TuZU
    rFKW5ZXvB24scrrpepthd10iSvHLLF3VwNPvMjZ9RCEoxM5v29c2Mlpsy7cc2OvJ
    WF99MIYZFozn5BpTOVVhcfUoKpL7RJhaZB4gPW4jJHlD2/6Xr0/TC999uSZeIzVo
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfO3H/OgcZNpUvSYX6ZiAkt+t33FbukYqc2vAvmLbQ4DZckEp5uk6HL7LdSaH6Rc1AVfYosbl6dLoTtzs8J5aqppzrXfr9s4kF2eHe4nfAh1fvb+fBVQW
    qnMC+xT9adTJ+wcb0/FA7zI8rWXgOIbBWBlW+YBxe06L5dKfnJvsnJMBOR+qjy+d3nqVFKJSNemoYj/5bO1/gLk7vl8VUtL6+AdcC/3r+DDTcR9kT+P5Qu5H
    vSGzfJonTpAIFXXmSY6AUA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=S0HLI4U28tife-j0U-MA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 14/25] staging: lustre: libcfs: rename i to node for
 cfs_cpt_set_nodemask
Date: Mon, 16 Apr 2018 00:09:56 -0400
Message-Id: <1523851807-16573-15-git-send-email-jsimmons@infradead.org>
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
Cc: Dmitry Eremin <dmitry.eremin@intel.com>,
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

From: Dmitry Eremin <dmitry.eremin@intel.com>

Rename variable i to node to make code easier to understand.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23222
Reviewed-by: Amir Shehata <amir.shehata@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 1669669..5f2ab30 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -550,10 +550,10 @@ void cfs_cpt_unset_node(struct cfs_cpt_table *cptab, int cpt, int node)
 int cfs_cpt_set_nodemask(struct cfs_cpt_table *cptab, int cpt,
 			 const nodemask_t *mask)
 {
-	int i;
+	int node;
 
-	for_each_node_mask(i, *mask) {
-		if (!cfs_cpt_set_node(cptab, cpt, i))
+	for_each_node_mask(node, *mask) {
+		if (!cfs_cpt_set_node(cptab, cpt, node))
 			return 0;
 	}
 
@@ -564,10 +564,10 @@ int cfs_cpt_set_nodemask(struct cfs_cpt_table *cptab, int cpt,
 void cfs_cpt_unset_nodemask(struct cfs_cpt_table *cptab, int cpt,
 			    const nodemask_t *mask)
 {
-	int i;
+	int node;
 
-	for_each_node_mask(i, *mask)
-		cfs_cpt_unset_node(cptab, cpt, i);
+	for_each_node_mask(node, *mask)
+		cfs_cpt_unset_node(cptab, cpt, node);
 }
 EXPORT_SYMBOL(cfs_cpt_unset_nodemask);
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
