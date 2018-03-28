Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522236843; cv=none;
        d=google.com; s=arc-20160816;
        b=ycikHe4oMl3tRPvv4S0CiWv0PE1WiIaK/NmiXlyvPu94QFYENBPoJzQ7vIH7EBLVBZ
         zMsBWdRqpxOz99qUL38755KooMT42sqFdvh+VfOPG16vawXRZ6H+dfuABIOp65SXRmY+
         djoJ7KP9UEApXcvyGYS3Mb8rwvhBzoO1gvdnuqciXUmA0OrMzzsmxA/6EDgYCAJvcvSi
         JJfK4QO0+MHTzWTX6pi2APs3EnGhuhYmYfSo9Os10UuZESX7EM6lW8QIqCeINfAX094X
         xRtkfXiR7aGYPqtTICFXY4ZzRVevIiQFn3ugacVx+1nQb7i3B12K25wSsjrCKeR/oP6o
         2Cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=3/Rz3GGAZEUveMEV/pjpm8kSikXQMTXsD6UYoMvMyZ0=;
        b=A23wZlO8K6xPxfVv335lDkfYozTTLT8ENYfUvOxoTpz9WHVyzeO8oNX6HhFZLww6ni
         3leaJXDfwUzEevx1xE1/9nSVb99mf4nxNtchOL/OJLp6Q+fVt7Nr597DkGSMO4qqLkAZ
         NIW7LIBCtyuby1uFClD8alz8up3fkPjHoLmEGBniM0cxPct6I/JWpn7nY8X5Z5GVKdfz
         1y6KaOQ4g47w8CU9RFYYEIZxAq/6W8dBj4sHeYoZRmf/DipNwa0H4j4OytXMllEi0Wdk
         OZuWdwMAe/C9LTICm1DMtNjH20tvPvoHX2EXlM4AZcuxiXwfugMWR8PgAsboIsAtyTIO
         KzYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=BFP25vvM;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=BFP25vvM;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AIpwx491ES16lJRyxGM9HU34G27O/yJ0rkZXwNHEFbYCAM9D5teQ07L/t6/ngCpgassGyJXO7jgpXCLe6CVr8WHd9SM=
MIME-Version: 1.0
In-Reply-To: <20180328112838.GA26219@kroah.com>
References: <20180328091450.85073-1-maco@android.com> <20180328112838.GA26219@kroah.com>
From: Martijn Coenen <maco@android.com>
Date: Wed, 28 Mar 2018 13:34:02 +0200
Message-ID: <CAB0TPYHAMmbW8Nfqxr94MyB_dR3zeE+5JtSGAadkaNaMyrD46Q@mail.gmail.com>
Subject: Re: [PATCH v2] ANDROID: binder: prevent transactions into own process.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Amit Pundir <amit.pundir@linaro.org>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, Martijn Coenen <maco@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596165622257812617?=
X-GMAIL-MSGID: =?utf-8?q?1596181020697019926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 1:28 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> What is different from "v2" you sent before this?  No change information
> from v1?

Sorry I messed this up - the first resend did not have "v2" in the
subject but did contain v2 change information, the second resend had
the v2 subject and did not contain the change information :( Either of
the last two patches is fine - it just used "target_proc" instead of
"target_node->proc".

>
> I'm totally confused as to which is the "latest" patch here :(
>
> thanks,
>
> greg k-h-
