Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6346EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2148820837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvMj6dQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2148820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeLIFX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 00:23:59 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:44259 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeLIFX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 00:23:59 -0500
Received: by mail-io1-f48.google.com with SMTP id r200so6341155iod.11;
        Sat, 08 Dec 2018 21:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTjZE7l1yFasODUMZS05B+vNOn1KTzFshPK1mE1w29k=;
        b=pvMj6dQJBiBxgK4X4gEKmIoPfRxiP9FhiclodygUpVLuOov2gsZV4p0YTiujx8I3A8
         MguAGuNM9+mgsxD3T3jykcfepUr4s3zfKVuLOxVpBOc5o6kxAFdSCpECYVTo/Uo5IpYV
         1ddfn59EeWGHJ/sE2VrNQQIG32agj527nu8VNwlNIfjoNBtXmmfkzy/vpWbSvkxi2VZj
         L5vHb7OEpvC5mRchCl7+LLrpkKU5Y+B/bXvpBSRF7Od4d7RDrOAqX7p4seLrvi/YXDZw
         wNGgqPAsNhFpWCLAKvP7e20Yw0JvsTL5UHcQJuuz95GUyrXong7kW+UQhMr1sklPshD3
         7Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTjZE7l1yFasODUMZS05B+vNOn1KTzFshPK1mE1w29k=;
        b=D5hfpc2WMmbXvw0T7QzaJbhKS4QW54Si24nuo3p9/XtW/ySkKvTRN6VggngTvWSXFk
         Yh2AFgQ7PqmXeHCKlYixWsNLw952BE3Dm35Ubg6v1W8mJS53wNp6lqlsiyyjNBEoNVx5
         T3Nnb847qKXLG2yAYoPokskXlHuX8vrgRgrIR4tysZOzA4toROakxwMPz4odE8i4Va7n
         BS6lP0i3N6WJvCQCBI+bLUkK08GStqNVjTlr5lR7k1eHitpooK4qV5IqVvCMsmn2ZLlp
         Sh6HoxRYpZTSHROaGpQvhp8dtemOj5IvS3DXjdTAXPF5R0EU45zjVv2fTDQOxN9YacCJ
         YQow==
X-Gm-Message-State: AA+aEWa9nlpmGFkXIehyhqHgdtMy4mLwh11+JEXhsy8B8XNjqPQ4WzoO
        YRKjuhAtHw+pXC8Cmkz1wHnE2NEwaMRv5JQANl4=
X-Google-Smtp-Source: AFSGD/XiC8N2h/ZwGOh3pDEjV/tvPJZaGMwjO1aErt3TQ8DMHEUnXwomzYIhCeIOod4JMft8NaLePV9vREkcHQBxgy8=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr6167713iom.7.1544333038522;
 Sat, 08 Dec 2018 21:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20181121132806.22521-1-tiny.windzz@gmail.com>
In-Reply-To: <20181121132806.22521-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 9 Dec 2018 13:23:35 +0800
Message-ID: <CAEExFWvNYqp-jrgujz--qt0oNzME4_v74_OqdbpNU+re5hRYOw@mail.gmail.com>
Subject: Re: [PATCH] Input: sparcspkr add of_node_put()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping....
