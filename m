Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1645187-1521031524-2-13639704583284432188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521031523; b=ezgMYmwi82L5yAG8nZ51BmfRpVS1HeAJj3y2R+km3GIaY1C
    teQHy/8BvjSgJEhSpO2hqklWHYoacOn07yQBOi0IzedbBhQII/Si6ou/mG7kPlj+
    9L1S1g94PlkBz6Y+0ZRGTt87yVxldH+ni5oKRTk2aiQ5fq+ZbgP4LsGI30T4BQpi
    4iYIgVF5HlD9mCWN/0oUyisWn+7AEw0ebxJjyLz50VKeW0y0H3HQ04GEjXIklIsh
    XVByaq5r9/z2k3P5PbSBHmITmZgHePG9+BYyLnRq0t4LirX40V/ahChEFYybjtqn
    o8MCtYNxOyK/iWGTG3gonRXjVcBWhSldJbhkBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521031523; bh=f
    uZMo4m38RBYppV90GzH73W2xIqr7Z3SqOgDOuIWu5M=; b=vrqkvuzBGD+oqt42J
    fhgjkFQRSAKKY1TlqAGHE+o96ACui7MZXihL5wki1s6R2V13H/tbNuDlvOWKVk/X
    vFoWsd+1gy157f4SZSCWx1RZYKhYnbGIfmpQX94zs5X+7YKvT/nUqADDVsbJq5g9
    QZNfhUZhjjhT2YB0Oy+wJTY2QYVZgAxmxR4y9f2JTHzKzPF8J4Uc3zR3aoTO3Aan
    5AZ2p6H1fITKLnlvELP5OoR9SmNadWtIiBUFoACX5Og63nDrhJhi1AP02lVxl9a3
    MdWkjL6VOc2fgAyk369XuN07VDAPOGOsXeGr7DmMCnTmO4u+InsKYPMGjMXLqk7C
    d+CVg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XIuJ2mP5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fxz+R/gN;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XIuJ2mP5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fxz+R/gN;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELswSaXnv4KNeTD9mNLln2cAqhCphPET97PbIWRPxyD8+bwEIOSkuC/g/yCLsodxFd7Q/gz++w==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com, gregkh@linuxfoundation.org,
 ganesh.krishna@microchip.com
Subject: [PATCH 0/7] Cleanup patches for wilc1000 driver
Date: Wed, 14 Mar 2018 18:14:58 +0530
Message-Id: <cover.1521030891.git.hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
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
Cc: devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, hariprasath.elango@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

This patchset has few cleanup patches related to coding guidelines and few
trivial changes

HariPrasath Elango (7):
  staging: wilc1000: Fix code block alignment
  staging: wilc1000: Destroy mutex object in deinitialization
  staging: wilc1000: use kmemdup instead of kmalloc and memcpy
  staging: wilc1000: destroy initialized mutex object
  staging: wilc1000: replace switch statement by simple if condition
  staging: wilc1000: remove unwanted braces and correct code alignment
  staging: wilc1000: use kmemdup to replace kmalloc/memcpy

 drivers/staging/wilc1000/host_interface.c         | 27 +++++++++++++----------
 drivers/staging/wilc1000/linux_mon.c              |  3 +--
 drivers/staging/wilc1000/linux_wlan.c             |  7 +++---
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c |  9 ++------
 4 files changed, 22 insertions(+), 24 deletions(-)

-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
