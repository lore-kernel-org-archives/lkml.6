Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1815473-1519747019-2-2359636046886435751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519747018; b=cb4udoETmTq+bSw72Qz8+skUp349iduQW2xsRRJZe7NV1NO
    ZxRG6in55Xne6yj5pso5tBTI5ZCRx/a9Zd8luqmFjmorS1YoWAKeSbolEEMaleMI
    3Qci+nWcFTEOPZ1cbfWFZzA0Z99u3P/oEn7sEOnDETK/qxkMObZlMRveQjoF2FkE
    +hdesneQAh25YRDzc62esx7JL8rMX3mmP2apH0/33ecp8EpzrfSgsmD8mua1KaDU
    7j45MjrI3QsQY+sKPIbR0oVlhoW+3RS04feo8lj+EOtC95rLz9vgeIs5l2nzyiMx
    2GWCAn2dZqWodbSo55yBhqb+r8QURKMp80XGnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519747018; bh=guP3CoJ92NCGpOJWCUxpBQPKufFUt2IPNVt84cVn0ws=; b=r
    KMFaRo8UBgHWrpivABBiYYHHuEgLNo+dPhyqKrS9jjob45LDRAR5jTptHmOLmwdB
    rYqoNQON3L0jy4WGvNkuQWXrIQcje/h/X/6dzBRW6VY84c2iv+lsiZL2QqkkKIB7
    W1xO4plEJMmMgYwILfqCjAkSGe/Z/gt6nHDLCYhi7dT8A9HnfHm1zk2EBLJFp7Jt
    RKr398IWsNIn6PV3fcZ7QMRRqKz9jHQf2Yyo3WNBUAxZM7YRhgbwkGb4RQCn0hgQ
    pGrzcm2YeF5btjFXThnZ1QcXBAzJETif9lD8FgCkCqPS8XWZ7LLLI3CserSCuHIi
    UzjESsxQLqNbmoSqleUHw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.com header.i=@amazon.com header.b=d84xNMEB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.com header.i=@amazon.com header.b=d84xNMEB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeB0P4Z (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 10:56:25 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44626 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932176AbeB0P4J (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 10:56:09 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515456000";
   d="scan'208";a="668545263"
From: Amit Shah <aams@amazon.com>
To: <xen-devel@lists.xenproject.org>
CC: <linux-kernel@vger.kernel.org>, Amit Shah <aams@amazon.com>,
        <stable@vger.kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Eduardo Valentin" <eduval@amazon.com>,
        Juergen Gross <jgross@suse.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Liu Shuo" <shuo.a.liu@intel.com>,
        Anoob Soman <anoob.soman@citrix.com>
Subject: [PATCH v2 1/2] xen: fix out-of-bounds irq unbind for MSI message groups
Date: Tue, 27 Feb 2018 15:55:57 +0000
Message-ID: <1519746958-52077-2-git-send-email-aams@amazon.com>
X-Mailer: git-send-email 2.7.3.AMZN
In-Reply-To: <1519746958-52077-1-git-send-email-aams@amazon.com>
References: <1519746958-52077-1-git-send-email-aams@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

V2hlbiBhbiBNU0kgZGVzY3JpcHRvciB3YXMgbm90IGF2YWlsYWJsZSwgdGhlIGVycm9yIHBhdGgg
d291bGQgdHJ5IHRvCnVuYmluZCBhbiBpcnEgdGhhdCB3YXMgbmV2ZXIgYWNxdWlyZWQgLSBwb3Rl
bnRpYWxseSB1bmJpbmRpbmcgYW4KdW5yZWxhdGVkIGlycS4KCkZpeGVzOiA0ODkyYzliNGFkYTlm
OSAoInhlbjogYWRkIHN1cHBvcnQgZm9yIE1TSSBtZXNzYWdlIGdyb3VwcyIpClJlcG9ydGVkLWJ5
OiBIb29tYW4gTWlyaGFkaSA8bWlyaGFkaWhAYW1hem9uLmNvbT4KQ0M6IDxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPgpDQzogUm9nZXIgUGF1IE1vbm7DqSA8cm9nZXIucGF1QGNpdHJpeC5jb20+CkND
OiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPgpDQzogRWR1YXJk
byBWYWxlbnRpbiA8ZWR1dmFsQGFtYXpvbi5jb20+CkNDOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NA
c3VzZS5jb20+CkNDOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KQ0M6ICJL
LiBZLiBTcmluaXZhc2FuIiA8a3lzQG1pY3Jvc29mdC5jb20+CkNDOiBMaXUgU2h1byA8c2h1by5h
LmxpdUBpbnRlbC5jb20+CkNDOiBBbm9vYiBTb21hbiA8YW5vb2Iuc29tYW5AY2l0cml4LmNvbT4K
U2lnbmVkLW9mZi1ieTogQW1pdCBTaGFoIDxhYW1zQGFtYXpvbi5jb20+Ci0tLQogZHJpdmVycy94
ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldmVudHMv
ZXZlbnRzX2Jhc2UuYyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jCmluZGV4IDFh
YjRiZDEuLmM4NmQxMGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFz
ZS5jCisrKyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jCkBAIC03NTUsOCArNzU1
LDEwIEBAIGludCB4ZW5fYmluZF9waXJxX21zaV90b19pcnEoc3RydWN0IHBjaV9kZXYgKmRldiwg
c3RydWN0IG1zaV9kZXNjICptc2lkZXNjLAogCW11dGV4X3VubG9jaygmaXJxX21hcHBpbmdfdXBk
YXRlX2xvY2spOwogCXJldHVybiBpcnE7CiBlcnJvcl9pcnE6Ci0JZm9yICg7IGkgPj0gMDsgaS0t
KQorCXdoaWxlIChpID4gMCkgeworCQlpLS07CiAJCV9fdW5iaW5kX2Zyb21faXJxKGlycSArIGkp
OworCX0KIAltdXRleF91bmxvY2soJmlycV9tYXBwaW5nX3VwZGF0ZV9sb2NrKTsKIAlyZXR1cm4g
cmV0OwogfQotLSAKMi43LjMuQU1aTgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55
IEdtYkgKQmVybGluIC0gRHJlc2RlbiAtIEFhY2hlbgptYWluIG9mZmljZTogS3JhdXNlbnN0ci4g
MzgsIDEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVyYnJpY2gsIENo
cmlzdGlhbiBTY2hsYWVnZXIKVXN0LUlEOiBERTI4OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBBbXRz
Z2VyaWNodCBDaGFybG90dGVuYnVyZyBIUkIgMTQ5MTczIEIK
