Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id n/g8MljRGlvZFwAAmS7hNA
	; Fri, 08 Jun 2018 18:57:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8A62C607DC; Fri,  8 Jun 2018 18:57:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eV8ALMw6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 052D0601D2;
	Fri,  8 Jun 2018 18:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 052D0601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeFHS5U (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:57:20 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:39126 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeFHS5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:57:18 -0400
Received: by mail-io0-f178.google.com with SMTP id f1-v6so17035226ioh.6;
        Fri, 08 Jun 2018 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbmgiceFQkHo47hoj3Ob7+rkCFXZ6eMCEMne9h6KXcM=;
        b=eV8ALMw6uettYzkBlH1VQWJV0w2TWFqmcfCHUvUUbdldMT+FfKQ0TndundvqEPCZwM
         jM3oqxRrZ5ZnXxrJDUtedEt9lEgTDcVOFmOU5/CMP61nHPBpYYKHxdURjXTOfQU2g5Dz
         +qnZmbh6NxygKpEJI0+Jy+pMyFRUAFhPqemtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbmgiceFQkHo47hoj3Ob7+rkCFXZ6eMCEMne9h6KXcM=;
        b=H6rpy3aCluxlSkSeZWJMaMm26d6VzMA9nR3I+W/1D3E450yp97JFa/e9kFnPAui7ta
         JPIZY3IzbvVJfW7aHvWAKixHY4iSjkl+LXTNVBDNirAy9Pj5sEM6GZU6y+AqFIAJYpOL
         Dl9Hk+G1mHNmqfWnCL4Odkm/FdewDU0sOwjp7uyyNuJDug9F2Sg8+Zx1S01sf8NjX75l
         WOMLyIbcmmaCeK5Niv2s2YR+UbDXFJ0cNyjfwiN3cdtEUWJkqbeCj+V3my5PVdMexWBL
         08npsPJSuojLWFII5BxPwNpm3p70PgkFvmcw5qfIZaVWH51qKNWYaZRvCYjymk50LUby
         5d4g==
X-Gm-Message-State: APt69E2LY8qSK9HhF3+H6SVNTM5r+CRq7/7GsQOvQinKn647Rz2swhzm
        KxEQO9DKlbDx83MpjXCWMpqZ/OOnHwUgCqmhoG7Bew==
X-Google-Smtp-Source: ADUXVKK7x0zqtx32zQMYvYIi0HlWwUHNgboUZE/XxIgDlmORFT6srlfR1E1GnjNE+64URwMEqr6x7AtR+p2IUE6FfyE=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr2954116iov.203.1528484237921;
 Fri, 08 Jun 2018 11:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
In-Reply-To: <20180608184842.GD30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Jun 2018 11:57:06 -0700
Message-ID: <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
Subject: Re: [RFC][PATCHES] getting rid of int *open in ->atomic_open() and friends
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm obviously biased since I asked for this, but:

On Fri, Jun 8, 2018 at 11:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  33 files changed, 135 insertions(+), 180 deletions(-)

this already looks nice.

I'll go through the individual patches and see if there's anything
there that raises my hackles. Silence will mean assent in this case

           Linus
