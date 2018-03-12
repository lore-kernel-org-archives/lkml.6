Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1104384-1520883106-2-16514620296558219205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='ar', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520883106; b=rPyecZ0zi22t29zjdYkoUMrgqf9tnuwC9ajMHCvZ2zxGrVL
    hQlTcwglMv78xe6DkKNlPx2prCQbF2wXcUYfMhqgb8p9XMLH0Bdj5XQQFfsGkp2M
    Xi3pu0w2U+qBiI9hdRbz0XR2SSbWMlxAjK8opVEZnub1j4ngqVMQblqFRCsGHS1O
    KVowQbsVKDMs4O10DP9kajgNUEjCwOlbLKtkS8tBaOkCAWZF13nUuw0rELtsW1JT
    RqkyjG4m2kFAmIWqKYv3lUr8addY57HKJaYumHq/GBve7p90vu+P5hnQK1NucHYc
    sd25R5TwPFsnJHaxszUS8l83Wn4dcn0rYqM/dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:list-id:list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:content-type:content-transfer-encoding:sender;
    s=arctest; t=1520883106; bh=jHSQdbTC9vvv7r3lQkb3ayccLfU1R7YZEC0
    EQ89MvgQ=; b=uoHTcgKtleSzgw8AFT197xxT3wrzQSTIE4kdYfdTeMwteXVCToT
    Vv4GVY+cBXr/dPR2d1ZZ1U0Zl7JAcXM2HF2R9mKFvpMpFeS4zDVNua4fEr9OWDSP
    YSS1MZe3D5Cy1nKahUI5HNDOUeuUfRmbOA94UJslzxRrMmASU1AhkwgnfB+6DWf5
    A1WAK78fgFtxesbvotAkgJQeXk33mz5RxvvYFfMeD5SsdghnOMmNivI6R3ztPp85
    19wgeK+XcCSAeGbYGT4e0jCUCkDosNtG/y9wARZzIV3/Vji8/gFK2ksIw0lQ2oBj
    5cTCP8GHqABPA8qA1eJrrA2GksfZPsRneAg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b=WEiUoWuU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vanguardiasur.com.ar;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LoYA+urC;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=vanguardiasur.com.ar header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b=WEiUoWuU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vanguardiasur.com.ar;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LoYA+urC;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=vanguardiasur.com.ar header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELurAo8/sUhFC4tMUiMoINSUCysyuBZo5aQB96riDPxt6+mo5jFs6mQOItsskPcTg8Af3gOWh8D0fowiTsKEfhs=
MIME-Version: 1.0
From: =?UTF-8?Q?Hern=C3=A1n_Gonzalez?= <hernan@vanguardiasur.com.ar>
Date: Mon, 12 Mar 2018 16:25:52 -0300
Message-ID: <CALfa3vGh4Ni36+ptCdnd0+mxPWDs8OQKe7-egpttgYBpuDTeqA@mail.gmail.com>
Subject: Plan to move cdc:ad7746 driver out of staging
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGksCgpUaGlzIGlzIG15IHBsYW4gZm9yIG1vdmluZyBvdXQgdGhlIGFkNzc0NiBkcml2ZXIgb3V0
IG9mIHN0YWdpbmcuIEkKaGF2ZSBzb21lIHNwZWNpZmljIHF1ZXN0aW9ucyB0aGF0IHdvdWxkIGJl
IHJlYWxseSBoZWxwZnVsIGlmIHNvbWVvbmUKY2FuIHBvaW50IG1lIGluIHRoZSByaWdodCBkaXJl
Y3Rpb24gdG8gZ28uCgoxLiBQaWNrIHVwIG9uIERhdmlkJ3MgY2xlYW4tdXAgcGF0Y2guIEZpbmlz
aCBjbGVhbmluZyBDSEVDS3MgZnJvbQpjaGVja3BhdGNoLnBsIGlmIHBvc3NpYmxlLgoKMi4gUmVv
cmRlciBpbmNsdWRlcyBhbHBoYWJldGljYWxseS4KCjMuIFJlb3JkZXIgc29tZSB2YXJpYWJsZSBk
ZWNsYXJhdGlvbnMgaW4gYW4gaW52ZXJzZS1weXJhbWlkIHNjaGVtZS4KCjQuIEZpeCBzeXNmcyBh
dHRycyBuYW1pbmcgdG8gY29tcGx5IHdpdGggdGhlIEFCSSwgZS5nLjoKaW5fY2FwYWNpdGFuY2Uw
X2NhbGliYmlhc19jYWxpYnJhdGlvbiAtPiBpbl9jYXBhY2l0YW5jZTBfY2FsaWJiaWFzCgo1LiBB
ZGQgZG9jdW1lbnRhdGlvbiB0byB0aGUge2NhcCx2dH1fZmlsdGVyX3JhdGUgdGFibGVzIGFuZCB0
byB0aGUKcHJvY2Vzc2VkIGluZm8gcmVhZC4gVGhlcmUgYXJlIHNvbWUgbWFnaWMgbnVtYmVycyBv
dXQgdGhlcmUsIEkgd2lsbApyZWFkIHRoZSBkYXRhc2hlZXQgYW5kIGV4cGxhaW4gdGhlIG1hdGgg
dGhhdCBJIGNvbnNpZGVyIGFwcHJvcGlhdGUuCgo2LiBUaGVyZSBhcmUgYSBmZXcgdG9vIG1hbnkg
ZGVmaW5lcyB0aGF0IGFyZSBub3QgdXNlZCBhdCBhbGwgYnV0IHRoZXkKZG8gZm9sbG93IHRoZSBk
YXRhc2hlZXQuIEkgZG9uJ3Qga25vdyBpZiB0aGVyZSBhcmUgcGxhbnMgdG8ga2VlcAphZGRpbmcg
ZnVuY3Rpb25hbGl0aWVzIHRvIHRoaXMgZHJpdmVyIG9yIGlmIEkgc2hvdWxkIGp1c3QgcmVtb3Zl
IHRoZW0uCgo4LiBFWENMVkwgaXMgZHVwbGljYXRlZC4gVGhlcmUncyBhIHNpbXBsZSBtYWNybyBp
biBhZDc3NDYuYyBhbmQgc29tZQpkZWZpbmVzIGluIGFkNzc0Ni5oLiBUaGUgbGF0dGVyIGFyZSBu
b3QgdXNlZCBhbnl3aGVyZSBpbiB0aGUgY29kZS4KUmVtb3ZlIHRoZW0uCgo3LiBNb3ZlIHRoZSBz
dHJ1Y3QgYWQ3NzQ2X3BsYXRmb3JtX2RhdGEgdG8gaW5jbHVkZS9saW51eC9paW8uCgpBcyBtZW50
aW9uZWQgaW4gZWFybGllciBtYWlscywgSSB3aWxsIGF2b2lkIGFkZGluZyBuZXcgZmVhdHVyZXMg
YXMgSQpoYXZlIG5vIGFjY2VzcyB0byB0aGUgaGFyZHdhcmUgYW5kLCB0aGVyZWZvcmUsIGNvdWxk
IG5vdCB0ZXN0IGl0LgoKSSBndWVzcyB0aGF0J2QgYmUgYWxsLiBJZiBJJ20gbWlzc2luZyBzb21l
dGhpbmcgSSB3b3VsZCBiZSByZWFsbHkKZ3JhdGVmdWwgaWYgeW91IGNhbiBsZXQgbWUga25vdyBv
ciBnaXZlIG1lIHNvbWUgcG9pbnRlcnMgd2hlcmUgdG8gbG9vawphdC4KCkNoZWVycywKCkhlcm7D
oW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwg
bWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRl
di5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVs
Cg==
