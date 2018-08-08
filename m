Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1BEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E72B219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj2XOI5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E72B219E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHHPAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeHHPAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:00:04 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D659321742;
        Wed,  8 Aug 2018 12:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533732033;
        bh=oNQHkXgsiwP5sqeeX/drnrB9cIwyFRMdJHtHJUSaL3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aj2XOI5lmbhlnlavS4NQfS7WFI6lEQnd/pC6mDKfJZTwUCxIYuKDGDWEMel7kHXwC
         0tnxErB5a+y9lWQtPG/2DSoLqOht4g6CvQ93Y/sVc9KHr77UtacozMjaOhvC3NjIlP
         XjPjcURIDKeLTTALHj4Oi4gGkvcsyEa6sJmC4IPg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A673C140A1C; Wed,  8 Aug 2018 09:40:30 -0300 (-03)
Date:   Wed, 8 Aug 2018 09:40:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] perf map: optimize maps__fixup_overlappings()
Message-ID: <20180808124030.GA1727@kernel.org>
References: <153363294565.396323.4605638589903548668.stgit@buzz>
 <153365189407.435244.7234821822450484712.stgit@buzz>
 <20180807200237.GA5395@kernel.org>
 <20180807230301.GA20320@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807230301.GA20320@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 08, 2018 at 01:03:01AM +0200, Jiri Olsa escreveu:
> On Tue, Aug 07, 2018 at 05:02:37PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Aug 07, 2018 at 05:24:54PM +0300, Konstantin Khlebnikov escreveu:
> > > This function splits and removes overlapping areas.

> > > Maps in tree are ordered by start address thus we could find

> > > 
> > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

> > Jiri, I'm applying this one with your Acked-by, ok?

> yep, sry.. overlooked this

> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks!

- Arnaldo
