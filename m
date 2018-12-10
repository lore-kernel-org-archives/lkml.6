Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B34CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE55820821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE55820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeLJKxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:53:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726614AbeLJKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:52:59 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBAAiI1d008183
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:52:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p9n05dmky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:52:57 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 10 Dec 2018 10:52:55 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Dec 2018 10:52:50 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBAAqnfQ51773578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 10:52:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 550484C044;
        Mon, 10 Dec 2018 10:52:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27CF54C040;
        Mon, 10 Dec 2018 10:52:40 +0000 (GMT)
Received: from [9.199.54.38] (unknown [9.199.54.38])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Dec 2018 10:52:39 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: mainline/master boot bisection: v4.20-rc5-79-gabb8d6ecbd8f on
 jetson-tk1
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        Oleg Nesterov <oleg@redhat.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <5c09f05a.1c69fb81.95568.35c2@mx.google.com>
Date:   Mon, 10 Dec 2018 16:23:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <5c09f05a.1c69fb81.95568.35c2@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121010-0028-0000-0000-000003286AD3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121010-0029-0000-0000-000023E48C24
Message-Id: <f24ba5f2-dcc8-45d2-9599-3a0d40fe4d95@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can you please provide more details. I don't understand how this patch
can cause boot failure.

From the log found at
https://storage.kernelci.org/mainline/master/v4.20-rc5-79-gabb8d6ecbd8f/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/lab-baylibre/boot-tegra124-jetson-tk1.html

23:21:06.680269  [    7.500733] Unable to handle kernel NULL pointer dereference at virtual address 00000064
23:21:06.680455  [    7.508893] pgd = (ptrval)
23:21:06.721940  [    7.511591] [00000064] *pgd=ad7d8003, *pmd=f9d5d003
23:21:06.722241  [    7.516500] Internal error: Oops: 207 [#1] SMP ARM
 ...
23:21:06.722724  [    7.546706] CPU: 0 PID: 122 Comm: udevd Not tainted 4.20.0-rc5 #1
23:21:06.722911  [    7.552785] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
23:21:06.765203  [    7.559045] PC is at drm_plane_register_all+0x18/0x50
23:21:06.765493  [    7.564094] LR is at drm_modeset_register_all+0xc/0x6c
23:21:06.765698  [    7.569217] pc : [<c09a8700>]    lr : [<c09ab240>]    psr: a0000013
23:21:06.765882  [    7.575470] sp : c3451c70  ip : 2d827000  fp : c1804c48
23:21:06.766053  [    7.580680] r10: 00000000  r9 : ec9cc300  r8 : 00000000
23:21:06.766229  [    7.585893] r7 : bf193c80  r6 : 00000000  r5 : c3694224  r4 : fffffffc
23:21:06.766403  [    7.592404] r3 : 00002000  r2 : 0002f000  r1 : eef92cf0  r0 : c3694000
 ...
23:21:07.068237  [    7.880215] [<c09a8700>] (drm_plane_register_all) from [<c09ab240>] (drm_modeset_register_all+0xc/0x6c)
23:21:07.068493  [    7.889603] [<c09ab240>] (drm_modeset_register_all) from [<c0992054>] (drm_dev_register+0x16c/0x1c4)
23:21:07.109960  [    7.898915] [<c0992054>] (drm_dev_register) from [<bf0ec0d8>] (nouveau_platform_probe+0x54/0x8c [nouveau])
23:21:07.110285  [    7.908750] [<bf0ec0d8>] (nouveau_platform_probe [nouveau]) from [<c0a45968>] (platform_drv_probe+0x48/0x98)
23:21:07.110515  [    7.918572] [<c0a45968>] (platform_drv_probe) from [<c0a43bd8>] (really_probe+0x228/0x2d0)
23:21:07.110706  [    7.926832] [<c0a43bd8>] (really_probe) from [<c0a43de4>] (driver_probe_device+0x60/0x174)
23:21:07.110893  [    7.935093] [<c0a43de4>] (driver_probe_device) from [<c0a43fc8>] (__driver_attach+0xd0/0xd4)
23:21:07.153794  [    7.943528] [<c0a43fc8>] (__driver_attach) from [<c0a41e8c>] (bus_for_each_dev+0x74/0xb4)
23:21:07.154133  [    7.951688] [<c0a41e8c>] (bus_for_each_dev) from [<c0a42ff0>] (bus_add_driver+0x18c/0x210)
23:21:07.154352  [    7.959946] [<c0a42ff0>] (bus_add_driver) from [<c0a44b24>] (driver_register+0x74/0x108)
23:21:07.154544  [    7.968212] [<c0a44b24>] (driver_register) from [<bf1bb170>] (nouveau_drm_init+0x170/0x1000 [nouveau])
23:21:07.154739  [    7.977692] [<bf1bb170>] (nouveau_drm_init [nouveau]) from [<c0402d6c>] (do_one_initcall+0x54/0x1fc)
23:21:07.197008  [    7.986820] [<c0402d6c>] (do_one_initcall) from [<c04d276c>] (do_init_module+0x64/0x1f4)
23:21:07.197344  [    7.994906] [<c04d276c>] (do_init_module) from [<c04d1980>] (load_module+0x1ee8/0x23c8)
23:21:07.197553  [    8.002907] [<c04d1980>] (load_module) from [<c04d2080>] (sys_finit_module+0xac/0xd8)
23:21:07.197751  [    8.010722] [<c04d2080>] (sys_finit_module) from [<c0401000>] (ret_fast_syscall+0x0/0x4c)
23:21:07.197935  [    8.018884] Exception stack(0xc3451fa8 to 0xc3451ff0)


Both PC and LR are pointing to drm_* code. I don't see this anyway related to
uprobes. Did I miss anything?

Thanks,
Ravi


On 12/7/18 9:30 AM, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> Bisection result for mainline/master (v4.20-rc5-79-gabb8d6ecbd8f) on jetson-tk1
> 
>   Good:       cf76c364a1e1 Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
>   Bad:        abb8d6ecbd8f Merge tag 'trace-v4.20-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
>   Found:      1aed58e67a6e Uprobes: Fix kernel oops with delayed_uprobe_remove()
> 
> Details:
>   Good:       https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.20-rc5-62-gcf76c364a1e1/
>   Bad:        https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.20-rc5-79-gabb8d6ecbd8f/
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       mainline
>   URL:        http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   Branch:     master
>   Target:     jetson-tk1
>   Lab:        lab-baylibre
>   Config:     multi_v7_defconfig
>   Plan:       boot
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 1aed58e67a6ec1e7a18bfabe8ba6ec2d27c15636
> Author: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Date:   Wed Dec 5 09:04:23 2018 +0530
> 
>     Uprobes: Fix kernel oops with delayed_uprobe_remove()
>     
>     There could be a race between task exit and probe unregister:
>     
>       exit_mm()
>       mmput()
>       __mmput()                     uprobe_unregister()
>       uprobe_clear_state()          put_uprobe()
>       delayed_uprobe_remove()       delayed_uprobe_remove()
>     
>     put_uprobe() is calling delayed_uprobe_remove() without taking
>     delayed_uprobe_lock and thus the race sometimes results in a
>     kernel crash. Fix this by taking delayed_uprobe_lock before
>     calling delayed_uprobe_remove() from put_uprobe().
>     
>     Detailed crash log can be found at:
>       Link: http://lkml.kernel.org/r/000000000000140c370577db5ece@google.com
>     
>     Link: http://lkml.kernel.org/r/20181205033423.26242-1-ravi.bangoria@linux.ibm.com
>     
>     Acked-by: Oleg Nesterov <oleg@redhat.com>
>     Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>     Reported-by: syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com
>     Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
>     Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>     Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 96d4bee83489..98b9312ce6b2 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -572,7 +572,9 @@ static void put_uprobe(struct uprobe *uprobe)
>  		 * gets called, we don't get a chance to remove uprobe from
>  		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
>  		 */
> +		mutex_lock(&delayed_uprobe_lock);
>  		delayed_uprobe_remove(uprobe, NULL);
> +		mutex_unlock(&delayed_uprobe_lock);
>  		kfree(uprobe);
>  	}
>  }
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [cf76c364a1e1e5224af80edf70a1e3023e1fcf8c] Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good cf76c364a1e1e5224af80edf70a1e3023e1fcf8c
> # bad: [abb8d6ecbd8f7801c048f6543f79d22d24cead7b] Merge tag 'trace-v4.20-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> git bisect bad abb8d6ecbd8f7801c048f6543f79d22d24cead7b
> # good: [33aaebd48ae2d2c78fef5063a0381e17db19b060] ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer Aspire U27-880
> git bisect good 33aaebd48ae2d2c78fef5063a0381e17db19b060
> # good: [b72f936f6b325f4fde06b02e4b6ab682f6f2e73f] ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4860G/Z6860G
> git bisect good b72f936f6b325f4fde06b02e4b6ab682f6f2e73f
> # good: [002f421a84c5a9260bf0e312af5d5043b3555511] Merge tag 'csky-4.20-rc6' of github.com:c-sky/csky-linux
> git bisect good 002f421a84c5a9260bf0e312af5d5043b3555511
> # bad: [1aed58e67a6ec1e7a18bfabe8ba6ec2d27c15636] Uprobes: Fix kernel oops with delayed_uprobe_remove()
> git bisect bad 1aed58e67a6ec1e7a18bfabe8ba6ec2d27c15636
> # first bad commit: [1aed58e67a6ec1e7a18bfabe8ba6ec2d27c15636] Uprobes: Fix kernel oops with delayed_uprobe_remove()
> -------------------------------------------------------------------------------
> 

