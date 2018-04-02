Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522663320; cv=none;
        d=google.com; s=arc-20160816;
        b=qPcJFCJI/ztbFN2mJV7jPwAInhgCgbR8jVtwrevGhXhnw9v8L+ACEbiNm3jbNJ9JpJ
         GCz2IbSDxVCnBkSSi/aUlB0HO+uHVmF5UUPkEta7H2Kk5Y4PdUD7FSi3h1PhdbY+WmIP
         Urvxptz5TTs9f30fQR7zp8Pp03ICEF9js+8Q4Shg8tU1GdtM2UVf+8BG/x4YGASMq5Mp
         8jM7tby2mSnmhkBGzXsQzhIfgwxvRCRxDB1c1zfhzQIrmgGygZVvNgaVaVQxhe0m35S2
         OfGGkytmb0L8AZtfjJqmrfJjlic80nxRiM1JA0tFy4dAUYguoKaKKhHgGL9Zw730k+E2
         qOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=3rCKbM3F7+fSlgZLVlT5FFTLEzTFr+rr9sVr8ePZ51Q=;
        b=eb+60+7qQ6OgCg5+TM4Hf96ybtpzo04BEmuKw7uTw7WvRsaykHzlZcthehTMi6laJF
         2tnfcN9wIOULh47w5DyGDZrOnqlt2SS8nw/rBnduUNsfnSe0TIcQQSoEzxDwghbtpVYL
         9kdUaJpmaTJyXAvFxwAS3+uHDf8jfw+MhEXEOTCO5mRjWg2JNFPs52elETnK2k4wu8F1
         Pv7724RMmkMMSn60V4NV+Tg3PQL9z0JRnQbi30wIVwbfIZb2yd4LJOShpMHFoWTXdq7N
         R99GA2IGjo3xgmN4raHpcIo7/J3yYQl98zWlnzdR+nN2LM+ui5sbjuMlQn3cLwZiuRXz
         Zvpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aRZun2t/;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aRZun2t/;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49Bb0/L0Zp3tak/JBHKNj+xPnaEvNRc6jml2SJoP8OE8R0psoV+Bwv5Ej6SKKa8US9BwbDC75IKbhpQ03mefw8=
MIME-Version: 1.0
In-Reply-To: <20180402071133.GA62369@rodete-desktop-imager.corp.google.com>
References: <20180329065424.203172-1-minchan@kernel.org> <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
 <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
 <20180330100407.GB19140@kroah.com> <20180402063448.GA250086@rodete-desktop-imager.corp.google.com>
 <CADAEsF8_vptm7p2y2ekj8m6t=bz4pwC1+np7r2-YnAKbnEsA4w@mail.gmail.com> <20180402071133.GA62369@rodete-desktop-imager.corp.google.com>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Mon, 2 Apr 2018 18:01:59 +0800
Message-ID: <CADAEsF9QcH8-TpG+-b2Pde0UysVC5Dzt4iUXpw9ksvReMo42mg@mail.gmail.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
To: Minchan Kim <minchan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Joe Perches <joe@perches.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1596628214245881214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-02 15:11 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> On Mon, Apr 02, 2018 at 02:46:14PM +0800, Ganesh Mahendran wrote:
>> 2018-04-02 14:34 GMT+08:00 Minchan Kim <minchan@kernel.org>:
>> > On Fri, Mar 30, 2018 at 12:04:07PM +0200, Greg Kroah-Hartman wrote:
>> >> On Fri, Mar 30, 2018 at 10:29:21AM +0900, Minchan Kim wrote:
>> >> > Hi Ganesh,
>> >> >
>> >> > On Fri, Mar 30, 2018 at 09:21:55AM +0800, Ganesh Mahendran wrote:
>> >> > > 2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
>> >> > > > binder_update_page_range needs down_write of mmap_sem because
>> >> > > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
>> >> > > > it is set. However, when I profile binder working, it seems
>> >> > > > every binder buffers should be mapped in advance by binder_mmap.
>> >> > > > It means we could set VM_MIXEDMAP in binder_mmap time which is
>> >> > > > already hold a mmap_sem as down_write so binder_update_page_range
>> >> > > > doesn't need to hold a mmap_sem as down_write.
>> >> > > >
>> >> > > > Android suffers from mmap_sem contention so let's reduce mmap_sem
>> >> > > > down_write.
>> >> > >
>> >> > > Hi, Minchan:
>> >> > >
>> >> > > It seems there is performance regression of this patch.
>> >> >
>> >> > You mean "This patch aims for solving performance regression" not "This patch
>> >> > makes performance regression"?
>> >> >
>> >> > >
>> >> > > Do you have some test result of android app launch time or binderThroughput?
>> >> >
>> >> > Unfortunately, I don't have any number. The goal is to reduce the number of
>> >> > call mmap_sem as write-side lock because it makes priority inversion of threads
>> >> > easily and that's one of clear part I spot that we don't need write-side lock.
>> >>
>> >> Please always run the binderThroughput tests when making binder changes
>> >> (there is a binder test suite in the CTS Android tests), as that ensures
>> >> that you are not causing performance regressions as well as just normal
>> >> bug regressions :)
>> >
>> > Thanks for the information. I didn't notice that such kinds of tests for
>> > binder. I will keep it in mind.
>> >
>> > Today, I have setup the testing for my phone and found testing was very
>> > fluctuating even without my patch. It might be not good with my test
>> > skill. I emulated user's behavior with various touch event. With it, I open
>> > various apps and play with them several times. Before starting the test,
>> > I did "adb shell stop && adb shell start && echo 3 > /proc/sys/vm/drop_caches"
>> >
>> > Such 15% noise was very easy to make it.
>> >
>> > Ganesh, How did you measure? What's the stddev?
>>
>> Hi, Minchan:
>>
>> Sorry for the late response, a little busy these days. :)
>>
>> We have our own test tools to measure app launch time, or you can use
>> android systrace to get the app launch time. We tested your V1 patch:
>> https://patchwork.kernel.org/patch/10312057/
>> and found app lunch time regression.
>
> V1 had a bug with VM_MAYWRITE. Could you confirm it with v5?

I have finished binder Throughput test. The test result is stable,
there is no performance
regression found both in v1 and v5.

            base            patch_v1         patch_v5
-----------------------------------------------------------
            91223.4      90560.2           89644.5
            90520.3      89583.1           89048.2
            89833.2      90247.6           90091.3
            90740.2      90276.7           90994.2
            89703.5      90112.4           89994.6
            89945.1      89122.8           88937.7
            89872.8      90357.3           89307.4
            89913.2      90355.4           89563.8
            88979         90393.4           90182.8
            89577.3      90946.8           90441.4
AVG    90030.8      90195.57          89820.59

Before the test, I stop the android framework by:
    adb shell stop

>
> Please tell me more detail. What apps are slower compared to old?
> Every apps are slowed with avg 15%? Then, what's the stddev?

Not all of the apps slowed 15%, The app *avg* launch time slowed 15%.
And We will re-launch the test tomorrow: base, v1,v5. We will get the
test result in two days later. Then I will post all the app launch time details.

>
> The reason I'm asking is as I mentioned, it would be caused by rw_semaphore
> implementation and priority of threads which calls binder operation so I
> guess it would be not deterministic.
>
> When I had an simple experiment, it was very fluctuating as I expected.
> (the testing enviroment might be not good in my side).
> If it's real problem on real practice, better fix is not using write_lock
> of mmap_sem(it's abusing the write-side lock)  but should adjust priority,
> I think. What do you think?

If you want to narrow the range of the problem. We can disable binder priority
inherit, and do not set the priority(currently it is nice -10 or fifo)
of top app in Android AMS.
I think we need to wait for the test result to see whether it really
has performance
regression.

>
> Anyway, before the further discussion, we should confirm the root cause.
>
>>
>> I will use binderThroghput tool to test the patch today or tomorrow.
>>
>
> Thanks. I will do.
