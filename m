Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B83ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B512147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo268oyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B512147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeITWM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:12:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35099 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeITWM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:12:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id f62-v6so5388871qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hQhvdW7Z7gaf+xLWPDcsR5lDoyS/53SvtCJwXp54gkA=;
        b=bo268oyk+QTUQMsnkkbx4BVgP0eLp1aC9IiFlCl/NtV5IVM+uf34popUWnwjhHbdvp
         5UTs8HzgbsOq8gWgOkEWfEN0h3MrLzWCAAiKQVqVQ1rvu+2cwiKgVDDhzBDXHc/cBUon
         ARTnpy7civkp3ALWkJsR97rfoP28htvUOOsxeybHIyRgHMr6oM+Bd/839SjKpPtF5h/a
         z3WpLkAIOqP/vmmoixnYtXqvrjg4yjBlY+88Nk0aBKmVksX2sLYrPGIOQLTmnsM3S6yg
         KN/LnllwUXEpQYV7cHa0RyzmkkocQu928FcireyIDGrKahJrgmtLNZhj8HQpBhHtDRdP
         2mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQhvdW7Z7gaf+xLWPDcsR5lDoyS/53SvtCJwXp54gkA=;
        b=Ei2Xv2CGkxskr/X6hPOihHONUzQodj5hliy6kHP7inQ4271jTsHaJybYmOtfJlreLL
         j22dRK0f48M+5GUIVy2WzoF5kUi7iZCXCeafQBeCzII24xIbxWoX2Aq9gkM4Diic69Cv
         h03VHMMGOnOSpXHKlzc6Fnr9fTUCYD4sajspvTG20VvF7ofj896fVaZ/U/4OSvzaWTNK
         ZBIpVIAc8+Hqw/mja/WSlWNAsy1rr+kpXtuSGjUjD0f4xVUq/ZmyPL8rHSoKTWHDAp53
         Xg4NdmnVrbNnLoOwM0h1yyZn0pHqcg9jFYzwx3eLJAAET5eV8qS6+WNk7ASAraiOAtLU
         hmEA==
X-Gm-Message-State: APzg51AFIhNiwxzdteEaN/gv16VhciDrr9OESZiDSjYyJEU8mjJ7RoJi
        P7AkbdOALIwAnl3mn+PGIw==
X-Google-Smtp-Source: ANB0VdYfwpWoRg4D1IqtWsOLlfbhMc/qdrSh2aXaPaaaW2Ek2M3MHnmI0zjkCD08KGZrfT3VHG5G5w==
X-Received: by 2002:a37:b246:: with SMTP id b67-v6mr24481638qkf.284.1537460919950;
        Thu, 20 Sep 2018 09:28:39 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d10-v6sm15353419qtc.53.2018.09.20.09.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:28:38 -0700 (PDT)
Date:   Thu, 20 Sep 2018 12:28:36 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, mike.travis@hpe.com, sivanich@hpe.com
Subject: Re: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
Message-ID: <20180920162834.bjpeixsfidqseoeq@gabell>
References: <20180904151141.20264-1-msys.mizuma@gmail.com>
 <20180918133026.gzyix3oyrfcsrdcx@gabell>
 <20180919121720.GA47424@gmail.com>
 <alpine.DEB.2.21.1809191421500.18945@nanos.tec.linutronix.de>
 <20180919124806.GA48413@gmail.com>
 <20180919141058.krruhvsjkm6hqgmf@gabell>
 <alpine.DEB.2.21.1809201127210.3243@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809201127210.3243@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 11:28:47AM +0200, Thomas Gleixner wrote:
> On Wed, 19 Sep 2018, Masayoshi Mizuma wrote:
> > On Wed, Sep 19, 2018 at 02:48:06PM +0200, Ingo Molnar wrote:
> 
> > > - Add checking code to the later SRAT case to at least _detect_ bad
> > >   padding after the fact.
> > >
> > >   We don't utilize RAM with bad padding until that, right?
> > 
> > I have an idea as following. Does that make sense?
> > 
> > Add a warning message which shows the padding size is not enough
> > for the physical memory mapping and tell to the user about
> > recommended padding size. User can change the padding size in next
> > reboot to add the boot parameter.
> 
> Yes, that makes sense because silently failing is bad.

Thanks. I will try to add it.

- Masa
