Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146072146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KFpQISNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfBHNqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:46:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43830 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBHNqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:46:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so1686822pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jPa/4FsjxI8lgcJIzZebH9QKZ59TFMb7tFmbCrpALpk=;
        b=KFpQISNt257AYVBbLuWz1TkKY3nu7raRB9nkT2Lu5lAl3qHsvgGI+ZZ88fUC7l+d7y
         tCpZ+LEa3DX+4F2PNxdgaKoinwZmzp8lEzASwR2bWluNRSInIStix0GQj7B0D2rtoSwH
         QCrPjik5iFvAMAuGuVF53Cjqt4rS9/lkFkNrBrvA9jR93d+tOJWqMnAju7gWWjt3CF4+
         yjaRWGRvc8yq9htdqcCS8BUEwztQbtvvEBv3RdwsL0Cv9Xg2Feziylv1mrukKYuMC5tF
         aW+CFpUrT0Owo7iz9QCtr/49vFuy09FSITUwYnhQsQ4DFyikFTQhqe4FF+uQeCXZbikI
         q4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPa/4FsjxI8lgcJIzZebH9QKZ59TFMb7tFmbCrpALpk=;
        b=GduND0NJa6qzkLBSsKtfVhP51KgoImNGTgR9TQj3W1Op6SMueP/ELQ8etG7cvdIhJK
         +Pud2l9VxE2Y0KBHqNWqRGfwEcbon32HZRD7JQq+BsOdD3VffwGVBvSaREhthJFy7l+n
         yTgkVMG5E4HHKcFztVkTyIFudjhSaygJd301id2ZvjIHeYVEC9RG6RFmGEJLYPdrwJy2
         jrukCZJFQgg/xOscP9a32OnrmwJ8JuKMwWJ33p5zhBjOFavMc5iDtOKdiAtvthI5Ljg7
         3sAiiGm9ZRICw0HyxetFD6XWfxQFQj1LNkxPl3eMy76KziFOLCN5GNQyDAyS8VVX36iO
         nKoA==
X-Gm-Message-State: AHQUAubngODeXs+j/qlpjqFE1osglCFoBHKCXB7Ij7LuDdkhN6y3LYtb
        Af6B7Hjx75sCZj5MHmfyc9z41gafwzdAGQ==
X-Google-Smtp-Source: AHgI3IabxzjEGcGYLfCNe3OK+WrXVLzjxhiVveVaHaWy1FLXXV7FtspNK7FzenjW0GQRfhlxGqcrYw==
X-Received: by 2002:a63:1063:: with SMTP id 35mr20612146pgq.133.1549633610267;
        Fri, 08 Feb 2019 05:46:50 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x3sm2500633pgc.80.2019.02.08.05.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 05:46:49 -0800 (PST)
Subject: Re: [PATCH] cdrom: Fix race condition in cdrom_sysctl_register
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org
References: <1549516429-6542-1-git-send-email-linux@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7cd6ae8f-a29e-17e8-ddef-ee7c3ae45fb8@kernel.dk>
Date:   Fri, 8 Feb 2019 06:46:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549516429-6542-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 10:13 PM, Guenter Roeck wrote:
> The following traceback is sometimes seen when booting an image in qemu:
> 
> [   54.608293] cdrom: Uniform CD-ROM driver Revision: 3.20
> [   54.611085] Fusion MPT base driver 3.04.20
> [   54.611877] Copyright (c) 1999-2008 LSI Corporation
> [   54.616234] Fusion MPT SAS Host driver 3.04.20
> [   54.635139] sysctl duplicate entry: /dev/cdrom//info
> [   54.639578] CPU: 0 PID: 266 Comm: kworker/u4:5 Not tainted 5.0.0-rc5 #1
> [   54.639578] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [   54.641273] Workqueue: events_unbound async_run_entry_fn
> [   54.641273] Call Trace:
> [   54.641273]  dump_stack+0x67/0x90
> [   54.641273]  __register_sysctl_table+0x50b/0x570
> [   54.641273]  ? rcu_read_lock_sched_held+0x6f/0x80
> [   54.641273]  ? kmem_cache_alloc_trace+0x1c7/0x1f0
> [   54.646814]  __register_sysctl_paths+0x1c8/0x1f0
> [   54.646814]  cdrom_sysctl_register.part.7+0xc/0x5f
> [   54.646814]  register_cdrom.cold.24+0x2a/0x33
> [   54.646814]  sr_probe+0x4bd/0x580
> [   54.646814]  ? __driver_attach+0xd0/0xd0
> [   54.646814]  really_probe+0xd6/0x260
> [   54.646814]  ? __driver_attach+0xd0/0xd0
> [   54.646814]  driver_probe_device+0x4a/0xb0
> [   54.646814]  ? __driver_attach+0xd0/0xd0
> [   54.646814]  bus_for_each_drv+0x73/0xc0
> [   54.646814]  __device_attach+0xd6/0x130
> [   54.646814]  bus_probe_device+0x9a/0xb0
> [   54.646814]  device_add+0x40c/0x670
> [   54.646814]  ? __pm_runtime_resume+0x4f/0x80
> [   54.646814]  scsi_sysfs_add_sdev+0x81/0x290
> [   54.646814]  scsi_probe_and_add_lun+0x888/0xc00
> [   54.646814]  ? scsi_autopm_get_host+0x21/0x40
> [   54.646814]  __scsi_add_device+0x116/0x130
> [   54.646814]  ata_scsi_scan_host+0x93/0x1c0
> [   54.646814]  async_run_entry_fn+0x34/0x100
> [   54.646814]  process_one_work+0x237/0x5e0
> [   54.646814]  worker_thread+0x37/0x380
> [   54.646814]  ? rescuer_thread+0x360/0x360
> [   54.646814]  kthread+0x118/0x130
> [   54.646814]  ? kthread_create_on_node+0x60/0x60
> [   54.646814]  ret_from_fork+0x3a/0x50
> 
> The only sensible explanation is that cdrom_sysctl_register() is called
> twice, once from the module init function and once from register_cdrom().
> cdrom_sysctl_register() is not mutex protected and may happily execute
> twice if the second call is made before the first call is complete.
> 
> Use a static atomic to ensure that the function is executed exactly once.

Applied, thanks.

-- 
Jens Axboe

