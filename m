Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2039553-1518460301-2-9958710729074361365
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='uk', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518460301; b=PFqXFu5+SIedlFMpq6Vyhxnxo1csMUOsWSfaW0s/DCFS5H2
    Sf9wkMOlFuv/Nx5+PWznJrBhY/ZFeMKEsawXtK1NWUJhE9poa5aZq1l3Vc0vrZw5
    r2/T2Cnm7OXlzBX50G0B4UyRV6HFgeWQFEo4BhiNO3pbCSl156AmXMllQc0lFBxa
    p/KfAqDTn3ftCWzuQL/beXWPzK4tvtdOFykuQiSd+o1GFAsKZrhjh15aQmqCNY2w
    TW7D8UsVP4vv4xr0plZ26Xg6l/2+0Upf05Xo+ILfy24056AYYPLNAkUEh17k+YWN
    PZgZ0Xsztt6Y7e07wMsWPI53ejWWOrcaImcbyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518460301; bh=3
    hNWlu0eKbakAkghFthLDo0SemonzMKh8VIjnwhCZgM=; b=Ap0uDtEofDQT29Mw9
    MOYyuZaTfxi0NLD7Xl6Vg3BPokJ1vI0mzp0msSEhjWIW2oS3R3NnkJQQ3PRdV4cG
    71nlbaZRk+0zxqE+CoaNXYbH2Y8E7mdqjgY6OZuyuxQk2+KXF8dr8n/U+GDMl5wV
    dZsvfFNdpL+Gu+69ZBUF+N9Po9vQ8YcwtqnRkBL1jeIulTreAtNnElDMyrttfupr
    L7EOp/RE7NI8tRXIUKY3nr0CMypCz/t1ZNVFRDjkEuZONgsrp+AgJTLliHh8T0E8
    T8B8eaLV4cbtux2Z+TyFfEPawW3aGEMz/FafNjwRZ6OzqCiUlE/VQgOcztmfhq15
    5H2Jw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Feb 2018 18:31:25 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: KASAN: use-after-free Read in remove_wait_queue
Message-ID: <20180212183125.GR30522@ZenIV.linux.org.uk>
References: <001a113f65b6d93e74056505e572@google.com>
 <CACT4Y+ZcXVrPAFrxfAohQ=PdqcN8fwrFq4ZGwzP-K_sSUEOY8A@mail.gmail.com>
 <CAHRSSEw7xrtANf2t4bUqMuz83MOo4s9+oGcDqSS7QpMoW7XGJQ@mail.gmail.com>
 <CACT4Y+bPoOWqCfz-jx13Vs+KVnrV2V6nn-nFDzjP=WgWYN1CWw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACT4Y+bPoOWqCfz-jx13Vs+KVnrV2V6nn-nFDzjP=WgWYN1CWw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
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
Cc: "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Todd Kjos <tkjos@android.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 linux-fsdevel@vger.kernel.org,
 syzbot <syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com>,
 Martijn Coenen <maco@android.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 06:11:02PM +0100, Dmitry Vyukov wrote:

> The commit on which it was triggered already includes this fix. So
> there must be another bug.

Any chance of bisecting it?
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
