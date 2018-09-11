Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D129FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234B520854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLWej1bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234B520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeIKKjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:39:10 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:41358 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeIKKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:39:10 -0400
Received: by mail-pg1-f173.google.com with SMTP id s15-v6so11651242pgv.8;
        Mon, 10 Sep 2018 22:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lWNX0+9g0p0SQsBRlm5zPRffGGsTTVk7JxlEp7OQ3JQ=;
        b=nLWej1bgtEVhw12Ik8cEl/ywaSJowNJG9IWI9lQvQLDRs47xLOd48fpl5t5JCZNMK1
         ZPSndQQ9f5uuOXBcszh5AvHHEN6JyDu8suJCIpSF9HeYzMB5+HeJYezLLXNbp4iyZ4QX
         iJ59+WkyP70+AtOvbrTwDw0pqAiH7RpE61cRhYUHf1/3gg150l7hnzi83WCpQpX45DUm
         nYEJ4oj8T+87Ultp7hEA/po4FWnLrhIoCvrd8uwCuJr6UcNrPjxozaxGjUp1MNXWtJVd
         xrCJVzB/QnMkztiOrH2aSPbe+/R5bTn7HVtm4X9EHlhJe59NsRvP/3q8LXhHxBhW/Pme
         AJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lWNX0+9g0p0SQsBRlm5zPRffGGsTTVk7JxlEp7OQ3JQ=;
        b=IBEZpEb7fUQYWJqmNREbZV7dKsJCCLVeAegKwgdyBkZlTU+VE7UQWK3yHose/Szg0Y
         M/lnlb4H7fEQtPhsYzdyPWsl5cseh1OWmwIdufo1SQUBNrFXtNJhXhKt4aH0TULqADNU
         m71j3TInikss8MuL6gsc+VNDEg7jUaev/78BnDUih8IieUCKfg5eU5dlGgrzW/96Czvs
         5SQbXr0VRUNaZ+rZal5koVP74YybJrgf2FtBTz1F91lqGnerbDe3dRiJ6+bRT63DYeT/
         za2IwvatT6p1UY3lYizwSQx80z9ltpeFBUZ3Ho5bzcbVMwblvJETXpxY9+FNOEMhLmXE
         zvVA==
X-Gm-Message-State: APzg51DCBo/1QwdXPIke5ZSO+OXObt7DkWw+edPNO9Q5wgnz9+Lm/Lam
        kX2Hor8Svxm9/Cn28aeZ0Dg=
X-Google-Smtp-Source: ANB0VdbxQ43h8Vii//ReyeHjYNB5mK/icBmw2JSkwyb3kJHRc6oey5PlGA5H+hXw99rbruwWLWYIyg==
X-Received: by 2002:a63:e70e:: with SMTP id b14-v6mr26243956pgi.68.1536644494740;
        Mon, 10 Sep 2018 22:41:34 -0700 (PDT)
Received: from localhost ([39.7.19.225])
        by smtp.gmail.com with ESMTPSA id x2-v6sm31396515pfi.166.2018.09.10.22.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 22:41:33 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:41:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv3 2/6] tty/ldsem: Update waiter->task before waking up
 reader
Message-ID: <20180911054129.GC4065@jagdpanzerIV>
References: <20180911014821.26286-1-dima@arista.com>
 <20180911014821.26286-3-dima@arista.com>
 <20180911050449.GB4065@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911050449.GB4065@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/11/18 14:04), Sergey Senozhatsky wrote:
> >  	for (;;) {
> >  		set_current_state(TASK_UNINTERRUPTIBLE);
> 
> I think that set_current_state() also executes memory barrier. Just
> because it accesses task state.
> 
> > -		if (!waiter.task)
> > +		if (!READ_ONCE(waiter.task))
> >  			break;
> >  		if (!timeout)
> >  			break;

This READ_ONCE(waiter.task) looks interesting. Maybe could be moved
to a loop condition

	while (!READ_ONCE(waiter.task)) {
		...
	}

	-ss
