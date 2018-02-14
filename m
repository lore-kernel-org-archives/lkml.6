Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225bF5fSrCOBU+TVcCcs27RP4R+8SH+FBFy6ek6brdg4RlkO4k8eoDFW6f5+P/A93c1CCLK1
ARC-Seal: i=1; a=rsa-sha256; t=1518619777; cv=none;
        d=google.com; s=arc-20160816;
        b=s6bA5U8Ha7tU0H+0ISj9zvZ6hQs+Eh8UI/+SbluBBAE8xgZPZr2VJOa5zF/G3JxIVX
         mtgiJlMuEXnzAhhA4bSf9Ilylj+TM90mOrO5LHcRQgqVetir1eEhRsBhNl1XQkesosJZ
         C5kzId3lMr/qQr5bvhExHgOT3yMHUaxpvTDKxzYemkRS2JotfxLUuLc5yQuYZPN8f6IP
         tb0WreMCFANESuNXF9R0cw3iS3L8LXoqo3d2GQULsvthiM1sQUDhpAR3LxE/qIpa9r3l
         v0Mg2UNyvh+P/YCBfmGU2zKb2hU+hRl81i75cd5ehnpQTG43ag7RhfIzU2CXz6YV6/Lw
         mmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:cc:to:subject
         :message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=io6qbakiOvIKDRZn3hOGpBCm0uVbv5tQLieCERgDpho=;
        b=iaSO0f1aTnZAhRg2EumefVLBMVcF0j2yw7zCB6VE3xIoKJ5mE4Mw0J1j4ZgnQCnL9R
         vrRhAIn+tA4cq+emPLlyDHmthMVttBAA0QSEZ8BOo94fKeMK0Q+FRIkn1YMdpYUbgRwW
         b/k2q0hjUufa3WKVJSJ3tsLUQYpcczeL1VA4RtT27My6c4DbPrNBm+nsbnwfo6tO5Ko9
         b1098ptqq1tzeW5faU8qEFaIST0ZF5BCuP/M5kAQzVkEa/AyouonOJ4VzabyyG2Px2DC
         MikSXysNUY4n3S7qbiA0JPZ8ig4fyDtX9bxK1n/sp2fzVJKUHmx0sJ3LqrnsZXPbHGXx
         VVPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=XIe4ozHe;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=XIe4ozHe;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030918AbeBNOtX (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 14 Feb 2018 09:49:23 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33891 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030749AbeBNOtV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Feb 2018 09:49:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180214020352.GB5786@fury>
References: <1518024271-12467-1-git-send-email-daniel.diaz@linaro.org>
 <dbf5a78f-4178-2210-9a6c-bf71de7b939d@osg.samsung.com> <20180214013347.GA5786@fury>
 <6d498007-de71-2071-646c-05eeb81b2b08@osg.samsung.com> <20180214020352.GB5786@fury>
From: =?UTF-8?Q?Daniel_D=C3=ADaz_Rodr=C3=ADguez?=
        <daniel.diaz@linaro.org>
Date: Wed, 14 Feb 2018 08:49:18 -0600
Message-ID: <CAEUSe781sJsz=4rMBa+np7x=snO7r-ByV_AiaTtmcfUZk06j=g@mail.gmail.com>
Subject: Re: [PATCH] selftests/futex: Fix line continuation in Makefile
To: Darren Hart <dvhart@infradead.org>
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:FUTEX SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591763894080699218?=
X-GMAIL-MSGID: =?utf-8?q?1592388251355737129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!


On 13 February 2018 at 20:03, Darren Hart <dvhart@infradead.org> wrote:
> On Tue, Feb 13, 2018 at 06:45:54PM -0700, Shuah Khan wrote:
[...]
>> My understanding is that this problem is seen with make versions prior t=
o 4.x.
>> This specific problem is seen with make version 3.81
>> I will let Daniel D=C3=ADaz share details on his environment.
>
> OK, thanks Shuah. I think this would be important to capture in the commi=
t
> message.

That's correct -- fails with GNU Make 3.80, 3.81; works with GNU Make
3.82 and the 4.x series. Shuah, if you'd like me to resubmit let me
know.

Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
