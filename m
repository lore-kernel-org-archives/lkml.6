Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671350-2-7003675491773442646
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671350; b=uw6FC9819nJxWAk8vxDg+Ecxtwd6fA6x2kzGWrdrInBZvJs45Q
    YoSDOXr+tTvLM9R9fl2g5lH2lkUvqR5bibB/n477LpVMGt05vZwb51ua5A+cLrL7
    +9QRbrJu13WqIKba2ozgEFUXjlUR6ISXO4QFVQ2cDRfel0Celn+bSI62BoYbULRo
    qv3qzgJ5EFXZJ7Ptm8Z91roZ9s6ZH93t0DpvfA4J/tE2f09gY6WJM4+OPVLS/+hQ
    LZKrC3RSnJQyxhfs2XN8nZnBsugS/LE5edOUoVrNEPlttmjFfL7P4xaBw+wuHtLo
    +jzSMudzkJWGzhZ3ar3xnxZuLCbUc5JPZLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671350; bh=E4YJl
    cXPjSVodAsKKkX55gDJC6S6uXbxFjUkYj0it5Y=; b=OoikJUEk2iGOwU8h79ifu
    sTv5GqMfZJdbeqjVBtt+j1NLNRJjrHyRubLz7EOjAsjpOYBuPEq2PLgH/DA4wTnT
    rNomadNFDk5weVIABh+FSGHZYbEv4yZVZtjyy8+UYxtfKQCp3RtuQmK7zvupP0Rh
    Vl8olY2lfQ86t4yARd+giVnsObNpBmhJ+PAUM5FCOnDBJadqMp18Gns14NmJ7VBJ
    vb0OESD+6k2E24pZKIUxIupoSwNryytoaLrHQwWBPuFd8lPW58SERt3mfgPTMHpm
    R9uD4aJ7QkUVWq/WIet7QcN/PzIxcXnDECfsWriecWH2PvgMmUrnI5NS9KnT+kKq
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FyrcBG7+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FyrcBG7+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFHcAGlA1zlXNaQEBduIVbeG7TwXH26EEUGP0ISLUjUn7yI3LNfyZC+l4lFfqnVBskurilwdXANCghq+5+G1NXXQ0rXdhG6Bom6dZkvA3eYIOF+Jhktm
    f/O/e7vnOWJIWaiZhI+bk764OSM/50SbvoR++f0bDEhhYJ5KKx4WMnH/bBXMXNJL9NhrTUtj2sVP8I4B2gzBcs/9G65hp1MJlClALeGFY36Q9yGyYLnGRT0o
    0TTAPYTJCbQt/ouqdsxbtg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=bkSUHnsPoyE9mSdkuG0A:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: simplify procfs code for seq_file instances V2
Date: Wed, 25 Apr 2018 17:47:47 +0200
Message-Id: <20180425154827.32251-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
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

We currently have hundreds of proc files that implement plain, read-only
seq_file based interfaces.  This series consolidates them using new
procfs helpers that take the seq_operations or simple show callback
directly.

A git tree is available at:

    git://git.infradead.org/users/hch/misc.git proc_create.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/proc_create.2

Changes since V1:
 - open code proc_create_data to avoid setting not fully initialized
   entries live
 - use unsigned int for state_size
 - dropped the s390/cio/blacklist hunk as it has a write method
 - dropped the IPMI patch given that IPMI proc support is scheduled for
   removal.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
