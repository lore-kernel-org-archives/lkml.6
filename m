Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3741095-1525414084-3-7111648132800688717
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525414084; b=irhfAKbt888MKTgbSjVF6L/pkt7c9WgD+ZIgFPHYeM2Rx1rllV
    aq0rCCEm+b43lDc8FRQK70usZgRkGGqh4cEAb+h03o7qFLyFy0jSbkULbaQmQnzZ
    OiID6YG3okAUZejIwuggFTAWIDoyIXPhcwuPXKii5ix3kHKDh3sE/ZwS9NA+2i+V
    dLLiZhEapRVZ4fJBFLIrLPl0Ik3H0qBoGU2idwpUeFLlfPOs7wQs4LOyCV5xGj5/
    NwvbXC/P84vSccg+8WdhW5+/6V6a46TUt2PwG83dF24svMRGwpCwVYsD8YrT6LIL
    HflAwbXe4zvxqldjAFK8G2RoeaRXx9cPCrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525414084; bh=p6bJz
    25nE2gn42DuTdRlONEJa3wJ6fVsERC82mX1A78=; b=M9JU2qtSv2XuIhvaKjNCL
    G3EOMaLPme5FGNiZqhkhF9CsvZXf3rSANfgmjYg+Y4xmlIk70ZpkycwbpDfj65sy
    sTSGW8LONwT9L45vT8jIwiMVDZiq/c5TkOVKuJakj63Q4nEBxMdGq7VjQ/GakEva
    xI3lVjmhksbUhiZhMtgIuIw8omSgi4clQLs1R4rVhWLXT9Yua//RFloG+HRJGEcW
    zfEifnoUeyWD9jns33fqc1jRXAZeNa1ij21JGWNe9HkDAFTHc01ankQ5Y3IxpQMs
    FxTGnic/yhKoQ0X1uV4b8aIFuPofRcJnd4s641zCwWBGI/MxTX2ZYpn82rrmYwnJ
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
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
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxonhyperv.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCHVVjFwfHEomcRsYzMYnOG/exPw1sqF8lAeDJ15Wxv4Dsu8R07jfzckmz7WQuX76JssI1jSuf/Y2krJBvV9Tdslzlra2peHyPnEt7LigCVcoFSGTcrT
    WNMM/9UrCKdr0wfV5BGRMlgbrRznTbmE7BVtfSTmxaqBv8IT+gK5ZlGJyHyqn7bjAsVg8Jya5nruuZyJtSCi0FwMfSPmAxdfUSSYPAjweDB13PT4GjnCAad/
    JT9HO6prdrfrcAmdGmN81A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=0zQdKNvPnbN3BBR5kWoA:9 a=CjuIK1q_8ugA:10
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
Subject: [PATCH V2 0/5] X86: Hyper-V: APIC enlightenments 
Date: Thu,  3 May 2018 23:06:53 -0700
Message-Id: <20180504060653.3240-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfH64OiKLpbms/bMoAerBxBU1/iL0bnzv7ZQrl0cHp1OLFD9QBZFRPe7mn3SrfvFcC3jEukCTGh26aZnei0oHbXKxyr5WApBqaJ1l4GF+HVgW/gK15Nst
 HoY7/yl5Y7McrbXxto/BO/EnEy76yaS1Xu6LDXQmAec3nlBnRPHr5XCUx/GibNxEYcefmbEkWZcdixc58/W5vKhLIipEUWPJXEpQTbFeGszg2AAkDK4Ea8so
 KB+jyr9nIOcRrAMd9DN3yNaSDEK9ckz188x4BxRsOtYR43+Gnzl+JbXCHMst4X/RcKbufqpaW+Vbb0RePsH/Fctpd9xCvc7JvPqLYkvafzKoaOM7cL5V2FAg
 +p1Lk2ZNfc2Dil8FYJG0HkfOn1Gu0Wif6ebgQaN8Moig79iF/71vUZYG1dVZasC2mj1ozH/DLEgCrIliK0t0RP3HhUJgJu7ij9qUuOAEIoMKF/vOpzk0J0pK
 dFi5x3Hg2d+JN1yDFL9ITJVj6exw6jaM7SlHp7fnSIcRO7Pl7wFlxIX36mSCqDbp2d1UlddNz6LhvmCsfXk/2lM3jK67WbkGVfkmx8OksbBEGdyzbgSe5cvk
 zqg7WtqHCHX6KRT8DvNjMzt4
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

K. Y. Srinivasan (5):
  X86: Hyper-V: Enlighten APIC access
  X86: Hyper-V: Enable IPI enlightenments
  X86: Hyper-V: Enhanced IPI enlightenment
  X86: Hyper-V: Consolidate code for converting cpumask to vpset
  X86: Hyper-V: Consolidate the allocation of the hypercall input page

 arch/x86/hyperv/Makefile           |   2 +-
 arch/x86/hyperv/hv_apic.c          | 259 +++++++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c          |  32 ++++-
 arch/x86/hyperv/mmu.c              |  75 ++---------
 arch/x86/include/asm/hyperv-tlfs.h |  30 ++++-
 arch/x86/include/asm/mshyperv.h    |  39 +++++-
 6 files changed, 365 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_apic.c

-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
