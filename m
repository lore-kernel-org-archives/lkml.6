Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5081C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600C5208B3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="KEpMZ1RK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600C5208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeGGV2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:28:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34095 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754060AbeGGV22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:28:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so583165pgv.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6cbni3BTTe7y3mBZmHihx9343OAlsbglTOx82f0/oI=;
        b=KEpMZ1RKTFW9uT35t89XP25BMofJD050/8CnvcXfZjsEsxAqmyfmmP4kUpdSrpGyFF
         fC5sNpvLSdfTxN9Xm7C5VDxaXMNEoT5nOtgxhtB7kZMhKIIijwtI1gEEcPK5D0UKkJCz
         xwaf5hdBPBBNNk0CvdSUhrbZSRijXiUIKhWP25uS5lgyLgHEME9q94j2fSitb048GOuL
         btjeTF0f+JAUNDMDAKW/zBg7oc0LquXKXgnrpQdRBf4Dz+gGeecj4sjQDB+KXpqFxDR4
         ssr+0c2wwb5URdJ8bJEh17HnPSvKFJuiix2mmlrSdHO4Grc6j2aOLPwftw5U6YbHncbh
         WNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6cbni3BTTe7y3mBZmHihx9343OAlsbglTOx82f0/oI=;
        b=Vvi/xczg1pJ7PDydDCLbuTGNSVIyYMyb02vEeNj+5aHzN5/OVGdAyfwqwvV7AbbMzf
         f50140SWKbgYXDhJvFJusod6Opmesf4iMo9rR8Tf1jjYVGRdlhMTkq1yLxCkf6fkQzdf
         kTZXR1Q3JoSycTVqOIBda4vCw+o7yALqi4ZxYtgREAHo6klKMPYY4t7nB8Uuml7LAQhr
         f4cgX05ou0v7CdfzrdHsDAdSIU4OEEU8vtkF19ISQlTEDxheNdiXU+JZasYaptQ7M4y+
         YZ9ZJWmYr3ItOJR1EFvdGBBayQLgi++cGVaC8ocMFgSik5bLM3raHNZe1HhKUokwyyUQ
         sjlg==
X-Gm-Message-State: APt69E3n/CH0QYOGWND4gaiIJM7kEyZ4ZsQ3e3TggmqS+1q2+r1gWgbK
        yxjb5V3CgPCypYE7zrfPLxxGdg==
X-Google-Smtp-Source: AAOMgpfmbNixHIC49nd+bxSqUEFz0Fm8zR1vfqoKS9HTZT119gR13yLM8h5ycLp3gdahYMPsN9cHXg==
X-Received: by 2002:aa7:8713:: with SMTP id b19-v6mr15492603pfo.151.1530998907725;
        Sat, 07 Jul 2018 14:28:27 -0700 (PDT)
Received: from vader ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id b67-v6sm36380754pfd.74.2018.07.07.14.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 14:28:27 -0700 (PDT)
Date:   Sat, 7 Jul 2018 14:28:25 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: Re: [PATCH 5/7] proc/kcore: clean up ELF header generation
Message-ID: <20180707212825.GA23366@vader>
References: <196479b479237502d4d8b0e5a562b52205e5c374.1530904769.git.osandov@fb.com>
 <201807071557.QxJwgEfj%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807071557.QxJwgEfj%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 06:05:17PM +0800, kbuild test robot wrote:
> Hi Omar,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.18-rc3 next-20180706]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Omar-Sandoval/proc-kcore-improvements/20180707-052548
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    include/linux/nodemask.h:265:16: sparse: expression using sizeof(void)
>    include/linux/nodemask.h:271:16: sparse: expression using sizeof(void)
> >> fs//proc/kcore.c:328:23: sparse: expression using sizeof(void)
> >> fs//proc/kcore.c:328:23: sparse: expression using sizeof(void)

Not sure why this confuses sparse. Maybe because it's #define elfhdr
elf64_hdr.

>    fs//proc/kcore.c:368:23: sparse: expression using sizeof(void)
>    fs//proc/kcore.c:368:23: sparse: expression using sizeof(void)
> >> fs//proc/kcore.c:384:49: sparse: missing braces around initializer

This is

>  > 384			struct elf_prstatus prstatus = {0};

GCC doesn't complain, but I guess I can change it to "= {};", which
isn't strict C89 but both GCC and sparse are happy with.
