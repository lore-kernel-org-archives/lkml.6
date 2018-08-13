Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12823C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B35421763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlzermPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B35421763
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbeHNAqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:46:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39092 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbeHNAqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:46:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so30061240oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXfPvfvYZ8m+krL6lE5RoFKOurLpQMv3nkdS+YlRUfo=;
        b=IlzermPp5ZHJp5RU0XTEo3OFZ7jECBqG9GhbCAnxyDWt+cvRCLB3raoqH9FmFqHBgS
         dtfahTl+cSzPZs1NaABVwnK1oETWr17W+ISIN2tWIswVyzicj7eKtmxr+15wdU35H50f
         PmAjMEiCe9y+eWzlysHuEnQ+jkD3CRzw9aI9lMgNTJLPQosgqvf2S1t0rP/XRdL1zyLD
         BMaee0nyLLreI4p0tf9rOQA+JX32fFHXW57Eou/jLc9P2Thed6+Pl7Z8Z9zTX7+y/RZ/
         8JuzJNd+J0bvYyfBk5ETPXsP04GlFhORBi9aDCJZEUHCsrlw+XbMyZpTQNgF5/Ak8YcI
         5JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXfPvfvYZ8m+krL6lE5RoFKOurLpQMv3nkdS+YlRUfo=;
        b=SB6N8CwlmYs7odqmhK0OSE+jTu709sNEVd+KE6h8fLImGSjX6m7j9mUp2ko/QqJSis
         5OK3I8W0pV2/WTey3Id82OMikS7QxxATmdSLyaXyb6KDEZ6RQAk7U0nCHXya6VaBFVJA
         d8VKMc8wPatSWG1hv87omBb15RV/XNsLbXIylTLPCRSHXnq3WxU4HsYgt5NXlJU/nhMc
         0jSEDkj2RujBQxdgUe66X6vwbnktiZM0L5YEBhp8CphN+Lj37/IREuSPuBQDx+7NQk1R
         crsDmS+5e4hfGB3dEzQ2Z6AdWGCAkRlcQZfEkhFiWJPVXgdI76XzABQRng45Tr6Fpu4Z
         x1CQ==
X-Gm-Message-State: AOUpUlHC3G4XaCZ3KUxeab7L5jpjhfN+4OkVhaJiweuy0vSpuzi6z/PB
        H9DvD5dpSvfcw9/WmlH4QLdwakUi4/frUzBtSNZC+A==
X-Google-Smtp-Source: AA+uWPwqVEwX0xaf0UZLzFGFCvlGelY6WT3oTDFcGfHbdS5J52sgTjieq+hhi4YyGFFJ5+9PRwKWTmJAT349yjKzDmQ=
X-Received: by 2002:a54:4010:: with SMTP id x16-v6mr21310818oie.228.1534197719053;
 Mon, 13 Aug 2018 15:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180813215546.3828228-1-arnd@arndb.de>
In-Reply-To: <20180813215546.3828228-1-arnd@arndb.de>
From:   Caleb Raitto <caraitto@google.com>
Date:   Mon, 13 Aug 2018 15:01:48 -0700
Message-ID: <CA+7y87rkaP5CAd4ionPLvOuoJDbnzbUL-C=E-FaSj7yjde8Lmw@mail.gmail.com>
Subject: Re: [PATCH] cpumask: provide a dummy cpumask_next_wrap
To:     arnd@arndb.de
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        Willem de Bruijn <willemb@google.com>, davem@davemloft.net,
        adobriyan@gmail.com, mingo@kernel.org, rakib.mullick@gmail.com,
        amritha.nambiar@intel.com, mhkelley@outlook.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 2:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The virtio_net driver has become the first one to call cpumask_next_wrap()
> even if CONFIG_SMP is disabled, leading to a build error:
>
> drivers/net/virtio_net.c: In function 'virtnet_set_affinity':
> drivers/net/virtio_net.c:1916:10: error: implicit declaration of function 'cpumask_next_wrap'; did you mean 'cpumask_next_and'? [-Werror=implicit-function-declaration]
>     cpu = cpumask_next_wrap(cpu, cpu_online_mask,
>
> Add a stub function along the lines of cpumask_first(), cpumask_next() etc.
> I'm not entirely sure what should be returned in this case, but at
> least for virtio_net, anything should work.

Sorry about the build break, I think this patch with a fix was already merged:

cpumask: make cpumask_next_wrap available without smp
https://patchwork.ozlabs.org/patch/956670/

Thanks,
-Caleb
