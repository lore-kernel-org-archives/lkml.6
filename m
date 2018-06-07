Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jAkGKKXDGVvgSgAAmS7hNA
	; Thu, 07 Jun 2018 23:45:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7AF27606FA; Thu,  7 Jun 2018 23:45:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj663Cye"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ECB44601D2;
	Thu,  7 Jun 2018 23:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECB44601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeFGXpi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 19:45:38 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33627 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeFGXpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 19:45:36 -0400
Received: by mail-wm0-f52.google.com with SMTP id z6-v6so5028975wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 16:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GNGp007zxEZhp+oAKiY/7RKjPqYwce/vV7W94kAW8mk=;
        b=gj663Cyefw3SYI2u+GdMWeZ4PS/A/LQfrng2ArPvR6TefD1g4SVMTz/M4DM2fOdkcR
         sYHmYKUthwaxjJ21v7k/AccvWCfUnCXCJfSRlgreN95WDLW8/mz9meT+HskTyQMfPfPK
         i7KTaPngTA9Z9JzUPOErGE7mOcwRJE/0O+TiopTOTV/rCcXMzXxrQnGUG2TK7Lkm5LbR
         nrlxuyeOvRyuCFDd0HkEGpGPchNgStPmZsi/2GI48loJedyyajKVWGSoOoL5ZeJnoDGc
         0+WH4y8Y/QFR6iw4jAMKNFKf1xzVEuz+bOovK3tlGJhf7xoaztNRN7DeKctCtO9fZ2Zm
         mhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GNGp007zxEZhp+oAKiY/7RKjPqYwce/vV7W94kAW8mk=;
        b=p5E8ePMYWSGqJo0vCVeZAXGq39XqZn5fAYUtyPq9kSFbW+UQP06IrfRZ1bmy3nQbsO
         vvY/rgmqbNNvg9ne/sMEIiwZsqNdtm8NTrgg7MJFHJ4dwCpgSm6cMYEqyq1akyb6UXul
         l3y1DtiMRckrp3vtuStbcNLeB3kED+f9HH4vleZOibD4q6dTgvSuf8iPh+B0UoRgoMB2
         MB4AKDpdUBjrl9XG8YO1vbYhN1i+kkH+kczOS5lw2KM3WgWH2DsvOk3aGiqMvyjIApJc
         V/evI0XQtgpGbm9U9j38xsdskjfQ+574MkFZ4tPQgWjmByH7rB1YrC3o9L5C+InlFHSi
         mZGg==
X-Gm-Message-State: APt69E0xzfSnkTf0WY5evOWlI/dAKC3llPbzYC4K42iwJZKFvnA41lkP
        VtOHC+a/JWvjKP5pSBdebzMlDQUx
X-Google-Smtp-Source: ADUXVKJFqRljn7/2wYGGISBM6hc8qhEeqoA5/IrSrI3URLZIzL9U32SPrPoLGP7B0ljrpUNWHNmReQ==
X-Received: by 2002:a50:f190:: with SMTP id x16-v6mr4497493edl.59.1528415135827;
        Thu, 07 Jun 2018 16:45:35 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4108:7200:48ec:50ae:df82:46f4])
        by smtp.gmail.com with ESMTPSA id x2-v6sm9507160edr.24.2018.06.07.16.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 16:45:35 -0700 (PDT)
Date: Fri, 8 Jun 2018 01:45:34 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>, Miroslav Benes <mbenes@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: sparse warnings in overflow.h
Message-ID: <20180607234533.nfdxd4cqiygahfms@ltop.local>
References: <alpine.LSU.2.21.1806071258310.7958@pobox.suse.cz>
 <CAGXu5j+XFR7BtYPU6G4CeLFREWevN+GC1FPX1hPAYA1LRBM9Bg@mail.gmail.com>
 <4d2aaa98-1655-3ab8-8ce8-bf4b9c7d2dbc@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d2aaa98-1655-3ab8-8ce8-bf4b9c7d2dbc@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 09:25:09PM +0200, Rasmus Villemoes wrote:
> 
> IIRC, the problem is that sparse pretends to be the gcc sparse itself
> was built with, which is obviously entirely unrelated to the C dialect
> that that particular sparse version groks. Sigh. Ack to the fix above.

Yes, indeed, and it is sometimes a problem.
Ideal would be that sparse would pretend to be same GCC as the one used
to compile the code being checked *and* to have exactly the same features.

Pretending to be an older version of GCC would maybe solve the present
problem it's not really a general solution.

One good thing would be to not depend on GCC versions to enable some
features (but GCC offers few facilities helping here).


Best regards,
-- Luc Van Oostenryck
