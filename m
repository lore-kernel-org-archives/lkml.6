Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B20ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F9C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F9C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbeGTRI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:08:58 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34945 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387900AbeGTRI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:08:57 -0400
Received: by mail-it0-f68.google.com with SMTP id q20-v6so15322358ith.0;
        Fri, 20 Jul 2018 09:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54CbYhnUCzA+CMLmvUIoNzFS+z5H4vNVCMSBgfR6YyI=;
        b=rM/v9N3cCHzDd6gqb+tezoPvt0t2wAsiQp9SKpLfl9k0LT/fJE2EcaZ/Pl50eapMTU
         tlNiK3mCGr4UcggbUpAUvbKu+rL4JQJ7hDnY14JzW0s9JPGIoQM+Ld0oWCKPNdUsAmEG
         dU2QAbl8Nqwseyj0hnsEAt/N2ZNQ3gITer7GH53nDOgjEnqO9BJl7bLYCT4ciQYYwGPz
         G/xB8uq53zsALE6on4mj/QTvpjcYWEsiSqNejcxMUHjZ+BsyLunqLm/LBPzR2KKVjRZP
         U76p+Ei6q8LXBJyJDZp0gzsLZl0rMlFuz1eo+T3SoDtHZjJDik3vguLpZhyTuq15OG2r
         ebJA==
X-Gm-Message-State: AOUpUlFDIUQXIJRYN+CsXr3dvgSTuJCuif+JDs7rtCjGZMzOGmf67c/z
        OYgsYgPlkwmQj71nME8RfQ==
X-Google-Smtp-Source: AAOMgpdz82moPJDOgaXdGcEJ+D+hZcX9f4Ed/eDJnQPWmJGoFqv/DEQGG5UxvRcf80znUz6FnxXJGA==
X-Received: by 2002:a24:918d:: with SMTP id i135-v6mr2326929ite.98.1532103598138;
        Fri, 20 Jul 2018 09:19:58 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z71-v6sm1848361ioz.34.2018.07.20.09.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 09:19:57 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:19:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: snps,designware-i2c: Add clock bindings
 documentation
Message-ID: <20180720161957.GA3486@rob-hp-laptop>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-2-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531731553-22979-2-git-send-email-phil.edworthy@renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:59:12AM +0100, Phil Edworthy wrote:
> The driver requires an undocumented clock property, so detail it.
> Add documentation for a separate bus clock.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
