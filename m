Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725C8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C8120656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4u0Y1OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfANMAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:00:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40538 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfANMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:00:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so8537251wmf.5;
        Mon, 14 Jan 2019 04:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w2vDY+L3uZ6tt6TZ/crakwjF3s1G74mw+bDe+AhnmwI=;
        b=q4u0Y1OXuo8/E2bmLR2oOs4nE3iR4tjIVkP7suz20S+KB3TuwRLZsKm0+U3B8mENdz
         gk3fnsU/R6Sa3jMPKYATZdbRBbLiwCmuo1dX8YuvNck6w8mAD5AE7cnprWtj2TQCzKfz
         gHucbJKYEuJ54TAHQb6r8Qu3HNGguef6reU8iU0mdGy70jg2iy1xb/O17GsbiGqNnllB
         3Lf2bHeAbGDVYyd/g+osO6O1RroyaDPKpvjVRvfPzFmlH3gGARLIz4pDnU5KcDni7fOV
         Geuc8AdoFD6EJOK932TF17R99L3O1Hn1Bsoeeea4NSlTKNGTruFKVaBdgxRjQpLvo2jD
         naHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w2vDY+L3uZ6tt6TZ/crakwjF3s1G74mw+bDe+AhnmwI=;
        b=Ryreg3P6freViInatOLdzQF/AjFxpNUDgwzwBxE0ELpvbGxOgKNyayL+5cSh696mQk
         PEArn/Q99TTtTNPe1QRuQp5UzLeQQIDlGyzbOxi+hIyDEJeW+Jv5HQ1eE0QTVu+akNig
         QYhxYGwnPWpyyHTwXT0X6IWlKucyXfVpVdEfjhkKqYo+ddCbDStLmSldrT9aPG+Ec8b3
         zN8LhL3Iwv2FbsHENo3+Nf6J30+HWPrEl3pKTvaMEme+oT11LWUqTKtqx9nIVs+5mp9W
         gZT2AAc0QavxduQA8NUH2eSQf7iKaVwywvHK4uGqqjGe85zr3ygink91uftc8cqML8v1
         Um9A==
X-Gm-Message-State: AJcUukfir+0XsJ6JP66BcMDYcOXBKzl+yl+ik0Ft2+uZOJAE0WLc8Hiz
        qKfFBHgBjSvGkQoDV3IVHiw=
X-Google-Smtp-Source: ALg8bN7O7pA4do9avzTVPB6aDGQHbJ4xkd9u7nT4c81X+w7lYzWiDaNv2cL4xE/BCCNUvVMJgjmQ2w==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr11255359wmd.112.1547467224950;
        Mon, 14 Jan 2019 04:00:24 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t12sm76599551wrr.65.2019.01.14.04.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 04:00:24 -0800 (PST)
Date:   Mon, 14 Jan 2019 13:00:23 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Michael Sabolish <sabolish@me.com>,
        Kevin Weidemann <kwe-lnx@postn.eu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
Message-ID: <20190114120023.wkftfz6pwatehpfe@pali>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190114103011.GD13316@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Monday 14 January 2019 11:30:11 Jan Kara wrote:
> > As for the case of remounting as rw if the UDF is ro but the device is
> > rw, I am not sure what the best idea is to deal with this.  If this new
> > behavior doesn't count as a regression, is there any way to end up with a
> > UDF filesystem as specced by the command above (-m dvd -b 512, so with it
> > being read-only), but still allow for mounting it as rw if the device
> > supports it? Does udftools offer a way to manipulate the UDF partition
> > descriptor flag in a pre-existing filesystem after it had already been
> > created that I am missing?
> 
> So I would really prefer to keep the behavior of disallowing remounting
> read-only partition read write. After all ECMA-167 standard is pretty clear
> on this saying that for read-only partitions no sectors can be recorded. I
> understand it is inconvenient if you try to create e.g. a DVD image. So you
> want partition to be read-only in the end but initially you need it to be
> writeable so that you can fill-in the contents.
> 
> Generally I think a clean solution for this is to provide a way in udftools
> to switch partition read-only / read-write. Also this is how similar things
> are achieved for other filesystems. Pali, is there a way to switch
> accessType of a partition on existing media with udftools? If not, can you
> look into implementing that please? It should be rather straightforward,
> the biggest question really is which tool should do this...

You are not the first who asked for such functionality in udftools.
Michael (CCed) already experimented with such thing and "hacked"
udflabel to switch access type from overwritable to readonly.

I'm not against adding a new tool into udftools project which can
manipulate UDF access type. Question is design / API of such tool.

Currently udftools has udfinfo tool which prints lot of information
about UDF filesystem (including access type). But the only tool which
modifies UDF filesystem in udftools is udflabel. And udflabel is not
really the proper place for changing access type.

So some new tool for modifying UDF filesystem would be better. Which
other settings of UDF filesystem could be useful to be modifiable? I'm
thinking about "udftune" where new features for modification could be
implemented later too.

-- 
Pali Rohár
pali.rohar@gmail.com
