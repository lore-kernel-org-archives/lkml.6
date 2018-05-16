Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-654-1526463874-3-4752846567302598836
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526463873; b=OrJ0oDVlIsnq3Tg/B2QFfmW4jF3F8yZdgdOp6pT0Ka0UEN9olN
    +Lgr3SjI+eiTJXICn/pCbmoLHH3cj5/ynW7zZ+ihXOZQ9qZfKyfRp4AgJpu/Se0Z
    MvTvzzNEQ8uDDBRBtn6+07NJqKngtJgLYGNZJBnT9pXtrCrYjD+lxYbifUa3HPKA
    R686gq8CqNzigrfc8bKUWdzfdMq9EhxQ3atINZFN62Yvof/3Myr/ygl2kHAfsFpU
    dfb05xzkylTgQmLw2eb/U8iTB5YoQ5lGfjebuqr59Ll/0PieotOa3cxy6uwzWU0U
    yYOqLEOwuVSBoWiq+16x5MkSBaKgdZcesWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526463873; bh=AMSd8
    7E5d6ma+0w52CSsRP4PUGFD1JDtpqdlDNrO3CU=; b=dVIXgRGcGl47f2B590vkR
    a2k1ixQxsULyhUJVOZvIKUBM9thxd1lfQeG+qV06IAu7xd0DsfssraUdgUhC+DJ3
    SGQLZp0yQKQs7nM6+dcfQ3KdfSxbQVkTe8T6hABpXOUipm4gI0vsUax/T0QwXqUu
    n8Vmd4bJ+waeJMMhfP766c23S6dvd6i12Rifki5VRbLshGU/yKcFwONydIirKG/w
    7bmL6GqDCVi1huM/c8lfUylPePNf2zqyyyJ1kXhlt8grtr7hTE0AUZJOB9YmwCZz
    C9BFyEkbo5O5GSWqmjyorZNsHtWpEya2Wd6XzCRk9V0vrHS97yT8OTv9jP6C2saQ
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=PwjGMvm2
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=PwjGMvm2
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM2v24upELycAgG3n3LqtuwOCLssAxy8McntILJbfguZMYoEt29+tphpa99oXh8R9k9zIO1O0GMU9kj5yDGRuICSkeIZB4/1HyXBU0VyPJyMX1stQNQ/
    b8PjCtvfwGWdahpAo3Ppqv5Mb/Y/v8X9rYbe6E3EjK3hT0+1Y6FmSbied2hP/jHYnG1P4nuUmksRjJqsZalupEPNncstaS9XfXwRSMZUMkjJEGfY61SdSmnO
    O41DCFfROQULHCCTscrAug==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=w2cMSxZChwwtV2GeLk8A:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: simplify procfs code for seq_file instances V3
Date: Wed, 16 May 2018 11:43:04 +0200
Message-Id: <20180516094346.20506-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/misc.git proc_create.3

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/proc_create.3

Changes since V2:
 - use unsigned int for state_size everywhere
 - move state_size around in proc_dir_entry to use a struct packing hole
 - update SIZEOF_PDE_INLINE_NAME
 - added a new proc_pid_ns helper
 - improved a few changelogs
 - added back a nubus comment
 - minor typo fix
 - collected various ACKs

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
