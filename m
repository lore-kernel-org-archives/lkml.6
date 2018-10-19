Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD0DECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCA321470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaG20aXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCA321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeJSOzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:55:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41445 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:55:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id q7-v6so8333118wrr.8;
        Thu, 18 Oct 2018 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ijcZ61+Aih4TeGCBVHN2MUNaatFjoSqj+Zv/KEE3h18=;
        b=uaG20aXolGUjW64VLJ7bACQ4qz3o8Gu6tDH5mp7Jbdv0mqc+LzIPIPYDNnWLZALZ05
         90ULl1YNmWVPNmtGVoZM0RnsJjZhpA1P1MYEvm5NSL5HY0opIilwyUnAfna9+GDYzmxI
         gZrduMJETcw55mYUG+jFz2dvIlh1ZI3OcEPuOMLEoogMYPBBrpuOVge5Hc1tl1I36Val
         ROugQTP0S02d4YEdCleJEQh2/pwh5EByOwlQOczYDRbDoWqpIHevjJ2FERRLM6eBW1Af
         wJ8yLlLfk3ge04pYZNagMWj9ys0MQv4QXK3v/uvjcTefYOI6eyJ4/6LsRoD6QMzypyXn
         2y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ijcZ61+Aih4TeGCBVHN2MUNaatFjoSqj+Zv/KEE3h18=;
        b=JVKlAGfohIN2HWrghGCX88rtjjAg1xD4rYfOzTAxHmRzXj1x0pD9eDEPPiyRf3ymE8
         KRoplP/kjaM/tFqCqsvwDHR6lnsk2gMz6hpG5Hi+bgnDzfCGKjdfKgIb2yO4nZdLDcNb
         LcN3mZsqB+Y/0wWIiiogrXfIiJgsP+IgzS+vCR1j/V9sVc/hZqqH37g1PTuPFUGqR1RF
         BkqZn1DbtJMwuFk7AFnoVM0McrilPgO1ttzD/T91F9gVu5/8eDQRfl6UNwETWQjuXeWQ
         X0eoyAnh4xJ5S5e6fR8vxflUkDJJIDVO13+gO0yYChGj81kIfjYsfNAl/6aISKIpvAJR
         BMQA==
X-Gm-Message-State: ABuFfogWhLyhYhL1BoXdgNI7dMbj2q8C4XXz58r5VCVkPcdhy2F4pn63
        K131pO+yZiq5afcow4in202gUhzMNxCsOw==
X-Google-Smtp-Source: ACcGV60Z7Mr1gC/QsLoPs7RBJRO77wz9fGyCIQtH4jmzkPgz5EGTMU4fddVtgN9NVSPf4MxcVLZqJA==
X-Received: by 2002:a5d:6551:: with SMTP id z17-v6mr30989026wrv.194.1539931867453;
        Thu, 18 Oct 2018 23:51:07 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z4-v6sm18297558wrt.13.2018.10.18.23.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 23:51:06 -0700 (PDT)
Date:   Thu, 18 Oct 2018 23:51:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: -Wswitch Clang warnings in drivers/scsi
Message-ID: <20181019065104.GA27170@flashbox>
References: <20181004183047.GA1885@flashbox>
 <1538678069.230807.6.camel@acm.org>
 <20181004184540.GA17513@flashbox>
 <CAKwvOd=FrGZ-oh5Q9RGQD2GNORZrqwAZUzNYN+hTKkp5wrfrqw@mail.gmail.com>
 <20181005065754.GA18637@flashbox>
 <1539024429.64374.40.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539024429.64374.40.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:47:09AM -0700, Bart Van Assche wrote:
> On Thu, 2018-10-04 at 23:57 -0700, Nathan Chancellor wrote:
> > Regardless of how the overflow is handled within the switch statement,
> > the overflow is also happening when passing in these values to the ioctl,
> > right? I mean these case values are defined in the uapi files so that
> > userspace can easily pass them in to the ioctl, meaning those values are
> > being passed in as a signed integer and I would assume subsequently
> > overflowing unless I'm just missing something here.
> 
> From the user space header <sys/ioctl.h>:
> 
> extern int ioctl (int __fd, unsigned long int __request, ...) __THROW;
> 
> From the kernel header <linux/fs.h>:
> 
> 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
> 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
> 
> Why has the second argument been declared as "unsigned long" in the glibc
> headers and as "unsigned int" in the kernel headers? That's not clear to me.
> 
> Bart.
> 

Hi Bart,

Sorry it took me so long to reply, somehow this email got lost in my
inbox...

Unfortuntely, I am unsure why there is that discrepency between the
headers. I tried to do some research but I didn't come up with much.

However, I did test changing the type of ioctl/compat_ioctl's cmd
parameter to 'unsigned int' and came up with the following diff (rather
large so sharing via a gist instead of pasting here):

https://gist.github.com/nathanchance/8febc92735f4228574cb0464520f0f6f

I'll obviously draft up a proper commit message before formally sending
but I can address any major concerns before that happens. I checked
every single ioctl for a negative value and there aren't any so I think
this change makes sense to fix this warning.

Cheers,
Nathan
