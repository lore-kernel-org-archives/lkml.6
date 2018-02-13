Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3419167-1518507760-2-16048126097873484535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518507759; b=kCMizHeGaosE+C/gaQNRHkz3nFjLvZcZJ1Ho+nLFbG5X8nZ
    3TraxAZRrbgrE6xoMs6/kEu26C03lGvN1Hi9KwKdrkSBJOEDgyINBMDBAC+3ZUjX
    xvsh3O6idU8sIZW1BHIC06TeHbY5QpyAMvwkfa+uCsSAD7GZ09tPNIglJLZdOY07
    MAoXl6JQQ/rTRNphEC29z39xPplhHlHSAjUqo6xxL02PlcKQudLGKpaHP51Mqzcc
    BvKn0FhrhjGwxBuC0mLxCbRd8EjQRZprPQFiLbHXSB5vdh+0+EtERvuejYdpuM6T
    vZCGFyZi6gLqEvOkORYfYdYaUmdaQzTVoXUeiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518507759; bh=G
    hrgX4XPxalc7ED0MEosHW73I2KY7o2jTLs5g+mYq2E=; b=TQyEdpThBxlDKseWY
    wuc3wuU++/viNFsaW51y9X5h9RzyFYbiOMyeAw1kgSmfbJCzagy87W3lYyDwJD6T
    KZ/8tKjYUdc3hfw3E9OFqKCgSrX2WBYaJ77pLoe+YsOxVzICU9wUJHHII2OlCtQy
    gA8mPMLDxgiUbuj4LjcojOMhEHgWZ69nl15KX/+tAakHAjeS4aqmRfRx4NvYycva
    lO4Q+wwI9jLgCTCMmue+Q0ODu8Blma4F0Ja3EpKMccYr9KOOAwuIG+Sc9NtQOmPv
    KXtYgpGPXK3bTNDa7siDMSZ1pWHucy7cr85E/xhFgvzHpb0bmj0bNyqNIZo2srYN
    kuuuQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=RuZZZf9J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Fv9RMigM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=RuZZZf9J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Fv9RMigM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226PPtuleIf/jzYtWOgvJWDbnIfxXPIBlanXK2uHJANudx32r4mV+NpSJ7tAvgdDSvPCVUcdrVK/f4BB+bUkzV4=
MIME-Version: 1.0
In-Reply-To: <20180212183125.GR30522@ZenIV.linux.org.uk>
References: <001a113f65b6d93e74056505e572@google.com>
 <CACT4Y+ZcXVrPAFrxfAohQ=PdqcN8fwrFq4ZGwzP-K_sSUEOY8A@mail.gmail.com>
 <CAHRSSEw7xrtANf2t4bUqMuz83MOo4s9+oGcDqSS7QpMoW7XGJQ@mail.gmail.com>
 <CACT4Y+bPoOWqCfz-jx13Vs+KVnrV2V6nn-nFDzjP=WgWYN1CWw@mail.gmail.com>
 <20180212183125.GR30522@ZenIV.linux.org.uk>
From: Martijn Coenen <maco@android.com>
Date: Tue, 13 Feb 2018 08:42:29 +0100
Message-ID: <CAB0TPYHGN9qLdKp1kiHqPp99TRs-WywHGHSyNAfoKvbhh2J_CA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in remove_wait_queue
To: Al Viro <viro@zeniv.linux.org.uk>
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
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 linux-fsdevel@vger.kernel.org,
 syzbot <syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 7:31 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Any chance of bisecting it?

Perhaps my fix introduced another (related) problem, I'm looking into it.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
