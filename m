Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2960DC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1762148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761996;
	bh=KcU/z8GuANWqNn0q3zEnLBIXXwtqCorwjomk+CGlmKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TLi0z/M3xX82nrGcxQSoZnVDsAz8U1RqlQ7riotoomJ7WHHZcWxRr2O+VM6r+94Du
	 xKSTChThWfaSp80P7wyAXi6HHkI61WF3hTeCDxlO3G88IL46V6TaKt6NvSzqpfyTPU
	 MplGPb0rk6OUnLQgp87BOxZakTTedRnLTqP2umww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfA2Ljy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:39:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbfA2Ljv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:51 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD2020989;
        Tue, 29 Jan 2019 11:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761990;
        bh=KcU/z8GuANWqNn0q3zEnLBIXXwtqCorwjomk+CGlmKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2AWZ7mtHrwrVkrz2mzbeMkPAvgPBRC+6H1ed9WOu7DG23GjV/l0AzAs5Jw31m5Dh
         rj/KVNVUSV8eFTv1A1BaIPsx1jo7wruwA4xeTkFS+Bk8LEQH/pOYKWsnxfHHjPwg1y
         d1hYle2kYfVLfqBR+PDtthekoISSWCJdZ0KGgm0c=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1BD064034F; Tue, 29 Jan 2019 12:39:49 +0100 (CET)
Date:   Tue, 29 Jan 2019 12:39:48 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Clifton <nickc@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf tools: Filter out hidden symbols from labels
Message-ID: <20190129113948.GK4344@kernel.org>
References: <20190115135354.11572-1-jolsa@kernel.org>
 <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
 <20190115173838.GB31411@krava>
 <20190128133526.GD15461@krava>
 <20190129090750.GE4344@kernel.org>
 <83e6ed5c-47b8-9499-af18-5ada0c4bdd6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e6ed5c-47b8-9499-af18-5ada0c4bdd6c@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 29, 2019 at 11:25:35AM +0000, Nick Clifton escreveu:
> Hi Arnaldo,
> 
> >> there were no objections for rfc, sending patch
> > 
> > I don't see a problem, Nick, can you provide an Acked-by, or better yet,
> > a Reviewed-by so that Jiri can collect in this patch and I can push it
> > to perf/urgent?
> 
> Sorry - I do not think that I have the authority to do that.  I am not a
> perftools maintainer (or a kernel maintainer).  For what it is worth the 
> patch does look good to me, but I think that a real maintainer needs to 
> approve it.

Ok, I was more thinking about this part of
Documentation/process/submittingpatches.txt:

----------------------------
Acked-by: is not as formal as Signed-off-by:.  It is a record that the acker
has at least reviewed the patch and has indicated acceptance.  Hence patch
mergers will sometimes manually convert an acker's "yep, looks good to me"
into an Acked-by: (but note that it is usually better to ask for an
explicit ack).
----------------------------

But its ok, if you still don't feel this should be added, I'll just
leave a Cc: you, ok?

- Arnaldo
