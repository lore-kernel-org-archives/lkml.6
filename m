Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524652887-2-936739360814055831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652886; b=ONiXnnThDNjz+BtAH5E3Wfe3sGqlusMZG1R6vXNgg835tSVUYy
    Hhtr9NLrWGObN0cC0fqj/9VTKA3/8Z9Oj5ByyJnnPlP4XqF6bRJna96gUevoAj1O
    X/kiRg/obhoV1XeWCrOyIFOEQBzXOwAYwzimAEZ7tD+vPu3wmsiGAXFvFUKs44Ju
    k/H/lIMSnpXvSLNShcINYpqIKitvzXtE1wGqItv03sh6C7TT8KRloRHOPq7hkv65
    y2FsDpWSFjbxTh40bCz6Ilw0hEqkXOvkoqR+2CFXrEqZ7QIWjmI0OplYEQdci54m
    hp2EuVY7eQMPJpcbAxAkcGgMVynxlJxmzVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524652886; bh=WCbrD
    zWaVF/iomNTFK5vIBs/f1B2hQ4J0mcv2PW8V3o=; b=sMvoiXeBhF8zBODyPTSAO
    ApB/tL1Er5JkD3IcCDiPU886U9VPNsX+nyoypKyflbk2zTKooah4yujEWu9CqHvy
    M8E83JuzrOB0cJgCI44rLGp1z5YAosZT8PlkkJRwzR8jahMurBVvNCKMnVGST8Ax
    XDKJl3eLwA70lEb259nhafRIWsQBXKGI2NEPSZBrzYdEU9zpm/iDduitpNs5qCwB
    ra2uGw60esEVwSepuSSiKPpG0K9CD/iDBMVXmYnXzjlceAtVswZXAhvCeP9/tTrn
    lsDr2xo18YJx6co8nHCJJJa4pD/ltyPKzZ/1egTsz+Cg0IHrGO5LLA9W3yLQucYB
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEEX7kaCI2aRPoFLgvgu7Haf4MDTXydkaVs1Ym/rhP5VxAUytfjpNge5xX6qH+hnA3+BtBIbbwb/fOvhbPPibgB1UQ4+rqIAs0WJTl2hYV82EIxpr+Hv
    QGJ8UW1wmtaQfdeSrALBwYBts4syBpQkDnpirm/9CWYUz+cTBpf+H5d3eTio/fcDYsAAv1hcSdrlFpSaKKK96BCEak0F3OaQAUz8F9I4S1uJU7Ai8GNRjpp1
    5cbV+FOzcjnmWl/+FMu02w==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=TYBLyS7eAAAA:8 a=DDOyTI_5AAAA:8 a=ag1SF4gXAAAA:8
    a=YtnSInc0arG0W8qGliQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=zvYvwCWiE4KgVXXeO06c:22 a=_BcfOz0m4U4ohdxiHPKc:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.14 102/183] x86/hyperv: Check for required priviliges in
 hyperv_init()
Date: Wed, 25 Apr 2018 12:35:22 +0200
Message-Id: <20180425103246.556675163@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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
Cc: Sasha Levin <alexander.levin@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, stable@vger.kernel.org,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Andy Lutomirski <luto@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mohammed Gamal <mmorsy@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

NC4xNC1zdGFibGUgcmV2aWV3IHBhdGNoLiAgSWYgYW55b25lIGhhcyBhbnkgb2JqZWN0aW9ucywg
cGxlYXNlIGxldCBtZSBrbm93LgoKLS0tLS0tLS0tLS0tLS0tLS0tCgpGcm9tOiBWaXRhbHkgS3V6
bmV0c292IDx2a3V6bmV0c0ByZWRoYXQuY29tPgoKClsgVXBzdHJlYW0gY29tbWl0IDg5YThmNmQ0
OTA0YzhjZjNmZjhmZWU5ZmRhZmYzOTJhNmJiYjhiZjYgXQoKSW4gaHlwZXJ2X2luaXQoKSBpdHMg
cHJlc3VtZWQgdGhhdCBpdCBhbHdheXMgaGFzIGFjY2VzcyB0byBWUCBpbmRleCBhbmQKaHlwZXJj
YWxsIE1TUnMgd2hpbGUgYWNjb3JkaW5nIHRvIHRoZSBzcGVjaWZpY2F0aW9uIGl0IHNob3VsZCBi
ZSBjaGVja2VkIGlmCml0J3MgYWxsb3dlZCB0byBhY2Nlc3MgdGhlIGNvcnJlc3BvbmRpbmcgTVNS
cyBiZWZvcmUgYWNjZXNzaW5nIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBWaXRhbHkgS3V6bmV0c292
IDx2a3V6bmV0c0ByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4KUmV2aWV3ZWQtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51
dHJvbml4LmRlPgpDYzogU3RlcGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1pY3Jvc29mdC5jb20+
CkNjOiBrdm1Admdlci5rZXJuZWwub3JnCkNjOiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJAcmVk
aGF0LmNvbT4KQ2M6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+CkNjOiAi
TWljaGFlbCBLZWxsZXkgKEVPU0cpIiA8TWljaGFlbC5ILktlbGxleUBtaWNyb3NvZnQuY29tPgpD
YzogUm9tYW4gS2FnYW4gPHJrYWdhbkB2aXJ0dW96em8uY29tPgpDYzogQW5keSBMdXRvbWlyc2tp
IDxsdXRvQGtlcm5lbC5vcmc+CkNjOiBkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnCkNjOiBQ
YW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpDYzogIksuIFkuIFNyaW5pdmFzYW4i
IDxreXNAbWljcm9zb2Z0LmNvbT4KQ2M6IENhdGh5IEF2ZXJ5IDxjYXZlcnlAcmVkaGF0LmNvbT4K
Q2M6IE1vaGFtbWVkIEdhbWFsIDxtbW9yc3lAcmVkaGF0LmNvbT4KTGluazogaHR0cHM6Ly9sa21s
Lmtlcm5lbC5vcmcvci8yMDE4MDEyNDEzMjMzNy4zMDEzOC0yLXZrdXpuZXRzQHJlZGhhdC5jb20K
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29t
PgpTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPgotLS0KIGFyY2gveDg2L2h5cGVydi9odl9pbml0LmMgfCAgICA5ICsrKysrKysrLQog
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0tIGEvYXJj
aC94ODYvaHlwZXJ2L2h2X2luaXQuYworKysgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jCkBA
IC0xMTAsMTIgKzExMCwxOSBAQCBzdGF0aWMgaW50IGh2X2NwdV9pbml0KHVuc2lnbmVkIGludCBj
cHUpCiAgKi8KIHZvaWQgaHlwZXJ2X2luaXQodm9pZCkKIHsKLQl1NjQgZ3Vlc3RfaWQ7CisJdTY0
IGd1ZXN0X2lkLCByZXF1aXJlZF9tc3JzOwogCXVuaW9uIGh2X3g2NF9tc3JfaHlwZXJjYWxsX2Nv
bnRlbnRzIGh5cGVyY2FsbF9tc3I7CiAKIAlpZiAoeDg2X2h5cGVyX3R5cGUgIT0gWDg2X0hZUEVS
X01TX0hZUEVSVikKIAkJcmV0dXJuOwogCisJLyogQWJzb2x1dGVseSByZXF1aXJlZCBNU1JzICov
CisJcmVxdWlyZWRfbXNycyA9IEhWX1g2NF9NU1JfSFlQRVJDQUxMX0FWQUlMQUJMRSB8CisJCUhW
X1g2NF9NU1JfVlBfSU5ERVhfQVZBSUxBQkxFOworCisJaWYgKChtc19oeXBlcnYuZmVhdHVyZXMg
JiByZXF1aXJlZF9tc3JzKSAhPSByZXF1aXJlZF9tc3JzKQorCQlyZXR1cm47CisKIAkvKiBBbGxv
Y2F0ZSBwZXJjcHUgVlAgaW5kZXggKi8KIAlodl92cF9pbmRleCA9IGttYWxsb2NfYXJyYXkobnVt
X3Bvc3NpYmxlX2NwdXMoKSwgc2l6ZW9mKCpodl92cF9pbmRleCksCiAJCQkJICAgIEdGUF9LRVJO
RUwpOwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRl
dmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnCmh0dHA6Ly9kcml2
ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaXZlcmRldi1k
ZXZlbAo=
