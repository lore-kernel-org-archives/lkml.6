Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49591C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2672075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+X/VC/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2672075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeIGXUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:20:09 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:43424 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIGXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:20:09 -0400
Received: by mail-wr1-f44.google.com with SMTP id k5-v6so15859256wre.10;
        Fri, 07 Sep 2018 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BkpBSasDkrQTqaT1qBfM4oSi38roQbkwEtGh90ZC06g=;
        b=A+X/VC/Jq3nl0QfndOmc7J54aeY0jU5Ub3Ze+sDJfdYTgb4sJXwPgKBdlwmpKZyLMA
         Fq59/lIhk/2fjapYBL1kYdvDcwKUolT9pbznINKk3HNyadjRgNYhVw9qcEKrSi6/smDc
         vxCWQZ/nfWeqWnqtbc0HKyF012tTkmAWYnG/tIPfeL/MePvPBjkUErkjq0jzer464jEt
         qDjNS4oEVY8ov8ceONlkVhq/Pu/q34rGOeNlbWUwc2196k9o4x5tWMrF+FCXbQJlOHCV
         uD3Y/S0kw9MQ4GZCK23z3BwOq6nlEWvHl44rk+paiknWEtsmvG94UfJX+NhDSqQZHh5L
         lSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BkpBSasDkrQTqaT1qBfM4oSi38roQbkwEtGh90ZC06g=;
        b=rvQZN8l+PblTx2ASd7iZvDZ27ZV080cv3UM+/4X4ypCa2sT0UfPUvhWsCXAw5WVa9k
         pHvNxf6fzcqoC9s8BhZ1Dq7cQ/qjxhDQGkDXrCbw8KrlPsjUX1ucZ9uTNx0V5H+FpLGh
         Aj454TAet/NHx/l4PqCfsuMR+56A8xLp53f9peAXqIbDRacmNZaVeW6zlC8I9xDfoaA2
         7XX9G9i2AZbnIAqC7yYfZUQLFXuwvROuQe0AyyB2boLZaU7P41N5pDZhCtMWXqB06HFD
         9oTveNDypBCOETwMYEk1RaLTk0tE0okRfq/IEPHM7yefYSKsycV6DKd0ZMzTwsZUK61q
         XYbg==
X-Gm-Message-State: APzg51AisKbyfG5Nul8g2jbYq0oBgN+SUJIeZfYy8QNB0UlIG/TPQ9Go
        2nYKZMTwHdbv5Svtk+p8zQ8=
X-Google-Smtp-Source: ANB0Vdb41Qlk1/S+A4Xp084kWsYA4GRJLzQJwV6wJbep4H9+y/VwAA492dTq9t5Srv0u9g4cSv+Zkg==
X-Received: by 2002:adf:c38e:: with SMTP id p14-v6mr7490863wrf.68.1536345475827;
        Fri, 07 Sep 2018 11:37:55 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:c856:97f7:a8a9:88f6])
        by smtp.gmail.com with ESMTPSA id h206-v6sm9904832wmf.25.2018.09.07.11.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:37:55 -0700 (PDT)
Date:   Fri, 7 Sep 2018 20:37:53 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     christophe.leroy@c-s.fr, joe@perches.com,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Message-ID: <20180907183751.zozqbmpq3dm4j3tw@ltop.local>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:19:43AM -0700, Nick Desaulniers wrote:
> On Fri, Sep 7, 2018 at 11:13 AM Luc Van Oostenryck wrote:
> >
> > Sparse expand these macros to the same version than the compiler used
> > to compile GCC. I find a bit strange though to have sparse v0.5.2 but
> > using an old compiler.
> 
> So Christophe must have a version of gcc < 4.6 installed somewhere?

It looks so.

> Does sparse use `cc`?

By default sparse use gcc (this can be overriden by using CC=...).

-- Luc
