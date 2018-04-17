Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1716434-1523967163-2-15884036030142360027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523967162; b=YvBhUn/nseb3ISjc/qmytIREQ5X8GK7qjrgko7kgM0aESvMzSb
    fD8lZP3c+H2KBZwLCS891TdMqGO3Nzmx40hzmMORVStf3foo0hF2YxwqmsUecNuT
    g2QZhXsueqrKzhMFui2htug4l1YtQNvHyR/4BHHmfT6wsuRw0fg+KztCK2nd+Jdz
    csACMzjnBLDgPTlD3om/dtanv2Pflebbo6nJaIhmqWgmPRQWeXNEX0D8kwlwGob+
    BBefArYjb5CzL26V1zp7m3USTwLIlC6P1MlFgTjsCUOQ+0Hi5RUTyGZu1d6UcC23
    4bA5eCUAByHIoZSNdOD55ioe3VkGzBbXT7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523967162; bh=Kx93ynm5XFq
    rFsLUrtP60CIxRzQXM9K60btIXlRix80=; b=iavoH6p27el7egqpiX03nymEuQi
    0EYDvA4VeYv5U/6bETa13R9ZhHAiBZ3dD4OrMQeN7zr5JUnE/4PavNORTYX1rn2o
    GQn1n4hnDV+xVd3OkfoZMBjgAEeXGEQxtPoXr+8+PfcxNCdm5nDmZyXI4z5WeOXC
    gjsj6ZBJsltYDwtLYKhaUEA+sfYnMMvA0fnWmj1vYW74dyAEf4PXgriPRM/GzcTQ
    7HgVsxcjT2g0QfKrekMBplGmscV9Imvmdf8zz3nyeXIJCFqFpGR5LSCvKsHUpu2c
    G63mEpkf1bL7AGEWHwa8EqXL1UUdRJYR7kExVXPzE7zRz8bWCEvUdPcBcUw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBL29NyLIicYyWhRgrgR330Akik/63m8AVz6n/sMdiXvRESc2XSjbaD0Bp6fYgtfKx/QnmicbJ20dbeNlsIumGxHZvC/eJ2YjdxXnirCDdAu6nAS5lmJ
    amS/mJxpL0SBugfRCNetdL3d8mXGpFnSKMZTp2ftUIOrHW6IRhG9Tp0rxHWcXSk3X29KudFiIR91i7MJre/sf4Um+NxvWtXqr+dA4XV6QyQczdI+7rAn07ht
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=D8GC7GL-FoSHl6cpUsEA:9 a=QEXdDO2ut3YA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeDQMMM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 08:12:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:39745 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753093AbeDQMMK (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 08:12:10 -0400
Date: Tue, 17 Apr 2018 14:12:07 +0200
From: Jan Kara <jack@suse.cz>
To: Pavlos Parissis <pavlos.parissis@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>,
        stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: kernel panics with 4.14.X versions
Message-ID: <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 01:31:24, Pavlos Parissis wrote:
> On 16/04/2018 04:40 μμ, Jan Kara wrote:

<snip>

> > How easily can you hit this?
> 
> Very easily, I only need to wait 1-2 days for a crash to occur.

I wouldn't call that very easily but opinions may differ :). Anyway it's
good (at least for debugging) that it's reproducible.

> > Are you able to run debug kernels
> 
> Well, I was under the impression I do as I have:
>   grep -E 'DEBUG_KERNEL|DEBUG_INFO' /boot/config-4.14.32-1.el7.x86_64
>   CONFIG_DEBUG_INFO=y
>   # CONFIG_DEBUG_INFO_REDUCED is not set
>   # CONFIG_DEBUG_INFO_SPLIT is not set
>   # CONFIG_DEBUG_INFO_DWARF4 is not set
>   CONFIG_DEBUG_KERNEL=y
> 
> Do you think that my kernel doesn't produce a proper crash dump?
> I have a production cluster where I can run any kernel we need, so if I need
> to compile again with different settings I can certainly do that.

OK, good. So please try running 4.16 as you mention below to verify whether
this is just a -stable regression or also a problem in the current upstream
kernel. Based on your results with 4.16 I'll prepare a debug patch for you to
apply on top of 4.14.32 so that we can debug this further.

> > / inspect
> > crash dumps when the issue occurs?
> 
> I can't do that as the server isn't responsive and I can only power cycle it.

Well, kernel crash dumps work in that situation as well - when the kernel
panics, it will kexec into a new kernel and dump memory of the old kernel
to disk. It can then be investigated with the 'crash' utility. But
obviously you don't have this set up and don't have experience with this so
let's go via a standard 'debug patch' route.

> > Also testing with the latest mainline
> > kernel (4.16) would be welcome whether this isn't just an issue with the
> > backport of fsnotify fixes from Miklos.
> 
> I can try the kernel-ml-4.16.2 from elrepo (we use CentOS 7).

Yes, that would be good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
