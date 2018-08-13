Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D619FC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1E5218C0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCp4kTXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1E5218C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeHMStn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:49:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39848 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeHMStn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:49:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id a134-v6so11633122lfe.6;
        Mon, 13 Aug 2018 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXmioDaVlh+HTSy5CEVzSy74yq1CaOkbUgOVN97UcqA=;
        b=TCp4kTXPe8a15pxTpnahYxAC5eUpmHRt+r0qAcqUYPIqRwxdVDS602wjFCnkuxp2zK
         RdR1AglMWYJK637GtSZXVZaRLP+KHmlhEPlXbld4DwcuiTdplEDT41e2gtgQZ4KyW1z/
         dbbsS+thFpUuGOgJZAACYxNQYVpQaWgMF6e8L1w/1ekz4xIhO7A0pR6sFNyWJeBKUFbB
         OM6cD8GjHv95r9YocpeibOjCWoxWmvrwjwEurLcl1q8H5k65veGqRB+qO8qvKf8Ofxex
         +B3I8L7DQV0Bm0iVQJpstWF8mk8/esYcTaDVmH/lVVUYRw4M0YGxUM3cTtlWGVqbJ7QX
         HHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cXmioDaVlh+HTSy5CEVzSy74yq1CaOkbUgOVN97UcqA=;
        b=s7oDZFEStbE2JiBlOrgBA3aHuEq9YoxZwRuBpAdsqwhIjmzTon5Fl2FtuFG9dBkAVg
         DdtDU1qxH1vSeLFjgBk6aojJPFl8n4hCa2n1wF9R/ofcAX4rlFZDOpjqbIzSv2zGguaJ
         8tw1VjMKc1Dt2Xh3lPtUZSGbNBL1vF/OHfQXxu31FIDGTHF87dxc+I1wMv2JteIL6EEe
         onln+sK/JeFOdjCiXWMt/u5vEnVvWCrdGP8NCZt+5ADF9eyxW3ovu5gzW947OhIlexWf
         bqxB4dz5KdsMtI0DOLuOJwI3kQYs7QzbC27XX+PM5CkcHPyqTCYbvzUctGy+33PjYrB+
         wVFA==
X-Gm-Message-State: AOUpUlHi4e9/0JpmDUO0bgfoSXSS4Qdekzi7GlIAcDMEWbOD0sOhXf+d
        vPq9ZmIbfXkQRWtTs7v1DCsHVKld
X-Google-Smtp-Source: AA+uWPzHaArBUCRm8OiajL+uM5pNufNk8S7LW5QsBOprZo5BMPW1ACGgPrL2N3L2iHz0Y7pTbQWZ+Q==
X-Received: by 2002:a19:6308:: with SMTP id x8-v6mr11924329lfb.104.1534176408541;
        Mon, 13 Aug 2018 09:06:48 -0700 (PDT)
Received: from [192.168.2.145] (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.googlemail.com with ESMTPSA id e41-v6sm3155642lji.37.2018.08.13.09.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:06:47 -0700 (PDT)
Subject: Re: [PATCH V5] thermal: Add cooling device's statistics in sysfs
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <d78a41e0-6602-e0f2-c00c-30b4766bb82c@gmail.com>
Date:   Mon, 13 Aug 2018 19:06:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.04.2018 13:56, Viresh Kumar wrote:
> This extends the sysfs interface for thermal cooling devices and exposes
> some pretty useful statistics. These statistics have proven to be quite
> useful specially while doing benchmarks related to the task scheduler,
> where we want to make sure that nothing has disrupted the test,
> specially the cooling device which may have put constraints on the CPUs.
> The information exposed here tells us to what extent the CPUs were
> constrained by the thermal framework.
> 
> The write-only "reset" file is used to reset the statistics.
> 
> The read-only "time_in_state_ms" file shows the time (in msec) spent by the
> device in the respective cooling states, and it prints one line per
> cooling state.
> 
> The read-only "total_trans" file shows single positive integer value
> showing the total number of cooling state transitions the device has
> gone through since the time the cooling device is registered or the time
> when statistics were reset last.
> 
> The read-only "trans_table" file shows a two dimensional matrix, where
> an entry <i,j> (row i, column j) represents the number of transitions
> from State_i to State_j.
> 
> This is how the directory structure looks like for a single cooling
> device:
> 
> $ ls -R /sys/class/thermal/cooling_device0/
> /sys/class/thermal/cooling_device0/:
> cur_state  max_state  power  stats  subsystem  type  uevent
> 
> /sys/class/thermal/cooling_device0/power:
> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> control               runtime_status
> 
> /sys/class/thermal/cooling_device0/stats:
> reset  time_in_state_ms  total_trans  trans_table
> 
> This is tested on ARM 64-bit Hisilicon hikey620 board running Ubuntu and
> ARM 64-bit Hisilicon hikey960 board running Android.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Hello,

I'm working on adding support of OPP and cooling for NVIDIA Tegra20/30 CPUFreq driver and stumbled upon a bug that is introduced by this patch. It is triggered on the driver module unload.

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab982309e6a..de53c821a282 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1102,8 +1102,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
        mutex_unlock(&thermal_list_lock);
 
        ida_simple_remove(&thermal_cdev_ida, cdev->id);
-       device_unregister(&cdev->device);
        thermal_cooling_device_destroy_sysfs(cdev);
+       device_unregister(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);

This patch fixes the issue with the "cooling_device", but I'm not sure that it won't break thermal_zone". Also see KASAN report below.


[   65.553469] ==================================================================
[   65.572514] BUG: KASAN: use-after-free in thermal_cooling_device_destroy_sysfs+0x24/0x40
[   65.592300] Read of size 4 at addr ced17c80 by task rmmod/206

[   65.632387] CPU: 1 PID: 206 Comm: rmmod Not tainted 4.18.0-rc8-next-20180810-00148-g2863c2b33049-dirty #361
[   65.654241] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   65.676552] [<c0116784>] (unwind_backtrace) from [<c010fd54>] (show_stack+0x20/0x24)
[   65.699719] [<c010fd54>] (show_stack) from [<c10861b4>] (dump_stack+0x9c/0xb0)
[   65.723224] [<c10861b4>] (dump_stack) from [<c03012ac>] (print_address_description+0x60/0x268)
[   65.747525] [<c03012ac>] (print_address_description) from [<c03018c8>] (kasan_report+0x120/0x388)
[   65.771873] [<c03018c8>] (kasan_report) from [<c02fff44>] (__asan_load4+0x64/0xb4)
[   65.796324] [<c02fff44>] (__asan_load4) from [<c0b76d00>] (thermal_cooling_device_destroy_sysfs+0x24/0x40)
[   65.820990] [<c0b76d00>] (thermal_cooling_device_destroy_sysfs) from [<c0b73804>] (thermal_cooling_device_unregister+0x130/0x238)
[   65.846039] [<c0b73804>] (thermal_cooling_device_unregister) from [<c0b7a26c>] (cpufreq_cooling_unregister+0xa8/0xfc)
[   65.870897] [<c0b7a26c>] (cpufreq_cooling_unregister) from [<bf0003c0>] (tegra_cpu_exit+0x2c/0x74 [tegra20_cpufreq])
[   65.895940] [<bf0003c0>] (tegra_cpu_exit [tegra20_cpufreq]) from [<c0b83fa4>] (cpufreq_offline+0x160/0x298)
[   65.920899] [<c0b83fa4>] (cpufreq_offline) from [<c0b841cc>] (cpufreq_remove_dev+0xd0/0xd4)
[   65.945804] [<c0b841cc>] (cpufreq_remove_dev) from [<c0867c90>] (subsys_interface_unregister+0xe4/0x130)
[   65.971622] [<c0867c90>] (subsys_interface_unregister) from [<c0b823f0>] (cpufreq_unregister_driver+0x44/0x8c)
[   65.998135] [<c0b823f0>] (cpufreq_unregister_driver) from [<bf00002c>] (tegra20_cpufreq_remove+0x2c/0x34 [tegra20_cpufreq])
[   66.025805] [<bf00002c>] (tegra20_cpufreq_remove [tegra20_cpufreq]) from [<c086cde4>] (platform_drv_remove+0x44/0x64)
[   66.053768] [<c086cde4>] (platform_drv_remove) from [<c086a93c>] (device_release_driver_internal+0x1f0/0x2e0)
[   66.081707] [<c086a93c>] (device_release_driver_internal) from [<c086aab8>] (driver_detach+0x68/0xb8)
[   66.110346] [<c086aab8>] (driver_detach) from [<c0869128>] (bus_remove_driver+0x84/0xfc)
[   66.139530] [<c0869128>] (bus_remove_driver) from [<c086b898>] (driver_unregister+0x4c/0x6c)
[   66.169514] [<c086b898>] (driver_unregister) from [<c086cee8>] (platform_driver_unregister+0x1c/0x20)
[   66.200091] [<c086cee8>] (platform_driver_unregister) from [<bf000980>] (tegra20_cpufreq_driver_exit+0x18/0x698 [tegra20_cpufreq])
[   66.232017] [<bf000980>] (tegra20_cpufreq_driver_exit [tegra20_cpufreq]) from [<c01ff02c>] (sys_delete_module+0x198/0x224)
[   66.264804] [<c01ff02c>] (sys_delete_module) from [<c0101000>] (ret_fast_syscall+0x0/0x58)
[   66.298137] Exception stack(0xce94bfa8 to 0xce94bff0)
[   66.331825] bfa0:                   0003f0d0 00000002 0003f10c 00000800 5e6a7500 5e6a7500
[   66.366665] bfc0: 0003f0d0 00000002 0003f0d0 00000081 b6a723d0 b6a7207c b6a7226c 00000001
[   66.401864] bfe0: aec42610 b6a72014 00022408 aec4261c

[   66.472603] Allocated by task 151:
[   66.508377]  kasan_kmalloc+0xd4/0x174
[   66.544570]  kmem_cache_alloc_trace+0x198/0x2e8
[   66.581197]  __thermal_cooling_device_register+0x9c/0x4c0
[   66.618085]  thermal_of_cooling_device_register+0x18/0x1c
[   66.655387]  __cpufreq_cooling_register+0x4c4/0x604
[   66.692976]  of_cpufreq_cooling_register+0x88/0xe8
[   66.730726]  tegra_cpu_ready+0x28/0x3c [tegra20_cpufreq]
[   66.768872]  cpufreq_online+0x798/0x8d0
[   66.807262]  cpufreq_add_dev+0xa0/0xac
[   66.845892]  subsys_interface_register+0x104/0x148
[   66.884167]  cpufreq_register_driver+0x1d0/0x264
[   66.922070]  tegra20_cpufreq_probe+0x1f8/0x27c [tegra20_cpufreq]
[   66.959803]  platform_drv_probe+0x70/0xc8
[   66.997149]  really_probe+0x284/0x3d4
[   67.034006]  driver_probe_device+0x80/0x1b8
[   67.070515]  __driver_attach+0x130/0x134
[   67.106447]  bus_for_each_dev+0x98/0xc4
[   67.141867]  driver_attach+0x38/0x3c
[   67.177010]  bus_add_driver+0x238/0x2cc
[   67.211717]  driver_register+0xdc/0x1b0
[   67.245684]  __platform_driver_register+0x7c/0x84
[   67.279456]  0xbf005028
[   67.312693]  do_one_initcall+0x60/0x344
[   67.345795]  do_init_module+0xe4/0x30c
[   67.378294]  load_module+0x3008/0x3784
[   67.410423]  sys_finit_module+0xac/0xc4
[   67.442102]  ret_fast_syscall+0x0/0x58
[   67.472788]  0xb6781c10

[   67.531724] Freed by task 206:
[   67.560135]  __kasan_slab_free+0x12c/0x204
[   67.587993]  kasan_slab_free+0x14/0x18
[   67.615343]  kfree+0x90/0x294
[   67.642143]  thermal_release+0x6c/0x98
[   67.668309]  device_release+0x4c/0xe8
[   67.693667]  kobject_put+0xac/0x11c
[   67.718166]  device_unregister+0x2c/0x30
[   67.742308]  thermal_cooling_device_unregister+0x128/0x238
[   67.766189]  cpufreq_cooling_unregister+0xa8/0xfc
[   67.789630]  tegra_cpu_exit+0x2c/0x74 [tegra20_cpufreq]
[   67.812973]  cpufreq_offline+0x160/0x298
[   67.835506]  cpufreq_remove_dev+0xd0/0xd4
[   67.857115]  subsys_interface_unregister+0xe4/0x130
[   67.878280]  cpufreq_unregister_driver+0x44/0x8c
[   67.899235]  tegra20_cpufreq_remove+0x2c/0x34 [tegra20_cpufreq]
[   67.919948]  platform_drv_remove+0x44/0x64
[   67.940467]  device_release_driver_internal+0x1f0/0x2e0
[   67.960895]  driver_detach+0x68/0xb8
[   67.981161]  bus_remove_driver+0x84/0xfc
[   68.001382]  driver_unregister+0x4c/0x6c
[   68.021561]  platform_driver_unregister+0x1c/0x20
[   68.041879]  tegra20_cpufreq_driver_exit+0x18/0x698 [tegra20_cpufreq]
[   68.062376]  sys_delete_module+0x198/0x224
[   68.082826]  ret_fast_syscall+0x0/0x58
[   68.103010]  0xb6a72014

-- 
Dmitry
