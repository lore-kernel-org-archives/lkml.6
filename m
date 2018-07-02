Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A77C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD5E24E6D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fm3RNo6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD5E24E6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeGBS3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:29:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37101 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbeGBS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:29:51 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so13239867itc.2;
        Mon, 02 Jul 2018 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWtTfyxfywAo7n/32HCZyyBRckK6j9GaUc3q+XeReGo=;
        b=Fm3RNo6S46lYut2Udh8uEpMTYTykap96dFsJZ7vkMFOzUmKkIHSLSM+vz1cT/V97pe
         iXmmMx8ogFg6qo3yjOalN1YWA4xHml+QyUAIC5FWG9bKjyXjj3EtJqtC/210w1tY1mvx
         alSlLlLskwEm6fQer8gu3sZ2ByRMuMupRx5LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWtTfyxfywAo7n/32HCZyyBRckK6j9GaUc3q+XeReGo=;
        b=TTGAhipfh9oVsIiPM1nQypjmcuCqkM+UcWsNLMyJq8yECml00ZHuz4IYsezE7odhl7
         K8TO+Z58d0vSzI7AG/zzpGDTUrfQw6SoRChRZowoQL/aBbo0AN6GrSL/wJzzW4QADtr7
         np7uQc+wSIhJc7a6+T9Efu7TT7CFt2V5twL1FkktmrJHZ5xNHYMW2ZICwhw/8qg98BFS
         boJ+cr5HazZdb5SZMbbSRiOwoQz/Y3rBG8vrzRYo4qD6wwJGYIFhudE+grp5dYv66SOw
         2ylzpliwA4gbvvK7UfhtQUzlPp+Sm0YkJNWSYOKFGH1SW27m/c7LMsCi8lgllm6N4RRA
         G2KA==
X-Gm-Message-State: APt69E0V89OLNbVivlsj5azKyQy9JUEJj7Jnn0eJvIdFrt8xTqGKXLi1
        TDL2djFePICGLnEWICrChoeRI3z2tWiD85BgzVLdo+nN
X-Google-Smtp-Source: AAOMgpfnyab5CKJanNA1+d/Tb9u2NCJyGEdmhAr1tm2Bwps3NK/aWAWaRBwGQLyPh/9ll+R0QxiPF5b/apdsH/3fyF0=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr2104909itm.113.1530556190929;
 Mon, 02 Jul 2018 11:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180702.220348.527254946062449999.davem@davemloft.net>
In-Reply-To: <20180702.220348.527254946062449999.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 11:29:40 -0700
Message-ID: <CA+55aFw4+YPQUh9RTJBzxdvJ9Xf_s4soPLbCXsXuhHT0TjPtZw@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>,
        Ursula Braun <ubraun@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 6:03 AM David Miller <davem@davemloft.net> wrote:
>
> are available in the Git repository at:
>
>   gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git

So the af_smc poll fixes clashed with the revert of the commit that
caused those fixed to be done in the first place.

See the changes to net/smc/af_smc.c in my commit

  a11e1d432b51 ("Revert changes to convert to ->poll_mask() and aio
IOCB_CMD_POLL")

vs Ursula's

  24ac3a08e658 ("net/smc: rebuild nonblocking connect")

I (briefly) considered just dropping Ursula's changes entirely, but
they looked like a nice cleanup on their own, so what I did instead
was to try to fix up my revert instead.

That involved removing the release_sock/lock_sock pair around the
->poll() call, and removing the special "sock_poll_wait()" that got
re-introduced by my revert, but that Ursula's changes seem to obviate.

However, while I can look at the code and say "my merge makes sense to
me", (a) I can't test it, (b) I don't actually know the rules for SMC
sockets in the first place, and (c) I may be just incompetent.

So Ursula - mind checking and testing the end result? I _think_ it's
fine and the merge looked pretty obvious, but maybe af_smc got broken
again.

[ It's still going through by basic build tests, so I haven't pushed
out my merge yet, but it should be in the usual places in a short
while ]

Thanks,

                Linus
