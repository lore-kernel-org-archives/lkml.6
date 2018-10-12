Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3FC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251E720865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcn8Tpvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251E720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeJLUMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:12:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37543 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbeJLUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:12:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id y11-v6so13267034wrd.4;
        Fri, 12 Oct 2018 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2GkV2qnHDFgLDfuLqIIY2bhW+UCJfHd9MWMc+0wwJpA=;
        b=vcn8Tpvy5QZ7FH0qyF9MhzeLviaCRKP0obdwsqox9C0UEjqcyjM8TsX2zEcYfj98Hm
         eHh9Vn6hYFv5XwavFoEBG1PpIMBSsZoJ2lIUDqFLwqBrwRDXH48qws5kDm7DQryDFnl6
         yi+2ycQsu0zGCJzVJoWXZB/kg2SebyabwiA0YsFWU5gYds/IeM8LEJ1H9OHS8vmpVqwI
         x2f2O9yZnvDu3B2Zx+Ohjb89Sx8pnxASYgkj4gn3gelm8SMsozSlFr14Wd4PSydx7Uhd
         XNA0JB/U8Qp6/Z3nfBHQXzV1s/T4gCy274EPhTkK42mkvRYIg2V3RB44MElk8Ie1kPhy
         5c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2GkV2qnHDFgLDfuLqIIY2bhW+UCJfHd9MWMc+0wwJpA=;
        b=J9S8cmyqgAQq8yfFpjVORHWLB4m5XCsguzqrr79TTCT/xABVgsF4Xro4AOAfD/r9ux
         O3eKBWCwLjVx/6lAgWI20D535Qv5JrUx8AfNJESkt7fPvO9ZKshxWBefLvZbzdqss29x
         P59bonzusdruhySGBFCOMv0IFdHjxJugAOEyCO2+YkabvQgq7CBHpRytEsIVsXDXTtkl
         hrFhxDKBnL4CGnfA5T3Jqv5CQBohrm8qa5r0o7dH+RXkaVZCdZze/DkCj0cbEaTHjs9C
         VwYfITorw6BInH3r9qohd6GdgC6tmDmEVZroNeCOOB53MKcpUkse2HfSTKc4JnGSar3W
         dL4g==
X-Gm-Message-State: ABuFfoj+AQJ7rvXrmEJgq/9pnXnjpw/X286MW1se0cIMutsbFz7I19X9
        z3J6EhQwiOYEupou9rlqV9M=
X-Google-Smtp-Source: ACcGV61F/2FzndhTe3S8LzjyB16L3WrG7J0xRxGCu5WRjmSG9ruv9ggQayzDjYAWblJegAjF4FG2PA==
X-Received: by 2002:adf:a144:: with SMTP id r4-v6mr5094140wrr.169.1539348029051;
        Fri, 12 Oct 2018 05:40:29 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i7-v6sm1589600wmd.41.2018.10.12.05.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 05:40:27 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:40:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     Jaroslav Skarvada <jskarvad@redhat.com>,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpluskal@suse.com,
        base-system@gentoo.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181012124026.3v3b6v46hpszkgrt@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <20181002081654.jxesr3kj62snzez5@pali>
 <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
 <20181012091941.o22srnhse4kzqjhf@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181012091941.o22srnhse4kzqjhf@fatal.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 October 2018 11:19:41 Andreas Henriksson wrote:
> Hello everyone,
> 
> On Tue, Oct 02, 2018 at 04:44:10AM -0400, Jaroslav Skarvada wrote:
> > I am downstream maintainer of dosfstools in Fedora/RHEL. My personal opinion
> > with such kind of projects is that one or two years without activity doesn't
> > mean the project is dead. I don't know what happened with Andreas, but
> > in case of no response my +1 for the GitHub fork. I think it's non offensive
> > solution which can be easily reverted if needed. Please let me know if you do it
> 
> It seems Andreas is a Debian Developer (like myself), so I used the
> debian tooling for 'missing in action' (mia-query) and it seems
> he is occationally active (but showing obvious signs of busyness).
> 
> I even found his irc nick and found him online. I told him about this
> mailing list thread and he replied that he has been extremely busy
> with things in his personal life lately and said he should really
> try to find some time to catch up with things, but since he hasn't
> replied here I thought I'd just let you know about the situation.
> Hopefully things calms down for him soon to allow him to catch up.
> 
> I hope you find a good way to handle things in the mean time. More
> people probably need to help out reviewing incoming issues/PRs and other
> things that can help Andreas out with the maintenance burden, but with
> his current lack of time it might be better if someone motivated and
> capable just forks the project on github and starts doing the
> maintenance work in the fork. If things works out well, maybe this gives
> Andreas confidence he can safely hand over the official maintainer role
> to someone with more time for it (and you can 'unfork' again).
> 
> Regards,
> Andreas Henriksson

Ok, so it would be great if somebody can help Andreas with reviewing
opened dosfstools pull requests on github...

https://github.com/dosfstools/dosfstools/pulls

-- 
Pali Rohár
pali.rohar@gmail.com
