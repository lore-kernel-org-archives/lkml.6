Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vSJhAHWVGVv4aQAAmS7hNA
	; Thu, 07 Jun 2018 20:28:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D97B06074D; Thu,  7 Jun 2018 20:28:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="K+RmU80A"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 463D960452;
	Thu,  7 Jun 2018 20:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 463D960452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeFGU2e (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:28:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34762 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753103AbeFGU2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:28:32 -0400
Received: by mail-pf0-f195.google.com with SMTP id a63-v6so5470339pfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=92TvZsl494ypeys0WXaV5Ta4QMESlp1LXmzzwDQAXIE=;
        b=K+RmU80AU4LXSIoCjIvyKcu7x25t+n0qbxkZPLVn5sPqNQz/J66x3GlKIBi51v+e+9
         Cz20QYXZmLXkPGJrlQnyeWOmoU0Dy28F9GrM+RPyfGJXlPdYMR5fZUxUu84LLBQC4W7a
         m1r5LLiH0ukeRBCBI2XE8R2wZDoiGfYkK7Qt/eRpHRS1yRVVdQMpnm/geIZY+or4A+XI
         NUF6bFfc9OEh9sRMeglHHKbeUTJRcTifIZsf3+HyDjfd1hwU0YN4gkx+S2OQZGZVTVUY
         sVM0BaQ1VAQ/m2LUxb4jckYuFfVwsECKnykyEwmfO1+pfxCq0dsEgQOjwdJmF2Y1i79w
         MHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=92TvZsl494ypeys0WXaV5Ta4QMESlp1LXmzzwDQAXIE=;
        b=rduZ0JPmV+zUJzT9vSOSVbwo2iySHKHUtwoTIpNSH+EZRhpX6KajMx2TZhAvTLuZ/+
         GhBADEDCkzIJMiOoRPFoCycpoMiHBN7NOVYwtBsgEwCkQWUihMnNba+1ch7yiqJuZJHk
         /fQPpahEGBunNwitnzTdT+rKWKXNHhXOD5HYcjL/mfU0qjB5xP7SWGu62uuX80fo5zQY
         fnFgAhYHwXOZBoWpr5xddTtqoF1KdXd1aqD/GHQGh0h9amyuYhYOAZl2jYuK+RY3RzeM
         4Pa0U9aCWlEnZocStu0V6QLxVMvR0w1sIPoMlC8CwZfvf36sMSgq05nf9JX/uFiH9ofR
         kcSg==
X-Gm-Message-State: APt69E3emkuA30Vh0zJX5VMK6CMLnTWTHpclPuSRiK1z62F/ts5ZEyvX
        hQp2JALq03+qmXsNJDRHKu7w9i5kdLA=
X-Google-Smtp-Source: ADUXVKLRf4FBBjdx7+bpJpPC/XMSduC4QCi9DX7i7BosMTLcXtiRiZE23fCknZ7L2lyjejEIvhqlVA==
X-Received: by 2002:a65:53cc:: with SMTP id z12-v6mr2764381pgr.350.1528403311720;
        Thu, 07 Jun 2018 13:28:31 -0700 (PDT)
Received: from cisco ([128.107.241.177])
        by smtp.gmail.com with ESMTPSA id r26-v6sm72405546pfj.180.2018.06.07.13.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 13:28:30 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:28:31 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Kees Cook <keescook@chromium.org>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] dh key: fix rounding up KDF output length
Message-ID: <20180607202831.GG9999@cisco>
References: <0000000000009c221d056e0cf53a@google.com>
 <20180607191201.97080-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607191201.97080-1-ebiggers3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:12:01PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Commit 383203eff718 ("dh key: get rid of stack allocated array") changed
> kdf_ctr() to assume that the length of key material to derive is a
> multiple of the digest size.  The length was supposed to be rounded up
> accordingly.  However, the round_up() macro was used which only gives
> the correct result on power-of-2 arguments, whereas not all hash
> algorithms have power-of-2 digest sizes.  In some cases this resulted in
> a write past the end of the 'outbuf' buffer.
> 
> Fix it by switching to roundup(), which works for non-power-of-2 inputs.
> 
> Reported-by: syzbot+486f97f892efeb2075a3@syzkaller.appspotmail.com
> Reported-by: syzbot+29d17b7898b41ee120a5@syzkaller.appspotmail.com
> Reported-by: syzbot+8a608baf8751184ec727@syzkaller.appspotmail.com
> Reported-by: syzbot+d04e58bd384f1fe0b112@syzkaller.appspotmail.com
> Fixes: 383203eff718 ("dh key: get rid of stack allocated array")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Arg, thanks.

Acked-by: Tycho Andersen <tycho@tycho.ws>
