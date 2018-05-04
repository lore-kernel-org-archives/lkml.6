Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525463078; cv=none;
        d=google.com; s=arc-20160816;
        b=frwf3Z87nDH1ydtqN8ghx8v8LCUEVMVnGvYPl0rNR5BIjWsFcQKNHO55WAbqOMtwKq
         Cik2lUmIgc4C7xMUqs09lBtrRtsHs1467rzxdNtLO3H+hWpjNW9Unwd+UrKX2HWylvHq
         JtS8DOZSrQjq6QJHP7PNcxsS9ki3HJ2GUTjIsbHQJovjbXAF0h53SbRkxlZ3B0woSMJG
         cR1ENe2aYxpLAkZEarUGZM9tYhr0yT6SxkfKSporBWpYS7Widjp/C10Je9L/wVfaye+r
         f7psQuhOiFiH21WYvtT2AKPNoLTE1aiUq5IuJ6l7hUaVeMdcCT0RodXk67dFF9qHKSQU
         15gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=+j2sUResMgaa4JVCFzD0zAB/f1rjseFwBqCCdn4Aqzo=;
        b=HbNCjdQycPgXkiYK3mzmAPrNEv/l13HniDcVNhJeZhcpZ+aBA03I729NP92FY94zi6
         HnB3a1zEBp+Xp8EOZ3afAaaFKEjIOamHkC+avMiYepcDNXUOJw8BefBtZZ5ak0eMnZxY
         HlWJPW8aYTolzZgs01/1U0WL1tIeakWSrP04cyo+As//XSpXx4H5hk7h9qY/MmyJK4Kv
         xiVOXKJoXTXSdxB3SgilMWWkFlcwl/itCXxdvcaQP/asx4SD1/j0NPT0t5dPD/W3dwW8
         JlZEOSJPUzaYcy2XooZQ+DLVCQlORb9pqoeB2rS4Ckzt4iQG9dAjSr3SHZRvlJK/QJJ/
         yGRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=sE7QzmHr;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=sE7QzmHr;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AB8JxZp4mVabGX9QBCjgOMbauZkiP/OZppeyIXEoyBi+S9BYkRfa9bQZsYfe6rasCs9Cuz5jCFIDPjBODKBXzm3acUY=
MIME-Version: 1.0
In-Reply-To: <20180425175557.GY14440@wotan.suse.de>
References: <20180408174014.21908-1-hdegoede@redhat.com> <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de> <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com> <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com> <20180425175557.GY14440@wotan.suse.de>
From: Martijn Coenen <maco@android.com>
Date: Fri, 4 May 2018 12:44:37 -0700
Message-ID: <CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Stephen Boyd <sboyd@kernel.org>,
	Vikram Mulukutla <markivx@codeaurora.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-security-module@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
	David Howells <dhowells@redhat.com>, Alan Cox <alan@linux.intel.com>,
	Kees Cook <keescook@chromium.org>, Hans de Goede <hdegoede@redhat.com>,
	Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>,
	Josh Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
	Kalle Valo <kvalo@codeaurora.org>, Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>, x86@kernel.org,
	linux-efi <linux-efi@vger.kernel.org>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199782052351527?=
X-GMAIL-MSGID: =?utf-8?q?1599563973085498552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 10:55 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Android became the primary user of CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
>
> It would be good for us to hear from Android folks if their current use of
> request_firmware_into_buf() is designed in practice to *never* use the direct
> filesystem firmware loading interface, and always rely instead on the
> fallback mechanism.

It's hard to answer this question for Android in general. As far as I
can tell the reasons we use CONFIG_FW_LOADER_USER_HELPER(_FALLBACK)
are:
1) We have multiple different paths on our devices where firmware can
be located, and the direct loader only supports one custom path
2) Most of those paths are not mounted by the time the corresponding
drivers are loaded, because pretty much all Android kernels today are
built without module support, and therefore drivers are loaded well
before the firmware partition is mounted
3) I think we use _FALLBACK because doing this with uevents is just
the easiest thing to do; our init code has a firmware helper that
deals with this and searches the paths that we care about

2) will change at some point, because Android is moving towards a
model where device-specific peripheral drivers will be loaded as
modules, and since those modules would likely come from the same
partition as the firmware, it's possible that the direct load would
succeed (depending on whether the custom path is configured there or
not). But I don't think we can rely on the direct loader even in those
cases, unless we could configure it with multiple custom paths.

I have no reason to believe request_firmware_into_buf() is special in
this regard; drivers that depend on it may have their corresponding
firmware in different locations, so just depending on the direct
loader would not be good enough.

>
> Is ptr below
>
>         ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
>                                         ptr, phdr->p_filesz);
>
> Also part of the DMA buffer allocated earlier via:
>
>         ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);
>
> Android folks?

I think the Qualcomm folks owning this (Andy, David, Bjorn, already
cc'd here) are better suited to answer that question.

Thanks,
Martijn
