Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524747911; cv=none;
        d=google.com; s=arc-20160816;
        b=OTA5XEEQ5dYLLYZVy7Y+SEBnb9QdJoJF4Mnz2+Msa5QiQga6dmukg6zDDQjsm2eeiH
         OyEhzt1YjHV7pkHmk8c4wuEs7eU+J6ANs2EwrpXDVkwRD/57tgttpCTQTGNcOLbMfHtE
         AvdrE7GIVrx9mVlYgPWhx4hxcZT6rslUeiIBu6RbAO6JDHZ2dluY56+cMcTFfeg9XUID
         dtgyk3RKFxuB+1FhomPtS6cyv4++0BkJFWKYSMlaugwfYWGW39qZje2hhPxImsFqEElC
         xrbwH1ETeADmFq25O+AumH4aAiqcvvI0P5Igy+gA/chLa0RSyRygiOaPYvTQcjVz58N5
         rGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=8FFPAMfHXwY/ZwRpaXwySe0jkJ3O3pR6rsHbwikUuxo=;
        b=QfoDI5dNP5Ut0PXUO5ZVqQ9yIxciaCsC5tHU/LziEovuhX5p9qhQ+qBhPRHjWJ5U5Q
         PZXzcdcSatEXi3CL6tP0/9vLlG067JeM7e1pcrdiiOoyzSAk/fX/+Z0CZuAsm6qjvef7
         OC9Kqe0PPpM0umF4JxNwBUoKPKIMFKJi+fL5VoZLq7vF72VmqPody0GgYu/HrPnTz+su
         miXUJaB54U8i5wgnInbpzP+B6GsHwr3BKbWIaDwHOKfrP7K8D0u1wvh8X6kwc5T2yGQ/
         s0TVQVHhV+trVCyTrP/8iPAp+HgYm3sPuk6bFYT9cpnfehcBrgTwordf9I4cyA8shgzP
         LIpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JUT4endP;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JUT4endP;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AIpwx49VEEFVLeDj4gISF8yA3k7TqQDPX93vHXrRoRMJeuyhFrMMvdbJVBvBLL531MwwSlNQSAhgfv00M7r+gTy52Qc=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180426125428.GA8975@kroah.com>
References: <20180426102356.77394-1-andriy.shevchenko@linux.intel.com> <20180426125428.GA8975@kroah.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Apr 2018 15:05:05 +0200
X-Google-Sender-Auth: XmX_ivLcmAqQ1OwT2xUDxLmFSDU
Message-ID: <CAJZ5v0huZAZjRDSkgR+z8XqLShoyy24arevD3oiwn7GPHRid+g@mail.gmail.com>
Subject: Re: [PATCH v1] device property: Get rid of union aliasing
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-efi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598803925974948684?=
X-GMAIL-MSGID: =?utf-8?q?1598814066342839806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 2:54 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Apr 26, 2018 at 01:23:56PM +0300, Andy Shevchenko wrote:
>> The commit
>>
>>   318a19718261 ("device property: refactor built-in properties support")
>>
>> went way too far and brought a union aliasing. Partially revert it here
>> to get rid of union aliasing.
>
> What is "union aliasing"?  And why is it bad?
>
>> Note, Apple properties support is still utilizing this trick.
>
> So you are breaking something now?
>
> What exactly is this fixing?

A device properties framework change that went in through my tree.

I'll take care of this, but I agree that the commit log is not
particularly useful.

Cheers,
Rafael
