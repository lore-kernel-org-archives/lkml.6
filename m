Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3747897-1527881924-2-11648664318957526971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527881924; b=aIk5KN+dGA7U6JQBrrg7BQ9UYHesJzyf2ceMhGmvTPZCRkksWx
    M9f37hMpDFu+wM59ufF24dYuAcxhmToM19p6FXAUmuIhmVZJxgzGFhlOoCDHHL10
    okzZm5SvqhYKb1lftZ2mEMH7BSBfDrG76Y6uOPCrmjXFEnSKarznbGmg3kB/uQgt
    IcTZqiMy7N97Reymj2SmRU/dDmnUcVk3WRrw/Zw/HiAy1jnds5a3T1ovLjzU9u7U
    rHTh0yQ+XvEF+K/LlvzK9ibvkZ+KEbB/tR7GqeSAx961256McRM/plg3wNKF5/li
    sLC1rKNOwK5W2vLV4fC+DZ0cDn7HvPC3nr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1527881924; bh=Uc617QCuGJ
    gvbEMQu19SyzXb5hZgwrtrclubE6Usj6w=; b=N57cQq/r+2YJxGuoPhQOVEp3AR
    vw+iHVI6HXVSoU+DBErBXkPMH9vK1w1Psom/dwhAnkpLivx4wH1B3LEfiIKNlB+M
    ro1M8SI60K3jxTYdbJZ/VbmmUsPQSjWMM6DbKjl5sW0Lqr9j+t9si4U/icy6WL1g
    HkTF7TUut1eswwfuw/M7rgXqnVlJ/LIKqkYkvITh26EWXzr5anlLgSGaGL3f0ONJ
    tSbLvv3Wc7zbONEFePF6yyRPpn8wZGMd+U/armw1qa2ql1wwI22wR2HLquGGVqIg
    8W4PTE+0eQ7/Wriawc4GE52g+BWdh764lX6jNjyeW3rPIcpI8bpTa3fPt4/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPHdlOv4/xNhofXUVRdtL/5OA4EpdtNhlm8mJlr4e5c88S0IveW2Vi35fBtPz3mjhwndONPHYLaJfCDBOFmiEZDHgyV2xYU7btRXAwsnk8zSJ9Yn7RTW
    f9x3yBTj4uTJCqeIA50RbTcwyj+SvS6+7Ps6/oENzi/4RbQJV0qV+P/yUux8YLmocU1EqAdRpAukoJmX24XQYAjsrCS2RMgdG5Sn19008O/IDakt5bF3FXlA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=MJJdeXxr-TQA:10 a=IkcTkHD0fZMA:10
    a=7mUfYlMuFuIA:10 a=VwQbUJbxAAAA:8 a=pV0Oxj85UeV4ogqd-wcA:9 a=QEXdDO2ut3YA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeFATil (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 15:38:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:57231 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753080AbeFATik (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 1 Jun 2018 15:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="59645238"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Bhupesh Sharma <bhsharma@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH V5 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Topic: [PATCH V5 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Thread-Index: AQHT9vOycW5QHpsqGkehQKqjrruTMqRHApcAgAU6ygD//5RkIA==
Date: Fri, 1 Jun 2018 19:38:33 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F3B53A8E4@ORSMSX114.amr.corp.intel.com>
References: <1527560464-19466-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_Wy2=8eC3U5Xuj_4CLsFmgQoeq34RPVaPOusvMA2i-7Q@mail.gmail.com>
 <CACi5LpOk6e+=Ly4r4WP+Mriq5ThAcnU2UJ8Eupz4gCTfeYB71A@mail.gmail.com>
In-Reply-To: <CACi5LpOk6e+=Ly4r4WP+Mriq5ThAcnU2UJ8Eupz4gCTfeYB71A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmU1YzE0NzMtMDY4MC00NDdmLWE4YzAtOTNmNzMxYzFlMzdiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZEFpWk9mdGNydWlPM010WXVTZlNZTG9OeXVkSUpPNU82aUtTZkZFMEJtU2tiT09YaTI2T043MlpLWDVIeVZ4UyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiA+PiBUZXN0aW5nOg0KPiA+PiAtLS0tLS0tLQ0KPiA+PiBUZXN0ZWQgdXNpbmcgTFVWIChMaW51
eCBVRUZJIFZhbGlkYXRpb24pIGZvciB4ODZfNjQsIHg4Nl8zMiBhbmQgYXJtNjQNCj4gPj4gKHFl
bXUgb25seSkuIFdpbGwgYXBwcmVjaWF0ZSB0aGUgZWZmb3J0IGlmIHNvbWVvbmUgY291bGQgdGVz
dCB0aGUNCj4gPj4gcGF0Y2hlcyBvbiByZWFsIEFSTS9BUk02NCBtYWNoaW5lcy4NCj4gDQo+IEkg
d291bGQgZ2l2ZSB0aGUgbGF0ZXN0IHY1IGEgdHJ5IG9uIG15IEFSTTY0IHF1YWxjb21tIGJvYXJk
IGFzIHdlbGwuDQo+IFdJbGwgZ2V0IGJhY2sgd2l0aCB0aGUgdGVzdCByZXN1bHRzIHNvb24uDQo+
IA0KDQpTdXJlISBUZXN0aW5nIGlzIGFsd2F5cyB3ZWxjb21lZCA6KQ0KYW5kIGlmIHlvdSBnZXQg
YSBjaGFuY2UgcGxlYXNlIHRyeSBvbiBVVjMwMCBtYWNoaW5lIHRvby4uIChwcm9iYWJseSBpdCBt
aWdodCBmaW5kIGlzc3VlcyANCmFzIGhhcHBlbmVkIHdpdGggbW1fc3RydWN0IHBhdGNoZXMpLg0K
DQpSZWdhcmRzLA0KU2FpDQo=
