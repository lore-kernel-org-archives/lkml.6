Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C88ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787052084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXa39jzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787052084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeGTC1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:27:37 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35403 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbeGTC1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:27:36 -0400
Received: by mail-oi0-f67.google.com with SMTP id i12-v6so18563194oik.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1tzZOpjDy5bQZJPZgsaTsXg21d3oqAPgOZo+zDjoH1Q=;
        b=uXa39jzijUgjd5yLSxipMAPK7FKCRvWQwBMxjs5KDFsoSiDQHJ1MqJM0qMKHI6/18f
         BruDmnGRRjXcXBrUqBnxVMbV4xiJkC0HcqtHx6GMqk4VQeKZ4XP+wivWBoYbWsvNBJcH
         XA35iAeUpeBhRFd0whYfzvaFdVZ6j/GwWl2Ek+Vgg2yzLs6zOYbG7w++kqjogqkxot9P
         Au9cFSL1dMA/hkcqwAV9Dhjo8d1WZZKWxmdHVyC8RFb8QmcdFAmCxdcw/rTmfU0TpcPN
         17DdHSaE+CpIc9kAOtAaoikLcMozFa066Eo0UCLmmKn/ZO1FCaI6Dag8w6zzMFRyZ6cm
         92dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=1tzZOpjDy5bQZJPZgsaTsXg21d3oqAPgOZo+zDjoH1Q=;
        b=LVj6aFw/zlIiDHmnag2TtJvZq+3gif8UVv9HWtfiuvjuREcjewRn8fiOcQDnArrbi6
         gmMlcdAKcnWEKS8wGWolNqOBEweVihQVU3RBAI0q0xxrsUBg2EAPzhkxXzQ8Fyt+cAOV
         KiH4JWM6Y5//FSKCK3SsnqJzTHkB2SzcS2/3GHVT5TfGuK1+JPeY3Wz5yEnZCwl13qzO
         yNuoAwyhS7WM+siIL6zhAfAak18xkY0zdoF4J8N7Yp7PXm2v6n+4ocfVhW5xA4IbNVdb
         Xz/t+gPcpTeR1yO4fhGnR+fdBdWL9gyMm5YhU6lVbfWcXC2ezWl7P4lQvqvrgY6CjKuQ
         /Xnw==
X-Gm-Message-State: AOUpUlGvDpoMLy3YlxW85WZ3KjphVb616PqwMhEv7IQWW6G1xkv2AoqY
        McnU9fg0dN9zotkKPkfBXlkF2c4=
X-Google-Smtp-Source: AAOMgpdWnEivtM/udTZfl5d7LL2BSKVSp4TW04KmQznDNpdv1ZJdoY24JnIcTWaHi3EZGjr85M2DIA==
X-Received: by 2002:aca:b3d6:: with SMTP id c205-v6mr60941oif.133.1532050906852;
        Thu, 19 Jul 2018 18:41:46 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.59])
        by smtp.gmail.com with ESMTPSA id v202-v6sm485918oie.47.2018.07.19.18.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:41:45 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id B94057A2;
        Thu, 19 Jul 2018 20:41:44 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi: initialize platform driver even when using
 passed-in config
To:     Olof Johansson <olof@lixom.net>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180706184301.12890-1-olof@lixom.net>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <c34f6ed3-115a-d560-ddf9-023ba01d3679@acm.org>
Date:   Thu, 19 Jul 2018 20:41:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706184301.12890-1-olof@lixom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 01:43 PM, Olof Johansson wrote:
> On platforms where manual values are passed in when the module is loaded
> (or through kernel command line), the device is instantiated with a
> reference to the platform driver, but the platform driver never gets
> initialized and loaded.

Sorry, I've been on vacation and busy on other stuff.

Your change is pretty simple, but it changes the behaviour of the 
driver.  Before, if
you had any hardcoded entries, it would ignore everything else. With 
your change
it will pick up platform entries.

I think the right thing to do is to create another platform driver for 
entries that have
no device (hardcode and hotmod, I think).  But I'm not 100% sure on this.

-corey

> Instead, always initialize the driver, but override any SMBIOS-found
> entries with the hardcoded values where they are in conflict.
>
> Crash is as below:
>
> [   20.052087] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
> [   20.067730] PGD 0
> [   20.071821] P4D 0
> [   20.075836] Oops: 0000 [#1] SMP PTI
> [   20.082864] CPU: 1 PID: 1330 Comm: systemd-udevd Not tainted 4.18.0-rc3-00134-g06c85639897c #10
> [   20.100394] Hardware name: <...>
> [   20.121583] RIP: 0010:sysfs_do_create_link_sd.isra.2+0x2f/0xa0
> [   20.361345] RSP: 0018:ffffc9000fab7b10 EFLAGS: 00010246
> [   20.371765] RAX: 0000000000000000 RBX: 0000000000000030 RCX: 0000000000000001
> [   20.386072] RDX: 0000000000000001 RSI: 0000000000000030 RDI: ffffffff82a8ef2c
> [   20.400312] RBP: ffffffff820dcdda R08: 0000000000000001 R09: 0000000000000044
> [   20.414560] R10: 0000000000000220 R11: ffff883ff80471e9 R12: ffff881fee1646e8
> [   20.428808] R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
> [   20.443056] FS:  00007f9d6c1e7940(0000) GS:ffff881ffff80000(0000) knlGS:0000000000000000
> [   20.459210] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   20.470685] CR2: 0000000000000030 CR3: 0000003fd1872006 CR4: 00000000007606e0
> [   20.484934] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   20.499182] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   20.513430] PKRU: 55555554
> [   20.518837] Call Trace:
> [   20.523729]  driver_sysfs_add+0x75/0xa0
> [   20.531388]  device_bind_driver+0xf/0x50
> [   20.539223]  __device_attach+0x89/0x100
> [   20.546885]  ? kobject_uevent_env+0x109/0x530
> [   20.555585]  bus_probe_device+0x8a/0xa0
> [   20.563245]  device_add+0x3df/0x590
> [   20.570214]  platform_device_add+0xb9/0x220
> [   20.578571]  try_smi_init+0x785/0x930 [ipmi_si]
> [   20.587618]  init_ipmi_si+0xfd/0x1a0 [ipmi_si]
> [   20.596493]  ? cleanup_ipmi_si+0x80/0x80 [ipmi_si]
> [   20.606060]  do_one_initcall+0x4e/0x1c9
> [   20.613722]  ? kmem_cache_alloc_trace+0x14e/0x1a0
> [   20.623118]  ? do_init_module+0x22/0x213
> [   20.630950]  do_init_module+0x5a/0x213
> [   20.638438]  load_module+0x1cef/0x2650
> [   20.645927]  ? m_show+0x1c0/0x1c0
> [   20.652550]  ? security_capable+0x3f/0x60
> [   20.660555]  __do_sys_finit_module+0xb2/0xc0
> [   20.669083]  do_syscall_64+0x49/0xf0
> [   20.676225]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>   drivers/char/ipmi/ipmi_si_intf.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index dd758223c56d..6ddfc8be0c76 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2018,7 +2018,13 @@ int ipmi_si_add_smi(struct si_sm_io *io)
>   	mutex_lock(&smi_infos_lock);
>   	dup = find_dup_si(new_smi);
>   	if (dup) {
> -		if (new_smi->io.addr_source == SI_ACPI &&
> +		if (new_smi->io.addr_source == SI_HARDCODED) {
> +			/* Assume the user knew what they wanted when they hardcoded */
> +			dev_info(dup->io.dev,
> +				"Removing discovered %s state machine in favor of hardcoded\n",
> +				si_to_str[new_smi->io.si_type]);
> +			cleanup_one_si(dup);
> +		} else if (new_smi->io.addr_source == SI_ACPI &&
>   		    dup->io.addr_source == SI_SMBIOS) {
>   			/* We prefer ACPI over SMBIOS. */
>   			dev_info(dup->io.dev,
> @@ -2341,12 +2347,13 @@ static int init_ipmi_si(void)
>   
>   	pr_info("IPMI System Interface driver.\n");
>   
> +	/* Always platform since hardcoded entries rely on it. */
> +	ipmi_si_platform_init();
> +
>   	/* If the user gave us a device, they presumably want us to use it */
>   	if (!ipmi_si_hardcode_find_bmc())
>   		goto do_scan;
>   
> -	ipmi_si_platform_init();
> -
>   	ipmi_si_pci_init();
>   
>   	ipmi_si_parisc_init();


