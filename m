Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2908601-1520178562-2-10744052950440619576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endanl, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520178561; b=g/lg2Zk9su6vC2h45ufvMOK091yk0psAj6WYwlg6bQb6JuW
    ZdV40lctFUojPYyeY1guxfqgdSjeZOF0NNY/iTR1B5SSKSHj41/k2nbA9nEgsY4v
    hrN288FbciOYROCj3evkG8ww2bI83pyJdjRjn55bkQfl2MyNz6wKwecJhcov2bQt
    +A+4WGdAoH/kEV41LRXmCq8NyvSWGzEw1vKgC0KFPgN/axXHWt3JfIU8p3PuuZFA
    IAseZ7nEobYdhO+ge03smekW5zmo5SsNHaCNYMtQapcOkGyhZetEafX5bl1/5okm
    hkkQRUEZxwyQuSEOXuzP4DVUvThWd9HuGuE683w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520178561; bh=n
    TpO9abDoR5u9lLdsO8+tq9X1IPcf2fawVUEX57CMHo=; b=RR37J0Pe/rafgW8KQ
    kxWd+MSGKHADEYexI+uflbnFfD+ghbaof5wlymbxuMOkffFUOV+WBG4/Mnpcr6pl
    Ure3Bq0DB3blOb7aiC/g/QmfX/dhw0SUgYiMZEIG1lBZQbnZ2oxowLPFedZXZNyd
    QQn7DWR0Nx4P5FsOLWHdI76OjS1aR+D3hTvgH3n2Tza51BTJeeQSykDEBzp0so7x
    C+KeTonm/kyF73c77vF3odBZceUTsKPkQk6jmruJnzCoIpuyB1gDp07lLv6aILlS
    Fk//9k3gI4E1C1rEFwJfH2OqCPGkuJHZDX231gF9Smv8qK9cZ4wH+gn+uQgfBP1l
    kRq2g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KGQPU2pA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F5aCBHMS;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KGQPU2pA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F5aCBHMS;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsCaFQ0xTJnhC7oPuYq5IvR7UwjqeC9gkWGzYI5097Rex072a+xX3hDuY8IbvNXl8wBJ3VnqA==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: alan@linux.intel.com
Subject: [PATCH 0/3] staging: media: cleanup
Date: Sun,  4 Mar 2018 21:18:24 +0530
Message-Id: <1520178507-25141-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
 sakari.ailus@linux.intel.com, mchehab@kernel.org, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Spellcheck the comments.
Remove the repeated, consecutive words with single word.

Arushi Singhal (3):
  staging: media: Replace "be be" with "be"
  staging: media: Replace "cant" with "can't"
  staging: media: Replace "dont" with "don't"

 drivers/staging/media/atomisp/pci/atomisp2/css2400/ia_css_pipe_public.h | 2 +-
 drivers/staging/media/atomisp/pci/atomisp2/mmu/isp_mmu.c                | 2 +-
 drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c                    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
