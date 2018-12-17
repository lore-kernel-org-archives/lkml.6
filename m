Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B09AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3637217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLMLRXvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbeLQU7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:59:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33209 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeLQU7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:59:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so15807303qtp.0;
        Mon, 17 Dec 2018 12:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mRJnJ2GDjoLwTe4Zo1720pJn3jeZ2gHfU0pxtv+yd+w=;
        b=bLMLRXvXo6TrwejYKQklElPWAyvOKRnMaIt16W5x2GzkvsI1eskYBTt+RC73vbEk8z
         sfWJVE2zLA064Mf9wiBz+lguxOMzxVCKJyaDNbrZwEBXTw898mreZ0AWSrm9I1EjyRy2
         DFRXKN7QvJYyKzi6NlIcAET14NGtyceanOsC/TBk2M6VuVcIrtEVDf39wgHO6xqFVA1J
         yZqiWZepC/I6CQ5+PcPJ9Q06kIe7o6/FYQLh0ITWtoF/Yz2d9eR/d2opJUlL9Mw3vpkp
         IRJQs8Pv5DDHMJr7TLh8md4zTyYTHOVKXBbHwt+fAuWV/BjV6r7Hs+g9Sst4yMVXgG0C
         MZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRJnJ2GDjoLwTe4Zo1720pJn3jeZ2gHfU0pxtv+yd+w=;
        b=f9m7eG4MJsqMS0q3lnfgHxadKjXPXGD1taRgbygWPtP4I9BFkEecAaKYYVlXbB+Dko
         J62Xdl7D3fdAtnc9mnVwcVy/VUdSNwbxyAL6ZaZOO97RPUINOhhtK75cKJqgLMtoRNeu
         vrlky4bZHRUBdhBovQ4/NDcDnW5w57Y0AmT+shGtr3I4REmP2jzxA78f4xE7YKQ+398v
         EOwiqaBwvyEj3SupR0JztNjMw4VNMUe4eFqIrzI6wAEYuQko0WsdGG/0gvi7qEycZhI4
         s0aW0xDBiA7qpFaNxnLoHjEbp/bF/KCzCmemxUZSoEYHhmljS2mxUM/Nran2bu98Us3k
         0fmw==
X-Gm-Message-State: AA+aEWbYW0pulZu85VQZfFfGEryQzVfXLPPQJi4Fid5egfW6Lsg0fNc3
        8lE5Kb/hPqt/RS+p4LF+MHA=
X-Google-Smtp-Source: AFSGD/V60l/FOmEK8D5KXFFfCoOqofDTPnb4t4b+epqG5zkYj5xYYLjreEFlrnxJN0MeaMKUxgmSiQ==
X-Received: by 2002:ac8:88:: with SMTP id c8mr15257104qtg.218.1545080356532;
        Mon, 17 Dec 2018 12:59:16 -0800 (PST)
Received: from localhost.localdomain ([168.194.160.142])
        by smtp.gmail.com with ESMTPSA id w81sm12925454qkg.43.2018.12.17.12.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 12:59:15 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id C339A180CC4; Mon, 17 Dec 2018 18:59:12 -0200 (-02)
Date:   Mon, 17 Dec 2018 18:59:12 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org
Subject: Re: [PATCH 6/7] sctp: Convert to genradix
Message-ID: <20181217205912.GA9487@localhost.localdomain>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
 <20181217131929.11727-7-kent.overstreet@gmail.com>
 <20181217125001.8e89ac2565417d55ef7a624e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217125001.8e89ac2565417d55ef7a624e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:50:01PM -0800, Andrew Morton wrote:
> On Mon, 17 Dec 2018 08:19:28 -0500 Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
> > @@ -535,9 +470,6 @@ int sctp_send_add_streams(struct sctp_association *asoc,
> >  		goto out;
> >  	}
> >  
> > -	stream->incnt = incnt;
> > -	stream->outcnt = outcnt;
> > -
> >  	asoc->strreset_outstanding = !!out + !!in;
> >  
> 
> I'm seeing a reject here for some reason.  Using todays's linux-next,
> but there are no changes against net/sctp/stream.c in -next.  The
> assignment to stream->incnt has disappeared.  I did this:
> 
> @@ -535,8 +470,6 @@ int sctp_send_add_streams(struct sctp_as
>  		goto out;
>  	}
>  
> -	stream->outcnt = outcnt;
> -
>  	asoc->strreset_outstanding = !!out + !!in;
>  
>  out:

That's because of
e1e46479847e ("sctp: not increase stream's incnt before sending addstrm_in request")
https://www.mail-archive.com/netdev@vger.kernel.org/msg255306.html
and what you did is the right merge fix for this.

> 
> 
> We're at 4.20-rc7 and this series is rather large.  I'll merge them all
> to see what happens, but I don't think it's 4.21-rc1 material?

Would be nice to be conservative here. It's the first time this change
is being proposed for SCTP stack and testing was probably very
limited.
