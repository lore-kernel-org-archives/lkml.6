Return-Path: <tedheadster@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517955097; cv=none;
        d=google.com; s=arc-20160816;
        b=dLrltSn7WRolO7S5FjSkeNmkvKdbsWQygKhMdW+LOvrlERjE3uM9rv8EIGJPQHuwbY
         6oh4mJqAv8JX9LHiID/HDpHZOvROMHY4IsVtlkYNr02hzREzuKGRB9hTBi4KRdjLP/b7
         QmY7R+AUMCXTAkJQTCKQJoao5M++E4B+8b4/9W39Cu63l54eiQkxl2CQuFy10dHVtX7g
         fo44L1VZvzbUnuOX64RHULn4lbzK0OpODJP0+Y1fIWRpNbSB4UiVPldd1xuRhdIcuNNH
         54WcNp4mvObGLCkExZ4byXjcXF8YlBxOchEI2kctMhzUrOT5cbrkH++VefWkpI82zoPk
         w1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=GFNSIzIgIE/X3soIs65womL+CQ6OZ1xdlRfP0GWC3RM=;
        b=kCWOZqgdkqmK7DuOV/IV3lo+DlYlc4UJQEvXGXojt4aFcv0Pfyd+g7J4L6o+6OvqMU
         HA1By5CDNeUfkme5kwIccIxC9Cxqralk1y/mEOnoD4P86CDiqsJDS5WSqSIctiVj75lW
         j88PMv0bj5DtbKkHYCw/UNEshiwlcxAk5kc98hOIn4mvXcT7mlLCfDYAMo3923KwPBF6
         RoKynz+DEmTkASasBFF8D1xwn8pZjPR1HuvOUSxaZBHg7fnfCB4aPuXYmBFgnJ1a6P1R
         D8WPVfCoIunVkpD2RwzbQ6d7HwgiKtSSXuXoB1dWhynZR7P1KnHKBKUc167Vsx+/SknU
         v8wA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ijuXsKlt;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ijuXsKlt;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226lCV1zr7lrPjgTRVOqZycSe4lzuQmT747/AlUYu6HehXcbMr8mGUfHwpX8tYI6WyjsWmisKZR261WOM2brfG8=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <1517950494.3677.30.camel@infradead.org>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517643438.31953.108.camel@infradead.org> <CAP8WD_Yrp5g6YZwV+XQTx93YpTakWEL8MD+p0bZDaPi3-r88JQ@mail.gmail.com>
 <20180206190233.GA10476@kroah.com> <1517944227.3677.15.camel@infradead.org>
 <20180206191355.GA7424@roeck-us.net> <1517944648.3677.18.camel@infradead.org>
 <CAP8WD_Znj+zG6hVD3zV+9tTJs0OEZtbQTy=XGOj3hurtRRXhVQ@mail.gmail.com>
 <CAP8WD_Ztwp3dLvv+kbQ9QizWHWCwpZnnXxQ++Z0OVnLnaj01+Q@mail.gmail.com> <1517950494.3677.30.camel@infradead.org>
From: tedheadster <tedheadster@gmail.com>
Date: Tue, 6 Feb 2018 17:11:16 -0500
Message-ID: <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: David Woodhouse <dwmw2@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hugh Dickins <hughd@google.com>, dave.hansen@linux.intel.com, jikos@kernel.org,
	Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
	eduval@amazon.com, labbott@redhat.com, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591691284839446666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 3:54 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2018-02-06 at 15:45 -0500, tedheadster wrote:
>>
>> If that is correct (and I might be wrong), then I am up to date and I
>> am still getting the following in /proc/cpuinfo on my Pentium 4M i686:
>>
>> bugs  : cpu_meltdown spectre_v1 spectre_v2
>
> That's expected for now. The CPUs we exempt are as follows:
>
> static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
>         { X86_VENDOR_INTEL,     6, INTEL_FAM6_ATOM_CEDARVIEW,   X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL,     6, INTEL_FAM6_ATOM_CLOVERVIEW,  X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL,     6, INTEL_FAM6_ATOM_LINCROFT,    X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL,     6, INTEL_FAM6_ATOM_PENWELL,     X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL,     6, INTEL_FAM6_ATOM_PINEVIEW,    X86_FEATURE_ANY },
>         { X86_VENDOR_CENTAUR,   5 },
>         { X86_VENDOR_INTEL,     5 },
>         { X86_VENDOR_NSC,       5 },
>         { X86_VENDOR_ANY,       4 },
>         {}
> };
>
> Alan is going to improve that list, but your Pentium 4 isn't on it yet.
>
> The bugs went away on the 486 though, right?

Okay, recompiled for the i486 and it reports no bugs.

As for the i686, it is really a "Mobile Pentium 4 HT" Prescott series
(https://ark.intel.com/products/27368/Mobile-Intel-Pentium-4-Processor-532-supporting-HT-Technology-1M-Cache-3_06-GHz-533-MHz-FSB).
Does that make it a 'speculative execution' processor?

Thank you for the help and I'll test more of the museum pieces.

- Matthew
