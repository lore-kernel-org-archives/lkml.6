Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-587712-1517524455-2-13105398217139730039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517524454; b=WclE/p4Kjot6uLl0nKoQ0HVip/bAFdO9HzRstnP3E8igesz
    //uXwbewB1VPrAnS4v0sRL0RPgQt3NDROQIuSdj2OLqW7cCC1zvB5Q0ov7veSb0n
    dwZNA5MMj4AXWIahZEX5A1EsMGiOt1JGhj2HKuCo7Xoo5aNWa1LDqSvhfmtx9Ko9
    adh/NPdhO5GhlrKiTtEsywoZddlFDtIdjYLfXgcHVPCSrpzrbhfNTPlCJ4pRSwdx
    40uY/5tEYJiYMFMbBKmYxb6fWZTiOXDV5/lcd+OMjW/UT8JCk7wAhovBLOCLJyze
    41XV2FQbeSeHc+Rt6AYK/rkpEeH9oIDyDP21FGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1517524454; bh=7+msYk3ggahunkkrmhGxsJqYkKsM5Vqo55cVk7xkbYo=; b=I
    f2D809DNjVfMMpXy854ZsY2+7ztr26iRXBskCQCK5kau24IGeaLrbt6ROVBz04td
    queJiY8CVOmYhAmZc9S2xVqL2zYxOtY6zQ/sTzvWtMGODPQ4l26UNkYR3pGMWvBN
    1uhf4W70R/sKjBi4uLeLB2mlPl9PtLpher1aNmlgkYLnLriqNyz92K20ccwnys8n
    ya6udcQJD//7QGxQO9HJs+I/aJGoGutBz1eOnHaHvbSgX1tDitd8vdmWzjK5WFDD
    +8Zsa9dQFZUKOWcivWvQIF8r+307P2SYMIf75QPq8sH64LazZyRogIaS7D4ocJgO
    WxEnTZOfC1Xu8tRY76A1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Message-ID: <1517524441.7076.2.camel@redhat.com>
Subject: Re: [RFC PATCH 1/2] hv_netvsc: Split netvsc_revoke_buf() and
 netvsc_teardown_gpadl()
From: Mohammed Gamal <mgamal@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 01 Feb 2018 23:34:01 +0100
In-Reply-To: <1517474239.30443.2.camel@redhat.com>
References: <1516700045-32142-1-git-send-email-mgamal@redhat.com>
 <1516700045-32142-2-git-send-email-mgamal@redhat.com>
 <20180130112926.53f3c166@xeon-e3> <1517397409.3452.7.camel@redhat.com>
 <20180131150137.58abee5b@xeon-e3> <1517474239.30443.2.camel@redhat.com>
Organization: Red Hat
Mime-Version: 1.0
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
Reply-To: mgamal@redhat.com
Cc: otubo@redhat.com, sthemmin@microsoft.com, netdev@vger.kernel.org,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, vkuznets@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAyLTAxIGF0IDA5OjM3ICswMTAwLCBNb2hhbW1lZCBHYW1hbCB3cm90ZToK
PiBPbiBXZWQsIDIwMTgtMDEtMzEgYXQgMTU6MDEgLTA4MDAsIFN0ZXBoZW4gSGVtbWluZ2VyIHdy
b3RlOgo+ID4gT24gV2VkLCAzMSBKYW4gMjAxOCAxMjoxNjo0OSArMDEwMAo+ID4gTW9oYW1tZWQg
R2FtYWwgPG1nYW1hbEByZWRoYXQuY29tPiB3cm90ZToKPiA+IAo+ID4gPiBPbiBUdWUsIDIwMTgt
MDEtMzAgYXQgMTE6MjkgLTA4MDAsIFN0ZXBoZW4gSGVtbWluZ2VyIHdyb3RlOgo+ID4gPiA+IE9u
IFR1ZSwgMjMgSmFuIDIwMTggMTA6MzQ6MDQgKzAxMDAKPiA+ID4gPiBNb2hhbW1lZCBHYW1hbCA8
bWdhbWFsQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IMKgwqAKPiA+ID4gPiA+IFNwbGl0IGVh
Y2ggb2YgdGhlIGZ1bmN0aW9ucyBpbnRvIHR3byBmb3IgZWFjaCBvZiBzZW5kL3JlY3YKPiA+ID4g
PiA+IGJ1ZmZlcnMKPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTW9oYW1tZWQg
R2FtYWwgPG1nYW1hbEByZWRoYXQuY29tPsKgwqAKPiA+ID4gPiAKPiA+ID4gPiBTcGxpdHRpbmcg
dGhlc2UgZnVuY3Rpb25zIGlzIG5vdCBuZWNlc3NhcnnCoMKgCj4gPiA+IAo+ID4gPiBIb3cgc28/
IFdlIG5lZWQgdG8gc2VuZCBlYWNoIG1lc3NhZ2UgaW5kZXBlbmRlbnRseSwgYW5kIGhlbmNlIHRo
ZQo+ID4gPiBzcGxpdAo+ID4gPiAoc2VlIGNvdmVyIGxldHRlcikuIElzIHRoZXJlIGFub3RoZXIg
d2F5Pwo+ID4gCj4gPiBUaGlzIGlzIGFsbCB0aGF0IGlzIG5lZWRlZC4KPiA+IAo+ID4gCj4gPiBT
dWJqZWN0OiBbUEFUQ0hdIGh2X25ldHZzYzogd29yayBhcm91bmQgZm9yIGdwYWRsIHRlYXJkb3du
IG9uIG9sZGVyCj4gPiB3aW5kb3dzCj4gPiDCoHNlcnZlcgo+ID4gCj4gPiBPbiBXUzIwMTIgdGhl
IGhvc3QgaWdub3JlcyBtZXNzYWdlcyBhZnRlciB2bWJ1cyBjaGFubmVsIGlzIGNsb3NlZC4KPiA+
IFdvcmthcm91bmQgdGhpcyBieSBkb2luZyB3aGF0IFdpbmRvd3MgZG9lcyBhbmQgc2VuZCB0aGUg
dGVhcmRvd24KPiA+IGJlZm9yZSBjbG9zZSBvbiBvbGRlciB2ZXJzaW9ucyBvZiBOVlNQIHByb3Rv
Y29sLgo+ID4gCj4gPiBSZXBvcnRlZC1ieTogTW9oYW1tZWQgR2FtYWwgPG1nYW1hbEByZWRoYXQu
Y29tPgo+ID4gRml4ZXM6IDBjZjczNzgwOGFlNyAoImh2X25ldHZzYzogbmV0dnNjX3RlYXJkb3du
X2dwYWRsKCkgc3BsaXQiKQo+ID4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0
aGVtbWluQG1pY3Jvc29mdC5jb20+Cj4gPiAtLS0KPiA+IMKgZHJpdmVycy9uZXQvaHlwZXJ2L25l
dHZzYy5jIHwgOSArKysrKysrKy0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvaHlwZXJ2
L25ldHZzYy5jCj4gPiBiL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYwo+ID4gaW5kZXggMTdl
NTI5YWY3OWRjLi4xYTNkZjBlZmY0MmYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9oeXBl
cnYvbmV0dnNjLmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYwo+ID4gQEAg
LTU3NCwxMCArNTc0LDE3IEBAIHZvaWQgbmV0dnNjX2RldmljZV9yZW1vdmUoc3RydWN0IGh2X2Rl
dmljZQo+ID4gKmRldmljZSkKPiA+IMKgCcKgKi8KPiA+IMKgCW5ldGRldl9kYmcobmRldiwgIm5l
dCBkZXZpY2Ugc2FmZSB0byByZW1vdmVcbiIpOwo+ID4gwqAKPiA+ICsJLyogV29ya2Fyb3VuZCBm
b3Igb2xkZXIgdmVyc2lvbnMgb2YgV2luZG93cyByZXF1aXJlIHRoYXQKPiA+ICsJwqAqIGJ1ZmZl
ciBiZSByZXZva2VkIGJlZm9yZSBjaGFubmVsIGlzIGRpc2FibGVkCj4gPiArCcKgKi8KPiA+ICsJ
aWYgKG5ldF9kZXZpY2UtPm52c3BfdmVyc2lvbiA8IE5WU1BfUFJPVE9DT0xfVkVSU0lPTl80KQo+
ID4gKwkJbmV0dnNjX3RlYXJkb3duX2dwYWRsKGRldmljZSwgbmV0X2RldmljZSk7Cj4gPiArCj4g
PiDCoAkvKiBOb3csIHdlIGNhbiBjbG9zZSB0aGUgY2hhbm5lbCBzYWZlbHkgKi8KPiA+IMKgCXZt
YnVzX2Nsb3NlKGRldmljZS0+Y2hhbm5lbCk7Cj4gPiDCoAo+ID4gLQluZXR2c2NfdGVhcmRvd25f
Z3BhZGwoZGV2aWNlLCBuZXRfZGV2aWNlKTsKPiA+ICsJaWYgKG5ldF9kZXZpY2UtPm52c3BfdmVy
c2lvbiA+PSBOVlNQX1BST1RPQ09MX1ZFUlNJT05fNCkKPiA+ICsJCW5ldHZzY190ZWFyZG93bl9n
cGFkbChkZXZpY2UsIG5ldF9kZXZpY2UpOwo+ID4gwqAKPiA+IMKgCS8qIEFuZCBkaXNzYXNzb2Np
YXRlIE5BUEkgY29udGV4dCBmcm9tIGRldmljZSAqLwo+ID4gwqAJZm9yIChpID0gMDsgaSA8IG5l
dF9kZXZpY2UtPm51bV9jaG47IGkrKykKPiAKPiBJJ3ZlIHRyaWVkIGEgc2ltaWxhciB3b3JrYXJv
dW5kIGJlZm9yZSBieSBjYWxsaW5nCj4gbmV0dnNjX3RlYXJkb3duX2dwYWRsKCkgYWZ0ZXIgbmV0
dnNjX3Jldm9rZV9idWYoKSwgYnV0IGJlZm9yZSBzZXR0aW5nCj4gbmV0X2RldmljZV9jdHgtPm52
ZGV2IHRvIE5VTEwgYW5kIGl0IGNhdXNlZCB0aGUgZ3Vlc3QgdG8gaGFuZyB3aGVuCj4gdHJ5aW5n
IHRvIGNoYW5nZSBNVFUuwqAKPiAKPiBMZXQgbWUgdHJ5IHRoYXQgY2hhbmdlIGFuZCBzZWUgaWYg
aXQgYmVoYXZlcyBkaWZmZXJlbnRseS4KCkkgdGVzdGVkIHRoZSBwYXRjaCwgYnV0IEkndmUgYWN0
dWFsbHkgc2VlbiBzb21lIHVuZXhwZWN0ZWQgYmVoYXZpb3IuCgpGaXJzdCwgbmV0X2RldmljZS0+
bnZzcF92ZXJzaW9uIGlzIGFjdHVhbGx5IE5WU1BfUFJPVE9DT0xfVkVSU0lPTl81IG9uCmJvdGgg
bXkgV2luMjAxMiBhbmQgV2luMjAxNiBob3N0cyB0aGF0IEkgdGVzdGVkIG9uLCBzbyB0aGUgY29u
ZGl0aW9uIGlzCm5ldmVyIGV4ZWN1dGVkLgoKU2Vjb25kLCB3aGVuIGRvaW5nIHRoZSBjaGVjayBp
bnN0ZWFkIGFzICBpZiAodm1idXNfcHJvdG9fdmVyc2lvbiA8ClZFUlNJT05fV0lOMTApLCBJIGdl
dCB0aGUgc2FtZSBiZWhhdmlvciBJIGRlc2NyaWJlZCBhYm92ZSB3aGVyZSB0aGUKZ3Vlc3QgaGFu
Z3MgYXMgdGhlIGtlcm5lbCB3YWl0cyBpbmRlZmluaXRlbHkgaW4gdm1idXNfdGVhcmRvd25fZ3Bh
ZGwoKQpmb3IgYSBjb21wbGV0aW9uIHRvIGJlIHNpZ25hbGVkLiBUaGlzIGlzIGFjdHVhbGx5IHdo
YXQgbGVhZCBtZSB0bwpwcm9wb3NlIHNwbGl0dGluZyBuZXR2c2NfcmV2b2tlX2J1ZigpIGFuZCBu
ZXR2c2NfdGVhcmRvd25fZ3BhZGwoKSBpbiBteQppbml0aWFsIHBhdGNoc2V0IHNvIHRoYXQgd2Ug
a2VlcCB0aGUgc2FtZSBvcmRlciBvZiBtZXNzYWdlcyBhbmQgYXZvaWQKdGhhdCBpbmRlZmluaXRl
IHdhaXQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRl
dmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnCmh0dHA6Ly9kcml2
ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaXZlcmRldi1k
ZXZlbAo=
