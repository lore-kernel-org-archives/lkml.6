Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F339C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D02620673
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MN6DnKhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D02620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLGPhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:37:10 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:43070 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:37:09 -0500
Received: by mail-ed1-f49.google.com with SMTP id f9so4033138eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P+REkCDifJLWaMeUuykifcBRoIVlixWZ9NbVmc8rUns=;
        b=MN6DnKhTH6tIoa1jB+0Y5fo4RAMBlzH4R+K+dgEop/q7IKGYonkhHcv3dET7Khj9ee
         iW+1gnOcJ/RuXxf6zqZC1d9v3hlEcHiZecHOKtf7iPEW39eCp1M/bnzX+MVd8qX+u/c2
         0sItJka228DOBwR4qqL6gdetbBd7iR5oVKzcC0SonR6wO1N77iiuepV9xSFukwvPGiQx
         9n9UKJw6Uue7f68oS8zf3Sn5k+3gdumCL6QCFh1GYSH86/UgGfkjHjSzuFXtJfYnqvWH
         uZUw3Bsur/yofPHPWCDr2bdArK2gLHZLfvHbpa1hkLkS561NpGBu4y2Es8fjwTMzRS0a
         LCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+REkCDifJLWaMeUuykifcBRoIVlixWZ9NbVmc8rUns=;
        b=Ousi4L4RobXgw00FNCqqJ+wr1wNR3ibY1CGW9OowHJCkEU4tLfztgQMGUW/e2WcJP8
         0bOkXj6sSI7pK7EDsJmN3w/63USc5J8ygoDaFFYh0MTr0TvpEMYXgw83nVFZQf9Mk/9P
         rmOd1dn99dn2QchZSZjqJ4OJh0ZeFIhIAjaQphNHqxZmPTrcRYnmrUTIIpIgnq28mF0j
         3FkcwbYNk80kOztbyvGB87yxwbZOeLXyTfm87VbnyV1+K//5VYsQBFhIJd7hScFEJjfT
         CufAEui5gSQXVN8JLvTIaETlM/ppiw2ZHexByB3ez5lAD8bvdVI0dvIF84Gy1Y0M5m1X
         0eFA==
X-Gm-Message-State: AA+aEWbDt0Dksm1q3dTwop8r6RefeOl5DFMwvZzZUayTmV3fgqmTJ5lf
        ixyJdgUATOxrICJsbaJrrsXwwg==
X-Google-Smtp-Source: AFSGD/W55Tt5Im4XeQVHILLIhB+sDGGqwL5aot+5Ih0lXRooUjuPZ0bQKYkdMxnmpebuPxYpkivJnQ==
X-Received: by 2002:a50:e045:: with SMTP id g5mr2711313edl.152.1544197027828;
        Fri, 07 Dec 2018 07:37:07 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r8sm1006080edo.11.2018.12.07.07.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 07:37:07 -0800 (PST)
Subject: Re: [PATCHv6 0/7] tty: Hold write ldisc sem in tty_reopen()
To:     Guilherme Piccoli <gpiccoli@canonical.com>,
        Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org, mpatocka@redhat.com, pasik@iki.fi,
        peterz@infradead.org
References: <20181119125208.GC15229@reaktio.net>
 <addf7faa-f6e9-df6b-8dad-4c43b71cfc1e@canonical.com>
 <20181207152309.GA30796@cisco>
 <CAHD1Q_yPbhTYcKwk2PUkoabD+dTqegkVEab7nAvcrgAN10otSQ@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <9c3c1c65-3717-3567-89c5-85d35d89c678@arista.com>
Date:   Fri, 7 Dec 2018 15:37:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAHD1Q_yPbhTYcKwk2PUkoabD+dTqegkVEab7nAvcrgAN10otSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guilherme, Tucho,

On 12/7/18 3:33 PM, Guilherme Piccoli wrote:
> Great news Tycho, thanks for pointing this out - in fact, the entire
> series got merged
> according
> to: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-next

Yes, Greg kindly took the patches set into -next to increase coverage.
So far, there is no standing issues known to me.

Ping me, if you have any, please.

Thanks,
          Dmitry
