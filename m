Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELvOXY5gHYtA+8t2oXGfKFhWkNNb3QudAyzv5SojBBlyvumJFPe+0Nfe5O2Bvg+Uqaxt95H+
ARC-Seal: i=1; a=rsa-sha256; t=1521404452; cv=none;
        d=google.com; s=arc-20160816;
        b=zdYJxyrUi3zaglcAF1J4mtA3jTQUG3vE+4AnYWDKpXd2qv7LntecgeYRYG0BsM1rEL
         Q/5JIIbEHmJM4WK3xQrcx+PZLBYTD8IeqM2a8JFVRzcBibQiIHRwEGqCKmNtOCs9NgwB
         UZGITug0PeVA1ungx3EnmHMDAGxxJsz7PQ8QUdd96j97X8PrJbvB+mRSUE7MCqA58AUI
         hBnn3b+gPU8dE8PAV2huvwQhviCbLdAnRiwEQoO6P4+fQaFb8cBz1LXJfulNybHZ3UAv
         dwYZC9aqo+xH+/+xlf0UFe8FCCuzSJOHWzhDblfqODLmJ8IIQgBJrVAIIelgXw7Ab5wC
         BzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=89xAItkYblio/rW/kw/cE3xUtpUajkodONEgyExRRaA=;
        b=v0NKh+7N+poDhSFhS9PP/8yUFbbg0L5ZWdQswLqAcVuktQOT19xfQ+Zq7sJbsX1hYE
         Ic0H4cu1Iko2AXUKJDQIJEmCjaTMGrL7YPvHlp08pMkm/C0oAXzIgd1Y8Liv/ulQ4dJp
         u3OsZYZ1tQ2FPBiIVLWeV4M5Wd3bndfcC5FqI2M6El9fnVUgnca0d0l7weQBgNbMzRQU
         JZ4Wqw8ctL7RtqHCFdYgFxno311T1M5uC909gO6YMo7HPRTdqFqiH0IzO63Q8jYzA6y4
         0vwC+CgYgeoaieuyBfJsk97t7zh6LeE5PVq30B4tWD2jEdoQRAhBgr50G/r73drH/pH0
         IhPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7326217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180314190039.GD15837@kroah.com>
References: <20180310141501.2214-1-mcgrof@kernel.org> <20180310141501.2214-12-mcgrof@kernel.org>
 <20180314190039.GD15837@kroah.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Sun, 18 Mar 2018 13:20:29 -0700
X-Gmail-Original-Message-ID: <CAB=NE6UWSdEUVzDo_stzkb2C8_FRZo9sS5d6oq9QJRME+JrGOw@mail.gmail.com>
Message-ID: <CAB=NE6UWSdEUVzDo_stzkb2C8_FRZo9sS5d6oq9QJRME+JrGOw@mail.gmail.com>
Subject: Re: [PATCH v3 11/20] firmware: enable to force disable the fallback
 mechanism at run time
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bitterblue of Monsea <cantabile.desu@gmail.com>, kubakici@wp.pl,
	linux-wireless <linux-wireless@vger.kernel.org>, Kees Cook <keescook@chromium.org>, shuah@kernel.org,
	Martin Fuzzey <mfuzzey@parkeon.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Takashi Iwai <tiwai@suse.de>, Arend Van Spriel <arend.vanspriel@broadcom.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Nicolas Broeking <nbroeking@me.com>, Vikram Mulukutla <markivx@codeaurora.org>,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay Salunke <Abhay_Salunke@dell.com>, Bjorn Andersson <bjorn.andersson@linaro.org>,
	jewalt@lgsinnovations.com, oneukum@suse.com, Alexei Starovoitov <ast@fb.com>,
	Andres Rodriguez <andresx7@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560429046312575?=
X-GMAIL-MSGID: =?utf-8?q?1595308194852110806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:00 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sat, Mar 10, 2018 at 06:14:52AM -0800, Luis R. Rodriguez wrote:
>> You currently need four different kernel builds to test the firmware
>> API fully. By adding a proc knob to force disable the fallback mechanism
>> completely we are able to reduce the amount of kernels you need built
>> to test the firmware API down to two.
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
>> ---
>>  drivers/base/firmware_loader/fallback.c       | 5 +++++
>>  drivers/base/firmware_loader/fallback.h       | 4 ++++
>>  drivers/base/firmware_loader/fallback_table.c | 9 +++++++++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
>> index 45cc40933a47..d6838e7ec00c 100644
>> --- a/drivers/base/firmware_loader/fallback.c
>> +++ b/drivers/base/firmware_loader/fallback.c
>> @@ -643,6 +643,11 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
>>
>>  static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>>  {
>> +     if (fw_fallback_config.ignore_sysfs_fallback) {
>> +             pr_info_once("Ignoring firmware sysfs fallback due to debugfs knob\n");
>
> s/debugfs/sysctl/ right?

Indeed. Will respin with the other space fix. As for the other changes
let me know if you have further feedback or if I should just keep them
as-is.

  Luis
