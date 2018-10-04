Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FFBC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7672084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgOrKxK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7672084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJEBkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:40:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35274 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbeJEBkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:40:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so11035960wrt.2;
        Thu, 04 Oct 2018 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L6Y9Y1jCXQH7QQjG9calOBdWeNbOMMFYVQu/Ox98vB8=;
        b=vgOrKxK/q2tJ7F/UCKQRnmLRUAucoC0SvgMKiHYTVchGyXsRZh1ed+VJBar9p32AKa
         38tYmKFFHGFnwxapelde/IfBfLhVaLg2+FejLCn8t/jIdb7bfVN5bIKuocJzwFn4Wj/w
         xPbZw9yk6KCbSsYXJJgSBmfWWboelNUVlFm1VsK634/ZS8r/7VFbIYw6kd+icA4hIlIE
         Oyz2/jzEN9HWVnpJts4rW3i8SUAneZidarOQujBMncFEn1u1RjDI5QIUgZNCf45EHYYD
         r5dp5HR9LFrj3PBlWlOSrFRkaFmf7ka4q7vtCb6Db5sYoKKQq2EqfIpaj1HcG3frOoaN
         GZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L6Y9Y1jCXQH7QQjG9calOBdWeNbOMMFYVQu/Ox98vB8=;
        b=AgPKjnUAzSQGLjj0tg/OU2xAATQmWbRwUmpVsc1SKLWKubq/LKpjvSOsZdc19zW4bZ
         gvKkRR66pr+d914PAqkntRAXGmPkVWcBwUU4I8pmup/Ned4EGZD0jWkSXWKpoKC5FnZ8
         IlVz5wJlmOpAhBjmU8v7sqg+OOQuYcQl5N5XpnLGTbXUl+1hf7qu4UboGMe+DiwoXIwC
         Q36zO73Rk77J1ptqcXKvvx+bG1r6IKjIHdulgrKkOe/Ns8vonwMWVpdJVUsMkKB50XR8
         ywlSSuFY/OcKaVolRPZU9c+26z6ciVq5DnR5npBO+QInkMcUW6WkOi/XUtJJIUBstMcL
         +yOg==
X-Gm-Message-State: ABuFfohY+CiutVyDLy3lVl9Ihyfde4HTl7KJWS9nHSm1TyOMBV83T1Rq
        0u2ilR+OQbuY/3NvUskpwW6dSNKvA0AUmw==
X-Google-Smtp-Source: ACcGV61hOdwqNSBvlJajxj/pdEOmynGkdMNjQB6Zleujc4lafi4r4UuhHNvKmRJ8PZTfaArEArTI5g==
X-Received: by 2002:adf:ecc9:: with SMTP id s9-v6mr5426983wro.142.1538678743514;
        Thu, 04 Oct 2018 11:45:43 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u191-v6sm7000307wmd.31.2018.10.04.11.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 11:45:42 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:45:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: -Wswitch Clang warnings in drivers/scsi
Message-ID: <20181004184540.GA17513@flashbox>
References: <20181004183047.GA1885@flashbox>
 <1538678069.230807.6.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538678069.230807.6.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:34:29AM -0700, Bart Van Assche wrote:
> On Thu, 2018-10-04 at 11:30 -0700, Nathan Chancellor wrote:
> > Hi SCSI folks,
> > 
> > In an effort to get the kernel building warning free with Clang, we've
> > come across an interesting occurrence in a few scsi drivers:
> > 
> > drivers/scsi/hpsa.c:6533:7: warning: overflow converting case value to switch condition type (2148024833 to 18446744071562609153) [-Wswitch]
> >         case CCISS_GETPCIINFO:
> >              ^
> > ./include/uapi/linux/cciss_ioctl.h:65:26: note: expanded from macro 'CCISS_GETPCIINFO'
> > #define CCISS_GETPCIINFO _IOR(CCISS_IOC_MAGIC, 1, cciss_pci_info_struct)
> >                          ^
> > ./include/uapi/asm-generic/ioctl.h:86:28: note: expanded from macro '_IOR'
> > #define _IOR(type,nr,size)      _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
> >                                 ^
> > ./include/uapi/asm-generic/ioctl.h:70:2: note: expanded from macro '_IOC'
> >         (((dir)  << _IOC_DIRSHIFT) | \
> >         ^
> > 
> > I see this warning in drivers/scsi/hpsa.c and drivers/scsi/smartpqi/smartpqi_init.c
> > on an arm64 allyesconfig build and it has also been reported in a couple of files in
> > drivers/scsi/cxlflash.
> > 
> > As the warning states, there is an overflow because the switch statement's value is of
> > type int but the switch value is greater than INT_MAX. I did a brief sweep of the tree
> > and it seems that all uses of _IOC in switch statement values either are small enough
> > to fit into size int or the value is of size unsigned int.
> > 
> > I am unsure of the implications of using a smaller _IOC value or converting all ioctls
> > to expect a cmd of type unsigned int (especially since that has userspace implications)
> > but I didn't see any negative ioctl commands. Some clarity and insight would be
> > appreciated.
> 
> Have you verified how gcc compiles these switch statements? Maybe gcc supports
> switch / case statements on integral types that are larger than an int?
> 
> Bart.

Hi Bart,

That is entirely possible, I will do some research. I did build with GCC
to see if there was any warning and there isn't so I'll be curious to
see what is happening at a lower level.

Thanks for the comment!
Nathan
