Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E426C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2BB2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9/V9v1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfAOO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:29:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38924 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAOO3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:29:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so3115866qtj.6;
        Tue, 15 Jan 2019 06:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZRrqV1FkdDFJxnk6ECyUpyTMihZUW/SL4D1cow1v2qc=;
        b=R9/V9v1gCKaWtL5XPQ4yHXIrbIWf+jUmfoKoJCIIw/tAp2Tk/bE7A4PiPDaX/xj6th
         UzUDqbpJhTCvRP7LcwPuuMWg2JVZYhUU8uWgc99ytXZ/RAP3eOKYOMl6mtoXySQ8hoCD
         h0pkuBihTCXLiEVbeN/ihCBDd4AWJWaZt8H6lGu6XaSKnHiu+RJLMvbVoeVxOJlSuwK2
         n5i5JTyYZ3uUbQaZw8ktuJ0Td35CGzDX+QQaEB9yAW3pkhoVtbJmwp/OeDlOJnstBcJb
         gnlLI2CvztIbHM0t3VZZOAtmVW/UyuQil3UqroRQw2DvvKvEaDEJ7LpiZ2Vl5saY0+Tj
         5rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZRrqV1FkdDFJxnk6ECyUpyTMihZUW/SL4D1cow1v2qc=;
        b=S9PUZ/PD2u9W5GJvecG94sujyr+LHLyjAgh7TIONjESEN8w7+jNlP2DIXcML/xVcGk
         2AaLbr7IhtNDDJj7N/yNdvSKvjcIoX1x13AqRTf0trSOI5u0baSMUveOpAsjX8B1fqWN
         P1mol5F+9RBHLh05cOPFazSAFG23qLpTMPe9BDJJZCrmPIvVK26cD+S25W3feK8ieyOu
         pOh2Crnszif8944FU/EFuA/4J/2jLxdXRm9V/l1yuvlgsMQK3EHEBIvEMJDBAEmyImiF
         NlNkOn9NEEXwnbJnd8RgFOg4nuyrKq0Pwl2OJVQ+Ehh8PosBG6Usp2qq3R9f5p4CKSR/
         vF7g==
X-Gm-Message-State: AJcUukcZq8J4olIwQP4nJ7S6c3TW6zbOuVgQB8sipx5P+yo10lvuSmcR
        ZUN0W/QXpca0g3GLlK82pjU=
X-Google-Smtp-Source: ALg8bN5azxxNw2PTCGRaIjrKWamGsGva4CNAepy+vdXkfp9GhzIItBSUGD+jJLfHMuOBQ+WuRqHWlA==
X-Received: by 2002:aed:2ae3:: with SMTP id t90mr3049052qtd.19.1547562570612;
        Tue, 15 Jan 2019 06:29:30 -0800 (PST)
Received: from localhost.localdomain ([2001:1284:f013:f0db:6feb:e3d8:3398:3455])
        by smtp.gmail.com with ESMTPSA id a20sm25364885qkj.28.2019.01.15.06.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:29:29 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id E9B9D180BCF; Tue, 15 Jan 2019 12:29:26 -0200 (-02)
Date:   Tue, 15 Jan 2019 12:29:26 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org
Subject: Re: [PATCH 6/7] sctp: Convert to genradix
Message-ID: <20190115142926.GQ23855@localhost.localdomain>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
 <20181217131929.11727-7-kent.overstreet@gmail.com>
 <20181217125001.8e89ac2565417d55ef7a624e@linux-foundation.org>
 <20181217210021.GA7144@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217210021.GA7144@kmo-pixel>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:00:21PM -0500, Kent Overstreet wrote:
> On Mon, Dec 17, 2018 at 12:50:01PM -0800, Andrew Morton wrote:
> > On Mon, 17 Dec 2018 08:19:28 -0500 Kent Overstreet <kent.overstreet@gmail.com> wrote:
> > 
> > > @@ -535,9 +470,6 @@ int sctp_send_add_streams(struct sctp_association *asoc,
> > >  		goto out;
> > >  	}
> > >  
> > > -	stream->incnt = incnt;
> > > -	stream->outcnt = outcnt;
> > > -
> > >  	asoc->strreset_outstanding = !!out + !!in;
> > >  
> > 
> > I'm seeing a reject here for some reason.  Using todays's linux-next,
> > but there are no changes against net/sctp/stream.c in -next.  The
> > assignment to stream->incnt has disappeared.  I did this:
> > 
> > @@ -535,8 +470,6 @@ int sctp_send_add_streams(struct sctp_as
> >  		goto out;
> >  	}
> >  
> > -	stream->outcnt = outcnt;
> > -
> >  	asoc->strreset_outstanding = !!out + !!in;
> >  
> >  out:
> > 
> > 
> > We're at 4.20-rc7 and this series is rather large.  I'll merge them all
> > to see what happens, but I don't think it's 4.21-rc1 material?
> 
> Yeah, agreed. Thanks!

Ping? Where did this go?

  Marcelo
