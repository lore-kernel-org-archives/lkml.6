Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667E0C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7D720874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZfCDJmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7D720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933626AbeFTWMD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:12:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46669 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933411AbeFTWMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:12:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id d2-v6so425728pga.13;
        Wed, 20 Jun 2018 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wkbNaKiH60gpxTd7lTwRppX5rhGRWx1Gje9IZO87/vg=;
        b=eZfCDJmHsizfgOA6UF5RvxGWm198ZXYIvkPKRAE19gjB0uS5UNQGX0OqAbFIH4R0Zf
         Ohx45+WD+x0DJ4W3YZQTZsVutLa4l3H0D3dyWVn/DRKUASQWO5g9A3f02LTMkq0r7n02
         ZsUOXwcr3CNh3nXaJ5RKV0pScRCZ7uPeY375He7aQFHgSveOmcSt1AyjID+aTQW4eS4l
         Sd0OxY9+NeqAFYtsX5YKD7TxY939q82Vo3gbApix4L7sKpI4W4j7KThUfFKMk6TQoCoD
         luURZgodfVjryqD3cmIkCbwRyUu7wzLXOfu+mSA06kuACsmXXCjuehh28o5bY/0pLXjL
         CX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wkbNaKiH60gpxTd7lTwRppX5rhGRWx1Gje9IZO87/vg=;
        b=InMEbqvkQ1gD7gwv2RNO3gqDSCOSGQncp419ZeUoq03bKL2PUaut6BChhff/Csrm9D
         lAI2nubh10k3xIij32Mn1le5cBQj/eXp7wqmOy+T1y0/A9YWCaBr/cROR18WTpkHeFSs
         MAy7eu8dD1gdvQs3qtSV7iZ++8/LfoRTRno6XFJqVECmVauUHoUBf0pfsQTJvx8HoGuU
         kJl+nHvx9nsWw+ErDxpQoJDhwuYEAdq8xvdP9HnYmAlWrGTrs0oY+mai/dypNIl5VCjQ
         d4BWoLJZOJD5paqCLlJ5Rp+jQDzlaEAsYase+8Rx5ES9cPy1BFnyIBMiA9MTIxG5kS8P
         6T5g==
X-Gm-Message-State: APt69E2FfzLKyVRm+YWHXjOPBJ4w2IaGfAD3DFtD4EfDHAR3sQa1AryD
        Aq6PFVa6k4rOMPikfv6fJhE=
X-Google-Smtp-Source: ADUXVKJvOdiT/nIAyr+ZQAi+dtg+PvgEPsylEtd6HNm5sOpqykr75Bz88I1Z3A5FLb2pFTJaV4GW+Q==
X-Received: by 2002:a62:9c9c:: with SMTP id u28-v6mr24831106pfk.90.1529532721533;
        Wed, 20 Jun 2018 15:12:01 -0700 (PDT)
Received: from randy-betty (pdf86861b.kngwnt01.ap.so-net.ne.jp. [223.134.134.27])
        by smtp.gmail.com with ESMTPSA id m5-v6sm4105041pgn.45.2018.06.20.15.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 15:12:00 -0700 (PDT)
Date:   Thu, 21 Jun 2018 07:12:47 +0900
From:   Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au
Subject: Re: [PATCH] crypto: testmgr: add test vectors for skein
Message-ID: <20180620221247.GA25379@randy-betty>
References: <20180620105714.18359-1-j.m.torrespalma@gmail.com>
 <20180620181051.GC76265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620181051.GC76265@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:10:51AM -0700, Eric Biggers wrote:
> Also, can you describe the users of Skein in the kernel?  If there are no users,
> there's no need to move it out of staging, or even have it in the kernel at all
> anymore.  I say that as someone who has had to volunteer to fix critical bugs
> found by fuzzing in crypto algorithms for which it's unclear why they are in the
> kernel at all, as there are no apparent users.

To be honest I'm not aware of anyone actually using Skein.

So by this are you suggesting that we drop support? If not removed, I believe
it's better to use test vectors as regression tests for further modifications.

-- 
Juan Manuel Torres Palma
Computer Engineer
