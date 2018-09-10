Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50518C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0318F20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUhP4krK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0318F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbeIJUKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:10:06 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:40385 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeIJUKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:10:05 -0400
Received: by mail-wm0-f53.google.com with SMTP id 207-v6so21757700wme.5;
        Mon, 10 Sep 2018 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=57P2rLV+EaCX+uKsFOIlAE7+5O8NhI9O+hbKZdChz9g=;
        b=VUhP4krKDFexqXx+I3nKz3ftseiC/XEnyu2W9x4J6pe1sDdzbwycjlrPJjr0HgOoh4
         kBYoj2kH0A4R4JG0I79CzBymEv9CH8luifx7tqZ7VopEI1+v7PRQ6AmlHNId1hGWyni8
         MX7kd4mU0CUYfYteaeodYyjXHlAo3X6deDPuigiD8h8T44QYRfOQGpwue0DUt9x5XO+S
         WC2bIweuhcnTXBjH64cFmV6rWkyzH/P1Vg8DDcxCNuE6kv1D0BX6jPoPhR3vIT6PLnXp
         1Z24hUxig0N9hqLyHJ0+8opJqbQGXdhuNTxXyMuX0+2keVp6NqZ/6nRT+Wnc+AuIuQd8
         dncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=57P2rLV+EaCX+uKsFOIlAE7+5O8NhI9O+hbKZdChz9g=;
        b=k9HFrfTp0Ik/0LWAPU7ADN2jLD050HoADBCdDhEca9Z2wgat+mXXqGnAGrxd/QEIx8
         LFK7dTVn8HPcXByGCY+fVU4DkBaqSJIorFiUqzEXnexSkZYvvadFwW57XWnZ8Vpuv3vO
         QAa2GJ8wJs9k5FS0wrI4qPrS9aA2q62Nk8QbwnbrSrb9jAjUEMXGmxZz6MW9S2yDUJr7
         io2tp//j4xG0DWh92EnHEdiwnlyA9MWwbV+kmS4RWeOIXzmRfo5GDdy2+dWc/uz3CEUi
         COJigpiNW7yRtKZTQtNQjXAEUVl71e/XsKxdSDmSOo4AwsJcghMQbqgEW0aySQrgTyDX
         yL8A==
X-Gm-Message-State: APzg51D2CDfaUHgr84LE8idf4SbytDYCmz4HzkTRIuwHNhZhGEsL4gbZ
        b4sZj/xGOiAhNar0mit4lWk=
X-Google-Smtp-Source: ANB0Vdb0PHuy7cKXl2J0C3H9a77Nlk6Ig40DoeTlukrxmBdifq/2kXPiy2FdXtkp9VINdFJc23MtXw==
X-Received: by 2002:a1c:3351:: with SMTP id z78-v6mr1086137wmz.23.1536592530448;
        Mon, 10 Sep 2018 08:15:30 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:81e:af75:e036:d35f])
        by smtp.gmail.com with ESMTPSA id y128-v6sm17252812wmy.26.2018.09.10.08.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:15:29 -0700 (PDT)
Date:   Mon, 10 Sep 2018 17:15:27 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Message-ID: <20180910151526.ljp3nynngprdmlkb@ltop.local>
References: <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
 <20180910092835.v5nex5nzfgtl475m@ltop.local>
 <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
 <20180910113448.dxnfvznyimtj3tkv@ltop.local>
 <9409138a-dc14-2b12-edc0-cfa0b471da6e@c-s.fr>
 <20180910135604.j2phe7r3k5vs6cik@ltop.local>
 <6191f6dc-1819-60e4-d4e8-f815f04325f0@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6191f6dc-1819-60e4-d4e8-f815f04325f0@c-s.fr>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 04:05:34PM +0200, Christophe LEROY wrote:
> 
> This time it works, thanks for your help.

You're welcome.
 
> Should we find a may to automate that in the Makefile when
> CROSS_COMPILE is defined ?

The situation here with an old gcc is really an oddity.
I was instead thinking to update sparse so that it repports a
GCC version of at least 4.6, maybe something even more recent.

But maybe, yes, kbuild could pass GCC_VERSION to sparse so
that both the compiler used and sparse will repport the same.
I'll see. The problem is not tied to cross-compilation, though,
just that sparse may be compiled with an older compiler.

-- Luc
