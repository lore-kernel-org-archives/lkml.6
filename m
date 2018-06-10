Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id w38jH8NZHVvSGwAAmS7hNA
	; Sun, 10 Jun 2018 17:04:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4CA3360791; Sun, 10 Jun 2018 17:04:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2uMEI3u"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B0EB1604D4;
	Sun, 10 Jun 2018 17:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0EB1604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeFJREr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 13:04:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46232 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeFJREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 13:04:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id j13-v6so27048493lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IXLYFeT7XSkFQ+cfuOLzu5Hdz2EA2zBQp2Ypi4GFsgU=;
        b=k2uMEI3uI8mYWtkK+JOHi8SRnRZuYtriV2Ztc2oJM4B1B1MkZ7lQ4+qPZpKqG9sfsv
         /wTBGhP4wYBybC1GZE8bT3PrRbhswagka3ja3gXnuylF0Yl4y+BNeK71Nod41Lc12Jyg
         U3Pn49yTCE80Xk/BJtRfvQLZR/llWATQhoGgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IXLYFeT7XSkFQ+cfuOLzu5Hdz2EA2zBQp2Ypi4GFsgU=;
        b=V7W2HPJxQT93/CIr91DUdU+JpD2Firo05qBwgwcuMuD9Spdv/H7ZJivcjvx4BfC1Aj
         dOhD/i9rn0jUDwJyUx+sP037BmfJzXL1FnEeNwLSahyVN28U61fe9aU3fWbH+YwyA9um
         tWNFU84FM3iX/6yCJbA3zLepQz15BTjUtANxpzp7c2WQM15RC5Y8E6eBRCFI2ZXn5vAb
         R5e0KWbYou0jYYTvvEnckmO+ijZ8EvOgE/IuXVSsq//wSQNyJVTOMi/4/ROqvAqCHjoS
         IiE21gs5fKJESIHI2/x7mNxqFZ6QQquZ5d4q9KzvJ++CEFIFDLxysCBcC6/NYQUtTveg
         tXYw==
X-Gm-Message-State: APt69E2yEi0AuvuuI4kWJgi+JVx8a+c6hbCz+DBrfv6jZe2wIxSAzP7g
        Mv0tCaFTBmHFwvvWSmnnWWgCjgCQyXJ3MR58Gm9zjg==
X-Google-Smtp-Source: ADUXVKK07SPVRozBTu226+NrXSC/qgTX4jULOtAFsv2RCaOfbjEoxOEfA6SHC/lsDzw3LpXLklA3DIkt8FmjZpI+TuU=
X-Received: by 2002:a19:944f:: with SMTP id w76-v6mr8927425lfd.90.1528650284525;
 Sun, 10 Jun 2018 10:04:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 10:04:43
 -0700 (PDT)
In-Reply-To: <20180610140532.GA24280@kroah.com>
References: <20180609145947.679103414@linuxfoundation.org> <CA+G9fYsWZNWeGeZzknVts5iF5h40y+-tBnoMNL5yZJx3sxfc8Q@mail.gmail.com>
 <20180610140532.GA24280@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 10 Jun 2018 22:34:43 +0530
Message-ID: <CA+G9fYvrjMn3QTCuNsEbgmWj5dvxRY3fL=NXu-JFE6oS_xc6xA@mail.gmail.com>
Subject: Re: [PATCH 4.16 00/48] 4.16.15-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 June 2018 at 19:35, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> On Sun, Jun 10, 2018 at 02:37:39PM +0530, Naresh Kamboju wrote:
>> On 9 June 2018 at 20:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
 wrote:
>> > This is the start of the stable review cycle for the 4.16.15 release.
>> > There are 48 patches in this series, all will be posted as a response
>> > to this one.  If anyone has any issues with these being applied, pleas=
e
>> > let me know.
>> >
>> > Responses should be made by Mon Jun 11 14:59:28 UTC 2018.
>> > Anything received after that time might be too late.
>> >
>> > The whole patch series can be found in one patch at:
>> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/pat=
ch-4.16.15-rc1.gz
>> > or in the git tree and branch at:
>> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-sta=
ble-rc.git linux-4.16.y
>> > and the diffstat can be found below.
>> >
>> > thanks,
>> >
>> > greg k-h
>>
>> Results from Linaro=E2=80=99s test farm.
>> No regressions on arm64, arm and x86_64.
>
> Wonderful, thanks for testing two of these and letting me know.
>
> Are you going to also test the 4.17.1-rc1 tree, or have you not set up a
> 4.17 test tree yet?

4.17 test tree setup not yet done.
We will do it on Monday and let you know results.

- Naresh

>
> thanks,
>
> greg k-h
