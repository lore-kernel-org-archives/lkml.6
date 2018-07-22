Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0960BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A8A2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 08:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A8A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pku.edu.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeGVJLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 05:11:10 -0400
Received: from mx20.pku.edu.cn ([162.105.129.183]:43645 "EHLO pku.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727986AbeGVJLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 05:11:10 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jul 2018 05:11:09 EDT
Received: by ajax-webmail-mailfront02 (Coremail) ; Sun, 22 Jul 2018 16:04:57
 +0800 (GMT+08:00)
X-Originating-IP: [61.148.244.78]
Date:   Sun, 22 Jul 2018 16:04:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Guan Xuetao" <gxt@pku.edu.cn>
To:     "Mike Rapoport" <rppt@linux.vnet.ibm.com>
Cc:     "Michal Hocko" <mhocko@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicore32: switch to NO_BOOTMEM
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.7b build 20180509(9e2321e9)
 Copyright (c) 2002-2018 www.mailtech.cn pku
In-Reply-To: <1531728024-13259-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1531728024-13259-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <76e49e5d.3370.164c1052665.Coremail.gxt@pku.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 8oFpogA3GQWpOlRbbr8hAA--.760W
X-CM-SenderInfo: qqqqliixuslio6sn3hxhgxhubq/1tbiAQENB1Py8BjBlwABsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlcy0tLS0tCj4gRnJvbTogIk1pa2UgUmFwb3BvcnQiIDxy
cHB0QGxpbnV4LnZuZXQuaWJtLmNvbT4KPiBTZW50IFRpbWU6IDIwMTgtMDctMTYgMTY6MDA6MjQg
KE1vbmRheSkKPiBUbzogIkd1YW4gWHVldGFvIiA8Z3h0QHBrdS5lZHUuY24+Cj4gQ2M6ICJNaWNo
YWwgSG9ja28iIDxtaG9ja29Aa2VybmVsLm9yZz4sICJBcm5kIEJlcmdtYW5uIiA8YXJuZEBhcm5k
Yi5kZT4sIGxpbnV4LW1tQGt2YWNrLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywg
Ik1pa2UgUmFwb3BvcnQiIDxycHB0QGxpbnV4LnZuZXQuaWJtLmNvbT4KPiBTdWJqZWN0OiBbUEFU
Q0hdIHVuaWNvcmUzMjogc3dpdGNoIHRvIE5PX0JPT1RNRU0KPiAKPiBUaGUgdW5pY29yZTMyIGFs
cmVhZHkgc3VwcG9ydHMgbWVtYmxvY2sgYW5kIHVzZXMgaXQgZm9yIHNvbWUgZWFybHkgbWVtb3J5
Cj4gcmVzZXJ2YXRpb25zLCBlLmcgaW5pdHJkIGFuZCB0aGUgcGFnZSB0YWJsZXMuCj4gCj4gQXQg
c29tZSBwb2ludCB1bmljb3JlMzIgYWxsb2NhdGVzIHRoZSBib290bWVtIGJpdG1hcCBmcm9tIHRo
ZSBtZW1ibG9jayBhbmQKPiB0aGVuIGhhbmRzIG92ZXIgdGhlIG1lbW9yeSByZXNlcnZhdGlvbnMg
ZnJvbSBtZW1ibG9jayB0byBib290bWVtLgo+IAo+IFRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUgYm9v
dG1lbSBpbml0aWFsaXphdGlvbiBhbmQgbGVhdmVzIG1lbWJsb2NrIGFzIHRoZQo+IG9ubHkgYm9v
dCB0aW1lIG1lbW9yeSBtYW5hZ2VyIGZvciB1bmljb3JlMzIuCj4gCj4gU2lnbmVkLW9mZi1ieTog
TWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC52bmV0LmlibS5jb20+CgoKU2VlbXMgb2sgdG8gdW5p
Y29yZTMyLiBUaGFua3MuCkFja2VkLWJ5OiBHdWFuIFh1ZXRhbyA8Z3h0QHBrdS5lZHUuY24+Cgo+
IC0tLQo+IAo+IEkgY291bGRuJ3QgZ2V0IHVuaWNvcmUzMiB0b29sY2hhaW4gYXMgdGhlIG9ubHkg
bGluayBJIHdhcyBhYmxlIHRvIGZpbmQgWzFdCj4gZ2l2ZXMgbWUgdGltZW91dCwgc28gdGhlIGJl
c3QgSSBjb3VsZCBkbyB0byBjaGVjayB0aGUgY2hhbmdlcyB3YXMKPiAKPiAJZ2NjIDxsb3RzIG9m
IGZsYWdzPiAtYyBhcmNoL3VuaWNvcmUzMi9tbS9pbml0LmMKPiAKPiBbMV0gaHR0cDovL21wcmMu
cGt1LmVkdS5jbi9+Z3Vhbnh1ZXRhby9saW51eC91YzQtMS4wLjUtaGFyZC50Z3oKPiAKPiAgYXJj
aC91bmljb3JlMzIvS2NvbmZpZyAgIHwgIDEgKwo+ICBhcmNoL3VuaWNvcmUzMi9tbS9pbml0LmMg
fCA1NCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDUzIGRlbGV0aW9ucygtKQo+IAo+IGRp
ZmYgLS1naXQgYS9hcmNoL3VuaWNvcmUzMi9LY29uZmlnIGIvYXJjaC91bmljb3JlMzIvS2NvbmZp
Zwo+IGluZGV4IDAzZjk5MWUuLmNmZjRiOWQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC91bmljb3JlMzIv
S2NvbmZpZwo+ICsrKyBiL2FyY2gvdW5pY29yZTMyL0tjb25maWcKPiBAQCAtNSw2ICs1LDcgQEAg
Y29uZmlnIFVOSUNPUkUzMgo+ICAJc2VsZWN0IEFSQ0hfTUlHSFRfSEFWRV9QQ19QQVJQT1JUCj4g
IAlzZWxlY3QgQVJDSF9NSUdIVF9IQVZFX1BDX1NFUklPCj4gIAlzZWxlY3QgSEFWRV9NRU1CTE9D
Swo+ICsJc2VsZWN0IE5PX0JPT1RNRU0KPiAgCXNlbGVjdCBIQVZFX0dFTkVSSUNfRE1BX0NPSEVS
RU5UCj4gIAlzZWxlY3QgSEFWRV9LRVJORUxfR1pJUAo+ICAJc2VsZWN0IEhBVkVfS0VSTkVMX0Ja
SVAyCj4gZGlmZiAtLWdpdCBhL2FyY2gvdW5pY29yZTMyL21tL2luaXQuYyBiL2FyY2gvdW5pY29y
ZTMyL21tL2luaXQuYwo+IGluZGV4IGY0OTUwZmIuLjQ0Y2NjMTUgMTAwNjQ0Cj4gLS0tIGEvYXJj
aC91bmljb3JlMzIvbW0vaW5pdC5jCj4gKysrIGIvYXJjaC91bmljb3JlMzIvbW0vaW5pdC5jCj4g
QEAgLTg0LDU4ICs4NCw2IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBmaW5kX2xpbWl0cyh1bnNpZ25l
ZCBsb25nICptaW4sIHVuc2lnbmVkIGxvbmcgKm1heF9sb3csCj4gIAl9Cj4gIH0KPiAgCj4gLXN0
YXRpYyB2b2lkIF9faW5pdCB1YzMyX2Jvb3RtZW1faW5pdCh1bnNpZ25lZCBsb25nIHN0YXJ0X3Bm
biwKPiAtCXVuc2lnbmVkIGxvbmcgZW5kX3BmbikKPiAtewo+IC0Jc3RydWN0IG1lbWJsb2NrX3Jl
Z2lvbiAqcmVnOwo+IC0JdW5zaWduZWQgaW50IGJvb3RfcGFnZXM7Cj4gLQlwaHlzX2FkZHJfdCBi
aXRtYXA7Cj4gLQlwZ19kYXRhX3QgKnBnZGF0Owo+IC0KPiAtCS8qCj4gLQkgKiBBbGxvY2F0ZSB0
aGUgYm9vdG1lbSBiaXRtYXAgcGFnZS4gIFRoaXMgbXVzdCBiZSBpbiBhIHJlZ2lvbgo+IC0JICog
b2YgbWVtb3J5IHdoaWNoIGhhcyBhbHJlYWR5IGJlZW4gbWFwcGVkLgo+IC0JICovCj4gLQlib290
X3BhZ2VzID0gYm9vdG1lbV9ib290bWFwX3BhZ2VzKGVuZF9wZm4gLSBzdGFydF9wZm4pOwo+IC0J
Yml0bWFwID0gbWVtYmxvY2tfYWxsb2NfYmFzZShib290X3BhZ2VzIDw8IFBBR0VfU0hJRlQsIEwx
X0NBQ0hFX0JZVEVTLAo+IC0JCQkJX19wZm5fdG9fcGh5cyhlbmRfcGZuKSk7Cj4gLQo+IC0JLyoK
PiAtCSAqIEluaXRpYWxpc2UgdGhlIGJvb3RtZW0gYWxsb2NhdG9yLCBoYW5kaW5nIHRoZQo+IC0J
ICogbWVtb3J5IGJhbmtzIG92ZXIgdG8gYm9vdG1lbS4KPiAtCSAqLwo+IC0Jbm9kZV9zZXRfb25s
aW5lKDApOwo+IC0JcGdkYXQgPSBOT0RFX0RBVEEoMCk7Cj4gLQlpbml0X2Jvb3RtZW1fbm9kZShw
Z2RhdCwgX19waHlzX3RvX3BmbihiaXRtYXApLCBzdGFydF9wZm4sIGVuZF9wZm4pOwo+IC0KPiAt
CS8qIEZyZWUgdGhlIGxvd21lbSByZWdpb25zIGZyb20gbWVtYmxvY2sgaW50byBib290bWVtLiAq
Lwo+IC0JZm9yX2VhY2hfbWVtYmxvY2sobWVtb3J5LCByZWcpIHsKPiAtCQl1bnNpZ25lZCBsb25n
IHN0YXJ0ID0gbWVtYmxvY2tfcmVnaW9uX21lbW9yeV9iYXNlX3BmbihyZWcpOwo+IC0JCXVuc2ln
bmVkIGxvbmcgZW5kID0gbWVtYmxvY2tfcmVnaW9uX21lbW9yeV9lbmRfcGZuKHJlZyk7Cj4gLQo+
IC0JCWlmIChlbmQgPj0gZW5kX3BmbikKPiAtCQkJZW5kID0gZW5kX3BmbjsKPiAtCQlpZiAoc3Rh
cnQgPj0gZW5kKQo+IC0JCQlicmVhazsKPiAtCj4gLQkJZnJlZV9ib290bWVtKF9fcGZuX3RvX3Bo
eXMoc3RhcnQpLCAoZW5kIC0gc3RhcnQpIDw8IFBBR0VfU0hJRlQpOwo+IC0JfQo+IC0KPiAtCS8q
IFJlc2VydmUgdGhlIGxvd21lbSBtZW1ibG9jayByZXNlcnZlZCByZWdpb25zIGluIGJvb3RtZW0u
ICovCj4gLQlmb3JfZWFjaF9tZW1ibG9jayhyZXNlcnZlZCwgcmVnKSB7Cj4gLQkJdW5zaWduZWQg
bG9uZyBzdGFydCA9IG1lbWJsb2NrX3JlZ2lvbl9yZXNlcnZlZF9iYXNlX3BmbihyZWcpOwo+IC0J
CXVuc2lnbmVkIGxvbmcgZW5kID0gbWVtYmxvY2tfcmVnaW9uX3Jlc2VydmVkX2VuZF9wZm4ocmVn
KTsKPiAtCj4gLQkJaWYgKGVuZCA+PSBlbmRfcGZuKQo+IC0JCQllbmQgPSBlbmRfcGZuOwo+IC0J
CWlmIChzdGFydCA+PSBlbmQpCj4gLQkJCWJyZWFrOwo+IC0KPiAtCQlyZXNlcnZlX2Jvb3RtZW0o
X19wZm5fdG9fcGh5cyhzdGFydCksCj4gLQkJCShlbmQgLSBzdGFydCkgPDwgUEFHRV9TSElGVCwg
Qk9PVE1FTV9ERUZBVUxUKTsKPiAtCX0KPiAtfQo+IC0KPiAgc3RhdGljIHZvaWQgX19pbml0IHVj
MzJfYm9vdG1lbV9mcmVlKHVuc2lnbmVkIGxvbmcgbWluLCB1bnNpZ25lZCBsb25nIG1heF9sb3cs
Cj4gIAl1bnNpZ25lZCBsb25nIG1heF9oaWdoKQo+ICB7Cj4gQEAgLTIzMiw3ICsxODAsNyBAQCB2
b2lkIF9faW5pdCBib290bWVtX2luaXQodm9pZCkKPiAgCj4gIAlmaW5kX2xpbWl0cygmbWluLCAm
bWF4X2xvdywgJm1heF9oaWdoKTsKPiAgCj4gLQl1YzMyX2Jvb3RtZW1faW5pdChtaW4sIG1heF9s
b3cpOwo+ICsJbm9kZV9zZXRfb25saW5lKDApOwo+ICAKPiAgI2lmZGVmIENPTkZJR19TV0lPVExC
Cj4gIAlzd2lvdGxiX2luaXQoMSk7Cj4gLS0gCj4gMi43LjQK
