Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-335416-1521653457-2-11791403071765721363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521653457; b=LKECNnFDikq8qarLptPxguRYxG7TlGBg+l79e2kF4iybI/b
    V4x4fPdOkUS4mAvrA0Om1p9LHZHx7VhCVfATrE/tEWKHllO34LQr6B0vBAkxW+qH
    hfbGIKwFb3kkaGivAAwuhRx8CciMpItJBUlPyPweteoIHGEcMs3UDWoQisPDsCJl
    jDtKgaILotHf8rV3WvYpNxY46kt+aKnufo9Np7sNxYF4gMcdRIwO/gQt0hPnLTT/
    abqXb4MmOcM7gxnqUR9cnl57GbMPMmpVh54aCMsCYBwqKGoSJg+Zi/XGcZFoPn5p
    4RjMWtrzAffs7D6/YzJsqUrffkb3DFVjXVnm17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521653457; bh=H
    fAVvt2ygFGPZicEI9HUL6sH9ItyhqUx9eoWbHgvenc=; b=gSJmImzebByVvJxzL
    9z9nfaabB0LAV1iKJxYbOtT+nEx7HEREuNhAW87kWbIm9bzaKFFPsSyjOS5D9v0u
    HOsN/AmwhJg8ZBuIcXJcyg1EQN996mZ8ve0h0geA3oDwgsAwHAqkRqlQ7GnvD8AS
    NjALjckzZktNs+8x/l123l93IJ/VM0U4JiUP6frAHq4hLu5mr1ZAnhUG9Bt7SXiQ
    N7CcuIKuyIjotNB4YoqAsszEMuDk3DbpG8zGQseYH/Utg6H8zh+Q/aGRQWt0m+8A
    PcOxypY0dyQeh4BfKq7VoWDfwO3NMLW34/iL65TNWWKzWbn7QJ3cnJ2stg5YFRKE
    IBm8Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B3D21770
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=helgaas@kernel.org
Date: Wed, 21 Mar 2018 12:30:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Message-ID: <20180321173047.GA38649@bhelgaas-glaptop.roam.corp.google.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
 <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

W0kgY29tcG9zZWQgbW9zdCBvZiB0aGlzIGJlZm9yZSBzZWVpbmcgTG9yZW56bydzIHJlc3BvbnNl
LCBzbyBzb3JyeQphYm91dCB0aGUgZHVwbGljYXRpb24uICBNYXliZSBzZWVpbmcgdGhpbmdzIHN0
YXRlZCBhIGRpZmZlcmVudCB3YXkKd2lsbCBoZWxwIDopXQoKT24gVHVlLCBNYXIgMjAsIDIwMTgg
YXQgMTE6MDA6MzZQTSArMDAwMCwgU3JpZGhhciBQaXRjaGFpIHdyb3RlOgo+IEhpIExvcmVuem8s
Cj4gICAgVHJhbnNwYXJlbnQgU1JJT1YgaXMgZXhwb3NpbmcgdGhlIE5JQyBkaXJlY3RseSB0byB0
aGUga2VybmVsIHZpYQo+IHBhcmEtdmlydHVhbCBkZXZpY2UsIHVubGlrZSBjcmVhdGluZyBhIG5l
dGRldiBhbmQgYXNzb2NpYXRpbmcgaXQgd2l0aCB0aGUgYm9uZAo+IGRyaXZlci4gRnVydGhlciBk
ZXNjcmlwdGlvbnMgaGVyZSwKPiAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9jb21taXQvP2lkPTBjMTk1NTY3YThm
NmU4MmVhNTUzNWNkOWYxZDU0YTE2MjZkZDIzM2UKPiAKPiBQcmV2aW91c2x5LCB3aGVuIHVzaW5n
IHRoZSBib25kIGRyaXZlciwgdW5pcXVlIGFuZCBwZXJzaXN0ZW50IFZGIE5JQyBuYW1lCj4gd2Fz
IHJlcXVpcmVkLCBzbyB3ZSB1c2VkIHNlcmlhbCBudW1iZXIgYXMgUENJIGRvbWFpbiB3aGljaCBp
cyBpbmNsdWRlZCBhcwo+IHBhcnQgb2YgdGhlIFZGIE5JQyBuYW1lLiAgVHJhbnNwYXJlbnQgU1JJ
T1YgbW9kZSBwdXRzIFZGIE5JQyBiYXNlZCBvbiBNQUMKPiBtYXRjaCBhcyBhIHNsYXZlIG9mIHN5
bnRoZXRpYyBOSUMsIHNvIFZGIE5JQ+KAmXMgbmFtZSBpcyBubyBsb25nZXIgaW1wb3J0YW50LgoK
SGkgU3JpZGhhciwKCkEgZmV3IGhpbnRzIGFib3V0IHN1Ym1pdHRpbmcgcGF0Y2hlcyBtb3JlIGVm
ZmljaWVudGx5OgoKMSkgWW91IG5ldmVyIGhhdmUgdG8gYXNrICJBcmUgd2UgT0sgd2l0aCB0aGUg
ZXhwbGFuYXRpb24/ICBJZiBzbywgSSdsbApzZW5kIGEgcGF0Y2ggd2l0aCB1cGRhdGVkIGNoYW5n
ZWxvZy4iICBUaGF0IGZvcmNlcyBhbiBleHRyYQpyb3VuZC10cmlwLiAgU2ltcGx5IHBvc3QgYSBu
ZXcgdmVyc2lvbiB3aXRoIHlvdXIgcHJvcG9zZWQgdXBkYXRlLiAgSWYKTG9yZW56byBoYXMgbW9y
ZSBxdWVzdGlvbnMsIGhlJ2xsIHNheSBzbyBhbmQgeW91IGNhbiBkbyBhbm90aGVyCnZlcnNpb24u
CgoyKSBXaGVuIExvcmVuem8gaXMgYXNraW5nIGZvciBjbGFyaWZpY2F0aW9uLCBoZSdzIG5vdCBy
ZWFsbHkgYXNraW5nCmZvciB0aGUgY2xhcmlmaWNhdGlvbiBpbiBhbiBlbWFpbCByZXNwb25zZSwg
YmVjYXVzZSB0aGUgZW1haWwgdGhyZWFkCndpbGwgc29vbiBiZSBmb3Jnb3R0ZW4gYW5kIGxvc3Qg
aW4gdGhlIGFyY2hpdmVzLiAgV2hhdCB3ZSByZWFsbHkgd2FudAppcyBmb3IgdGhlIHBlcm1hbmVu
dCBnaXQgY2hhbmdlbG9nIHRvIG1ha2Ugc2Vuc2UgdG8gc29tZW9uZSBpbiB0aGUKZnV0dXJlLiAg
VGhlIGVhc2llc3Qgd2F5IGlzIHRvIHBvc3QgYSBuZXcgcGF0Y2ggdmVyc2lvbiB3aXRoIGEKcmV2
aXNlZCBjaGFuZ2Vsb2cgdGhhdCBhbnN3ZXJzIHRoZSBxdWVzdGlvbnMuCgozKSBQbGVhc2UgY2Fw
aXRhbGl6ZSBhbmQgcHVuY3R1YXRlIGNvbnNpc3RlbnRseSB3aXRoIHByZXZpb3VzIGhpc3Rvcnks
CmUuZy4sICJQQ0k6IGh2OiBGaXggZG9tYWluIElEIGNvcnJ1cHRpb24iIGZvciB5b3VyIHRpdGxl
LCAiU1ItSU9WIgoobm90ICJTUklPViIpIGFuZCAiYnVzIiAobm90ICJCVVMiKSBpbiBjaGFuZ2Vs
b2cuICBCb3RoICJwYXJhLXZpcnR1YWwiCmFuZCAicGFyYXZpcnR1YWwiIGFyZSB1c2VkIGluIHRo
ZSBrZXJuZWwsIGJ1dCAicGFyYXZpcnR1YWwiIGlzIG11Y2gKbW9yZSBjb21tb24uICBSdW4gImdp
dCBsb2ciIGFuZCAiZ2l0IGxvZyAtLW9uZWxpbmUiIG9uIHlvdXIgZmlsZSBhbmQKZm9sbG93IHRo
ZSBzYW1lIHN0eWxlLgoKNCkgV2hlbiB5b3UgcmVmZXJlbmNlIGEgcHJldmlvdXMgY29tbWl0LCBw
bGVhc2UgdXNlIHRoaXMgc3R5bGU6CjBjMTk1NTY3YThmNiAoIm5ldHZzYzogdHJhbnNwYXJlbnQg
VkYgbWFuYWdlbWVudCIpLCBpLmUuLCAxMi1jaGFyIFNIQTEKZm9sbG93ZWQgYnkgdGl0bGUuICBZ
b3Ugc2VlbSB0byBoYXZlIHJlbW92ZWQgc29tZSBzcGFjZXMgZnJvbSB0aGUKY29tbWl0IHlvdSBt
ZW50aW9uIGluIHRoZSAiRml4ZXMiIHRhZy4KCkFuZCBhIGZldyBjb250ZW50IHF1ZXN0aW9ucy9v
YnNlcnZhdGlvbnMgb2YgbXkgb3duOgoKMSkgIkZpeCBkb21haW4gSUQgY29ycnVwdGlvbiIgaXNu
J3QgYSB2ZXJ5IGdvb2QgdGl0bGUgYmVjYXVzZSBpdApzdWdnZXN0cyB5b3UncmUgZml4aW5nIGEg
bWVtb3J5IGNvcnJ1cHRpb24gb3Igc2ltaWxhciBkZWZlY3QuICBCdXQgaW4KZmFjdCwgSSB0aGlu
ayB5b3UncmUgcmVtb3Zpbmcgc29tZXRoaW5nIHRoYXQgdXNlZCB0byBiZSBhIGZlYXR1cmUKKGFk
ZGVkIGJ5IDRhOWIwOTMzYmRmYyAoIlBDSTogaHY6IFVzZSBkZXZpY2Ugc2VyaWFsIG51bWJlciBh
cyBQQ0kKZG9tYWluIikpIGJ1dCBpcyBub3cgbm8gbG9uZ2VyIG5lZWRlZCBhbmQgaW4gZmFjdCBu
b3cgY2F1c2VzIGEKcHJvYmxlbS4KCjIpIFlvdXIgY2hhbmdlbG9nIGRvZXMgbWVudGlvbiA0YTli
MDkzM2JkZmMsIHdoaWNoIGlzIGdvb2QsIGJ1dAp0aGVyZSBtdXN0IGJlIHNvbWUgb3RoZXIgPGNv
bW1pdCBYPiB0aGF0IG1ha2VzIGl0IHNhZmUgdG8gcmVtb3ZlCjRhOWIwOTMzYmRmYywgaS5lLiwg
PGNvbW1pdCBYPiByZW1vdmVzIHRoZSBuZWVkIGZvciB1c2luZyB0aGUgZGV2aWNlCnNlcmlhbCBu
dW1iZXIgYXMgdGhlIFBDSSBkb21haW4uICA8Q29tbWl0IFg+ICptdXN0KiBiZSBtZW50aW9uZWQg
aW4KdGhlIGNoYW5nZWxvZy4gIE90aGVyd2lzZSwgcGVvcGxlIG1heSBiYWNrcG9ydCB0aGlzIHBh
dGNoIHRvIGEga2VybmVsCnRoYXQgZG9lc24ndCBpbmNsdWRlIDxjb21taXQgWD4sIGFuZCB0aGlu
Z3Mgd2lsbCBicmVhay4KCjMpIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGJ5ICJ0
cmFuc3BhcmVudCBTUi1JT1YgbW9kZSIuICBJcwp0aGF0IHNvbWV0aGluZyBkaWZmZXJlbnQgdGhh
biByZWd1bGFyIFNSLUlPVj8gIElmIHNvLCB3aGF0IGV4YWN0bHkgaXMKdGhlIGRpZmZlcmVuY2U/
ICBJIGRvbid0IHRoaW5rIHRoZSBQQ0llIHNwZWNzIG1lbnRpb24gYSAidHJhbnNwYXJlbnQKbW9k
ZSIsIHNvIGlzIGl0IGEgSHlwZXItViB0aGluZz8gIEl0IHNlZW1zIGltcG9ydGFudCwgYnV0IEkg
ZG9uJ3Qgc2VlCmFueSBwY2ktaHlwZXJ2LmMgY29tbWl0cyB0aGF0IG1lbnRpb24gaXQuCgpIZXJl
J3MgYSBzdGFiIGF0IHRoZSBzb3J0IG9mIGNoYW5nZWxvZyBJIHdvdWxkIGJlIGxvb2tpbmcgZm9y
LgpPYnZpb3VzbHkgSSBkb24ndCB1bmRlcnN0YW5kIG11Y2ggYWJvdXQgSHlwZXItViBhbmQgcGNp
LWh5cGVydi5jLCBzbwpwbGVhc2UgY29ycmVjdCB0aGUgdGhpbmdzIEkgZ290IHdyb25nOgoKICBX
aGVuIExpbnV4IHJ1bnMgYXMgYSBndWVzdCBpbiBhIEh5cGVyLVYgVk0sIHBjaS1oeXBlcnYuYwog
IHBhcmF2aXJ0dWFsaXplcyBhY2Nlc3MgdG8gUENJIGRldmljZXMgYXNzaWduZWQgdG8gdGhlIGd1
ZXN0LiAgRm9yCiAgZWFjaCBvZiB0aG9zZSBkZXZpY2VzLCBodl9wY2lfcHJvYmUoKSBjcmVhdGVz
IGEgdmlydHVhbCBQQ0kgYnVzIGluCiAgaXRzIG93biB1bmlxdWUgUENJIGRvbWFpbi4KCiAgNGE5
YjA5MzNiZGZjICgiUENJOiBodjogVXNlIGRldmljZSBzZXJpYWwgbnVtYmVyIGFzIFBDSSBkb21h
aW4iKQogIG92ZXJyb2RlIHRoYXQgdW5pcXVlIFBDSSBkb21haW4gdG8gYmUgdGhlIEh5cGVyLVYg
ZGV2aWNlIHNlcmlhbAogIG51bWJlciB0byBtYWtlIGRldmljZSBuYW1lcyBtb3JlIGNvbnZlbmll
bnQgPG9yIHdoYXRldmVyIHRoZSByZWFsCiAgcmVhc29uIGlzOyBJIGRvbid0IHF1aXRlIHVuZGVy
c3RhbmQgdGhpcyBwYXJ0Pi4KCiAgT25lIHByb2JsZW0gd2l0aCA0YTliMDkzM2JkZmMgaXMgdGhh
dCB0aGUgSHlwZXItViBkZXZpY2Ugc2VyaWFsCiAgbnVtYmVyIGlzIG5vdCBuZWNlc3NhcmlseSB1
bmlxdWUsIHNvIHdlIG1heSBlbmQgdXAgd2l0aCB0d28gYnVzZXMKICB3aXRoIHRoZSBzYW1lIGRv
bWFpbiBhbmQgYnVzIG51bWJlciwgYW5kIGFkZGluZyB0aGUgc2Vjb25kIGJ1cwogIGZhaWxzLgoK
ICBXZSBubyBsb25nZXIgbmVlZCB0byBvdmVycmlkZSB0aGUgUENJIGRvbWFpbiBudW1iZXJzIGJl
Y2F1c2UgPGNvbW1pdAogIFg+IHJlbW92ZWQgdGhlIG5lZWQgZm9yIHRoYXQuCgogIFJldmVydCA0
YTliMDkzM2JkZmMgKCJQQ0k6IGh2OiBVc2UgZGV2aWNlIHNlcmlhbCBudW1iZXIgYXMgUENJCiAg
ZG9tYWluIikgc28gd2UgY2FuIHJlbGlhYmx5IHN1cHBvcnQgbXVsdGlwbGUgZGV2aWNlcyBiZWlu
ZyBhc3NpZ25lZAogIHRvIGEgZ3Vlc3QuCgogIFRoaXMgcmV2ZXJ0IHNob3VsZCBvbmx5IGJlIGJh
Y2twb3J0ZWQgdG8ga2VybmVscyB0aGF0IGNvbnRhaW4KICA8Y29tbWl0IFg+LgoKQmpvcm4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51
eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
