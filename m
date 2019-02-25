Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922A720663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHqbY7UC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfBYN6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:58:49 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36968 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfBYN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:58:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so10523408qtb.4;
        Mon, 25 Feb 2019 05:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7E2nhCf5m4zUU+0g1U73m8a7i0WnkC30luu+UtHCISg=;
        b=LHqbY7UChlWQuopDi5XwO9YvFxLQBtm+R9NE15+OeJiDKLgCoDXtQJM3sS5QWjnY1u
         kz+1lHSv4SGGsOGvdirjrUEGTu7EadRcc27q6alpR06Q6MM2haKRqQcyCLape0L410Mn
         zuFSUACyJJ3UUWdrNUPhs4Xsi2tnS2Iz10ytmCAXQBrDkYVUOo5gs4vNefX+tndyRGTc
         4G6S52mgOb7WyVuvDzrmy7fE9XlkjTqRE7tOrIBlTecwmt6ENddfVCYoOIqvRN/PLcXz
         d7QxBcLYBiuebiqcJ5iQZpYiOvw23nMYXw7lWCdi6JwFXklGULqnv/RrfpEjhX8ZuaDK
         4tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7E2nhCf5m4zUU+0g1U73m8a7i0WnkC30luu+UtHCISg=;
        b=JfXshJ/xjixiYblN/i8MvHcGrrqb1TUmdUaEgiI1bTPFiDbgB2shDHKwgdr3fa0aRX
         6RRlret2T+nXEUHaYASaKjclMJT2msUHsTLee1I93L/2pjx2EotX1DZ0ZB8xAWfN+M6s
         B1V6777bOdT86RoMIPEKcF6na8rSF9ii1519dFkXCzrOOa3naxhK7ZfXSVcSLGxRs6pd
         61e3uVoGj2syLGN2lojosHvf12K9MKy4/4qntpkqrv6ljRMBFCHthCGh6ObVFD1spmNp
         ozWw39Dn87F11Qj8RImgFl0iqfMW7IjTcvEUDJiQJ5H6PS/22N/GS5i1pernKGekugCT
         MJTg==
X-Gm-Message-State: AHQUAuZm45ZZ3pQ8pUDgADBwxF7FNcGbevF20oY2TCxhTsOMWEC7UYNt
        GLeoO3mn3B/kjzPzu3X+D8vMLk0P
X-Google-Smtp-Source: AHgI3IYFds9+mKpBw3LI4/R1LnxlbxqLW5s7FBrIAUioS+tTAkLDjY4cmkSwtDrOXFgXzh29wvG33w==
X-Received: by 2002:a0c:b527:: with SMTP id d39mr13806768qve.201.1551103127650;
        Mon, 25 Feb 2019 05:58:47 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id s16sm857396qks.90.2019.02.25.05.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 05:58:46 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB5154039C; Mon, 25 Feb 2019 10:58:42 -0300 (-03)
Date:   Mon, 25 Feb 2019 10:58:42 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 08/11] perf tools: Add perf_exe() helper to find perf
 binary
Message-ID: <20190225135842.GC31136@kernel.org>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-9-andi@firstfloor.org>
 <20190225125622.GJ19795@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225125622.GJ19795@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 25, 2019 at 01:56:22PM +0100, Jiri Olsa escreveu:
> On Sun, Feb 24, 2019 at 07:37:19AM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Also convert one existing user.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Applied.

- Arnaldo
