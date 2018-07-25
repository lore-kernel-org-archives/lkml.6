Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D779C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D748A20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK1z1d6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D748A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeGYFRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:17:49 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:38800 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbeGYFRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:17:49 -0400
Received: by mail-pg1-f170.google.com with SMTP id k3-v6so4350638pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 21:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m+8DjOv/eZ7vSrNIzumwemN3JheG531Da1XZklPrXKI=;
        b=qK1z1d6ijdPO2gqgN8YMWtocsx0/aJdMeUUaLU14vC5EskQ2jbBPPt6mnwS3Ah4Sxf
         4BlXsSp/Igdpz+WSkH3jdgdZvlwuGAJNMOK7Lgj8XwQRDEH3yOeka9IpzZ50NST8bru8
         LWZxksudUnCE9TSFveYPOmMTRYqNf4EcbHjZlzgHmDwLUy9YIYlT+Ja9OQsKCA1Gljn4
         a8EJeG743pZaURiqdm4tSUWhG12lI0RWJc2BURlu3OU89DQzvTV46A3zwJCjfEkYLMLI
         uyD8Or0ugnd3/LLTCOZFIhH83J316JsAPuOswehx13x4r5WLanT6yuLzRdDc5CMy/JKu
         0N3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m+8DjOv/eZ7vSrNIzumwemN3JheG531Da1XZklPrXKI=;
        b=BPL9fek54gR1eInz2BX6D6dsA4n2wBY4tr1RhNl2R3eWXtBbzznEJ/othN7GmH92qO
         LVyrGLwwIH2BgNFOxmOhTksDFDGmHDvsUd4iS/6zN1uS8JG/DvnzGuiELdgdugdkLb71
         YNOuw71QLdsSLRGPBJMTsohcSB+SJExWTIe2ApBAXEU6XN3X0pOSde4+DvUlCA7Z2SNB
         ijXEE3uSHP1fG3rAafK4OOR9V4lRxcozHOyfL45qjd7U5SKVF3qtgOA6szH6oR+vTD0D
         3mjXjdUVrqPPC8dW9z5pDJssQ2ovSgWNPLgXefgPQW9JmXJwhYEfwnrYKZDAfbda2eOL
         YlzQ==
X-Gm-Message-State: AOUpUlFAgbOMSFwIsjHTZTddxwhnHXamV3FpQLBtev3bUfwdAaFrcETG
        yUHhGhgYU6BUbNtjcICQZ3w=
X-Google-Smtp-Source: AAOMgpc8IrMv127Ckg4o4EuE802Q1M0vXbvTa3MP0ukoJUGwM1MSvNHW/D44mXVDdK761TncjLRFKQ==
X-Received: by 2002:a62:5cc1:: with SMTP id q184-v6mr20487722pfb.241.1532491684022;
        Tue, 24 Jul 2018 21:08:04 -0700 (PDT)
Received: from localhost ([39.7.58.253])
        by smtp.gmail.com with ESMTPSA id a15-v6sm21087999pfe.32.2018.07.24.21.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 21:08:02 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:07:58 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Tino Lehnig <tino.lehnig@contabo.de>, ngupta@vflare.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180725040758.GA616@jagdpanzerIV>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
 <20180725025124.GC16271@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725025124.GC16271@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/24/18 19:51), Matthew Wilcox wrote:
> 
> Also note that this is in the allocation path; this flag isn't checked
> at free.  But it is cleared on free, so someone's stomping on page->flags
> after they're freed.  I suggest enabling more debugging code.

Would be lovely if Tino could bisect it, perhaps.

	-ss
