Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA3FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6247265DC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t11s8kHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6247265DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeFZHSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:18:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32977 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeFZHSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:18:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id k16-v6so16065906wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GG07+ZCqAyaOPMynhJMbBwk3HcuhahgAfWpVsrWg3OM=;
        b=t11s8kHrSBRxBGz6iCGjR25ROPvEIZKK9yF25g/p3o5MbcdDUmPUJQOirdlIqZ2QiS
         OBBIxJ1Ke2HwUs40krC2hY8PRiab/NKp/ic/ipeVIt9f1RpRH9ozeXe3M+aCOgavEJaU
         hWbbG9kENOyrk7NWgCSBuqNhfp6orhoSvm79hvUvHHOsjzB22Yaajdu7lKJzjq898gL+
         /exalTM+kRspVSB8fNppTgYLKa0HUBkfbr308+C8czOrTUP6WLJJRf+CVEW48ljb+sFv
         1vmSaL7H1nHSUjOuA4C5o4apHafc/4hZ446YxDm7SNHG4H+RxTFrVuOa9ITgy2+Rkclj
         LQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GG07+ZCqAyaOPMynhJMbBwk3HcuhahgAfWpVsrWg3OM=;
        b=Ps8lmUJepddgzDA94uPYTSpMoQuThC2JXVry4dn5lQBq598Zkp6CZX5kNQQsf3HB/Y
         U3CYbWSL+h9ZM8qAI9jtlAW/oObVTzEppnZa6EmX0uKDatCPEsHNTmXA6QvxH9foMtd9
         aoGTFQ0EdYGqhc4hDdqPleQpqw7DC277jAhLfeVlxxRbYEqi9LEg4jL8igHcjGftqpSk
         E1IwlQijJH7/ZceRhJM2Bi43seqfqTlJ5nXdhubZAqKlmdlIAp7FDXlOnFhfm5TK6UH2
         xAIyKcmOjOhvZTnXldznKoqH84LExzpiqolGzKxQ4sz1P6bLfK+sGy9uwbvE4AgvhFah
         ujKg==
X-Gm-Message-State: APt69E1nqB1czvtzR7CWBP+WEu0fWXGVmrA+ZFlVzSG1utj22/qUEVEt
        zIIjFgOI8OfhCG8TuXXCjps=
X-Google-Smtp-Source: AAOMgpfqrPeQw/ffcVgORbRSjOVI8fiY9fXm5ZK1zOhOjcijhCcnoanx4ZvL8gUdg291nbw+ep8wNw==
X-Received: by 2002:adf:9b86:: with SMTP id d6-v6mr375072wrc.240.1529997533198;
        Tue, 26 Jun 2018 00:18:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g88-v6sm2002669wmc.27.2018.06.26.00.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 00:18:52 -0700 (PDT)
Date:   Tue, 26 Jun 2018 09:18:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jan Beulich <JBeulich@suse.com>
Cc:     mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: modernize sync_bitops.h
Message-ID: <20180626071850.GC26761@gmail.com>
References: <5B30C2C302000078001CD6D1@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B30C2C302000078001CD6D1@prv1-mh.provo.novell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <JBeulich@suse.com> wrote:

> Add missing insn suffixes and use rmwcc.h just like was (more or less)
> recently done for bitops.h as well.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> ---
>  arch/x86/include/asm/sync_bitops.h |   34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Have you verified that a typical x86 vmlinux (with defconfig for example) is the 
same before/after?

Thanks,

	Ingo
