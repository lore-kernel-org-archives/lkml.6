Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FV2pAz+BGVsDCAAAmS7hNA
	; Thu, 07 Jun 2018 19:02:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E763F6074D; Thu,  7 Jun 2018 19:02:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiyrKiFv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7CA88601D2;
	Thu,  7 Jun 2018 19:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CA88601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeFGTAW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeFGTAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:00:21 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9291120895;
        Thu,  7 Jun 2018 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528398020;
        bh=zsgJri9oPeZ1HAY0o+FSGjA1BnCAaNo3VQ5luK+hWr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiyrKiFvdKLI9RvbjB3Y9mdBKfODMA1tlrxkNaKAR0g/c3tusOSEOmk3UIwT4kG3p
         o5Zq7T26Eok0TkizkHUtHNzpXTP6LTN1nT6nbOYV7GdozoQEIXaLkLD5cJbghRFbeq
         T4OGioWAJVUmyjfFDm0t4BZPpYPYKKOBQLZRbynQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 613F61468B9; Thu,  7 Jun 2018 16:00:18 -0300 (-03)
Date: Thu, 7 Jun 2018 16:00:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 04/10] perf stat: Use only color_fprintf call in
 print_metric_only
Message-ID: <20180607190018.GC17292@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606221513.11302-5-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 07, 2018 at 12:15:07AM +0200, Jiri Olsa escreveu:
> We can call color_fprintf also for non color case, it's
> handled properly. This change simplifies following patch.

Thanks, applied.

- Arnaldo
