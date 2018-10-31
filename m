Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4F1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3096820657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wYpLUu5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3096820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbeKAEGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:06:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42784 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeKAEGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WadHYzkthM+IYYIWuQM7npCV+TPl0MTPmKlc7dqjfZQ=; b=wYpLUu5b3X3i6hARNDkWY4DxPd
        qgyS9OODC4B0Ik2PkvaEQUiVIMlyjlibSdfkl68bjuhBLjCQmu00MeUlULa9yP3fWSDaa7Vj8y/gt
        zCSXFm/rKMIKI7/qNDrE6j//ILXGm6rjET5Nij5tPr83nt61wIrRrXSMwaFXkieiPi5QLKHOZzSpg
        D/ESHiPgY+YHPOMsR5DeU+oS21HreK8Nn+TSqIDD/wn0M3vWAN7j2t6DvJVNnaH3y1GRcH8Hk0Qo0
        pJwOQG6jBx0qkFzaycXgxK4Mdl4FxhA8a97PxJsXzv5UwBr3xNHb0XzLql044kC/1a16Hxvdz1HZt
        TrrMZ8hA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHvpo-0006Nn-UV; Wed, 31 Oct 2018 19:07:21 +0000
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
To:     Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181031145907.1ee2e866@canb.auug.org.au>
 <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <560c85c8-1ee2-31b0-3148-a08f56a25a2e@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dab59782-26d4-9b7e-2537-a1d8e578b2d9@infradead.org>
Date:   Wed, 31 Oct 2018 12:06:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <560c85c8-1ee2-31b0-3148-a08f56a25a2e@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMzEvMTggOTo1MCBBTSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gSGksDQo+IA0K
PiBPbiAzMS0xMC0xOCAxNjo1MSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPj4gT24gMTAvMzAv
MTggODo1OSBQTSwgU3RlcGhlbiBSb3Rod2VsbCB3cm90ZToNCj4+PiBIaSBhbGwsDQo+Pj4N
Cj4+PiBQbGVhc2UgZG8gbm90IGFkZCBhbnkgdjQuMjEvdjUuMSBjb2RlIHRvIHlvdXIgbGlu
dXgtbmV4dCBpbmNsdWRlZCB0cmVlcw0KPj4+IHVudGlsIGFmdGVyIHRoZSBtZXJnZSB3aW5k
b3cgY2xvc2VzLg0KPj4+DQo+Pj4gQ2hhbmdlcyBzaW5jZSAyMDE4MTAzMDoNCj4+Pg0KPj4N
Cj4+DQo+PiBvbiBpMzg2Og0KPj4NCj4+IGxkOiBkcml2ZXJzL3ZpcnQvdmJveGd1ZXN0L3Zi
b3hndWVzdF9jb3JlLm86IGluIGZ1bmN0aW9uIGB2YmdfaW9jdGxfaGdjbV9jYWxsJzoNCj4+
IHZib3hndWVzdF9jb3JlLmM6KC50ZXh0KzB4MjEyYik6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYHZiZ19oZ2NtX2NhbGwzMicNCj4gDQo+IEFyZSB5b3UgcGVyaGFwcyB1c2luZyB3ZWly
ZCBjb21waWxlciBvcHRpb25zPw0KDQpOb3BlLCBqdXN0IHdoYXRldmVyIGtidWlsZCBnaXZl
cyBtZS4NCg0KSSBjb3VsZCBzdXNwZWN0IGdjYyB2NC44LjUsIGFsdGhvdWdoIEkgaGF2ZSBi
ZWVuIHVzaW5nIGl0IGZvciBxdWl0ZQ0KYXdoaWxlIG5vdy4NCg0KPiBUaGlzIGNhbGwgc2hv
dWxkIGJlIG9wdGltaXplZCBvdXQgb24gaTM4NiAoYW5kIHdlIHJlbHkgb24gY2FsbHMgYmVp
bmcNCj4gcmVtb3ZlZCBiZSBkZWFkIGNvZGUgZWxpbWluYXRpb24gdG8gYXZvaWQgI2lmZGVm
cyBpbiB2YXJpb3VzIHBsYWNlcywNCj4gaW93IHRoaXMgaXMgYSBub3JtYWwgdGhpbmcgdG8g
cmVseSBvbikgOg0KPiANCj4gRmlyc3Qgd2UgaGF2ZToNCj4gDQo+IKCgoKBib29sIGYzMmJp
dCA9IGZhbHNlOw0KPiANCj4gLi4uDQo+IA0KPiCgoKCgoKCgIHN3aXRjaCAocmVxX25vX3Np
emUpIHsNCj4gI2lmZGVmIENPTkZJR19DT01QQVQNCj4goKCgoKCgoCBjYXNlIFZCR19JT0NU
TF9IR0NNX0NBTExfMzIoMCk6DQo+IKCgoKCgoKCgoKCgoKCgoCBmMzJiaXQgPSB0cnVlOw0K
PiCgoKCgoKCgoKCgoKCgoKAgLyogRmFsbCB0aHJvdWdoICovDQo+ICNlbmRpZg0KPiCgoKCg
oKCgIGNhc2UgVkJHX0lPQ1RMX0hHQ01fQ0FMTCgwKToNCj4goKCgoKCgoKCgoKCgoKCgIHJl
dHVybiB2YmdfaW9jdGxfaGdjbV9jYWxsKGdkZXYsIHNlc3Npb24sIGYzMmJpdCwgZGF0YSk7
DQo+IKCgoKB9DQo+IA0KPiBBbmQgdGhlbiB3ZSBhbHNvIGhhdmU6DQo+IA0KPiBzdGF0aWMg
aW50IHZiZ19pb2N0bF9oZ2NtX2NhbGwoc3RydWN0IHZiZ19kZXYgKmdkZXYsDQo+IKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBzdHJ1Y3QgdmJnX3Nlc3Npb24gKnNlc3Npb24s
IGJvb2wgZjMyYml0LA0KPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgc3RydWN0
IHZiZ19pb2N0bF9oZ2NtX2NhbGwgKmNhbGwpDQo+IHsNCj4goKCgoC4uLg0KPiANCj4goKCg
oKCgoCBpZiAoZjMyYml0KQ0KPiCgoKCgoKCgoKCgoKCgoKAgcmV0ID0gdmJnX2hnY21fY2Fs
bDMyKGdkZXYsIGNsaWVudF9pZCwNCj4goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCBjYWxsLT5mdW5jdGlvbiwgY2FsbC0+dGltZW91dF9tcywNCj4goKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBWQkdfSU9DVExfSEdDTV9DQUxMX1BBUk1T
MzIoY2FsbCksDQo+IKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgY2Fs
bC0+cGFybV9jb3VudCwgJmNhbGwtPmhkci5yYyk7DQo+IKCgoKCgoKAgZWxzZQ0KPiCgoKCg
oKCgoKCgoKCgoKAgcmV0ID0gdmJnX2hnY21fY2FsbChnZGV2LCBjbGllbnRfaWQsDQo+IKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIGNhbGwtPmZ1bmN0aW9uLCBjYWxs
LT50aW1lb3V0X21zLA0KPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBW
QkdfSU9DVExfSEdDTV9DQUxMX1BBUk1TKGNhbGwpLA0KPiCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCBjYWxsLT5wYXJtX2NvdW50LCAmY2FsbC0+aGRyLnJjKTsNCj4g
fQ0KPiANCj4gU28gb24gaTM4NiBDT05GSUdfQ09NUEFUIGlzIG5ldmVyIHNldCwgdGhpcyBm
MzJiaXQgaXMgYSAwIGNvbnN0DQo+IGFuZCB0aGUgY29tcGlsZXIgcmVtb3ZlcyB0aGUgaWYg
YnJhbmNoIG9mIHRoZSBpZiAuLi4gZWxzZSAuLi4NCj4gDQo+IFRoaXMgaGFzIGJlZW4gdXBz
dHJlYW0gbGlrZSB0aGlzIHNpbmNlIDQuMTYgd2l0aG91dCBhbnkgcHJvYmxlbXMgc29mYXIu
DQoNClRoYXQncyBuaWNlLg0KDQpIZXJlJ3Mgd2hhdCBidWlsZGluZyB3aXRoIFY9MSB0ZWxs
cyBtZSBmb3IgdmJveGd1ZXN0X2NvcmUuYzoNCg0KICBnY2MgLVdwLC1NRCxkcml2ZXJzL3Zp
cnQvdmJveGd1ZXN0Ly52Ym94Z3Vlc3RfY29yZS5vLmQgIC1ub3N0ZGluYyAtaXN5c3RlbSAv
dXNyL2xpYjY0L2djYy94ODZfNjQtc3VzZS1saW51eC80LjgvaW5jbHVkZSAtSS4uL2FyY2gv
eDg2L2luY2x1ZGUgLUkuL2FyY2gveDg2L2luY2x1ZGUvZ2VuZXJhdGVkICAtSS4uL2luY2x1
ZGUgLUkuL2luY2x1ZGUgLUkuLi9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkgLUkuL2FyY2gveDg2
L2luY2x1ZGUvZ2VuZXJhdGVkL3VhcGkgLUkuLi9pbmNsdWRlL3VhcGkgLUkuL2luY2x1ZGUv
Z2VuZXJhdGVkL3VhcGkgLWluY2x1ZGUgLi4vaW5jbHVkZS9saW51eC9rY29uZmlnLmggLWlu
Y2x1ZGUgLi4vaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5oICAtSS4uL2RyaXZlcnMv
dmlydC92Ym94Z3Vlc3QgLUlkcml2ZXJzL3ZpcnQvdmJveGd1ZXN0IC1EX19LRVJORUxfXyAt
V2FsbCAtV3VuZGVmIC1Xc3RyaWN0LXByb3RvdHlwZXMgLVduby10cmlncmFwaHMgLWZuby1z
dHJpY3QtYWxpYXNpbmcgLWZuby1jb21tb24gLWZzaG9ydC13Y2hhciAtV2Vycm9yLWltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uIC1Xbm8tZm9ybWF0LXNlY3VyaXR5IC1zdGQ9Z251
ODkgLWZuby1QSUUgLURDQ19IQVZFX0FTTV9HT1RPIC1tbm8tc3NlIC1tbm8tbW14IC1tbm8t
c3NlMiAtbW5vLTNkbm93IC1tbm8tYXZ4IC1tMzIgLW1zb2Z0LWZsb2F0IC1tcmVncGFybT0z
IC1mcmVnLXN0cnVjdC1yZXR1cm4gLWZuby1waWMgLW1wcmVmZXJyZWQtc3RhY2stYm91bmRh
cnk9MiAtbWFyY2g9aTU4NiAtV2EsLW10dW5lPWdlbmVyaWMzMiAtZmZyZWVzdGFuZGluZyAt
bWFjY3VtdWxhdGUtb3V0Z29pbmctYXJncyAtRENPTkZJR19BU19DRkk9MSAtRENPTkZJR19B
U19DRklfU0lHTkFMX0ZSQU1FPTEgLURDT05GSUdfQVNfQ0ZJX1NFQ1RJT05TPTEgLURDT05G
SUdfQVNfU1NTRTM9MSAtRENPTkZJR19BU19BVlg9MSAtRENPTkZJR19BU19BVlgyPTEgLURD
T05GSUdfQVNfQVZYNTEyPTEgLURDT05GSUdfQVNfU0hBMV9OST0xIC1EQ09ORklHX0FTX1NI
QTI1Nl9OST0xIC1waXBlIC1Xbm8tc2lnbi1jb21wYXJlIC1mbm8tYXN5bmNocm9ub3VzLXVu
d2luZC10YWJsZXMgLVdhLGFyY2gveDg2L2tlcm5lbC9tYWNyb3MucyAtV2EsLSAtZm5vLWRl
bGV0ZS1udWxsLXBvaW50ZXItY2hlY2tzIC1PZyAtV25vLW1heWJlLXVuaW5pdGlhbGl6ZWQg
LVduby1tYXliZS11bmluaXRpYWxpemVkIC0tcGFyYW09YWxsb3ctc3RvcmUtZGF0YS1yYWNl
cz0wIC1mbm8tcmVvcmRlci1ibG9ja3MgLWZuby1pcGEtY3AtY2xvbmUgLWZuby1wYXJ0aWFs
LWlubGluaW5nIC1XZnJhbWUtbGFyZ2VyLXRoYW49MTAyNCAtZm5vLXN0YWNrLXByb3RlY3Rv
ciAtV25vLXVudXNlZC1idXQtc2V0LXZhcmlhYmxlIC1mbm8tb21pdC1mcmFtZS1wb2ludGVy
IC1mbm8tb3B0aW1pemUtc2libGluZy1jYWxscyAtZm5vLXZhci10cmFja2luZy1hc3NpZ25t
ZW50cyAtZm5vLWlubGluZS1mdW5jdGlvbnMgLWZuby1pbmxpbmUtc21hbGwtZnVuY3Rpb25z
IC1mbm8taW5saW5lLWZ1bmN0aW9ucy1jYWxsZWQtb25jZSAtcGcgLWZuby1pbmxpbmUtZnVu
Y3Rpb25zLWNhbGxlZC1vbmNlIC1XZGVjbGFyYXRpb24tYWZ0ZXItc3RhdGVtZW50IC1Xdmxh
IC1Xbm8tcG9pbnRlci1zaWduIC1mbm8tc3RyaWN0LW92ZXJmbG93IC1mbm8tbWVyZ2UtYWxs
LWNvbnN0YW50cyAtZm1lcmdlLWNvbnN0YW50cyAtZm5vLXN0YWNrLWNoZWNrIC1mY29uc2Vy
dmUtc3RhY2sgLVdlcnJvcj1pbXBsaWNpdC1pbnQgLVdlcnJvcj1zdHJpY3QtcHJvdG90eXBl
cyAgICAtREtCVUlMRF9CQVNFTkFNRT0nInZib3hndWVzdF9jb3JlIicgLURLQlVJTERfTU9E
TkFNRT0nInZib3hndWVzdCInIC1jIC1vIGRyaXZlcnMvdmlydC92Ym94Z3Vlc3QvLnRtcF92
Ym94Z3Vlc3RfY29yZS5vIC4uL2RyaXZlcnMvdmlydC92Ym94Z3Vlc3QvdmJveGd1ZXN0X2Nv
cmUuYw0KDQoNCnRoYW5rcy4NCi0tIA0KflJhbmR5DQo=
