Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3839317-1519560819-2-10969719469989399850
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519560819; b=g82QKSb0aBjEX99yjfRthz05lX/y/N2v0VLY2rlaeY1rrkF
    QpjLZvUVC1Ap2PSP6MplAY2OufBTx5Eop3YRF/FMYZAN9jAomg3axIl/dfjX5vuv
    uvQ4HO2N/8RSgK6QaYrMv7qUKzz2GR08zbO7J8ArkRmK5AgB92Izi4ayh+nGCXr4
    BdczIJao6cvSI5YhEGpX6Fx5yoL66alIEpsCRGHGVoxBhyJBzwOOleHV9+V8Em4N
    RerGmXfon3UJQieCoJchCLByh0v0E1NTDvrvjMYtVYRN9Rjd9k5EqIyuWw6sn1bv
    CVL8kDrWQecYa0Id81643nwTTFdMjnO/zEav4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519560819; bh=6c0uhXjDYPs9iVSZsgjuDI+GZ56wZsChWzBu2k
    dk+ho=; b=oaTKt0bbNgd8TkdcMtxZZKd959OTz0/VCWCPiNU32o1gWl7uyhgy2r
    VwFCwEMOP6BCW1hYULJSZFxUvLNIE9H9Fku7L7lq7asDxW9/B9HFlmk9O1+LTyUU
    SPOgVYT6IqNgwSY5levPCt/iW4YtQ2eimxntkLOAr8cKRhXOEukWYpwvac97WRJ+
    r/EPX9tpacE9USEo41DBNacYeE4Vv9TIsKCHchHvCRQ4TPAFWJt0brJ3UM4U1jMO
    Xvv3GPgc6/qOnJrRkemMMNGNOJM6gScDOkI8GBqo74H22AEH9XS/sQ/Msz76ezh4
    FMoBbgD0HXHlnj6V9s9VoF5anuF25Piw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gMkstAr3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IOqR+ea8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gMkstAr3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IOqR+ea8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeBYMNX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 07:13:23 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36470 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeBYMNW (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 07:13:22 -0500
X-Google-Smtp-Source: AG47ELsoIutOBNnXMpX/Y/bzdYGS+C+8ga8MXfH0eGoFdeTsM/30daiDcdAYJp1CFYdH61QotYs2aX1kzeykzLS7vjw=
MIME-Version: 1.0
In-Reply-To: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 25 Feb 2018 14:13:20 +0200
Message-ID: <CAHp75VdKDFnrk6i9vBZL2YnqeUH3AaxdZJ_f6ZNOUtnq1pjM3Q@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 4:50 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Also, make MFD_SYSCON 'default y' because some defconfig files may
> rely on someone select's MFD_SYSCON.

I'm not sure this is right thing to do. You basically imply that there
always a user of it.


-- 
With Best Regards,
Andy Shevchenko
