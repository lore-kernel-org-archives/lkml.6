Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD29C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9726D21757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="je7NA7cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9726D21757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbeHGPaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbeHGPaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:30:16 -0400
Received: from jouet.infradead.org (unknown [179.95.176.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231E12150F;
        Tue,  7 Aug 2018 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533647759;
        bh=sygzHL2WNPl3I5HIiYvoGKmqp6kuqjRiiajtwUCxIaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=je7NA7cc33bAu+9FHU88AFPL4NN4dAhfnQohNNzWYnD+IdZG5JIl/N66T8YGBkgJq
         ZR/6QZmGZLwqKrJxs0GXF5BA/fee6WC2LiSYdQgxzfG/M66CVgrhbOJE/vsEL/+IY3
         2g+4DDJgdQpUD0sQs+sqk41JgdccaX7S6IyiMgdQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 67DF7140A1C; Tue,  7 Aug 2018 10:15:57 -0300 (-03)
Date:   Tue, 7 Aug 2018 10:15:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] perf map: optimize maps__fixup_overlappings()
Message-ID: <20180807131557.GB4173@kernel.org>
References: <153363294102.396323.6277944760215058174.stgit@buzz>
 <153363294565.396323.4605638589903548668.stgit@buzz>
 <20180807125528.GE7716@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807125528.GE7716@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 07, 2018 at 02:55:28PM +0200, Jiri Olsa escreveu:
> On Tue, Aug 07, 2018 at 12:09:05PM +0300, Konstantin Khlebnikov wrote:
> > This function splits and removes overlapping areas.
> > 
> > Maps in tree are ordered by start address thus we could find
> > first overlap and stop if next map does not overlap.

please address Jiri's suggestions and send a v2 just for this one,

- Arnaldo
