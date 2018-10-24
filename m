Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B27ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038052075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038052075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJYDJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:09:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40364 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJYDJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:09:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id z9-v6so6789377qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JW22Nj9JavNkAaAoHhk6rQh0OyOgmrYf3Y7ylg6klCo=;
        b=a1eu5/OezYY5AYwkoP1/Hq8K7UVeQ95Nh4iGT8/m/EmBIl1+vtyXoDmnQbkp302gmn
         IeIqQWslTTQs1qXClW4/ZHltH6dgj8ytbj70CcivpiqrdETs5B/jA8Jkc2/gXy6yBvFn
         KB7Xm6I36ruStzouI6uZKiYiREtw+jGnxbLdDI0UIRFITU5s4TzZfW+8baqDtXHS34hL
         RiWX0qb9jTswqJk+k6BI9Xjb973tG2/UI5PM+8vWARlsYcv8UPnnGjLXkzd+uKqVcd+C
         GfGwUNmvwF9i7cJRtK5x3Ea8Q8kiZmvmOv3ypNJZuTDr6EogsA5pT4aSEfzP60v6/LBX
         Okaw==
X-Gm-Message-State: AGRZ1gK6t1n0TlFLxqAfcaUBmw+L8/JBoELvxjPsHX6JL89U+nBf/0P7
        Urup3p05fOPP32XerIMhks1Uow==
X-Google-Smtp-Source: AJdET5d86BD91azO9kquW2+ICjJEaz8CKhc7/u9uVl44+ilY9yPenP+qzSbBR0dminwgRSUpAa2XnA==
X-Received: by 2002:a0c:8cc1:: with SMTP id q1mr3626782qvb.102.1540406443453;
        Wed, 24 Oct 2018 11:40:43 -0700 (PDT)
Received: from loberhel74 (174-083-000-020.dhcp.chtrptr.net. [174.83.0.20])
        by smtp.gmail.com with ESMTPSA id 19-v6sm3729121qkd.44.2018.10.24.11.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 11:40:42 -0700 (PDT)
Message-ID: <1540406442.27840.1.camel@redhat.com>
Subject: Re: [PATCH] V3 init/main.c Enable watchdog_thresh control from
 kernel line
From:   Laurence Oberman <loberman@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Date:   Wed, 24 Oct 2018 14:40:42 -0400
In-Reply-To: <201810250204.vqMhcNpx%fengguang.wu@intel.com>
References: <1540399992-23448-1-git-send-email-loberman@redhat.com>
         <201810250204.vqMhcNpx%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 02:23 +0800, kbuild test robot wrote:
> Hi Laurence,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linux-sof-driver/master]
> [also build test ERROR on v4.19 next-20181019]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Laurence-Oberman/V3-
> init-main-c-Enable-watchdog_thresh-control-from-kernel-line/20181025-
> 015902
> base:   https://github.com/thesofproject/linux master
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    init/main.c: In function 'is_watchdog_thresh_setup':
> > > init/main.c:1037:20: error: 'watchdog_thresh' undeclared (first
> > > use in this function); did you mean 'proc_watchdog_thresh'?
> 
>      get_option(&str, &watchdog_thresh);
>                        ^~~~~~~~~~~~~~~
>                        proc_watchdog_thresh
>    init/main.c:1037:20: note: each undeclared identifier is reported
> only once for each function it appears in
> 
> vim +1037 init/main.c
> 
>   1033	
>   1034	static int __init
>   1035	is_watchdog_thresh_setup(char *str)
>   1036	{
> > 1037		get_option(&str, &watchdog_thresh);
> 
>   1038		return 1;
>   1039	}
>   1040	__setup("watchdog_thresh=", is_watchdog_thresh_setup);
>   1041	
>   1042	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation

Hello Randy

So I have tested this with no issues, it built clean multiple times
no errors and I was able to set the parameter and I have been using it
for days.

BOOT_IMAGE=(hd0,msdos1)/vmlinuz-4.18.x86_64
root=/dev/mapper/rhel_segstorage3-root ro crashkernel=512M@64M
resume=/dev/mapper/rhel_segstorage3-swap
rd.lvm.lv=rhel_segstorage3/root rd.lvm.lv=rhel_segstorage3/swap
memmap=128G!385G watchdog_thresh=60

[root@segstorage3 ~]# cd /proc/sys/kernel
[root@segstorage3 kernel]# cat watchdog_thresh
60

Do I maybe need the below to avoid the warning
extern int watchdog_thresh;

Thanks
Laurence
