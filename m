Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3C53EC07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65C22087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KW4PmawE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65C22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933140AbeFKSvu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:51:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53030 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeFKSvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:51:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so16464254wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/t6TzYRrEArVifOmxTfTGnjHafv6/3KlwlFq8kwamCo=;
        b=KW4PmawEh+abKnolb2EX+ByOQ7+b2Z+94ZMAJT0di9sPGivYRSylNXMmpiHe4ZekpJ
         17k4mMzWQOd0VSPOXymvc5MFhML/9NOQyBIKZzGRqGgteT9iNExh99Vh/lK3XBVRl/aM
         liUmeeLBCVBZ68FLb4+XopAHwufNfI/Kc5LORv0bGSif+bqYtBVy/TE2MTluc6LQ4hQL
         zqrILgW2n7eJfsFCeth1kf6bHEkq1pY+70DJpuHfvXYQYawRk621l4hyk1oV+c8nmLGl
         ylv0ztALWFSFwGrqesuY4W6nu5ihuwfvq+WxS330RbygvuVYZTOIOjAqDX9dvKxKWgu9
         mIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/t6TzYRrEArVifOmxTfTGnjHafv6/3KlwlFq8kwamCo=;
        b=bVi3KPgQek/hxh2jloFx1fSPGc5QXrQei0u8SMNMafeM8pEu3CHEY3HQjKW3CRMSTk
         SEvByvaFFVXlvYFhW+fvZgnc+sCXIXrqKlj3S4knMOPJIrNDAvX5ZYP41GakV2HolyPT
         jo/bresd+KY87rjHO2nmcYsPy0rQElsbVBCUQNSvwP8DPkLx91YFeJGk5bg6f6+/LSaX
         2kYUcX7dHoKEFPShWHAZlDjyA191y0KnftcWAHw65xt873qQb832UQfRgppIG5N41mtp
         Ak79DFJtEHhOpnZdRtP1brPJS2xrGvlCV7+JOMELLjy01a4M6XVun8Jg+jN5s7+NbNyK
         l1mw==
X-Gm-Message-State: APt69E0hxY7JU2IivbsaV9GNuXaSensL7WZ9bdsAbryCKyJVfSEGfrLa
        K2T8u/p3eIn9x6Tz3asWR3K9o7ZcINmv30/EuiOguw==
X-Google-Smtp-Source: ADUXVKJEvtv0Olhz4Ew8sFZEb6g3XfRxV+DP90OpooofeoJJZ6WSdPliiJ5GdAxB4YW7e9wlF2dicBvo62QZQD6qBDw=
X-Received: by 2002:a1c:afc3:: with SMTP id y186-v6mr84085wme.87.1528743106721;
 Mon, 11 Jun 2018 11:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180608184842.GD30522@ZenIV.linux.org.uk> <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
 <20180609051051.GF30522@ZenIV.linux.org.uk> <20180609155107.GH30522@ZenIV.linux.org.uk>
 <20180611021028.GT30522@ZenIV.linux.org.uk> <20180611162313.GA6942@infradead.org>
 <20180611164859.GA28292@bombadil.infradead.org> <CA+55aFykGPDTVN=UvrcDvwV3S_sixXREu8D7eK+x695OmA2PNw@mail.gmail.com>
 <20180611171811.GB28292@bombadil.infradead.org>
In-Reply-To: <20180611171811.GB28292@bombadil.infradead.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 11 Jun 2018 11:51:34 -0700
Message-ID: <CABPqkBTwqtFxtFsCjTNyHa_T1_vCbCQWHwo42RZAbg0QRi1BFw@mail.gmail.com>
Subject: Re: perfmon trouble
To:     willy@infradead.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 11, 2018 at 10:18 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jun 11, 2018 at 10:04:00AM -0700, Linus Torvalds wrote:
> > On Mon, Jun 11, 2018 at 9:49 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > The problem is that even oprofile on ia64 depends on perfmon.
> >
> > Hmm? You can definitely enable ia64 support for oprofile even without perfmon.
>
> Oh, I think my memory is playing tricks on me.  This is my confusion, I think:
>
> oprofile-$(CONFIG_PERFMON) += perfmon.o
>
> so perfmon events are exposed through oprofile, but you can disable
> perfmon without disabling oprofile.
>
> > Because I'd be inclined to just remove CONFIG_PERFMON support, and see
> > if anybody even notices..
> >
> > I'm not expecting a lot of people to do a lot of oprofile on ia64
> > anyway. It's a bit late to start optimizing things now.
> >
> > Do people use perfmon still? Maybe. Maybe not. Perhaps we could just
> > mark it as broken in the Kconfig file for now, and see if somebody
> > says something?
>
Thanks Al for the careful analysis. If I understand correctly, the
problem seems to be that on
execve the mapping of the sampling buffer is not destroyed and then on
close, the kernel
unmaps whatever the new binary had in that address range. The fix
would be to ensure
the mmap is destroyed on execve.

My problem is that I do not have IA64 hw anymore, so whatever the fix,
I will not be able
to test this. In the meantime, I agree with Matthew, simply disable
PERFMON support.

thanks.


> That gets my vote.
>
> Tony?  Fenghua?
>
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 792437d526c6..ff861420b8f5 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -455,6 +455,7 @@ config IA64_MCA_RECOVERY
>
>  config PERFMON
>         bool "Performance monitor support"
> +       depends on BROKEN
>         help
>           Selects whether support for the IA-64 performance monitor hardware
>           is included in the kernel.  This makes some kernel data-structures a
>
