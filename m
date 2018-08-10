Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31805C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52A3223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52A3223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeHJRQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:16:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33209 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeHJRQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:16:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so4934496edr.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=T+vRjBwjVYr6p5ANu+Lfib/Kw/sEWImfVWRA/qpHXqw=;
        b=HpGrAMBPUo5xrVLQ+Vtv4euJUl6tuWw4alollzfV1EVvuNiafMmv3vVpYuy4sJtgV0
         YM28yj43BW6zH7VcSJvTnJHBc3BeuvNP4CWZc5XqB7VMrPZbEQpzI7oRtaH+iQcSLvxS
         GOP4H2tIyPG5WcSLZdgzwByLFmvUB6DDNvU5fHozAqFseOwP2rBnSFk85Nu5/DjGKGfz
         MYJSlmIYWM2hrUqsEdMZbyCrM8zaJq9iTGbwTf99DvgyJAmNiHr5R6wmfKKcGEaJFkXD
         q2hMVIeROVt5+IH6rkralAOL+xJ10e41xisb3hRbUHuCZ+tNINkKZqQ8kOeCmC/sVYLh
         revg==
X-Gm-Message-State: AOUpUlGAJ4KfnZ6pBcwoVZThtAiKgEJGgjh2r40nsbV0Fiw7cVvhPBug
        gADbq/5Lw83HXgKvw7d2R8TF7X8hvigcaA==
X-Google-Smtp-Source: AA+uWPwtcNTCa5gpXFrx0/R1kp/SFjyE26q2mjk6mOuOvokGMZ3LFHL/NnDXm0vAn0U7eE9YNxrcPQ==
X-Received: by 2002:a50:86a1:: with SMTP id r30-v6mr9019933eda.138.1533912359926;
        Fri, 10 Aug 2018 07:45:59 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a11-v6sm3661388edn.95.2018.08.10.07.45.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 07:45:58 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id b15-v6so8514794wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:45:58 -0700 (PDT)
X-Received: by 2002:a5d:4c4c:: with SMTP id n12-v6mr4336566wrt.71.1533912358119;
 Fri, 10 Aug 2018 07:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180810133636.8340-1-efremov@linux.com> <alpine.DEB.2.20.1808101541270.3390@hadrien>
 <CADKZ3FLsksV8-cCE6aOnZnLbYj3SSAkPnMs_VRQB3g0V3mUYcg@mail.gmail.com> <alpine.DEB.2.20.1808101627230.3390@hadrien>
In-Reply-To: <alpine.DEB.2.20.1808101627230.3390@hadrien>
Reply-To: efremov@linux.com
From:   Denis Efremov <efremov@linux.com>
Date:   Fri, 10 Aug 2018 17:45:46 +0300
X-Gmail-Original-Message-ID: <CADKZ3F+UzwTbcKBHDYQnoFFgWiVoDbxZzBb=PQjMn2x-T26jHg@mail.gmail.com>
Message-ID: <CADKZ3F+UzwTbcKBHDYQnoFFgWiVoDbxZzBb=PQjMn2x-T26jHg@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: return proper error code on check fail
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My mistake. Initially, I thought that this line signals about errors
in the code, but now I see that this is about the tool's internal
error. However, this doesn't change the fact that coccicheck returns
the improper error code.

I will reformulate the commit message and send the v2 patch with the
same diff. Thank you for clarifying things.
