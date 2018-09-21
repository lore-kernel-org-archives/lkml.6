Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B8521523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHMaL+wT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B8521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391218AbeIVAQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:16:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44643 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391176AbeIVAQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:16:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so6308695plb.11;
        Fri, 21 Sep 2018 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8M6NvsRzq5/PiwuIviYd+0usMHlfL8rTYgkJMHyc8Zs=;
        b=rHMaL+wTBxFzccIYysoEzt0PzbloDF4HmAMkZqnxbJRvqeWHRUSxhVKp1HquWLzq5p
         UVkLEBnJyX7uqgCsnu+QR89n/WQj/wBVQVD5pnqNnkDTEk6WmHGQeVkPwW11hlKztfqu
         fyBO6Ir1dzbgXLaAgQixkBeL6Y1YRFbf88xcIJEGPMrwRoTsCfcxE7ITXSg7J6OsXEiL
         RiIppLH4dhDSu1KPqTpwWAm7Un8MUy6I4IxjoxgLeYRQ1Q2ROUGcv7kpE8fjmRQa/0AZ
         XUNtDrw4eQIIVaM4Y8TyItJCJsY8KbbeND7nZcQiGW13/nX+4rIUzeraZvMa2MY/UVuq
         yYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8M6NvsRzq5/PiwuIviYd+0usMHlfL8rTYgkJMHyc8Zs=;
        b=FZGMRQzg6S+QYX4rhrYXBNMXSim3W3LG92EpJR37x0itiuT0Q/ynzdXaNDeOu4zWom
         umlxIkJ9TMMKcDiunZ21KN/J7WzAXC1B/Qqpi13eKEBUHXrc/NsYfX7hSZw5D7XbGim8
         rBUbpQ6LCcVYJHFPoABffKy9oUlQbs2RK7Q3aejzfSXJuVXyODz0LuwIptQghM1Lxcjo
         vtqYTNGF5KyJggTiOCNU6bJikpqf0bAutLMafotmfHr0UxtStkmLa/xzXW373BBNzM03
         njEfIvKVQ49kB61YGtj1fbfmWtNOhriXGBgSUS/TKlC3J9cfSdnd9Aau1yNrynTVjSHC
         I83w==
X-Gm-Message-State: APzg51CVvGkTbacfT9DbEbGaTyuHADK4YnViUSyCMpcfR5dhEJt8h2ZL
        V6GmjwqVgvARcFt4iYaryZo=
X-Google-Smtp-Source: ANB0Vdb6MfvwnJPpWIPqBo+AUwdPj/Jw8oU8rWsyYaLUr/7RXhYfq8z7jCdcHPXoCOu57PGIjsHFTA==
X-Received: by 2002:a17:902:988a:: with SMTP id s10-v6mr44502343plp.200.1537554384606;
        Fri, 21 Sep 2018 11:26:24 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id y69-v6sm41077708pfd.36.2018.09.21.11.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 11:26:23 -0700 (PDT)
Date:   Fri, 21 Sep 2018 23:56:16 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     songqiang1304521@gmail.com
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Clean up redundant code.
Message-ID: <20180921182616.GA2077@himanshu-Vostro-3559>
References: <20180920141321.15251-1-songqiang1304521@gmail.com>
 <201809211608.bVz8vg0N%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809211608.bVz8vg0N%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Fri, Sep 21, 2018 at 04:10:16PM +0800, kbuild test robot wrote:
> Hi Song,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.19-rc4 next-20180920]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Song-Qiang/iio-magnetometer-hmc5843-Clean-up-redundant-code/20180921-091239
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: x86_64-randconfig-u0-09211331 (attached as .config)
> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "hmc5843_volatile_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> >> ERROR: "hmc5843_readable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> >> ERROR: "hmc5843_writable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!

You would need to export these above symbols using EXPORT_SYMBOL()
to be used by i2c/spi modules.

But on the other hand, exporting too many symbols is a bad idea since
it is only used for this driver and not at any other place in IIO.
So, in my opinion drop this patch and leave the code as-is.

https://lkml.org/lkml/2018/7/16/566 --> worth reading


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
