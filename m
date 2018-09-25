Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69775C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C22120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKNiNCp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C22120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeIZB4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:56:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39511 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:56:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so20384400edi.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7huE5ausKCXcu8YeX6+N1tezaPQioW3+0J45DsMSm5E=;
        b=YKNiNCp1SqGGl9W4DS8fSssn1dV+xLMkvFEeXv87+InoLHUfnwkxlPsSqZXD3xXaKe
         txe6vpCxRemNgvdm7XylH804k4foUEkwWOzxCWBoz0PNuLMHeNLM5YtD5HjGQIRYfedq
         aTxkbF2vH2mYmLe0nv1sRjKiTn4eqi0/rJB0ptmMVWoEaAutqYHSeA1RackMIKa54B7t
         mwtX3xI4DePnHZ1uhlWAI4biKFYJtUt6arkkmL4+yZiKsJTfwSt/fQz5kqq5zSvD73pe
         Jf5nM0mZ00GWH8hyjzC0i+T+RrIiF2jrtAPr7sTf1iPhmscHHDvQ5X5lYj9gOVyrXaRj
         57wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7huE5ausKCXcu8YeX6+N1tezaPQioW3+0J45DsMSm5E=;
        b=OkE773HDeeKza3V1ybRJzcyoXgFgT4ETd66qwpYxKddoTNvZPyWN5qLTRxBpQ3M4cE
         MGiW4h2Ehm5jSyhDlAOmh2zN+4LGU9FdTzWdHCK4q2l1nVlZD5UB04KKDA+tGsaMJwmY
         E1yjP1a/9BAdGBfVr9kyyNoqhDCj5oTLo5cbo0pFcTNAxc/1XoEuTqJiL9NZ7X/HZ3lP
         9McIInFqklRGv/0VOp7cVK/EaycNkFo5BVIGHjMhuI0sqSIkhldVrFK3wYWKeFksJXz7
         67g/Rr4gVvrMDWfqsHoq9JsML9/N38etooLTuljrR/vOBTpHKtaqmBcjlUU1grS2U8Kd
         A6tA==
X-Gm-Message-State: ABuFfoiWtev7sLE173o2rrQr/VVnPNUn/A+cJofneAEJI196KkKnnaOG
        oVoOHVQlNMeBKkr9c/AUd+M=
X-Google-Smtp-Source: ACcGV60/Z3msTs5L5hT7QFHRUX+sdlGLHpqITk+LwtkgjcCVjZ8AxLSWOdx9EuIfnUQC4ajhEyF46Q==
X-Received: by 2002:a50:9034:: with SMTP id b49-v6mr4146184eda.174.1537904843191;
        Tue, 25 Sep 2018 12:47:23 -0700 (PDT)
Received: from GANOO-Loonix.attlocal.net (1c-3e-84-ee-f8-f9.wlan.lsu.edu. [167.96.47.50])
        by smtp.gmail.com with ESMTPSA id a52-v6sm6969275eda.2.2018.09.25.12.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:47:22 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:47:08 -0500
From:   Pierce Griffiths <pierceagriffiths@gmail.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] torture-test modules: Remove unnecessary "ret" variables
Message-ID: <20180925194706.GA27944@GANOO-Loonix.attlocal.net>
References: <20180922012132.23373-1-pierceagriffiths@gmail.com>
 <20180922212630.GF4222@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922212630.GF4222@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,
The #ifdef cannot be replaced, as this would break the build for
CONFIG_HOTPLUG_CPU=n builds. There are assignments and references to two
global variables, a struct, and a function that are declared/defined in
a large "#ifdef CONFIG_HOTPLUG_CPU" block which ends directly above
torture_onoff_init(). IS_ENABLED() would cause these references to be
present at compile time, but not their declarations or definitions,
which would certainly cause a compilation error.

On Sat, Sep 22, 2018 at 02:26:30PM -0700, Paul E. McKenney wrote:
> On Fri, Sep 21, 2018 at 08:21:31PM -0500, Pierce Griffiths wrote:
> > Remove return variables (declared as "ret") in cases where,
> > depending on whether a condition evaluates as true, the result of a
> > function call can be immediately returned instead of storing the result in
> > the return variable. When the condition evaluates as false, the constant
> > initially stored in the return variable at declaration is returned instead.
> > 
> > Signed-off-by: Pierce Griffiths <pierceagriffiths@gmail.com>
> 
> Not bad, as it does safe a couple of lines.  Is it possible to save
> a few more by using "if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))" instead
> of the #ifdef?  Or does that end up breaking the build for either
> CONFIG_HOTPLUG_CPU=y or CONFIG_HOTPLUG_CPU=n builds?
> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/torture.c | 22 ++++++++--------------
> >  1 file changed, 8 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/torture.c b/kernel/torture.c
> > index 1ac24a826589..f4cec6db7f3c 100644
> > --- a/kernel/torture.c
> > +++ b/kernel/torture.c
> > @@ -233,16 +233,15 @@ torture_onoff(void *arg)
> >   */
> >  int torture_onoff_init(long ooholdoff, long oointerval)
> >  {
> > -	int ret = 0;
> > -
> >  #ifdef CONFIG_HOTPLUG_CPU
> >  	onoff_holdoff = ooholdoff;
> >  	onoff_interval = oointerval;
> >  	if (onoff_interval <= 0)
> >  		return 0;
> > -	ret = torture_create_kthread(torture_onoff, NULL, onoff_task);
> > -#endif /* #ifdef CONFIG_HOTPLUG_CPU */
> > -	return ret;
> > +	return torture_create_kthread(torture_onoff, NULL, onoff_task);
> > +#else /* #ifdef CONFIG_HOTPLUG_CPU */
> > +	return 0;
> > +#endif /* #else #ifdef CONFIG_HOTPLUG_CPU */
> >  }
> >  EXPORT_SYMBOL_GPL(torture_onoff_init);
> > 
> > @@ -513,15 +512,13 @@ static int torture_shutdown(void *arg)
> >   */
> >  int torture_shutdown_init(int ssecs, void (*cleanup)(void))
> >  {
> > -	int ret = 0;
> > -
> >  	torture_shutdown_hook = cleanup;
> >  	if (ssecs > 0) {
> >  		shutdown_time = ktime_add(ktime_get(), ktime_set(ssecs, 0));
> > -		ret = torture_create_kthread(torture_shutdown, NULL,
> > +		return torture_create_kthread(torture_shutdown, NULL,
> >  					     shutdown_task);
> >  	}
> > -	return ret;
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(torture_shutdown_init);
> > 
> > @@ -619,13 +616,10 @@ static int torture_stutter(void *arg)
> >  /*
> >   * Initialize and kick off the torture_stutter kthread.
> >   */
> > -int torture_stutter_init(int s)
> > +int torture_stutter_init(const int s)
> >  {
> > -	int ret;
> > -
> >  	stutter = s;
> > -	ret = torture_create_kthread(torture_stutter, NULL, stutter_task);
> > -	return ret;
> > +	return torture_create_kthread(torture_stutter, NULL, stutter_task);
> >  }
> >  EXPORT_SYMBOL_GPL(torture_stutter_init);
> > 
> > -- 
> > 2.19.0
> > 
> 
