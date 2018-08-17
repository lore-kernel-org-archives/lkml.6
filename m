Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC979C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816B7218A8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeEbXfoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816B7218A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeHQNxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:53:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39590 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:53:50 -0400
Received: by mail-pl0-f68.google.com with SMTP id w14-v6so3558782plp.6;
        Fri, 17 Aug 2018 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J//Jpe0y3hpgNZCpN3ucqwjDoFhX/wEcH2FfMKhSzzM=;
        b=PeEbXfohUIoKqRM13a749T9sS9DkMjiqu0xEWQv8Y2T+GNAkN1kEhjOA1dW3UvVjxM
         qtJp4xp51qt/3UWtNSVPMhzWnJ8+163JTR/ea7UHfGkwS4haBvZaT0bgXQ8Mx8xF83+p
         O+MUYkfDyT7k9UChLBs5A/xeENVl8/LYjhpbtjzTwMMg3ryfQCfiyjsgFcA0y8om2MSq
         aqLalIuN9fdQLe2VGiEhafonJIB+X/1DIOMu2RwmrOesD4nOGK90HhmzCuwWRxn1jya+
         lferXUvwkCH+QNh3SgrFxvtEZjA8Pq3CY5nb1krgFa1cnC0MQXRVCBKN2P4hQ4J8pZb8
         ewFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J//Jpe0y3hpgNZCpN3ucqwjDoFhX/wEcH2FfMKhSzzM=;
        b=L9oCBtbnvPrak3kv+qFPs6qd5OP+nXkro9wfL6+u/opk5BLe10xjhN6AHcFmL+oZOX
         VzGfm2KO8BOrka6jDfwTRv1lYcHJViVF4NAmhvKxXkQrJ7X9LY1k8pQwE0XLh8rJeaKm
         OBevBSmrqdGFJToSgXBxg8116hKMZXnL0S3jko1MByUWlkv5dBo3t1R/CDJtC1uCl25g
         9LSKa96zA5iW1+PIuHWMtdE3FbQAGULfVfQbahJ133Rzyc7q9z9IRWWBVsD0YOks3AcF
         +olNuBsb12fK25LXh3aFbZLiYu8AoJxk8DRJf1+6sIQMZc8F4VOny2eDgCbsXfQ9mCQD
         PMbw==
X-Gm-Message-State: AOUpUlGAW67X2LIeS5ZnGPXhKL6Gzc1O3zw3TP3UKZFV+et5fscXoqH3
        OhQsMPgtB4xI829GZvshvzE=
X-Google-Smtp-Source: AA+uWPwPtBc/FQ6nDXi937f6xkpTA6kN3ArmJiJXAIJnJCCDp4NqK4yDcrD3Ie8O8abM1RtLCMigyA==
X-Received: by 2002:a17:902:280b:: with SMTP id e11-v6mr32776192plb.298.1534503051202;
        Fri, 17 Aug 2018 03:50:51 -0700 (PDT)
Received: from localhost ([39.7.55.28])
        by smtp.gmail.com with ESMTPSA id x65-v6sm2754604pfk.140.2018.08.17.03.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 03:50:49 -0700 (PDT)
Date:   Fri, 17 Aug 2018 19:50:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>,
        Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] console: Add console=auto option
Message-ID: <20180817105046.GB10337@jagdpanzerIV>
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
 <20180816173902.18971-1-prarit@redhat.com>
 <20180817093828.GA10337@jagdpanzerIV>
 <a530a430-70ce-c1e1-ccba-bf5df107c5ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a530a430-70ce-c1e1-ccba-bf5df107c5ad@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Cc-ing Peter Zijlstra

  lkml.kernel.org/r/728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com
  lkml.kernel.org/r/20180817081947.m425gok2ugt7tglp@pathway.suse.cz
  lkml.kernel.org/r/00c60dca-60bc-8568-eaa3-d4b0c326cab4@redhat.com

On (08/17/18 06:36), Prarit Bhargava wrote:
> On 08/17/2018 05:38 AM, Sergey Senozhatsky wrote:
> > On (08/16/18 13:39), Prarit Bhargava wrote:
> >>
> >> +		auto	[X86] Enable ACPI SPCR console
> > 			^^^^
> > 			And arm64?
> 
> Hi Sergey, on arm64 if an SPCR is present the early console and console are
> initialized by default.  IOW no kernel parameter is necessary to initialize the
> console in that case.

OK, thanks.

> > Any chance we can rename param to "spcr" or something more clear?
> > To explicitly state what exactly it's going to do. `auto' sounds
> > too general and doesn't tell me that much. I'm probably the only
> > here who can't see a connection between "auto" and "SPCR", but
> > still.
> 
> I came up with "auto" because I think it is generic.  I also thought about
> "console=fw", or just "console".  If in the future another arch wants to
> optionally bring up a firmware or hardware defined console then they could use
> auto too.

Hmm, I see your point.
My [sort of a] problem with "auto" is that it tells me as much as "magic"
[and "magic" tells me almost nothing]. By the way, would be fun if we had
"magic" instead of "auto" all over the kernel

	echo "magic" > /sys/bus/usb/...../power/control

> > 	void arch_console_setup(void)
> > 	{
> > 		if (acpi_parse_spcr(false, true))
> > 			pr_err(.........);
> > 	}
> > 
> > There can be other consoles in the system, logging an error is not
> > such a useless thing.
> 
> I can make the second change.  The problem (IIRC) with returning an error in an
> setup fn is that the rest of the setup functions will not execute.  I don't want
> to fail the setup callbacks because of an incorrect SPCR table.

OK, fair enough.
Letting users know that SPCR is incorrect also makes sense, so option #2
I guess is what we want after all.

> Like I mentioned to Petr, I'd like to know if you (or anyone else) has strong
> feelings about changing the behaviour of earlycon on x86?  I could make it so
> that specifying just earlycon would also initialize the console.

x86 people and/or scheduler people might have strong opinions on this.
I Cc-ed Peter Zijlstra; he represents both groups and is known to be
a hardcore earlycon user.

	-ss
