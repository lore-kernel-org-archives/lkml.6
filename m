Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5F3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F94420855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrPvzkYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F94420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeKJLpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:45:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36973 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeKJLpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:45:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so3171046lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 18:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwMAVwdQKRVwYaaXHdGuFmtSQJSf2VcuItQnYCQ0+Cw=;
        b=mrPvzkYBc6I9siU+nkxZYOpEQYf1N6cH9zXOGokp7KPwVtSLiWoLUBgPCzKyWObWPr
         gCSDzzM47nx2PTOK599zfsvGP56T4gWu/mlNeZt5j+ONWQyFPbzcv+UAHBWvr+8UuB2w
         EvbZ10xeJswdRfu8PamkThAiSvw2ntbDRvoQz16/fIWkkgvkgKNYWO05iWufPI20Acob
         cWe7AzBl4GdrjjKnRkf7tRMLEYWD29WETkhs+0mamX5/vqrvw1N9foY5IsiIHWBAea9N
         q7OLC4Ua0lG06IqYprdKZBfjpAEFaQDhRxKX01FCCyWXz/UMvPiIGXExQcg8PgyPVimn
         scvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwMAVwdQKRVwYaaXHdGuFmtSQJSf2VcuItQnYCQ0+Cw=;
        b=WJAr06XAM8CF3z4/uLqmMgrfYF4ypEx2graBzbwXlFkVwnr3clR1eABL527yrKEBz3
         AL2/c4/LwLj6Y1ax5okSkGb/K+UJ/n/lENBlPCAOUO4imQHRhewmJwixcNdsfmMAoG0v
         t1c+YWRSTLU00u7fHs5V6emI54LVE84VD/dj3WowFB9rwkmAShOK66oXOcBIg30twtEH
         u8v23TLplsICdH9FTFWDQcvB1glZIXaMo6kqOnPCQpQzEjOydXWL183bYT20fzaH9rBg
         MFl67X9ocZJTcCcwk7hSaOiZi8L/TnS+1JEUe1RnTv5sFb3sibUxlfJM+1gcm3ODyJCc
         kbCA==
X-Gm-Message-State: AGRZ1gLJ3DSO1fBzkho4o6SdSyQLnGNTkaSYrBrwxqwJuyRN/l49Xept
        cxa2JegnXSz6wZoS2simITs7bLkQITPVaFqEO83WbQ==
X-Google-Smtp-Source: AJdET5cdN89dZ2hFsfESAy6wnY+Ub4KKv6vTwzAfxv+MJLyF1sYgJJ5L9LcUwYnDoYgLC8IgYlAgLFK3NnPOXWj43N4=
X-Received: by 2002:a2e:4601:: with SMTP id t1-v6mr7480404lja.111.1541815325375;
 Fri, 09 Nov 2018 18:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
 <20181012105427.243779-1-dancol@google.com> <20181013023138.m445q6itdmyxdtoc@ast-mbp.dhcp.thefacebook.com>
 <CAEXW_YQFs9mcw5Qv04ZRv=ZAK7YeBLJKByQxXYLj34iigS-Q=Q@mail.gmail.com>
 <20181018154657.ehgj3ozy62zy47hi@ast-mbp.dhcp.thefacebook.com> <20181018233633.GA89903@joelaf.mtv.corp.google.com>
In-Reply-To: <20181018233633.GA89903@joelaf.mtv.corp.google.com>
From:   Chenbo Feng <fengc@google.com>
Date:   Fri, 9 Nov 2018 18:01:54 -0800
Message-ID: <CAMOXUJ=YFEwzBdkQw8xUrQXd4ZRzX6ob0dOCCRA=uEbjvw9yEQ@mail.gmail.com>
Subject: Re: [PATCH v4] Wait for running BPF programs when updating map-in-map
To:     joel@joelfernandes.org
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        netdev@vger.kernel.org, Lorenzo Colitti <lorenzo@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi netdev,

Could we queue up this patch to stable 4.14 and stable 4.19? I can
provide a backport patch if needed. I checked it is a clean
cherry-pick for 4.19 but have some minor conflict for 4.14.

Thanks
Chenbo Feng
On Thu, Oct 18, 2018 at 4:36 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Oct 18, 2018 at 08:46:59AM -0700, Alexei Starovoitov wrote:
> > On Tue, Oct 16, 2018 at 10:39:57AM -0700, Joel Fernandes wrote:
> > > On Fri, Oct 12, 2018 at 7:31 PM, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Fri, Oct 12, 2018 at 03:54:27AM -0700, Daniel Colascione wrote:
> > > >> The map-in-map frequently serves as a mechanism for atomic
> > > >> snapshotting of state that a BPF program might record.  The current
> > > >> implementation is dangerous to use in this way, however, since
> > > >> userspace has no way of knowing when all programs that might have
> > > >> retrieved the "old" value of the map may have completed.
> > > >>
> > > >> This change ensures that map update operations on map-in-map map types
> > > >> always wait for all references to the old map to drop before returning
> > > >> to userspace.
> > > >>
> > > >> Signed-off-by: Daniel Colascione <dancol@google.com>
> > > >> ---
> > > >>  kernel/bpf/syscall.c | 14 ++++++++++++++
> > > >>  1 file changed, 14 insertions(+)
> > > >>
> > > >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > >> index 8339d81cba1d..d7c16ae1e85a 100644
> > > >> --- a/kernel/bpf/syscall.c
> > > >> +++ b/kernel/bpf/syscall.c
> > > >> @@ -741,6 +741,18 @@ static int map_lookup_elem(union bpf_attr *attr)
> > > >>       return err;
> > > >>  }
> > > >>
> > > >> +static void maybe_wait_bpf_programs(struct bpf_map *map)
> > > >> +{
> > > >> +     /* Wait for any running BPF programs to complete so that
> > > >> +      * userspace, when we return to it, knows that all programs
> > > >> +      * that could be running use the new map value.
> > > >> +      */
> > > >> +     if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
> > > >> +         map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS) {
> > > >> +             synchronize_rcu();
> > > >> +     }
> > > >
> > > > extra {} were not necessary. I removed them while applying to bpf-next.
> > > > Please run checkpatch.pl next time.
> > > > Thanks
> > >
> > > Thanks Alexei for taking it. Me and Lorenzo were discussing that not
> > > having this causes incorrect behavior for apps using map-in-map for
> > > this. So I CC'd stable as well.
> >
> > It is too late in the release cycle.
> > We can submit it to stable releases after the merge window.
> >
>
> Sounds good, thanks.
>
> - Joel
>
