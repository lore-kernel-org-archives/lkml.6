Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA7CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D448825EDC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYBie8Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D448825EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934370AbeFYROc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:14:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45602 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933724AbeFYRO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:14:29 -0400
Received: by mail-pl0-f68.google.com with SMTP id o18-v6so6428873pll.12;
        Mon, 25 Jun 2018 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JjuSp3H89JENXPeEO1/EE1PYS+ejPM3/bTrspFvLJdQ=;
        b=BYBie8Pd2i/Jo3eQYte2AaPX/qLQdeTjRJVEORlYjAFD18qX4zmnTxoHzLPiHr5rpC
         /0droukld/wGo8eMEeocVaKJlesgFsNGXSXIBAd2b+GvMQnbgvWJd1l3FIo5Zkmhjiph
         VOzRAS43t2VgZahclqJG4FkBO0+i9bmfmgd5VTMby4rBb7uc+1/Q2DeG4IRfekps0mXm
         T3sCYggicb4l5+PVzXqKRNAZo7t08UKZ6OXV/sIdqAfqJ2part6NBsGWn9rutCfNenSi
         FOpJf8eEwhbxeSgFNc6JH8StpYqD1xIM1kjJfmcBOm7g7js0JD8y7K9NseaZFPs7VzkZ
         pMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JjuSp3H89JENXPeEO1/EE1PYS+ejPM3/bTrspFvLJdQ=;
        b=E+qjCcgb9ELWL8Vl4OsIZSUAbm5fOIM35sOppHYPAuFCel9OzDpum47nLqSYrZ/7uZ
         yGfMeuFQQ0OqgfVXj+Yr8FhyTr8KQf/EtjAOAlcY2lxh2Tknz5hZTrfMt7kWJVf1SCeN
         2mm/RQxNp0xFfxZmMWpxCTCr69FkqujRoh8YHHABJN7lLCrtLyklJmoWMMO0xLY3E48C
         skHQrJ+icHGzXQxTmoycVH4LqxX1trSRBkrBC634z92/HXgN/eBYERUMV0/PTlIicC99
         jJQlXvVKBKK0/EViQJwa54EiS9zfGRVmwrcIF4OBg9kYFvz4BY71DJ+9MO1Ys8DOuMpi
         rfxw==
X-Gm-Message-State: APt69E0M/8HKdACBtRZWJUfzQsXPXQsZ4iRpzQmwxfuktG4FKmtqIlRi
        WZBQx9uvgW/7/etECc1+lqU=
X-Google-Smtp-Source: ADUXVKKBV+mBs37xWxELZaYHvCZpGnvsHNupu/2nXRuGNN/ZVyTHKD+U8QyHhzFHagBo/TQlZmFq+g==
X-Received: by 2002:a17:902:600d:: with SMTP id r13-v6mr6180453plj.70.1529946868731;
        Mon, 25 Jun 2018 10:14:28 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id 10-v6sm32774531pgb.40.2018.06.25.10.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:14:27 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:14:26 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] dh key: fix rounding up KDF output length
Message-ID: <20180625171426.GA180889@gmail.com>
References: <20180607191201.97080-1-ebiggers3@gmail.com>
 <0000000000009c221d056e0cf53a@google.com>
 <17595.1528472278@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17595.1528472278@warthog.procyon.org.uk>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Jun 08, 2018 at 04:37:58PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > Commit 383203eff718 ("dh key: get rid of stack allocated array") changed
> > kdf_ctr() to assume that the length of key material to derive is a
> > multiple of the digest size.  The length was supposed to be rounded up
> > accordingly.  However, the round_up() macro was used which only gives
> > the correct result on power-of-2 arguments, whereas not all hash
> > algorithms have power-of-2 digest sizes.  In some cases this resulted in
> > a write past the end of the 'outbuf' buffer.
> > 
> > Fix it by switching to roundup(), which works for non-power-of-2 inputs.
> 
> Applied.

Applied to where?  When are you planning to send this to Linus?  Note that this
was a regression from v4.17 to v4.18-rc1.

Thanks,

- Eric
