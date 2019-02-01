Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21961C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC224218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549038670;
	bh=6jHS0f+LWfyTpZALm5yURty/6Dd8VPZuM/qKbGyDVSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UGvvjOyqLIawagrrmwq1Z3uUJ7bfAypLN6gw4QFYn8ZN9hBiBa37cXdPswoZmsOjS
	 2iw4vQ5wp/k5RQ8LTM2zhzWqAThKdNuSdBYjzKgIsuhIB9+xHgSDYYA5ueGvmNedaZ
	 4RYaJppCaCHjfzzBkOv2EkcrLulU2rsBDH9HW1Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfBAQbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfBAQbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:31:08 -0500
Received: from quaco.ghostprotocols.net (unknown [94.113.247.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD142086C;
        Fri,  1 Feb 2019 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549038667;
        bh=6jHS0f+LWfyTpZALm5yURty/6Dd8VPZuM/qKbGyDVSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yi3wmig3cq1aoQkvVFjkPAw0LJ64IiKLQ7T5y5amhPJqn4UAUNaf2aQxiVLWgX9xF
         kAbYbOV+tH0mUxYhzpqKmgzJRk0TZ4i6bdbv0aDDozr4LXEV+3rO0AHPP241Apu2gh
         PuruzKCE1wL9Cg6ZmcwQ3strlOq4cxOxtyWaMHhs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A5304034F; Fri,  1 Feb 2019 17:31:05 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:31:04 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] Reduce NUMA related overhead in perf record
 profiling on large server systems
Message-ID: <20190201163104.GA5593@kernel.org>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
 <20190128112748.GC15461@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128112748.GC15461@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 28, 2019 at 12:27:48PM +0100, Jiri Olsa escreveu:
> On Tue, Jan 22, 2019 at 08:45:12PM +0300, Alexey Budankov wrote:
> > Changes in v5:
> > - avoided multiple allocations of online cpu maps by 
> >   implementing it once in cpu_map__online()
> > - reduced indentation at record__parse_affinity()
 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Applied, now going thru testing, lets see if it builds in all the
containers.

- Arnaldo
