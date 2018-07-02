Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EAEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249E824110
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="tb1Wwod7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249E824110
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeGBRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:20:06 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36325 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeGBRUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:20:01 -0400
Received: by mail-qt0-f194.google.com with SMTP id f1-v6so7398989qti.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=yfuRBkiFWmrjXZ7Dyn1o0HEdbdEI+tUop1KvUn0jYss=;
        b=tb1Wwod7N1H3xGGZdnmdncRHQrWZ8gpycG5cQQRkRIUirNM71LGotJDF1ytj3RKHyW
         qp4JRbXo3K/c4omLE71HriQVqfJxIfsawldclB91SsyVwAJmvjsWcGfdDQ6HBx7NJdDB
         +dnsRY2jZ6IbP7Y4Aze3NJp5jp/aQhz4J96wfg2nGYQnX6GMesaMu0rxAYasaK1+/DLv
         maM724V+4K2vdyZfdcat5bV7/Zej25WvBBrTUZajRXFWVKVbxcbjH1yZjsmxjOujf/6M
         F8KcLIYtW3BEKoXSzxdP9GXn1YfUouZpGTZkWf8l/H7QxPQNhJBkMB7fPQtRXeJXZSLP
         5NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=yfuRBkiFWmrjXZ7Dyn1o0HEdbdEI+tUop1KvUn0jYss=;
        b=NpCGYmYTPejm/7pfj1AEIAbf07tvWZRmdIdNYuvNmNOKNbcCsTb4vnm7v56HmZXjYy
         8rYjvdvrykXVo2uvhMlqYxmxonEAvay8wQJyG/ES/ddo0ReZU4gn6yNxl27jtjhbnBKQ
         +Ubso/+ymdToJz8i6ZWJh0ONKCX+NN5R89UvTAO4GwHLzFwHRMM+eRG8xLzRFyVwHW4v
         k0axue5pil1ooY1EUtpg8yy5ErtmIghT9CwO3AWq1MRkEqLH7dq3aEhLhD2vAN3iz8j+
         YLdXRnn6HkyXX32vgTRrQK9uPtzk0VO8uaEcvVOG/IfL3eMq1x6i1kdFqZAuOmB4GOnv
         bYdA==
X-Gm-Message-State: APt69E1dQU07ZYKYzsqMotIhhxqpjJ47qdY+BBpk6iBIG7lxc0+1MojE
        cxLSB5uWUEFo489RM+9cp+4BuA==
X-Google-Smtp-Source: AAOMgpdWoL94+6A0vbSxkaJN4aehvGphkxgv+I17o15trblvQ7bSVeDZQfCgNiQefHvhY4gAwurdCg==
X-Received: by 2002:aed:3d74:: with SMTP id h49-v6mr23093809qtf.113.1530552000476;
        Mon, 02 Jul 2018 10:20:00 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id o31-v6sm11002145qte.16.2018.07.02.10.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 10:20:00 -0700 (PDT)
Date:   Mon, 2 Jul 2018 10:19:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Quentin Monnet" <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180702101956.23bde767@cakuba.netronome.com>
In-Reply-To: <20180701103146.GA1388@w1t1fb>
References: <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
        <20180622163200.20564ec4@cakuba.netronome.com>
        <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
        <20180626164820.GA12981@w1t1fb>
        <20180626133133.618af1d3@cakuba.netronome.com>
        <20180626222709.fsznwqauxojhhx7v@kafai-mbp.dhcp.thefacebook.com>
        <20180626153559.0511f709@cakuba.netronome.com>
        <23968d53-2895-f0bc-a38c-5bc99e1846ab@iogearbox.net>
        <20180627114737.GA1580@w1t1fb>
        <0360a47f-1056-3117-31ec-7c3f5d6dbccb@iogearbox.net>
        <20180701103146.GA1388@w1t1fb>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jul 2018 11:31:47 +0100, Okash Khawaja wrote:
> On Wed, Jun 27, 2018 at 02:56:49PM +0200, Daniel Borkmann wrote:
> > On 06/27/2018 01:47 PM, Okash Khawaja wrote:  
> > > On Wed, Jun 27, 2018 at 12:34:35PM +0200, Daniel Borkmann wrote:  
> > >> On 06/27/2018 12:35 AM, Jakub Kicinski wrote:  
> > >>> On Tue, 26 Jun 2018 15:27:09 -0700, Martin KaFai Lau wrote:  
> > >>>> On Tue, Jun 26, 2018 at 01:31:33PM -0700, Jakub Kicinski wrote:  
> > >> [...]  
> > >>>>> Implementing both outputs in one series will help you structure your
> > >>>>> code to best suit both of the formats up front.    
> > >>>> hex and "formatted" are the only things missing?  As always, things
> > >>>> can be refactored when new use case comes up.  Lets wait for
> > >>>> Okash input.
> > >>>>
> > >>>> Regardless, plaintext is our current use case.  Having the current
> > >>>> patchset in does not stop us or others from contributing other use
> > >>>> cases (json, "bpftool map find"...etc),  and IMO it is actually
> > >>>> the opposite.  Others may help us get there faster than us alone.
> > >>>> We should not stop making forward progress and take this patch
> > >>>> as hostage because "abc" and "xyz" are not done together.  
> > >>>
> > >>> Parity between JSON and plain text output is non negotiable.  
> > >>
> > >> Longish discussion and some confusion in this thread. :-) First of all
> > >> thanks a lot for working on it, very useful!   
> > > Thanks :)
> > >   
> > >> My $0.02 on it is that so far
> > >> great care has been taken in bpftool to indeed have feature parity between
> > >> JSON and plain text, so it would be highly desirable to keep continuing
> > >> this practice if the consensus is that it indeed is feasible and makes
> > >> sense wrt BTF data. There has been mentioned that given BTF data can be
> > >> dynamic depending on what the user loads via bpf(2) so a potential JSON
> > >> output may look different/break each time anyway. This however could all be
> > >> embedded under a container object that has a fixed key like 'formatted'
> > >> where tools like jq(1) can query into it. I think this would be fine since
> > >> the rest of the (non-dynamic) output is still retained as-is and then
> > >> wouldn't confuse or collide with existing users, and anyone programmatically
> > >> parsing deeper into the BTF data under such JSON container object needs
> > >> to have awareness of what specific data it wants to query from it; so
> > >> there's no conflict wrt breaking anything here. Imho, both outputs would
> > >> be very valuable.  
> > > Okay I can add "formatted" object under json output.
> > > 
> > > One thing to note here is that the fixed output will change if the map
> > > itself changes. So someone writing a program that consumes that fixed
> > > output will have to account for his program breaking in future, thus  
> > 
> > Yes, that aspect is fine though, any program/script parsing this would need
> > to be aware of the underlying map type to make sense of it (e.g. per-cpu vs
> > non per-cpu maps to name one). But that info it could query/verify already
> > beforehand via bpftool as well (via normal map info dump for a given id).
> >   
> > > breaking backward compatibility anyway as far as the developer is
> > > concerned :)
> > > 
> > > I will go ahead with work on "formatted" object.  
> > 
> > Cool, thanks,
> > Daniel  
> 
> 
> hi,
> 
> couple of questions:
> 
> 1. just to be sure, formatted section will be on the same level as "key"
> and "value"? so something like following:
> 
> 
> $ bpftool map dump -p id 8
> [{
>         "key": ["0x00","0x00","0x00","0x00"
>         ],
>         "value": [...
>         ],
>         "formatted": {
>                 "key": 0,
>                 "value": {
>                         "int_field":  3,
>                         "pointerfield": 2152930552,
>                         ...
>                 }
>         }
> }]

Looks good, yes!

> 2. i noticed that the ouput in v1 has all the keys and values on the
> same level. in v2, i'll change them so that each key-value pair is a
> separate object. let me know what you think.

For non-JSON output?  No preference, whatever looks better :)  Empty
line between key/value pairs to visually separate them could also
work.  But up to you.

> finally, i noticed there is a map lookup command which also prints map
> entries. do want that to also be btf-printed in this patchset?

It would be nice to share the printing code for the two, yes.
