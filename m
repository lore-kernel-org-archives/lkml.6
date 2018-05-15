Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1731937-1526350633-2-7656986917464004445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526350632; b=WmxbEJHBsEG3THtcGpD7Ie2/NUkLy1woP3vqfbHUN8AJC+E/Fp
    a6fTs7d5+zhSfq7boZpq4nY2S2FQEtRlnOho/jfOLxTPvSyiufBH5o+LgEG2AGpY
    BtZAkziDoQrA1Rik9KeeczLee4uu0VE2qw6lLDYD8BgcIhlJIH75bXn85c2Q65DB
    CzqNi5AwX3asgyyvoZxOYStgiy0fASOBTwdn5TOPSMDDXIfPgEv5ggv5xSn5mSU0
    CCwggsybpRXsmWCuFB9gkiNVVi83gf0kI/FBy/0LJO7NYt0JXxOtempC/mfsILdz
    NupDR353twGhNly+xPE3xLzZcQA0GxEPN3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526350632; bh=dO/yx
    xQ2nolGe3h+XHScq/TgTd+YUEmqnyRoDw+UKjg=; b=YPovYKWMq8eXW/7OUYi4o
    XJb7c82oNYnXNjkzUyxspbvg63ae1ze/RadIX0uaGdXwq+5iKzbpqrGm4gIu/ZlY
    F9EnjbzwQxmlDvqXX+2POh4tuP6W37Vf/8AGkSwBqa3Y6r9kMFrO4SlOOed7cD+O
    0GcSO+Fj29t5X3A4+8pyNdILJlNtiEFKP/O8yic9/86D/WCmQ2DMI5IDChdrrEkc
    n4Emv3DlHKHHRwW6fL0al2DrvITp0hDT/E/3hcKcb2CIGF3LK80komK6loKMhbF2
    u123KBQBuLFODIAud6cXplsHNrj9TqR1MOJOmssOHco/n8lsgnY2gDJiqRZBtFi9
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGRywi24tUweUDqmZSar4dmbWNiy8Er2fUqYx8NxjpRjiQuPq/U1hbT2zlX7wjr2HUbBvL+yk9YpSsIlLYc5gX41I+rMkZhwLrB2lbZzwWSQPBca1X7x
    knfER3eB7tWrvAUD5otBC8amouU17jP1N8h3+R/CzULfvMNSJReUr8fWhUYhixs4QmO08URyZtANoT0GLzs1PaNLzPOKh+qZ7CgHtompc7rhs7w93rStHmPe
    BC9ulOpB4zNG45Sf3IYU0w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=bMovAFdmXc2sLEf3_1YA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 0/5] staging: lustre: llite: remaining xattr fixes
Date: Mon, 14 May 2018 22:16:58 -0400
Message-Id: <1526350623-4616-1-git-send-email-jsimmons@infradead.org>
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

Fixed the bugs in the set_acl patch pointed out by Dan Carpenter.
Rebased the next patch 'remove unused parameter..." on the parent
patch. Added newer xattr fixes that were recently pushed.

Andrew Perepechko (1):
  staging: lustre: mdc: excessive memory consumption by the xattr cache

Dmitry Eremin (1):
  staging: lustre: llite: add support set_acl method in inode operations

Fan Yong (1):
  staging: lustre: acl: increase ACL entries limitation

John L. Hammond (2):
  staging: lustre: llite: remove unused parameters from md_{get,set}xattr()
  staging: lustre: mdc: use large xattr buffers for old servers

 .../lustre/include/uapi/linux/lustre/lustre_idl.h  |  2 +-
 drivers/staging/lustre/lustre/include/lustre_acl.h |  7 ++-
 drivers/staging/lustre/lustre/include/obd.h        |  7 +--
 drivers/staging/lustre/lustre/include/obd_class.h  | 21 +++----
 drivers/staging/lustre/lustre/llite/file.c         | 65 +++++++++++++++++++++-
 .../staging/lustre/lustre/llite/llite_internal.h   |  4 ++
 drivers/staging/lustre/lustre/llite/llite_lib.c    |  3 +-
 drivers/staging/lustre/lustre/llite/namei.c        | 10 +++-
 drivers/staging/lustre/lustre/llite/xattr.c        |  6 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        | 22 ++++----
 drivers/staging/lustre/lustre/mdc/mdc_locks.c      | 42 +++++++++++---
 drivers/staging/lustre/lustre/mdc/mdc_reint.c      |  2 +
 drivers/staging/lustre/lustre/mdc/mdc_request.c    | 38 ++++++++-----
 drivers/staging/lustre/lustre/ptlrpc/layout.c      |  4 +-
 drivers/staging/lustre/lustre/ptlrpc/wiretest.c    |  4 +-
 15 files changed, 171 insertions(+), 66 deletions(-)

-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
