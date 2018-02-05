Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3281902-1517859368-2-8995171912711231403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517859368; b=kMCewGDGowE8kRkE9+ny0TPgGeDQO92sCwPJ4O+GhLJsJSH
    sSylZ7X0TlqIfmtF825bdbpzActfppayg/0L/TW2IdQcPStG7DKAD4qOUYVppJRp
    Ec1YhfkT3gY9Rdzciq9wrA9lXVnznVwREVgcLtI2K8NiLHO0/ad92w+ozRW7W94h
    nJ7psC+KPmNOqqrsCt5wsm4Jf+2IRvaGops8hkjTptIEC7v6l15y2RStodgg8SXA
    vnPNVpVboG7kItw6+X/AvppR42a1be3DqA0P1vqW15XNPfs08By4Hc8Qb70UUd3w
    Bz6slFYb9zQWzKZd28IzpKrHdPJdSmAGDpDl6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517859368; bh=G
    Ti5ZiAAzW3R8NzJer306ofBYadCvyR+mHwWZ51Ecqo=; b=NTROsLtbtkx9YqzGt
    BMNCViX7BDFVUObR1uoC1gRm7yhc3Zdhl5ga9U6iMh6/Nyvlq95pvlxsjCVneJ3N
    4RoFKqE01KPVrvWmQmkNop3h7DrqVu1v3ZIz3DIJyyNLHHANfkkGuCKzzxZ5W8SM
    +OWAF1iqCsd5CRrvrbw7+EqU/ZvzBTybJOTlmhd7QqUHsLjqBHqhjON8waZeuP68
    LN3RpWYk8H6c9JDHG1LRlIY+f1UgMocoxHO4BhoRb9tFaYkMDeadt4eeeNnQDR6X
    jBeZzxq4n9tKvPgQU5Fljpez6YlgO4HJqU/P+RoenH49AE7NoIQDTcntyEFBa7Nz
    FsZTQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XEBqTJlN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cJJI0YiC;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XEBqTJlN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cJJI0YiC;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224sgmv5TuJ43oGgaOBtvKi0RBG8aW0MWBUnuFqmBILMRLBhamvTgg0ugJVRC9W5/drySYO/ew==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Remove usage of mlocks from ade7758 file 
Date: Tue,  6 Feb 2018 01:05:50 +0530
Message-Id: <cover.1517845616.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset has been introduced for the removal of mlocks
from the ade7758 file and replace it with the already established
buf_lock.
Patch *[1/2] removes the unnecessary mlocks i.e. which are
taken around the read cases.
Patch *[2/2] replaces other mlocks with buf_locks and introduces
unlocked forms of read and write registers so as to avoid nested 
locks. Also some additional cleanups like moving the locks to where
they are required to protect, are made to improve the code clarity.

This patchset has been introduced after the revisions done on the
patch *[2/2] and also there was the need of patch *[1/2].


Shreeya Patel (2):
  Staging: iio: ade7758: Remove iio_dev mlock
  Staging: iio: ade7758: Expand buf_lock to cover both buffer and state
    protection

 drivers/staging/iio/meter/ade7758.h      |  2 +-
 drivers/staging/iio/meter/ade7758_core.c | 54 ++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 17 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
