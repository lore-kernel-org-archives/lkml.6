Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1521860-1525930726-2-18402578099759975708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525930725; b=RVEfmTdGxVzjI/XxCbbFRUauAS57QlPzz+kkTibxSInTX1mVAD
    NDb+oaAkmK56/v+UXxB+hxSrf52Ka/dInb+bdPfJcXi/VGfmKl6lTb2CYY4hBTMy
    DFdA/STnodK5afYoe7BZHWoAE/G9fzK+ikqd7Cgd2T0MaGnpg0ipkc/mhvKA9ftV
    syUPh+Cs4+9FCrNxOjtXyzO+QBRmeO8oE00xTw5mymBGLNGhbwWxsIKL2JOCiBB8
    QgUd6rIdZaTCOQb+X6+T0siz4TOnmyKVGIKVx+6gbbhPA7htEHKlClbMrZz86xCU
    PHxt4EommEbqwQrEk15nB2eVl/rE7Nilxz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525930725; bh=vkpUV
    3NMQk08V8z/zsvfYeU6/aLrLdvhFzrxbcXpVzs=; b=ls5wvruQfpjlvZFTPpdfD
    VRzrJcRYojX2Rt/EiCazgzzjFS0G9OFip9TJfMPZZeix1mo7NLTrV8ZjtZUaNc64
    I8NuzMhWbKy0DXXxZoKbilXm4HwvmClYpiBwWZFF9H6FNa+8RP+wQEiYG2QuPVdO
    ogU38ECyBm9k1pDeSrV/WshGit3hXD9mc+PQkxciluV9KgS0RhRGPna6KLdbM+dw
    2966MJ+SarNg61/bFNXdkWXsP7nrVdSY51CH9U4AlzAqcUIBUVYQPcvwojwhQIOT
    rE21eN3S0i5ZBYBntdh/NP2m0og/swDDMtjo5pc0xmM9ITbEGw+wh6lpwFY8FuM8
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=me.com header.i=@me.com header.b=rYPLI9YU x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=me.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=me.com header.i=@me.com header.b=rYPLI9YU x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=me.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfARU68RdxAox6CQgC/9oXjJuqNJN1ytoyOvvFj0wyKtKe/DWSIjVjIBblZQJIswUnQIGElJvtPzyjVVD5FKmjpcemmujayR743j0XB09KkySJ4s9Ctul
    TJn4A7145K/xaj9mFfsjo2GB7bzrriHnkN2Dc94drlYzB6irk8LCx38XKb6yP9Ii9yQB+T19UBOVsOH49nphhpZkrUS34/5NdwbziwAreET0X1B9163OyH2q
    Z1TkvwSVQmmyvcHHBhTfuA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=HHGDD-5mAAAA:8
    a=DDOyTI_5AAAA:8 a=cx7vGKMz2EFIZ3jWNeQA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-10_02:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=2 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805100057
From: Doug Oucharek <dougso@me.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>
Subject: [PATCH] staging: lustre: o2iblnd: Fix crash in
 kiblnd_handle_early_rxs()
Date: Wed, 09 May 2018 22:37:59 -0700
Message-id: <1525930679-15227-1-git-send-email-dougso@me.com>
X-Mailer: git-send-email 1.8.3.1
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

Under upstream staging commit 5a2ca43fa54f561c252c2, the list handling
code in kiblnd_handle_early_rxs() got changed to list_for_each_safe().
That protects against the current thread from deleting the current entry
it is looking at. It does not protect against another thread from deleting
the next item in the list (which the tmp variable points to). The way this
routine holds then releases a lock opens the door to other threads doing
just that.

This patch reverts this commit on this routine.

Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9886
Signed-off-by: Doug Oucharek <dougso@me.com>
---
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index 32fa8ca..6148fbb 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -1965,13 +1965,14 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 {
 	unsigned long flags;
 	struct kib_rx *rx;
-	struct kib_rx *tmp;
 
 	LASSERT(!in_interrupt());
 	LASSERT(conn->ibc_state >= IBLND_CONN_ESTABLISHED);
 
 	write_lock_irqsave(&kiblnd_data.kib_global_lock, flags);
-	list_for_each_entry_safe(rx, tmp, &conn->ibc_early_rxs, rx_list) {
+	while (!list_empty(&conn->ibc_early_rxs)) {
+		rx = list_entry(conn->ibc_early_rxs.next,
+				kib_rx_t, rx_list);
 		list_del(&rx->rx_list);
 		write_unlock_irqrestore(&kiblnd_data.kib_global_lock, flags);
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
