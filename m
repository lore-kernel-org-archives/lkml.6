Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2022578-1524240424-2-6602468306445797344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  FROM_LOCAL_NOVOWEL 0.5, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  HK_RANDOM_FROM 0.001, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524240424; b=H3AdkARVWsaDbx7PrX/gSy5ENYaYFz64Caqc1hWkb4qUuV7PZa
    X03+JyYOpvSUIgK+MUwzoxypk138EcNdqpN/QZXYHapHG3fvZXNhMsUOCkRB8lHL
    8dHwJsLsR63ZAZhseD3DHZJsd+8Jy1pqvk4IOOZxdqjZDcLHCF9/6dbsf9qIu2gC
    9U1XSa9XBR1ZGkss0XiAdfmKGg7TY6y66t02ALttfD6LtI6j1bIGQ5BoiZEpTRPd
    +QjbtYHg1N/dHlYEDk1AOOMEXMB0fHdjnOrLe3UCcYbSsOYZNGJUBBVNbuGkzJQq
    iYGg/pGY8A/uE6nb+zIONwAWp7cTrlKI+hYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524240424; bh=hR8fWu7VpmG/Z8zosUvN3z4fUe4WZ05uDBINC6ti/g
    o=; b=dlewnIuCaOeosyGhO6aHMq8AsX5+7tX7+f1rrMkGTpt9AdFPsVTQa/CmMv
    A8vT7xPl6SAW5sh47sZHZgPfYIzWm3oMiwJH+tC6J41vu2eO6CpD/M1iIhtYV1h5
    zFis9+TgZUoO0HFq9HYEdWbno31ap0MmwJxrQXNltunTMULpZHvQGacJXaobkz53
    qptFzYOy5GlTjWASltjyLIySc1omsU/z6QCXtY9xXd21HrwuRgVrik9z9K1qTeDj
    gjf910v1+8M5LJKX52AfzOMpks/SjxUzdy/3jhT7OEXAXhGOuglFE342jvEZquq3
    xJ7aSKhvR9CbGCfBSUVVIDgo/4Cw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MfcAF5PR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FKUwwawK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MfcAF5PR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FKUwwawK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOWIROHt5vSdVI+aMC/zDrfjrVah0Ejg/KtQN99VjMkYt/hac0UFeC8r7djRu2BJwRgxlUVxnW17eoX4VkvdZfFq6yO9kxpDAHsNaWy54Hv5CR49zVNY
    BnhUsPTLzFESPxgBpzEQfl5FNemL6sKDimABcUk/fljZbkC7VYnvnsi+ya6052oqR3gwFHlsGxgqm9H8BhJq1qJVUgSR8pjQxrrg85R83AtgwAwJdkIwMQC4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=Jj7W8BWmodYA:10 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8 a=F-1i3n2SAAAA:8
    a=pGLkceISAAAA:8 a=u3DotqyyAAAA:8 a=VwQbUJbxAAAA:8 a=GQVYfScIh66bs6-3bScA:9
    a=QEXdDO2ut3YA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=DkFbxxcXd2AJf-O9kuUr:22
    a=g3YQyp1ytkc1jtnOLIrM:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755834AbeDTQHB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 12:07:01 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46951 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755655AbeDTQHA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 12:07:00 -0400
X-Google-Smtp-Source: AIpwx4/cg/d1360l2PsVyIJbcn/7YypUsV3eISZqAdGbFu4RZ2gXgsxL/5imlvKZaRoFGgC607yDFmEIjlYB09SF8Ak=
MIME-Version: 1.0
In-Reply-To: <20180420143811.9994-21-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-21-ebiederm@xmission.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 20 Apr 2018 09:06:59 -0700
Message-ID: <CAMo8BfLcxvEK4BqteXGGzUNWXS1iRfUtSkO364MjL1URPbpKOQ@mail.gmail.com>
Subject: Re: [REVIEW][PATCH 21/22] signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 7:38 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> While working on changing this code to use force_sig_fault I
> discovered that do_unaliged_user is sets si_signo to SIGBUS and passes
> SIGSEGV to force_sig_info.  Which is just b0rked.
>
> The code is reporting a SIGBUS error so replace the SIGSEGV with SIGBUS.
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: stable@vger.kernel.org
> Fixes: 5a0015d62668 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 3")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/xtensa/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
