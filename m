Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94953C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5614520834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN99HlcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5614520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJZRhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:37:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44814 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:37:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id z21-v6so603450edb.11;
        Fri, 26 Oct 2018 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xqwwDdD+iaVKc6Q+WDBr37969mL+58DAgoioZwt5vEI=;
        b=FN99HlcTwmShfmX2drFnkXiVmsgyDkEthIaduU5ywnXyADu1i8t9tNUEldS4I/Sf7C
         HlQnY3bkda2R/A1NPL8U4ir+cyG0tGwV5OcBcGP6ompD7xPm1iSGDDNPeYUxd0DjM77Z
         EVWAw6xwv6I7vC2snehi5lpu3SqzMOoKLMCQN1XkcPPqph9E4IFmg1yxR4/H6XF1/lgv
         nACrdI+aSg5Ccm6eSEKKFQtpujei0DvH4wZqEu6n5pWRCdCoFBdGHdFoCz6H81AX61dH
         O/MDfNNjRCUL9UgU6Z8HpJusNk5WNOmQgZwNtSI1RFokTFlRrtV7VZvaIe/TYT0IQmrJ
         9dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xqwwDdD+iaVKc6Q+WDBr37969mL+58DAgoioZwt5vEI=;
        b=DneK3HA2ANI688WpEimC3KRq6VClMJorf5sf16+PB2EAD/FyRCR/p6mAMw5AkQG5GH
         tkaveMXmeSkAbmYPZiNbElIAnVU+mNNQY6uZdZaegp4S2Qbhbeftq6deYou6o7ufS2kn
         Q9lc1lfoE4SFXDF2x/WJLGm5/ctTWQZsGOMuQDornrxocM0s4MLKIObcj/Znao6EDQqR
         clOme8lDntXNRyJyA0zjNUlShpwnRLl/DixsSN6qTHSa5avvCWCIRXPUChInbvOuzhzE
         X3+hF9+rlPU4nNobcKjQh0MC/hUR0tZ6/NRWjdL9QuzI//dd6Nk7HjtUNWTe8DAGWFRl
         z86Q==
X-Gm-Message-State: AGRZ1gK2SrHxQ7xR4EDSbJ/OnT/hteArCZflKbXbYQI4A83Z3A15VXS8
        FZ5NipB+T1YjaoyRWbmyOMEMBw/j
X-Google-Smtp-Source: AJdET5eQvMbCzrvrwQVaxfgof3Jdf/4pppRKo3zb/KcDxfz/ThdPdD8vj3V9c5uoqNTnx0tXIAziug==
X-Received: by 2002:a17:906:74d7:: with SMTP id z23-v6mr1856458ejl.234.1540544500168;
        Fri, 26 Oct 2018 02:01:40 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:407f:2200:200d:b9a4:6a0c:ace2])
        by smtp.gmail.com with ESMTPSA id l52-v6sm3916047edc.10.2018.10.26.02.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 02:01:39 -0700 (PDT)
Date:   Fri, 26 Oct 2018 11:01:37 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sparse] parse: shifting by full number of bits is
 undefined
Message-ID: <20181026090136.2fidq6kicv4szwjd@ltop.local>
References: <CAHmME9oZk7Afns=W=xM=6waqvVfV+iAdAcB6731xzUUcm4P0zA@mail.gmail.com>
 <20181026031700.12310-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026031700.12310-1-Jason@zx2c4.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 05:17:00AM +0200, Jason A. Donenfeld wrote:
> The type checker wasn't identifying upper bounds for huge unsigned
> 64-bit numbers, because the right shift turned into a no-op:
> 
> zx2c4@thinkpad /tmp $ cat sparse.c
> enum { sparse_does_not_like_this = 0x8000000000000003ULL };
> zx2c4@thinkpad /tmp $ sparse sparse.c
> sparse.c:1:36: warning: cast truncates bits from constant value (8000000000000003 becomes 3)

Hi Jason,

This is already fixed in the development tree:
   git://github.com/lucvoo/sparse.git
together with some other fixes & changes regarding enums.

I hope to be able to push this to the official tree real soon now.


Kind regards,
-- Luc
