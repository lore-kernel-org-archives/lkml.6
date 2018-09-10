Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDF2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4A22086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwz5x1Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4A22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIJOVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:21:46 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:42958 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:21:46 -0400
Received: by mail-wr1-f42.google.com with SMTP id v17-v6so21094832wrr.9;
        Mon, 10 Sep 2018 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bHXCryUE900U9/Xi4G65zOUHDO75Un7a8t/UKIv1+Bc=;
        b=Rwz5x1Eo9qKC2G0EMfSFCuk4W16SYvpp1Jss6asCLSEwdICDWRMZbdgfK+BewKOnY3
         AZVhNtYgaizmyn4e7C31G9/MW+pS+oBXYbRnMIGUrUQs9bde6GO8gRFg6zRYzp5iagPb
         5tPxkQQ1kb0uF/XKEDyI0Z/rqynHeifT8Dpygq6Jfb7ydb4+0DQrThM/jtbMkfMTBLUl
         YqGOxxS/wqkuvKvBAwf+ud1gicnEwHWLFofqXjesrJWtpclkgF0kNV+QtI3WOm8gXMlB
         HTPT7Q+3tczHdXCXNFER/7F+0U7nbip192ls0B+0XJ4zRrkgIbC1KO74tv+CIIulmhED
         19hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bHXCryUE900U9/Xi4G65zOUHDO75Un7a8t/UKIv1+Bc=;
        b=V0KkSvBowkYq7DBES7k+fVJLwe44VqA4VG/SuQIJSysSmiK3VupUScJiaWvVXTAXHN
         tpIb9usN/gjDZ69q1attJCoW0TSG03E42pZpM4dryNO+8tWlMKS3OWzMedGcLqb0nc+z
         RtxuFi1SH08ZGVAnv5kz8SIaeEDU0kLO8emMuriJpP/H7OST/SVBkB1SX70wIAmVOzT/
         MT6QheUK+1JB8XFgiEmzBJzArP5BYdebpPPjr9kBNOuNltpR3JmqC7/knTuoYJzonUuk
         2lF8RjOte7X75f0DIxqvZHDDf97f9Pxh/Avgw7qYl9xICo23Qr6rdX+3GTeiU3aVy3oX
         ZrYQ==
X-Gm-Message-State: APzg51CFCqIxLZpgDKownPTszZae8t5VNrIIURTmq5AmdZ9/phSZ/8Rt
        wHRG/ZmbM8whkURAnmyII1ODTaDY
X-Google-Smtp-Source: ANB0VdZIUGIUcH+/cXBR0m2XTNgB5Q3xi9j1ZE7tMsUK2f3vfv0h13y3st5tEmQ7PpnhLzcL8PwmJQ==
X-Received: by 2002:adf:dfca:: with SMTP id q10-v6mr13312647wrn.113.1536571718082;
        Mon, 10 Sep 2018 02:28:38 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:58a0:e14d:efc:4c92])
        by smtp.gmail.com with ESMTPSA id t9-v6sm38401540wra.91.2018.09.10.02.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 02:28:37 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:28:36 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Message-ID: <20180910092835.v5nex5nzfgtl475m@ltop.local>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 08:49:07AM +0200, Christophe LEROY wrote:
> Le 07/09/2018 à 20:19, Nick Desaulniers a écrit :
> > On Fri, Sep 7, 2018 at 11:13 AM Luc Van Oostenryck wrote:
> > > 
> > > Sparse expand these macros to the same version than the compiler used
> > > to compile GCC. I find a bit strange though to have sparse v0.5.2 but
> > > using an old compiler.
> > 
> > So Christophe must have a version of gcc < 4.6 installed somewhere?
> > Does sparse use `cc`? If so, Christophe, does your `ls -l $(which cc)`
> > point to an old version of gcc maybe?
> 
> Indeed it looks like sparse expand these macros to the version of
> the compiler it was compiled with.
> 
> I'm building kernels for a powerpc platforms, with CROSS_COMPILE set
> to ppc-linux- and ppc-linux-gcc being version 5.4
> 
> However my build machine is a CentOS6 and the native gcc has version
> 4.4.7, so sparse expands that version.

OK, I see.
 
> Is there a way to get sparse in line with my cross compiler version
> and not with the local native version ?

When cross-compiling, there is also things like the machine word-size
and the endianness to take in account (they also default to the
native compiler used to compile sparse itself) as well as a few
defines (like __PPC64__). To be in line with your cross-compiler
you can use to the wrapper 'cgcc' (installed with sparse) and call
it, for example, like this:
	$ export REAL_CC=ppc-linux-gcc
	$ cgcc -target=ppcc64 -D_CALL_ELF=2 -D__GCC__=5 -D__GCC_MINOR__=4 ...
or, since this is for the kernel:
	$ export REAL_CC=ppc-linux-gcc
	$ make CHECK='cgcc -target=ppcc64 ...


I think this should solve it. Do not hesitate to report any
difficulties you may encounter.

-- Luc
