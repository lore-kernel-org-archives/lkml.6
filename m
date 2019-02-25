Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CD020663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2GsBbpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfBYOro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:47:44 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:40594 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfBYOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:47:43 -0500
Received: by mail-qt1-f182.google.com with SMTP id j36so10701718qta.7;
        Mon, 25 Feb 2019 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T/9QqGTYa8nXnCeDMrKImFAWHaBr4lxk3AhsZKbb+AU=;
        b=B2GsBbpTLJ16Xrurrrh3KEqq2PBJbBG5do7Si/kPgSGHO1huDrpRfK3MSTtR/Lh16q
         wte5U+G4PyvaQa2ZSEm9LO3X62K4flLQM8ztn1giVQxVWKjx8YIPG8kU0dhtdZoTEI2u
         dHZu0xlrmtoiFHkz67zRDrELfJ68y74UudL0pD0PlQsMbD7cOm5LjHsxJ9+oZLfeZ1vR
         BDM6o05cbcpjwvViJbCoAhtHMYzQbD0JeeFCZQ9THjHRNGMztYx8be5BpaTCW3d8M/AU
         vO5PpZyxr7w+i0ur4CKvqy6vxqnWJ9ccLEZowNW8x4Zu3gNNebam2Nsh+j/zN27L0T5Y
         JJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/9QqGTYa8nXnCeDMrKImFAWHaBr4lxk3AhsZKbb+AU=;
        b=ZlNIr7snQb5V716W2nCCPihdVveli7/35RDHfdWZ74sRkN1TBNy0us9DQgxCangRxg
         Cka5JxLkRzM0m5dGQIUBNo+B5kSSXH++vggXQM0zXEBXWC9MXPQeiBh/6Nu7sbAtNTXU
         YLahSzGQLSIKoqMHqfECGYXWOhBBkcmxumHQjxV8B+FuSP/mlfVX8kF3USmXHfypSWPR
         nD9DGP4Z4Z2GnTtnyPUonK9S8XDar68MftJ9gCvP1Qj4tZR1817BOnwtbzV6Fg5d9P/N
         hgLfL6WYHwA/LTZSy9Yq3GGOW7qd+GI/AzxM0yby/kd16SB+NB+0DN1HnPZW2hWgjeEZ
         xkxw==
X-Gm-Message-State: AHQUAuYO0L2yFgJnbIg++doEgExbb9uhiIEzZibYVoEpUIorRa3e0qsu
        dY26WFkQFl85iz3LrUETK1A=
X-Google-Smtp-Source: AHgI3IYQ0vZOu3PuEQkNBbEbpT11BBcCJGQFkMfMTfbLhUACNkSBvZAWWs2nXRSyI7WFXIz1tlvG6Q==
X-Received: by 2002:a0c:8889:: with SMTP id 9mr14083685qvn.122.1551106062758;
        Mon, 25 Feb 2019 06:47:42 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id t123sm5098370qkc.6.2019.02.25.06.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:47:41 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 272354039C; Mon, 25 Feb 2019 11:47:39 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:47:39 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/15] perf script python: add Python3 support to
 syscall-counts.py
Message-ID: <20190225144739.GM31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-14-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-14-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:17PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the syscall-counts.py script

applied
