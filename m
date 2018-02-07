Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518045555; cv=none;
        d=google.com; s=arc-20160816;
        b=UZ0bMTYo1IXMrWIIvl2nxOHXk6mdSSz9c1MLnrE/jFeKXxUFM8hYJT6fd4BZ9/sh9b
         g++TQnF8shjRuM2YHb/8idZLw/+nNkn+Faih6EC1jUYVnwlcr3/WMob56QuVx+avPhuU
         yxOhMidkSUuQgkbsicqcNzRx4QLVyzTiXN4lbUzJoev1muCmpPH/TsHJE0pd608GJ6tF
         +dRb0Fa5kVssATDwv3IL5hBhVkKNfPSu/qroI0n5bsgowC4CHqbAoIRVmuw7k5JTjyIy
         Tqk2WVvTvsYAX76JHCS3gFF/yFHt/K6NHreizN4DdIPN4A5RN2JzAuvVqAVS2gfNUrhV
         DMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Me79yCN9fyYlNZ/sjShi+YsQ+C24E6mfK/ORJ1jriqM=;
        b=Ylz/3I+AVA+kuDaJTlDWMS4dmdj5P55DGc9JsmG72dRTnPeiYjqbQaaxZeNQhAsWbo
         PN3L2Z2Mjfu4ta1KO+UUX3RPZczs32wHOy5/QLj4E73uoNA+y1Hjes9is91Ec9SGkyG4
         SOIZcxTWP03sM6KcDt/J1JrskAqvG26Qhl0HoHTfWzWhUHpIZlyDYkGPr5RysMILqJ1c
         i0c96aomS/Ywbq0q73epgKT6txGzgGOBe9IGn87tBYvCurDn3w4IBoBo3T8fo+IX+RBj
         MkmG97oda55/nV9u6pCxK/Hhim6VRwiHDdU1IlbMrcPdvPpt20UPyM2zojkkj33h3wDW
         6wnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JQLRVBPs;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JQLRVBPs;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224VIjplNR3t2GVq2ehXUWoFoqxNgGnMraOn+0DwzIOsX0EJzgV5h+imrqiCSZJ7woxQdeFWyHXeOkAh4vAy79g=
MIME-Version: 1.0
In-Reply-To: <20180206093803.GC31558@kroah.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <20180206093803.GC31558@kroah.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 00:19:14 +0100
Message-ID: <CAFkk2KSdg0+AdnncRuwUNeHHoXv7zsdrrZEsMgq0esvAU5U7Eg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Add Kconfig unit tests
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Yaakov Selkowitz <yselkowi@redhat.com>, linux-ia64@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>, Marc Herbert <marc.herbert@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778603176357?=
X-GMAIL-MSGID: =?utf-8?q?1591786137023667679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 10:38 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Feb 06, 2018 at 09:34:40AM +0900, Masahiro Yamada wrote:
>> I am applying various patches to Kconfig these days.
>>
>> However, I fear regressions.  I have been thinking of unit-tests.
>>
>> There are various cryptic parts in Kconfig and corner cases where
>> it is difficult to notice breakage.  If unit-tests cover those,
>> I will be able to apply changes more confidently.
>>
>> So, here is the trial.
>>
>> After fixing some problems, I will add a basic test framework.
>> This is based on pytest.  Also, this is written in Python 3.
>> Python 2 will return in 2020.  So, I believe new python tools should be
>> written in Python 3.
>>
>> This is my Python 3 and pytest versions.
>>
>> $ python3 --version
>> Python 3.5.2
>> $ python3 -m pytest --version
>> This is pytest version 3.4.0, imported from /home/masahiro/.local/lib/python3.5/site-packages/pytest.py
>>
>> If I use old pytest version, some parts did not work as expected.
>> If this does not work for you, please consider using newer pytest.
>>
>> I will brush up the code more and add more test cases to do a better job.
>> Before proceeding more, I'd like to get consensus for this approach.
>> If you have an idea for better implementation, comments are appreciated.
>
> Personally I think this is great stuff.  I too have never wanted to
> touch Kconfig stuff due to the complexity, and having unit tests like
> this is a great idea to help ensure that things do not break.
>
> Your first 5 patches should be queued up for the next merge window, no
> problem (see my comments on the 6th).  As for the rest, I don't have any
> objection to them, and using python3 over python2 is a good idea.  And
> anyone who wants to do Kconfig work can easily install the needed
> packages, it's not required by any "normal" kernel developer.
>
> Anyway, nice job, it's great to see this happening, no objection from me
> at all!
>
> greg k-h

Yeah, breaking Kconfig is a sure way to feel the wrath.

The only reason I feel somewhat confident modifying Kconfig is that
the Kconfiglib test suite happens to work as a regression test for the
C implementation as well. It compares the .config files produced by
the two implementations for all defconfig files and for
all{no,yes,def}config, for all ARCHes, meaning any changes to the
output of the C tools get flagged as well (with a diff).

Having some "native" tests is great as well. I'm a big fan of
automatic testing. :)

In case you want to run the Kconfiglib test suite at any point, here's
how to do it (in the kernel root):

        $ git clone git://github.com/ulfalizer/Kconfiglib.git
        $ git am Kconfiglib/makefile.patch
        $ python Kconfiglib/testsuite.py speedy

Cheers,
Ulf
