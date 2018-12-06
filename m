Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E3EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807A720892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzCJntGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807A720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeLFMir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:38:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46696 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbeLFMir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:38:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so94768pgp.13;
        Thu, 06 Dec 2018 04:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7T3Z/RLXH8+rd3EVgCwxQV8uumOeYg1p74kYiWjm518=;
        b=RzCJntGzBbKtveKyMaWS0U1HMRngO/ZfP7IsiaptTrM1IwxJnuXWuFQLR1c+EicHTG
         5d8JB7LklBsfHt7Mj38i8O3Uzrop09DFk2eQv52qKZuR2fo2dYKUOnXaUVGlI+0ushJI
         JI+rU4f/5KsdSQUBUZU8jZczlkgNyEvA3OdagRo2irVtRTa3+NMdnNR4U6SiGhjIKh70
         riz2V8blEQljBZQyTWcyD/SyC120svaS1cdT33PjL+r7stZw70atUO87zYvdGzMbr/Di
         Q6NIcFYXUujx+IgWVmLKEjQo6Y994JboUi+ojqcwclSiKT7Bx7k6Fh+aFxKQbDs8fF6V
         G7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7T3Z/RLXH8+rd3EVgCwxQV8uumOeYg1p74kYiWjm518=;
        b=NtxYY15MuPYdRXcVzxOqZATDmFI5ijtrrs3OSDHh8U+pKPJBtFkakTgeLUgUg4Q+P1
         2XC4F8Z1cFH7RkspTkoIvaoW8UTnxpsHjOhG8RYJo2DL9viB/sL3jyLqWDmBjwfaIHgL
         1U/K9OOKLu+YlJ+vXXlYY/96nyqcdaoS/U4OxrHi1lQFBolmKl5iyXhfcIPXTVEHnY+6
         z9lJ4ua2wX1G5A7yIsVlwV3C+Dal+vKmB5U/t7D32L3QK6nP9p+vPpnUwzUntOOAbxM9
         XSoWgbTRQk26g6FrmYTDuJdgJiONmP0jYC1zQXPfaSue4Rmr0VENJz3vOCVFNbo1Ak0L
         vD3A==
X-Gm-Message-State: AA+aEWap4bprJJstHYYLwITZpidqP5vTMibkENXoAAdEVhNxzTNM+udi
        495ZnqAUcmyygu53OOnBjwM=
X-Google-Smtp-Source: AFSGD/XCz07iz7PLzaVaT3lmHTtqAt2hgE/Tzx0XfI23TuALfbsCq2SYKCDL2iZmnsHZ7Yg/+tCbHQ==
X-Received: by 2002:a63:955a:: with SMTP id t26mr24110648pgn.449.1544099926319;
        Thu, 06 Dec 2018 04:38:46 -0800 (PST)
Received: from localhost (c-24-4-239-105.hsd1.ca.comcast.net. [24.4.239.105])
        by smtp.gmail.com with ESMTPSA id w88sm1350095pfk.11.2018.12.06.04.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:38:45 -0800 (PST)
Date:   Thu, 6 Dec 2018 04:38:43 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181206123843.f637bvkvzibev2p5@localhost>
References: <20181130163252.e6z33t23j3qud57z@localhost>
 <20181203105506.GA21127@unbuntlaptop>
 <20181204044257.grk3na2wyrx6nssg@localhost>
 <20181204070033.GG3073@unbuntlaptop>
 <20181204145538.dnyqlfspnpqmojop@localhost>
 <20181204151049.GK3073@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204151049.GK3073@unbuntlaptop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Tue, Dec 04, 2018 at 06:10:49PM +0300, Dan Carpenter wrote:
> On Tue, Dec 04, 2018 at 06:55:38AM -0800, Richard Cochran wrote:
> > On Tue, Dec 04, 2018 at 10:00:33AM +0300, Dan Carpenter wrote:
> > > 
> > > Why did you commit 3b1ad360acad ("pps: using ERR_PTR instead of NULL
> > > while pps_register_source fails")?  You're not listed as a maintainer so
> > > I wouldn't have known to CC you.
> > 
> > I'm confused.  Where is that commit?

...

> I'm on linux-next but originally it came from the char-misc-next tree.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-next

Commit 3b1ad360acad changes a return value in the PPS core, but it is
missing the hunk for the caller in drivers/ptp/ptp_clock.c.  Can that
be amended?

Thanks,
Richard
