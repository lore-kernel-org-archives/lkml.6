Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3733408-1521094723-2-6464741139357890718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521094722; b=sk31rQH4ezt6NO8K3ylI3i67HNfPYi4pgsx5xpee9A7Z6m6
    Iz1EMgXNijpRjY5/ARtNzokYF+a4D6cB8O61uft92NB33FnyKzGOHzpogZoppkfs
    WVshEvdA/VaN8IM7kt2zBMx2K2Bs4t9cBaXArHLwGkkd6CJklAgF6WhSoHXbhNlx
    6S/0+/+5O70vMHfcfWfDgrWxfPdiPksQzOvweBwTMyZOZJ6CBaOcohGpLZ27+NXe
    lGAL9Iea0bfEKMLccibgrLFG+yd1wNoclsn2Lnc2nuv/SvMbpYlOTvDkt07CQ50F
    S7khVn00oEKZpnHJAVcroKz/haG0LTJ7gk7E6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:mime-version:subject:message-id:date
    :to:list-id:list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1521094722; bh=tNfa6oG4MdeeFuc2ANahhffmUXo
    rK9cePS2ozbEIW6A=; b=MS3vUctpKJVsxrvixK+9IizAtNFp6ggRjI8bIZdtAQ+
    FCA4wSPiTpcon2TxjsYQvcuTExJgPWDr++pBy0KgGSgCPgrcTQA0R43G5ZG2qlGA
    RJPQK84QisBT91jvnxP9psqLnptQsH4wXgjYSU/sEJvZj8fM1KVCVnGBh3B4ycSb
    3CWLyh/tKXHnznR86LpmbSa00EWRaCbTDRhkcSh6ayq3k+c8cBpjgj9YeQF2jReW
    eyrY+WAvUbciNYgcG0Th2Snzp57TTOW/HtJW0SYE+RvQ+nW7UH4+pSiuz0qsPX7o
    KfF3bjv4SZR2pBEKHlFURaoi9ff5hI1rcfPg0QA2eqQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=me.com header.i=@me.com header.b=3kKAsHQf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=me.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=me.com header.i=@me.com header.b=3kKAsHQf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=me.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-03-15_02:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1803150074
From: Doug Oucharek <dougso@me.com>
MIME-version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: [PATCH] staging: lustre: o2iblnd: Fix FastReg map/unmap for MLX5
Message-id: <B5E4E902-16A7-4279-BE5A-8117E23286E9@me.com>
Date: Wed, 14 Mar 2018 23:18:30 -0700
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, "Drokin, Oleg" <oleg.drokin@intel.com>,
 "Dilger, Andreas" <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
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

The FastReg support in ko2iblnd was not unmapping pool items
causing the items to leak.  In addition, the mapping code
is not growing the pool like we do with FMR.

This patch makes sure we are unmapping FastReg pool elements
when we are done with them.  It also makes sure the pool
will grow when we depleat the pool.

Signed-off-by: Doug Oucharek <doug.s.oucharek@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9472
Reviewed-on: https://review.whamcloud.com/27015
Reviewed-by: Andrew Perepechko <andrew.perepechko@seagate.com>
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: Doug Oucharek <dougso@me.com>
---
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |  2 +-
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 12 ++++--------
2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
index 7ae2955..355c816 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
@@ -1702,7 +1702,7 @@ int kiblnd_fmr_pool_map(struct kib_fmr_poolset *fps, struct kib_tx *tx,
				return 0;
			}
			spin_unlock(&fps->fps_lock);
-			rc = -EBUSY;
+			rc = -EAGAIN;
		}

		spin_lock(&fps->fps_lock);
diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index 6690a6c..6ed779ef0 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -48,7 +48,7 @@ static int kiblnd_init_rdma(struct kib_conn *conn, struct kib_tx *tx, int type,
			    __u64 dstcookie);
static void kiblnd_queue_tx_locked(struct kib_tx *tx, struct kib_conn *conn);
static void kiblnd_queue_tx(struct kib_tx *tx, struct kib_conn *conn);
-static void kiblnd_unmap_tx(struct lnet_ni *ni, struct kib_tx *tx);
+static void kiblnd_unmap_tx(struct kib_tx *tx);
static void kiblnd_check_sends_locked(struct kib_conn *conn);

static void
@@ -66,7 +66,7 @@ static int kiblnd_init_rdma(struct kib_conn *conn, struct kib_tx *tx, int type,
	LASSERT(!tx->tx_waiting);	      /* mustn't be awaiting peer response */
	LASSERT(tx->tx_pool);

-	kiblnd_unmap_tx(ni, tx);
+	kiblnd_unmap_tx(tx);

	/* tx may have up to 2 lnet msgs to finalise */
	lntmsg[0] = tx->tx_lntmsg[0]; tx->tx_lntmsg[0] = NULL;
@@ -591,13 +591,9 @@ static int kiblnd_init_rdma(struct kib_conn *conn, struct kib_tx *tx, int type,
	return 0;
}

-static void kiblnd_unmap_tx(struct lnet_ni *ni, struct kib_tx *tx)
+static void kiblnd_unmap_tx(struct kib_tx *tx)
{
-	struct kib_net *net = ni->ni_data;
-
-	LASSERT(net);
-
-	if (net->ibn_fmr_ps)
+	if (tx->fmr.fmr_pfmr || tx->fmr.fmr_frd)
		kiblnd_fmr_pool_unmap(&tx->fmr, tx->tx_status);

	if (tx->tx_nfrags) {
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
