Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1C3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2953A20643
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnqJnXef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbeLSPbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:31:43 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:35335 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeLSPbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:31:42 -0500
Received: by mail-io1-f47.google.com with SMTP id o13so200720ioh.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=Eddjy1yIu1eEGnkwlfQj42NuIjTYKtmeSXVcn3/nUZQ=;
        b=nnqJnXefzaPmvQRuHa/IcjOJ6CdRR5GP+dz9+6ZGPpEAjVKqF0a9HmvSXVhdlIqTn0
         /1ZjMHEC4+YP+ZO8fT6oONj+ZWUvzSYfl5hi4ny4456plYejr/26Vy5oh3JqjlZZ05Lo
         JwpHA2N52Y8mWvo+uklz83kH+m4fSpiXktO+iduRc9Q7P1P1Y0gICeHntzMcLq7ITakB
         5bdslW3nf1+C8/QzK9M/yPL4C2xwKnidVBupJ9RNqtjBG3hv+bgcwM0XKjFJezNSdyqC
         ND8YCpBx+Z8olgjsKWE97lzVKPAkoe0vKKNPs6gI8OpjnRTcVMMysojhSis/00jfu2p4
         bmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=Eddjy1yIu1eEGnkwlfQj42NuIjTYKtmeSXVcn3/nUZQ=;
        b=JEdAe7v2UQwv/q0d1pi5lDVOMmbfktNHVmBRqVAttIrOKUhjLH6iOCpNBm09peSB2f
         Ztawu+N59lwCPU6fypeY/ktXqbUBl2uuOj25+0xM/8d370qx/fuKPp6MpVJmSFLiMNl/
         qN6+QRx52/5d0OkVSLuHEAXo4UHilS65uU7nM6kXd0pAg7CYPzYcXUON2STRiDCCAl86
         yVQg/VkPwHEOOBUw+40Fyku3e9GlcCrDHY8E9qkaqoZekSVBJhnTx8yuE4ErBx73MMwR
         P0r1Gy/cbCrTVQ/lBri2ymCOekf5UwV4hLQAEAZEy9ZTHULAGOFDOcayVGH8IF5iEhhh
         n8UA==
X-Gm-Message-State: AA+aEWYf81CunPBEU0jscB+8L7/OVE5C7EGJGqKLnm5UqaTaAbbAxtKh
        BC9QvntER6Pizdy07mO6rS8FRcZmeSLGqpuegpg=
X-Google-Smtp-Source: AFSGD/Xd9Et4pONQEumJ5agaoFVPl7i0fF6cpSo5axb/73WN3vb1e+oqBLRxeZqT319R7+WkLScWbyFRYSVRfFaApSI=
X-Received: by 2002:a6b:1583:: with SMTP id 125mr18203422iov.102.1545233501593;
 Wed, 19 Dec 2018 07:31:41 -0800 (PST)
MIME-Version: 1.0
References: <CABcWhv5QApdqti+fhGuH-3puhk89n2jgfziV2zG3H8Y59RE63A@mail.gmail.com>
 <20181219150604.GB25653@kroah.com>
In-Reply-To: <20181219150604.GB25653@kroah.com>
X-Google-Sender-Delegation: praveenkumar1511@gmail.com
From:   Praveen Kumar <kpraveen.lkml@gmail.com>
Date:   Wed, 19 Dec 2018 21:01:11 +0530
X-Google-Sender-Auth: oHu8Mu3nP5kIyriqG_uhocKxtGE
Message-ID: <CABcWhv4794moz7PZxmzJMySpJnjZR4ikGwHVcicp0-4PWOHmig@mail.gmail.com>
Subject: Re: /proc/modules not showing any output
To:     Greg KH <greg@kroah.com>
Cc:     kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 8:36 PM Greg KH <greg@kroah.com> wrote:
>
> On Wed, Dec 19, 2018 at 06:52:39PM +0530, Praveen Kumar wrote:
> > Hi All,
> >
> > Compiled the vanila kernel 4.20.0-rc6 build, and was trying to get
> > module information, but /proc/modules is not showing any output ( both
> > on arm64 and x86_64 )
> >
> > root@ubuntu:~# uname -a
> > Linux ubuntu 4.20.0-rc6-00082-g65e08c5e8631 #7 SMP PREEMPT Fri Dec 14
> > 15:54:30 IST 2018 aarch64 aarch64 aarch64 GNU/Linux
> >
> > root@ubuntu:~# cat /proc/modules
> > root@ubuntu:~#
> >
> > Tried with older version 4.4.162-78-default modules were properly shown.
> >
> > Can you please help if there is something which I am missing during
> > compilation or is there any potential bug here ? Thanks in advance.
>
> Are you sure your .config file has enabled modules?  Have you actually
> loaded any?  If you do not load any, nothing will show up in that proc
> file :)
>

Thanks Greg for the reply.
I think I did compile with enabled modules.
kern-xen-dev:/mnt/kernel/linux # cat .config | grep MODULE
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_MODULES=y                              <<<<<<<<
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y

I added a new kernel module and was able to see the module added.

kern-xen-dev:/mnt/kernel/linuxfs # insmod linuxfs.ko
kern-xen-dev:/mnt/kernel/linuxfs # cat /proc/modules
linuxfs 16384 0 - Live 0xffffffffc01c1000 (O)

I think, on my test machine, by default, there are many modules which
get added during boot up, which with vanilla kernel is not happening.
Thanks for your input.

Regards,

~Praveen.
