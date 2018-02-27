Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1815473-1519747018-2-15869373645375082693
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519747017; b=bZwXuLTXsUArNblfKo5krjtUm/e5xr6esIL5nvYmzuW4ctN
    PM3m8rudpnGjUB0j6ST3fIDa1BLDGY+QeuKI5D4MiT/XXz6EEtd5ORUwLyqK/EnW
    oN15p5zSx35bv7NK45hacpkbq/cn0OfwtrhoYMR7+sTtmnDiy6jmuUAZMWAeweni
    6VQlD3g+nnkQccMsCufM+6Yj+5qTH0I90VI+qsDjGnkSpvtPykZkn9FyRSKdFCzp
    e6QWbvJt+HIENRiGWfys+ZoxszCQNOpQLJw61+J+kjEhU7llh0XylGt7KhUfBcku
    D7S6mn/WhnjVtMMhNdA/F1eMjF7bhHj7RBEnGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519747017; bh=3zPl9aQCvbXraCwel6kLHYVTIdi5oUtlMlHGyNDb9fk=; b=m
    bD46YxclAawRh0HG4K9tgpIp/atnUYItlTPk4wVr7SoFogA00PQuZX6wBGj5ozdR
    Acbh7msnEBWdUopQGAuR7f3OUGllPMM59s8D3NabUqaukeWoZk8IPQ2rgleY/c9L
    0LIgLrk9jhzlJYx9OI2nfFa8vK5eqGJjNfmPOiGEvt9rH/tAHM05ACa+wam9OO/C
    eHvl/cANdnuU1UfcnQ+b7qxj0VSC8wdO0WBINQ0HS8wf3pMGatMz5ZiY+n+0O03r
    iuaaIBHclIk8vBAA822ks+G1Ri7JyFWPKacuVRzWmB7yGbDdL6ZFYT7CiuEut83o
    nVH2W71QI50JAxn5tK/Pw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.com header.i=@amazon.com header.b=UXBvpb9S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.com header.i=@amazon.com header.b=UXBvpb9S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932096AbeB0P4H (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 10:56:07 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:42067 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754361AbeB0P4F (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 10:56:05 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515456000";
   d="scan'208";a="721844579"
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
Subject: [PATCH v2 2/2] xen: events: free irqs in error condition
Date: Tue, 27 Feb 2018 15:55:58 +0000
Message-ID: <1519746958-52077-3-git-send-email-aams@amazon.com>
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

SW4gY2FzZSBvZiBlcnJvcnMgaW4gaXJxIHNldHVwIGZvciBNU0ksIGZyZWUgdXAgdGhlIGFsbG9j
YXRlZCBpcnFzLgoKRml4ZXM6IDQ4OTJjOWI0YWRhOWY5ICgieGVuOiBhZGQgc3VwcG9ydCBmb3Ig
TVNJIG1lc3NhZ2UgZ3JvdXBzIikKUmVwb3J0ZWQtYnk6IEhvb21hbiBNaXJoYWRpIDxtaXJoYWRp
aEBhbWF6b24uY29tPgpDQzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+CkNDOiBSb2dlciBQYXUg
TW9ubsOpIDxyb2dlci5wYXVAY2l0cml4LmNvbT4KQ0M6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMu
b3N0cm92c2t5QG9yYWNsZS5jb20+CkNDOiBFZHVhcmRvIFZhbGVudGluIDxlZHV2YWxAYW1hem9u
LmNvbT4KQ0M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KQ0M6IFRob21hcyBHbGVp
eG5lciA8dGdseEBsaW51dHJvbml4LmRlPgpDQzogIksuIFkuIFNyaW5pdmFzYW4iIDxreXNAbWlj
cm9zb2Z0LmNvbT4KQ0M6IExpdSBTaHVvIDxzaHVvLmEubGl1QGludGVsLmNvbT4KQ0M6IEFub29i
IFNvbWFuIDxhbm9vYi5zb21hbkBjaXRyaXguY29tPgpTaWduZWQtb2ZmLWJ5OiBBbWl0IFNoYWgg
PGFhbXNAYW1hem9uLmNvbT4KLS0tCiBkcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyB8
IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyBiL2RyaXZlcnMv
eGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jCmluZGV4IGM4NmQxMGUuLmEyOTk1ODYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jCisrKyBiL2RyaXZlcnMveGVuL2V2
ZW50cy9ldmVudHNfYmFzZS5jCkBAIC03NTAsMTEgKzc1MCwxNCBAQCBpbnQgeGVuX2JpbmRfcGly
cV9tc2lfdG9faXJxKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0cnVjdCBtc2lfZGVzYyAqbXNpZGVz
YywKIAogCXJldCA9IGlycV9zZXRfbXNpX2Rlc2MoaXJxLCBtc2lkZXNjKTsKIAlpZiAocmV0IDwg
MCkKLQkJZ290byBlcnJvcl9pcnE7CisJCWdvdG8gZXJyb3JfZGVzYzsKIG91dDoKIAltdXRleF91
bmxvY2soJmlycV9tYXBwaW5nX3VwZGF0ZV9sb2NrKTsKIAlyZXR1cm4gaXJxOwogZXJyb3JfaXJx
OgorCXdoaWxlICgtLW52ZWMgPj0gaSkKKwkJeGVuX2ZyZWVfaXJxKGlycSArIG52ZWMpOworZXJy
b3JfZGVzYzoKIAl3aGlsZSAoaSA+IDApIHsKIAkJaS0tOwogCQlfX3VuYmluZF9mcm9tX2lycShp
cnEgKyBpKTsKLS0gCjIuNy4zLkFNWk4KCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFu
eSBHbWJICkJlcmxpbiAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEtyYXVzZW5zdHIu
IDM4LCAxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhlcmJyaWNoLCBD
aHJpc3RpYW4gU2NobGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFnZW4gYW0gQW10
c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==
