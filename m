Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E658C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650732175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="toTOaaMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390352AbfA1Q1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:27:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41000 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390332AbfA1Q1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:27:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so12297880lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/eTeENllUVBor3ZLLcrRubwa9wKsC0NrA8qQ3FEFC0=;
        b=toTOaaMGbqhZCRdddr4IFBlW5J31RE4u6kutafPsQH0xndpPadh/0T+liAlTtZHRKh
         nRK/ECf273Qfaa5JhqFduHE4uuBO6ahx0Vudd4CbL7WWypgxCbi/DbtF1LH5rlwHy1jT
         DIGWtmHPB8dG/H1YAXkfppclPRfcW2t2GJbUsAiEQ6N97II0/PR7bRWx/O7u6URB823T
         lYJMuwv7bFPgU6pVeVZJ5xmO7DtafGoPvhdaKA+TZsjsFWjANhRtR8mCT/U/B71/EzNJ
         5HRoJo/VpLLAsuCFQq4ZUHVQWFycbBqk0M02xluWKbmSlaFl4tRqw+FWM2PrGfurFsiT
         Cn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/eTeENllUVBor3ZLLcrRubwa9wKsC0NrA8qQ3FEFC0=;
        b=AmDysdn/ulmYFLYZLrrQ5w3PscnSG7jDe+JCQ3QZmenvpPNHPskrUHD9H15ELXzf3H
         MruyfzbVKs+ZZsEaJjIabHGZlWoixD4M+WiMENLhYsfuZ/crKTuI3UoPPOxcvSnWUE6O
         c7DJNeX2ftacVXnF48z8sXxxOvX6JLBkOplzgrvMaf1w2XZby4b2MHBCI+QldTSUuvMf
         PccoS+MC5J6d9i1Fzx6ABU3Yw6r5Pe/6oLBbQi2GQdXnfC409sePpP0XD/FTpmkESFjH
         MYIUc5SC45WItF5RmFaoqPRx39zrSbt12yLkqT+ApT+LH2+iv/wno31xy7arWDCq/zs5
         zcJQ==
X-Gm-Message-State: AJcUukdMxcQUWoYBFMfsKfTVyZSfspPm2d1cHW6FftM5UYLvRQ5LwTf5
        F0cgQK0VFgtkvn97pmevz5Yd1l3bZavjC6ZOC5WJ
X-Google-Smtp-Source: ALg8bN5IUr5nBugCgdRwdtgLtxJnINE8UlGGXSRtL9hRE5XHQj1O1mic1s+QbshhF9C/VLitHyZw/NV38q/ilvTclPg=
X-Received: by 2002:a19:ee08:: with SMTP id g8mr17084558lfb.72.1548692822794;
 Mon, 28 Jan 2019 08:27:02 -0800 (PST)
MIME-Version: 1.0
References: <20151208164237.15736.42955.stgit@localhost> <5490ae28-251b-bfda-38a6-5be201a4a8d8@nokia.com>
 <CAHC9VhQsVFY1LAakAUUCBZw6nmSy0-eoFrhQgVQrkqgAsWVGhQ@mail.gmail.com>
 <4fb6def1-a1d9-8af0-394c-f92224884d18@nokia.com> <CAHC9VhT1T4wTonW_L8CH2j1aMqSaBcUf-zH==233+ZZvSKhkwg@mail.gmail.com>
 <8bf5d613-9b27-381d-283b-c8892483f424@nokia.com>
In-Reply-To: <8bf5d613-9b27-381d-283b-c8892483f424@nokia.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 11:26:51 -0500
Message-ID: <CAHC9VhR25UdWPSRurefEX3YjM80DEh5BXETvK4na3Ym+k2=9xQ@mail.gmail.com>
Subject: Re: [PATCH] audit: always enable syscall auditing when supported and
 audit is enabled
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc:     "linux-audit@redhat.com" <linux-audit@redhat.com>,
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

On Mon, Jan 28, 2019 at 10:38 AM Sverdlin, Alexander (Nokia - DE/Ulm)
<alexander.sverdlin@nokia.com> wrote:
> Hello Paul,
>
> On 28/01/2019 15:52, Paul Moore wrote:
> >>>>> time also enables syscall auditing; this patch simplifies the Kconfig
> >>>>> menus by removing the option to disable syscall auditing when audit
> >>>>> is selected and the target arch supports it.
> >>>>>
> >>>>> Signed-off-by: Paul Moore <pmoore@redhat.com>
> >>>> this patch is responsible for massive performance degradation for those
> >>>> who used only CONFIG_SECURITY_APPARMOR.
> >>>>
> >>>> And the numbers are, take the following test for instance:
> >>>>
> >>>> dd if=/dev/zero of=/dev/null count=2M
> >>>>
> >>>> ARM64:      500MB/s -> 350MB/s
> >>>> ARM:        400MB/s -> 300MB/s
> >>> Hi there.
> >>>
> >>> Out of curiosity, what kernel/distribution are you running, or is this
> >>> a custom kernel compile?  Can you also share the output of 'auditctl
> >> This test was carried out with Linux 4.9. Custom built.
> > I suspected that was the case, thanks.
> >
> >>> -l' from your system?  The general approach taken by everyone to
> >>> turn-off the per-syscall audit overhead is to add the "-a never,task"
> >>> rule to their audit configuration:
> >>>
> >>>  # auditctl -a never,task
> >>>
> >>> If you are using Fedora/CentOS/RHEL, or a similarly configured system,
> >> This is an embedded distribution. We are not using auditctl or any other
> >> audit-related user-space packages.
> >>
> >>> you can find this configuration in the /etc/audit/audit.rules file (be
> >>> warned, that file is automatically generated based on
> >>> /etc/audit/rules.d).
> >> I suppose in this case rule list must be empty. Is there a way to check
> >> this without extra user-space packages?
> > Yes, unless you are loading rules through some other method I would
> > expect that your audit rule list is empty.
> >
> > I'm not aware of any other tools besides auditctl to load audit rules
> > into the kernel, although I haven't ever had a need for another tool
> > so I haven't looked very hard.  If you didn't want to bring auditctl
> > into your distribution, I expect it would be a rather trivial task to
> > create a small tool to load a single "-a never,task" into the kernel.
>
> I've done a quick test on my x86_64 PC and got the following results:

...

> Which brings me to an idea, that the subject patch should have been accompanied
> by a default "never,task" rule inside the kernel, otherwise you require an
> extra user-space package (audit) just to bring Linux 4.5+ to 4.4 performance
> levels.

[NOTE: I dropped pmoore@redhat.com from the To/CC line, I left Red Hat
for greener pastures several months ago.]

Well, it generally hasn't been an issue as 1) most people that enable
audit also enable syscall auditing and 2) most people that enable
audit have some sort of audit userspace tools to work with the audit
logs (and configure audit if necessary).  I don't want to diminish
your report, but this change was made several years ago and we really
haven't heard of many issues surrounding the change.  If we can ever
get all of the different arches to support syscall auditing, I'd love
to get rid of the syscall auditing Kconfig knob entirely.

If you wanted to put together a patch that added a single "-a
never,task" rule on boot I could get behind that, just make it default
to off.

-- 
paul moore
www.paul-moore.com
