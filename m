Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A54C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CF821473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PPalrHoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CF821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeIXFbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 01:31:14 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40267 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeIXFbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 01:31:14 -0400
Received: by mail-lj1-f177.google.com with SMTP id j19-v6so16600311ljc.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 16:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvLwHwM9hxFAdw/QrpKA/KQOe9dZ9N7qjDamXE+LX4k=;
        b=PPalrHoCBlaqiifvig9/v523wKEp8++NEFNPW0WLL0Og0Rd2i6TKv2yU0r2oVot1p/
         VcrOvf/Xp8mhA1WOZRnleL2w22jqirljAKSnLpvE8ZYgPkQnc0+vkXGDxV2kCZMK0mec
         ZFSoi6agFCbjne/f5JwBM9XWbUCSV7McC87sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvLwHwM9hxFAdw/QrpKA/KQOe9dZ9N7qjDamXE+LX4k=;
        b=WKHLpv6MTku4NwIE4k3o7hon07JtCEL8xLw1C71sWYQioLazyhaNKtZxCHo7uM6Zff
         eYIUPweqoNwmYRUwJY0VMWlq//qlVEBOd6XGsOx9h4fCvnb5wlmqoeVQV3m0y2g87s2/
         ViFL5fk/b/oXgaZ3al9vspbnuqLnVf37yKgMxJGptWfLiMlTxPoTrQEZmquBOpowOK1B
         5kq/6wBC6sPOxLIFMYxU2Wm0ACcCJvATdWV8ESzeEwnTkkgiu9JYdOnwkCvMELkT2Lut
         LslOPq06NEqdah0sCrTaeoRFG6hRuHdfTV8q9K4KqmD8cydgkakhDsM305OV5issb1VV
         Wx/g==
X-Gm-Message-State: ABuFfoiPoPuBRHfyanNlT7e9kRNEmjeZkkziHEL7/+g1fJgk8YqDG1BW
        PPHrVW1cVHzKMZEGl8ERgtLswuZd5FTvKigU2TUaAQ==
X-Google-Smtp-Source: ACcGV61Uw+mgbw1KliXhqV75ez/UowEvshPK+7EAZfGcMLhTh2mhbHK6NQrTpQKnyXsSeYwM0WlkQPNUYGYPIDbA+0o=
X-Received: by 2002:a2e:8098:: with SMTP id i24-v6mr8479507ljg.36.1537745509177;
 Sun, 23 Sep 2018 16:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YQd8s9GP-TACJCbT67ZCy5guTJMW+Jue3VsEX1777UhBQ@mail.gmail.com>
In-Reply-To: <CAEXW_YQd8s9GP-TACJCbT67ZCy5guTJMW+Jue3VsEX1777UhBQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 23 Sep 2018 19:31:37 -0400
Message-ID: <CAEXW_YTv2wFoaVW-1yv_S5pRo85Tiad-B4u4EaYBdCx5_KWRkQ@mail.gmail.com>
Subject: Re: Question about ->head field of rcu_segcblist
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 7:30 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Paul,
>
> I was parsing the Data-Structures document and had a question about
> the following "Important note" text.
>
> Could it be clarified in the below text better why "remaining
> callbacks are placed back on the RCU_DONE_TAIL segment", is a reason
> for not depending on ->head for determining if no callbacks are
> associated with the rcu_segcblist? If callbacks are added back to the
> DONE_TAIL segment, then I would think rcu_head should be != NULL.
> Infact the "rsclp->head = *rsclp->tails[RCU_DONE_TAIL];" in
> rcu_segcblist_extract_done_cbs should set the ->head to  NULL if I
> understand correctly.

Just to clarify, I meant set to NULL assuming all cbs were done
waiting and ready to be invoked.
