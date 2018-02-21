Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225HBAHVWGMh1hLdVpCJ/0sNSPG2Upl6LIbWFJvzGLmudw0dlS/IJMT4V2pdkIyG/DHJHQ7g
ARC-Seal: i=1; a=rsa-sha256; t=1519251009; cv=none;
        d=google.com; s=arc-20160816;
        b=BEpRfezZSLHm7ur38pRkgLsYsVIg7+xrhFTPL7Fs4eeNcRpNEntFJ+I28uYFGJNyuq
         KskSHi4DQgNjq+Z1nrZNoTR0CN0H8Mkt3bDf5skvAx2j430jiODYXNpgCDUgfmviygJ4
         Dew4QcjGBcdgUS671KFyccIjaXSWQ6UL9A7gYzAfVfCVdHfwfYNR/WDRVNVN/8qy5fDf
         7+N1/J7aOlJFVBEgPGyKaOBtOtOpp+CP/Rw2D/PeFY8rWiXZeqtk9kb9jlqqyI692ZAL
         ahI0BsK28Nz8xg8NxqdUqf3iOJdXzEVy1r6Q7swG8qFFKLRqrfAHKLPY2c6W3xCWiDpI
         NiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:cc:to:subject
         :message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=JOdGxX0582Ut3OwR0QZCkRfT6zyDicsiIs1geE8IJEE=;
        b=hNDmHfDYxg9k2HJEJVD/o2S62WfMAO0ISE9/Btoq8T5K3t0qGtBVzERqQYJSRlQUED
         sVmql6TvLrA85wvrN2MiZpRW/+sR1miiElY9GH/O9+7T7NnYTnmag5XLpJL4RRqALOWl
         4Qdjsc4XaX+poH5tnudoVZ3HUVpjq6AfAMEEShscqg4ohaRR9NDbNJbjs4ngBls6uX6q
         /J1foyS1t1ibuU0aOSf1dV0IYizgmVwTvWzSN6X1++xDsXg4ytqVzIuA8J5o/FCpNUyL
         +FA8GZ+aZxXi0EUFyzUI+JO2C0++T6qveAwh1n9nqJy6HipZyzC7aRc0RDm9uC67pj3j
         HE1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=Q3n22hde;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=Q3n22hde;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeBUWJ4 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 17:09:56 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32916 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBUWJz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 17:09:55 -0500
MIME-Version: 1.0
In-Reply-To: <1519249964-1630-2-git-send-email-daniel.diaz@linaro.org>
References: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org> <1519249964-1630-2-git-send-email-daniel.diaz@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 00:09:54 +0200
Message-ID: <CAHp75VdMCaKnqbUPzU2QTxOk6gjyor69w+sVVoaKyjnO+zU=+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/gpio: Fix OUTPUT directory in Makefile
To: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        "open list:GPIO MOCKUP DRIVER" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593049155220283470?=
X-GMAIL-MSGID: =?utf-8?q?1593050146707111865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 11:52 PM, Daniel D=C3=ADaz <daniel.diaz@linaro.org>=
 wrote:
> When simply running `make' from the selftests top dir, this
> error shows up:
>
>   cc -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/ -I/usr/include/=
libmount -I/usr/include/blkid -I/usr/include/uuid    gpio-mockup-chardev.c =
../../../gpio/gpio-utils.o  -lmount -o gpio-mockup-chardev
>   cc: error: ../../../gpio/gpio-utils.o: No such file or directory
>   <builtin>: recipe for target 'gpio-mockup-chardev' failed
>   make[1]: *** [gpio-mockup-chardev] Error 1
>
> because the output directory is set to "selftests/gpio" and
> all binaries built from ../../../gpio/ end up there. In fact,
> they appear as, exempli gratia:
> * gpiogpio-event-mon
> * gpiogpio-hammer
> * gpioinclude/
> * gpiolsgpio
> which is wrong, as it's missing directory separator somewhere.
>
> This patch sets straight the output directory when building
> ../../../gpio/ so that binaries don't cross paths.

This patch doesn't sound right like previous one.
Does selftest infrastructure have it's own build system like tools?
Does it use tools' one?
What's wrong with the current approach?
Why do you need tools in selftests?

--=20
With Best Regards,
Andy Shevchenko
