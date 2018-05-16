Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-968028-1526507576-3-15761058803525197448
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526507575; b=iSKQZGvEXqxa5ZzbNoIRdV7Qol3w6kQN8QmR23tYoNS/C6bHp9
    PvD1MGglm/x+hmBbij63paU+khQoLip53q8zfHnlxfgB6iSKNndbJ5Oso+j5Qo1m
    n97V8N4fhg6lTHB6EhJHhZy61il3W7/8uyHv21SpzaN1sBmKVkFukweUQ0hX1s8F
    vfgf5Eog8xJN5Q4gmeHPpYOZ6bHO9Gbj5HbsHESIX+lBVdq0+ETDfR0cwD0PsZo/
    7oTuyoR9uRl8msI4HXBBfDhGs14K9wn5LGDEupptbY8HoEunFLNp2wB19l6Bkt0L
    qq4kXgnUhujZl+Xhxf84RiOlpFI8Z1IwDpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526507575; bh=tLuh9
    yjfyrz3kvmzJocxe/Din9qrFBFMDTC3iaE7ohI=; b=FgeX6KqvXMMgs6t9lVC1L
    JNO58K9PAmRf4pzjke0S4HzPw99wKh3DgIBlGc64I+GWY4ADtoU40B3PdrbtXQBb
    sNCCKQxG9cSQ6mGjW/rVw8DnxnLr/rqX2ebIFIt0dem9svxGlEx8qbImlk0Pb1Ed
    8srUc7YPYR5ZeKOPppJnICrgSjcM9MxU390pbHQQzU9R0VBMsCxNkEJ7+LryVFu9
    yl4qKW/o4ToFPDw7gh4gxIpOAw82ELzb6RdNe33vmL4j/3boP0LWuKAqSmG8tt1f
    N4Di5mSs65ExrKRUhHs0nXGRS+/KdFFV68giz3Ivb61E5PwX8Fo2MYzHb60GsLcU
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxonhyperv.com
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxonhyperv.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEEIDTKtgaAywbD8gf02FYGpbdkfHRFFmAxZQskizsnje/OxrJbAP7Wnc3+QjWgTX/oBp+TeZTqeePmUlKb+9i4Imq+/r40yGQ5kFYuDyY/b+kpFle2W
    AESIFeDMIWdwZ62+gh7qYdoSA/oCvPRr+kusJp87iJzobqDbjzbSyCjSz4zybldTrK0ARmX3axJjqszoMANkU8hYZk0RZJ2CCM3N8kStOQX5Sdt78esNbRx0
    GYhC7hrRAbOPcCtaTzSW0w==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8 a=0zQdKNvPnbN3BBR5kWoA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 jasowang@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V3 0/5] X86: Hyper-V: APIC enlightenments 
Date: Wed, 16 May 2018 14:51:44 -0700
Message-Id: <20180516215144.6481-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
X-CMAE-Envelope: MS4wfHGL/BmCWT4A7R3ugGLI3bBO1efzjjEzFoE7XTzWeRwNt3YGV0+ib5Vd+EBZl9rEDUJM//PtjAi7nRvHwG0t6ONsZyopQM7BbfPL5o8M/lEpYPPRCrnq
 BoHBACMdU4dZh/2f97EkCujSlj6i/rbUJCF5721GC8MpHX7HLn8Zi0fYz22q78itFvCPegstXadZhu2CdkFvmbU0hsrQS7/H01Pj00i70sxBGyklobntWIfg
 hU/1LKeqYPJ/4n1ASKqP2smpMCdKVXxyetBllN8k1uF2ZcyKKAPhiNXO70QxxKYdvezVxikYIV91V9VcSQXzFKzHESrG8uIVsDeksk0TJU87ORPA2uQHE9r5
 8HQfTx44vmp8PPcDneDjQC0Apvp+nVn4mCZVO8n1tqDViIj+uvYKc3+KJibLQ/B6eILZTvRPHBaBmAQveyqzHZWprHtuOFrpg2di6AE6zOAmyKrxJhFJTvwK
 SCKAtIyOjpKebTqlOHHylPTgK884rNCJBVXoqBsSmSL4HDzYV/DdAL7yYlh7npAUTN/14p/rnWWfDC3+XEKRDZ8Kzi+MmMC5aUaASG7ioKqLZuOqXxLlqGUr
 YNK5nIyOq0++KStid0L4svdC
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

Implement APIC related enlightenments.

V2: Addressed comments from Thomas Gleixner <tglx@linutronix.de>
and Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>.

V3: Address build issues reported by kbuild test robot <lkp@intel.com>

K. Y. Srinivasan (5):
  X86: Hyper-V: Enlighten APIC access
  X86: Hyper-V: Enable IPI enlightenments
  X86: Hyper-V: Enhanced IPI enlightenment
  X86: Hyper-V: Consolidate code for converting cpumask to vpset
  X86: Hyper-V: Consolidate the allocation of the hypercall input page

 arch/x86/hyperv/Makefile           |   2 +-
 arch/x86/hyperv/hv_apic.c          | 261 +++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c          |  32 +++-
 arch/x86/hyperv/mmu.c              |  75 +--------
 arch/x86/include/asm/hyperv-tlfs.h |  30 +++-
 arch/x86/include/asm/mshyperv.h    |  39 ++++-
 6 files changed, 367 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_apic.c

-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
