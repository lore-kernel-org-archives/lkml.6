Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-568472-1520227013-2-2999095994769029103
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227012; b=JB9o6jXmFD/Nd6ImQp1r90Q+PQMbWIX4dbMxYMN/XjZrYnq
    9IWkGxfpIypm1XuKeJrqNwEoV9sTgp4c3wh6iYwENb8g/rR+E7JODJEyNfAI5fPi
    cj+yiXqVU3PZx+Kq37Me/31EUy2BAd9W2wkPXdvNWWt+h/JZGpNRixyo6YK678yW
    nFlf47MfUHhspSfen3UlDVKO6IPrHHOPZaDENrujwV7o8NDKJ8TaDDE1BTkxnqhZ
    1gq/vVXYvTKhU+PpG/BBZWb/pXwWAmNAZt54PRBWbC8Lrkf0UdxAlVTzNdZabOMd
    WRfnMw4yk0k1Bt+EIGppilPS4+Qkuk/fAHcu15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520227012; bh=s
    7d8U/ljuhWud/zwD/8tnMnmojJNNhtpzs7PXkXmjHQ=; b=lFDLB++C/1q8SHPaf
    1SFVVZtovHtZHlD4OOksVNXgEIEv2DWmfy1UUn+SOYIDBCWxv4E0dDE9cePh55nA
    Gv4W+op3PSxCCPkAFlhPRc1Od6O0wSBl504qbuy1oxV5JZAQ69baYvfKqzjm51vP
    7F75il0rUeWlYrVl9wHz5a6DJCtd/wKR6UUgsgWhcGoBI5/V70ATVDEeAzRz29l1
    TwRY4cUqnn867YJMVSrOSg1OShMGyqwb2QBZMES3K6KVp979JT1j+ztx+37vwDdq
    3ku2JLiQUJaoVD2+pgDfcGDFT0NPcgNXbnUH1rE2DPDUDLc1W00uvQJg0kM0subf
    OzvVg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 00/12] Drivers: hv: Miscellaneous fixes 
Date: Sun,  4 Mar 2018 22:15:39 -0700
Message-Id: <20180305051539.19079-1-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfFVlCwteshYGvEzQkQ6qjr7WCEp2ijvaAy9NPIZ+3JBgzh5B1eu2ltcGfvVpy2nmTuEvCcokkZ51aMEskgao8H7Pfz96AyLpEgfY//7zQ3YNhW0skmbX
 aKDWpz1ADdCLaB4zpWnZmQ01ckrBGdCFyo6iHiPl35TFH3yOoYdeakoUVOMK4V5TxELA75EZIQthcRLYmKdNnlM6GSBMUrRM1XegEWCaIrFgHxJeLwKABkXI
 J6V30mRzWyCarz4gtMOtYvGPRAeWeh05eSfl+wrkmhnNCYMVzAKGOoF3kAzxFW770GuX2FVGNUaZnpqe/fKorE8cwL9Bvy7HJ3yM1ZrIp6E7oVlQyrzzBKwS
 zPJuKkSCLcz2rlPfUeTmDllOiXwiCwxnA77lqhaE/FR5qzQkCFsSmOx9Fn3RBb5R4IogSnHGhEMsmapJfdWjiS6TSeYXgIILPWpmRWb9A554OaUWhLgSnQNb
 ceDBpijOrdGjV2J1s5x1BZZ9lJNF041V1AVoP2LPA6WgGyhyHem2SjRPzTnZZrf9vX6bHPLuFe/oCuffmLU8czJCD/A1GeO0baYPNg==
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
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Miscellaneous fixes.
	V2: Only the patch "Drivers: hv: vmbus: Implement Direct Mode for stimer0"
	has been modified to address review comments from Dan Carpenter.

Dexuan Cui (1):
  tools: hv: fix compiler warnings about major/target_fname

Haiyang Zhang (2):
  tools/hv: Fix IP reporting by KVP daemon with SRIOV
  hv_vmbus: Correct the stale comments regarding cpu affinity

Jia-Ju Bai (1):
  hyper-v: use GFP_KERNEL for hv_context.hv_numa_map

Joe Perches (1):
  hv: Synthetic typo correction

Michael Kelley (1):
  Drivers: hv: vmbus: Implement Direct Mode for stimer0

Olaf Hering (1):
  tools: hv: include string.h in hv_fcopy_daemon

Vitaly Kuznetsov (4):
  hv_balloon: fix printk loglevel
  hv_balloon: simplify hv_online_page()/hv_page_online_one()
  hv_balloon: fix bugs in num_pages_onlined accounting
  hv_balloon: trace post_status

lantianyu1986@gmail.com (1):
  vmbus/ring_buffer: remove some redundant helper function.

 arch/x86/entry/entry_32.S          |   3 +
 arch/x86/entry/entry_64.S          |   3 +
 arch/x86/include/asm/hardirq.h     |   1 +
 arch/x86/include/asm/irq_vectors.h |   3 +-
 arch/x86/include/asm/mshyperv.h    |  13 ++++
 arch/x86/include/uapi/asm/hyperv.h |   3 +
 arch/x86/kernel/cpu/mshyperv.c     |  40 +++++++++++
 arch/x86/kernel/irq.c              |   7 ++
 drivers/hv/Makefile                |   1 +
 drivers/hv/channel_mgmt.c          |   6 +-
 drivers/hv/hv.c                    |  63 +++++++++++++++--
 drivers/hv/hv_balloon.c            | 121 ++++++++++++++++++++++----------
 drivers/hv/hv_trace_balloon.h      |  48 +++++++++++++
 drivers/hv/hyperv_vmbus.h          |   4 +-
 drivers/hv/ring_buffer.c           |  49 ++-----------
 include/linux/hyperv.h             |   2 +-
 tools/hv/hv_fcopy_daemon.c         |   4 +-
 tools/hv/hv_kvp_daemon.c           | 138 +++++++++++++++++--------------------
 tools/hv/hv_vss_daemon.c           |   1 +
 19 files changed, 341 insertions(+), 169 deletions(-)
 create mode 100644 drivers/hv/hv_trace_balloon.h

-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
