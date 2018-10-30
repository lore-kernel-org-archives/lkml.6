Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2D3C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3E32080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFCPogtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3E32080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJaBS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:18:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43847 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeJaBS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:18:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so14145775qtq.10;
        Tue, 30 Oct 2018 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3g1qJ1+rYIYYum/xPbu372Zwj+KEq2z2EhpnXuN81A=;
        b=bFCPogtAoa0IfPrTcBc3CtyuNGwbuOyfMIeaRYLCFvhGTWMqV6p/CBy92WUQxBY7ks
         FBYYoyR5EYDEX1AT66/ZtO+E0q8MaWWoOs43Wo46va1J4bRDqhCnGG1FGIu3Asu+Ayo4
         jnvfaAGrHPmJlvEsBLSQOEk96QoFf7dIng8pW3ZqANrXs9axzi3Py5MzvkOxS+V6T72J
         Y1OcEIcTd3BbUvbn+tDeGx1yPx2Gs9JIZgABcDuWt6kOoGp0U0qiWpBF/zoHyrgMj7Xj
         i9J0/ymQoRzMDPiCNv+hFYe83XDzsNeFq6cW5IKocrN5xdJIlI/7bUh0SBkxDXLgRsuw
         e2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3g1qJ1+rYIYYum/xPbu372Zwj+KEq2z2EhpnXuN81A=;
        b=M8J4alPLYnoh4F+4sajUbB40f6rRC6+i2oXErrI7PlPfJDnLJfkALCJexrmSiL7HxF
         E0K77AyITaUCVkbnxHmrkZK34ps0WHy5o9rpZ3uGq57iNpPZiKszrFimPG0q5xthfGmz
         9G7natbcGCFAtbUJd1eXI4A8Tm8dRw5SLoB6YgdMGtWJOm401ozCc74Z46xJqKD0qupD
         MwzguDtbOYT34i/kR1tQXaSGIrZphNKJgJ4uW9xNXglyfJvDgRsFngG9ZRrU4nhRwA41
         dY7LNkln4bzKxQ7eNF1e7jC9xyBxU0Yr8pnOyQnSDaj5dGXd6jRmFK7YX6UIq4LRX8KX
         NraA==
X-Gm-Message-State: AGRZ1gIFV9+kIpF9ALFI6u59kRMR9wLYam7gcTlQz34vi3RKNMcjUyKh
        Wk5wfMn0PgutlEI7Hi3KNPWqHzp68cMoLbC3nt0=
X-Google-Smtp-Source: AJdET5c2LsG3tCNN/1iPKnZ22EzROfHBnyIfCXDZt1s5j23Kj5YxQTMTeF1E8eF6aQ9LWK1Tmj1fN09rRy2LOW+jSK8=
X-Received: by 2002:a0c:d268:: with SMTP id o37mr17628195qvh.136.1540916687461;
 Tue, 30 Oct 2018 09:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181025232517.ywnw54qibemosjws@picard> <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard> <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <ac7720fd-ed2e-dd77-d60b-7ab535daf167@redhat.com> <2696c9c2-29f7-18cf-1893-bd2fc2f203f9@redhat.com>
In-Reply-To: <2696c9c2-29f7-18cf-1893-bd2fc2f203f9@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Oct 2018 18:24:35 +0200
Message-ID: <CAHp75VcQWWiBmvkQJ6G50-efKRK7ivOwHw+7pZzkUPLepfa-FQ@mail.gmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dean Wallace <duffydack73@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mogens-jensen@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 1:05 PM Hans de Goede <hdegoede@redhat.com> wrote:

> for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat $i/clk_flags; echo; done

Just a side note about nice tool, called `grep` :-)

grep -H . /sys/kernel/debug/clk/pmc_plt_clk_*/clk_flags

does above in one call.

-- 
With Best Regards,
Andy Shevchenko
