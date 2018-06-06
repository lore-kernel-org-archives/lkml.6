Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7AT+JzVVGFszcwAAmS7hNA
	; Wed, 06 Jun 2018 21:42:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 44EA5607F7; Wed,  6 Jun 2018 21:42:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="LAl54Jcd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9880A601C3;
	Wed,  6 Jun 2018 21:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9880A601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeFFVmN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:42:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35409 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbeFFVmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:42:09 -0400
Received: by mail-pf0-f196.google.com with SMTP id c22-v6so3361135pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VJ8qk5s+xYKiHwGZWZI+ZIC9IXGEnt0+TzQXBlrrZ/s=;
        b=LAl54JcdFOjO/D1mRSPxEJpDzhAD9uECkT7NgIE+1Vua4tH+ePaj0aQ8mio+mV0RP8
         EMhsjWOStmhJewnCz1kHksHkpKNjh6LF3kYsBQra3c5HDJ0IdW0RT9SaU/p+Bp6LuxRu
         gh9i7KlyKTJE6L80bV/kaU3kXKLQqJpMY7jK53NUNd+nnPmHygmN8hFZyS3RZkKp5xvr
         VgWDdOP6qqrwAOBWse1WLdKgsm1kNHiLMhyy7+fdoZaX2wHYY0fvu0I3rV2gbQse0Pdi
         7OmR2MKM7A3hR/uyTF6RIX/hRuOFeykRd+G5iKjwRaXzJ/5YTRpG7Mb7m1cCH8PaiEPN
         y/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VJ8qk5s+xYKiHwGZWZI+ZIC9IXGEnt0+TzQXBlrrZ/s=;
        b=j8DMC+2dnvwVpgWg9P7a9VRW4bNpJH3GsPm7MNMTkgTdEuUWMhwp/Qi7btyqa/Ax6L
         ZMX6YrZWyBAqbxn5rzfnqbZ8fnOU3pD9rEH9YDXOMAerlPPAebP9R3m4LNP8EUHPwNk8
         q+0Dlu9RVrk0tYboqY7KBhDu6lopFti/zvlKOXAbXdIq4fWNoUsN8z40NLjs53spkThm
         4m3nFKpS+yXylAK89EVdDdm3ttt2SElCgqeBI6lXn0DofxrsuutG9bZv6bR/OF7T4mVR
         35lekVE8iRv9hGkS5GtQ3hGj2PYJ6VbEce0pjYjxpAcVf4rtrsNTrRI8IDGfIUuXFPOA
         +lNw==
X-Gm-Message-State: APt69E30VJDKb0CVgh6HC5yUyYzymsoZX4JU1xnChFoPiLCSOqMu2ixZ
        0HU6T5fuEA4fBCbE1nC2BBkqTlK3
X-Google-Smtp-Source: ADUXVKKvoj9EdlIbK3eAIOqOr5P0MAxx/BzvkkYvM/XzDyeayWTLOA2snlvRvNy2VcTekhVj9kGghw==
X-Received: by 2002:a63:78c6:: with SMTP id t189-v6mr3908826pgc.239.1528321329076;
        Wed, 06 Jun 2018 14:42:09 -0700 (PDT)
Received: from cisco ([128.107.241.182])
        by smtp.gmail.com with ESMTPSA id y2-v6sm1505367pfk.82.2018.06.06.14.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 14:42:07 -0700 (PDT)
Date: Wed, 6 Jun 2018 15:42:07 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180606214207.GB9999@cisco>
References: <20180605000127.5495-1-tycho@tycho.ws>
 <20180605035936.GA19642@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605035936.GA19642@mail.hallyn.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 10:59:36PM -0500, Serge E. Hallyn wrote:
> Quoting Tycho Andersen (tycho@tycho.ws):
> > Unfortunately, I don't have any insightful thoughts about how to test this.
> > Ideas are appreciated :)
> 
> I wonder whether there is something we can do with qemu -serial pipe: ?

Good idea. I couldn't get tty_put_char() to trigger nicely, but I just
hard coded one to occur, so at least now I know that this doesn't
deadlock when called normally.

Another suggestion Serge gave off list was to write a kernel module
that implemented a driver. I'll see about doing that to see if I can
force the original crash.

> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>

Thanks!

Tycho
