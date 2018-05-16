Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526464044-2-675218165921736806
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526464043; b=cfnHg7vYJXI2O/NpG3pP/9W0GQ4jqyEJP9HR9hNP9XXxq5R7qy
    fpFFNSSQ3fQL2K8YSigFlPvwlFhJOQhJ8H5u9dgeGLAFnCMmV92WxIk9uqj8ejjJ
    bOmHxF4SWD+/+XvsYZUwYD/f+UO2Pb6XfG+Mb5kOFWlPEj0yM+yVZIJ2JMoc+fWo
    rvMiot0SKXhL/+0JbuMJ3Rt3QbCf8ebBzGH+LJjdRVTOc1HjZiHSZUBgdO3PHS2i
    0DtdXjIs74WfDFO36PgdRzdPFxOMEWoo1pbs9UOJlIzFOw2G8iKA5jMX8QdMIeHM
    iq5Ikk/ZBqDBkOnHIWKJJcmjq5m1j5v7U74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526464043; bh=miyba
    K4QTHa55V/lHZl4oC0bjpEhNes4CNP0tM6JPu8=; b=UDKQJeF6xUVazxrcr3xFi
    9LQKPlawdXE+Fq6ERaHLxXTlO/Q/+BR5NwhnSBsvGvoNiB+Oa0dpVOqbPf197EJj
    3+r3c+Kw73jyzHVR+OQvjPflvRuVPYoc1xzDAMjMp8M47V1If1za1m6k1U1buggU
    17Iv0VEdsvnHAdUA41Mg72/fe6Rx7p09AW3YD96u12O4cITMLMaUMxBG1fUdnmo3
    Vh1auTiwNFTq06PdLxLbDVugETBj6PbnPYEYvopzqXuDn/Zx4jLbrdq3ElnYYh0N
    CFOJ53wtLgyq3jxRB1Q0Soq8nd6/D1GL02TjGsr6kqZ6J+cImhMad7xGrcMSsaxw
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Mp2jz2go
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Mp2jz2go
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPtt7ISGCLE6FXoVJ9uckpGmYDw1lnPSYVHXqpZ/sA777aX6m1qXRWIFAN2/MHI4rsnbDdh1RS7Gw0/7MvofLzOL82LjnHR2pZnWFlQ93VLHk3jPicTM
    umgk3cAvKPbmQ1eP4JAl4HgxvWXNH1fieyqpV1yrRU1UMI6YwYT0r8SQA+wZW10A+xKqnYhhv02zsv9ybc7kXKPbmg6IA0VRbKs2+ioamvVOiBqIx0e4ei0m
    1s0u+9lDNUp2FmaHsAAXig==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=vhW0EZN9xUNxw50ONO8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 42/42] proc: update SIZEOF_PDE_INLINE_NAME for the new pde
 fields
Date: Wed, 16 May 2018 11:43:46 +0200
Message-Id: <20180516094346.20506-43-hch@lst.de>
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

This makes Alexey happy and Al groan.  Based on a patch from
Alexey Dobriyan.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 84c68508a256..a318ae5b36b4 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -62,9 +62,9 @@ struct proc_dir_entry {
 	umode_t mode;
 	u8 namelen;
 #ifdef CONFIG_64BIT
-#define SIZEOF_PDE_INLINE_NAME	(192-139)
+#define SIZEOF_PDE_INLINE_NAME	(192-155)
 #else
-#define SIZEOF_PDE_INLINE_NAME	(128-87)
+#define SIZEOF_PDE_INLINE_NAME	(128-95)
 #endif
 	char inline_name[SIZEOF_PDE_INLINE_NAME];
 } __randomize_layout;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
