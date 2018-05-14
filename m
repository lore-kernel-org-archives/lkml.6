Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526331333; cv=none;
        d=google.com; s=arc-20160816;
        b=DUTiZA7Q7QAEv4cCz7pYNp3g4K7mkcgePNZCqF6tqBvboIsJZ0LIyFVDP1v1nHqk92
         il48AB9UAK2tXy14iu5ApGzgV8Hfrjnrn/CT8tAcQ0Ykxq+T6Ih6T6i4Vww5Qg3JEP3e
         52Hy6gOWJhjIU2Nm2TENHHU/cwTPOV/U61Sj+rtZQMOPBfPKSrzy/Lw/SW5BpFBJ//JM
         IE/sDuDUEZhIhN9joR+cWsyth0RcYMKudW+/tvmh8Ya7l7WYpb5gGg/lRIkiDZxSVJgO
         SDwAYsy0rqUEDJ+ZuV/vyxgWLk+JcVNsPRR0/ZXuX7TXnQJVQLDGy7gvqia2NH8SB2xj
         GMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=dnow8lJoxdh4niPS70mfvnGNp1xLsE9aFc+7n3wxf4Y=;
        b=M5WEHCKAQ89j1SgpuKQoZ4KzFM3w+psWSdqXK4pgYM104HklWXio0hLILNRJ/ZI7jI
         HAIYcyeJY1sWvGh4SggpQuvp4q0IHzT8t+lf0/4lEebgaKAQrDLtSyq5o6ku6HK683Rc
         3xmgkVOh2VKOl/M4m7eEqrbCzpLqnWqwrslBrYoGuVY1fYH6lUJXRlZVi+Cw+AmKrpOw
         3V5b+tTjJkXSg3oAbmnmqjeFrKmoKSQJgZFau9HokU7PF1MdJLTBjf97ybHohLyr9rlX
         CIIAC4O4pRJvUtUijEyCSJ7g5bT8tpSTlvaYdsPs9rx/kHUB0qf5/h4QOYYIAo4D2q/b
         gyeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R24cEaP/;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R24cEaP/;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZr/uOBuQqEsLhcacenyaQfnW9ajPfyfdV4Z62vLnULiniGvvZjlUr9L2hZGdyUaCyDEJbSky8flcgcrwiUMzeQ=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iD3-gmOsRtH6H+EHz-wXyW_xJV+U_vbM94oVdz1=gkPg@mail.gmail.com>
References: <20180508131547.44366-1-andriy.shevchenko@linux.intel.com>
 <20180514121817.GA27869@wunner.de> <f2109d06a0755dd2d9dc807c1e13dd2c19903905.camel@linux.intel.com>
 <20180514154017.GA6734@wunner.de> <ddd9eae5cf848df9c25a49001845a3d80e429a6f.camel@linux.intel.com>
 <CAJZ5v0iD3-gmOsRtH6H+EHz-wXyW_xJV+U_vbM94oVdz1=gkPg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 23:55:32 +0300
Message-ID: <CAHp75VfzFSZpCw1tsiWcLL9GHDvCMb076eXXJELTF1bPmJwEAw@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Get rid of union aliasing
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-efi <linux-efi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599901902158233534?=
X-GMAIL-MSGID: =?utf-8?q?1600474404008539209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 11:44 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, May 14, 2018 at 6:13 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Mon, 2018-05-14 at 17:40 +0200, Lukas Wunner wrote:
>>> On Mon, May 14, 2018 at 03:48:09PM +0300, Andy Shevchenko wrote:

>>> Well if that is your concern then you need to prevent functions which
>>> retrieve properties to use the wrong type.
>>>
>>> E.g. to prevent retrieval of the u8 array as string, you'd have to
>>> amend drivers/base/property.c:pset_prop_read_string_array() to
>>> check the type of the property found and return -EINVAL if it's not
>>> string.
>>
>> I think it's doable. I will hack a new version later this week.
>
> So I'm assuming that I should disregard this patch and wait for an
> update, right?

Right.

-- 
With Best Regards,
Andy Shevchenko
