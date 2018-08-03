Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B733C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92322086B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTA/LSKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92322086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeHCRsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbeHCRsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:48:36 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850B42170A;
        Fri,  3 Aug 2018 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533311504;
        bh=rga/CoHFt2fwF9D5EzSynYye+ZsAnLjxTSkc9wkx2Mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTA/LSKKtpSA8S6dPuKO1U0t9Ui8w6/AmRIC857iB+1WivwQkVu6O6PVoWOxd1jmV
         R1eu0lOvJoNlvJXdiXqFjGQBCJyvrSmOuirnWuzDdUfSo9EK2Sn1/K/toYd3hRksOj
         NFiXfSnx0W6s5KVS1KlsoM+Vo5PwG8djWu3ykG/o=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 02876140A1C; Fri,  3 Aug 2018 12:51:40 -0300 (-03)
Date:   Fri, 3 Aug 2018 12:51:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] perf annotate: option to report global percentage
Message-ID: <20180803155140.GH7996@kernel.org>
References: <CABPqkBT0P=GKNb6ypjaPxe4dEwShHk37mdrX0RtodMm44gaE+Q@mail.gmail.com>
 <20180719082539.GB18667@krava>
 <20180731092128.GA17617@krava>
 <CABPqkBQOWGUsTOXP1CjVxSDtquSGrxaiSqK1ZgJcW0jfzwENsg@mail.gmail.com>
 <20180803112955.GA2402@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803112955.GA2402@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 03, 2018 at 01:29:55PM +0200, Jiri Olsa escreveu:
> On Fri, Aug 03, 2018 at 12:28:16AM -0700, Stephane Eranian wrote:
> > On Tue, Jul 31, 2018 at 2:21 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > there's the 'p' key to switch between local and global period
> > > I haven't added any command line option for stdio yet

> > > I'll have more testing and post later but any feedback
> > > now would be great

> > Tested your code on a few examples and it seems to work well. Looks nice!
> > Thanks.
 
> cool, I'll have it sorted and send out soon

> > PS: I'll have more small requests coming based on user feedback and my
> > personal experience.

> keep them comming, we need more user feedback ;-)

Exactly! Features driven by user requests are super important to keep
these tools improving.

- Arnaldo
