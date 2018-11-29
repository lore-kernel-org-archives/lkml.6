Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F026C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515F9206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9JucVAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515F9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeK2OPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:15:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36883 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2OPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:15:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so253296pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 19:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J+YsAacigZRSuSF1fzrWioRQGakHZlB28wt6JpZmGgE=;
        b=M9JucVALYGmONvtgBTRWy1az0iOLff6IXUQ8MMzH7DPQPaRU73g25IiVO631VnNCid
         GXlUT4DEgheHYLUf/wKnM93YkFaVFimHBl8Dy0Z7WG/AFldypw9JQvLdMKg5ZeYgLa9Q
         B9oKYS5Xj/MN1k9x3MT24IZal4TRq4BEy9LviCic2blOOyYf3q1OuwMXlopLCTdSMrYC
         vzxBPmkpkCHKO2AJc9+aRFmHgvRn+tdMpyDd1NJDvZPsQNLK2V1UzKpfbdhp9Rk3KwFD
         Uuo0OXA9WNcGmfhpMQ5Yz3UwxXc2NW3HkHy5mKWgdWOMx781nU7CV5hSE3xOZpZ/EI30
         f5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J+YsAacigZRSuSF1fzrWioRQGakHZlB28wt6JpZmGgE=;
        b=RxrlhyIKWnPwTxPK6ru+Oi+5mjNpzwEpXDitNSIDtASKsGN8W3MY1bs7AZIZEHskl5
         +m27O0bpywBPfX/n9OEMpnej8UhcYhSuhlFoWr9TBGHr+1oE6kchDbC8BQAVM4//v1Fw
         hQCdH7nGHY2CilNlhqxwychPHMoqTYzgcW7PBcPAXdImV832htl92QZY4iaLkGkcbklf
         EfTP8JEX58xSueNQcd15Q06X04V2qB7vPoeGP2+S3W3NofK1DmU7mf4t/v4Dm0GFkALn
         JlfjOfSEuBzJgs/wRvWtz8asDBO6MldTU9PbsOUwM9OWakthNAlEl/CmglzgmCyQT7mL
         tKlg==
X-Gm-Message-State: AA+aEWYVRpOzJ+QAars13qcNcaHDORlazXpDc/sI4Jye0349wJit/SGb
        hXGYIrtbOu7oYikXUt7KYdQ=
X-Google-Smtp-Source: AFSGD/WXrp5TEyOsSvgWW17pD2+tNoh7wBBquEoaQmi+5RNvgsI+z68lEkiDKJCdd6o7wboadzLOwg==
X-Received: by 2002:a62:c185:: with SMTP id i127mr8802046pfg.43.1543461093601;
        Wed, 28 Nov 2018 19:11:33 -0800 (PST)
Received: from localhost ([175.223.15.27])
        by smtp.gmail.com with ESMTPSA id f13sm468065pfa.132.2018.11.28.19.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 19:11:32 -0800 (PST)
Date:   Thu, 29 Nov 2018 12:11:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 6/7] lib/lzo: implement run-length encoding
Message-ID: <20181129031129.GG6379@jagdpanzerIV>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
 <20181127161913.23863-7-dave.rodgman@arm.com>
 <20181129030840.GF6379@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129030840.GF6379@jagdpanzerIV>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/29/18 12:08), Sergey Senozhatsky wrote:
> On (11/27/18 16:19), Dave Rodgman wrote:
> >
> > This modifies the bitstream in a way which is backwards compatible
> > (i.e., we can decompress old bitstreams, but old versions of lzo
> > cannot decompress new bitstreams).
> >
> 
> Hmmm... Whoa. Help me understand this:
> 
> So a btrfs filesystem, compressed with the new lzo, say I run 4.21,
> won't be readable at all once I reboot under 4.19?
> 
> What about compressed net traffic between servers running different
> kernel version (one with new lzo, the other one with old lzo)?
> XFRM can be compressed with lzo, can't it?

Ah, false alarm. Sorry for the noise!

You create a new lzo version in the next patch.

	-ss
