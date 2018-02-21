Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227Tbauy1dBMGX0egvgkVQLzrfrIrf8lR22CtzFgRjwYWotSQTzK3RE9Hh8pChyA10rjXUUl
ARC-Seal: i=1; a=rsa-sha256; t=1519254285; cv=none;
        d=google.com; s=arc-20160816;
        b=f5A3547SM6z+gEmGOBaP2Y1jgZBCwz6PFV7clIfEXXA0DmzFhHJlStcGwRySPPNIVf
         0T//u42UzK6XFByhkOYJLcRPkrRMOmtqGE2FopoqgxHfGALU46nS/e3fHUcwKDemrFFL
         UyYzdJEJQiORNuY35qTmQIWARSmL34mHFXlqZ5bP6B7K5qFIgCSoRzav1y3DM+JDgbA0
         7AiDwZLipdYlgaqNXkCzcvzg7a3c8Wqp0kY3TNbDA4HCfMGfWYWKijfH/kGgu9bnk9AK
         L8rKNVuCeQXW188Av5wkYNSoxJrgrvGsBdSfx5VamcWGdYq7HPevP/8s5TWvGXS4Y9aG
         Bu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=zUnuGCt04BohNv7PTDNd7a5fuZ8Sygz5djd/VpFRFko=;
        b=Zw+JJYfZ+YNBRwhQa5uQWJHj0xtJ0F6FXbXT88JOTXNDhd0LcJimfZaPz5RjtA3W70
         QCiRwPByIYeqLmqVG0nUepSC48sllKiwHU/uTgyfI0F65N7qOv6ZB/CHfAA9K4QFsUo/
         7LCt8wLg8j22t/tKAYeBmA0lXPz9xpod0/YI9JNPCs+rKupYoxDej+dB60hFmpdFNUbk
         xcbFOK17etf6H2bXAY5c4Sh09tEjGZ6DBspan/ctU0iWx1dZG6uM2LRY5IK8O18NPNPu
         EB8vEsY0Sq30NwWkkSoS7b+5XIpOzOATJY8wna0g44vEpv763rpsDJKzskyITVW0A+CA
         Q5SQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=NDnVWzDL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=NDnVWzDL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBUXEo (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 18:04:44 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37457 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeBUXEj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 18:04:39 -0500
Subject: Re: [PATCH 2/2] selftests/gpio: Fix OUTPUT directory in Makefile
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        "open list:GPIO MOCKUP DRIVER" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
 <1519249964-1630-2-git-send-email-daniel.diaz@linaro.org>
 <CAHp75VdMCaKnqbUPzU2QTxOk6gjyor69w+sVVoaKyjnO+zU=+A@mail.gmail.com>
From: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <8e7b8d40-99ac-3f4f-a25d-e0df0dd104d5@linaro.org>
Date: Wed, 21 Feb 2018 17:04:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdMCaKnqbUPzU2QTxOk6gjyor69w+sVVoaKyjnO+zU=+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593049155220283470?=
X-GMAIL-MSGID: =?utf-8?q?1593053582173075459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!


On 02/21/2018 04:09 PM, Andy Shevchenko wrote:
> On Wed, Feb 21, 2018 at 11:52 PM, Daniel Díaz <daniel.diaz@linaro.org> wrote:
>> When simply running `make' from the selftests top dir, this
>> error shows up:
>>
>>   cc -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/uuid    gpio-mockup-chardev.c ../../../gpio/gpio-utils.o  -lmount -o gpio-mockup-chardev
>>   cc: error: ../../../gpio/gpio-utils.o: No such file or directory
>>   <builtin>: recipe for target 'gpio-mockup-chardev' failed
>>   make[1]: *** [gpio-mockup-chardev] Error 1
>>
>> because the output directory is set to "selftests/gpio" and
>> all binaries built from ../../../gpio/ end up there. In fact,
>> they appear as, exempli gratia:
>> * gpiogpio-event-mon
>> * gpiogpio-hammer
>> * gpioinclude/
>> * gpiolsgpio
>> which is wrong, as it's missing directory separator somewhere.
>>
>> This patch sets straight the output directory when building
>> ../../../gpio/ so that binaries don't cross paths.
> 
> This patch doesn't sound right like previous one.
> Does selftest infrastructure have it's own build system like tools?

Yes. See linux/Documentation/dev-tools/kselftest.rst § "Contributing new
tests (details)" or linux/tools/testing/selftests/lib.mk itself, which
starts saying:
# This mimics the top-level Makefile. We do it explicitly here so that this
# Makefile can operate with or without the kbuild infrastructure.


> Does it use tools' one?

No, as far as I can tell. If anything, it uses it only to build inside
tools/gpio/ whatever is needed.


> What's wrong with the current approach?

When building from the tools/testing/selftests/ directory, binaries end
up in the current directory (and with an improper name), which is
undesirable. The gpio/ selftest fails to build when make'ing from there.

This is with current master:
  /linux/tools/testing/selftests$ make
  make[1]: Entering directory '/linux/tools/testing/selftests/gpio'
  [...]
  gcc -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
gpio-mockup-chardev.c ../../../gpio/gpio-utils.o
../../../../usr/include/linux/gpio.h  -lmount -I/usr/include/libmount -o
gpio-mockup-chardev
  gcc: error: ../../../gpio/gpio-utils.o: No such file or directory
  <builtin>: recipe for target 'gpio-mockup-chardev' failed
  make[1]: *** [gpio-mockup-chardev] Error 1
  make[1]: Leaving directory '/linux/tools/testing/selftests/gpio'
  Makefile:32: recipe for target 'all' failed
  make: *** [all] Error 2


> Why do you need tools in selftests?

I'll leave that to the test author to answer, as this is only a fix in
the Makefile, but the only part of tools needed here is tools/gpio/*,
for make'ing the object files this test will be built against.

Thanks and greetings!

Daniel Díaz
daniel.diaz@linaro.org

