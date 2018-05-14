Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526295736-2-14460211968101175128
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES dasven,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526295736; b=GIhRJk0fNXWtaSdoaMDwQ2KvTQWEMx7YFJ/uOqQqD0dEcmMKf/
    mvbmaeYi+Au2rjulPBnzDnT087WW7H19KT0xYkGG1fw4jY7j1o+pi/CgJAXwzczP
    z+E0X6cMcSoqIub1q6QybC4hwbqg4WwJNwvp/KNbaW0xW58KNTF4SrNdffaFdT4n
    MKLISbGF8LkTGQ4o/bVxjB8QU5SMmPbfaPP6q++1ykJ/M5gM0I5TRUUEMmSoM2cX
    tZoXQq/ehb50ULhRRr5W888hGoe0LH2jj8SVCXI2Sp2DYQM4UawgfMA1u3IP54OS
    qm/aH9Y9xIQUoAhFy7ArNIjn/qbaE5f3tkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526295736; bh=9AONj
    l4Te92XVJ69HF0AR3i4+pl21J9XmkaMhiPn/VM=; b=TjeSSk7fEiAzA6RNmBfrj
    aTQD7WNnYKXraIKaDdDjxovl9g9twk6iIx/hClI3qXOi2fa0ES2DccmOGIjEJlu7
    PTt4vo6hhdiyVBqH8ZZJqt1ADQf9tG3+ZtxT84SiS/SHStQaB2qVdP4i74mWh4Kb
    7xfF+JEkqQTtxQpBDnsLIhez1rO5UuQ7oiUN0+A6UcgpTTeGuQk/tlC7L+9lJiZc
    14AS/8YUs56Yh+9Yfl809m5K5cV6lirChlR1KQiTp/B6DLQxE0SGdQ+Jn+KGqEpj
    GsBfSPCTizANyxwRpI4f5VCx9CuwYZ0dWdO+BI5VZlaC0rjBu9jQuKODB2IuqUaH
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=qBwWRp4K x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=qBwWRp4K x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHB7aw0HYnLWn3kuwKz1jhAMMe5LjNmUKxgvsFfmH8IMyAGcSzjQdFttZSgx2xMlNw1egARpDrmj2j/DCs9neinWm/ajd4AlDYbN36S63gSYfjKBr5YB
    uaLX+hz3vrT7T9qojoPy7aZXZspe0wdMXo7Is+io8wpYzC7xtXcvY3oocNtTdIsCNp8S408zpT2bQwc/q4iq5H54zKkXD9ATOLiw097wiqjtkdzRSibzN90m
    feUKE4eJihgVsHdn61MRNA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=KKAkSRfTAAAA:8 a=DDOyTI_5AAAA:8
    a=SKMpXopfqbPt5I2EzdIA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 13:01:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] staging: video: fix warning unused variable
Message-ID: <20180514110152.GA25303@kroah.com>
References: <20180514105442.10179-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514105442.10179-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCBNYXkgMTQsIDIwMTggYXQgMTI6NTQ6NDJQTSArMDIwMCwgQW5kZXJzIFJveGVsbCB3
cm90ZToKPiBXaGVuIGJ1aWxkaW5nIHZpZGVvIHdhcm5pbmdzIHBvcHMgdXAgdW51c2VkIHZhcmlh
YmxlICdtZGV2JywKPiBkcml2ZXJzL3N0YWdpbmcvbW9zdC92aWRlby92aWRlby5jOiBJbiBmdW5j
dGlvbiDigJh2aWRpb2NfZW51bV9mbXRfdmlkX2NhcOKAmToKPiBkcml2ZXJzL3N0YWdpbmcvbW9z
dC92aWRlby92aWRlby5jOjI2NToyNTogd2FybmluZzogdW51c2VkIHZhcmlhYmxlIOKAmG1kZXbi
gJkgWy1XdW51c2VkLXZhcmlhYmxlXQo+ICAgc3RydWN0IG1vc3RfdmlkZW9fZGV2ICptZGV2ID0g
ZmgtPm1kZXY7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn4KPiBkcml2ZXJzL3N0YWdp
bmcvbW9zdC92aWRlby92aWRlby5jOiBJbiBmdW5jdGlvbiDigJh2aWRpb2NfZ19mbXRfdmlkX2Nh
cOKAmToKPiBkcml2ZXJzL3N0YWdpbmcvbW9zdC92aWRlby92aWRlby5jOjI4MjoyNTogd2Fybmlu
ZzogdW51c2VkIHZhcmlhYmxlIOKAmG1kZXbigJkgWy1XdW51c2VkLXZhcmlhYmxlXQo+ICAgc3Ry
dWN0IG1vc3RfdmlkZW9fZGV2ICptZGV2ID0gZmgtPm1kZXY7Cj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn4KPiBkcml2ZXJzL3N0YWdpbmcvbW9zdC92aWRlby92aWRlby5jOiBJbiBmdW5j
dGlvbiDigJh2aWRpb2NfZ19zdGTigJk6Cj4gZHJpdmVycy9zdGFnaW5nL21vc3QvdmlkZW8vdmlk
ZW8uYzozMDk6MjU6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhtZGV24oCZIFstV3VudXNl
ZC12YXJpYWJsZV0KPiAgIHN0cnVjdCBtb3N0X3ZpZGVvX2RldiAqbWRldiA9IGZoLT5tZGV2Owo+
ICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+Cj4gCj4gUmVtb3ZlIHRoZSAnbWRldicgZGVj
bGFyYXRpb24uCj4gCj4gRml4ZXM6IDdkN2NkYjRmYTU1MiAoInN0YWdpbmc6IG1vc3Q6IHZpZGVv
OiByZW1vdmUgZGVidWdnaW5nIGNvZGUiKQo+IFNpZ25lZC1vZmYtYnk6IEFuZGVycyBSb3hlbGwg
PGFuZGVycy5yb3hlbGxAbGluYXJvLm9yZz4KPiAtLS0KPiAgZHJpdmVycy9zdGFnaW5nL21vc3Qv
dmlkZW8vdmlkZW8uYyB8IDkgLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGRlbGV0aW9u
cygtKQoKSSBwb3N0ZWQgdGhlIHNhbWUgZXhhY3QgZml4IGFib3V0IGFuIGhvdXIgYWdvLCBzb3Jy
eS4KCmdyZWcgay1oCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRldmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnCmh0dHA6
Ly9kcml2ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaXZl
cmRldi1kZXZlbAo=
