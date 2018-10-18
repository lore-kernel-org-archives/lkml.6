Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903EEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE1C2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWpRxeP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE1C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeJRXsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:48:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43867 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeJRXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:48:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so14488316plb.10;
        Thu, 18 Oct 2018 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PjOqgVaJv/ojAIKUyDQMVhFrWFdFG0K0V1bDLkbd25Y=;
        b=nWpRxeP74V25o2HXVbG1MxA/ZNQDldfzLIwIPnbKGjtmvacbUHZkRwRRxbdhXWlny0
         1EUDGeD9hi1gtOhaFPW9rKrY3SINX9ax+ANQxhHYrl3gzubbNcOwOPgH4YsttJo3DWPf
         NjqycDVbs/HjHnqDeLtjXeV3OuLtYsEQtmCIl1rDP/ui8Ur2G1gPyKEafr7phb/CEVpG
         UzooJD3EX2Ixq2xkla3V1rBCoUTFwTHZvBQNBOxUdQjRdBJ+wt7CzExRVD7wXNbPVjEh
         YUCNj+CqG2/U+Nocnaa52yLD8E5pif1OcnIxn6eBrqnURV+F4hsR7MxOk8YPwJbEWC/s
         meCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PjOqgVaJv/ojAIKUyDQMVhFrWFdFG0K0V1bDLkbd25Y=;
        b=sJK8OnkpBV/brkkTPW0dFKpQu5AY/2Xtp38GYWV7z6R6LM/2vE9kAd/dxKc2ehCCwI
         8irwhD45yr3x+3OVghDKS5jOIBvDL8QswOcw3gJEaxRCGd+APpsSPKceMc/1caH9XRiO
         5wdfTmhaxaEVQYBOPhzVUgpL9V5y0To1aP5qjxlcn9cpzIwJbkslMvJyYbbhhHPHVCpa
         0R6TISnaAPd6uFA7RU1wbL4NW/E1S90kEFs1GMUAwOYl1vzPQppoj3HgOh/DkqeMawk6
         edcpRXsw+z8AKea8n2DMe8rPKB3YtSZg33d86I4w90S1tml1DgOMeBaQPeyru9pWNVPv
         QGoQ==
X-Gm-Message-State: ABuFfojUwev8hV6omI/lvfuYsKiVPekKh7StcdXGfKlB2oSVXGYo2ePB
        qEmdD8lF3wORMe1gPDt61Tg=
X-Google-Smtp-Source: ACcGV61nKbG82Aq5d57hsSbFwqvkkDuGtooVET/yfgAG5JI5lEN0ZghHoq5qKjZwLMTxeOBzElqcww==
X-Received: by 2002:a17:902:8502:: with SMTP id bj2-v6mr30188803plb.295.1539877623807;
        Thu, 18 Oct 2018 08:47:03 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:733a])
        by smtp.gmail.com with ESMTPSA id y24-v6sm39551131pfi.24.2018.10.18.08.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 08:47:02 -0700 (PDT)
Date:   Thu, 18 Oct 2018 08:46:59 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org
Subject: Re: [PATCH v4] Wait for running BPF programs when updating map-in-map
Message-ID: <20181018154657.ehgj3ozy62zy47hi@ast-mbp.dhcp.thefacebook.com>
References: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
 <20181012105427.243779-1-dancol@google.com>
 <20181013023138.m445q6itdmyxdtoc@ast-mbp.dhcp.thefacebook.com>
 <CAEXW_YQFs9mcw5Qv04ZRv=ZAK7YeBLJKByQxXYLj34iigS-Q=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQFs9mcw5Qv04ZRv=ZAK7YeBLJKByQxXYLj34iigS-Q=Q@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:39:57AM -0700, Joel Fernandes wrote:
> On Fri, Oct 12, 2018 at 7:31 PM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Fri, Oct 12, 2018 at 03:54:27AM -0700, Daniel Colascione wrote:
> >> The map-in-map frequently serves as a mechanism for atomic
> >> snapshotting of state that a BPF program might record.  The current
> >> implementation is dangerous to use in this way, however, since
> >> userspace has no way of knowing when all programs that might have
> >> retrieved the "old" value of the map may have completed.
> >>
> >> This change ensures that map update operations on map-in-map map types
> >> always wait for all references to the old map to drop before returning
> >> to userspace.
> >>
> >> Signed-off-by: Daniel Colascione <dancol@google.com>
> >> ---
> >>  kernel/bpf/syscall.c | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 8339d81cba1d..d7c16ae1e85a 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -741,6 +741,18 @@ static int map_lookup_elem(union bpf_attr *attr)
> >>       return err;
> >>  }
> >>
> >> +static void maybe_wait_bpf_programs(struct bpf_map *map)
> >> +{
> >> +     /* Wait for any running BPF programs to complete so that
> >> +      * userspace, when we return to it, knows that all programs
> >> +      * that could be running use the new map value.
> >> +      */
> >> +     if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
> >> +         map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS) {
> >> +             synchronize_rcu();
> >> +     }
> >
> > extra {} were not necessary. I removed them while applying to bpf-next.
> > Please run checkpatch.pl next time.
> > Thanks
> 
> Thanks Alexei for taking it. Me and Lorenzo were discussing that not
> having this causes incorrect behavior for apps using map-in-map for
> this. So I CC'd stable as well.

It is too late in the release cycle.
We can submit it to stable releases after the merge window.

