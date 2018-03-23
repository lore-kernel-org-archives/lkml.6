Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2024708-1521835494-2-11897935866848626966
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521835493; b=R5149bGzmNXIiCncy3AkzCNXoY8GVd/QTZCmclENII7CSbe
    YuX6FveXdkX0yKY8iikubGZNzFtsxPNE2mkFkmoIgYMUb5OqRsgzm74ZMRgMSOox
    0GUoy7wsZgcyILbb9l14FBlwzw+H/diZ7m/F34ELIGvJ958B5Um1iuumm2wep7Uw
    EOShCFDh0QOqQfeja0Msi2G0IwBEuKKra+9DMsHAqaQhe+NwzK24B3eyj+hXc8Ua
    8xanYJ3y8Cur8517/KdhnXYpmPbY8kkgcP3mYqTMmphLdn+prdAwbfwULWhNMjRS
    Gle0ntu/KZ/+S0f6Bdecr2xvWXnLtemZEdvM5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521835493; bh=P
    6E/O+YkS0W5xmfI57F5UmUtH7KheMWsmJOvYe3HkrU=; b=QMJv+vybu8LjB3V5p
    Tt+M/GnVwDGmP4tYTSyP/0d7rg7Zh+GcDeRkhSI9TBlxNU9Yfk1u/ixtPXlTqs/Q
    HxwcFn9Nlk/KMsQKJ46BzHXuSD2HywLlZj0+mK9nYyhA+WMh5p5WFyvS81b6WaL/
    0JB9wJZUTmM+2uo0WFufWuCEwQQcmHjt3N+HrPsIzXXoxBnKq88ug0dGD4d+Yjgn
    lv35EYMK0uc5sTWUekdBmHdaQwow8LYF0G20EBdHnMsOVFPYA+IGpO80Rt10TW4/
    vQ8hhnps16KqMeqxrMhvCWwLFViEIT3pOMx3iM+ovOZUsIoICkdpDREgYoQ5mwZU
    9YgtA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cu3L3TS1;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cu3L3TS1;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuzH/y8Xjr74UK6gAZexiAhdQs41cyUUaD8JzihDxvqO51mpyXBeN7h3//GwrnGx2/AVHfsxA==
MIME-Version: 1.0
In-Reply-To: <201803231411.1XijNmJc%fengguang.wu@intel.com>
References: <1521643299-18231-1-git-send-email-roy.pledge@nxp.com>
 <201803231411.1XijNmJc%fengguang.wu@intel.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 23 Mar 2018 15:04:42 -0500
X-Gmail-Original-Message-ID: <CADRPPNTk0_Odjd8CayS4Q1ROHmpYBkxJ7NusCdRB=KfDshO3OA@mail.gmail.com>
Message-ID: <CADRPPNTk0_Odjd8CayS4Q1ROHmpYBkxJ7NusCdRB=KfDshO3OA@mail.gmail.com>
Subject: Re: [v2] staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
To: Roy Pledge <roy.pledge@nxp.com>
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
Cc: devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, kbuild-all@01.org, stuyoder@gmail.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCBNYXIgMjMsIDIwMTggYXQgMTo0NiBBTSwga2J1aWxkIHRlc3Qgcm9ib3QgPGxrcEBp
bnRlbC5jb20+IHdyb3RlOgo+IEhpIFJveSwKPgo+IEkgbG92ZSB5b3VyIHBhdGNoISBZZXQgc29t
ZXRoaW5nIHRvIGltcHJvdmU6Cj4KPiBbYXV0byBidWlsZCB0ZXN0IEVSUk9SIG9uIHN0YWdpbmcv
c3RhZ2luZy10ZXN0aW5nXQo+IFthbHNvIGJ1aWxkIHRlc3QgRVJST1Igb24gbmV4dC0yMDE4MDMy
Ml0KPiBbY2Fubm90IGFwcGx5IHRvIGxpbnVzL21hc3RlciB2NC4xNi1yYzZdCj4gW2lmIHlvdXIg
cGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIHBsZWFzZSBkcm9wIHVzIGEg
bm90ZSB0byBoZWxwIGltcHJvdmUgdGhlIHN5c3RlbV0KPgo+IHVybDogICAgaHR0cHM6Ly9naXRo
dWIuY29tLzBkYXktY2kvbGludXgvY29tbWl0cy9Sb3ktUGxlZGdlL3N0YWdpbmctZnNsLW1jLU1v
dmUtRFBJTy1mcm9tLXN0YWdpbmctdG8tZHJpdmVycy1zb2MtZnNsLzIwMTgwMzIzLTEwMjMyNQo+
IGNvbmZpZzogYXJtLWFsbG1vZGNvbmZpZyAoYXR0YWNoZWQgYXMgLmNvbmZpZykKPiBjb21waWxl
cjogYXJtLWxpbnV4LWdudWVhYmktZ2NjIChEZWJpYW4gNy4yLjAtMTEpIDcuMi4wCj4gcmVwcm9k
dWNlOgo+ICAgICAgICAgd2dldCBodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaW50
ZWwvbGtwLXRlc3RzL21hc3Rlci9zYmluL21ha2UuY3Jvc3MgLU8gfi9iaW4vbWFrZS5jcm9zcwo+
ICAgICAgICAgY2htb2QgK3ggfi9iaW4vbWFrZS5jcm9zcwo+ICAgICAgICAgIyBzYXZlIHRoZSBh
dHRhY2hlZCAuY29uZmlnIHRvIGxpbnV4IGJ1aWxkIHRyZWUKPiAgICAgICAgIG1ha2UuY3Jvc3Mg
QVJDSD1hcm0KPgo+IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToKPgo+ICAg
IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2NyeXB0by9jYWFtL3NnX3N3X3NlYzQuaDox
NDowLAo+ICAgICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL2NyeXB0by9jYWFtL2NhYW1h
bGcuYzo1NToKPj4+IGRyaXZlcnMvY3J5cHRvL2NhYW0vc2dfc3dfcW0yLmg6Mzg6MTA6IGZhdGFs
IGVycm9yOiAuLi8uLi8uLi9kcml2ZXJzL3N0YWdpbmcvZnNsLW1jL2luY2x1ZGUvZHBhYTItZmQu
aDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQo+ICAgICAjaW5jbHVkZSAiLi4vLi4vLi4vZHJp
dmVycy9zdGFnaW5nL2ZzbC1tYy9pbmNsdWRlL2RwYWEyLWZkLmgiCj4gICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KCkhpIFJv
eSwKCkFzIGNvbXBsYWluZWQgYnkgdGhpcyBhdXRvIGJ1aWxkIGVycm9yLCB3ZSBzaG91bGQgdXBk
YXRlIGFsbCB0aGUKcmVmZXJlbmNlcyB0byB0aGUgbW92ZWQgaGVhZGVyIGZpbGVzLiAgQSBxdWlj
ayBzZWFyY2ggc2hvd3Mgbm90IG9ubHkKdGhlY2FhbSBkcml2ZXIgYnV0IGFsc28gdGhlIGRwYWEy
LWV0aCBkcml2ZXIgbmVlZCB0byBiZSB1cGRhdGVkLgoKUmVnYXJkcywKTGVvCgo+ICAgIGNvbXBp
bGF0aW9uIHRlcm1pbmF0ZWQuCj4KPiB2aW0gKzM4IGRyaXZlcnMvY3J5cHRvL2NhYW0vc2dfc3df
cW0yLmgKPgo+IDI5N2I5Y2ViIEhvcmlhIEdlYW50xIMgMjAxNy0wNy0xOCAgMzcKPiAyOTdiOWNl
YiBIb3JpYSBHZWFudMSDIDIwMTctMDctMTggQDM4ICAjaW5jbHVkZSAiLi4vLi4vLi4vZHJpdmVy
cy9zdGFnaW5nL2ZzbC1tYy9pbmNsdWRlL2RwYWEyLWZkLmgiCj4gMjk3YjljZWIgSG9yaWEgR2Vh
bnTEgyAyMDE3LTA3LTE4ICAzOQo+Cj4gOjo6Ojo6IFRoZSBjb2RlIGF0IGxpbmUgMzggd2FzIGZp
cnN0IGludHJvZHVjZWQgYnkgY29tbWl0Cj4gOjo6Ojo6IDI5N2I5Y2ViZDJmYzAyMGYwYmQzZTBh
YWM2OGIwNzU4YWI4NGU4ZDggY3J5cHRvOiBjYWFtL2pyIC0gYWRkIHN1cHBvcnQgZm9yIERQQUEy
IHBhcnRzCj4KPiA6Ojo6OjogVE86IEhvcmlhIEdlYW50xIMgPGhvcmlhLmdlYW50YUBueHAuY29t
Pgo+IDo6Ojo6OiBDQzogSGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1Pgo+
Cj4gLS0tCj4gMC1EQVkga2VybmVsIHRlc3QgaW5mcmFzdHJ1Y3R1cmUgICAgICAgICAgICAgICAg
T3BlbiBTb3VyY2UgVGVjaG5vbG9neSBDZW50ZXIKPiBodHRwczovL2xpc3RzLjAxLm9yZy9waXBl
cm1haWwva2J1aWxkLWFsbCAgICAgICAgICAgICAgICAgICBJbnRlbCBDb3Jwb3JhdGlvbgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5n
IGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4
ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
