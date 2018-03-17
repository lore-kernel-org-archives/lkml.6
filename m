Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2444442-1521325648-2-3768366733115240853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521325647; b=rWTQATK1439CGMXOtvuV//PlvhDio/Pcqdlpmdc0xomqBN/
    8e+vKlQek7MwN7j++ZqQ8a7YDksxlw2wGB63c4Btuk+QsqE6sm50IAyHKc1Lbvqr
    K4s4SRFOzxd7LndExdaKnZriJMOtvMn+wkTTWIkuEJMPs99hJK2hnQ0mNLulwKLJ
    eod+7fBF8/hUNgPAhOFMm1Rmcx0Jc6HPyMkoQ3iN4WlL7CVoxtdeMQLzRQl7s21x
    fV4CP3pFbCecZPhd91eXbiP9hnHRBUKHaddX/8OWAGGj/SRa689GDfNd9LwzLHnC
    lF8DiE6c+T59V5Waf4gwivKbGXzeWTGrkJ43Tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521325647; bh=D
    NSMJbyIAcaBD1MlFP1G6QwCGAW40QYMRqz4yQeNtGg=; b=Hq1AsZJfxGYU5CDnQ
    zZG1eb643qJpVDAId+HSDqrt9VmBD+3Fq+/faU8iJsmDD5YeY9uJjo7PVPtAekSf
    812ra8Q7ljirr/8al5FCrVSImeDJfw3l23B5cTt+B0CrR1mIE/6kSS2R3ZL/1CWy
    awg7GLPllqDJc6znbBofTCLPI7UhC5Sbsa62FEtQVD9rW2tc35HeUxemlE4b5lOA
    Lwda72yzB2mjYN+cn4c7N36OHW8lBO0G4w/qQe1VHF1ZVYJtDsDwwaJrWg7hf1Pj
    SPxwomVDXrxlawWvEvSP9zLsEEFJMigHI25Q+eHziszQYM7XUMeSvz0tR86wYRV3
    1sUJA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCC921741
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Mar 2018 22:27:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Subject: Re: Plan to move cdc:ad7746 driver out of staging
Message-ID: <20180317222714.101ce507@archlinux>
In-Reply-To: <CALfa3vGh4Ni36+ptCdnd0+mxPWDs8OQKe7-egpttgYBpuDTeqA@mail.gmail.com>
References: <CALfa3vGh4Ni36+ptCdnd0+mxPWDs8OQKe7-egpttgYBpuDTeqA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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
Cc: devel@driverdev.osuosl.org, Daniel Baluta <daniel.baluta@gmail.com>,
 lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCAxMiBNYXIgMjAxOCAxNjoyNTo1MiAtMDMwMApIZXJuw6FuIEdvbnphbGV6IDxoZXJu
YW5AdmFuZ3VhcmRpYXN1ci5jb20uYXI+IHdyb3RlOgoKPiBIaSwKPiAKPiBUaGlzIGlzIG15IHBs
YW4gZm9yIG1vdmluZyBvdXQgdGhlIGFkNzc0NiBkcml2ZXIgb3V0IG9mIHN0YWdpbmcuIEkKPiBo
YXZlIHNvbWUgc3BlY2lmaWMgcXVlc3Rpb25zIHRoYXQgd291bGQgYmUgcmVhbGx5IGhlbHBmdWwg
aWYgc29tZW9uZQo+IGNhbiBwb2ludCBtZSBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uIHRvIGdvLgo+
IAo+IDEuIFBpY2sgdXAgb24gRGF2aWQncyBjbGVhbi11cCBwYXRjaC4gRmluaXNoIGNsZWFuaW5n
IENIRUNLcyBmcm9tCj4gY2hlY2twYXRjaC5wbCBpZiBwb3NzaWJsZS4KPiAKPiAyLiBSZW9yZGVy
IGluY2x1ZGVzIGFscGhhYmV0aWNhbGx5Lgo+IAo+IDMuIFJlb3JkZXIgc29tZSB2YXJpYWJsZSBk
ZWNsYXJhdGlvbnMgaW4gYW4gaW52ZXJzZS1weXJhbWlkIHNjaGVtZS4KPiAKPiA0LiBGaXggc3lz
ZnMgYXR0cnMgbmFtaW5nIHRvIGNvbXBseSB3aXRoIHRoZSBBQkksIGUuZy46Cj4gaW5fY2FwYWNp
dGFuY2UwX2NhbGliYmlhc19jYWxpYnJhdGlvbiAtPiBpbl9jYXBhY2l0YW5jZTBfY2FsaWJiaWFz
ClRha2UgYSBjYXJlZnVsIGxvb2sgYXQgd2hhdCB0aGVzZSBhcmUgZG9pbmcgYmVmb3JlIHlvdSBk
byB0aGF0IDopClRoZW4gY29uc2lkZXIgd2hhdCB0aGUgdXNlY2FzZXMgYXJlLiAgSWYgd2UgbmVl
ZCB0bywgd2UgbWF5IG5lZWQKdG8gYWRkIG5ldyBBQkkgdG8gY292ZXIgdGhlIHJlcXVpcmVtZW50
LgoKPiAKPiA1LiBBZGQgZG9jdW1lbnRhdGlvbiB0byB0aGUge2NhcCx2dH1fZmlsdGVyX3JhdGUg
dGFibGVzIGFuZCB0byB0aGUKPiBwcm9jZXNzZWQgaW5mbyByZWFkLiBUaGVyZSBhcmUgc29tZSBt
YWdpYyBudW1iZXJzIG91dCB0aGVyZSwgSSB3aWxsCj4gcmVhZCB0aGUgZGF0YXNoZWV0IGFuZCBl
eHBsYWluIHRoZSBtYXRoIHRoYXQgSSBjb25zaWRlciBhcHByb3BpYXRlLgo+IAo+IDYuIFRoZXJl
IGFyZSBhIGZldyB0b28gbWFueSBkZWZpbmVzIHRoYXQgYXJlIG5vdCB1c2VkIGF0IGFsbCBidXQg
dGhleQo+IGRvIGZvbGxvdyB0aGUgZGF0YXNoZWV0LiBJIGRvbid0IGtub3cgaWYgdGhlcmUgYXJl
IHBsYW5zIHRvIGtlZXAKPiBhZGRpbmcgZnVuY3Rpb25hbGl0aWVzIHRvIHRoaXMgZHJpdmVyIG9y
IGlmIEkgc2hvdWxkIGp1c3QgcmVtb3ZlIHRoZW0uCj4gCj4gOC4gRVhDTFZMIGlzIGR1cGxpY2F0
ZWQuIFRoZXJlJ3MgYSBzaW1wbGUgbWFjcm8gaW4gYWQ3NzQ2LmMgYW5kIHNvbWUKPiBkZWZpbmVz
IGluIGFkNzc0Ni5oLiBUaGUgbGF0dGVyIGFyZSBub3QgdXNlZCBhbnl3aGVyZSBpbiB0aGUgY29k
ZS4KPiBSZW1vdmUgdGhlbS4KPiAKPiA3LiBNb3ZlIHRoZSBzdHJ1Y3QgYWQ3NzQ2X3BsYXRmb3Jt
X2RhdGEgdG8gaW5jbHVkZS9saW51eC9paW8uCj4gCj4gQXMgbWVudGlvbmVkIGluIGVhcmxpZXIg
bWFpbHMsIEkgd2lsbCBhdm9pZCBhZGRpbmcgbmV3IGZlYXR1cmVzIGFzIEkKPiBoYXZlIG5vIGFj
Y2VzcyB0byB0aGUgaGFyZHdhcmUgYW5kLCB0aGVyZWZvcmUsIGNvdWxkIG5vdCB0ZXN0IGl0LgpN
aWNoYWVsIGhhcyBzdGF0ZWQgaGUgaGFzIGF0IGxlYXN0IHNvbWUgb2YgdGhlIENEQ3Mgc3RpbGwg
c28gbWF5IGJlIGFibGUKdG8gaGVscCB3aXRoIHRoYXQuCgo+IAo+IEkgZ3Vlc3MgdGhhdCdkIGJl
IGFsbC4gSWYgSSdtIG1pc3Npbmcgc29tZXRoaW5nIEkgd291bGQgYmUgcmVhbGx5Cj4gZ3JhdGVm
dWwgaWYgeW91IGNhbiBsZXQgbWUga25vdyBvciBnaXZlIG1lIHNvbWUgcG9pbnRlcnMgd2hlcmUg
dG8gbG9vawo+IGF0LgoKSXQgd291bGQgcHJvYmFibHkgYmUgYSBnb29kIGlkZWEgdG8gYWRkIGRl
dmljZXRyZWUgYmluZGluZ3MgaWYgcG9zc2libGUuCkhhcmRseSBhbnl0aGluZyBpcyBkb25lIHdp
dGggYm9hcmQgZmlsZXMgdGhlc2UgZGF5cyAtIHRob3VnaCB3ZSBzaG91bGQKbWFpbnRhaW4gdGhl
IHBsYXRmb3JtIGRhdGEgZm9yIGFueW9uZSB3aG8gaXMgdXNpbmcgdGhlbSAoZm9yIG5vdykuCgpU
aGVyZSBtYXkgd2VsbCBiZSBvdGhlciB0aGluZ3MgdGhhdCBjb21lIG91dCBvZiB0aGUgd29vZHdv
cmsgb25jZQp3ZSBkbyBhIGZvcm1hbCByZXZpZXcgb2YgdGhlIHBhdGNoIHRoYXQgcHJvcG9zZXMg
bW92aW5nIGl0IG91dCBvZgpzdGFnaW5nICh0aGVyZSBhbG1vc3QgYWx3YXlzIGlzISkKCkpvbmF0
aGFuCgo+IAo+IENoZWVycywKPiAKPiBIZXJuw6FuCj4gLS0KPiBUbyB1bnN1YnNjcmliZSBmcm9t
IHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgbGludXgtaWlvIiBpbgo+IHRo
ZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnCj4gTW9yZSBt
YWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5o
dG1sCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZl
bCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVy
ZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2
ZWwK
