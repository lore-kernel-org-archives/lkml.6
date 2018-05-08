Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1824247-1525739893-2-10593811668419911542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525739893; b=Gfu5wOnaerBzHE9g3xIIap1rSW8glVwB9g3zNwODPjWw7XasYE
    ZgrSOghEmY65CtToiZYv+dhVYV0of/WFkkY7J8LNNW4+wptBNigQsf/n5FN5egWV
    gpQ1XsN/kckq3tHD2kBooXdlVtza0FMpLa5DjjlpnO6+jfoMK4zAq9r+eBl2W2Lw
    Q28EdbNklryzC611T1tkXH8gFaUWeZm2kTZZitva3ReOzRFWedEGrhELpUZ6d0j4
    hrjSnPR4sj6GS8aETjjAmv5h+GvXphn5kadPcSVTn69xF33WwltS5VR36dUjdxIj
    sI7k16hEEMnu/k4YgpY0TTzBTqbIQ6FwCAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525739893; bh=+ppJP
    RRmFeVCcJEb5AgxbJcWsJihuqq1u9g1aEFXDm0=; b=Y+hCw6BH82NkD6v1Z0p7s
    G+/SFyDMtoaBPkhSTWkJ94sR9qgfR6OjWtweCX/QqLVdI56nMORhhNYThfaDqVkO
    QAi5xeVA2msVdhQ0gwEe+1rL40+GVvOXIlL0b4ESB7hSJ+bLInlAMWuAzVM07VOQ
    7o6+vJxP2ImuMdKuhra4VWW071Y8di6aRkjQcaRFrYx7O2Bl+1pBoXS8Br/vFM3w
    igoDGu/UV9f5/iry+RRrjyPURZ7BdIjhzdBMApHcu2sKpEdBhiEqPuIYXIWgIXXW
    oWYqZTZQ0QI02/gKooHP/niOFXKAZH4HCO30MpfJaCDDB8pLqjHp3aiczTuZ9rzJ
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=RZo9feeF x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=kUoMH6C2;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=RZo9feeF x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=kUoMH6C2;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBp99wn9Gd8TKufz7F2IOCrU2Pyzb2/TFGRSHBOSco7m3wdw2t/n3guIMWIgBhpp9b/GeQxBJIgmbeG5HvevRlxcHLNpQxktwb3YLZbHsw0gQ97oubVz
    MyKeogfnMa3hbst8elBttu1OKwiuXsYsIM2EtkVeHJ6CQFDiym7SCa2Cq+/Hn6jys7vdszNXxvx84IkkJG+ftfRwvmYhs+e1JTBAlv2Nkf57PzoAd/r3PUI/
    wqF25NeOczvoA9az/aFJwQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=b8aGf-dT0oUA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8 a=ubyyxFxAb2ufU0R0QZ8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZp253AWvtcUAznJLdYphkH4WmRZW7ke32AaAEk0aJeZVL8mPpra1d3e23mqoG4iFPAITiC6SA==
From: mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com, kys@microsoft.com
Subject: [PATCH char-misc 0/2] Drivers: hv: vmbus: Remove x86-isms in arch
 independent code
Date: Mon,  7 May 2018 17:37:29 -0700
Message-Id: <1525739851-54919-1-git-send-email-mikelley@microsoft.com>
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
Reply-To: mikelley@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mikelley@microsoft.com>

More changes to cleanly separate architecture independent code from
architecture dependent code.  The first patch moves x86-specific code
out of the Hyper-V architecture independent drivers and into the arch/x86
directory.  The second patch removes the string "X64" from symbol names
that aren't x86/x64-specific.

These changes are preparation for supporting Hyper-V on ARM64.

Michael Kelley (2):
  Drivers: hv: vmbus: Remove x86 MSR refs in arch independent code
  Drivers: hv: vmbus: Make TLFS #define names architecture neutral

 arch/x86/hyperv/hv_init.c          |  4 ++--
 arch/x86/include/asm/hyperv-tlfs.h | 12 ++++++------
 arch/x86/include/asm/mshyperv.h    | 12 ++++++++----
 arch/x86/kernel/cpu/mshyperv.c     |  4 ++--
 drivers/hv/hv.c                    | 30 +++++++++++++-----------------
 5 files changed, 31 insertions(+), 31 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
