Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C313EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B8F218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1PhLnqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBFVSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:18:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32946 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:18:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so9680429qtp.0;
        Wed, 06 Feb 2019 13:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R9eu82QN005lXLW0iM8nnXzJJTl60vNjS2omKD3C5i8=;
        b=q1PhLnqspQINftw4DjQ48g17LEwE4hXjkWgqZEVYAcQN5sC77QAGiHX+n4v4QOVdXe
         KH5d3I6P28LHndxQkeJyl8ofFOq9bGTGzhdPTY2klmGjMq5+ETFYqs/QT84arm6MHTe6
         +RSSl8qILDVnM5+unMUz0SDPt1g+yQUU5p8SnWzSFwIZlnoIBD3+UmhFDtULjKM2pqnJ
         PNuW7YRGZwQRcFsIIgPqGlm68wc5GiH+R7tFfsO0Vi87KUQNJrYsGoA2ofLjixggusKh
         ryKbh6q3sATaoybRVmcQmwrT5piqwjnmaRCuPbP4FlkaBeKxvdgMPluQbPYsA47jIpAe
         RuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R9eu82QN005lXLW0iM8nnXzJJTl60vNjS2omKD3C5i8=;
        b=ZXk+rSRW7NNB/uYSfU2RgEe7LSWOQPmbh744CC/qD9ngY1PmvrNm2t2Ncji3uaBtn/
         NN9g5PQGCZoDS/0ipBK+NTuLDPW8ZCD8drjWYjqv7lyLn+3XW+RD5Pzz7q83zRrg6DK8
         1QSGpGLNEshOt5sEi8ltVEBmFdcCbXDc/D37+JORTOS+237zgip0PVC7vqxuGYx2Y5WD
         O4LuhVFMuECT4zCof/OH8nt2UiPcwgMq4fyIs3vdWUZ8zrOO+z7bdoomdkYIw6mhESaV
         5beDNj7cQPCTJlLQMPoxjJqKPbW6dDIshYE0XdmcQ4qMO4BIhD/yyKNBSa4y8sjS1WrX
         uggA==
X-Gm-Message-State: AHQUAubqcsjq1lb3GL3zP8GCM6CjCiUXEyLmZhcXIt9CuP4mOSNSFpTo
        Op0MBEo1FC07k9pHsqUtqLM=
X-Google-Smtp-Source: AHgI3IY4MWzLH57HTOzZBVGyO0AuIjANTSSqCPyTSCB3JYea7ikFEwxNoQuhzyZWbE4SxbcyJ5QM2Q==
X-Received: by 2002:ac8:39e5:: with SMTP id v92mr9238048qte.142.1549487895979;
        Wed, 06 Feb 2019 13:18:15 -0800 (PST)
Received: from localhost.localdomain ([168.181.50.206])
        by smtp.gmail.com with ESMTPSA id c49sm37727038qtc.94.2019.02.06.13.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 13:18:14 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 5B914180C4F; Wed,  6 Feb 2019 19:18:12 -0200 (-02)
Date:   Wed, 6 Feb 2019 19:18:12 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Julien Gomes <julien@arista.com>, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, vyasevich@gmail.com, lucien.xin@gmail.com
Subject: Re: [PATCH net] sctp: make sctp_setsockopt_events() less strict
 about the option length
Message-ID: <20190206211812.GE13621@localhost.localdomain>
References: <20190206201430.18830-1-julien@arista.com>
 <20190206203754.GC13621@localhost.localdomain>
 <c13067c0-f127-50a0-9ae0-4be7f0399c0d@arista.com>
 <20190206210827.GC16887@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206210827.GC16887@hmswarspite.think-freely.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:08:27PM -0500, Neil Horman wrote:
> On Wed, Feb 06, 2019 at 12:48:38PM -0800, Julien Gomes wrote:
> > 
> > 
> > On 2/6/19 12:37 PM, Marcelo Ricardo Leitner wrote:
> > > On Wed, Feb 06, 2019 at 12:14:30PM -0800, Julien Gomes wrote:
> > >> Make sctp_setsockopt_events() able to accept sctp_event_subscribe
> > >> structures longer than the current definitions.
> > >>
> > >> This should prevent unjustified setsockopt() failures due to struct
> > >> sctp_event_subscribe extensions (as in 4.11 and 4.12) when using
> > >> binaries that should be compatible, but were built with later kernel
> > >> uapi headers.
> > > 
> > > Not sure if we support backwards compatibility like this?
> > > 
> > > My issue with this change is that by doing this, application will have
> > > no clue if the new bits were ignored or not and it may think that an
> > > event is enabled while it is not.
> > > 
> > > A workaround would be to do a getsockopt and check the size that was
> > > returned. But then, it might as well use the right struct here in the
> > > first place.
> > > 
> > > I'm seeing current implementation as an implicitly versioned argument:
> > > it will always accept setsockopt calls with an old struct (v4.11 or
> > > v4.12), but if the user tries to use v3 on a v1-only system, it will
> > > be rejected. Pretty much like using a newer setsockopt on an old
> > > system.
> > 
> > With the current implementation, given sources that say are supposed to
> > run on a 4.9 kernel (no use of any newer field added in 4.11 or 4.12),
> What given sources say that?  I understand it might be expected, but this is an
> common concern with setsockopt method on many protocols, it just so happens that
> sctp extends them more than other protocols.
> 
> > we can't rebuild the exact same sources on a 4.19 kernel and still run
> > them on 4.9 without messing with structures re-definition.
> > 
> Right, put another way, we support backward compatibility with older userspace
> applications, but not newer one.  I.e. if you build an application against the
> 4.9 SCTP API, it should work with the 4.19 UAPI, but not vice versa, which it
> seems is like what you are trying to do here.

Was looking for that. Thanks.

> 
> > I understand your point, but this still looks like a sort of uapi
> > breakage to me.
> > 
> > 
> > I also had another way to work-around this in mind, by copying optlen
> > bytes and checking that any additional field (not included in the
> > "current" kernel structure definition) is not set, returning EINVAL in
> > such case to keep a similar to current behavior.
> > The issue with this is that I didn't find a suitable (ie not totally
> > arbitrary such as "twice the existing structure size") upper limit to
> > optlen.
> > 
> There is no real uppper limit to the size of the structure in this case, and
> IIRC this isn't the only sockopt structure that can be exentded for SCTP in this
> way.
> 
> I really don't see a sane way to allow newer userspaces to be compatible with
> older kernels here.  If we were to do it I would suggest moving the
> responsibility for that feature into lksctp-tools, versioning that library such
> that correlary symbols are versioned to translate the application view of the
> socket options structs to the size and format that the running kernel
> undertands.  Note that I'm not really advocating for that, as it seems like a
> fast moving target, but if we were to do it I think that would be the most sane
> way to handle it.

Speaking of that, recent lksctp-tools got some defines to help knowing
which features the available kernel headers have as it now probes if
specific struct members are available or not. Though yeah, it also
wouldn't help in this case, just mentioning it.

> 
> Neil
> 
> > > 
> > >>
> > >> Signed-off-by: Julien Gomes <julien@arista.com>
> > >> ---
> > >>  net/sctp/socket.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > >> index 9644bdc8e85c..f9717e2789da 100644
> > >> --- a/net/sctp/socket.c
> > >> +++ b/net/sctp/socket.c
> > >> @@ -2311,7 +2311,7 @@ static int sctp_setsockopt_events(struct sock *sk, char __user *optval,
> > >>  	int i;
> > >>  
> > >>  	if (optlen > sizeof(struct sctp_event_subscribe))
> > >> -		return -EINVAL;
> > >> +		optlen = sizeof(struct sctp_event_subscribe);
> > >>  
> > >>  	if (copy_from_user(&subscribe, optval, optlen))
> > >>  		return -EFAULT;
> > >> -- 
> > >> 2.20.1
> > >>
> > 
> > 
