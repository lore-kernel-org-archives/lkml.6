Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4146336-1521243635-2-5454989135451917165
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521243635; b=nnBv6YVVsz8vnK/S7rZ2pYYYMyiS3DNjsrZc0atvKfex496
    q5WMUC1i/nZBmEA7kf6RyEgdPRXYHfD+sIcE0Q3v4QvlN6cM+BwIm/fJ8MEZxlAe
    JfyVDhiN/Eva5+GnIb8W+8G/uZyeycRuslGk1Vn3P17N/JTnBloGlYjZIC0kzyYS
    jxmgRfny9nykJqYuyPBSDAsVkS5tZXjwf3hv3tKKW8IY1L3JLIDj9SGjAkrx5A3s
    PJ6rPPihsZoN6miqG8IBQeet+jvUcaih04phrCCXm9NpZgQU1raK3am8vqffJrUA
    VPhXByfkyEDqReB/vDc/MxKtYwVspSbbqkNRJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:mime-version:subject:message-id:date
    :to:list-id:list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1521243635; bh=L+8C1J10LWRm3fSyjqTEvEOEtFQ
    3gk01fNjlsRrc+oM=; b=Lo/3PgzZmWA7TC6mDPeejM0pLTJT6Jn22XppB/a21ty
    d090aKrgXFqj2GmvzcRospo39xi1bAln6UHE25kgTcYoIxDRahOsqzXXRWOVQeDd
    h7z1HMufL2Z9Tdw1Iby5G//7I4S4XLmytupIQEATgQ7AkWn6685FkCDvgFut9kEC
    Ez6c1doHYL0uKmEt2D6+xpGb/03Gn0lzyHzm1hq7odVTqSSwkCzYPk5/+zVAI67T
    iKyCRifrTCLQ+nw7kDUW4KvO2vfZRw/QJwV3V5H2l9yhAXHnS3L7aIMg54JXusc1
    Sh+zw0Ozhz3fnBeqotNQa1ODJj9vlPvdMu+G2VXzZHQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=me.com header.i=@me.com header.b=TgG7wxMy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=me.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=me.com header.i=@me.com header.b=TgG7wxMy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=04042017;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=me.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=me.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-03-16_15:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1803160275
From: Doug Oucharek <dougso@me.com>
MIME-version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: [PATCH] staging: lustre: o2iblnd: Stop MLX5 triggering a dump_cqe
Message-id: <B7D07263-126A-4156-AD60-3A58E8852865@me.com>
Date: Fri, 16 Mar 2018 16:40:21 -0700
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

We have found that MLX5 will trigger a dump_cqe if we don't
invalidate the rkey on a newly alloated MR for FastReg usage.

This fix just tags the MR as invalid on its creation if we are
using FastReg and that will force it to do an invalidate of the
rkey on first usage.

Signed-off-by: Doug Oucharek <doug.s.oucharek@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8752
Reviewed-on: https://review.whamcloud.com/24306
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Amir Shehata <amir.shehata@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: Doug Oucharek <dougso@me.com>
---
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c | 5 ++++-
1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
index 7ae2955..00ebc61 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
@@ -1384,7 +1384,10 @@ static int kiblnd_alloc_freg_pool(struct kib_fmr_poolset *fps, struct kib_fmr_po
			goto out_middle;
		}

-		frd->frd_valid = true;
+		/* There appears to be a bug in MLX5 code where you must
+		 * invalidate the rkey of a new FastReg pool before first
+		 * using it. Thus, I am marking the FRD invalid here. */
+		frd->frd_valid = false;

		list_add_tail(&frd->frd_list, &fpo->fast_reg.fpo_pool_list);
		fpo->fast_reg.fpo_pool_size++;
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
