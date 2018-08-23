Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2421D21568
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2421D21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeHXAip convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:38:45 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35080 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbeHXAip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:38:45 -0400
Received: by mail-vk0-f66.google.com with SMTP id w193-v6so3310667vke.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2rAsC/ZB3su5qCOHQ2F87WGgD6U5NWKu92dZGJDB0Q0=;
        b=FyKJwiyFAPkW1GplEnR7p61SxQcHTE7Vu5PUThyMg1ZkHk9KAE3JgsX1kUxNPMNqsv
         mcQGk8ly65SAP/mxMs+IjzguQ+KzRoroO8vKvK9ZiCBTFp88EiaFgphpqruOUY+aUtL1
         HkBfeVNmchOSVhTbAzeoYZgK0oj/aBct9hRrbtqtfBeIBUjr1TTH8Gp/750t6LY/8Y90
         DySSd0nP+tgtvo12Q7ODOnFbMldehJt23/t057as9baw9ljnv2CypMrQfS1xy/P6DhCi
         idAmJ1OZBHCJCWZzIb6rdPQ++BjEs25KuJT6cKrTSEGzcATgt3bars83042zZi0Da+nP
         24Vw==
X-Gm-Message-State: AOUpUlGqevuA7yzkr2OoffFb4IUhstSlWt3PMQA3ViHTuvMi650+0AaG
        Ax9bvGunzDT5K64fodwDugXeqztwvSUai7tvN+E=
X-Google-Smtp-Source: AA+uWPx4vvbMQllpx0oV+/eBJwd+0UVoFrRBgpf0jEhxOp8KcLOLhACQwqmZSmEGyntakX9WpP3W8c9tojDfvvGTICw=
X-Received: by 2002:a1f:8948:: with SMTP id l69-v6mr40570142vkd.132.1535058435639;
 Thu, 23 Aug 2018 14:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180704095318.19218-1-anders.roxell@linaro.org>
In-Reply-To: <20180704095318.19218-1-anders.roxell@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Aug 2018 23:07:02 +0200
Message-ID: <CAMuHMdWCyH-E9VA7ihsoXEq4dvLrPjYd01TYot6qja-psVRcog@mail.gmail.com>
Subject: Re: [PATCH] fs/ocfs2/dlmglue: lockdep_keys defined but not used
To:     anders.roxell@linaro.org
Cc:     mark@fasheh.com, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On Wed, Jul 4, 2018 at 11:54 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> When CONFIG_DEBUG_LOCK_ALLOC isn't enabled lockdep_keys isn't used and
> we get a warning:
> fs/ocfs2/dlmglue.c:99:30: warning: ‘lockdep_keys’ defined but not used
>     [-Wunused-variable]
>  static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
>                               ^~~~~~~~~~~~
> Adding __maybe_unused to the declaration hids the warning.

Thanks for your patcj!

> Fixes: 1cd75cdb8fbb ("ocfs2: make several functions and variables static (and some const)")

Fixes: 480bd56485b77c36 ("ocfs2: make several functions and variables
static (and some const)")

Presumably the branch got rebased?

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
