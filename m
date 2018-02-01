Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3115974-1517474254-2-9484584375227235360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517474253; b=Og9kWQpeEBAD3xjm3B1MaNiVKIgT8cDFnUKVOwXg45zA+GK
    9yhdIuOOvC3J0giFrLNEhEGIGBcNXdKpNrgBljcou++2Wt35jQCVHDpqp9XIxq8Q
    38GuNYnAmFk2idi/4UQbcN8K/uS4U0IeIAKD+EtjQmNGoqkPibqGZEFxjIzLNpxS
    5zqwHZZKBsuzIeA+zbxF+HilG5Ax5RXX5hrVAEgt8MPbzAwuLn5co+yfwz5Vr8wI
    RPjSqsV+6TGxkJTk3E282GgQUuY57aTTxTa3tGsYWnKzzdd40FNS2Zho3CiVFFBK
    xZSTZDV+xGKpglWJoFolgyRRA6qevhiSZERJAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1517474253; bh=pXsKPuoe75kOBz+1zL6RorT5uLW3nqQ2hZqVuzk1Mq0=; b=r
    WhHUSsHEfRzohJ6Mdvb7ikNkJUeR9ww8APimlY3qPdCW6xZ4Q1bOAQpYyQBtyALp
    6+mx/niAjrh257Mfpjgq8PznkEgJvI4Xd34FM2oxQWAPj21OeaTy1MCkIJF31wnd
    sj+QvqvqCKdHRvJpHDnjV2rKphpUKLDm1zND6WKKQjUNWx7KuIrTehfRuC862H9H
    VLmN865C1rzLqc22kwC7Qn/IDQzfaziPMRcbsxy0zymjeBvGcPkYhPfuTmqBKe5w
    LpChhEYQGP9hTZ4/zlQd17whf9w5nKghPn+wqN4zFa8tnpHq4bo8UC9cXOWryFBw
    ATtACl6ghVQDcJPDTuelg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Message-ID: <1517474239.30443.2.camel@redhat.com>
Subject: Re: [RFC PATCH 1/2] hv_netvsc: Split netvsc_revoke_buf() and
 netvsc_teardown_gpadl()
From: Mohammed Gamal <mgamal@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 01 Feb 2018 09:37:19 +0100
In-Reply-To: <20180131150137.58abee5b@xeon-e3>
References: <1516700045-32142-1-git-send-email-mgamal@redhat.com>
 <1516700045-32142-2-git-send-email-mgamal@redhat.com>
 <20180130112926.53f3c166@xeon-e3> <1517397409.3452.7.camel@redhat.com>
 <20180131150137.58abee5b@xeon-e3>
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

T24gV2VkLCAyMDE4LTAxLTMxIGF0IDE1OjAxIC0wODAwLCBTdGVwaGVuIEhlbW1pbmdlciB3cm90
ZToKPiBPbiBXZWQsIDMxIEphbiAyMDE4IDEyOjE2OjQ5ICswMTAwCj4gTW9oYW1tZWQgR2FtYWwg
PG1nYW1hbEByZWRoYXQuY29tPiB3cm90ZToKPiAKPiA+IE9uIFR1ZSwgMjAxOC0wMS0zMCBhdCAx
MToyOSAtMDgwMCwgU3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgMjMgSmFu
IDIwMTggMTA6MzQ6MDQgKzAxMDAKPiA+ID4gTW9oYW1tZWQgR2FtYWwgPG1nYW1hbEByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gwqDCoAo+ID4gPiA+IFNwbGl0IGVhY2ggb2YgdGhlIGZ1bmN0aW9u
cyBpbnRvIHR3byBmb3IgZWFjaCBvZiBzZW5kL3JlY3YKPiA+ID4gPiBidWZmZXJzCj4gPiA+ID4g
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTW9oYW1tZWQgR2FtYWwgPG1nYW1hbEByZWRoYXQuY29t
PsKgwqAKPiA+ID4gCj4gPiA+IFNwbGl0dGluZyB0aGVzZSBmdW5jdGlvbnMgaXMgbm90IG5lY2Vz
c2FyecKgwqAKPiA+IAo+ID4gSG93IHNvPyBXZSBuZWVkIHRvIHNlbmQgZWFjaCBtZXNzYWdlIGlu
ZGVwZW5kZW50bHksIGFuZCBoZW5jZSB0aGUKPiA+IHNwbGl0Cj4gPiAoc2VlIGNvdmVyIGxldHRl
cikuIElzIHRoZXJlIGFub3RoZXIgd2F5Pwo+IAo+IFRoaXMgaXMgYWxsIHRoYXQgaXMgbmVlZGVk
Lgo+IAo+IAo+IFN1YmplY3Q6IFtQQVRDSF0gaHZfbmV0dnNjOiB3b3JrIGFyb3VuZCBmb3IgZ3Bh
ZGwgdGVhcmRvd24gb24gb2xkZXIKPiB3aW5kb3dzCj4gwqBzZXJ2ZXIKPiAKPiBPbiBXUzIwMTIg
dGhlIGhvc3QgaWdub3JlcyBtZXNzYWdlcyBhZnRlciB2bWJ1cyBjaGFubmVsIGlzIGNsb3NlZC4K
PiBXb3JrYXJvdW5kIHRoaXMgYnkgZG9pbmcgd2hhdCBXaW5kb3dzIGRvZXMgYW5kIHNlbmQgdGhl
IHRlYXJkb3duCj4gYmVmb3JlIGNsb3NlIG9uIG9sZGVyIHZlcnNpb25zIG9mIE5WU1AgcHJvdG9j
b2wuCj4gCj4gUmVwb3J0ZWQtYnk6IE1vaGFtbWVkIEdhbWFsIDxtZ2FtYWxAcmVkaGF0LmNvbT4K
PiBGaXhlczogMGNmNzM3ODA4YWU3ICgiaHZfbmV0dnNjOiBuZXR2c2NfdGVhcmRvd25fZ3BhZGwo
KSBzcGxpdCIpCj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1p
Y3Jvc29mdC5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL25ldC9oeXBlcnYvbmV0dnNjLmMgfCA5ICsr
KysrKysrLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9oeXBlcnYvbmV0dnNjLmMKPiBiL2RyaXZl
cnMvbmV0L2h5cGVydi9uZXR2c2MuYwo+IGluZGV4IDE3ZTUyOWFmNzlkYy4uMWEzZGYwZWZmNDJm
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2MuYwo+ICsrKyBiL2RyaXZl
cnMvbmV0L2h5cGVydi9uZXR2c2MuYwo+IEBAIC01NzQsMTAgKzU3NCwxNyBAQCB2b2lkIG5ldHZz
Y19kZXZpY2VfcmVtb3ZlKHN0cnVjdCBodl9kZXZpY2UKPiAqZGV2aWNlKQo+IMKgCcKgKi8KPiDC
oAluZXRkZXZfZGJnKG5kZXYsICJuZXQgZGV2aWNlIHNhZmUgdG8gcmVtb3ZlXG4iKTsKPiDCoAo+
ICsJLyogV29ya2Fyb3VuZCBmb3Igb2xkZXIgdmVyc2lvbnMgb2YgV2luZG93cyByZXF1aXJlIHRo
YXQKPiArCcKgKiBidWZmZXIgYmUgcmV2b2tlZCBiZWZvcmUgY2hhbm5lbCBpcyBkaXNhYmxlZAo+
ICsJwqAqLwo+ICsJaWYgKG5ldF9kZXZpY2UtPm52c3BfdmVyc2lvbiA8IE5WU1BfUFJPVE9DT0xf
VkVSU0lPTl80KQo+ICsJCW5ldHZzY190ZWFyZG93bl9ncGFkbChkZXZpY2UsIG5ldF9kZXZpY2Up
Owo+ICsKPiDCoAkvKiBOb3csIHdlIGNhbiBjbG9zZSB0aGUgY2hhbm5lbCBzYWZlbHkgKi8KPiDC
oAl2bWJ1c19jbG9zZShkZXZpY2UtPmNoYW5uZWwpOwo+IMKgCj4gLQluZXR2c2NfdGVhcmRvd25f
Z3BhZGwoZGV2aWNlLCBuZXRfZGV2aWNlKTsKPiArCWlmIChuZXRfZGV2aWNlLT5udnNwX3ZlcnNp
b24gPj0gTlZTUF9QUk9UT0NPTF9WRVJTSU9OXzQpCj4gKwkJbmV0dnNjX3RlYXJkb3duX2dwYWRs
KGRldmljZSwgbmV0X2RldmljZSk7Cj4gwqAKPiDCoAkvKiBBbmQgZGlzc2Fzc29jaWF0ZSBOQVBJ
IGNvbnRleHQgZnJvbSBkZXZpY2UgKi8KPiDCoAlmb3IgKGkgPSAwOyBpIDwgbmV0X2RldmljZS0+
bnVtX2NobjsgaSsrKQoKSSd2ZSB0cmllZCBhIHNpbWlsYXIgd29ya2Fyb3VuZCBiZWZvcmUgYnkg
Y2FsbGluZwpuZXR2c2NfdGVhcmRvd25fZ3BhZGwoKSBhZnRlciBuZXR2c2NfcmV2b2tlX2J1Zigp
LCBidXQgYmVmb3JlIHNldHRpbmcKbmV0X2RldmljZV9jdHgtPm52ZGV2IHRvIE5VTEwgYW5kIGl0
IGNhdXNlZCB0aGUgZ3Vlc3QgdG8gaGFuZyB3aGVuCnRyeWluZyB0byBjaGFuZ2UgTVRVLsKgCgpM
ZXQgbWUgdHJ5IHRoYXQgY2hhbmdlIGFuZCBzZWUgaWYgaXQgYmVoYXZlcyBkaWZmZXJlbnRseS4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFp
bGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5s
aW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
