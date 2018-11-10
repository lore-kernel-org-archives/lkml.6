Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E01BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE22520840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ns0c9Zpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE22520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeKJP0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:26:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38277 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeKJP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:26:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id q186-v6so3371337ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 21:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kMWXyngKUYHE1/3txmEIZDDZQlXN8AUZB9QWLFdisYc=;
        b=ns0c9ZpeAQIBsP5suVv1hZBT1E4j2hh4Li4mXxZSHL9Iq7Er1YE6bzkiM5JN9ZIXp8
         R/9L5MzSa4dMcpDcQq7EW1WeAHdEpzxKngYcFxfyizVNqaa28xcfZH01zJ3hMtdOvFgw
         XtfE5FOhj3I13VGlyC2cC7cZXWki6kjzPPdMhfBH6HEe0Gl2OeXKI+vmCaV4x49l1CfW
         Pi3wEHJXtfbv3nXsAua1JbAtzR4elayRUe4UXozOA7z5liqmijAh2KQXL50JP7LSmQCc
         doY7XcL9B80SYbhxZjLXuvlnJUDqchozeM7LH61h3vXuZo7k2Re1ImnKdYncprNiPPgT
         a4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kMWXyngKUYHE1/3txmEIZDDZQlXN8AUZB9QWLFdisYc=;
        b=FByCrEDhT7rpt44Zg1+5APkYjzU0o0jd3GXe0utQiySRID3YaGTvXURSRDObv5/Z/8
         eEyrOqrrDwWo/5yOhOQB4Z/tRZcfpuy84t8W2RRK8cpgPC0T05C/7ED9too35SfcVY70
         PYPSiVR3Vk3j+De80FjN95AjmAfQzG1A8vChb4E9yEkxk8cDonDZcvmjBT4cE9kBb5Ai
         HME5RTDfduOXbvEGJEFxtop5PIxvEGtW9XMEumoHv3Y6H2vPFynHX/g6LE8YMYb04kUR
         J/bwS8jIcsLtf+p3QShSwQN68u4h2ctdqyj2ApMh0vk2Wl1kplvdCDwjcS7TNUrsy7l0
         MD+g==
X-Gm-Message-State: AGRZ1gJBdOqcnjnCa5yMm2iAacdart6Js7c05BPRmfKrA5RcX1uLsJrE
        dx/Gdze9nwwpVKdIQU+0AJ2xKt3OjTKXsqahYmMImTfrMYRfGw==
X-Google-Smtp-Source: AJdET5cPvYxg6iyarLrf2/9H3S/sbp0u70jm8pgn2cn+FWcC4kYa51sDeyyJTY8q5Ncf/4Sb86hGTwszc0CXy2RabOA=
X-Received: by 2002:a2e:9d50:: with SMTP id y16-v6mr7728098ljj.136.1541823430933;
 Fri, 09 Nov 2018 20:17:10 -0800 (PST)
MIME-Version: 1.0
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
 <CAHRSSExukqyS5V=fgdBP1Jn_KXZEMsWR+wMLNtxBq8+G3wkgSQ@mail.gmail.com> <5FBCBE569E134E4CA167B91C0A77FD610198F8A217@EXMBX-SZMAIL022.tencent.com>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F8A217@EXMBX-SZMAIL022.tencent.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 9 Nov 2018 20:16:57 -0800
Message-ID: <CAHRSSEx=z_CCfM5dmdm_cVtH-Az5eKCL5N_S-52qqSsMmGDUbQ@mail.gmail.com>
Subject: Re: Re: [PATCH V3] binder: ipc namespace support for android binder
To:     chouryzhou@tencent.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, akpm@linux-foundation.org,
        dave@stgolabs.net,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>, chouryzhou@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 7:09 PM chouryzhou(=E5=91=A8=E5=A8=81) <chouryzhou@t=
encent.com> wrote:
>
> >
> > I still don't understand the dependencies on SYSVIPC or POSIX_MQUEUE.
> > It seems like this mechanism would work even if both are disabled --
> > as long as IPC_NS is enabled. Seems cleaner to change init/Kconfig and
> > allow IPC_NS if CONFIG_ANDROID_BINDER_IPC and change this line to
> > "#ifndef CONFIG_IPC_NS"
>
> Let me explain it in detail. If SYSIPC and IPC_NS are both defined,
> current->nsproxy->ipc_ns will save the ipc namespace variables. We just u=
se
> it. If SYSIPC (or POSIX_MQUEUE) is defined while IPC_NS is not set,
> current->nsproxy->ipc_ns will always refer to init_ipc_ns in ipc/msgutil.=
c,
> which is also fine to us. But if neither SYSIPC nor POSIX_MQUEUE is set
> (IPC_NS can't be set in this situation), there is no current->nsproxy->ip=
c_ns.
> We make a fack init_ipc_ns here and use it.

Yes, I can read the code. I'm wondering specifically about SYSVIPC and
POSIX_MQUEUE. Even with your code changes, binder has no dependency on
these configs. Why are you creating one? The actual dependency with
your changes is on "current->nsproxy->ipc_ns" being initialized for
binder -- which is dependent on CONFIG_IPC_NS being enabled, isn't it?

If SYSVIPC or POSIX_MQUEUE are enabled, but IPC_NS is disabled, does this w=
ork?

>
> > why eliminate name? The string name is very useful for differentiating
> > normal "framework" binder transactions vs "hal" or "vendor"
> > transactions. If we just have a device number it will be hard to tell
> > in the logs even which namespace it belongs to. We need to keep both
> > the "name" (for which there might be multiple in each ns) and some
> > indication of which namespace this is. Maybe we assign some sort of
> > namespace ID during binder_init_ns().
>
>  I will remain the name of device. The  inum of ipc_ns can be treated as
> namespace ID in ipc_ns.
>
> > As mentioned above, we need to retain name and probably also want a ns
> > id of some sort. So context now has 3 components if IPC_NS, so maybe a
> > helper function to print context like:
> >
> > static void binder_seq_print_context(struct seq_file *m, struct
> > binder_context *context)
> > {
> > #ifdef CONFIG_IPC_NS
> >           seq_printf(m, "%d-%d-%s", context->ns_id, context->device,
> > context->name);
> > #else
> >           seq_printf(m, "%d", context->name);
> > #endif
> > }
> >
> > (same comment below everywhere context is printed)
> >
> > Should these debugfs nodes should be ns aware and only print debugging
> > info for the context of the thread accessing the node? If so, we would
> > also want to be namespace-aware when printing pids.
>
> Nowadays, debugfs is not namespace-ized, and pid namespace is not associa=
ted
> with ipc namespace.  Will it be more complicated to debug this if we just=
 print
> the info for current thread? Because we will have to enter the ipc namesp=
ace
> firstly. But add ipc inum should be no problem.

With the name and ns id, debugging would be fine from the host-side. I
don't understand the container use cases enough to know if you need to
be able to debug binder transaction failures from within the container
-- in which case it seems like you'd want the container-version of the
PIDs -- but obviously this depends on how the containers are set up
and what the use-cases really are. I'm ok with leaving that for a
later patch.

>
> - choury -
>
>
