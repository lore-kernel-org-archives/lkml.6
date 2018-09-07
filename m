Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F7C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676F220861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfnyUlFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676F220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeIGNPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:15:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33433 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIGNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:15:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so6690932pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ky5On3ReD2fuZx9WaBUFqA6SF4E7UU9Nl8NEhnQKo6M=;
        b=hfnyUlFcYqctSJW8St/opYFiPi+w9rDZn4sXzLYINb5uwKXOg7ZRNdtCWFiU+qS59V
         1ynK3VC95jJhUemOqCACSVf80oCcjgCVyaCNUSeGpMvSG6u5JTCLYSEfp2d+BusARFpL
         a+BE8p9vU4BmIHrsEz189oORGHcpCCsC+wFL5OiPyWDUa+udAX6egtfrLWnZSMuxGc6n
         p5XxJDKdR4+VdL6T7W/hnzFfCh2uiT3PZGS6HQzzgQza3kmKz01Nync4CsZGeNxPoYaY
         k/sWPIJdCyQ18gbcBpA400P56vx+TEs/3Kn0Og1eB0csQHSZA3zN8hf1a3VzRMUzHMsa
         8QPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ky5On3ReD2fuZx9WaBUFqA6SF4E7UU9Nl8NEhnQKo6M=;
        b=t+/a7nQw3osiXth7ikqpxsfsrIx2zSnzb3DbJs2Oo20Kiqo63XodOGOUqn40rDhAX2
         Fci1S3/HgrlPyYlKn1eGB5ptrh6VnFQKpndie256EvseYpvbznKYIT12aU75bSsnduPa
         fBxGaz8SV3iH2w0GTsjH0j30xzg+YJND163UeMJlQ9KfAps39AQ6eHKhRGK6/0Biwa/x
         LVoERUCIHjzCpEW5euqueGjHezvM7VArf88yeY3/qT2X5xyM1HID9Ouw/9PyM4maGOTF
         7RJCD01kEG352JAkscoG0M4hTtAqptDo49eKwZgEEIMWkrNCC9gcexymBM2VJkXKmaIx
         um5w==
X-Gm-Message-State: APzg51AINdJcae/hOajinh0hebTPvZRskMZRtIctqKnDiahrvQdR9BN5
        GGSCjhd0+NhszxNFFugZ8LA=
X-Google-Smtp-Source: ANB0Vda494QKeT6O9Fpt+H7/AUgpDaET0R+gG93QvUHPEvYme8alFw5PV8urE5/8M7Q+SIOe1HNJPg==
X-Received: by 2002:a62:3c7:: with SMTP id 190-v6mr7211141pfd.145.1536309343555;
        Fri, 07 Sep 2018 01:35:43 -0700 (PDT)
Received: from localhost ([39.7.51.34])
        by smtp.gmail.com with ESMTPSA id j27-v6sm14626139pfj.91.2018.09.07.01.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 01:35:42 -0700 (PDT)
Date:   Fri, 7 Sep 2018 17:35:38 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907083538.GA2279@jagdpanzerIV>
References: <20180905213334.03375777@vmware.local.home>
 <20180906023151.GA749@jagdpanzerIV>
 <20180907074531.GM24106@hirez.programming.kicks-ass.net>
 <20180907082834.vjycyvt6nddpb4la@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907082834.vjycyvt6nddpb4la@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/07/18 10:28), Petr Mladek wrote:
> On Fri 2018-09-07 09:45:31, Peter Zijlstra wrote:
> > On Thu, Sep 06, 2018 at 11:31:51AM +0900, Sergey Senozhatsky wrote:
> > > An alternative option, thus, could be re-instating back the rule that
> > > lockdep_off/on should be the first and the last thing we do in
> > > nmi_enter/nmi_exit. E.g.
> > > 
> > > nmi_enter()
> > > 	lockdep_off();
> > > 	printk_nmi_enter();
> > > 
> > > nmi_exit()
> > > 	printk_nmi_exit();
> > > 	lockdep_on();
> > 
> > Yes that. Also, those should probably be inline functions.
> > 
> > ---
> > Subject: locking/lockdep: Fix NMI handling
> > 
> > Someone put code in the NMI handler before lockdep_off(). Since lockdep
> > is not NMI safe, this wrecks stuff.
> 
> My view is that nmi_enter() has to switch several features into
> NMI-safe mode. The code must not trigger the other features when
> they are still in the unsafe mode.
> 
> It is a chicken&egg problem. And it is hard to completely prevent
> regressions caused by future changes.
> 
> I though that printk_nmi_enter() should never need any lockdep-related
> code. On the other hand, people might want to printk debug messages
> when lockdep_off() is called. This is why I put it in the current order.
> 
> That said, I am not against this change. Especially the inlining
> is a good move. Note that lockdep_off()/lockdep_on() must not
> be traced as well.

Should't printk_nmi_enter()/printk_nmi_exit() still be notrace?
Like you and Steven said - it's still before ftrace_nmi_enter()
and should be notrace regardless.

	-ss
