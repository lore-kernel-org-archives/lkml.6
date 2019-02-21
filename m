Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBF0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FD52086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAGYpFw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfBUBr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:47:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37061 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBUBr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:47:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so12908872pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 17:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fu5FhGF59R4aUmLm0zhhX9vBkIAmS/WbdEnqus1WefU=;
        b=QAGYpFw2Xuw4dJ5aVRAqbmnOW6201yd3fYg5LI5sB66A4+21tCcN/bZa+nY+MWzC8D
         AScm9TuHmn3gQ1YOu9/gt5t+kVgZb2NXx1WU56VZw0gXDb8lQLEZPQpemGzS+975+5G8
         lJZxOuzssVJoG32on5cHQBu5hZGJ2CL9NX1gf1kpPiqiLbfZ5wZetX4C6EVo8tnLVT+R
         S9M4C9+ZRqJQuK4lwT4sd6egsQ3npalKVw9vZfbkUiz9ozlmQRs3PmPohijz9kipHvG4
         GwR1QNFhZ+DiLP46UKLqEknyePbxQFClR+uyNxbtit0JpUdy9D6BxzZDrtvOcMRS73Hn
         vBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fu5FhGF59R4aUmLm0zhhX9vBkIAmS/WbdEnqus1WefU=;
        b=tWUn58kGBbUUp1gHpIXhYqqQtaZnxtv6wXdzTKeOEAaOFaQazmdhhMR30XdUn1F6q4
         2PZX6afANr8QOR+vn/ZOMiZecmMw85q7qkdJu+enfGy76mrn+aCnJzdljPYxrwGyaQsf
         A/o5iIHl5rwQ2rHDAbWYcVqADdO9Ekp5NkeoZOJCJTXOiyeVC21hdCDzBr2sZ3j5Yz/W
         skRxrc8wVrMPckDsTUS51drX4MkMJP/HA7cJq/cv1/9aM0RUI8lmKDs65URmIW96eGiV
         dKV0kjbP5ByeXnNxTevyvZ4JrYxZI4iI+YImOvjxk7NGU1uzZ1xSPySh9Gym0bN1ncuj
         VXUA==
X-Gm-Message-State: AHQUAubywVpCDmbOmXR/wVRUETLZbmg0JZO+wDTCVaGCRvK06yGV4mRP
        LyiLZqX5yzDRb3yQD84sHvE=
X-Google-Smtp-Source: AHgI3IZqoIeFGVWmHtHVHB9KjoexaUqF4wza2FbLGh+w7YPcf/Yq3V9OFwfYZJwzKYyENxvQ43kHNw==
X-Received: by 2002:a63:df09:: with SMTP id u9mr35665373pgg.299.1550713675809;
        Wed, 20 Feb 2019 17:47:55 -0800 (PST)
Received: from localhost ([110.70.55.83])
        by smtp.gmail.com with ESMTPSA id s1sm17076884pgv.30.2019.02.20.17.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 17:47:54 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:47:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 9/9] vsprintf: Avoid confusion between invalid address
 and value
Message-ID: <20190221014751.GA448@jagdpanzerIV>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-10-pmladek@suse.com>
 <20190219030300.GA640@jagdpanzerIV>
 <CAHp75Vckf_aJqpK75-7xmN-u3aVs8nUrAOWiRzSLP5Gh3uHUEQ@mail.gmail.com>
 <20190220092425.zgwbvbskpd6zss7r@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220092425.zgwbvbskpd6zss7r@pathway.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/20/19 10:24), Petr Mladek wrote:
> Well, better be on the safe side. I'll move it at the beginning
> of the patchset.
>
> PS: I am a bit busy with some other things. I'll send v7 later.

If this is the only change you are going to make then I'm OK with v6.

	-ss
