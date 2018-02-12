Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3993364-1518394008-2-8084128380565649570
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
    t=1518394007; b=QKCFxx/bHx2e0CwgfQcI+dU2G+sNoqpfQIPE8Cn/0OHTz0R
    Z5IHvExrjI3wfBFAgWZLF4ROVo+MuAqVQgLuc3rCOqEviyZhQB7y020EMpuTpwNp
    DxvJid3YXjMYGX68RkIv61ZuQkvpHlVZ7ESC8u17abnMSHMo2yN7VMLvGOfJqd3M
    DsyotJ+xB/G7nC8OyMWehFX8+XMcmryp6jk0s+8pXkHoMoM2eRFGq4oY3QxFRDfy
    PnO+rLniiDJhqK/o5t4hzvP7TJbtWrD2PErUlmhmDBDxPZIDXR/TMHseryaZfLdP
    xxUlSAVxs91chsvkD2p4lB/7tDEL9mxysOCkw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:from:in-reply-to
    :date:message-id:references:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518394007; bh=i
    mobgoGGSgMZ5fS+FQoMEN1QNkLoABj1wuS70Tq/H80=; b=QGFp31IPtL5jvrDlv
    A2AYAh5o+lGhmooGddJMtvkCn48yf/fwl/6rMFUdeMqoCackeBSXo0V/MdkqDkVP
    xNijQeHV3SHNfZCv3tkZUJXfZh21B4fQrMdhFTwrXqN0316dfuwKdyHtPQeBHLtX
    ssXFGJLuyvzAMKw9awhFeBTZ1uyJgbwqwCi/ZrnYkyXwOFz/N0lBv/J0gRGbrRW1
    HXsb+ckrN99v8DAOla4MHdxKl4rPeeWVgKri00p9e9CAh5oA8W+PkG82ner2Sh6f
    ZN6Y28RC/IGeAHgtiNBvsOmOlmO2doFwnSJAU+cq65MxzPvsUB1MTGyM4TT4o96Y
    yTZmA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
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
X-IronPort-AV: E=Sophos;i="5.46,499,1511856000"; d="scan'208";a="17174939"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [lustre-devel] [PATCH 41/80] staging: lustre: lmv: separate
 master object with master stripe
From: Oleg Drokin <oleg.drokin@intel.com>
In-Reply-To: <87eflrrsr7.fsf@notabene.neil.brown.name>
Date: Sun, 11 Feb 2018 19:06:30 -0500
Message-Id: <3E2C6545-B1F2-46AD-8539-A3F65DBE5EF9@intel.com>
References: <1471378773-24590-1-git-send-email-jsimmons@infradead.org>
 <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
 <87r2pvkkl5.fsf@notabene.neil.brown.name>
 <09CE6CEC-52BC-4B29-B609-40DE68A64A33@intel.com>
 <87o9kylux7.fsf@notabene.neil.brown.name>
 <FC7E817D-BA15-4D0A-9976-F1343F9B022A@intel.com>
 <alpine.LFD.2.21.1802102027560.5700@casper.infradead.org>
 <87eflrrsr7.fsf@notabene.neil.brown.name>
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
Cc: "devel@driverdev.osuosl.org SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cj4gT24gRmViIDExLCAyMDE4LCBhdCA2OjUwIFBNLCBOZWlsQnJvd24gPG5laWxiQHN1c2UuY29t
PiB3cm90ZToKPiAKPiBNYXliZSAtIGFzIHlvdSBzdWdnZXN0IGluIGFub3RoZXIgZW1haWwgLSBp
dCBpcyBkdWUgdG8gc29tZQo+IGNsaWVudC9zZXJ2ZXIgaW5jb21wYXRpYmlsaXR5LiAgSSBndWVz
cyBpdCBpcyB1bmF2b2lkYWJsZSB3aXRoIGFuIGZzCj4gbGlrZSBsdXN0cmUgdG8gaGF2ZSBpbmNv
bXBhdGlibGUgcHJvdG9jb2wgY2hhbmdlcy4gIElzIHRoZXJlIGFueQo+IG1lY2hhbmlzbSBmb3Ig
ZGV0ZWN0aW5nIHRoZSB2ZXJzaW9uIG9mIG90aGVyIHBlZXJzIGluIHRoZSBjbHVzdGVyIGFuZAo+
IHJlZnVzaW5nIHRvIHJ1biBpZiB2ZXJzaW9ucyBhcmUgaW5jb21wYXRpYmxlPwoKWWVzLCBjbGll
bnQgYW5kIHNlcnZlciBleGNoYW5nZSDigJxmZWF0dXJlIGJpdHPigJ0gYXQgY29ubmVjdCB0aW1l
CmFuZCBvbmx5IHVzZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmVzIHRoYXQgYm90aCBjYW4gdW5kZXJz
dGFuZC4KCkJ5ZSwKICAgIE9sZWcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5v
cmcKaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpdmVyZGV2LWRldmVsCg==
