Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1014489-1524076648-2-17503978316765554538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524076647; b=c7ehskUKixP1b583Wp75Rp/OdHpGVRSkY/AonM69kqUEcR/sEm
    XWz5AL4cCGDrqA9zcOchljdm0PLv9uGt4PBsXbE46KvOZRlquPINrhXaZPtPpPIY
    sXklvFJH3O7+T1BnrK6M184ARlkFJg3I5urai8C+lER1i8654mbe32nH8A8L+9Mo
    pBlvQfswfb/0cp0sBvQn6xrVPlvAGnEwkSq4YNxPKMLalM2ONlCs4Jx4CBPrlJvb
    0dvL+LKsGggeqDs2/wWgj/ZBXem1FK4IlI5c931tghlUSJ0h5BOv97jDT7yOHJMr
    VUpiAx6DzUp0Bk5CVsAes7OQXzx9OAbg/neg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524076647; bh=x6v8t
    sO0oX7y1+43BgGZ1PTQhpZXg1cv0Tmydy60b3A=; b=odmCUEQ3mRFA5iUd4Qici
    HlPz3PLi6XAztLZVmBg6OlaiNTPZfh//MExAZdHWX2ROQIiTI06kQ4zG7Uvu2Ltm
    blUkgMRuUor/yObG2WPKOdWsphN9T8liNl19Kf8ccqNBf2cCZTfV3TB/iC9AVCMJ
    yqN+MkMIPhQRuCIGHZxSbKHALykxgHUGcHjsjpbuFFMD84/1wlDepXIzKCI5CXi/
    EdxpXg1C8yLhF5USS2jqXgTt37BrirX0lX1CiqS8Kav0nMf6UXK5S8kyU5BLpAj2
    odMCykSNTE7GB22NpcF1QkB+SP8M+wZZxBREx1QBrSL+nE3+eD0eyCiDkFRnWD3/
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T1/KXqWG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B6Zbj6/q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eeezD7y9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T1/KXqWG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B6Zbj6/q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eeezD7y9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOf8GZ8uhK0fR91/yNHqz50usPPv3GaO4dDuL5CehAcXLXuXivn8azFd6eqlEDPmojOOoCFMY/R9dhtlcmv1GA07EgwWrVVdHd+RvoRxp9FWBKSUiSKx
    R1RUarI9TPNE2Ranhr8g9NRgUvp9coYJOtMV74EdzaayToSxC0o1cNkqWXO1+3w1Bv1fbqAxqP0TUIhErm4oFIzTX/Gu+uyvRZYKUTt5ham+Hl0+P25Qr6U+
    4NIL+C+nrAwZQg7wRMpdmA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=edaUdiry3KTi0doYCV8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+w8gj93ZW3rdNNRuUHCaKWZYuV+ecL1JyWN8p+YX0GP7kMguc0A+Gca+BkefHBKCFIyPrJSHddsYzAZWHtWbg=
MIME-Version: 1.0
In-Reply-To: <20180418134058.l3orjjxcpv7cxjfw@wfg-t540p.sh.intel.com>
References: <20180418133831.uef7d77ejdyjtxgh@wfg-t540p.sh.intel.com>
 <20180418134058.l3orjjxcpv7cxjfw@wfg-t540p.sh.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Apr 2018 11:37:21 -0700
X-Google-Sender-Auth: ZdWqAaQ1-FxhcHMgDhaLQK-J6VA
Message-ID: <CA+55aFz=VCq6w=kH5aYavOM0-h130HgzVhVc94JxeYSdbMWbxg@mail.gmail.com>
Subject: Re: [cfs_trace_lock_tcd] BUG: KASAN: null-ptr-deref in
 cfs_trace_lock_tcd+0x25/0xeb
To: Fengguang Wu <fengguang.wu@intel.com>, NeilBrown <neilb@suse.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>
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
Cc: Staging subsystem List <devel@driverdev.osuosl.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Denis Petrovic <denis.petrovic@edu.ece.fr>, LKP <lkp@01.org>,
 Andreas Dilger <andreas.dilger@intel.com>, lustre-devel@lists.lustre.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ugh, that lustre code is disgusting.

I thought we were getting rid of it.

Anyway, I started looking at why the stack trace is such an incredible
mess, with lots of stale entries.

The reason (well, _one_ reason) seems to be "ksocknal_startup". It has
a 500-byte stack frame for some incomprehensible reason. I assume due
to excessive inlining, because the function itself doesn't seem to be
that bad.

Similarly, LNetNIInit has a 300-byte stack frame. So it gets pretty deep.

I'm getting the feeling that KASAN is making things worse because
probably it's disabling all the sane stack frame stuff (ie no merging
of stack slot entries, perhaps?).

Without KASAN (but also without a lot of other things, so I might be
blaming KASAN incorrectly), the stack usage of ksocknal_startup() is
just under 100 bytes, so if it is KASAN, it's really a big difference.

Anyway, apart from the excessive elements, the report seems fine, but
I'm adding Neil Brown to the cc, since he's the one that has been
making most of the lustre/lnet changes this merge window.

Also adding Andrey to check about the oddly large stack usage.

Not including the whole email with the attachements - Neil, it's on
lkml and lustre-devel if you hadn't seen it.

                Linus
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
