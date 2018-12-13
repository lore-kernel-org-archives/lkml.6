Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E2BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEE520879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d7gXdt9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEE520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeLMKMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:12:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37545 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeLMKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:12:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so853733plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:subject:to
         :references:message-id:from:user-agent:cc:date;
        bh=2RSgyU5jTt3wDEdar1Vh9WqBv/03n8miRn6gGDTIw3k=;
        b=d7gXdt9WDnlcs6BAW9su0+7OTb2lL0Tt2kg+3nedZgoWZZOSSjIWXZ6XzqdAcom1Nx
         bHp6CI3H6AvZ+wvXROlePRUwM/1DITNCTjt9/2lwYYKfKCtVBGV4HgTXxaJPxMLPKtAd
         AOA0ez3Ak0SIUSDLWUhPVQhzki6WkFyRMKmHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:subject:to:references:message-id:from:user-agent:cc
         :date;
        bh=2RSgyU5jTt3wDEdar1Vh9WqBv/03n8miRn6gGDTIw3k=;
        b=dKejTz8GkiPK4Ka2RKH1ZBLSVp/bc0WssjJ3IKP3UfxLWFG8fcl9eWF+z6pUUusjwu
         EqU2kChaOroLLkjXY1ZW3s1Wo4XB8iufFnIandeH/nSspLYgBl+zfSsAb5fUWUAItPIA
         xUXMY3vTWIFYjf1ADnsMpR3tMhvFryxuaPpLeUHNYyi5ONUWxbymXjWT9WT5xEfmS95p
         iYjVvX2k4g0XdKP6vc2bO4iDpwc/C1scptr2DLz3z65/EvwWylzbXUBD8sIwjc8ERnHg
         AtweK1yVcqJHZNl02cDJbg9U32LA6BhSI6HqiULbnQMdVMzhxQt6paH7rtEayhpTkX2w
         KzUQ==
X-Gm-Message-State: AA+aEWZqCTKNjx7nIkVAYOZnuhW3D+1ey3egsN19rfa8FraXjONrJ6cK
        IIQ7wmfse38Y/Ia1o50hVZ5xrQ==
X-Google-Smtp-Source: AFSGD/WIl3B8Z77e/0h6WdDnYArkmt09YaD9Nsa0DTsQHc6PVvzlLezwXpQMM2kTxBz16IYcXl/oaQ==
X-Received: by 2002:a17:902:7848:: with SMTP id e8mr23708772pln.100.1544695969128;
        Thu, 13 Dec 2018 02:12:49 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w128sm2411018pfw.79.2018.12.13.02.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 02:12:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-3-git-send-email-tdas@codeaurora.org> <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com> <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
Message-ID: <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
Date:   Thu, 13 Dec 2018 02:12:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2018-12-13 02:05:06)
> On 13-12-18, 01:58, Stephen Boyd wrote:
> > BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
> > upon bringing the policy online the second time. I guess cpufreq_stats
> > aren't able to be freed from there because they take locks in different
> > order vs. the normal path?
>=20
> Please share the lockdep report and the steps to reproduce it. I will
> see if I can simulate the failure forcefully..
>=20

It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
think all it takes is to return an error the second time the policy is
initialized when cpufreq_online() calls into the cpufreq driver.

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
 WARNING: possible circular locking dependency detected
 4.19.8 #61 Tainted: G        W
 ------------------------------------------------------
 cpuhp/5/36 is trying to acquire lock:
 000000003e901e8a (kn->count#326){++++}, at: kernfs_remove_by_name_ns+0x44/=
0x80

 but task is already holding lock:
 00000000dd7f52c3 (&policy->rwsem){++++}, at: cpufreq_policy_free+0x17c/0x1=
cc

 which lock already depends on the new lock.


 the existing dependency chain (in reverse order) is:

 -> #1 (&policy->rwsem){++++}:
        down_read+0x50/0xcc
        show+0x30/0x78
        sysfs_kf_seq_show+0x17c/0x25c
        kernfs_seq_show+0xb4/0xf8
        seq_read+0x4a8/0x8f0
        kernfs_fop_read+0xe0/0x360
        __vfs_read+0x80/0x328
        vfs_read+0xd0/0x1d4
        ksys_read+0x88/0x118
        __arm64_sys_read+0x4c/0x5c
        el0_svc_common+0x124/0x1c4
        el0_svc_compat_handler+0x64/0x8c
        el0_svc_compat+0x8/0x18

 -> #0 (kn->count#326){++++}:
        lock_acquire+0x244/0x360
        __kernfs_remove+0x324/0x4fc
        kernfs_remove_by_name_ns+0x44/0x80
        remove_files+0x5c/0xd8
        sysfs_remove_group+0xb4/0xec
        cpufreq_stats_free_table+0x50/0x9c
        cpufreq_policy_free+0x184/0x1cc
        cpufreq_online+0xa44/0xc4c
        cpuhp_cpufreq_online+0x1c/0x2c
        cpuhp_invoke_callback+0x608/0x1328
        cpuhp_thread_fun+0x1dc/0x440
        smpboot_thread_fn+0x46c/0x7c0
        kthread+0x248/0x260
        ret_from_fork+0x10/0x18

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&policy->rwsem);
                                lock(kn->count#326);
                                lock(&policy->rwsem);
   lock(kn->count#326);

  *** DEADLOCK ***

 2 locks held by cpuhp/5/36:
  #0: 00000000549a28c3 (cpuhp_state-up){+.+.}, at: cpuhp_lock_acquire+0x8/0=
x48
  #1: 00000000dd7f52c3 (&policy->rwsem){++++}, at: cpufreq_policy_free+0x17=
c/0x1cc

 stack backtrace:
 CPU: 5 PID: 36 Comm: cpuhp/5 Tainted: G        W         4.19.8 #61
 Call trace:
  dump_backtrace+0x0/0x2f8
  show_stack+0x20/0x2c
  __dump_stack+0x20/0x28
  dump_stack+0xcc/0x10c
  print_circular_bug+0x2c0/0x328
  __lock_acquire+0x22b0/0x2708
  lock_acquire+0x244/0x360
  __kernfs_remove+0x324/0x4fc
  kernfs_remove_by_name_ns+0x44/0x80
  remove_files+0x5c/0xd8
  sysfs_remove_group+0xb4/0xec
  cpufreq_stats_free_table+0x50/0x9c
  cpufreq_policy_free+0x184/0x1cc
  cpufreq_online+0xa44/0xc4c
  cpuhp_cpufreq_online+0x1c/0x2c
  cpuhp_invoke_callback+0x608/0x1328
  cpuhp_thread_fun+0x1dc/0x440
  smpboot_thread_fn+0x46c/0x7c0
  kthread+0x248/0x260
  ret_from_fork+0x10/0x18
