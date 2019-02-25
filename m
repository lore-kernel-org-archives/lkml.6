Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74B5217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+6z3rJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfBYOyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:54:46 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:39862 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBYOyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:54:45 -0500
Received: by mail-qk1-f172.google.com with SMTP id x6so5429465qki.6;
        Mon, 25 Feb 2019 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SbFXoj4f8i3EcvLlKTnI4mHCIczDvyuycOQ9EPw1VBs=;
        b=W+6z3rJK/hpN6+0KsCzP0Hw/LUYsylmnjUBFty9GMUCap0nhx+Q9n+mRmYNYvgnwv9
         Ra4BUaKAiBmREyQptb+zQY7sVqtZx/94JRkvw7dP/NGNE3TMzEgQU8yFgpKgH3u6MyTZ
         fc7b7HsTclHMXl0XferdPsCrU7qbCKNYyp2/o4nk+WUvALdb4dMfYg7J1h5V+dNc6gHV
         4zdB2hXFlFbAAt0BAEap1Pk1YxyLGmPO3aIkT6Cnj+WX3N9f2MLsqF5cgkhzaP1CdyGO
         hPG627ESmJO6jLid0OF3L7oBmJm7I0Q1VJCQZ4C4ikLRNYPNhsp45cw0sOVcmnaK6cHW
         qJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbFXoj4f8i3EcvLlKTnI4mHCIczDvyuycOQ9EPw1VBs=;
        b=Ct0m1dbgGttskYtyHFj5vC1le5s7q94V3Bq7GgiIPCGRzs4pEq1Tqez/LSZ+ANAuAR
         HdMWQwAjOWwzIKxwaWkxU4i/zY2Ge4xM8mInN9we5mDXp1nnnOrSJtRuvTifHvyQIiel
         fuW0Z0jOM+mcBOiN1dr4m2zLMvkmvcnBhAuYeLmVhCzl8LOngesXCkcj6Jjk7vUmFamD
         SrSzUKn3NmX5ASIT1rc6oZRF4r8uXIHnamAogMSPOm4ZRP/YQHlHsaWhD69fg65b3eHv
         d99TTKTKk8+EMrngSw1BZ3IU1v76I5NGemA1I6128OGw+EFa23E8aVzz+nVmg4YY+m7N
         2i2A==
X-Gm-Message-State: AHQUAuask85QJsEGw/3qfuI18Lm5u0FbWkMdU8UP/HdbyDj+AV9YanEr
        ftchmXVMvQAGK3eJk052lEuxyzsk
X-Google-Smtp-Source: AHgI3IbsCFPomhtYHHw/6mBoNimrmJKgdZhtG5eYUVi/YvLc0ETdUacv1og9l6hX74R5yIm1bCEW4Q==
X-Received: by 2002:a37:4bd7:: with SMTP id y206mr13390484qka.167.1551106484091;
        Mon, 25 Feb 2019 06:54:44 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id 37sm6064959qtz.95.2019.02.25.06.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:54:43 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D85594039C; Mon, 25 Feb 2019 11:54:39 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:54:39 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH 15/15] perf script python: add Python3 support to sql
 scripts
Message-ID: <20190225145439.GP31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-16-tonyj@suse.de>
 <20190225145119.GO31136@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225145119.GO31136@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 25, 2019 at 11:51:19AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 22, 2019 at 03:06:19PM -0800, Tony Jones escreveu:
> > Support both Python2 and Python3 in the exported-sql-viewer.py,
> > export-to-postgresql.py and export-to-sqlite.py scripts
<SNIP>
> > @@ -234,12 +236,17 @@ perf_db_export_mode = True
> >  perf_db_export_calls = False
> >  perf_db_export_callchains = False
> >  
> > +def printerr(*args, **kw_args):
> > +    print(*args, file=sys.stderr, **kw_args)
> > +
> > +def printdate(*args, **kw_args):
> > +        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
> 
> So this one introduces inconsistencies in indentation, i.e. the above
> two routines don't use tabs and one uses 4 spaces while the other uses 8
> spaces :-\
> 
> I'm converting them to use tabs, like the rest of this script, ok?

But it is not applying, Adrian did work recently here, can you please
address this and resubmit?

I'm pushing what I have already merged, please update your
acme/perf/core branch and continue from there.

Thanks!

- Arnaldo
