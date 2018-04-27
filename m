Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524826569; cv=none;
        d=google.com; s=arc-20160816;
        b=MWtmz9yRDpnvd9BH8VnYsm+2mh3zUv7PWo3VT1kwTEM6K8QCV3baVgUnDovoEzHSCn
         up8lQPwa0UvJSwXRqTdexQJX+EvRqPU4NM/AO/rAafufd/99DPK1aNRCA5Fd/CJGps1z
         jR7/dpe0nQcr8ETqvRnUwCU8RqdiLLA+1FOOXoPyLjwvWOI0LKey06C3SOJNH3zMSquC
         lEA6j5HL1OULrwt9zcg9k255xIR3RmmIJcB7foOtU7Anc72zDPXpiLpKsKTcbiEwYfj1
         uYvFXFnwL7BI2sr+kkma0JUwgbCxK8s+X5b9BdX3bO50c+Y8lWvNIenlO6bvJKZYH6I6
         vG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7bPjlZsqPJb25LY3hEzQks+vqADbbkVvyYVLeyBsuqM=;
        b=Hssh6xYcKhkqcsbGFqN+fD6Tpafi74ARh1qdErWiJohjT7/1q364mUHVuHcE15jqs1
         trj4muKCTUeSRTbFi/aehM7+BkkQR/81VvKFk7kJozuUHT7EB6DtX1rDg57CQZWraWRr
         mkAXZU+fiwUWhY1c1RX64togxDYqxm5GT7VwyW4wcRrP1WuY0fWjsOVPm2t26pARN1z4
         mV9YuLfflTVtwrH0msPnEMI5FUX5X7iVoqB5/S3pJWPRR88aSds8P4kya40mlf3NNgec
         gYeOYAvfj5pzHeuVahy6CkL+Rd/BYNGnphli5+f3XqaU0T3GmSaBQ/lMCpec4E3xFE6U
         2OGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TZq13P+5;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TZq13P+5;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AB8JxZqt18nkJJ39Wq6Yg5BLTYOoMzDgLqMqKJu7hFh+FxmtwFTKRvkivx27lTiCWGtWTslrzW3Sfp7PDePRXqmU0Po=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180426102356.77394-1-andriy.shevchenko@linux.intel.com>
References: <20180426102356.77394-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Apr 2018 12:56:08 +0200
X-Google-Sender-Auth: nH3CyfRE75bcFL9daTVN7BAFMHY
Message-ID: <CAJZ5v0jgQwQCSqAfnap+pLBqBy-aMTORU=P3g5J77GK46-xOBQ@mail.gmail.com>
Subject: Re: [PATCH v1] device property: Get rid of union aliasing
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-efi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598803925974948684?=
X-GMAIL-MSGID: =?utf-8?q?1598896544685412770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 12:23 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The commit
>
>   318a19718261 ("device property: refactor built-in properties support")
>
> went way too far and brought a union aliasing. Partially revert it here
> to get rid of union aliasing.
>
> Note, Apple properties support is still utilizing this trick.

Can you please resend this with a slightly more detailed description
of what's going on in the changelog?

Someone reading git logs in the future would have a really hard time
with decoding the above, and the last sentence in particular. :-)
