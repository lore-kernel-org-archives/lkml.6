Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1586717-1517934717-2-2766359700653065053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517934716; b=wsINZWmRopvDKkVgn3R37tHpO8UYEq89Tibbal6n0cG9jUl
    9VDnn+bBaiKKln3sFUp5AyegOeNYeV0f1ypK9RjQpFrUdqzR1wBSynuVaC2+pVF+
    bcoVjh/6c/julkDXu/7vL7agC9cJPyigFeixyl8mDyd7OkoIPT4aeJw7cyTjpOVr
    7nQAkL3gHmZIBV7TACbLx69IXAv8vvrZnBp3DHmc6p6NIu5PYfd8h6nLol8RLG6h
    igEx4Tx99HrF2X9NftoR1y/ZJ/b11jFXj53wTDiJHTtwvHnoKvq+ry5am98UrYKO
    qK3TKpHctkP5OVf6/k+/meXTYiQmB2DFK62yRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517934716; bh=C
    n4PfcmNAwHsGTSdOzwY6RBQsLXJ8YASNy5WeLrt2x0=; b=ctn337eLAEUL0zasO
    6i1upq8dAvk0N4x4ZOk9nJcQBqrA0+bQaoVpeIWUAUStfL2suqbpx/qfAHRvQhkb
    qgHq9meP3mjBIkPfUQjqVx5ihlUblXg8kni/qFQbYRGonAFwJXIXAjaG8Q816nw4
    4ssKxlvHAOZ7AtgBcbxb2cvIpDgjzNV8dUTu9i3jM/McqYH6bBl1b2O9mOVx7VtJ
    GVUXQARwHAwwtOwjQXGl3ohkTIMVW5CX5kvvIHVK1MeufBh8r5ekB+sM7lweiQ94
    nUDzabApw3NL1JqcUWhy/eiwLV1n3Yy20+Rdq6yGKfTHQxGFVP8dNVlup11iqoeA
    diIjA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=prYFPk+u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O2xUhOSH;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=prYFPk+u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=O2xUhOSH;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225J6LpdXwk3UqYLYcrzeSeLDFSyW7aWj8Xa+H2vygEhUHGRkHpF1nj2NJyd9gItofErLDVwYh83FRIgSwJPbds=
MIME-Version: 1.0
In-Reply-To: <1517933300.2557.81.camel@hadess.net>
References: <1517932633-7832-1-git-send-email-l4stpr0gr4m@gmail.com>
 <1517933300.2557.81.camel@hadess.net>
From: Kangmin Park <l4stpr0gr4m@gmail.com>
Date: Wed, 7 Feb 2018 01:31:48 +0900
Message-ID: <CAKW4uUzDA22u=URAaSvXT_tpEruu6i_R9VuGnX0nbu1OzM4_DA@mail.gmail.com>
Subject: Re: [PATCH] Resolve RF Type mismatch
To: Bastien Nocera <hadess@hadess.net>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, justin@jvreeland.com,
 davem@davemloft.net, hdegoede@redhat.com, joe@perches.com,
 linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Oops, Sorry for being stupid cuz of first time to use git email.
RF_TYPE and ODM_RF_TYPE on staging/rtl8723bs is different from
staging/rtlwifi 's - updated from v 4.14 -
So, I try to update code on staging/rtl8723bs in comparison with
staging/rtlwifi.
commit message is "Update rf_type and odm_rf_type in comparison with
drivers/staging/rtlwifi"

2018-02-07 1:08 GMT+09:00 Bastien Nocera <hadess@hadess.net>:
> On Wed, 2018-02-07 at 00:57 +0900, Kangmin Park wrote:
>> From: pr0gr4m <l4stpr0gr4m@gmail.com>
>
> This needs a commit message. I don't understand what the code is trying
> to do.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
