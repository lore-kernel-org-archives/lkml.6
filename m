Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1133727-1525285319-2-6135021251830703917
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525285318; b=Ff12XiomSHzPmkTdTYarLyBgt0d0l7rP/cvbpTkzfSy0DpjAWW
    qbghV47OjT0Y3YOPgWNDjXpJtxAUsMI1xzMACkIFkcGzUbvEL8+njhMZlWe+jWqp
    MlUULHOCAXQWyZyr/rggkIpIXuIQtUX2iZIhT4FVlhkqU/HNfOhwFgqU6FynX+8s
    VrK533KbkCAtzjTCXbX2AdDj2onTmJDNhSU/qgm4iYZPKTY/KNa0bHOxUShsSskE
    i8/bKeUH/EWi7amwFxj2TFNr5iZsMOd914Vm5ieKpnMho6QpynCp79jrOtiENMoc
    2mg7o8pht0WsJpRb+mBsSFMbCs9igZj/4R3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525285318; bh=pp6iY
    jJOhsMbCQHwXsz+0N6osBFv3T98XS354cbw05o=; b=SfZn6CR3OqFuI5fl05Hod
    R2m/Sz2PeuYYeOgSKBrPvXbc9NYcJko0v8ppW7CwZWtkEshtOsR6te3yfqmwBkN3
    oBeRckL15ZYGpYOOsic6q2nogwDrXBlGNH+uviVyBLCnuHQLrlqqsb/StCnP4PPG
    mjcWTLZupIsuSW5ItRDdvaYf2szoD/aMNap26fug7Fio6lSDYv9CvwG9MvnofAqv
    zDwDdAtG8F6n69CWAkykIDNCKQMyPlro0wvSbe5Bu0p8ee8SFR86Dam8gVWF+Hc7
    S7aTe0URZDIJcri/SiZqPAt1CRyjRSQ5K7TIbBsHYCY+184zWzunvrS3piKF7ulY
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfKCGuKCaQqEL+UtYSpnN0lkh/699HcKdUCf3G55wYDGTaUz0VDUs4URf0coeGJ671suzk5cfpsiUf9fpEFv3Crx2F2AVwFHh4oEL8CUHGRvNQbK02nXY
    pzAj0EiCeg66vuWbf6/9PusgC23smiNiQUlqKNnJ6fDOChfQoJuGBE0HVx+eTRbjE+Hk00rC5p1jgV2tCL1uL0gkmZhvKb8+La/3MutYKWwE+YJdbiPpTTnz
    yyKeL85pHx70LBr95GTTNQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=4H1Za8GlMU1PDXbX6EsA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, Lai Siyao <lai.siyao@intel.com>,
 Jinshan Xiong <jinshan.xiong@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 0/4] staging: lustre: obdclass: missing lu_object fixes
Date: Wed,  2 May 2018 14:21:44 -0400
Message-Id: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
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

With the work going for lu_object by Neil I noticed him solving the
same problem as the Intel developers in a very similar approach. Also
with the changes we don't want to lose these important changes. This
is more mean for a basic review since in the end Neil and this work
will be combined in some fashion. Note this patch set is based on
top of Neil's cleanup patches for lu_objects published a few days ago.

Hongchao Zhang (1):
  staging: lustre: obdclass: guarantee all keys filled

John L. Hammond (1):
  staging: lustre: obdclass: hoist locking in lu_context_exit()

Lai Siyao (1):
  staging: lustre: obdclass: change object lookup to no wait mode

Li Xi (1):
  staging: lustre: obdclass: change spinlock of key to rwlock

 drivers/staging/lustre/lustre/include/lu_object.h  |   2 +-
 drivers/staging/lustre/lustre/obdclass/lu_object.c | 153 +++++++++++----------
 2 files changed, 83 insertions(+), 72 deletions(-)

-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
