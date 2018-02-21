Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225a6KJy7wRhrLXSA+iI7j0aiK9PzCwyn0utB/ozHxycXGoJ+Y9QxxJQhVTjZnB2yWdNNRe5
ARC-Seal: i=1; a=rsa-sha256; t=1519253123; cv=none;
        d=google.com; s=arc-20160816;
        b=dyvDyCxjhtOksJsWAn+VRi2+/nLKZ6SIjU32pM2zKRCfAn53DQJoej3NTbw3FviR5c
         dwov5fQJgAFYPj5LpvIgGo9XqbX35ndwWwrbfeHhW3SLxVgMUXLtyiRaxWqIhoyyu/W7
         D4LO4lvbxh2F2Gk4V+XWtomRZTUQtkPnqcknUE9nUXQqrOQOsHBQiib8PZp37cjQnSl2
         jB72Q4AjdIW/xJzWjvGuyiY8I/QhN6Q4uPHvVXGa2Moi1zHl93CTlIkvSgqthkbSuecH
         jh7KYN60fqE6muctJbd30rN7LK5GGCO1Wtv/Ntnw8jEXpNWv+hiwV/ZERMJiZCSXSNX0
         pbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=s5XiBkIyeWW9xMRWDj+u/zMzbAC2YV1MiFUBk/Cd3zY=;
        b=qlve+dIF2yHTSg/2xBWEjjQja/4CFx6WHQNfIw1hNHkFWwnHreNJdWdwy+4HGsIvN/
         GH29QJ1H9NOTTGJ6zBS8I3ocYtQLcGVeOB+Vqw0lBR6gSabtJGkM4izcXNikk/v8GnXt
         dTMa9CYaCUQmA7P7Kv7H3SfnBwDjI4JP7WaWOYpPn4yQtJ9ZLy1FJXQyhvjWTGMvpLVz
         LJVsQ4N3qw6O8tDqS6olUnyj/AxXGW+bVKlm6cf7zoIqH/7PGeQUwXuvt+pDajylJgnb
         DKJ1v++sQicYugQY+7hd8b8c06kK5SoMtwWynfgQVaKbjUjnbmvMgCeZ+zDU0JWuWpvm
         BqPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=K5WOP8dL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=K5WOP8dL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeBUWpW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 17:45:22 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45038 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBUWpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 17:45:20 -0500
Subject: Re: [PATCH 1/2] selftests: gpio: restructure Makefile
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        Fathi Boudra <fathi.boudra@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        "open list:GPIO MOCKUP DRIVER" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
 <CAHp75VdceMCPw1b8NNoNLTqU-7b7gZ6b8i6eS1MF8eUTH7Lcjg@mail.gmail.com>
From: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <290910ca-2e0f-8550-0f9c-e48cf277a27c@linaro.org>
Date: Wed, 21 Feb 2018 16:45:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdceMCPw1b8NNoNLTqU-7b7gZ6b8i6eS1MF8eUTH7Lcjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593049130388691991?=
X-GMAIL-MSGID: =?utf-8?q?1593052362680412304?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!


On 02/21/2018 04:06 PM, Andy Shevchenko wrote:
> On Wed, Feb 21, 2018 at 11:52 PM, Daniel Díaz <daniel.diaz@linaro.org> wrote:
>> From: Fathi Boudra <fathi.boudra@linaro.org>
> 
> What are you doing here?
> Why?
> What is the benefit of it?

Thanks for looking into this. I will resend with description.

The purpose of the patch is to clean up the Makefile by restructuring
explicit paths in targets for variables, substituting a variable
(BINARIES) for one of the build system (TEST_PROGS_EXTENDED), and proper
cleaning up of the EXTRA objects.

The resulting Makefile is much more readable and manageable.

Greetings!

Daniel Díaz
daniel.diaz@linaro.org
