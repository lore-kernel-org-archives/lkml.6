Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3088FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1832150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQTWIQEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1832150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeHWWyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:54:09 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44832 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeHWWyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:54:08 -0400
Received: by mail-oi0-f66.google.com with SMTP id l82-v6so5645129oih.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 12:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CqoyeFzUJ6zmgIatiRxc/g8Rnnv6WERcPFLca2dTD0=;
        b=PQTWIQEtpG0iJPWcgqp1zw2PdZ19fpwKf0I+NdrNjwlbNak4IFe7OIm9fLynYXdk0O
         mHZ12IYIv+KC6hsC/O+nS+nWueS4/m8TfylDxRtNvC7ljBg91uZbz76vxllcZ9XSy7U4
         MFWuUw5lEXKcC6fs2fVx1s8E9SlVHNlVUZKguvOv2ZoUkqdkb8LiQc4K3pXKONs7ty8z
         jN9E5CGAJYPPJIHtW3znRJPBVh8z7leE+O4d+amSb8mABUjdrBSbECyemDEYkNdIVd/l
         9PTipbgMLEI4zbOwYATRtLEVvMXdzMaCCnmukcGQMBIfv4MfD+o94S/jP3H2BNseU823
         UAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CqoyeFzUJ6zmgIatiRxc/g8Rnnv6WERcPFLca2dTD0=;
        b=ZJHIlgkfLGtXzS8otmYALxsX+n3M2J/XGYaMoZRltpa/hEpBM6w8iCaOqL4Y3osnb7
         na2uyiogU7icz4ti+vmCj9mpAJlGjU79PH+Elw+Trghjnkce+u8w1MFcMzzB0nezTuPK
         ZmzoReEQS045dN6z9Opq250qARQwU/36rOMWbrQkZWv8HNhrnfDiVJ4jNu4/eRf8ocaT
         aY5IRTlfP7h/CXfytXU4V7N75xhQmBpe929ae2yqatcQsQjoUYct99pDyJpHjMnjnOwZ
         22RKdLKP8QOZJUA8I03lXLLcGKY8ETy10n6b9Oou6RC+Z+KZbfecZMZKSiod4qpGnUaL
         6oRA==
X-Gm-Message-State: APzg51AAEYIWayNwhLqhx0pBBG0T727LrPqRfpyg95Qo9BetBCglZMvg
        RhVGIIPgOJVj17v8WxMDyh1MUCX0VVIKZfMXdkNVJEqk
X-Google-Smtp-Source: ANB0VdYy5Ihc15ovIr6rx3722dp9dWncm6RBRgp0XleMv7oZErSeAtfcXYisRPXQzRqZNO5EyYjLZZaJaF9o5Y2/7N8=
X-Received: by 2002:a54:4010:: with SMTP id x16-v6mr10089840oie.228.1535052179793;
 Thu, 23 Aug 2018 12:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180823174359.GA13033@linux.vnet.ibm.com>
In-Reply-To: <20180823174359.GA13033@linux.vnet.ibm.com>
From:   Ray Clinton <mr.ray.clinton@gmail.com>
Date:   Thu, 23 Aug 2018 15:22:48 -0400
Message-ID: <CAPMnawvzuAaXmuMg_Z4_Av59zHmxeWzdbfZv3GaX6Vmw48t+Aw@mail.gmail.com>
Subject: Re: Kernel-only deployments?
To:     paulmck@linux.vnet.ibm.com
Cc:     nicolas.pitre@linaro.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 7:44 PM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> Does anyone do kernel-only deployments, for example, setting up an
> embedded device having a Linux kernel and absolutely no userspace
> whatsoever?

To be honest I'm a total newb to kernel dev, so much so that I copied and
pasted the above quote in the hopes that I did the formatting right. I'm such
 a newb that I realize I might not even understand your question.

That beingsaid, wouldn't building a uImage of the kernel and loading it onto
your device using tftpboot accomplish this?

Ray On Thu, Aug 23, 2018 at 1:46 PM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> Hello!
>
> Does anyone do kernel-only deployments, for example, setting up an
> embedded device having a Linux kernel and absolutely no userspace
> whatsoever?
>
> The reason I as is that such a mode would be mildly useful for rcutorture.
>
> You see, rcutorture runs entirely out of initrd, never mounting a real
> root partition.  The user has been required to supply the initrd, but
> more people are starting to use rcutorture.  This has led to confusion
> and complaints about the need to supply the initrd.  So I am finally
> getting my rcutorture initrd act together, with significant dracut help
> from Connor Shu.  I added mkinitramfs support for environments such as
> mine that don't support dracut, at least not without significant slashing
> and burning.
>
> The mkinitramfs approach results in about 40MB of initrd, and dracut
> about 10MB.  Most of this is completely useless for rcutorture, which
> isn't interested in mounting filesystems, opening devices, and almost
> all of the other interesting things that mkinitramfs and dracut enable.
>
> Those who know me will not be at all surprised to learn that I went
> overboard making the resulting initrd as small as possible.  I started
> by throwing out everything not absolutely needed by the dash and sleep
> binaries, which got me down to about 2.5MB, 1.8MB of which was libc.
> This situation of course prompted me to create an initrd containing
> a statically linked binary named "init" and absolutely nothing else
> (not even /dev or /tmp directories), which weighs in at not quite 800KB.
> This is a great improvement over 10MB, to say nothing of 40MB, but 800KB
> for a C-language "for" loop containing nothing more than a single call to
> sleep()?  Much of the code is there for things that I might do (dl_open(),
> for example), but don't.  All I can say is that there clearly aren't many
> of us left who made heavy use of systems with naked-eye-visible bits!
> (Or naked-finger-feelable, for that matter.)
>
> This further prompted the idea of modifying kernel_init() to just loop
> forever, perhaps not even reaping orphaned zombies [*], given an appropriate
> Kconfig option and/or kernel boot parameter.  I obviously cannot justify
> this to save a sub-one-megabyte initrd for rcutorture, no matter how much
> a wasted 800K might have offended my 30-years-ago self.  If I take this
> next step, there have to be quite a few others benefiting significantly
> from it.
>
> So, does anyone in the deep embedded space already do this?
>
>                                                         Thanx, Paul
>
> [*]     What zombies???  There is no userspace!!!
>
