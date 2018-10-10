Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A9AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C122087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRZ2gI+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C122087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJJPmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:42:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40014 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:42:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so2244695pfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J926Cf3AaVSnmVsVP5xY8q+xeD1gequYYjoCkCShNv0=;
        b=cRZ2gI+7kZQ58SOZgvetq655CWihtXnGbJoZTq6rb5D6BKzRdNIlZ4NdvZ68t7APAP
         a+DdCwTyY2sG8+jk/U6TIM6aFar2h7SClKqrOJpN8bsmF7DmwwN5t61ciP3JBiBKgmhY
         weCMUrfV+UQ2OSpmC6E0sQOnW7ayZvydSIQ134Jdqe91cLVWKyIDDTuZ1Nh2bkr0ewXx
         VsAheDRXFAlgm62E4lbBnpnPmTKQExU0yTpmJP74eOMkB4tOsg6ZAUlZ905XCsjxTGym
         z4uUulSZWLHLj8Za1wiNDcCwHq2c9ixzBBcLkZo+tkW/8VBNSlEepYlgx+ZnavzgK+Bd
         NNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J926Cf3AaVSnmVsVP5xY8q+xeD1gequYYjoCkCShNv0=;
        b=jfCvJ29K44ZGdL4n9FBsWADHNULL9VX5Fr9JbJr2IkaFyztaZ9nxm9gRrOaHwpjugs
         KUaJLz1xFLQVi0g1hAjO0EQetN1c68fkvfsgN9p1Eo1ax2Kt/Itl+meZ86uwRRcbD65M
         /0VyaftRCThv8V/qglVxx97CzkrdvHA3ASOKqn9LjomSvEBLfKDrFa0vJKLEDPce9Rlk
         61y+eVY7PgNJpoCRoek9p48UUb6+q0oTgsXxf+OQcU2Usu1/oYUHxYbrb74H+KJJposA
         NdZ4nij8+lkDnubSpZQQb2cuV83HQT1tp9/VsiwIAFzhyEFc8fc4dFo7jAVV2LH9QC7H
         ZUIQ==
X-Gm-Message-State: ABuFfogbHixWWTx/4FvpxcU/E80f5QRSZPJSVqCGYcNzpAhC3shoX60E
        gxOyrcFKJAZqJ/kPaVbLs+0=
X-Google-Smtp-Source: ACcGV60Sk/qgDsf0UEZSd1FYMmSpn/DB5XFHER9nZ1xg6sEVoQbs2eKnfP5nSzL2t3cnO+n7VmWA8g==
X-Received: by 2002:a63:6203:: with SMTP id w3-v6mr28729367pgb.53.1539159694949;
        Wed, 10 Oct 2018 01:21:34 -0700 (PDT)
Received: from localhost ([175.223.17.147])
        by smtp.gmail.com with ESMTPSA id w2-v6sm29215173pfk.140.2018.10.10.01.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 01:21:33 -0700 (PDT)
Date:   Wed, 10 Oct 2018 17:21:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        zhe.he@windriver.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: Give error on attempt to set log buffer
 length to over 4G
Message-ID: <20181010082129.GA631@jagdpanzerIV>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
 <20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz>
 <20181008145950.GA1473@tigerII.localdomain>
 <20181009130538.7rtd3du2d7l6m63w@pathway.suse.cz>
 <20181009135758.GA1419@tigerII.localdomain>
 <20181010080932.h6nln2qsgg4oef4l@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010080932.h6nln2qsgg4oef4l@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/18 10:09), Petr Mladek wrote:
> > > +#define LOG_BUF_LEN_MAX (u32)(1 << 31)
> > [..]
> > > +	if (size > (u64)LOG_BUF_LEN_MAX) {
> > > +		size = (u64)LOG_BUF_LEN_MAX;
> > > +		pr_err("log_buf over 2G is not supported.\n");
> > > +	}
> > 
> > Why not INT_MAX?
> 
> INT_MAX is 0x7fffffff but we need 0x80000000. I did not find
> any predefined macro.

Hmm, OK. I need to think about it more.

> > > +	pr_info("log_buf_len: %u bytes\n", log_buf_len);
> > > +	pr_info("early log buf free: %u(%u%%)\n",
> > >  		free, (free * 100) / __LOG_BUF_LEN);
> > 
> > Can 'free * 100' overflow?
> 
> Good question. It uses the size of the static buffer. If I count
> correctly then we are on the safe side because LOG_BUF_SHIFT
> is limited by
> 
> 	range 12 25

I didn't know there was Kconfig "range" :)

$ echo $(((1<<25)*100))
3355443200

	-ss
