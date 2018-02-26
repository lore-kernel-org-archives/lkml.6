Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2691517-1519645200-2-5966084641449495162
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
    t=1519645200; b=IRrVKXgew16OOYfUFzzzkpRYGtnoLlnNpJyezohBQR035wW
    B92hWeYALvb9A7puJWmLlsC3gVD6wfntdIhdVc3pYhj+w1O4BUbWHs2iIqlg8NO7
    FyOldNLf1Lo3oO7cLuqfNuny4AH0kYE9JUlJpuyY1dNPiToGCsD2m9te+suNF2v7
    SAnVecXCSxGT7+fBhLcFISfZVzw4/JlBJ1Cm9XK1o60raW32zjUkUEzALAnmsEsB
    xzF+kwDES0WkMd/Ngkd6Md/bYa44uWM6pBXffysHtU8iep+br/Fl1Psit0VBqZxe
    n/NGMVXTv3WSPA++Xa6faxEBY87sej5X0MBovTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519645200; bh=bLuLvWRx60ENKCBIr/5j2OEwIP0kZ+6Df1N+rD
    VK9fE=; b=KrmXCBh0QflWU0D9gSuVVqwTAFxkUcT7+ggjSAJqwIbwz5b8/1BU/E
    AhyIZHCP9kfevyca3wcxZK+i2VNxEB9MGBlN/6SB3uUkrb/B8evH8Xd6HW7xFLhM
    3bVNPpAiuIKOHfO6LZ+T6j9Mu+BKsr37dozW7L1/7Yx79pIe68n1yzwmvJDzYSsq
    oTTuyREPMSl6ckmc+dbBqlCtnJUNIwhcOqYKyFZ1hFMRn8PRIvSz7KPrWpjoqjTs
    NHAZWl45pMZqnFtWZg1OHPZ4DY3XCcFww8mcFIJFVtBB18RJLyWsJc+BcXrccARv
    M6gu8Ov1xfgGmkoaXZw35eJHnhH3Zuxw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kARybQ+Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VACkBTD+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kARybQ+Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VACkBTD+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeBZLjp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 06:39:45 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35135 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbeBZLjo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 06:39:44 -0500
X-Google-Smtp-Source: AG47ELs3YpRQAgbLbRNrvjoq8qeDIOzIX8rRbzWkY6PTW4cewhN20mKUSZun2xfquuBTvkYwZrzp2cF7YCzor5709Bc=
MIME-Version: 1.0
In-Reply-To: <f8fc1193-2057-497f-3494-aeef437f1341@redhat.com>
References: <20180226090925.29436-1-hdegoede@redhat.com> <CAHp75VevNQB_8BTaazq94RHQ_Nbs=CcjJwfw+Ph9iLunLYb9kg@mail.gmail.com>
 <f8fc1193-2057-497f-3494-aeef437f1341@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 13:39:43 +0200
Message-ID: <CAHp75VcAVKEyjqidVBbupeNb4cxviBeNtjigddn_gH=xpA5x6g@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] USB Type-C device-connection, mux and switch support
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 1:19 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 26-02-18 11:59, Andy Shevchenko wrote:
>> On Mon, Feb 26, 2018 at 11:09 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:

>> Didn't have time to comment on v2, so here we are:
>> you are using in even the same file two styles, i.e. IS_ERR_OR_NULL
>> vs. !x || IS_ERR(x) (and negative ones).

> Good catch, I only see this in "usb: common: Small class for USB role
> switches",
> will fix for v4.
>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> So with the above fixed I can apply your reviewed-by to the entire series?

Right.

-- 
With Best Regards,
Andy Shevchenko
