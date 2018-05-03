Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1876815-1525323190-2-4739918997266982069
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES svenda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525323189; b=HjRCLgNYZ8THR3o5KYRtLeI+YFD7R2MIAC66PHg0csV+uf+iut
    3y0LsevWZdRYipN5jJGGYe+7GzkcxdmpjLPN7eFT5V039IWJrZTztWgJSG8yHjsu
    koX0S4gB+UH6IpNLq2zjngCZyoRdwol3JxyIQWZt+sG3Lacnc7HgJTo8T6nJHzjA
    jqdBCQ5mgK8IwQC7E1+pjUoEVWhnFnQdKyxnXHW3O3ZTL1j876/IGUjrgFDBiNRk
    cNskbBHnfHhUpVuU9wzXLZdVqBVUHgxQqWqxXDwVQ9o5e7MTfRV7YJ5LkSw1VHlK
    mvC9Djo8Bbk4QVy2PZuxq+I3T5SNEyoD+LLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525323189; bh=Fb+/5
    7o2NlicMyCmCSzbgbx6gHw1B1SdhtQMYUguWBY=; b=lYGp3Eh2ImTfNgqxlFpC/
    zcD1qqGSBwWM9+OWkYccy5daBRmw3yYkN+je6oCirughRdeG3rW8nMyXOZJ3CRU2
    bgAlRhI+Ok30l03/t/1NwdfitPvsAGg+KKmpHPqVfGUHSvtSFmCCYcrc8Ei7kAbt
    CPVF6CX3WA/7RTN1ywh3BlVHKrnv09x0zhyOXLW+9PbHBq4a0FUomnedJsWzZzPB
    FnRiNzUS7gmUsA/bMsfp54oS+LMXavqohKbn8qFC5V9zJppYYqgHRNZDF8qejFTN
    hO+ML/r0BAUTaC13N7GV6LdV0Wd+r4jdn/2OvyrougSBPRnbzSVo79N5JLPXD7u8
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=TsYLjMfp x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=erNqLd8b;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=google.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=TsYLjMfp x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=erNqLd8b;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=google.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPY7EVyBgzA8who3pX2Gz2t/mAbJrPIYLvdSsw56bq+KxdbtsF80yB+wu98bAdwY+r/XugAQDkKbHftG2VHljjaMzRxsLmT2pJvhD+TGM3/Lkq6LnNhI
    LGpC8jAyGSh2xfY0mgk7DREChoYL62CP3E+2KtpHZidEIXjhyHBtk27vmZP74bVjT1gnxQuuvoARFZ8s/KIlua5NWa2/LAomU0EUj8WYA+c0WZLZbDmX5DqY
    5Q2U0DNCq5DXaUV7eszFtg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8
    a=n8i27M1mAAAA:8 a=1XWaLZrsAAAA:8 a=lTbjQzD5AAAA:8 a=DDOyTI_5AAAA:8
    a=uWkGACebqQqNKXD9YiMA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=w8YF5asEQ23juLwKoPR8:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqt+ezCZ6ZpXeKFVYbNmoYfNmYi2qab1w5vdXYcvj1GWmVMCUNG/JW9T2h66cEraROWUrhgVQ==
From: Alistair Strachan <astrachan@google.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: Android: vsoc: Fix a i386-randconfig warning.
Date: Wed,  2 May 2018 21:45:56 -0700
Message-Id: <20180503044556.157075-1-astrachan@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
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
Cc: devel@driverdev.osuosl.org, kernel-team@android.com,
 Todd Kjos <tkjos@android.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Greg Hartman <ghartman@google.com>, Alistair Strachan <astrachan@google.com>,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rml4ICJ3YXJuaW5nOiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVudCBz
aXplIiB3aGVuCnByaW50aW5nIHRoZSByZWdpb24gc2htIHBoeXNpY2FsIGFkZHJlc3MuIFVzZSB0
aGUgJXBhIGNvbnZlcnNpb24Kc3BlY2lmaWVyIGFuZCBwYXNzIHRoZSByZXNvdXJjZSBieSByZWZl
cmVuY2UuCgpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4KQ2M6IEFydmUgSGrDuG5uZXbDpWcgPGFydmVAYW5kcm9pZC5jb20+CkNjOiBUb2RkIEtqb3Mg
PHRram9zQGFuZHJvaWQuY29tPgpDYzogTWFydGlqbiBDb2VuZW4gPG1hY29AYW5kcm9pZC5jb20+
CkNjOiBHcmVnIEhhcnRtYW4gPGdoYXJ0bWFuQGdvb2dsZS5jb20+CkNjOiBkZXZlbEBkcml2ZXJk
ZXYub3N1b3NsLm9yZwpDYzoga2VybmVsLXRlYW1AYW5kcm9pZC5jb20KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgU3RyYWNoYW4gPGFzdHJhY2hhbkBnb29nbGUuY29tPgotLS0KIGRyaXZlcnMvc3Rh
Z2luZy9hbmRyb2lkL3Zzb2MuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvYW5kcm9p
ZC92c29jLmMgYi9kcml2ZXJzL3N0YWdpbmcvYW5kcm9pZC92c29jLmMKaW5kZXggNzk0MTM3Yjc3
NTFmLi4zZTZlNGFmN2Q2YTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL3Zz
b2MuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvYW5kcm9pZC92c29jLmMKQEAgLTgwMCw4ICs4MDAs
OCBAQCBzdGF0aWMgaW50IHZzb2NfcHJvYmVfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAog
CXZzb2NfZGV2LnNobV9waHlzX3N0YXJ0ID0gcGNpX3Jlc291cmNlX3N0YXJ0KHBkZXYsIFNIQVJF
RF9NRU1PUllfQkFSKTsKIAl2c29jX2Rldi5zaG1fc2l6ZSA9IHBjaV9yZXNvdXJjZV9sZW4ocGRl
diwgU0hBUkVEX01FTU9SWV9CQVIpOwogCi0JZGV2X2luZm8oJnBkZXYtPmRldiwgInNoYXJlZCBt
ZW1vcnkgQCBETUEgJXAgc2l6ZT0weCV6eFxuIiwKLQkJICh2b2lkICopdnNvY19kZXYuc2htX3Bo
eXNfc3RhcnQsIHZzb2NfZGV2LnNobV9zaXplKTsKKwlkZXZfaW5mbygmcGRldi0+ZGV2LCAic2hh
cmVkIG1lbW9yeSBAIERNQSAlcGEgc2l6ZT0weCV6eFxuIiwKKwkJICZ2c29jX2Rldi5zaG1fcGh5
c19zdGFydCwgdnNvY19kZXYuc2htX3NpemUpOwogCXZzb2NfZGV2Lmtlcm5lbF9tYXBwZWRfc2ht
ID0gcGNpX2lvbWFwX3djKHBkZXYsIFNIQVJFRF9NRU1PUllfQkFSLCAwKTsKIAlpZiAoIXZzb2Nf
ZGV2Lmtlcm5lbF9tYXBwZWRfc2htKSB7CiAJCWRldl9lcnIoJnZzb2NfZGV2LmRldi0+ZGV2LCAi
Y2Fubm90IGlvbWFwIHJlZ2lvblxuIik7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmRldmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2pl
Y3Qub3JnCmh0dHA6Ly9kcml2ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaXZlcmRldi1kZXZlbAo=
