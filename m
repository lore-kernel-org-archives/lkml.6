Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PxEeNW2HGVulRwAAmS7hNA
	; Thu, 07 Jun 2018 19:28:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 60943608C1; Thu,  7 Jun 2018 19:28:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I47ecloT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FSL_HELO_FAKE,MAILING_LIST_MULTI
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DDB676074D;
	Thu,  7 Jun 2018 19:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDB676074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbeFGT2x (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:28:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37964 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeFGT2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:28:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so5221267pgf.5;
        Thu, 07 Jun 2018 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jq4YMJMe/V5XMR5mZN+fjPZ8cGuphVOER0JybDH/Jp4=;
        b=I47ecloTcQpAv+ZaDQY9WKgZ111NYN9vrS+dw+QNVTX2XTiQ2UbDo+RFG9GN6ZU24v
         MtCKy2M82x2xekjTll1EySIEjNLpwDUy9mtr5G+ifAENQlf8rs3gzE2+Tdlt2x169W/g
         n5wFnCi+eIm2QRbQ1OV0mS3pV/Bh1m0RHD9R4+DHSrq1Aeiu6A0F1WnJ4yKaQ3fx+BF0
         lC1MZ0ma5HNE4Dcyic717qLWXWyyi84zVj6n/Ln0VIrQ8jG7k7CUNVwSRQUVCbrU0o1H
         FQHkSv/jDg5BviObQq38RnApftU7l8LnzrNm5GjqeEnwqWUTIEcVOwIXMnenZ2jeKwpZ
         0lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jq4YMJMe/V5XMR5mZN+fjPZ8cGuphVOER0JybDH/Jp4=;
        b=hnLTtn93DWwVzSo+Smy9FEVFq4sXt11YQYN1DdMruq0HgxXvm2fVBVZHjtapAMBzLU
         twE+kY1lWAs70ngYfAYHepiJE1oRJV1nqS59VrN9+bdKEb/3Jdku2Lor418+SXyWsh5D
         FcBczMIFRNDPE39sBLn1m9xe21ncaQty2nXuKzhGm4SgJuLCOFYK4QvM8wRUyaGwOzd0
         /Z/ehmr2HV6m/gftMjaRXEKVa2GoWe7qaC0XdyTOoe64U437sbBsFC+SJeFl1p+QWNgg
         aCoQCPMSwzJPxSnhJQX6FInq4NDiegweqhghdxXq5FgN/SC/2DDtb2OvhPNo2pfry2dV
         9s8w==
X-Gm-Message-State: APt69E0GXqmSxlyaUP4H8VHBZy5ry8KSj3d6ou9862FZ3pz1g/53eJBw
        vjr+WKpSqeqY5XljoFOJNQg=
X-Google-Smtp-Source: ADUXVKL3fvFbNR83t9VbdSTuk74CzPqqeMvS+WX6TXB3uaBBCe7UQ+2ZS78hEVxVUDByXrgQGJY0nA==
X-Received: by 2002:a62:3889:: with SMTP id f131-v6mr2932595pfa.173.1528399730196;
        Thu, 07 Jun 2018 12:28:50 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id u1-v6sm18840364pgc.80.2018.06.07.12.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 12:28:49 -0700 (PDT)
Date: Thu, 7 Jun 2018 12:28:48 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Tycho Andersen <tycho@tycho.ws>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] dh key: fix rounding up KDF output length
Message-ID: <20180607192848.GD29665@gmail.com>
References: <0000000000009c221d056e0cf53a@google.com>
 <20180607191201.97080-1-ebiggers3@gmail.com>
 <CAGXu5jJf-cW8WkwMoPZT8zM2aUoO6P-EQs7MK6_uUTneZr0ehA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJf-cW8WkwMoPZT8zM2aUoO6P-EQs7MK6_uUTneZr0ehA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:16:16PM -0700, Kees Cook wrote:
> On Thu, Jun 7, 2018 at 12:12 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
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
> round_up() vs roundup(). Wow, that's not confusing. :( I wonder if we
> should rename the former to roundup_pow2() or something?

Yes, it's very confusing, and I wish the names were clearer, or that there was
one macro that just did the right thing (but then the power-of-2 optimization
could only be done for constants, where it might not be necessary anyway).
roundup_pow2() would still be confused with roundup_pow_of_two(), unfortunately.

Eric
