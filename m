Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E570C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D834E20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZW6f/Uz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D834E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754326AbeFSWxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:53:16 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36867 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFSWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:53:05 -0400
Received: by mail-it0-f66.google.com with SMTP id l6-v6so2847686iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+f3hyzJ6fnWtOc7BZA2jtOeyYZSB1/c1gOuaJFJ/7A=;
        b=ZW6f/Uz6rDQ9oEUbzajWPtXWehZSb7+npKgdqeQydBdbQEyQBNvL2PuCxrZl3QsUaj
         ZEdKEl1iGPLbeWyU3PsXtF1q1b/z9nvP2Jk5aCRIcG+ctLqhl9WcmYpU1tCm2N97N54m
         yEsf0/+tdTHubhpvTDU0jau7w0JYxYsemZYXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+f3hyzJ6fnWtOc7BZA2jtOeyYZSB1/c1gOuaJFJ/7A=;
        b=GyePlRllBjTyHU/sEnh7eIRguMHMlXyOLk3eS0VONsdT8gO5lBXkPX0vgD5oPVcC5a
         pDlrQRfbCXbcMqmSikbQaandQtlvx/2DghkOD+HNM/fU7HaxzPv7UzdNfiqCMHqq9u7J
         COD2rg2TsoRTO1/ZMeFL7RL7ELIutWoJ5dd9as/SwpN8shKiEt2YzMJeMhyOU2wRXv19
         2wJitFkdddInaMajJ4vpzkr1WBBFyr/LExg51UdHSl8AYiMOy3rE02K8Y0lkiKbukspP
         SMli4bf87OXfveQxjCc6FDrnDjuGC2y1Tx0A49Z1s9BzW+qgVWOwo8Cs3iBA6C4yoxcH
         1xYg==
X-Gm-Message-State: APt69E3FnVscRhQZPNDMC+1GcPij7LyC+KCG5ma5NqoymW66ss/fp4Gx
        2beHK2YKg+Q99NMcGWgD26XTYWxB/6NdAxqqdug=
X-Google-Smtp-Source: ADUXVKIBeavlpTZl6jD5FyzklnnP77f5Ea3yCtyQYJHsTP0D0IuMAuaJKL+zXSRLGbWjA02ndoDdHYZs0QDTWb3IgFo=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr14344262itd.16.1529448784441;
 Tue, 19 Jun 2018 15:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180619044358.snyej666melspv46@infradead.org>
In-Reply-To: <20180619044358.snyej666melspv46@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 07:52:53 +0900
Message-ID: <CA+55aFwEZHzxXDdUGwwuw5HYZB9R5CfTv3XKbft46+ai7C_Q7w@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping file renames for Linux 4.18
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 1:44 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> below is a rename of the assorted dma-mapping files to that they live
> under kernel/dma and lose their dma-* prefixes.  If there is any time
> to do this it is right after -rc1, so let me know if this is something
> you'd take.

I iwas going to take it, but then I noticed that it's an unsigned tag
from a random site.

Yeah, yeah, I have pulled such things in the past, but  I'm really
trying to convince people to use signed tags.

I prefer signed tags even on kernel.org, where I know the security is
tight. On other sites, I really want that warm fuzzy feeling of
knowing that yeah, you actually put that code there.

             Linus
