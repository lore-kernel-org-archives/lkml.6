Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EBAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145792084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546169109;
	bh=RpjY7SSj2kmlORp8R7hyIgBne2j4azVNO6Escq39RUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gx01ENAd7WRB8jey26RDlcYgxUs99DaafH0RE/KAIdJ5h1XX/WpPFQilf7gPTqJfz
	 mdE7a+o63D+/e1V7b6PlkpgUQPl7R/eZXWwvDyDz+dlABtXdLvvCOlQM9qErHgvCwM
	 fBQgQh2TAYShCdpyjsg1hEunaRGDgV6T1odF5VaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeL3LZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 06:25:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50875 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeL3LZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 06:25:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so21903196wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 03:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zihMkPJKGrw/WyBTRFkecBRoxbnNFH+ExvSelPKG0Pk=;
        b=JBsl+P9Uf4YWM+SIA9tbcWzM4gKSuy09o4wUcrlWxnxSLD39RZE9jnKh86U3cUqvPS
         V7a2wmIM/q9H4BjeTr74fv4lIkuvPA3OEDUukvO9K9/WECPkXSpeTwRTR3i4xxXToNm0
         bTwyRLQ4XHZtyJQSTI0HzT910rui5T2T+QEP5UtVINn0X8aKdcHsM69dwHgcaXUi5O3w
         YaDZhrCS9t0lQeb7sd5zZGAgKcinVczsEQGlJN93iMJQGbcCCrta07XwWx3sLC2q44Sc
         8nDTQKOnyJ3EPPXSaaRoEaZgjaDOwV0fn7MPaCmhhecnH5vWeWKtfUpxgKCZ0s5tu4ET
         VQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zihMkPJKGrw/WyBTRFkecBRoxbnNFH+ExvSelPKG0Pk=;
        b=kx6yHiZaQwlUw7YDQPFwNBUYrHMoPIZSQjOHppe4E7veX1bu9FUL798rmQQLTUFE3Q
         5hcCVlQwD1A9XQUEQheXpcik9spc6iR9aKQdTibSvkJMDvrBQAy3vn42MRzE3wI7xkpB
         4UtvxtfmnNdDU+MWdviuv3vwJ85VIcK7pO+y2GettMCQitxeL3qnEauEz6Oa+SE2tXSK
         2k635JEeSWvZvgYjwlNiP5OJ/G10iSYRYNAjgBgIRi0bmIorwt0LeMD9FD3AKkhEZi5e
         nlyfwh+BlRbWW6jSTE1OTMT0ilveGnmipjo38mw9hRcIamRf+N+HW+TdIolPfqjrqE2Y
         bxMw==
X-Gm-Message-State: AA+aEWboYXwH6Rez8yrN0i+HXaHIya7554W1fF6Hz9EFGmE1lo2HLsfe
        lm/UAfzBM3lThpHVE+4usQI=
X-Google-Smtp-Source: AFSGD/Ue9Iyd/YC4V1XE2ldRjt+9qkCdbDTm8ddrtW7q3AXUH/bCyIyAKvR0lB9v8ZuMtBCvGyVE2A==
X-Received: by 2002:a1c:c58d:: with SMTP id v135mr29790763wmf.88.1546169105039;
        Sun, 30 Dec 2018 03:25:05 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j129sm27683812wmb.39.2018.12.30.03.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Dec 2018 03:25:04 -0800 (PST)
Date:   Sun, 30 Dec 2018 12:25:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Willy Tarreau <w@1wt.eu>, acme@redhat.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools headers: move the nolibc header from rcutorture to
 tools/include/nolibc/
Message-ID: <20181230112502.GA16126@gmail.com>
References: <20181229180453.15889-1-w@1wt.eu>
 <20181229182508.GJ4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229182508.GJ4170@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> On Sat, Dec 29, 2018 at 07:04:53PM +0100, Willy Tarreau wrote:
> > As suggested by Ingo, this header file might benefit other tools than
> > just rcutorture. For now it's quite limited, but is easy to extend, so
> > exposing it into tools/include/nolibc/ will make it much easier to
> > adopt by other tools.
> > 
> > The mkinitrd.sh script in rcutorture was updated to use this new location.
> > 
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> Thank you, Willy!  I have queued all four of these.  Should there
> be a MAINTAINERS file entry for the new include/nolibc home for this
> library code?

Very good idea - ack. Could we please also use the opportunity and move 
nolibc.h to a more prominent place, like in tools/include/nolibc/nolibc.h 
or so?

Thanks,

	Ingo
