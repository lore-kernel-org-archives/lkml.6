Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C431221927
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545534832;
	bh=CCaHCf7avPEunjE0Dn5DQ/W1BraU/H137Y/X2Vr0pCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eJw2HoNZqhc6qA1baubuM5EcfVQIVPl3RL9JjDPyjVATm3TG6G0zI/viCXxBRJ+PB
	 XXkaJzA3BwsqAC2MxTomk3dN2OJ9LdxGYfvA0BICPuOo/njayLPcOsSihFor2ubr+3
	 4WRIoE/hX3dizLeTCENVqDsC9+42RHyoBDL3+Yg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404403AbeLWDNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:13:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44234 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733137AbeLWDNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:13:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so4243655pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 19:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wMSsrKia3m+yS7t2jRxpzKStBYQ+cWiNVYpOSLtJA2Y=;
        b=V9SR3yWt9AbLLBYQ9g6CkEbmzCRWhABGtF/XUmMMyzn90UR/HIVN4zVkEHLwU6yGQH
         k1jiysPIoPHm6JKJwU0BcfA3N8kE7aZ+smFOsR6ZdMqPDnr9WFLXINtshoSOwvWjMvGJ
         9TbhD+fW6L0/Npm2ST3kBcmayl4Azm8GgRVe+UViDt0lpxnq+Tj7hGAJUuieZuZr+zmh
         jD9ahgkwXvYDgni8QehW5e1CfhOLUtGxQGdEEms9lTQhh3UjKHLCpvTmZOMxmpmqlYgI
         3bEgAjAe0fGaV7uc1IJIy1Y9rnd71Kcs5qetEi4fr2g5TLrgZ0akDzXYclS9/U9RiINS
         ua+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wMSsrKia3m+yS7t2jRxpzKStBYQ+cWiNVYpOSLtJA2Y=;
        b=uRwhH4o1Grgl1zyWm3OWKE5SpGwfHifwDeYjcdMj9JCbfPvMEBL0+HnVPqQVIqOgY0
         ky4fciMdOptOST2GIHPYR7JSz3L2tWvc6NE5BqfTjJlIhSkmuGG37ZlHEOFdu2MYLGBz
         SBdPvA82y86xVmx1z/PqeT/LS5lPwOn/Z0xXaPdr2BG3qHlh5awjBTpKzyklXIGpooLC
         MoqIpoULJzL1hp0jGXoJclV0eI1LnFV0k/4pU08aKITr8hiXYrNVr9+hCiVc1HmAe0VO
         1Bwq3SvaLmXfp0L7bcppJRIFhVUF7vEqL4/Xlu8G1CFkOe+CA2Y4LhR58nzarBrZR76B
         xSmw==
X-Gm-Message-State: AJcUukczp3dqYp8RMVWJ2zu+VdaLz/FdKrgSYMMBDE2yaqjxbN1i0spy
        5O1ae9jqchuoJM73yECegrKByKs4
X-Google-Smtp-Source: ALg8bN7FcAbhzfaVde5tLry6u0Tb4UU6Pe7gSlTwBH7u+F89MLN4FG8LNk8G4B0c4UIFIy3I/OOpJA==
X-Received: by 2002:a63:db02:: with SMTP id e2mr8060306pgg.419.1545534830432;
        Sat, 22 Dec 2018 19:13:50 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id p7sm54173977pfj.72.2018.12.22.19.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 19:13:49 -0800 (PST)
Date:   Sun, 23 Dec 2018 12:13:43 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, kernel-team@lge.com
Subject: Re: [PATCH v4] string.h: Add str_has_prefix() helper function
Message-ID: <20181223031343.GB11421@danjae.aot.lge.com>
References: <20181221231924.4583e90b@vmware.local.home>
 <20181222093346.GB7610@danjae.aot.lge.com>
 <20181222072404.27a7e9a3@vmware.local.home>
 <20181222142411.GA10058@danjae.aot.lge.com>
 <20181222101244.7da017c9@vmware.local.home>
 <20181222111630.24a4444a@vmware.local.home>
 <20181222164605.GA10792@danjae.aot.lge.com>
 <20181222121911.68603488@vmware.local.home>
 <20181222122335.7fee7e5e@vmware.local.home>
 <20181222122454.63bba1ac@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181222122454.63bba1ac@vmware.local.home>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 12:24:54PM -0500, Steven Rostedt wrote:
> On Sat, 22 Dec 2018 12:23:35 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 22 Dec 2018 12:19:11 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > Because memcmp() isn't required to test byte by byte. In fact, most
> > > implementations don't which is why memcmp is faster than strcncmp.  
> > 
> > In fact, if memcmp() was safe to use if we only knew the size of one of
> > the parameters, then there would be no reason for strncmp to exist.
> >
> 
> Also, I believe there are some memcmp implementations that start at the
> end of the memory locations, not the beginning. That is, it compares
> backwards. Which is also legit for memcmp to do.

I'm not sure, the man page says:

    RETURN VALUE
       The memcmp() function returns an integer less than, equal to,
       or greater than zero if the first n bytes of s1 is found,
       respectively, to be less than, to match, or be greater than
       the first n bytes of s2.

       For a nonzero return value, the sign is determined by the sign
       of the difference between the first pair of bytes (interpreted
       as unsigned char) that differ in s1 and s2.

       If n is zero, the return value is zero.


It should return difference in the first pair of bytes that differ so
I guess implementations should compare from the beginning.

Thanks,
Namhyung
