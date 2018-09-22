Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA2ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294B421567
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeqd6tgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294B421567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeIVP51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:57:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37670 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:57:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id q1-v6so1555909plr.4;
        Sat, 22 Sep 2018 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ehJBkiM5j21JwFDXV9pseglwDPQdYPC5hmCDiQAbqxM=;
        b=qeqd6tgDlPmKRvtoxzBt0gZABCNEJDBhVxwdX6FoxbXWtCAUghoK1KHOp1sz9OYsQy
         4EeMhu/GQaO035mx3oDQhgwwW6fnxaJu6YZntCh7BiMs5ZQnJbcB/WqtlZmMowat+Mu+
         ++t9Rue5hB4V15nHVIl0gFlSjjueqdWcdcLGrKaDBOYiX7Uic764qmlUw4rqrEW0jc6P
         2h5ewXgVzZqdJ203cKtuOS4rRdVap34lrmmAcfDoSLQDh1slme7ZruLDS0bnXagX9iZH
         8ho+pozbyoO+AxP3l/xM+eEUkWL6ZG8LTvipBgBb0wby/tRUyxePgExg0jYm6hmLS6oS
         2ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ehJBkiM5j21JwFDXV9pseglwDPQdYPC5hmCDiQAbqxM=;
        b=RR4FnVSLdRDgYZ75qs37f7jNOCHFeJKnjN1pK27QZhCnOYI6CjySdI437Gk7izGqDK
         m6xjOLEm44rXqgv9YQRAeH3MfmaUl16a5RHHqU491M8k85d/mQFdRZtjRaUVu867Brb8
         IPY8HHmCDdkb/w7z8oHiOe1wRcMFPefzMVeBZSF2n6Qhj9WksUBA/UFnyECjTFlJczv5
         2s9aPZRFpGCuKAv8qAqGn1p9EGbVNhLufWYphpTfM0ZMofnI3fPXzoZadrnU+bFueN5G
         8y/tzDuKQRlKTFzzbOdCWmCCIpiydghs9cD9feuOpYZP7CdhgvZgSnWFZ4p4a5yhU0OJ
         7jxw==
X-Gm-Message-State: ABuFfoiRnDP7WwpE27pfkisBgSmBLf1i7Z3IIFj4xh5R+aVhEE6MrQ6Q
        I8iB1mU+v/gVa2VV8NZQeWY=
X-Google-Smtp-Source: ACcGV60eDUUYHumDbstPHFC07V00vyN+sATUvq/G+d35Z9FrNi3r1wM6dafooFOHlSw4lvCGSqSzRA==
X-Received: by 2002:a17:902:585:: with SMTP id f5-v6mr1977491plf.7.1537610666705;
        Sat, 22 Sep 2018 03:04:26 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id n74-v6sm43540923pfi.161.2018.09.22.03.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 03:04:26 -0700 (PDT)
Date:   Sat, 22 Sep 2018 18:04:19 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Clean up redundant code.
Message-ID: <20180922100419.GA25620@Eros>
References: <20180920141321.15251-1-songqiang1304521@gmail.com>
 <201809211608.bVz8vg0N%fengguang.wu@intel.com>
 <20180921182616.GA2077@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921182616.GA2077@himanshu-Vostro-3559>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 11:56:16PM +0530, Himanshu Jha wrote:
> Hi Song,
> 
> On Fri, Sep 21, 2018 at 04:10:16PM +0800, kbuild test robot wrote:
> > Hi Song,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on iio/togreg]
> > [also build test ERROR on v4.19-rc4 next-20180920]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Song-Qiang/iio-magnetometer-hmc5843-Clean-up-redundant-code/20180921-091239
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > config: x86_64-randconfig-u0-09211331 (attached as .config)
> > compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64 
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> ERROR: "hmc5843_volatile_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> > >> ERROR: "hmc5843_readable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> > >> ERROR: "hmc5843_writable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> 
> You would need to export these above symbols using EXPORT_SYMBOL()
> to be used by i2c/spi modules.
> 
> But on the other hand, exporting too many symbols is a bad idea since
> it is only used for this driver and not at any other place in IIO.
> So, in my opinion drop this patch and leave the code as-is.
> 
> https://lkml.org/lkml/2018/7/16/566 --> worth reading
> 
> 
> Thanks
> -- 
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology

Hi Himanshu,

You're right, that's exactly what I was missing!
I saw the link you mentioned above and I also think that's a very good
idea to limit the scope of symbols. But I don't know when this work can
be applied to the kernel, as it seems like a not little change for the
build infrastructure.
I think this maybe a common problem for some drivers.
Divers for bmc150 in drivers/iio/accel/bmc-150-accel-core.c did the same
exporting stuff as I was prefered. So I think even if either exporting or
duplicating is not good enough, one must be choosed for now.

I think this is a topic that I have some ideas but not experienced
enough to say what should we do is better. I would like to hear Jonathan's
ideas about this. If this patched shouldn't be applied, then maybe bmc150
should be patched.

yours,
Song Qiang

