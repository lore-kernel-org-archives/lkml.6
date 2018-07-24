Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4493C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B8720856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCVql7Vx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B8720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbeGXXSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:18:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35477 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeGXXSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:18:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so3825022pgv.2;
        Tue, 24 Jul 2018 15:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzitGvfo7yUEzlJBRlOK34PhKWnibYzQyV2HN8+eokE=;
        b=pCVql7VxJOIKYd0P7Qo8VlNVdhWjalTPgs8nNjWKcoU+XgqZg6mZi0ENXZ9eMdXVC6
         nUhcfEkh6Y36NCrmJA0MPceDnzzgvr8ZUISgl0r7tKZlze0xaXq5DTSuwTAGGfOFWhl8
         FcYD+CcgkbpC2YWiWJmzo6St1/ESnBVSXNrZQyH6dSmQers1l63YBjhSx++PNxGabavS
         sQCQz5Ko2TTixpc5fzOvC1lw8dxdDZbLLC4PP/bMI+O+IkDKBLrodtsk+reScy6IlA2W
         Yp/y/UiVzSZo5CS8HHKdMifXmAM09C2Rv/slhTqEGJ/W80hWpFfvMog7ONplCQqm95Wx
         v7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzitGvfo7yUEzlJBRlOK34PhKWnibYzQyV2HN8+eokE=;
        b=Rfo9sWVX5sK3VIfwdl+Uzi/22A9XyICWSbx9hrBRxURnZDOqUjtyX1Y3uTQLhYCAjq
         M7qsk13TAUq0YtzpMa7YxBGwa/6cM3Iuf+wuPjyFRmwHULAe+i1m7WGY+jy8L7/v5pPw
         bJcBr0ZZQe4sPQDCdzVhnEfJb6M1THSCzvM6kGuImKOjzEEV8eHEhpw2gR/6Ujzihjyq
         6wu4Bid73HVa6LHxHdhv+SZ7Z087R3GdpanlVKX3Z4yRvDbo0KNogTjwxNLZE0H6OFju
         k8Gv2safyDiVhk+9bsuiKY0xg6MztCZrao5rEHxf6iV6iMlVYUtrweuElOKjqNcRA1vz
         X1Ag==
X-Gm-Message-State: AOUpUlEAjSlGa7o1/Aa1FWjwF6VHB297XxYggRsgvj6EYPFpV2JGrc7g
        t+BtGxSPr89oo16QCWu0FiS95g6pZw4mw5aQaCY=
X-Google-Smtp-Source: AAOMgpfw6mrdWl1zHOtGyeuCXmRY/aKrZniR52zU5WSzMTJ7g4rs8iqX2r73ao3a0lwGYaKPjyZOi+9sezMhx2XThwU=
X-Received: by 2002:a62:cd3:: with SMTP id 80-v6mr19602583pfm.184.1532470167277;
 Tue, 24 Jul 2018 15:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
 <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
 <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com> <20180718.125938.2271502580775162784.davem@davemloft.net>
 <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com> <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
 <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
In-Reply-To: <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 24 Jul 2018 15:09:25 -0700
Message-ID: <CAM_iQpUc-H2kZCBevePs6g-8qKyJkUhdd1ZDSQgYsCG0ChfC2w@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
To:     David Ahern <dsahern@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 8:14 AM David Ahern <dsahern@gmail.com> wrote:
>
> On 7/19/18 11:12 AM, Cong Wang wrote:
> > On Thu, Jul 19, 2018 at 9:16 AM David Ahern <dsahern@gmail.com> wrote:
> >>
> >> Chatting with Nikolay about this and he brought up a good corollary - ip
> >> fragmentation. It really is a similar problem in that memory is consumed
> >> as a result of packets received from an external entity. The ipfrag
> >> sysctls are per namespace with a limit that non-init_net namespaces can
> >> not set high_thresh > the current value of init_net. Potential memory
> >> consumed by fragments scales with the number of namespaces which is the
> >> primary concern with making neighbor tables per namespace.
> >
> > Nothing new, already discussed:
> > https://marc.info/?l=linux-netdev&m=140391416215988&w=2
> >
> > :)
> >
>
> Neighbor tables, bridge fdbs, vxlan fdbs and ip fragments all consume
> local memory resources due to received packets. bridge and vxlan fdb's
> are fairly straightforward analogs to neighbor entries; they are per
> device with no limits on the number of entries. Fragments have memory
> limits per namespace. So neighbor tables are the only ones with this
> strict limitation and concern on memory consumption.
>
> I get the impression there is no longer a strong resistance against
> moving the tables to per namespace, but deciding what is the right
> approach to handle backwards compatibility. Correct? Changing the
> accounting is inevitably going to be noticeable to some use case(s), but
> with sysctl settings it is a simple runtime update once the user knows
> to make the change.

This question definitely should go to Eric Biederman who was against
my proposal.

Let's add Eric into CC.
