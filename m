Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E5C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E283206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSl1+qml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E283206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeKTSxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:53:36 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:37748 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeKTSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:53:36 -0500
Received: by mail-io1-f41.google.com with SMTP id a3so767991ioc.4;
        Tue, 20 Nov 2018 00:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItsFuh9qLalskdwwc1EzGsSkdgnBDgmaIBMhKLTUYjk=;
        b=hSl1+qmlUkMIOTZ4NpjYhWyqfKFABq2huu51/9LR83HYFktO1teupaW1XJO2KlzDjZ
         dwgfIb5nM84LUd4RAtA8aXvcZX3o0eSgAjXWXJJQLLL4OcQhiiT4zfus4lwWmBedsldy
         otoqhS+Dwcg7CgMMEvh6P+aIpUugmzbXL8RIprtPUf30kLAvcVnjc/3lmdUbXoyV6cXN
         ARFBLajWif91X4AmFUSBAIE/eNM6+DFKYTArMBu6G4GNcW8/xPmNuTMsb3nyU1InzTMf
         I/WcE0YqcZnuI3Vs/N+xNYVw874uxp1ovc1b5EORxLiGGHlB0vg9xVDlRSNTkqYLBFS7
         bhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItsFuh9qLalskdwwc1EzGsSkdgnBDgmaIBMhKLTUYjk=;
        b=unWqR9Lq6X0FviRKNsISfTcGoY8NytHcfpzCHS8AzFBm3J4LT65uTcAQ/pzLkk0buB
         lDwXXq5E4xJlb2xFzMkqZOBm0YDDc1U3lRN4+0pmnpNZRh/p5WmXV8hQMJxNgnqR0S4y
         aX1dCBbH2LYxOI83jkZBtbVB2bxDnCGDaxuybw98+qk6O9h/NTnaJcRYcYuIfarXdZEm
         Dopxx3qUP7Azt5h36LykPq1QH5NKgdOAYV18vpSE8c91DMvuYhdgmyE1F5PuYp0RfjUA
         wrmEUjrb3caLeLLmOmgJ9HA+Nx0rwjkd9q+sff+aqsJP1LAm0R8Zkuga6mCK0MZDz1zQ
         hPtg==
X-Gm-Message-State: AA+aEWanB12+7AUxaZfv54Zs8mLQVymj/t/7gDBMvL30pizqkc4YyU0a
        NmmKnCaqxZqG6Zs33sQjvhMAHUzGXT5SUCojYg+Hjg==
X-Google-Smtp-Source: AFSGD/X4OHM6OjO6fFpRRTFw5sA+R5VlnRS9N+OGsgwapqZPLbtqcYr1b7zTFPZaCWtAlSpKAquWRK2+BIUYcknOXYQ=
X-Received: by 2002:a6b:5b12:: with SMTP id v18mr858868ioh.157.1542702342234;
 Tue, 20 Nov 2018 00:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20181120161546.1098b346@canb.auug.org.au>
In-Reply-To: <20181120161546.1098b346@canb.auug.org.au>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 20 Nov 2018 17:25:30 +0900
Message-ID: <CADvbK_fBH5zL6H+j3vZPT3BuG5m0_tDKJ=YUzEe5PeMCz4y9pQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     davem <davem@davemloft.net>, network dev <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 2:15 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   69fec325a643 ("Revert "sctp: remove sctp_transport_pmtu_check"")
>
> is missing a Signed-off-by from its author.
Hi, Stephen, sorry about this.

David has reminded me, and I will be careful next time.

Do I need to do something for this one now?

Thanks.
