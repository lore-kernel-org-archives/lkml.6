Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZrIq7YlacdAf6Pp1//32KeokyBiWkckRD02uPQNEY1mQKCQeCVUyfgQrBnz3vXNHiPlCGQG
ARC-Seal: i=1; a=rsa-sha256; t=1524842922; cv=none;
        d=google.com; s=arc-20160816;
        b=xxinGNN+Dcj8JPecFxw6kewHseStWEzgECRJyOKCU1VMAghZ0KrEe6gvPxvIs3tPc6
         DcHA+eosui875k/x1Cv/20bwlpqdis73Il1s+ds5k59znzfEIWoxFQByuF6FOhuQwl6P
         WYPAMSjbr2VMsyGNZks+YL2Q7sAIPJwPEGrhzDcTC01P1YctjpoN92YnFsC4YeISX+Ki
         cZTOOdxiZrjj1+rgiYWnWkotgl2FCmox+2dqek/FqSy4g2V1LbYHZ1Hdj5IBw2IvvvMu
         505/5Dhn3PmOVBJMqW07feX0laJz95oRnvBQOP7kuYjxE477qYK0qPz5sqVLBoDTB0yG
         1V8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:cc:to:subject
         :message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=9xfEVprlpl6lktx17sp93yiv3mekP/yX3Nt3gOCiiQQ=;
        b=QpY85lK50Hv1IdSiEwNkxuP5K/8heO6vd+LE/FryiOBDxxowe17F/U0SfQJMUdhXQR
         DxkBBi/e0WCZCTa3C+gOZW0Bke3pf+IdlnOTh2aSL0AFe20ZhZCWLFcbBaOemN6QcYeT
         oQ4mC283/OGGugWOIsZPrA1NHZewKOZet4E+xfgHlsl9EBioc1/LVDA3nNCmgGXHhBjm
         9f9z502hg7eUaW0KfUSYXpadP1NYSzL+xi1cO+IhzgVu/NPyBPc5JLPAWSB51rDVX6XO
         5MYvtg6zI3iwCgs3flI4hldDe9tmaDk1BQPUopGeBY8uHC039eW069KNFMNdEWUGAs3f
         TLvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=VpbWhuQF;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=VpbWhuQF;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933218AbeD0P23 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 11:28:29 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33764 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbeD0P21 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 11:28:27 -0400
MIME-Version: 1.0
In-Reply-To: <20180427074130.GN20050@localhost>
References: <CAG=yYwmQb-zuq3V9muu=xXsRGa3s1A=fFgz-XJchCiFd+GYUYQ@mail.gmail.com>
 <alpine.DEB.2.21.1804262327480.1596@nanos.tec.linutronix.de> <20180427074130.GN20050@localhost>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 27 Apr 2018 20:58:26 +0530
Message-ID: <CAG=yYwmfZXYTQfqGr1_b69nw2au9B+ftF9KdXmmhm-3CdfTXjg@mail.gmail.com>
Subject: Re: possible BUG: selftest about raw_skew failed
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598367547498408284?=
X-GMAIL-MSGID: =?utf-8?q?1598913692808463816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

i think may be  systemd-timesyncd  was running.
anyway currently the status is as follows...

$systemctl status systemd-timesyncd.service
=E2=97=8F systemd-timesyncd.service - Network Time Synchronization
   Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service;
enabled; vendor preset: enabled)
   Active: active (running) since Fri 2018-04-27 19:26:16 IST; 1h 11min ago
     Docs: man:systemd-timesyncd.service(8)
 Main PID: 514 (systemd-timesyn)
   Status: "Synchronized to time server 123.108.200.124:123
(0.debian.pool.ntp.org)."
    Tasks: 2 (limit: 4382)
   Memory: 1.8M
   CGroup: /system.slice/systemd-timesyncd.service
           =E2=94=94=E2=94=80514 /lib/systemd/systemd-timesyncd
$

The test in the latest run show  "PASS"
see below...

selftests: raw_skew
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Estimating clock drift: 26.836(est) 26.838(act) [OK]
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
ok 1..7 selftests: raw_skew [PASS]



On Fri, Apr 27, 2018 at 1:11 PM, Miroslav Lichvar <mlichvar@redhat.com> wro=
te:
> On Thu, Apr 26, 2018 at 11:28:29PM +0200, Thomas Gleixner wrote:
>> On Sat, 21 Apr 2018, Jeffrin Thalakkottoor wrote:
>> > selftests: raw_skew
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > WARNING: ADJ_OFFSET in progress, this will cause inaccurate results
>> > Estimating clock drift: 17.910(est) 16.820(act) [FAILED]
>
> Was ntpd, systemd-timesyncd, or some other NTP/PTP daemon running
> shortly before or during the test?
>
> The warning indicates that the clock was slewed by adjtime() or
> adjtimex(), which makes the measurement of the frequency less accurate
> and the test may fail.
>
> Maybe this test and other tests that measure the frequency of the
> system clock should be modified to SKIP when adjtimex() returns a
> non-zero offset (or the frequency changes during the test)?
>
> --
> Miroslav Lichvar



--=20
software engineer
rajagiri school of engineering and technology
