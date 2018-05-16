Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-62429-1526463926-3-13077157765383866624
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526463926; b=Fy5jwVPt8kI0GECyHYA5EwsPPJqjXQqwjU69J8LfkUg9tA171c
    XU9m++ciOpSugHRx6e28/pYN5+fM/ZmDJ8fp6KzdCMEWmMf6lWocBrijjpF9jhzW
    a5sfkFTcTK+2fReEtUrWF6Fz6KmvCRGQQPOixSurpiH4i+oeBOiwX1Hsb9y8qaX2
    zLDbSo7c12cjrhtiLtVn0ci0kQul5JXojsKwYrtRdxWcCkRMsxxXZrbEvXMQ5XwN
    DFWZqlLBXLAlzETBlNqF6RnyF+pjo1ledcZfjPi1tLakAgymhS5fljlElprCin64
    uVyHAOPedp204BG0wRDy3oV8ft+57U2HLzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526463926; bh=Tm9Eo
    xsHloiefTSESzFIACYYKYZtEQSwyyW1UfEmj3k=; b=CKHRoWxeXxi8JYcF2D30h
    V5gaq6fMcxOrvbVeMPNXAswtceqtx1C8l5AyhEwoDBrlDUDrq0vx4MWLaxgKvM1h
    VlgHz/Mh90gl/ieZxoq/yPsIGRQessu3/317N7ZDTJlSqqid72uwQDKWldPx/mi/
    wWZRpbd74jL/aqfmrv49wx/fNkbkkte8Og69Y2Bobw0SJ8PCythr3qi6CnXvCnG2
    h757Qsq4LhBf6uZEBGCr0zZxUemdYqlcxV+rx0FB8eAGT/NG1IpkVjp00L6hUFKj
    uFBikJla5Us8N5woGyAoZngzPLO92NiMZKvYVlkXkEZ8g/4rlyctoIsBkxNg9yxL
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=t/ZxM/8+
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=t/ZxM/8+
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF3EETZp/fGrwodz4+zkOGjV1dwKSwDiJ+rNYb3SBaRmFE4GiIDcGZe4j5kOD1PofdvtNEVZktfWSIpUgbA44060l/IEF0n1thVFupDfDB2lKjoFSCZ1
    8LmMl2+nZQe2YKVyGL1OGUhD/sH7UAmTFINF93XR3L584Q00rkNCQmXKx2Q7bQZjQrUjYhUNT7IfAFvJ5UyVz/ox6bnoEjwuCnK02MCPKd+KsPl8myt0ZjsF
    K4fTYNxPkeFAemK6G97onA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=E5bRLM3UHy0a_ASftUEA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 16/42] net: move seq_file_single_net to <linux/seq_file_net.h>
Date: Wed, 16 May 2018 11:43:20 +0200
Message-Id: <20180516094346.20506-17-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This helper deals with single_{open,release}_net internals and thus
belongs here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/seq_file_net.h | 13 +++++++++++++
 include/net/ip_vs.h          | 12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/seq_file_net.h b/include/linux/seq_file_net.h
index 43ccd84127b6..ed20faa99e05 100644
--- a/include/linux/seq_file_net.h
+++ b/include/linux/seq_file_net.h
@@ -28,4 +28,17 @@ static inline struct net *seq_file_net(struct seq_file *seq)
 #endif
 }
 
+/*
+ * This one is needed for single_open_net since net is stored directly in
+ * private not as a struct i.e. seq_file_net can't be used.
+ */
+static inline struct net *seq_file_single_net(struct seq_file *seq)
+{
+#ifdef CONFIG_NET_NS
+	return (struct net *)seq->private;
+#else
+	return &init_net;
+#endif
+}
+
 #endif
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index eb0bec043c96..aea7a124e66b 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -41,18 +41,6 @@ static inline struct netns_ipvs *net_ipvs(struct net* net)
 	return net->ipvs;
 }
 
-/* This one needed for single_open_net since net is stored directly in
- * private not as a struct i.e. seq_file_net can't be used.
- */
-static inline struct net *seq_file_single_net(struct seq_file *seq)
-{
-#ifdef CONFIG_NET_NS
-	return (struct net *)seq->private;
-#else
-	return &init_net;
-#endif
-}
-
 /* Connections' size value needed by ip_vs_ctl.c */
 extern int ip_vs_conn_tab_size;
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
