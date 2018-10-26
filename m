Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE61ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238C820868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkO369SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238C820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeJ0C62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:58:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41974 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeJ0C62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:58:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id u21-v6so1996735lja.8;
        Fri, 26 Oct 2018 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T56q1WFOtYNSeaP64ZTRRqTdS6w1Bc+ijJta1+x82Qk=;
        b=XkO369SIZ60TFFWgesTcdetuDj2QB7WRtVPtpTB4xytqLmNAIBrZn2x1EnQjWSEfee
         l+Sdg9H0MI7wqmFl4ECVG7UIIr3SYv2PdgFqUiGzLDXgAk5UmyaWhy5zgCt8A7WNJSuS
         tjEP0fj7LXmQP5dAbmsM+Vzq78z9qermJUJCcs2tVId9tO8YYcA1eJDdUt+ty9c1d0Rc
         ECu14JrsKDN6Zdyc7iUk2eGl5CxSd520bbbR2zkt4CNqLsFY0mTXOObgSr/RtYDFCu9X
         6N7/AMgdKOfhCflYzznIfvTl1iAPgrSvHquqK538W8qhu11etZBUc2ecgXGJCsrYYA31
         whKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T56q1WFOtYNSeaP64ZTRRqTdS6w1Bc+ijJta1+x82Qk=;
        b=rEZwdlSegzaT4amqisLcm1+SDMREmkNoe1vH9mnmeMZi2X9d+YSxUGGOL9x+rYnLRs
         BidE8yonWBOnfI8vnNch5GDnUE3wCmPnF/s/JIwJScxZ7JH4ABMHZqIY93GFpVEto3Q7
         4wA+Gh4GuFOz8TlA9QDKbeh3kEdZFEkz8QdfrSzmijGtxuLscU0FJv49GYKpWsEAhCI2
         01AmCNoSnfUVNplqn9O+zU9grT0HrhPdMLZRMFpI5Fyx8YYNu2NGfjGw3O3ZqK7nHxJ5
         svDOJpCJYr1eYMBLkizAgbhkELYwqScIPfZQ6x1lLuxfaXLJ4TbHImWZi/X3vy1pyy1q
         5zdw==
X-Gm-Message-State: AGRZ1gIUU8OIrNSPHZIM5MFUGZTeT8UP7zlDvRdH0LklbvbZ6TKyMjU1
        7jTadKlfkwoGSAU5DA48VL8Wo/jJWG/BPCfJ2SM=
X-Google-Smtp-Source: AJdET5djV3qCBBz+Am4ofKk8nvp7aX8mrHg4ZeqwTTv4xhxojmBX0n6Mvm3k4FkDlOHXlVQsJmJenqUuHARFYuadFc4=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr3117652ljd.94.1540578023113;
 Fri, 26 Oct 2018 11:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181026172549.3628-1-colin.king@canonical.com>
In-Reply-To: <20181026172549.3628-1-colin.king@canonical.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 Oct 2018 20:20:12 +0200
Message-ID: <CANiq72nFZS=3KGaQpGjRbprh8HTBiTcSpxScE2uacDmg-xqDGA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
To:     colin.king@canonical.com
Cc:     jk@ozlabs.org, Jonathan Corbet <corbet@lwn.net>,
        Dave Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, linuxppc-dev@lists.ozlabs.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 7:27 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to a spelling mistake of the error access name EACCESS,
> rename to EACCES

? It is not a typo, it is the name of the error (POSIX). Same thing
for the rest of the patches.

Cheers,
Miguel
