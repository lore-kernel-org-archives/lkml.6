Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523852120-2-13696774249908077130
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852120; b=KRN+o9fzC/4rn7qeSjs50eG6SDGP0psD+w27775459Fr9UDvDR
    qYG2JHtWrQEL+1oJCKmgP34FFrimhZCx5/+OmBuNSNjcB/qt1aNg5w/SGxVzUIh+
    OafmUvLiXNNmpXGzMYALKzxuBPv7XBTwZoAzg7O5hkjv8xJMaen/ukqNEcVyPR/0
    zqc9cxj0Jgq3luaECj9RAJ+0An9/+0J+hbNStLO9minQXpBq1o4pr7Q9tMoG1oFi
    9vnJiIN1T9nt6ZhPbSGgcuXXmFRyleiWJJtz2tmeu340Xx40JWLGcDDgbo0MdXsf
    Q83A5b0UJl9r0rC9x3fDuYMr3GuBb9MAqCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852120; bh=xpps2
    AHLYjYENuEqrA25EgbNcPt9SEVwSUrvtfX+Y48=; b=RkIJPlaY8kJqA/Ys02yZF
    JJp06fEH3+TAse4Z6PPFjSwpRGaCq8qxQAxMIfSXIkGZ0a4lEyft2hkIrD4wk56V
    iokJyySmYi9ocyIdWvBRd+3+yj5ilC9A2UCM7GYM5cx+O/yUdbKmey8Xge7WA3le
    iWsLLZ57LG44JYYqSVzL6bTiKud3xlTHVZdwdzcasHAIfzfBx6gwxzOvghJz5zr8
    Yorn04L5uLRlNObgnAeHHCLppkTHwBdhgEak0mIRkTGwEdiFq/fHteLOXwzynYd7
    kuiwKyQ0MHNBxG2R7XT015Eq0FmJ6UE/DHdctYYFXBeVzHqKUcpGqxyedL+pebuw
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP2hovUDjezSdJAG/yRrytKdxOn/DMHjTsYSWjvHC3gr7VQbSoJTQ6MHZWVwCDFr7fEkr/0BPbdfpVjhreY0vzwD+tVn5TumODLYjpJ/KwIAC+y5dkjE
    XQkmtpzjw4nBjVt70QwN3qdnGVuat0a96KULIui61HTu5FDqAEgwnLFAzlP6KLGdGLeuMzmMsj9tWgx7UgB4BSfnWZM9BiJIZV9LH+WO1oaDdk0+xQz1oY2D
    7LY9fSICEwFq3TjzZsiPdg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=CjxXgO3LAAAA:8 a=DDOyTI_5AAAA:8
    a=zPcYKlPyBEtjp4J93ecA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 00/22] staging: lustre: llite: fix xattr handling
Date: Mon, 16 Apr 2018 00:14:49 -0400
Message-Id: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
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
Cc: James Simmons <uja.ornl@yahoo.com>,
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

From: James Simmons <uja.ornl@yahoo.com>

Lustre utilities and user land APIs heavly depend on special xattr
handling. Sadly much of the xattr handling for lustre client has
been broken for awhile. This is all the fixes needed to make xattr
handling work properly with the latest kernels.

Bobi Jam (3):
  staging: lustre: llite: break up ll_setstripe_ea function
  staging: lustre: llite: return from ll_adjust_lum() if lump is NULL
  staging: lustre: llite: eat -EEXIST on setting trusted.lov

Dmitry Eremin (1):
  staging: lustre: llite: add support set_acl method in inode operations

James Simmons (9):
  staging: lustre: llite: initialize xattr->xe_namelen
  staging: lustre: llite: fix invalid size test in ll_setstripe_ea()
  staging: lustre: llite: remove newline in fullname strings
  staging: lustre: llite: record in stats attempted removal of lma/link xattr
  staging: lustre: llite: cleanup posix acl xattr code
  staging: lustre: llite: use proper types in the xattr code
  staging: lustre: llite: cleanup xattr code comments
  staging: lustre: llite: style changes in xattr.c
  staging: lustre: llite: correct removexattr detection

John L. Hammond (3):
  staging: lustre: llite: handle xattr cache refill race
  staging: lustre: llite: use xattr_handler name for ACLs
  staging: lustre: llite: remove unused parameters from md_{get,set}xattr()

Niu Yawei (2):
  staging: lustre: llite: refactor lustre.lov xattr handling
  staging: lustre: llite: add simple comment about lustre.lov xattrs

Robin Humble (1):
  staging: lustre: llite: Remove filtering of seclabel xattr

Vitaly Fertman (3):
  staging: lustre: obd: create it_has_reply_body()
  staging: lustre: obd: change debug reporting in lmv_enqueue()
  staging: lustre: ldlm: xattr locks are lost on mdt

 drivers/staging/lustre/lustre/include/obd.h        |  20 +-
 drivers/staging/lustre/lustre/include/obd_class.h  |  24 +--
 drivers/staging/lustre/lustre/llite/file.c         |  86 ++++++--
 .../staging/lustre/lustre/llite/llite_internal.h   |   4 +
 drivers/staging/lustre/lustre/llite/namei.c        |  10 +-
 drivers/staging/lustre/lustre/llite/xattr.c        | 231 ++++++++++++---------
 drivers/staging/lustre/lustre/llite/xattr_cache.c  |  83 +++-----
 drivers/staging/lustre/lustre/lmv/lmv_intent.c     |  12 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        |  36 ++--
 drivers/staging/lustre/lustre/mdc/mdc_internal.h   |   4 +-
 drivers/staging/lustre/lustre/mdc/mdc_locks.c      |  68 ++++--
 drivers/staging/lustre/lustre/mdc/mdc_request.c    |  34 +--
 12 files changed, 364 insertions(+), 248 deletions(-)

-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
