Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FCEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04222087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BckBCcwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfARNfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:35:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34971 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfARNfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:35:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so8049898qka.2;
        Fri, 18 Jan 2019 05:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lq/IqQ19vCoxyFTJyD7jgLHanmIgXYLNCjQ21ue7X5o=;
        b=BckBCcwYbzZX4bCIQzPCghFxc694z/6pdhAgN6B+I5hJwJujt3h5yoPnntcg780Pro
         fpuk9Dk5FN508uPjlLX+RLcZg+IY7f8QcN/bnChTnUcfl4UznU0Cjs3EFoSdd9zM/YSa
         AEn4X0ZL5CMJn/C5488qjel/dil+4h/636woYWmAy0AP58GOEv/cOiyo+WWj1NIaH+uF
         GRRtQj72KC34iyBKe+5mOhGfHyRdR7GsXchvgCYtZ5nBbyL2F+I24V7NKeJlGMb8H7m8
         Q1Ja3Aehy4kW6Z5d1KCzVYxvuGD3Vis2IVDor0CCSLkqU7GKN5VVrQkuHBT3OCwFS8Ug
         pVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lq/IqQ19vCoxyFTJyD7jgLHanmIgXYLNCjQ21ue7X5o=;
        b=kK2UVkBCtrDYhBPzzcEpPYRRKaBSwIjzWuoZp9ok+wBbKxXYpzQV2jw3JlexaFTRz7
         Z86qKVYrQq3oGIyAeFEyqdxwz4HsM795MhLaHOyFGu6NZkpW8+d6feQQOIo4r+p+J2Sw
         3rjCMI4kNjEY6lptsUULYe2oNQaX+cTk2OJU+dSdXMWO9DU9MeQjxrKa72SiOUk81J+a
         xDo+sGDqkx8HsfVC4IS6zvAYj1eX/BfcjjsBwpIRjHcNm9UUu/4QvM7ylAccdUgPD98R
         ctHtbCdbWtE+5oUosH2kIlCKnHOEWnpjrVg9GqxMDvZsCWbcx4W5B5FZHhIOUsBQY+6N
         iZaA==
X-Gm-Message-State: AJcUukdOCLl4LnlIg0Wammmp1Bkj8t+IJ3MLoQkZgLnhZhlNdtOGPsAs
        xRPPdaQmXXktyoBnvU1Ln/Y=
X-Google-Smtp-Source: ALg8bN57zDHLgJRzng0hZNk+auXGZ2faow/Hqb6TQv9oetSR8Wb7Pey2Lbk92nuIA3CS3VApNnbo8g==
X-Received: by 2002:a37:6f85:: with SMTP id k127mr14708794qkc.240.1547818537913;
        Fri, 18 Jan 2019 05:35:37 -0800 (PST)
Received: from localhost.localdomain ([168.181.49.80])
        by smtp.gmail.com with ESMTPSA id w184sm67984658qkw.90.2019.01.18.05.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 05:35:37 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 73171180B7A; Fri, 18 Jan 2019 11:35:34 -0200 (-02)
Date:   Fri, 18 Jan 2019 11:35:34 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        linux-sctp@vger.kernel.org
Subject: Re: [PATCH 6/7] sctp: Convert to genradix
Message-ID: <20190118133534.GD666@localhost.localdomain>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
 <20181217131929.11727-7-kent.overstreet@gmail.com>
 <20181217125001.8e89ac2565417d55ef7a624e@linux-foundation.org>
 <20181217210021.GA7144@kmo-pixel>
 <20190115142926.GQ23855@localhost.localdomain>
 <20190118131022.GA22165@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118131022.GA22165@hmswarspite.think-freely.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 08:10:22AM -0500, Neil Horman wrote:
> On Tue, Jan 15, 2019 at 12:29:26PM -0200, Marcelo Ricardo Leitner wrote:
> > On Mon, Dec 17, 2018 at 04:00:21PM -0500, Kent Overstreet wrote:
> > > On Mon, Dec 17, 2018 at 12:50:01PM -0800, Andrew Morton wrote:
> > > > On Mon, 17 Dec 2018 08:19:28 -0500 Kent Overstreet <kent.overstreet@gmail.com> wrote:
> > > > 
> > > > > @@ -535,9 +470,6 @@ int sctp_send_add_streams(struct sctp_association *asoc,
> > > > >  		goto out;
> > > > >  	}
> > > > >  
> > > > > -	stream->incnt = incnt;
> > > > > -	stream->outcnt = outcnt;
> > > > > -
> > > > >  	asoc->strreset_outstanding = !!out + !!in;
> > > > >  
> > > > 
> > > > I'm seeing a reject here for some reason.  Using todays's linux-next,
> > > > but there are no changes against net/sctp/stream.c in -next.  The
> > > > assignment to stream->incnt has disappeared.  I did this:
> > > > 
> > > > @@ -535,8 +470,6 @@ int sctp_send_add_streams(struct sctp_as
> > > >  		goto out;
> > > >  	}
> > > >  
> > > > -	stream->outcnt = outcnt;
> > > > -
> > > >  	asoc->strreset_outstanding = !!out + !!in;
> > > >  
> > > >  out:
> > > > 
> > > > 
> > > > We're at 4.20-rc7 and this series is rather large.  I'll merge them all
> > > > to see what happens, but I don't think it's 4.21-rc1 material?
> > > 
> > > Yeah, agreed. Thanks!
> > 
> > Ping? Where did this go?
> > 
> As I recall kent reposted his series convirting flex_arrays to radix trees such
> that it included sctp's uses.

That should be this patchset already.  Or you mean another (re)post,
v2 or so? If yes then I missed it somehow but I still see the
flex_array in v5.0-rc2:

net-next]$ git ls-tree v5.0-rc2 -- lib/flex_array.c
100644 blob 2eed22fa507c7cb0756d7ef643f8a3454eb455ec    lib/flex_array.c

and missing the convertion on sctp stack.

Current patch is the only one I could find with sctp being included:
https://lore.kernel.org/lkml/20181217210021.GA7144@kmo-pixel/T/#re4f8656af37431a376044399681a8771375a4405

> 
> I think xin needs to repost the sctp reallocation patch to make use of those
> radix trees appropriately still (assuming any additional work still needs to be
> done)

This came up on another converstation with him and the lack of this
convertion is blocking him on at least one fix, on one that the fix
using flex_arrays is one and genradix is another.

  Marcelo

> 
> Neil
> 
> >   Marcelo
> > 
