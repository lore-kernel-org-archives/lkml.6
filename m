Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iR4HKmyEHlveGgAAmS7hNA
	; Mon, 11 Jun 2018 14:17:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 93340607A4; Mon, 11 Jun 2018 14:17:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="e6XWf3be"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 19E566074D;
	Mon, 11 Jun 2018 14:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19E566074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934111AbeFKORM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:17:12 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:54134 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933534AbeFKORJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FEkErDQ6hAFvizy8B/F5+8tRwr//SvGo6GUoksXzhWk=; b=e6XWf3bew3jwBsUehAA5s8PzHj
        UHhMA40XeEeBoEkvyEMsyv/tnWbe6jr4KTzmJwfCmqKo3TvSxRPLWnPmmqT6W7dF0uz451MQ0VueD
        6oF5k4qLexUsKLXvZK2evfTt3ImJAjSM8MCZcWFvIvrjSqMtG0dStXncR8W4aQEBV/pk=;
Date: Mon, 11 Jun 2018 10:19:25 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm: fix null pointer dereference in mem_cgroup_protected
Message-ID: <20180611141925.GC1507@cmpxchg.org>
References: <20180608170607.29120-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608170607.29120-1-guro@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:06:07PM +0100, Roman Gushchin wrote:
> Shakeel reported a crash in mem_cgroup_protected(), which
> can be triggered by memcg reclaim if the legacy cgroup v1
> use_hierarchy=0 mode is used:
...
> Reported-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
