Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F91CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C9520844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="b6Lg9os6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfA1Owv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:52:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38664 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfA1Ows (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:52:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so14465319lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBENkcMXEzBlZN5GByv2ewYQ+oLDu6vHTniUepHWzk8=;
        b=b6Lg9os6GuGm/VRPbxhKKDH+wzDPMaSNFZuSHtPW2Vzgxq79fEwey0C0SKifvhPIGQ
         0UR8ld39YPLpyecNERr7W+pWBo3z9ujU2GQiJAa4fiCLR5j1YssEe4Gmk8mO8gTRedR4
         UFV8/17JuLiI11YSUHOA2udUw9HCbb/8FHnjlQtnDaEj8Mrs/zhyYos0gdmCVScwU15J
         zfitEtPAgqNEIO2Ql4IizaUFMro6DK5g4nq4NRRl7QptCOe4WSViiDWod2VQ6JBDnwu7
         eIGnuid75r0Cnz57TzJczcI51jtKL2p9o7DJEKjgyAzgd0oQAgAvgcPiRqzAW9TMrmsu
         HaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBENkcMXEzBlZN5GByv2ewYQ+oLDu6vHTniUepHWzk8=;
        b=h0BZK39AuImApm3c/r0IMyBZi7Eh7j1UpnNpSwc+2ou9OSKG+TA4AdSxqWMRg+I4et
         /NLHQ67nhyyT0YoANCFCgdFRwe3duHPzJmHqsFmy25FOWKQf0Bv4JxNTAxt9XhYfj//5
         +Upj+0xTN/ovh+U1Yg6nZKUSCAeRVPehuEXZnpX/IyeNdyRIFLthvHGzch+s07E26svX
         bDW3BLmlyH223gQ6esFirf2eoDpCXRgB7iofdFBIPyOx0rvG+7vVr6A21Ad4UONDbpXl
         YaBApyaZKnTeqko96snt+sgEiRt5eqe2LExllGAfaDirG6ZtZFLU0c+oZE5V2MGeT+mz
         v2+w==
X-Gm-Message-State: AJcUukcO4+AIW9IW/qqgYFwf8+v26WLCd+QmSD7yZuhJ6cC42yDTm4Rx
        qOEFnmmqbEwHAo4bBcjRRENUKlHLvx4RG8iautnX
X-Google-Smtp-Source: ALg8bN4slus7YwfdM3vnDj+eJWR8vOGyMAMLqI/C2tMH6+ePkH+8EZSst6nptqOeTGsVxpr4mpv7gsFQQxqG6kGq34Y=
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr10070985lji.57.1548687165969;
 Mon, 28 Jan 2019 06:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20151208164237.15736.42955.stgit@localhost> <5490ae28-251b-bfda-38a6-5be201a4a8d8@nokia.com>
 <CAHC9VhQsVFY1LAakAUUCBZw6nmSy0-eoFrhQgVQrkqgAsWVGhQ@mail.gmail.com> <4fb6def1-a1d9-8af0-394c-f92224884d18@nokia.com>
In-Reply-To: <4fb6def1-a1d9-8af0-394c-f92224884d18@nokia.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 09:52:34 -0500
Message-ID: <CAHC9VhT1T4wTonW_L8CH2j1aMqSaBcUf-zH==233+ZZvSKhkwg@mail.gmail.com>
Subject: Re: [PATCH] audit: always enable syscall auditing when supported and
 audit is enabled
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc:     Paul Moore <pmoore@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Richard Guy Briggs <rbriggs@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 9:36 AM Sverdlin, Alexander (Nokia - DE/Ulm)
<alexander.sverdlin@nokia.com> wrote:
> Hello Paul,
>
> On 28/01/2019 15:19, Paul Moore wrote:
> >>> time also enables syscall auditing; this patch simplifies the Kconfig
> >>> menus by removing the option to disable syscall auditing when audit
> >>> is selected and the target arch supports it.
> >>>
> >>> Signed-off-by: Paul Moore <pmoore@redhat.com>
> >> this patch is responsible for massive performance degradation for those
> >> who used only CONFIG_SECURITY_APPARMOR.
> >>
> >> And the numbers are, take the following test for instance:
> >>
> >> dd if=/dev/zero of=/dev/null count=2M
> >>
> >> ARM64:      500MB/s -> 350MB/s
> >> ARM:        400MB/s -> 300MB/s
> > Hi there.
> >
> > Out of curiosity, what kernel/distribution are you running, or is this
> > a custom kernel compile?  Can you also share the output of 'auditctl
>
> This test was carried out with Linux 4.9. Custom built.

I suspected that was the case, thanks.

> > -l' from your system?  The general approach taken by everyone to
> > turn-off the per-syscall audit overhead is to add the "-a never,task"
> > rule to their audit configuration:
> >
> >  # auditctl -a never,task
> >
> > If you are using Fedora/CentOS/RHEL, or a similarly configured system,
>
> This is an embedded distribution. We are not using auditctl or any other
> audit-related user-space packages.
>
> > you can find this configuration in the /etc/audit/audit.rules file (be
> > warned, that file is automatically generated based on
> > /etc/audit/rules.d).
>
> I suppose in this case rule list must be empty. Is there a way to check
> this without extra user-space packages?

Yes, unless you are loading rules through some other method I would
expect that your audit rule list is empty.

I'm not aware of any other tools besides auditctl to load audit rules
into the kernel, although I haven't ever had a need for another tool
so I haven't looked very hard.  If you didn't want to bring auditctl
into your distribution, I expect it would be a rather trivial task to
create a small tool to load a single "-a never,task" into the kernel.

-- 
paul moore
www.paul-moore.com
