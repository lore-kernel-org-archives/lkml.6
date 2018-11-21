Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8A6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB42214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a2poI+oF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB42214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbeKVE2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:28:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34336 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbeKVE2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:28:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id f12-v6so6545202plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qgMvH87QAjl4XD2K7wrH+sqH5+4x7tieqakBo8nZc30=;
        b=a2poI+oFhZrTF1RUm8nEob9c+H6237f1E5QRH1dKUY8M7hwGp935B/MrvBeIMxLmEZ
         wwEBlXhmiq4iI2S6Xi2FYdw3XmxQyMa9eVo0iNqOZANuAggHDWgGcTbARKd0J73ohrHE
         1ZNsap9C92tBJd5Htm7dnUW7OA1JAkM9ZTQYbUu1W3VErDxlhAjGyFxkErsHET6IglBd
         Iro8JuJLZYoh/NZ+Tm4iStyVQBnpPjv7BLgZOXehohbJY4Z+VRdR+KErYSFgLRXMChvW
         KkEk0eQs3nYnY4j2PhYSijjX+HBNjoR0PMPQ5R8zOHdlJFiaB7v67FnT3FZe6UptngoS
         XAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qgMvH87QAjl4XD2K7wrH+sqH5+4x7tieqakBo8nZc30=;
        b=Lh/CujnPsCELhDCgE7yqVY2aaE4u9cucEHPD5au01v+JHzGlsMhBWg5twvZJm+Ujh3
         yRUsh5xkK/QJA54VsZYLXkC6sLQJtyoFJwrdf5kYmQVNaSW4fHfOd8QULgyPgIjmgR+L
         KcSeQ6I+B549Dk/DtuQE7sGkrBpgDfZvdvWrUSY0rZ/TFs54dGdQ1MBZSjR/fbcJwJ8y
         ghnTABQqQx+FGDNiDKD812asNESKxNXwl51Kor1ofPrS8pDj0+q/TDUiyIfYGJaEoLm9
         qySLUFVxR9SUA9m+jG+K+gjJR9V0QKj+vzb8G4rTxIBuGOVcC0fwDOmQPV1SMZSz+eo3
         XCpw==
X-Gm-Message-State: AA+aEWZ/fSGjrx2xrdXZVqBoUbJyUOcwv+TIt/lhn3NMKf9bRJg5Ndzg
        WjZ+eWf/RK98zjcySvtWs0aWNnqE1g8=
X-Google-Smtp-Source: AFSGD/WNOOw614oNbnqKYwwJ3VhmPlsJ/jUJWqMUtD1/okfElIw0oEYBdpppk348sLQpFtBIOBOrVA==
X-Received: by 2002:a17:902:227:: with SMTP id 36mr7849818plc.140.1542822774623;
        Wed, 21 Nov 2018 09:52:54 -0800 (PST)
Received: from localhost ([65.158.186.241])
        by smtp.gmail.com with ESMTPSA id t3sm26220875pgv.31.2018.11.21.09.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 09:52:53 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Wed, 21 Nov 2018 09:52:52 -0800 (PST)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     paul.walmsley@sifive.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, jimw@sifive.com,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] modpost: skip ELF local symbols by default during
 section mismatch check
In-Reply-To: <CAK7LNAQqpzJcxZBvZY1Bd2sVUwTLg7eD2mq61hDOw6Ek=akdfw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1811210950100.18372@viisi.sifive.com>
References: <20181115005602.30746-1-paul.walmsley@sifive.com> <20181115005602.30746-3-paul.walmsley@sifive.com> <CAK7LNAQqpzJcxZBvZY1Bd2sVUwTLg7eD2mq61hDOw6Ek=akdfw@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masahiro,

On Wed, 21 Nov 2018, Masahiro Yamada wrote:

> I think this is almost good.
> Just a nit.
>
> Maybe, putting this check in secref_whitelist()
> (with a comment "Pattern 6:")
> could look more consistency.
>
>
> Also, if you use strstart() helper,
> you can remove is_local_symbol() function.
>
>
>        /* Check for pattern 6 */
>        if (strstarts(fromsym, ".L"))
>                return 0;
>

Thank you for your suggestion.  This change is a definite improvement. 
The patch has been updated, and I will repost the patch after it's been 
tested.

Best regards,

- Paul
