Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-422771-1518026373-2-2384579394924730754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518026373; b=pQDZShyuvdNEEXmEDBRXi332GmEB94SHdedv/rSdTef2xwA
    R9dRLdgq54K/avwHQxOpup3xOIBcy9WU1ND9dTs9W8WywODEkZZa/ShY0VZewnBq
    c13GCDSOm+k3aH0/w3SvBedq2yV5PPHvh4UaSm9B/OViEgOTY8Q1SbdsPsujAZIo
    Ip+ouFyAAgIROMaTeWOmXifO+6lspcS22IAz7ChSrdgis+pVbjb7D3t2oiOfvz/D
    scWmyA5XKPywNehZ+uNLOHKiCz/ZXIaQv0SgnWk1oaPNEygLsgtfVzU3ln0lJTNM
    SX3k8gsiY6baH3S1u7Gg1tya/u/fqumYUGw7ogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518026373; bh=x
    q1qk00Ry0gWqwn6x8TeBAviphHBoCRYlBEsalx2mHc=; b=L61aYgSpnKh5Eo4VG
    RqWDKZ5ZNMllfE4hYNBkaPltvf2YAZWYbbihgrClnJBmzr7LYjo9g8bqnaTNtDCb
    GXbK6o5NkJGu+OVLKQcEHUtI2rJT/fBfkPHPxcGTlLZ0e/ov1SDAUTEgqFUgTnbZ
    RV+Bl3KzchSVz1ZJVXiDUes906mEDvig1A0sw+Jh6t4r2Jo9LClVPdoSRhwFkhhS
    0xcGGRYQdOxv7vwtmdShNrWFBOVwU8AdJgCS39FPVNbHm85vmZSgwvdE37KO9jFu
    2RG5hC/GdqKv1NY2pE/sTQR25ezsZNA6p1HgrFO/8KfGJWvQV94v/M8C8kwx/aBI
    wqVrw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: devel@linuxdriverproject.org
Subject: [PATCH RESEND 0/4] hv_balloon: fixes for num_pages_onlined accounting
 and misc improvements
Date: Wed,  7 Feb 2018 18:49:59 +0100
Message-Id: <20180207175003.28859-1-vkuznets@redhat.com>
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
Cc: Eduardo Otubo <otubo@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Alex Ng <alexng@microsoft.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I just noticed that this series got lost; the initial submission was on
Nov, 8 but nothing happened after. Resending.

Original description:

While doing routing code review I noticed that commit 6df8d9aaf3af
("Drivers: hv: balloon: Correctly update onlined page count") introduced
an issue with num_pages_onlined accounting on memory offlining. Deeper look
showed that the accounting was always buggy. This is fixed in PATCH3.
PATCHes 1 and 2 are preparatory cleanups, PATCH4 adds a tracepoint to
post_status so it's now possible to see what's being sent to the host and
where the data comes from.

Vitaly Kuznetsov (4):
  hv_balloon: fix printk loglevel
  hv_balloon: simplify hv_online_page()/hv_page_online_one()
  hv_balloon: fix bugs in num_pages_onlined accounting
  hv_balloon: trace post_status

 drivers/hv/Makefile           |   1 +
 drivers/hv/hv_balloon.c       | 121 +++++++++++++++++++++++++++++-------------
 drivers/hv/hv_trace_balloon.h |  48 +++++++++++++++++
 3 files changed, 132 insertions(+), 38 deletions(-)
 create mode 100644 drivers/hv/hv_trace_balloon.h

-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
