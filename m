Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000A7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37C72184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N5M5NqY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeLRTNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:13:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46556 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeLRTNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:13:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so8232308ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 11:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:references:message-id
         :in-reply-to:to:cc:user-agent:subject:from:date;
        bh=U45WOpdJOI0IuCowowF4NcoMlzPRGfjJKE4V0ZrtBVI=;
        b=N5M5NqY00D9UqGa+WBNQZwhP9X4edSJ+CSEHskLt89QCo5TZ6cIo7CTNtrP+8FzpF/
         l6ajtmX5beAwtxzX5fkno4Mb0pxm4yHSVo4gT2lDFWIKgqJAeL1U3d5SKNUdCuF5gXTD
         4+RM4LwUuw7Zkw0RETUyUQrst8pAOUv3fmd3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :references:message-id:in-reply-to:to:cc:user-agent:subject:from
         :date;
        bh=U45WOpdJOI0IuCowowF4NcoMlzPRGfjJKE4V0ZrtBVI=;
        b=pTRCHUBCR53E9DKhIDLz5qiS/EZR4u098kbBkkkblrdgOYehAxZLeF6ujpbCvqbSzM
         UvZvJs35N81xU92TtJmaMx8W9kqIyJQvLQCX4sw2BEWRQ5ImbO93ongRe2koqm2limnm
         uRD4XoFJhv20GITnT+ToQUS8TZEYDfsmWkscAIJOJnBjB8Ch+qpfMIDfh2IgRTtMB/iG
         zFpuCLCS3F2+qZujt+iTXIM6x6AXTowc5bGQZgR7IT8+Mdge1mCDIRoBV//29hv04iQH
         6FaGS2CPDMhq9d+F/mZtxluGzFsZ64frehnrLAALDerbbUXapvmmT66P4YcC0lIQBh7T
         jHbw==
X-Gm-Message-State: AA+aEWYJoVicwdPHdZaU/uCJpDn4gkHx7jS8sQUylkOOnSslojaiUUb1
        XSWNXcqAe+SJqv3Cpb5kmk+UEw==
X-Google-Smtp-Source: AFSGD/WHGTqbo4viKbWozYOjYU/Qtow0vcjbL/+Nd0TEOPK55rvaWCL9cPuAj2yfG254cW8A+yW8Ow==
X-Received: by 2002:a17:902:b48b:: with SMTP id y11mr16924122plr.200.1545160383404;
        Tue, 18 Dec 2018 11:13:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h8sm23368405pfo.162.2018.12.18.11.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 11:13:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-3-git-send-email-tdas@codeaurora.org> <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com> <20181213100506.sy3haqjbxtmkthvt@vireshk-i7> <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com> <20181218054545.k77jh5lxvmj2zott@vireshk-i7>
Message-ID: <154516038159.238328.2917665370794230521@swboyd.mtv.corp.google.com>
In-Reply-To: <20181218054545.k77jh5lxvmj2zott@vireshk-i7>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>,
        vincent.guittot@linaro.org
User-Agent: alot/0.8
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Tue, 18 Dec 2018 11:13:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2018-12-17 21:45:45)
> Hi Stephen,
>=20
> On 13-12-18, 02:12, Stephen Boyd wrote:
> > Quoting Viresh Kumar (2018-12-13 02:05:06)
> > > On 13-12-18, 01:58, Stephen Boyd wrote:
> > > > BTW, Viresh, I see a lockdep splat when cpufreq_init returns an err=
or
> > > > upon bringing the policy online the second time. I guess cpufreq_st=
ats
> > > > aren't able to be freed from there because they take locks in diffe=
rent
> > > > order vs. the normal path?
> > >=20
> > > Please share the lockdep report and the steps to reproduce it. I will
> > > see if I can simulate the failure forcefully..
> > >=20
> >=20
> > It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
> > think all it takes is to return an error the second time the policy is
> > initialized when cpufreq_online() calls into the cpufreq driver.
> >=20
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >  WARNING: possible circular locking dependency detected
> >  4.19.8 #61 Tainted: G        W
> >  ------------------------------------------------------
> >  cpuhp/5/36 is trying to acquire lock:
> >  000000003e901e8a (kn->count#326){++++}, at: kernfs_remove_by_name_ns+0=
x44/0x80
> >=20
> >  but task is already holding lock:
> >  00000000dd7f52c3 (&policy->rwsem){++++}, at: cpufreq_policy_free+0x17c=
/0x1cc
> >=20
> >  which lock already depends on the new lock.
> >=20
> >=20
> >  the existing dependency chain (in reverse order) is:
> >=20
> >  -> #1 (&policy->rwsem){++++}:
> >         down_read+0x50/0xcc
> >         show+0x30/0x78
> >         sysfs_kf_seq_show+0x17c/0x25c
> >         kernfs_seq_show+0xb4/0xf8
> >         seq_read+0x4a8/0x8f0
> >         kernfs_fop_read+0xe0/0x360
> >         __vfs_read+0x80/0x328
> >         vfs_read+0xd0/0x1d4
> >         ksys_read+0x88/0x118
> >         __arm64_sys_read+0x4c/0x5c
> >         el0_svc_common+0x124/0x1c4
> >         el0_svc_compat_handler+0x64/0x8c
> >         el0_svc_compat+0x8/0x18
>=20
> I failed to reproduce it over linux/next.
>=20
> I had the following changes over linux/next:
> https://pastebin.ubuntu.com/p/zkVm77PGdY/

I don't see any failure returned from cpufreq_dt's cpufreq_init()
function. Maybe put a static int counter =3D 0 and then fail
cpufreq_init() the second time that it's called for the same policy
pointer? I have a system with two policies, so I made it fail and return
-EINVAL when the counter =3D=3D 2 and I see the lockdep splat.

>=20
> I also did savedefconfig to show what all I changed in it. I faked multip=
le
> clusters on my hikey960 board, which is not big little..
>=20
> And here is the command list from history that I ran after boot.
>=20
>   501  grep . /sys/devices/system/cpu/cpufreq/*/*
>   502  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   503  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   504  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   505  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   506  grep . /sys/devices/system/cpu/cpufreq/*/*
>   507  grep . /sys/devices/system/cpu/cpufreq/*/*
>   508  echo 0 > /sys/devices/system/cpu/cpu4/online=20
>   509  echo 0 > /sys/devices/system/cpu/cpu5/online=20
>   510  echo 0 > /sys/devices/system/cpu/cpu6/online=20
>   511  echo 0 > /sys/devices/system/cpu/cpu7/online=20
>   512  grep . /sys/devices/system/cpu/cpufreq/*/*
>   513  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   514  grep . /sys/devices/system/cpu/cpufreq/*/*
>   515  echo 1 > /sys/devices/system/cpu/cpu4/online=20
>   516  grep . /sys/devices/system/cpu/cpufreq/*/*
>   517  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   518  dmesg=20
>=20

I did the following:

  grep . /sys/devices/system/cpu/cpufreq/*/* >/dev/null
  echo 0 > /sys/devices/system/cpu/cpu4/online=20
  echo 0 > /sys/devices/system/cpu/cpu5/online=20
  echo 0 > /sys/devices/system/cpu/cpu6/online=20
  echo 0 > /sys/devices/system/cpu/cpu7/online=20
  echo 1 > /sys/devices/system/cpu/cpu4/online=20
  dmesg

And boom, lockdep splat.
