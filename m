Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523350379; cv=none;
        d=google.com; s=arc-20160816;
        b=q7VVBkvzhAxRElrevAOSW0c9NQk15vTrdi2oJmI732tunEJYD2QWXwfqin1rBC8FgI
         Wb9Z5IzX1pi99mc32j+D6MqnM8+sdRNNcSB627Zgk9oxVdM3tV2GbSM0j+oN1xFyRZYY
         nmJdv7J+5hl7pfQoJgtSVQWQR3v2FovSu/IBvK0Y1Y/CQSlD+E1EujASxUu5MIjSNkNz
         oDcODH8yNyMFrrMUcxSaskLjiN/dAvMiYpEOBDMCrgPihS4pKteqqwnk3pwOoC0GDQ2K
         WFGDz6Zs7ZYNu5vaDAD6v0BN0WjxaxhZb9YggNZ5mgtGFK0BeL7QR7pj3lY+lqtkSsCQ
         vi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UnYpSXtDBvSavoPFliTaqd6gFmbYuhUFVRDMgZhDQFA=;
        b=buDkXNRc/PeI6A2t6kEcD9GIPuCuQ8ksgBhr7QVT/fjycyNUeJ0fY0n1Kq2yKSV52Q
         iVBvMuuKJWLdceUV6L2gZ3CYrq3GJVPfDe3lKCK6zHUH2f4dH7/+wiO0n5HC3gSyzXv5
         G8c1zOYEqCwPBEkHPig3PkleskqMwtQxJsUS1Ga18ZVRgBoI77CxvOSFk+eipkXeKH/F
         ukE5dqjkJDimGBXD08oOLNWvRvU5EwheusWsgMDE9EmRmH8u3ogXxuwcxD6N0qKxlrWz
         1xVqK1gzt+VWApKqVS9JupMpzSmGxwD6BMZNoNlQIxew4ULgNOHHapxUkA00ZI3QgG8W
         bn6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ci/hisQO;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ci/hisQO;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/SPcZJBrDzaO4iaINw57iNliwCxLRk59s2z2OEcMUNqCxc3P1GTCJS8Vu7KaFkrwHQD/g5ICKoWeKvMph2h6Q=
MIME-Version: 1.0
In-Reply-To: <20180402103204.GB62369@rodete-desktop-imager.corp.google.com>
References: <20180329065424.203172-1-minchan@kernel.org> <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
 <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
 <20180330100407.GB19140@kroah.com> <20180402063448.GA250086@rodete-desktop-imager.corp.google.com>
 <CADAEsF8_vptm7p2y2ekj8m6t=bz4pwC1+np7r2-YnAKbnEsA4w@mail.gmail.com>
 <20180402071133.GA62369@rodete-desktop-imager.corp.google.com>
 <CADAEsF9QcH8-TpG+-b2Pde0UysVC5Dzt4iUXpw9ksvReMo42mg@mail.gmail.com> <20180402103204.GB62369@rodete-desktop-imager.corp.google.com>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Tue, 10 Apr 2018 16:52:58 +0800
Message-ID: <CADAEsF_-uv9Xq7RGGz76mZ3JBBetg6vBSB5CtH8B5Xb1YJTYsQ@mail.gmail.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
To: Minchan Kim <minchan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Joe Perches <joe@perches.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596254032587353794?=
X-GMAIL-MSGID: =?utf-8?q?1597348647624141182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-02 18:32 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> Hi Ganesh,
>
> On Mon, Apr 02, 2018 at 06:01:59PM +0800, Ganesh Mahendran wrote:
>> 2018-04-02 15:11 GMT+08:00 Minchan Kim <minchan@kernel.org>:
>> > On Mon, Apr 02, 2018 at 02:46:14PM +0800, Ganesh Mahendran wrote:
>> >> 2018-04-02 14:34 GMT+08:00 Minchan Kim <minchan@kernel.org>:
>> >> > On Fri, Mar 30, 2018 at 12:04:07PM +0200, Greg Kroah-Hartman wrote:
>> >> >> On Fri, Mar 30, 2018 at 10:29:21AM +0900, Minchan Kim wrote:
>> >> >> > Hi Ganesh,
>> >> >> >
>> >> >> > On Fri, Mar 30, 2018 at 09:21:55AM +0800, Ganesh Mahendran wrote:
>> >> >> > > 2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
>> >> >> > > > binder_update_page_range needs down_write of mmap_sem because
>> >> >> > > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
>> >> >> > > > it is set. However, when I profile binder working, it seems
>> >> >> > > > every binder buffers should be mapped in advance by binder_mmap.
>> >> >> > > > It means we could set VM_MIXEDMAP in binder_mmap time which is
>> >> >> > > > already hold a mmap_sem as down_write so binder_update_page_range
>> >> >> > > > doesn't need to hold a mmap_sem as down_write.
>> >> >> > > >
>> >> >> > > > Android suffers from mmap_sem contention so let's reduce mmap_sem
>> >> >> > > > down_write.
>> >> >> > >
>> >> >> > > Hi, Minchan:
>> >> >> > >
>> >> >> > > It seems there is performance regression of this patch.
>> >> >> >
>> >> >> > You mean "This patch aims for solving performance regression" not "This patch
>> >> >> > makes performance regression"?
>> >> >> >
>> >> >> > >
>> >> >> > > Do you have some test result of android app launch time or binderThroughput?
>> >> >> >
>> >> >> > Unfortunately, I don't have any number. The goal is to reduce the number of
>> >> >> > call mmap_sem as write-side lock because it makes priority inversion of threads
>> >> >> > easily and that's one of clear part I spot that we don't need write-side lock.
>> >> >>
>> >> >> Please always run the binderThroughput tests when making binder changes
>> >> >> (there is a binder test suite in the CTS Android tests), as that ensures
>> >> >> that you are not causing performance regressions as well as just normal
>> >> >> bug regressions :)
>> >> >
>> >> > Thanks for the information. I didn't notice that such kinds of tests for
>> >> > binder. I will keep it in mind.
>> >> >
>> >> > Today, I have setup the testing for my phone and found testing was very
>> >> > fluctuating even without my patch. It might be not good with my test
>> >> > skill. I emulated user's behavior with various touch event. With it, I open
>> >> > various apps and play with them several times. Before starting the test,
>> >> > I did "adb shell stop && adb shell start && echo 3 > /proc/sys/vm/drop_caches"
>> >> >
>> >> > Such 15% noise was very easy to make it.
>> >> >
>> >> > Ganesh, How did you measure? What's the stddev?
>> >>
>> >> Hi, Minchan:
>> >>
>> >> Sorry for the late response, a little busy these days. :)
>> >>
>> >> We have our own test tools to measure app launch time, or you can use
>> >> android systrace to get the app launch time. We tested your V1 patch:
>> >> https://patchwork.kernel.org/patch/10312057/
>> >> and found app lunch time regression.
>> >
>> > V1 had a bug with VM_MAYWRITE. Could you confirm it with v5?
>>
>> I have finished binder Throughput test. The test result is stable,
>> there is no performance
>> regression found both in v1 and v5.
>
> Thanks for the test! Now I'm struggling with setting up BinderThrough test.
> Binder matainers:
> If it's really one every binder contributors should do before the
> sending their patch, couldn't we have them in kernel directory like kselftest?

BinderThrough tool depends on some android libs. It seems not easy to
put them in kernel dir.

> Like me who understand just a part of code, it's hard to download android
> userspace full code and build/test.
>
>
>>
>>             base            patch_v1         patch_v5
>> -----------------------------------------------------------
>>             91223.4      90560.2           89644.5
>>             90520.3      89583.1           89048.2
>>             89833.2      90247.6           90091.3
>>             90740.2      90276.7           90994.2
>>             89703.5      90112.4           89994.6
>>             89945.1      89122.8           88937.7
>>             89872.8      90357.3           89307.4
>>             89913.2      90355.4           89563.8
>>             88979         90393.4           90182.8
>>             89577.3      90946.8           90441.4
>> AVG    90030.8      90195.57          89820.59
>
> Yes, no regression.
>
>>
>> Before the test, I stop the android framework by:
>>     adb shell stop
>>
>> >
>> > Please tell me more detail. What apps are slower compared to old?
>> > Every apps are slowed with avg 15%? Then, what's the stddev?
>>
>> Not all of the apps slowed 15%, The app *avg* launch time slowed 15%.
>> And We will re-launch the test tomorrow: base, v1,v5. We will get the
>> test result in two days later. Then I will post all the app launch time details.
>
> I'm also trying to make stable result in my side but it's really hard to
> get. Please post stddev of each app as well as avg when you finished testing.
> I really appreicate you.

What do you mean by stddev?

We test 80 loops and launch ~40 apps in each loop.
Below is the app launch time result:

app base v1 diff percent v5 diff percent
----
com.tencent.mobileqq 829 834 5 1% 879 50 6%
com.tencent.qqmusic 799 790 -9 -1% 764 -35 -4%
com.tencent.mtt 659 655 -4 -1% 979 320 49%
com.UCMobile 1149 1144 -5 0% 927 -222 -19%
com.qiyi.video 1557 1579 22 1% 1497 -60 -4%
com.baidu.BaiduMap 1137 1136 -1 0% 1096 -41 -4%
tv.danmaku.bili 3642 3655 13 0% 3538 -104 -3%
com.sdu.didi.psnger 4334 4352 18 0% 4224 -110 -3%
com.ss.android.ugc.aweme 1958 1970 12 1% 1884 -74 -4%
air.tv.douyu.android 3333 3371 38 1% 3251 -82 -2%
me.ele 3183 3182 -1 0% 3178 -5 0%
com.autonavi.minimap 1920 1922 2 0% 1868 -52 -3%
com.duowan.kiwi 1452 1457 5 0% 1349 -103 -7%
com.v.study 3549 3558 9 0% 3519 -30 -1%
com.qqgame.hlddz 4074 4060 -14 0% 4443 369 9%
com.ss.android.article.news 1631 1680 49 3% 1649 18 1%
com.jingdong.app.mall 1448 1443 -5 0% 1323 -125 -9%
com.tencent.tmgp.pubgmhd 1703 1706 3 0% 1601 -102 -6%
com.kugou.android 854 862 8 1% 791 -63 -7%
com.kuaikan.comic 1341 1374 33 2% 2118 777 58%
com.smile.gifmaker 798 686 -112 -14% 642 -156 -20%
com.hunantv.imgo.activity 1560 1616 56 4% 1569 9 1%
com.mt.mtxx.mtxx 1746 1838 92 5% 1773 27 2%
com.sankuai.meituan 3610 3697 87 2% 3551 -59 -2%
com.sankuai.meituan.takeoutnew 3376 3387 11 0% 3325 -51 -2%
com.meitu.meiyancamera 1905 2010 105 6% 1870 -35 -2%
com.tencent.karaoke 888 906 18 2% 896 8 1%
com.taobao.taobao 3344 3406 62 2% 3368 24 1%
com.tencent.qqlive 1314 1345 31 2% 1499 185 14%
com.tmall.wireless 3746 3735 -11 0% 3699 -47 -1%
com.tencent.tmgp.sgame 3250 3513 263 8% 3707 457 14%
com.netease.cloudmusic 2550 2570 20 1% 2546 -4 0%
com.sina.weibo 2201 2240 39 2% 2191 -10 0%
com.tencent.mm 638 645 7 1% 690 52 8%
com.immomo.momo 1536 1554 18 1% 1563 27 2%
com.xiaomi.hm.health 915 926 11 1% 888 -27 -3%
com.youku.phone 1881 1820 -61 -3% 1880 -1 0%
com.eg.android.AlipayGphone 1536 1557 21 1% 1624 88 6%
com.meituan.qcs.c.android 3140 3533 393 13% 3171 31 1%
-----
average 2064 2095 31 1.50% 2085 21 1%

1% is in the fluctuating range of our tool.
So no obvious regression found in app launch time.

>
>>
>> >
>> > The reason I'm asking is as I mentioned, it would be caused by rw_semaphore
>> > implementation and priority of threads which calls binder operation so I
>> > guess it would be not deterministic.
>> >
>> > When I had an simple experiment, it was very fluctuating as I expected.
>> > (the testing enviroment might be not good in my side).
>> > If it's real problem on real practice, better fix is not using write_lock
>> > of mmap_sem(it's abusing the write-side lock)  but should adjust priority,
>> > I think. What do you think?
>>
>> If you want to narrow the range of the problem. We can disable binder priority
>> inherit, and do not set the priority(currently it is nice -10 or fifo)
>> of top app in Android AMS.
>> I think we need to wait for the test result to see whether it really
>> has performance
>> regression.
>
> Look at up_write.
>
> (Let's assume process B is head of wait list of rw_semaphore, and then C, D, E)
> If the process B is trying to down_write and previous lock holder A is
> called up_write, the only B could be waked up so there is no contention
> to get CPU slice. It's the current as-is but if we changes B to try to
> down_read instead of down_write, B should be competed with other down_read
> C,D,E in so the chance would be rare to be scheduled.

Sorry , I did not get your point.

In below scenario:
---
A   down_write
B, C, D , E  down_read
A   up_write
B, C, D, E will all be waked up

>
> It's really (timing|priority of binder and other threads) problem so I don't
> understand what you said how we could narrow down the problem with disabling
> binder priority.
