Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A2FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C720420856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt5Ujvvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeL1Vtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:49:50 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:38668 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeL1Vtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:49:49 -0500
Received: by mail-lj1-f180.google.com with SMTP id c19-v6so19667282lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 13:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A17ybq+TZw/qb7KMf3MfzOTfIS3m5Hfdir07TTq3aFM=;
        b=Jt5UjvvsDJZXgNN0d90bMcVWDu41i7sLXz97NKqn8eQG0AG0RYh/HTfpmbcfn7vDEw
         0xHm5HjUqZRic4Rn+BeejSC4SvWkb9q/4yq2Nn85eZPDJzdeVmWJQPxA/6QXTc7E8qDL
         7/Lee6BZo/9eqNLqnXU4oukcYzvB1tBjaLzf6M1Gd4RkViLgaGOUUsuznoEn8910mlTo
         fw7geAvj+CikTfQ7c/VsLZD4SMawHZVerhme+/wEvbv3WQD7BXglptvtOkgYMD4f8r97
         vkco/WFjul6Gtw0JfOJojfgmYShEfwyD3B2cJu6xBSYhe3x3qguMsLoDF/R0nws54+Nt
         baww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A17ybq+TZw/qb7KMf3MfzOTfIS3m5Hfdir07TTq3aFM=;
        b=sMSE1rTawpEoj2WvMdEi9l16dfOtFfR2JGyPlf9XlVlPtuEx0Lk65NHgxv6IB0ju59
         u5rFq2aqxpe8s7r4TRpk0XCZ/s/QQI1IBrm7xpK1kczlcuP41lkscCnQ0AhPxp2BEQ64
         wWszVK/MD85APgSrt+R8sht2bq1X23Lyix9fR0/Y2VK5omFaqlelt6+DrL7uBGjefl47
         viLLmTUoxfI+l0sql11QceX6FlSeK5Xy0S2CR3m6bHrGGocmfQvjrytC6pDrrPQajg4a
         kdqo8c3pBrqzy+wR6mSWUHiRun3v9r/fI8CH+f0WMJ+c+EeGwA7Ry/kP/Zd6gOida64u
         slhg==
X-Gm-Message-State: AA+aEWYipasec/aARypPgiwerMkF9rgDeTRXCtKozIOqG4OlFmIlESte
        nyd0heSOl0qFS8toxjKYIyDAVwQkTrk54a3Y4V1ggQ==
X-Google-Smtp-Source: AFSGD/WvpRWzMhQCvqlSanmQhtB2oy2bfG1qFF/p7oD63hTiJV8mS12b0SQwg/F1FT9rxIvZyEeJET/0v8KoDhEYYig=
X-Received: by 2002:a2e:4746:: with SMTP id u67-v6mr16550509lja.142.1546033787426;
 Fri, 28 Dec 2018 13:49:47 -0800 (PST)
MIME-Version: 1.0
References: <25ffdaef51fc80ac49f3d54d5245cd87@memeware.net>
In-Reply-To: <25ffdaef51fc80ac49f3d54d5245cd87@memeware.net>
From:   R0b0t1 <r030t1@gmail.com>
Date:   Fri, 28 Dec 2018 15:49:35 -0600
Message-ID: <CAAD4mYi572rWPcXZqw-5DGFDWKZQzBXVm=kUC4KsMqBBB8fZ1g@mail.gmail.com>
Subject: Re: Thank you for your insight.
To:     vnsndalce@memeware.net
Cc:     gentoo-user@lists.gentoo.org, ubuntu-users@lists.ubuntu.com,
        linux-kernel@vger.kernel.org, debian-user@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the response, though I feel you don't address my
question. Happily though, I spoke with an acquaintance and it was
determined that the subservience to the license (i.e. agreeing to be
bound by the GPL2) could not be offered as consideration as its
restrictions were not the licensee's to offer at the time of
acceptance of the license. The licensee had no rights to offer as part
of the contract, as the contract had not yet given them any rights to
give up. The terms put forth by the GPL2 are only restrictions that
are part of the license.

Furthermore, as stated above, it should seem quite self referential -
I can't offer my acceptance of a license as consideration, because it
is what I am trying to accept.

As I am sure you are aware, under US law there is no contract if both
sides have not provided consideration. This leaves us in the strange
place of gratis licenses being suggestions.

Cheers,
    R0b0t1

On Fri, Dec 28, 2018 at 12:47 PM <vnsndalce@memeware.net> wrote:
>
> Thank you for your insight.
>
> It is a shame that there were no responses. They ignored your post, then
> kept baying at me: "no this is wrong" "you're not a lawyer" "I will not
> lower myself to refute you with arguments!".
>
> As for non-monetary consideration to support an additional no-revocation
> term:
> Many of the old linux-kernel (programmer)rights-holders have received
> nothing, and have made no such promise.
> Many of the contributors (who did not transfer their rights) have
> received nothing.
>
> There is nothing to uphold the contention that they have forfeited their
> default right to rescind license to their property.
> They never made such a promise, they were never paid for such a promise,
> they never contracted for such, etc.
>
> They wrote code, licensed it gratuitously,
> and now an attempt is being made to both control their speech, their
> action, and to basically convert their property.
>
> Most of the entities who have been licensed the works have neither paid
> anything to the various rights-holders,
> nor have they ever contacted nor been contacted by the various
> rights-holders, etc.
>
