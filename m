Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-841013-1524864670-2-10131096214619703600
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524864669; b=nvTm9ZuHo+AVd2tTz4LeRiMft2OZhf4ONQrLUNnfdAmwEfT3ZL
    91fF5FqJosOMUrmu+tL1cga58EGVo//BZT86kw5blVa18HONWfFlfP9dp5iPai6a
    F+PKXLRWVFSNa+0ItKDYFTsfjbM2oE7pjnl0ruv6ihzIN5t85xUgmgtsxR9PoJJs
    dZ/l3aMOcUc4i1ngHlyym0UfbkGZgThxQx4cvzbiVU+t6H7MwyqN1gl+PfT+Tsi+
    JXJ0rEsIxdDfw/StB50miNxaBvUYnsIxP1NZ0pNxRLxzmZ79YSVK9jTG/hXFnhxR
    50SgvsYUFDQrvvoweH94nZ8bRD4CHQFl4Y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1524864669; bh=WySkZCIDmizL6wWeKDtgKn4eU5dJOxKLmkrqtYlTp3s=; b=X
    77/xQYPRvJjBaNkjY9gZ51DLwdb/evHgdwenb+RFAcGT126ckx2aoMWNtWj/zZso
    HRofsDApKbmJOnpqeTvs6ZGQLmWoBR2a6IoVXykeU0Fb91QeUwVQzwln5I90J+vq
    hzrABZ7CWjGbf5Fz0D3pOJ/NJnEpyc5Ew+abU4dlt5u8xqwh6plmLRq2D1/ega6x
    MImS1r9VeUATxcmvl+7wp5lQ1I8Siao6X1hqcCNe18Lqzc1839Ya/MF9rMV9PTOR
    aHcJo3/YgvVQtBIF4X6PQ8niy5j+0ba66n/1imDVaB227wGa7fchPiES6JcG2v2y
    IGCMl7wwClx1tj1ShMNuA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FC3Cgyrv;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FC3Cgyrv;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGvWpcbwlcJHONPR1gM8IoYeZSY742vIUP49fBzZzo/l5TEgxF6rMCheTktz+5Zyf8SE9tO8tSH9XoDzMFTrz9f4MoS9Gxlcm3DOUDhjRFsh0w2uUElz
    ke8kg+a/BosO7+IvREGeGL+1rXvvea5Xd2knPAQjC+p+gQ6l2VAtT/H44EhElugvP9HVdF3r/4PVm/wttGaUSQ5RRJt7o0KYXst4g2XaYRMMBSZSwFWeUBDA
    8nqTRPWEaO1V9BeP6rrhNw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=LpQP-O61AAAA:8 a=D19gQVrFAAAA:8 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8
    a=lDTnscz64feEo7zCEE8A:9 a=QEXdDO2ut3YA:10 a=pioyyrs4ZptJ924tMmac:22
    a=W4TVW4IDbPiebHqcZpNg:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqidfs4JJx/JhBdWwNgF1JOZAkW4SKef/DoaL8a8EVD+6qEBA/G93XxbgBjHC9Cb9uqHR1jXw==
Subject: Re: [PATCH] ion: Consider ion pool pages as indirectly reclaimable
To: vjitta@codeaurora.org
References: <1524627830-17187-1-git-send-email-vjitta@codeaurora.org>
 <8618859b-06f9-39a7-80a9-af36cf9faf9f@redhat.com>
 <fb3f0974e9e83b33e7eac267aeecf130@codeaurora.org>
 <cabda3bb75177e37863155deaaf2cb46@codeaurora.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <38cf04f1-bded-7edf-4455-6e6c284277b8@redhat.com>
Date: Fri, 27 Apr 2018 14:30:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cabda3bb75177e37863155deaaf2cb46@codeaurora.org>
Content-Language: en-US
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
Cc: devel@driverdev.osuosl.org, linux-kernel-owner@vger.kernel.org,
 tkjos@android.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 arve@android.com, maco@android.com, sumit.semwal@linaro.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMDQvMjcvMjAxOCAwMjoyOSBBTSwgdmppdHRhQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+IE9u
IDIwMTgtMDQtMjcgMTA6NDAsIHZqaXR0YUBjb2RlYXVyb3JhLm9yZyB3cm90ZToKPj4gT24gMjAx
OC0wNC0yNSAyMToxNywgTGF1cmEgQWJib3R0IHdyb3RlOgo+Pj4gT24gMDQvMjQvMjAxOCAwODo0
MyBQTSwgdmppdHRhQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+Pj4+IEZyb206IFZpamF5YW5hbmQg
Sml0dGEgPHZqaXR0YUBjb2RlYXVyb3JhLm9yZz4KPj4+Pgo+Pj4+IEFuIGlzc3VlIGlzIG9ic2Vy
dmVkIHdoZXJlIG1hbGxvY3MgYXJlIGZhaWxpbmcgZHVlIHRvIG92ZXJjb21taXQgZmFpbHVyZS4K
Pj4+PiBUaGUgZmFpbHVyZSBoYXBwZW5zIHdoZW4gdGhlcmUgaXMgaGlnaCBJT04gcGFnZSBwb29s
IHNpbmNlIElPTiBwYWdlCj4+Pj4gcG9vbCBpcyBub3QgY29uc2lkZXJlZCByZWNsYWltYWJsZSBi
eSB0aGUgb3ZlcmNvbW1pdCBjYWxjdWxhdGlvbiBjb2RlLgo+Pj4+IFRoaXMgY2hhbmdlIGNvbnNp
ZGVycyBpb24gcG9vbCBwYWdlcyBhcyBpbmRpcmVjdGx5IHJlY2xhaW1hYmxlIGFuZCB0aHVzCj4+
Pj4gYWNjb3VudGVkIGFzIGF2YWlsYWJsZSBtZW1vcnkgaW4gdGhlIG92ZXJjb21taXQgY2FsY3Vs
YXRpb24uCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWaWpheWFuYW5kIEppdHRhIDx2aml0dGFA
Y29kZWF1cm9yYS5vcmc+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9zdGFnaW5nL2FuZHJvaWQv
aW9uL2lvbl9wYWdlX3Bvb2wuYyB8IDUgKysrKysKPj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2FuZHJv
aWQvaW9uL2lvbl9wYWdlX3Bvb2wuYyBiL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2lvbi9pb25f
cGFnZV9wb29sLmMKPj4+PiBpbmRleCBkYjhmNjE0Li45YmM1NmViIDEwMDY0NAo+Pj4+IC0tLSBh
L2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2lvbi9pb25fcGFnZV9wb29sLmMKPj4+PiArKysgYi9k
cml2ZXJzL3N0YWdpbmcvYW5kcm9pZC9pb24vaW9uX3BhZ2VfcG9vbC5jCj4+Pj4gQEAgLTMyLDYg
KzMyLDkgQEAgc3RhdGljIHZvaWQgaW9uX3BhZ2VfcG9vbF9hZGQoc3RydWN0IGlvbl9wYWdlX3Bv
b2wgKnBvb2wsIHN0cnVjdCBwYWdlICpwYWdlKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBsaXN0
X2FkZF90YWlsKCZwYWdlLT5scnUsICZwb29sLT5sb3dfaXRlbXMpOwo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBwb29sLT5sb3dfY291bnQrKzsKPj4+PiDCoMKgwqDCoMKgIH0KPj4+PiArCj4+Pj4g
K8KgwqDCoCBtb2Rfbm9kZV9wYWdlX3N0YXRlKHBhZ2VfcGdkYXQocGFnZSksIE5SX0lORElSRUNU
TFlfUkVDTEFJTUFCTEVfQllURVMsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAoMSA8PCAoUEFHRV9TSElGVCArIHBvb2wtPm9yZGVyKSkpOwo+Pj4+IMKgwqDCoMKgwqAgbXV0
ZXhfdW5sb2NrKCZwb29sLT5tdXRleCk7Cj4+Pj4gwqAgfQo+Pj4+IMKgIEBAIC01MCw2ICs1Myw4
IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqaW9uX3BhZ2VfcG9vbF9yZW1vdmUoc3RydWN0IGlvbl9w
YWdlX3Bvb2wgKnBvb2wsIGJvb2wgaGlnaCkKPj4+PiDCoMKgwqDCoMKgIH0KPj4+PiDCoMKgwqDC
oMKgwqDCoCBsaXN0X2RlbCgmcGFnZS0+bHJ1KTsKPj4+PiArwqDCoMKgIG1vZF9ub2RlX3BhZ2Vf
c3RhdGUocGFnZV9wZ2RhdChwYWdlKSwgTlJfSU5ESVJFQ1RMWV9SRUNMQUlNQUJMRV9CWVRFUywK
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0oMSA8PCAoUEFHRV9TSElGVCAr
IHBvb2wtPm9yZGVyKSkpOwo+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIHBhZ2U7Cj4+Pj4gwqAgfQo+
Pj4+Cj4+Pgo+Pj4gSSdtIHN1cmUgdGhpcyBmaXhlcyB0aGUgcHJvYmxlbSBidXQgSSBkb24ndCB0
aGluayB3ZSB3YW50IHRvCj4+PiBzdGFydCB0aHJvd2luZyBwYWdlIGFkanVzdG1lbnRzIGludG8g
SW9uLiBXaHkgaXNuJ3QgdGhpcwo+Pj4gbWVtb3J5IGFscmVhZHkgY29uc2lkZXJlZCByZWNsYWlt
YWJsZSBieSBleGlzdGluZyBjYWxjdWxhdGlvbnM/Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4gTGF1cmEK
Pj4KPj4gWW91IGNhbiByZWZlciB0byBkaXNjdXNzaW9uIGhlcmUgaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMTgvMy81LzM2MSBpbnRyb2R1Y2luZwo+PiBOUl9JTkRJUkVDVExZX1JFQ0xBSU1BQkxF
X0JZVEVTIGZvciB0aGUgbWVtb3J5IHdoaWNoIGlzIG5vdCBjdXJyZW50bHkgY29uc2lkZXJlZAo+
PiBhcyByZWNsYWltYWJsZQo+Pgo+PiBUaGFua3MsCj4+IFZpamF5Cj4gCj4gVGhlcmUgd2FzIGFs
c28gZGlzY3Vzc2lvbiBzcGVjaWZpYyB0byBpb24gaW4gdGhhdCB0aHJlYWQgeW91IGNhbiBmaW5k
IGl0IGhlcmUKPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC80LzI1LzY0Mgo+IAo+IFRoYW5r
cywKPiBWaWpheQoKVGhhbmtzIGZvciBwb2ludGluZyB0aGF0IHRocmVhZCBvdXQuIEknbSBzdGls
bCBhIGxpdHRsZSB3YXJ5IHNpbmNlCklvbiBpcyBpbiBzdGFnaW5nIGJ1dCBpZiB0aGUgcmVzdCBv
ZiBtbSBhcmUgb2theSB3aXRoIGl0CgpBY2tlZC1ieTogTGF1cmEgQWJib3R0IDxsYWJib3R0QHJl
ZGhhdC5jb20+CgpUaGFua3MsCkxhdXJhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9q
ZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
