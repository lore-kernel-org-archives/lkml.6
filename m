Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BB0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8E6208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDDnig4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8E6208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeHXX4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:56:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33889 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeHXX4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:56:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so8422409wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c9yDvo6xKRF+l7Fhu32z/LWZp1o65Tby7eUu3bBh8UY=;
        b=aDDnig4CHU1iwv+KBPE5QFWwB+Yjp2IWIHQBipimyRXhTc0rHQE/QiMTU9x2kzWwgN
         8mH+MT8Jmuvn4Vu0ugDQBxP0PLCX/LewTU0i71JjHeFO33zPf+LhS8CCCuvpzJ7093aU
         O94RAOZprOBzFTIa/nLWYacFSvos8RoyNBwls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c9yDvo6xKRF+l7Fhu32z/LWZp1o65Tby7eUu3bBh8UY=;
        b=mzhDlknpN5u8KTxT1mZ6Y4p2sKb/Q7jiwKYiB2vrOdvmpsFLuzkoKlb60DaWdIGK4t
         0svICmHRwE89ziCgi/mUXULZGld+lwVTem5B84MwMm/3QecFgHViFPgwaaavQz0BNHlD
         LOQ/c+nGgpg7kn/ZSGzg9lg4B4S6mtbOoT4BV6KvDeNmnwxt72FQ5dv5i7cXbDu0/tLf
         RRCKjFGDLtiHiY/HA47HehdmP+eMqONiGLF1qv01QkjB9Oc6Th+jdUKEbiHgdHXZDF5h
         R9YjWBzLaplRHBTtmZCXuwGnBTvumpBZVYMASEHR3Xh5oHqRJ2ZN6MOjs3mh+EhmzZI7
         ia8g==
X-Gm-Message-State: APzg51D0ne8/3WiSlPXgk20M35UvnZhyg8amufwgLB6tJRfx7XS0TdkE
        LTJQGxOFwmSG7aQqDQqw5pg4v0BnaVDgAVX1eveiUQ==
X-Google-Smtp-Source: ANB0Vdb7UYBtavMsA+QU1L6p6OOj7EuzW1qRdSEUqTDSVhl4GGqEy+QkCaiXx+2m4IbJjuqmc8wBEAwTB5aVlV7L0Rc=
X-Received: by 2002:a5d:66d2:: with SMTP id k18-v6mr2201083wrw.154.1535142042354;
 Fri, 24 Aug 2018 13:20:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 13:20:41
 -0700 (PDT)
In-Reply-To: <20180824194703.h3mbuhrxzixmna4e@madcap2.tricolour.ca>
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-3-omosnace@redhat.com>
 <20180824194703.h3mbuhrxzixmna4e@madcap2.tricolour.ca>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 24 Aug 2018 13:20:41 -0700
Message-ID: <CALAqxLXtdzhm3B2YJOx0ptM3wg+YE+nM1pWk+aS0Gf3p9ue+Jw@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 2/2] timekeeping/ntp: Audit clock/NTP params adjustments
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, linux-audit@redhat.com,
        lkml <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 12:47 PM, Richard Guy Briggs <rgb@redhat.com> wrote=
:
> On 2018-08-24 14:00, Ondrej Mosnacek wrote:
>> This patch adds logging of all attempts to either inject an offset into
>> the clock (producing an AUDIT_TIME_INJOFFSET record) or adjust an NTP
>> parameter (producing an AUDIT_TIME_ADJNTPVAL record).
>
> I thought I saw it suggested earlier in one of the replies to a previous
> revision of the patchset to separate the two types of records with their
> calling circumstances.  The inj-offset bits could stand alone in their
> own patch leaving all the rest in its own patch.  The record numbers and
> examples are easier to offer when given together, but they aren't as
> clear they are indepnendent records and callers.  That way, each patch
> stands on its own.  (more below)
>
>> For reference, running the following commands:
>>
>>     auditctl -D
>>     auditctl -a exit,always -F arch=3Db64 -S adjtimex
>>     chronyd -q
>>
>> produces audit records like this:
>>
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.507:5): op=3Dadjust old=3D0=
 new=3D0
>> type=3DSYSCALL msg=3Daudit(1530616044.507:5): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78c00 a1=3D0 a2=3D4 a3=3D7f754ae28c0=
a items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0=
 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=3D"chronyd=
" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0 key=3D(nul=
l)
>> type=3DPROCTITLE msg=3Daudit(1530616044.507:5): proctitle=3D6368726F6E79=
64002D71
>> type=3DSYSCALL msg=3Daudit(1530616044.507:6): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78c00 a1=3D1 a2=3D1 a3=3D7f754ae28c0=
a items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0=
 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=3D"chronyd=
" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0 key=3D(nul=
l)
>> type=3DPROCTITLE msg=3Daudit(1530616044.507:6): proctitle=3D6368726F6E79=
64002D71
>> type=3DTIME_INJOFFSET msg=3Daudit(1530616044.507:7): sec=3D0 nsec=3D0
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.507:7): op=3Dstatus old=3D6=
4 new=3D8256
>> type=3DSYSCALL msg=3Daudit(1530616044.507:7): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78c00 a1=3D1 a2=3D1 a3=3D7f754ae28c0=
a items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0=
 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=3D"chronyd=
" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0 key=3D(nul=
l)
>> type=3DPROCTITLE msg=3Daudit(1530616044.507:7): proctitle=3D6368726F6E79=
64002D71
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.507:8): op=3Dstatus old=3D8=
256 new=3D8257
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.507:8): op=3Doffset old=3D0=
 new=3D0
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.507:8): op=3Dfreq old=3D0 n=
ew=3D0
>> type=3DSYSCALL msg=3Daudit(1530616044.507:8): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78ab0 a1=3D0 a2=3D55e129c850c0 a3=3D=
7f754ae28c0a items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=
=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 co=
mm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:=
s0 key=3D(null)
>> type=3DPROCTITLE msg=3Daudit(1530616044.507:8): proctitle=3D6368726F6E79=
64002D71
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.507:9): op=3Dstatus old=3D8=
257 new=3D64
>> type=3DSYSCALL msg=3Daudit(1530616044.507:9): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78ab0 a1=3D0 a2=3D55e129c850c0 a3=3D=
7f754ae28c0a items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 euid=
=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 co=
mm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:=
s0 key=3D(null)
>> type=3DPROCTITLE msg=3Daudit(1530616044.507:9): proctitle=3D6368726F6E79=
64002D71
>> type=3DSYSCALL msg=3Daudit(1530616044.507:10): arch=3Dc000003e syscall=
=3D159 success=3Dyes exit=3D5 a0=3D7fff57e78a70 a1=3D0 a2=3D55e129c850c0 a3=
=3D7f754ae28c0a items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D0 gid=3D0 eui=
d=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 c=
omm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t=
:s0 key=3D(null)
>> type=3DPROCTITLE msg=3Daudit(1530616044.507:10): proctitle=3D6368726F6E7=
964002D71
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.511:11): op=3Dfreq old=3D0 =
new=3D49180377088000
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.511:11): op=3Dtick old=3D10=
000 new=3D10000
>> type=3DSYSCALL msg=3Daudit(1530616044.511:11): arch=3Dc000003e syscall=
=3D159 success=3Dyes exit=3D5 a0=3D7fff57e78ad0 a1=3D0 a2=3D2710 a3=3Df42f8=
2a800000 items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D385 gid=3D382 euid=
=3D385 suid=3D385 fsuid=3D385 egid=3D382 sgid=3D382 fsgid=3D382 tty=3D(none=
) ses=3D1 comm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system=
_r:kernel_t:s0 key=3D(null)
>> type=3DPROCTITLE msg=3Daudit(1530616044.511:11): proctitle=3D6368726F6E7=
964002D71
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616044.521:12): op=3Dstatus old=3D=
64 new=3D64
>> type=3DSYSCALL msg=3Daudit(1530616044.521:12): arch=3Dc000003e syscall=
=3D159 success=3Dyes exit=3D5 a0=3D7fff57e78b40 a1=3D1 a2=3D40 a3=3Df91f6ef=
84fbab items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D385 gid=3D382 euid=3D3=
85 suid=3D385 fsuid=3D385 egid=3D382 sgid=3D382 fsgid=3D382 tty=3D(none) se=
s=3D1 comm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:k=
ernel_t:s0 key=3D(null)
>> type=3DPROCTITLE msg=3Daudit(1530616044.521:12): proctitle=3D6368726F6E7=
964002D71
>> type=3DTIME_INJOFFSET msg=3Daudit(1530616049.652:13): sec=3D-16 nsec=3D1=
24887145
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616049.652:13): op=3Dstatus old=3D=
64 new=3D8256
>> type=3DSYSCALL msg=3Daudit(1530616049.652:13): arch=3Dc000003e syscall=
=3D159 success=3Dyes exit=3D5 a0=3D7fff57e78270 a1=3D1 a2=3Dfffffffffffffff=
0 a3=3D137b828205ca12 items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D385 gid=
=3D382 euid=3D385 suid=3D385 fsuid=3D385 egid=3D382 sgid=3D382 fsgid=3D382 =
tty=3D(none) ses=3D1 comm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsyst=
em_u:system_r:kernel_t:s0 key=3D(null)
>> type=3DPROCTITLE msg=3Daudit(1530616049.652:13): proctitle=3D6368726F6E7=
964002D71
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616033.783:14): op=3Dfreq old=3D49=
180377088000 new=3D49180377088000
>> type=3DTIME_ADJNTPVAL msg=3Daudit(1530616033.783:14): op=3Dtick old=3D10=
000 new=3D10000
>> type=3DSYSCALL msg=3Daudit(1530616033.783:14): arch=3Dc000003e syscall=
=3D159 success=3Dyes exit=3D5 a0=3D7fff57e78bc0 a1=3D0 a2=3D2710 a3=3D0 ite=
ms=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D385 gid=3D382 euid=3D385 suid=3D=
385 fsuid=3D385 egid=3D382 sgid=3D382 fsgid=3D382 tty=3D(none) ses=3D1 comm=
=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_u:system_r:kernel_t:s0=
 key=3D(null)
>> type=3DPROCTITLE msg=3Daudit(1530616033.783:14): proctitle=3D6368726F6E7=
964002D71
>>
>> The chronyd command that produced the above records executed the
>> following adjtimex(2) syscalls (as per strace output):
>>
>> adjtimex({modes=3DADJ_OFFSET|0x8000, offset=3D0, freq=3D0, maxerror=3D16=
000000, esterror=3D16000000, status=3DSTA_UNSYNC, constant=3D2, precision=
=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D507215},=
 tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitcnt=3D0, =
calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
>> adjtimex({modes=3DADJ_MAXERROR, offset=3D0, freq=3D0, maxerror=3D0, este=
rror=3D16000000, status=3DSTA_UNSYNC, constant=3D2, precision=3D1, toleranc=
e=3D32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D507438}, tick=3D10000,=
 ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitcnt=3D0, calcnt=3D0, er=
rcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
>> adjtimex({modes=3DADJ_SETOFFSET|ADJ_NANO, offset=3D0, freq=3D0, maxerror=
=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC|STA_NANO, constant=3D=
2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616044, tv_use=
c=3D507604737}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D=
0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ER=
ROR)
>> adjtimex({modes=3DADJ_OFFSET|ADJ_STATUS, offset=3D0, freq=3D0, maxerror=
=3D16000000, esterror=3D16000000, status=3DSTA_PLL|STA_UNSYNC|STA_NANO, con=
stant=3D2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616044=
, tv_usec=3D507698330}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, s=
tabil=3D0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 =
(TIME_ERROR)
>> adjtimex({modes=3DADJ_STATUS, offset=3D0, freq=3D0, maxerror=3D16000000,=
 esterror=3D16000000, status=3DSTA_UNSYNC, constant=3D2, precision=3D1, tol=
erance=3D32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D507792}, tick=3D1=
0000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitcnt=3D0, calcnt=3D=
0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
>> adjtimex({modes=3D0, offset=3D0, freq=3D0, maxerror=3D16000000, esterror=
=3D16000000, status=3DSTA_UNSYNC, constant=3D2, precision=3D1, tolerance=3D=
32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D508000}, tick=3D10000, pps=
freq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitcnt=3D0, calcnt=3D0, errcnt=
=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
>> adjtimex({modes=3DADJ_FREQUENCY|ADJ_TICK, offset=3D0, freq=3D750433, max=
error=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC, constant=3D2, p=
recision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616044, tv_usec=3D=
512146}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabil=3D0, jitc=
nt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIME_ERROR)
>> adjtimex({modes=3DADJ_MAXERROR|ADJ_ESTERROR|ADJ_STATUS, offset=3D0, freq=
=3D750433, maxerror=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC, c=
onstant=3D2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D15306160=
44, tv_usec=3D522506}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, st=
abil=3D0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (=
TIME_ERROR)
>> adjtimex({modes=3DADJ_SETOFFSET|ADJ_NANO, offset=3D0, freq=3D750433, max=
error=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC|STA_NANO, consta=
nt=3D2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616033, t=
v_usec=3D778717675}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stab=
il=3D0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TI=
ME_ERROR)
>> adjtimex({modes=3DADJ_FREQUENCY|ADJ_TICK, offset=3D0, freq=3D750433, max=
error=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC|STA_NANO, consta=
nt=3D2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616033, t=
v_usec=3D784644657}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stab=
il=3D0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TI=
ME_ERROR)
>>
>> (The struct timex fields above are from *after* the syscall was
>> executed, so they contain the current (new) values as set from the
>> kernel, except of the 'modes' field, which contains the original value
>> sent by the caller.)
>>
>> The changes to the time_maxerror, time_esterror, and time_constant
>> variables are not logged, as these are not important for security.
>>
>> Note that the records are emitted even when the actual value does not
>> change (i.e. when there is an explicit attempt to change a value, but
>> the new value equals the old one).
>>
>> An overview of changes that can be done via adjtimex(2) (based on
>> information from Miroslav Lichvar) and whether they are audited:
>>   timekeeping_inject_offset() -- injects offset directly into system
>>                                  time (AUDITED)
>>   __timekeeping_set_tai_offset() -- sets the offset from the
>>                                     International Atomic Time
>>                                     (AUDITED)
>>   NTP variables:
>>     time_offset -- can adjust the clock by up to 0.5 seconds per call
>>                    and also speed it up or slow down by up to about
>>                    0.05% (43 seconds per day) (AUDITED)
>>     time_freq -- can speed up or slow down by up to about 0.05%
>>     time_status -- can insert/delete leap seconds and it also enables/
>>                    disables synchronization of the hardware real-time
>>                    clock (AUDITED)
>>     time_maxerror, time_esterror -- change error estimates used to
>>                                     inform userspace applications
>>                                     (NOT AUDITED)
>>     time_constant -- controls the speed of the clock adjustments that
>>                      are made when time_offset is set (NOT AUDITED)
>>     time_adjust -- can temporarily speed up or slow down the clock by up
>>                    to 0.05% (AUDITED)
>>     tick_usec -- a more extreme version of time_freq; can speed up or
>>                  slow down the clock by up to 10% (AUDITED)
>>
>> Cc: Miroslav Lichvar <mlichvar@redhat.com>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>  kernel/time/ntp.c         | 38 ++++++++++++++++++++++++++++++--------
>>  kernel/time/timekeeping.c |  3 +++
>>  2 files changed, 33 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
>> index a09ded765f6c..f96c6d326aae 100644
>> --- a/kernel/time/ntp.c
>> +++ b/kernel/time/ntp.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/module.h>
>>  #include <linux/rtc.h>
>>  #include <linux/math64.h>
>> +#include <linux/audit.h>
>>
>>  #include "ntp_internal.h"
>>  #include "timekeeping_internal.h"
>> @@ -294,6 +295,8 @@ static inline s64 ntp_update_offset_fll(s64 offset64=
, long secs)
>>
>>  static void ntp_update_offset(long offset)
>>  {
>> +     s64 old_offset =3D time_offset;
>> +     s64 old_freq =3D time_freq;
>>       s64 freq_adj;
>>       s64 offset64;
>>       long secs;
>> @@ -342,6 +345,9 @@ static void ntp_update_offset(long offset)
>>       time_freq   =3D max(freq_adj, -MAXFREQ_SCALED);
>>
>>       time_offset =3D div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_=
FREQ);
>> +
>> +     audit_ntp_adjust("offset", old_offset, time_offset);
>> +     audit_ntp_adjust("freq", old_freq, time_freq);
>>  }
>>
>>  /**
>> @@ -669,21 +675,31 @@ static inline void process_adjtimex_modes(struct t=
imex *txc,
>>                                               struct timespec64 *ts,
>>                                               s32 *time_tai)
>>  {
>> -     if (txc->modes & ADJ_STATUS)
>> -             process_adj_status(txc, ts);
>> +     if (txc->modes & (ADJ_STATUS | ADJ_NANO | ADJ_MICRO)) {
>> +             int old_status =3D time_status;
>> +
>> +             if (txc->modes & ADJ_STATUS)
>> +                     process_adj_status(txc, ts);
>>
>> -     if (txc->modes & ADJ_NANO)
>> -             time_status |=3D STA_NANO;
>> +             if (txc->modes & ADJ_NANO)
>> +                     time_status |=3D STA_NANO;
>>
>> -     if (txc->modes & ADJ_MICRO)
>> -             time_status &=3D ~STA_NANO;
>> +             if (txc->modes & ADJ_MICRO)
>> +                     time_status &=3D ~STA_NANO;
>> +
>> +             audit_ntp_adjust("status", old_status, time_status);
>> +     }
>>
>>       if (txc->modes & ADJ_FREQUENCY) {
>> +             s64 old_freq =3D time_freq;
>> +
>>               time_freq =3D txc->freq * PPM_SCALE;
>>               time_freq =3D min(time_freq, MAXFREQ_SCALED);
>>               time_freq =3D max(time_freq, -MAXFREQ_SCALED);
>>               /* update pps_freq */
>>               pps_set_freq(time_freq);
>> +
>> +             audit_ntp_adjust("freq", old_freq, time_freq);
>>       }
>>
>>       if (txc->modes & ADJ_MAXERROR)
>> @@ -700,14 +716,18 @@ static inline void process_adjtimex_modes(struct t=
imex *txc,
>>               time_constant =3D max(time_constant, 0l);
>>       }
>>
>> -     if (txc->modes & ADJ_TAI && txc->constant > 0)
>> +     if (txc->modes & ADJ_TAI && txc->constant > 0) {
>> +             audit_ntp_adjust("tai", *time_tai, txc->constant);
>>               *time_tai =3D txc->constant;
>> +     }
>
> It appears this time_tai use of "constant" is different than
> time_constant, the former not mentioned by Miroslav Lichvar.  What is it
> and is it important to log for security?  It sounds like it is
> important.

From the adjtimex man page:
       ADJ_TAI (since Linux 2.6.26)
              Set TAI (Atomic International Time) offset from buf->constant=
.

thanks
-john
