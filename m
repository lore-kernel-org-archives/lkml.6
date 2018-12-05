Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B061CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDA5206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/SZGRi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDA5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeLEIoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:44:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37846 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:44:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id z16so21367304qtq.4;
        Wed, 05 Dec 2018 00:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEKuLzQazfavNlvV2l8C8plrh4QTNKZaDr0RC4HkX0A=;
        b=V/SZGRi2KqxJoqakREfRf9gdVzBODjWZFOSvz13lKegJBmrji2AV7et6dZQ9DcKHiZ
         86ITW7qIuwVt37ZcOjSBoRW+FZxifm0rVdJqfjavrwvzL3N39xFQre1DV5QQEhzTf1Rl
         RxlvBdDR4XBPiwliCcG058FrB1aYluykxhthsXIPHT+7e8h1xzZ98AlD/JirbvPxFP6q
         604GjEBMCEXDxaDbza5YhzMrVWY0Acq/ApO0CX6TYFYRDpEjBnffcXfS+e+aJkyyGzE7
         y+gGm3hMMhLwvbvO3DEbFgxBAtjijZkBcMPAHhZR0C5139wPgX8+6xpxLMSSNqTcVXWu
         IrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEKuLzQazfavNlvV2l8C8plrh4QTNKZaDr0RC4HkX0A=;
        b=lDn+nfgzevk+owv4+9MHVebiE/kapYrjlg1cx5naXBYjFmEZSWLu85ufcsUUHMWVD2
         o4qfGgktKa4jvC7yy7jmtNGs1lsZHmuj8Q0YVIygxQH86246gaHSDTXWMl9J69huUZm2
         CztI1RTlEub4rKj3AWiWxAKO8ElAKecImrOhVCbwtJITlrGOwqXSvHf3Gr9rMLoaoorv
         7uHuEwMsqdMxRZS0ZrOpKqPAuLw4z44o2pJhfZiRsHjiBC8zhnYx7ZtR6IqhQ/js90sR
         MfRWvkJzz/xIyPjJje1drf7A+PZmb9E3BSuA0XKYoPonevcYja8pnUP90w6c3Ak/IBJH
         DcvQ==
X-Gm-Message-State: AA+aEWblNSQV9zJ1dRXWI9jHpwUC7O9TRAnDnYmEd6lewvRtW1Pt63L2
        VzcJdTiFQ6Lhk4TsHAx5S5wT7csflPrR5KrZPSA=
X-Google-Smtp-Source: AFSGD/V9UwrqnZ2JTHLq5uqtsgXvcro60FF7YkxqaGUnk6cPqI5z5OymZauuZQ+rytCuhAlIeM8vQT9pkCJykKvWTFE=
X-Received: by 2002:aed:3b76:: with SMTP id q51mr22527413qte.229.1543999483084;
 Wed, 05 Dec 2018 00:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-11-chenyu56@huawei.com>
 <CAHp75VdSowHk4meQqqUamSjJJoVT59+pMZ1qjmmWd-W5nWBcUw@mail.gmail.com>
 <6810012e-9a77-dfdf-a738-14ce77a3027a@huawei.com> <CAHp75Vf_nemtPuMZV-1ezyYaB_BuuDM6uqaBf9DLBWLdCnm4Gg@mail.gmail.com>
 <a1168f88-5679-6245-41d8-5ef4be5493b2@huawei.com>
In-Reply-To: <a1168f88-5679-6245-41d8-5ef4be5493b2@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Dec 2018 10:44:31 +0200
Message-ID: <CAHp75Vee21_x47wS9y7eoLsnemst=gigVv9sw_LrUd-kTs0mtA@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] hikey960: Support usb functionality of Hikey960
To:     chenyu56@huawei.com
Cc:     liuyu712@hisilicon.com, Wangbinghui <wangbinghui@hisilicon.com>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 3:57 AM Chen Yu <chenyu56@huawei.com> wrote:
> On 2018/12/5 1:47, Andy Shevchenko wrote:
> > On Tue, Dec 4, 2018 at 3:40 AM Chen Yu <chenyu56@huawei.com> wrote:
> >> On 2018/12/3 17:23, Andy Shevchenko wrote:
> >>> On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:
> >
> >>>> +               .of_match_table = of_match_ptr(id_table_hisi_hikey_usb),
> >>>
> >>> Does it compiles for non-OF case? Why macro is in use?
> >
> >> OK. I will add the "CONFIG_OF".
> > Why? Is this driver supposed to work without DT?
> >
> No. This driver should depend on OF.
> Can I solve this by add "dpends on OF" in Kconfig?

Yes and don't forget to drop unneeded macro(s) like of_match_ptr() above.


-- 
With Best Regards,
Andy Shevchenko
