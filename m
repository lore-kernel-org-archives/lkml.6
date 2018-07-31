Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E348FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932B2208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TA5Xdqok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932B2208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeGaC1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:27:54 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:50472 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeGaC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:27:53 -0400
Received: by mail-it0-f50.google.com with SMTP id g191-v6so1985013ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 17:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0CmbeHPYoCcGZWcpL4uM2rf63WD+QD+DjX49fVdIIgc=;
        b=TA5XdqokL5L4hXZMX97GBW+lFWjLg2Vw0VQGvN3WjbT1tff1s7I17xfavM5hbSuFoq
         NAqDJ5IfMENTsZ+PlYkwM97TigWEkj7C3AZgEKsgl6iDpzQPwwXio9rQJjrveuh1mTd4
         a+yUDy9MJBQKulRFot/hlizPJIn7HiOvxZZUg1K/Le45s09xMMXOy2M78w1wGQ5Az0sl
         p86fIl9ngaT2JyRxnnF2jmeIbdNYBjUwDDbKo+Ba+dBE1POlk1pXyLK8FgwJc3tKCE8d
         hy2RBWWb+KLqQKajEkFecHBm5tsorS6Ay+PiAVE+vbO6KDgDxVS0HA4J2gBSfVpVq72B
         uOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0CmbeHPYoCcGZWcpL4uM2rf63WD+QD+DjX49fVdIIgc=;
        b=AoTxIuJ3Ee3zuZO26dY0PoIhHPt+L0zOJ+G0wRcD9OUvjzPTl3XcmtupQw8X7aQGbv
         ks8n+YgU47Fxot0xBTqTvOWqQ3hUy+/bytbnnWiw43npIs1/E20nJzOI+goWnbtVkpBO
         AnhhNahZ7zV1JSCzegHEAh6+WzsQdVROv7d9sSxhspj6roUFYSMDx365KAQGDTiFnTSY
         rTD3Xp/D34k1A5czf1WAPEXdF8R4WX910HYTETLzksOmc99B1XuFdmNxoh9s+o0Ua4tj
         AOWRinbP3euBOGFPDWw/EGIuL9aze0FzLoYDcZuxxWorp8wRCCAmu3bLbktQ344Sb4QJ
         oByg==
X-Gm-Message-State: AOUpUlFF1tB6PLSgPkE2EgxN2D3ljT2R56/07ailcIqjrbTh+bH/9o2K
        YVeqmZw256f+4iC6rBEeqEsBy7/ZhX6OOIieAelbpQ==
X-Google-Smtp-Source: AAOMgpdA15ESPTqdCe3CXUlXllKVlwBNdCaZvj4GTwno4H/2aKJSj/pkmMFV1/Lb8cMZXqQ4dNaJgXMR4Jxv37FaHzU=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr1247645itm.113.1532998216637;
 Mon, 30 Jul 2018 17:50:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 17:50:15
 -0700 (PDT)
In-Reply-To: <20180730174532.20010e0d@cakuba.netronome.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com> <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
 <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
 <20180730172641.7d516231@cakuba.netronome.com> <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
 <20180730174532.20010e0d@cakuba.netronome.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 30 Jul 2018 17:50:15 -0700
Message-ID: <CAKOZuev_fRPjH6PWRnDpWo0OjOo2EF+at_Uw4JXs25mwKoWF1A@mail.gmail.com>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2) command
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 5:45 PM, Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
> On Mon, 30 Jul 2018 17:33:39 -0700, Daniel Colascione wrote:
>> On Mon, Jul 30, 2018 at 5:26 PM, Jakub Kicinski wrote:
>> > On Mon, 30 Jul 2018 03:25:43 -0700, Daniel Colascione wrote:
>> > > On Mon, Jul 30, 2018 at 3:04 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> > > > Hmm, I don't think such UAPI as above is future-proof. In case we would want
>> > > > a similar mechanism in future for other maps, we would need a whole new bpf
>> > > > command or reuse BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES as a workaround though
>> > > > the underlying map may not even be a map-to-map. Additionally, we don't have
>> > > > any map object at hand in the above, so we couldn't make any finer grained
>> > > > decisions either. Something like below would be more suitable and leaves room
>> > > > for extending this further in future.
>> > >
>> > > YAGNI.  Your proposed mechanism doesn't add anything under the current
>> > > implementation.
>> >
>> > FWIW in case of HW offload targeting a particular map may allow users
>> > to avoid a potentially slow sync with all the devices on the system.
>>
>> Sure. But such a thing doesn't exist right now (right?), and we can
>> add that more-efficient-in-that-one-case BPF interface when it lands.
>> I'd rather keep things simple for now.
>
> You mean map-in-map offload doesn't exist today?  True, but it's on the
> roadmap for Netronome.

Sounds cool. I'd still wait until map-in-map offload lands until
adding the map-specific API though.

> Tangentially it would be really useful for us to have a "the map has
> actually been freed" notification/barrier.  We have complaints of users
> creating huge maps and then trying to free and recreate them quickly,
> and the creation part failing with -ENOMEM, because the free from a
> workqueue didn't run, yet :(  It'd probably require a different API to
> solve than what's discussed here, but since we're talking about syncing
> things I thought I'd put it out there...

Yeah. What you're talking about is what I meant upthread when I
briefly mentioned a "refcount draining approach" --- you'd block until
all references except your own to a map disappeared.
