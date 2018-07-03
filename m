Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7709C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7086A24B6E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9oKQedI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7086A24B6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeGCI2T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:28:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50533 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeGCI2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:28:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so1347756wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TevpuEWHwzFJwFokUquiu1PaVulMJQIS/cpJ9Aao+Hg=;
        b=O9oKQedIrAilhYuGUIqWKjYJiF2KTa8EoqWTHBsakLRtrTsnjsSBsX3Nw1i7r1bBUv
         X3cP6ksTF14a2J3GQUEfd6g/INGhqy5uRwolKG03s/HW6N5xHTGRhYvSLSSD/eAfauC8
         3VAcFgc150sdBEDUHwEAFTtiAcQq55VgLLP34LhECw9onqukoKD1oAKmukxwDsxaftX6
         aBS7EuTLPvEjM9loW/HB4xrFA2W85b170NkpqK9TMLEJ5LLlkKQOfzd7g2Nx+eqm+Z+7
         8yDJDiYIViQHLlCXbLgblxzinXmTMXT0Sk2u07JsWk1whYzI4p6dOP1SuG9nyX8I3V2s
         ASyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TevpuEWHwzFJwFokUquiu1PaVulMJQIS/cpJ9Aao+Hg=;
        b=qe8s06mQ03zppq9+OvIYKwkmd+LpPxdhjag8aqEqhpYzAaENp98KIN4RHI3uUZaIEb
         SbwuHgeWW3E9eLCNtW69llfaxUlkhhNfhnZ0LqQy9YUBUyoUVYy2+PyGHjbrwe8u3f8H
         TOqt17EYzN2gVGZsLV2agyE4kO15Qs78DPIdhuhNSm2GR2rWZ/mZ/TUMBqlSOx8dw2ij
         XzVHpwD2AXE9nAY8fHT37fJJJIdgNQvWBzDbXOdKWi4wP1UCPnD/U2yohoXV1NMvADvy
         BxggLRXcyYNVGXh4S+9zVCLg187Ziuvj96zEu9FuT4sPF8mpsi4qe+MPfqD1vSjCeVxn
         J2aQ==
X-Gm-Message-State: APt69E0ub73KAPp+A0rXADWqXHsMVOajS5Iv4De8Wj9dY5aj78yY5+O8
        FB+FJTCubmHFTHpO6WAzeoc=
X-Google-Smtp-Source: AAOMgpdtwQUDWEjNAK5xjS1qcZn4K7X8I9fZM9MpC4CcMyP9p5Yhk+/zgyt6IoUCof1C3gWRitmIJg==
X-Received: by 2002:a1c:a342:: with SMTP id m63-v6mr9730862wme.141.1530606495399;
        Tue, 03 Jul 2018 01:28:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l1-v6sm1323645wrf.19.2018.07.03.01.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 01:28:14 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:28:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH] x86: make Memory Management options more visible
Message-ID: <20180703082812.GA971@gmail.com>
References: <af12c83d-2533-ae00-b53c-1fc1a9d8e9ce@infradead.org>
 <20180702140612.GA7333@infradead.org>
 <afcb4a42-891a-d732-f072-79c0a1fc49f0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcb4a42-891a-d732-f072-79c0a1fc49f0@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> On 07/02/2018 07:06 AM, Christoph Hellwig wrote:
> > On Sun, Jul 01, 2018 at 07:48:38PM -0700, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Currently for x86, the "Memory Management" kconfig options are
> >> displayed under "Processor type and features."  This tends to
> >> make them hidden or difficult to find.
> >>
> >> This patch makes Memory Managment options a first-class menu by moving
> >> it away from "Processor type and features" and into the main menu.
> >>
> >> Also clarify "endmenu" lines with '#' comments of their respective
> >> menu names, just to help people who are reading or editing the
> >> Kconfig file.
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Hmm, can you take off from this for now and/or rebase it on top of
> > this series:
> > 
> > 	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/kconfig-cleanups
> > 
> 
> Sure, no problem.

Also:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
