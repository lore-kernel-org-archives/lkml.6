Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1638A20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1638A20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeIGM2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:28:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeIGM2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:28:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76927AF3C;
        Fri,  7 Sep 2018 07:48:29 +0000 (UTC)
Subject: Re: [PATCH v3] xen: avoid crash in disable_hotplug_cpu
To:     Olaf Hering <olaf@aepfle.de>, xen-devel@lists.xenproject.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180907063023.16913-1-olaf@aepfle.de>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c26bfbe1-9032-468c-d4d0-c05eda8af762@suse.com>
Date:   Fri, 7 Sep 2018 09:48:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907063023.16913-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/18 08:30, Olaf Hering wrote:
> The command 'xl vcpu-set 0 0', issued in dom0, will crash dom0:
> 
> BUG: unable to handle kernel NULL pointer dereference at 00000000000002d8
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 PID: 65 Comm: xenwatch Not tainted 4.19.0-rc2-1.ga9462db-default #1 openSUSE Tumbleweed (unreleased)
> Hardware name: Intel Corporation S5520UR/S5520UR, BIOS S5500.86B.01.00.0050.050620101605 05/06/2010
> RIP: e030:device_offline+0x9/0xb0
> Code: 77 24 00 e9 ce fe ff ff 48 8b 13 e9 68 ff ff ff 48 8b 13 e9 29 ff ff ff 48 8b 13 e9 ea fe ff ff 90 66 66 66 66 90 41 54 55 53 <f6> 87 d8 02 00 00 01 0f 85 88 00 00 00 48 c7 c2 20 09 60 81 31 f6
> RSP: e02b:ffffc90040f27e80 EFLAGS: 00010203
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff8801f3800000 RSI: ffffc90040f27e70 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff820e47b3 R09: 0000000000000000
> R10: 0000000000007ff0 R11: 0000000000000000 R12: ffffffff822e6d30
> R13: dead000000000200 R14: dead000000000100 R15: ffffffff8158b4e0
> FS:  00007ffa595158c0(0000) GS:ffff8801f39c0000(0000) knlGS:0000000000000000
> CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000002d8 CR3: 00000001d9602000 CR4: 0000000000002660
> Call Trace:
>  handle_vcpu_hotplug_event+0xb5/0xc0
>  xenwatch_thread+0x80/0x140
>  ? wait_woken+0x80/0x80
>  kthread+0x112/0x130
>  ? kthread_create_worker_on_cpu+0x40/0x40
>  ret_from_fork+0x3a/0x50
> 
> This happens because handle_vcpu_hotplug_event is called twice. In the
> first iteration cpu_present is still true, in the second iteration
> cpu_present is false which causes get_cpu_device to return NULL.
> In case of cpu#0, cpu_online is apparently always true.
> 
> Fix this crash by checking if the cpu can be hotplugged, which is false
> for a cpu that was just removed.
> 
> Also check if the cpu was actually offlined by device_remove, otherwise
> leave the cpu_present state as it is.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  drivers/xen/cpu_hotplug.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
> index d4265c8ebb22..68f9f663da08 100644
> --- a/drivers/xen/cpu_hotplug.c
> +++ b/drivers/xen/cpu_hotplug.c
> @@ -19,11 +19,15 @@ static void enable_hotplug_cpu(int cpu)
>  
>  static void disable_hotplug_cpu(int cpu)
>  {
> +	if (!cpu_is_hotpluggable(cpu))
> +		return;
>  	if (cpu_online(cpu)) {
>  		lock_device_hotplug();
>  		device_offline(get_cpu_device(cpu));
>  		unlock_device_hotplug();
>  	}
> +	if (cpu_online(cpu))
> +		return;
>  	if (cpu_present(cpu))
>  		xen_arch_unregister_cpu(cpu);

Could you merge the two if conditions?

if (!cpu_online(cpu) && cpu_present(cpu))
	xen_arch_unregister_cpu(cpu);

And while not really important, as we are called in the xenstore watch
thread only, it might be a good idea to move the first cpu_online()
test into the lock, i.e.:

lock_device_hotplug();
if (cpu_online(cpu))
	device_offline(get_cpu_device(cpu));
unlock_device_hotplug();

This will make the code robust against reentry.


Juergen
