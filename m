Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3993364-1518396757-5-4396121114822013694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518396757; b=lTdRELmyi4IRKVzst6VxzIMDHUcTAltOPdTFdJecCd7NRFJ
    RCMks+XtLPGQdV/L/YJx1gp9j330rsLcLGRdxHnyrm1F2fRr9Jy16RL7R2vAFrh0
    E0M7b6TIwHK258njVAJnUE4JS93tpRmGZjh2K8SEn9Bp/f8db+AtzXnwIFkIoOeR
    KE5iDFyoX4yk7yQMlUddpwXCxRvxo57bCKeYIUO2PQvGKeOiJFZLR98TNn6dl9R5
    dBp5cjLsd1QtmfMy2ho3iJKoh2M0LDBze6q5IluQ48TMlwbMiBN3Gtfu5Iks/yNO
    feUg+pOGQy3pfdjwQYicLTNyuYGOh192jDIsRyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:from:in-reply-to
    :date:message-id:references:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518396757; bh=4
    eM5ErLb70sjGhIQIe/LBONGS06tMPxCXKJpU6atfms=; b=UnqZT7J2DoIWqHqgJ
    kUrfsfxwAAAQsgJL3EqmJ3lj9fLR6tV1kXGvfWe8tqG9qe+JFR3SSfAOtviaa0i4
    Hgexu2teIHdXk4Wj2XbxAUlsdQibFYjEjDplKd9/+/UgEKYXa0/B8BUTiiWG1rMP
    f+2GXDxbuONdsaetv1OvvWiJRxrkSyvcNsIz2T/v5cfxHH5zQuO/ZpkJKpOmrO4E
    JUija4KqC28m0Irp5N0xsZ3adJ71knmYcmc4/jCWvqGPfDLb20S7bbef7Hv7kvsP
    q1UIK+ObtZgrZaYxrxElp2PL55AAas/gG2r0WCiR1pMLKyEPyXteLs9bO9xvDWrq
    4tbyg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,499,1511856000"; d="scan'208";a="17697200"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [lustre-devel] [PATCH 41/80] staging: lustre: lmv: separate
 master object with master stripe
From: Oleg Drokin <oleg.drokin@intel.com>
In-Reply-To: <87h8qnrt0o.fsf@notabene.neil.brown.name>
Date: Sun, 11 Feb 2018 19:52:26 -0500
Message-Id: <5928AEAA-EDD6-4A6E-A9BA-1FA5974C1BD9@intel.com>
References: <1471378773-24590-1-git-send-email-jsimmons@infradead.org>
 <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
 <87r2pvkkl5.fsf@notabene.neil.brown.name>
 <09CE6CEC-52BC-4B29-B609-40DE68A64A33@intel.com>
 <87o9kylux7.fsf@notabene.neil.brown.name>
 <FC7E817D-BA15-4D0A-9976-F1343F9B022A@intel.com>
 <87h8qnrt0o.fsf@notabene.neil.brown.name>
To: NeilBrown <neilb@suse.com>
X-Mailer: Apple Mail (2.3273)
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 wang di <di.wang@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cj4gT24gRmViIDExLCAyMDE4LCBhdCA2OjQ0IFBNLCBOZWlsQnJvd24gPG5laWxiQHN1c2UuY29t
PiB3cm90ZToKPiAKPiBPbiBUaHUsIEZlYiAwOCAyMDE4LCBPbGVnIERyb2tpbiB3cm90ZToKPj4g
Cj4+IENlcnRhaW4gdGhpbmdzIHRoYXQgc291bmQgdXNlbGVzcyAobGlrZSB0aGUgZGVidWcgc3Vi
c3lzdGVtIGluIEx1c3RyZSkKPj4gaXMgdmVyeSB1c2VmdWwgd2hlbiB5b3UgaGF2ZSBhIDEwayBu
b2RlcyBpbiBhIGNsdXN0ZXIgYW5kIG5lZWQgdG8gc2VsZWN0aXZlbHkKPj4gcHVsbCBzdHVmZiBm
cm9tIGEgcnVuIHRvIGRlYnVnIGEgY29tcGxpY2F0ZWQgY3Jvc3Mtbm9kZSBpbnRlcmFjdGlvbi4K
Pj4gSSBhc2tlZCBORlMgcGVvcGxlIGhvdyBkbyB0aGV5IGRvIGl0IGFuZCB0aGV5IGRvbuKAmXQg
aGF2ZSBhbnl0aGluZyB0aGF0IHNjYWxlcwo+PiBhbmQgdXN1YWxseSBpbnZvbHZlcyByZWR1Y2lu
ZyB0aGUgcHJvYmxlbSB0byBhIG11Y2ggc21hbGxlciBzZXQgb2Ygbm9kZXMgZmlyc3QuCj4gCj4g
dGhlICJycGNkZWJ1ZyIgc3R1ZmYgdGhhdCBMaW51eC9uZnMgaGFzIGlzIHNvbWV0aW1lcyB1c2Vm
dWwsIGJ1dCBzb21lIHBhcnRzCj4gYXJlIGNoYW5naW5nIHRvIHRyYWNlcG9pbnRzIGFuZCBzb21l
IHBhcnRzIGhhdmUgcmVtYWluZWQsIHdoaWNoIGlzIGEKPiBsaXR0bGUgY29uZnVzaW5nLgo+IAo+
IFRoZSBmYWN0IHRoYXQgbHVzdHJlIHRyYWNpbmcgc2VlbXMgdG8gKmFsd2F5cyogbG9nIGV2ZXJ5
dGhpbmcgc28gdGhhdCBpZgo+IHNvbWV0aGluZyBnb2VzIHdyb25nIHlvdSBjYW4gZXh0cmFjdCB0
aGF0IGxhc3QgZmV3IG1lZyg/KSBvZiBsb2dzIHNlZW1zCj4gcmVhbGx5IHVzZWZ1bC4KCk5vdCBy
ZWFsbHkuIEx1c3RyZSBhbHNvIGhhcyBhIGJpdG1hc2sgZm9yIGxvZ3MgKHNpbmNlIG90aGVyd2lz
ZSBhbGwgdGhvc2UgcHJpbnRzCmFyZSBwcmV0dHkgY3B1IHRheGluZyksIGJ1dCB3aGF0IG1ha2Vz
IHRob3NlIGxvZ3MgYmV0dGVyIGlzOgp0aGUgc2l6ZSBpcyB1bmxpbWl0ZWQsIG5vdCBjb25zdHJh
aW5lZCBieSBkbWVzZyBidWZmZXIgc2l6ZS4KWW91IGNhbiBjYXB0dXJlIHRob3NlIGxvZ3MgZnJv
bSBhIGNyYXNoZHVtcCAoc29tZXRoaW5nIEkgcmVhbGx5IHdpc2gKc29tZWJvZHkgd291bGQgaW1w
bGVtZW50IGZvciB0cmFjZXBvaW50IGJ1ZmZlcnMsIGJ1dCBhbGFzLCBJIGhhdmUgbm90CmZvdW5k
IGFueXRoaW5nIGZvciB0aGlzIHlldCAtIHdlIGhhdmUgYSBjcmFzaCBwbHVnaW4gdG8gZXh0cmFj
dCBsdXN0cmUKZGVidWcgbG9ncyBmcm9tIGEga2VybmVsIGNyYXNoZHVtcCkuCj4+PiAKPj4+IEV2
ZW4gaWYgaXQgaXMgaG9ycmlibGUgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIGl0IGluIHN0YWdp
bmcuLi4gSSBndWVzcwo+Pj4gdGhlIGNoYW5nZXMgcmVxdWlyZWQgdG8gZXh0NCBwcm9oaWJpdCB0
aGF0Li4uIEkgZG9uJ3Qgc3VwcG9zZSBpdCBjYW4gYmUKPj4+IG1hZGUgdG8gd29yayB3aXRoIG1h
aW5saW5lIGV4dDQgaW4gYSByZWR1Y2VkLWZ1bmN0aW9uYWxpdHktYW5kLXBlcmZvcm1hbmNlCj4+
PiB3YXk/Pwo+PiAKPj4gV2Ugc3VwcG9ydCB1bnBhdGNoZWQgWkZTIGFzIGEgc2VydmVyIHRvbyEg
OykKPiAKPiBTbyB0aGF0IHRoYXQgbWVhbiB5b3Ugd291bGQgZXhwZWN0IGx1c3RyZS1zZXJ2ZXIg
dG8gd29yayB3aXRoIHVucGF0Y2hlZAo+IGV4dDQ/IEluIHRoYXQgY2FzZSBJIHdvbid0IGdpdmUg
dXAgaG9wZSBvZiBzZWVpbmcgdGhlIHNlcnZlciBpbiBtYWlubGluZQo+IGluIG15IGxpZmV0aW1l
LiAgQ2xpZW50IGZpcnN0IHRob3VnaC4KCldoaWxlIHVucGF0Y2hlZCBleHQ0IG1pZ2h0IGluIHRo
ZW9yeSBiZSBwb3NzaWJsZSwgY3VycmVudGx5IGl0IGRvZXMgbm90IGV4cG9ydApldmVyeXRoaW5n
IHdlIG5lZWQgZnJvbSB0aGUgdHJhbnNhY3Rpb24vZnMgY29udHJvbCBwZXJzcGVjdGl2ZS4KCkJ5
ZSwKICAgIE9sZWcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDov
L2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVy
ZGV2LWRldmVsCg==
