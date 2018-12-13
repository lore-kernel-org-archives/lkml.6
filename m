Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F752C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C888820849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544699149;
	bh=VAnteShsxr+mYwyaaWsn+W2dB7z04tnG78OymOge4nA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dh2c5Gn6qC4J90FB6jcGzYSWQ5kwirsO+lYHnGscBce6TBiji5QMCHSJzt1H53HFb
	 4UvcegEszuJh6m78QjZVElpSuqtkhGld/qDOtJ1K1xvhMJkEUWaTKpI6bdLx0VVlil
	 uwbH/dbv7qSL1XstJUzFCFbSMHZz9PCaulDuFkz4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C888820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeLMLFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:05:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35988 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbeLMLFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:05:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so1525515otk.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 03:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIxCMHuiYc5qOlbaPnyB1gC09TvtDkrA2eXRBKRDiBE=;
        b=YK40Gc7pZIQ8eyRzSW3wOzADVOHkCrraC85F6WA5K2SWY2GG9g8TCQFconZeuti1Kd
         /HETZ0g9ErQtc1oZnP5oD3j7fExUrTAc+NASyNEvzWu3afMku/6PsF6k5Xyt+jVL+Noz
         TQBR6tv+VT2Kjsy9BZyplBvKfX85rvd2MX+7WCBmaOKuWTxKV1EHx9o5AVjyObqjeIbK
         DUSenPPWcyidMysLVmDqzsrlFUQgaqfuy4UMWSwOL1W+lma6UsjkFy2DPmxn6um4nGKz
         c2a55LNv9BrmaTuFH59KTfXUJA49JfWLZTF4iSFSqTKMW5tnWCMqMpHBJkeNjFtvMdlb
         tMzQ==
X-Gm-Message-State: AA+aEWafvijh18pxxnQABajHH9YVPr07BeC/L3NcSNQvWaet+K+fIwjH
        DP0zXx41aEpUFF1McEIwc99EQW9iSQZe5MbsUKs=
X-Google-Smtp-Source: AFSGD/WPKil3Q+NtqeI5tJfrL0bEcHoR7JiVG+HQ4R6ZITGaku0CDVMSTC76d0o1AYnRpRMdw8x/CmS6mh797zXk6Qo=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr15612608otq.119.1544699147720;
 Thu, 13 Dec 2018 03:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch> <CAJZ5v0jkE=Rt2ozwcTxRdUN++Sr4HXULksDeMx4jEWj1jVDcyA@mail.gmail.com>
 <20181213095814.GC21184@phenom.ffwll.local> <CAJZ5v0iWshem3kuurF53gutVJ8jFm_caAbetK2CiSCpyc6ReeQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iWshem3kuurF53gutVJ8jFm_caAbetK2CiSCpyc6ReeQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Dec 2018 12:05:36 +0100
Message-ID: <CAJZ5v0g9BGP61CT6SSypo+sUa8BbE+cPuqqzwKfKW=b8YNM6Wg@mail.gmail.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
To:     Daniel Vetter <daniel.vetter@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:23 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 13, 2018 at 10:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:

[cut]

> >
> > - Most of these issues are never visible in normal usage, since normally
> >   driver bind/unbind is done from a kthread or model_load/unload, neither
> >   of which is running in the context of that kernfs mutex kernfs_fop_write
> >   holds. That's why I think the task work is the best solution, since it
> >   changes the locking context of the unbind sysfs to match the locking
> >   context of module unload and hotunplug.
>
> I think that using a task work here makes sense.  There is a drawback,
> which is that the original sysfs write will not wait for the driver to
> actually be released before returning to user space AFAICS, but that
> probably isn't a big deal.
>
> Also please note that the patch changes the code flow slightly,
> because passing a non-NULL parent pointer to
> device_release_driver_internal() potentially has side effects, but
> that should not be a big deal either.
>
> > Unfortunately that trick doesn't work for the bind sysfs file, since that way we can't thread the errno value back to userspace.
>
> Right.  That is unless we wait for the operation to complete and check
> the error left behind by it.  That should be doable, but somewhat
> complicated.

That said I'm not really sure if propagating the error to user space
in this case should be expected.  The interface could be defined as
asynchronous to begin with a separate way for user space to check the
status if necessary.  Changing that now may not be practical, though.
