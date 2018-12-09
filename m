Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B8C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D995820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544392895;
	bh=+csGDQjAt3wUL5lVWLBnoXCkSIeDhZV22yrAsv9MpsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xZnt8oZwSC8iazKhmEZO/geWe2f5vxaIS36gJrsrGWiqyGZjwi+QVN+0PDgC1PL2K
	 enzBpvZcaJ5d7pS/vHVS8iBaASNuNxqNfOxjV7jYJ/8iEUpVD2mQq4cbP1NBNygdJU
	 r2MzHYoh02jrB+Uj35BIgrsm9seDs5RSBd5dLWlA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D995820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeLIWBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:01:33 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35236 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeLIWBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:01:32 -0500
Received: by mail-wr1-f48.google.com with SMTP id 96so8617828wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 14:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GKkpqZfazBkhIXU6Z7Vj6BGBovitjRIAk7qm7gs95LA=;
        b=HpAbp23RYmKnvSpxRDRsL23nWgSlyu1LB54dcMzKHM+x8LEja8/MT3IHYVM4m+3veG
         1tfnk34jjHV92mQyjsMICpjNhqiycLwff+yFbYbwvm/cYGR2cRfteYdbWEl9Vy4h1RuT
         aG1WSO2SC29sWmPMlnHAOrXjqd1p3dqRMwj/YhT8nZW7XoaMBGfWNNdE5hEpdh68UaS/
         Q+dyIobtJS3VbJ74vIzcWr7Q4lkenux1aokYBxzgzHEjefTRoi4vq+2qGc9bbG5utf8t
         AC8VIln5kBdOyzpMs4yQGIf6YPBuX4EFkHvTtHha/i/w79W3zYitBrUHZ/HddbmBhdjQ
         xc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GKkpqZfazBkhIXU6Z7Vj6BGBovitjRIAk7qm7gs95LA=;
        b=EKHehIHwklAKbf0mxd+UhkWGdfECXRLBjjNWw98l83C9cCTSxgK5+Yvy4sRUAPdE9s
         owsRoaz8z5WyhuGqTllaD2vs9EtzU738q40HJnbr7wHAPTyvxpBt9sokNV/dJVzLRhS+
         Jls43Azs/YlMwrKsNczmKPPWMcLRWlf0xq1sCp4lgm9GXtARHm9ajjYaok+tVqt7RHbN
         FHSNuYgIuyJak515W9oWQmteRxW/LTO//dpMLoEsir2OxKufHVwHXXlrCsfEvpM0/RGk
         2UCLwUmClUuP5G865Wzh/1WVyOM0cWaB3jSmUBEd7WYffZOhWwLZFxaubNUd3kCfWvgg
         b40w==
X-Gm-Message-State: AA+aEWYOdNRaP28Rydzc+IguBuyKSaL1qLC5wR7P5bOCUkPePuPP06Ol
        Rz4PK9cCmdcGsvqkRCL/h8Q=
X-Google-Smtp-Source: AFSGD/U1L/+ijcY+EuVeL/YP5jZ5iVBaZmM2amiVTf3qx9n6RZe3kdea8MLi8BJP6Y66jiT3MuRI0Q==
X-Received: by 2002:adf:f2c6:: with SMTP id d6mr7457400wrp.37.1544392890484;
        Sun, 09 Dec 2018 14:01:30 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d2sm6648897wrs.97.2018.12.09.14.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 14:01:29 -0800 (PST)
Date:   Sun, 9 Dec 2018 23:01:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: Strange hang with gcc 8 of kprobe multiple_kprobes test
Message-ID: <20181209220127.GA84159@gmail.com>
References: <20181203211807.17e03384@vmware.local.home>
 <20181204164007.956a3458c9fd301b3d173eba@kernel.org>
 <20181204170229.4442d43ce956d48619c1d232@kernel.org>
 <20181204081506.GA73770@gmail.com>
 <20181204143830.6c7f8910@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204143830.6c7f8910@vmware.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 4 Dec 2018 09:15:06 +0100
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > I remember I have fixed this, and actually WE did it :-D
> > > 
> > > https://lkml.org/lkml/2018/8/23/1203
> > > 
> > > Ah, we hit a same bug...
> > > 
> > > Ingo, could you pick the patch? Should I resend it?  
> > 
> > Indeed: I just picked it up into tip:perf/urgent.
> > 
> > It's my bad: I missed the original submission due to Steve's feedback 
> > which I mistook as a request for another iteration, while he only 
> > commented on the reason for the original breakage and gave his 
> > Reviewed-by ...
> > 
> 
> Sorry for the confusion. The patch and code was quite complex, and I
> was documenting what I thought of the patch (and the bug), so that my
> Reviewed-by had a bit more meaning.

It was totally welcome when I read it the second time - and it's my bad I 
was reading too quickly first time around ;-)

So please keep doing it whenever you find the time! :)

Thanks,

	Ingo
