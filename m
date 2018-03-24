Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521866989; cv=none;
        d=google.com; s=arc-20160816;
        b=gEp10JTHfJshNychDtP639Z+YU9ftwjoK5v5qCSd/PCA+67aWvlM4UhDCd05L4UX5O
         NhXXTHIaiqoJiodBUFiGtiYoEepB3edxJCYuH3dWGvP8es6wHCYGz9gQ4UOlPSlVAnG8
         xSQXYRicvokJKA0O6Xu7E5lXNkgY2mDYlIwfYSvkIcLh9hbVz3PxrtoWz1FWxpY4E3IK
         uXDAPVUvH4gHyPlrSIS/XROwitrKwHnIxExlxpnCpVMG3TccGS52Imdt5rgCmPkZRxBO
         jNjQayXCm12DYmrssuPaaMPaC8grg0oQI18gofm/zR/+Q72jb5ufLkih+XJTRjeKGyIz
         ARpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LEhDUWOMeWqr33+KXDtJ0TZ7P9aDgZfhXJxPX4a1D5I=;
        b=e+7ju4XZpVj/pYIXc5iFbO6kt42nCUY42ciNGYzHeSjyGpUeydbT3LAczY/jfXhA34
         XeCImg9iCyPChc1JBPY0T9yxe83e7hHThrOYNNqQ220pY3fFdvBg5cm91i6OSxPeGdum
         AB8keLZuB+PfcS6M5adI2BUpU0mmBuvFfH/WzIagMG1p2EBB+NZT8la293fblGLmER15
         7V7VohdvPIK9zWx72Cj5lcuo2XWxWfuYRh+ryy1CQsetmaCsFkNNZbcZRNO5O4lJZknH
         FAeKkUuVKud4Gs8sQ1WxdnDImAGG2GBixcrxyceoDA/AISpHfKeL2eJJ6MKyzunlsIVW
         61RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=mMwbCylQ;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=mMwbCylQ;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvCVlbBTf7eIRrNZt/LqHmWMxgRIk2/CuRhVVBk0X3qGnnHsoIc55NebcMepmn0JGg/iHJXBwnKOnXVUumbiPc=
MIME-Version: 1.0
References: <20180320175712.201572-1-djkurtz@chromium.org> <20180323133448.GA3434@kroah.com>
In-Reply-To: <20180323133448.GA3434@kroah.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Sat, 24 Mar 2018 04:49:35 +0000
Message-ID: <CAGS+omBxftY6t9dWE3FHuhhN75ayfALJUjatCAR8JKudLNOx0g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix __earlycon_table stride... again
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: mka@chromium.org, Guenter Roeck <groeck@chromium.org>, adurbin@chromium.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595480358475048954?=
X-GMAIL-MSGID: =?utf-8?q?1595793199546663698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 7:34 AM Greg Kroah-Hartman <
gregkh@linuxfoundation.org> wrote:

> On Tue, Mar 20, 2018 at 11:57:10AM -0600, Daniel Kurtz wrote:
> > The __earlycon_table lives in a special "__earlycon_table" section.  The
> > contents of this table are added using some macros that deposit
individual
> > struct earlycon_id entries into this section.  The linker then defines
a symbol
> > __earlycon_table that is supposed to contain the addresss of the first
of these
> > entries.  The code in earlycon.c and fdt.c then tries to access the
memory
> > pointed to by __earlycon_table as an array of struct earlycon_id
entries.
> >
> > Unfortunately, the compiler doesn't always place the entries such that
they
> > are an array.  Let's fix that.
> >
> > Patch 1 of the series is a fix that should hopefully fix a kbuild error
that
> > seems to be triggered by Patch 2.

> Doesn't seem like that worked :(

> And I have a bunch of different versions of this patch in my to-review
> queue, and I can't figure out which is the "latest" one.

> Can you resend it, after getting the build error fixed, so I know which
> to attempt to apply?

Please take Patch Set v5 (fixes kbuild errors and commit message typos):
https://patchwork.kernel.org/patch/10298043/

thanks,
-djk


> thanks,

> greg k-h
