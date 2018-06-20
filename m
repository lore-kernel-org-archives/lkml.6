Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5526DC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B2520652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH+3K70E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B2520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeFTX1w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:27:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43259 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932224AbeFTX1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:27:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id a14-v6so498270pgw.10;
        Wed, 20 Jun 2018 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bd2bG75vP6ZR2ixDnNDVNbxHyshmyKSprjd1bt0JYDI=;
        b=IH+3K70EsRw55W5LnxDhac5QQXmcYntDF9cfQu+Fw/Ws4HEz1gR8oDya6qQRM+0xcA
         7SlfzWWqwcbkF8oqgY76Gi+ziux9ftgkypxLf9jZ+LCCwhOw+5xR1JNIogOQjdatR255
         C2ZtVSV7Cl7LcUJ+bM/oBsWEF3kzi7ye6rrJngfDhdP+pnpQN7yG55kT4Uf/VQC4Ai+/
         KGxrmMYFt6+S4Pzj1F53wUVHJYUBUjHvN2iUSyOlEJ1+kKNu+6UGXXFVNk5uu0WpgDdr
         dp0P3zRnwaVzO4g1aWQv9I/VLY7FTX/pR+ozBctNdHt4NahDlAddGucmXGWCP6XGjcKM
         dQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bd2bG75vP6ZR2ixDnNDVNbxHyshmyKSprjd1bt0JYDI=;
        b=Y9VgBJfYw0SqX0qSm8Y55IS7/hKThIlScxiRBDqElFEU0eFxWpSja0JgkoWls5K5WW
         4y2sY5nAL8E5L6wPTps3B4S5ibrnDj0ddar7TVCr6NTyVzfnQqt8uCWcrJ44MJuIw+BH
         Cd2tOv/iiidKd5ctCxvXYX4krDtDXOHWX/iABf9zK7rb23hKOmrtxjrSkqjZ/bcjms0f
         TNA8+Mu44jQAkeRAboAcx5rDdfvzW6TGOc0lGmyBHi6pq58j6hEzIsn3NygO/zV/pCgm
         0YADE6OIUw60lpBQblFOxVPPSHnZymDiz/Wv4mCC01iu7X5KWgsFEYMRHga8VOWr5v5V
         K6/Q==
X-Gm-Message-State: APt69E3xLhAJiRvBIYinY4AAIc/qt24v7iKJegWgInLwuxrUgeTPC9Mp
        tfUWjZxeFCsiSmIDgTxp4dI=
X-Google-Smtp-Source: ADUXVKJaj1J+azruREXBqRaDBq/tJgSQtdxQ/CWHxFiRWfY5QkjrKs+YJ40DtQcBTrIupzDZ3cuwGQ==
X-Received: by 2002:a65:5b4c:: with SMTP id y12-v6mr20841848pgr.442.1529537269796;
        Wed, 20 Jun 2018 16:27:49 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id y69-v6sm8744458pfi.108.2018.06.20.16.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 16:27:49 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:27:47 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        Jason Cooper <jason@lakedaemon.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Rost <eric.rost@mybabylon.net>
Subject: Re: [PATCH] crypto: testmgr: add test vectors for skein
Message-ID: <20180620232747.GA111712@gmail.com>
References: <20180620105714.18359-1-j.m.torrespalma@gmail.com>
 <20180620181051.GC76265@gmail.com>
 <20180620221247.GA25379@randy-betty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620221247.GA25379@randy-betty>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Jason Cooper <jason@lakedaemon.net>]
[+Cc Greg Kroah-Hartman <gregkh@linuxfoundation.org>]
[+Cc Eric Rost <eric.rost@mybabylon.net>]

On Thu, Jun 21, 2018 at 07:12:47AM +0900, Juan Manuel Torres Palma wrote:
> On Wed, Jun 20, 2018 at 11:10:51AM -0700, Eric Biggers wrote:
> > Also, can you describe the users of Skein in the kernel?  If there are no users,
> > there's no need to move it out of staging, or even have it in the kernel at all
> > anymore.  I say that as someone who has had to volunteer to fix critical bugs
> > found by fuzzing in crypto algorithms for which it's unclear why they are in the
> > kernel at all, as there are no apparent users.
> 
> To be honest I'm not aware of anyone actually using Skein.
> 
> So by this are you suggesting that we drop support? If not removed, I believe
> it's better to use test vectors as regression tests for further modifications.
> 

Yes, either we remove Skein, *or* we fix all the bugs and other issues such as
the lack of test vectors and continue to maintain the code in the future, e.g.
responding to bug reports from fuzzers and keeping it up to date with API
changes.  But if there are no current or planned users, then removing it is the
obvious choice.  Note that it's been in staging for over 4 years, and AFAICS the
original commits say nothing about any actual users or even why the code would
even be useful.  There's no need to waste time doing work that no one cares
about, and creating more bloat and kernel attack surface.  Skein is a good hash
algorithm, but it wasn't selected as SHA-3, so I'm not sure who would actually
want to use it in the kernel now in preference to SHA-2, SHA-3, etc.

I did recently investigate the Threefish block cipher (which is used internally
by Skein) as a possible alternative for Speck for fast encryption on processors
with AES instructions.  But it wasn't fast enough, among other disadvantages.

Eric
