Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9230AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CEE2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcG6Dm6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CEE2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeJDPN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:13:29 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52328 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeJDPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:13:28 -0400
Received: by mail-it1-f196.google.com with SMTP id 134-v6so11990834itz.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLsLOIuZo5+XWpGw9AXQYbV43EzIMgt6VHkD75PjN6Y=;
        b=HcG6Dm6kb1tq1fonIuaEsGLnWBZbSjTUYcPB8lBNT6n+OK/aoTWHrlKHRT5j83ZQ+v
         aAkbADV36yafpfHVrPVUfxM4fxXvpyv+ysoryTeHdPD4bZskYq2JRg/9DjlOKz94Z3IG
         MMHvc5GSIAgZwQFKofgYDtynjLHV2vQVo4HrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLsLOIuZo5+XWpGw9AXQYbV43EzIMgt6VHkD75PjN6Y=;
        b=gGpQAC4PaZ3TF4AXsJRZDccJXZHVKt/NnEkUkuFT51UUwlqdshATEKflbZyjsZeOwE
         pWwDQaIhk5HqKBx1oaCyCdT/suUD3owl72Ji3L3KKCWSAa6+EyXiTUb6cDrzim8atIE+
         hMlF21qAFDVJ9BQnHXZbuFmhcbA2iNvxxNF2O0jsyxcEudASPqGX23ZTDM0LDz/E83z4
         8wLKX/1SG2LlVa0ZoEZYjy/Jx97NyrkJSRiowqB+VkzyzHTCesyUQMtHzezvlBcY2SV8
         4zZHKMrdTKmsHQfM/QngP7E5BEI67OcQ49EUpP/NYWTK4EtxsNBmezXMgPRkq7NVXW+D
         Z5RA==
X-Gm-Message-State: ABuFfoiGSz2z8bTA0TgeqKdby0JVOyOEF23RUBk0uU+2stGzPRJLzlxQ
        cC01tw6vJ6iR1vXutHHNmEYwtz+7Jet2O4B9GhFLUg==
X-Google-Smtp-Source: ACcGV632MamWI+sZTX7ssrpK4esQLYD3bTGXA8sSF6OyVIcYx34BgZq8fqyrTTxTyR7pP3jcS4ROAr8BBhx96lLY9mU=
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr4445694ite.16.1538641283776;
 Thu, 04 Oct 2018 01:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com> <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
 <1E24731C-13E1-41CC-A96A-ABDAA6175849@linaro.org> <CAHhmqcRbz+UsgDsHzJzKDWqZ_JMNp1UYq3M2rAf1vqfmO+wRyg@mail.gmail.com>
In-Reply-To: <CAHhmqcRbz+UsgDsHzJzKDWqZ_JMNp1UYq3M2rAf1vqfmO+wRyg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Oct 2018 10:21:11 +0200
Message-ID: <CACRpkdbHD4fNq0jz_JBuake7piJwRJmiK_JtsMXkiWVWxnis8A@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To:     bgurney@redhat.com
Cc:     Paolo Valente <paolo.valente@linaro.org>, Damien.LeMoal@wdc.com,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, aherrmann@suse.com, mgorman@suse.com,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 7:34 PM Bryan Gurney <bgurney@redhat.com> wrote:

> Right now, users of host-managed SMR drives should be using "deadline"
> or "mq-deadline", to avoid out-of-order writes in sequential-only
> zones.
>
> I'm running into a situation right now on a test system (Fedora 28,
> 4.18.7 kernel) where I copied test data onto an F2FS filesystem, but I
> accidentally forgot to add my "udev rule" file:

This should be fixed after
d5038a13eca7 scsi: core: switch to scsi-mq by default
right?

Since mq use mq-deadline by default.

I'm making sure to preserve mq-deadline on zoned devices
in my v2 of this patch.

Yours,
Linus Walleij
