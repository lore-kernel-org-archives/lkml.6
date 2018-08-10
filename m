Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A980DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51342223D3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJL1JJBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51342223D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeHKBBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:01:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36487 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeHKBBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:01:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id h12-v6so5008332pgs.3;
        Fri, 10 Aug 2018 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xw5/XiW2Wca+UcjUAosEYBEvri+G6/ayQ5KAueaLLvQ=;
        b=XJL1JJBKD014+3/kidW5H9i/YBJbOcYXbQm/chPvXCYRQGcAJtfthxuSWbfxafwrLe
         C+DyKTXXILtSsSGu2k4W3UjZ/f/W3ILQKe7T5hB2LtkDhC5DqgsMqMM+8UwuFqlKizio
         o9b9bKC/68NYWa8PhIzPhLy32ZcIRlychyxjNQppxfR3uIvg2Lvtd5VfKBWHTGe8znR4
         DFAn4T7lZF+R9VBlq6aKp0Bjt3Uy+2fcE8FxVst/njGLZozXcbNUwLjdwRbWjxRgXZdP
         /0v3W4GCjjZJ/U5/hwVO9KWDOMPUQxpGe878zJ/KnFil8i0TbChm3uXAvcB9xPZqakV3
         cQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xw5/XiW2Wca+UcjUAosEYBEvri+G6/ayQ5KAueaLLvQ=;
        b=mqzsgPD9CS1Mv0ITbJjZYriS82YWyUDJsAzr2X+lwuV+dDRAmyKgDsi5nAsYhzuhvd
         iq+1CobKBUaGl79syHoyzfGn/I0QmH3YwTheqhWw6+AGYjt5RB8mXvoLGz/qI1sSr3om
         hnidVQ4epcLNWpIgYOLMJ5RKeytrz0NKdA8XYL8d1YnfhvMWUMWG7bXf+5OAjdu8jH78
         AP5IZITwl5ss8x+VY51jcDmV5Mn5D1x2zoKcqAyAtrmTqauyMKvieitaMZifuvNRoQsd
         LVD5qcZK0pHiZdpd01F3JafdA5u4dezimZ8Qw5ViYLkebPvZPI9mkumyOZzzuGFiQ0KX
         Cr7g==
X-Gm-Message-State: AOUpUlG8h6HLVdqS9VL6wqawcTsSPSVpXzattBQnKyze1oKeZy5IqLav
        oL9kQUcZC36uYIrIhLYwGaTnNpPW
X-Google-Smtp-Source: AA+uWPzMqk4JA7GqFFoilgAwRWb/fnRHsBfFawiKil/Xf1ym67VnaNlBvq1k922M/qhu1V/oRlacTw==
X-Received: by 2002:a63:ca09:: with SMTP id n9-v6mr7964831pgi.287.1533940195529;
        Fri, 10 Aug 2018 15:29:55 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::6:e23f])
        by smtp.gmail.com with ESMTPSA id 70-v6sm17613065pfz.27.2018.08.10.15.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:29:54 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:29:53 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2)
 command
Message-ID: <20180810222951.5g4ck2mur6mnwfkw@ast-mbp.dhcp.thefacebook.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com>
 <CAKOZues6SE_c=ix7ap6QaJHqd1TmYpWWMJiu3=TtuqgKuqOUCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZues6SE_c=ix7ap6QaJHqd1TmYpWWMJiu3=TtuqgKuqOUCA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 10:17:50AM -0700, Daniel Colascione wrote:
> Ping.

sorry for delay. have been off grid. let's continue in the other thread for full context

