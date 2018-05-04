Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3667791-1525410055-2-6650221610712775650
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525410055; b=QzlZsWyoXmHn5DK92aTAMYzucGEVmR20TzbhCfTV/o0BgsVQbG
    ShIY89kgsldo3eVNPyNF7RhNllxZdQkbf5IzKCXdQ0usdgfprRkyj6zxd5rxBp8l
    TWIFHD98EbL48dXZ9A4sYSl+alxmwdLqcvhprgisrT3qx9Ale+a2iQ4yr71TxuLR
    SoSz+yooZI26mTkSbN2aNgI9rY5q87F6hhdkOKJnsofAg3DgTGArWgIa65ZEeZLs
    jkuMtxy/OflHuZI+ZpovMxLqUcqXezlFLootrO4+sdN/OnMJzU15pJ8i8dboxNOW
    eI07743YcsuisYe0/WxolPDZ2FIqoJ/zL9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525410055; bh=mPpkN
    b/wEAdflRJdKd9Mn4JC/pYIUdeHemTzpVm5maQ=; b=XAWxDOIbmxXvQAIDziu4h
    kBJVqrj951vDnNlQ4CvqKK1bkPLKYPWAxjOCA0KuKzWfnyz9miBPmVMFDnlO9RV+
    AYXr8mabMD2TVhtN7qM3n9SuvHcs94emKAwzILgLRtODL/oZwXvlZq5TkXR6uV22
    SedsPJTU09Ljr6Jr8OAjrWNzZQtOSKB+UkGcOZPO2rNC52/CvmtvxDnEaJ4nUgKG
    s9VcLbdu4R8z6z861JJIHiZVABSyayM3xXBftD9/+lXYDSJ1HIupVp1FjvD2gCfJ
    wt6+K3GcmWFQUSd7nFcfVEMe2+WCx9C5NiKXVbitdyiQwpWczxLKD8yEp8/UWyjt
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=brown.name header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=brown.name header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEowGw7+Bo2F+r4oi8n1BXbeVX4vLSemj7xh6UUSXdrWgMPDp3fmZ2QwwUF/wWbOzORA6RYGyMbRh8hGV+Tt7PaN3AQtD8YqCYmwjIq3RlsAo0bC+9HV
    4Ou/t5oY78hOOEUQhvGpBhSuQmF5GOgOk0RWZd9vXI1XT9QVxAhGt5cQUj/r2Qjyi2TI4zfyWvDlUJryuiurKWVl7LHkFZApu6B4Korfzt+H0MqDtdlFH6XR
    YXoe7vo7QT7kuPugHpktaQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=AZKa23BuJWmuy-52xWQA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 04 May 2018 14:58:35 +1000
Subject: [PATCH 0/8] staging: various mt7621 fixes
Message-ID: <152540982998.12190.15220622955317261586.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Highlights here are a bugfix for the ethernet driver,
and proper handling of irq assignments in the PCI driver.

We also make the full 32M of the gnubee flash available and start
cleaning up the mt7621-pci code.

---

NeilBrown (8):
      staging: mt7621-eth: Lock is never unlocked.
      staging: mt7621-spi: remove unused lock.
      staging: mt7621-pci: improve interrupt mapping
      staging: mt7621-pci: white-space cleanups.
      staging: mt7621-pci: remove conditional compilation.
      staging: mt7621-pci: remove unnecessary resource details.
      staging: mt7621-pci: remove some dead code.
      staging: mt7621-dts: update nor-flash info for gnubee1


 drivers/staging/mt7621-dts/gbpc1.dts    |    3 
 drivers/staging/mt7621-dts/mt7621.dtsi  |    9 -
 drivers/staging/mt7621-eth/mdio.c       |    1 
 drivers/staging/mt7621-pci/pci-mt7621.c |  482 +++++++++++--------------------
 drivers/staging/mt7621-spi/spi-mt7621.c |    3 
 5 files changed, 175 insertions(+), 323 deletions(-)

--
Signature

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
