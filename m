Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFB1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF58B21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBGNxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:53:38 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36285 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBGNxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:53:37 -0500
Received: by mail-ed1-f67.google.com with SMTP id d12so8025693edy.3;
        Thu, 07 Feb 2019 05:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm5Avw4EPLC0zdN0Yr9cwA50XTgURy4PyLPaThhN+lU=;
        b=Qs1RLlEPkelmegQHTYXlhuhmoUxyg0teJ1gcQpUKpKZ0c/J6eJKN6C4Lzjt4CYxRn/
         Nd+MebdNc/ITu20Hd7rEQiXZI2uYhkmdqeCk5q22z0ZdtsOu8z9M2bxRqjYOVE/H2tlr
         iq0K8HZeVTqw7/DozotAQT+a5H7KuGMowPj8oqBEWrN/6di3yiYF+kwqJqrmCO33Iwm9
         Ee+9AuCOCofkWykMXwyMz3wUGDDoRgdUlWrBdyjzhgnki+qiuFcGGSOeWsqOK8JRh6JK
         gfSMXXKqjdc+xhip9PsGvbkQ2DTLnKfZsag/iUpRhD5IjF59KzbPwP/5qRRW5q3qdwyO
         cF5A==
X-Gm-Message-State: AHQUAub41s2Ye16SvVEoHuz4qnABYyJ6Aykpf7aTBYnddc95EeCGTBOV
        IokuENZsOHZqbmM8MTKjFbJbQAYxlvw=
X-Google-Smtp-Source: AHgI3IYASUycXwNZntenyldK54+kAKD6RrVVCe+amcE+SZgXZkIFGBCUp7pzBaqMFw9zoSDbeENGGQ==
X-Received: by 2002:a17:906:2ec8:: with SMTP id s8mr11936062eji.235.1549547615429;
        Thu, 07 Feb 2019 05:53:35 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id y14sm4084904eju.58.2019.02.07.05.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 05:53:35 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id q1so1648175wrp.7;
        Thu, 07 Feb 2019 05:53:35 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr12263321wrs.44.1549547614690;
 Thu, 07 Feb 2019 05:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20190208005042.6b353e17@canb.auug.org.au>
In-Reply-To: <20190208005042.6b353e17@canb.auug.org.au>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 7 Feb 2019 21:53:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v650UCEXbEnNPTiPPSn_5Tznso4gg5W23P9K8Y7f_pAqxw@mail.gmail.com>
Message-ID: <CAGb2v650UCEXbEnNPTiPPSn_5Tznso4gg5W23P9K8Y7f_pAqxw@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the sunxi tree
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 9:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   df0aeb208b24 ("ARM: dts: sun9i: a80-optimus: Add node for AXP809's unused dc1sw regulator")
>
> Fixes tag
>
>   Fixes: aa4a27bc819e ("ARM: dts: sun9i: a80-optimus: Add AXP809 PMIC
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please don't wrap the Fixes tag over more than one line.

Right. I forgot to update the messages from these I made in the past.

Maxime, can you fix it up?

Thanks
ChenYu
