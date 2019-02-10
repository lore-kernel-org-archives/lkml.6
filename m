Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4ACC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44932176F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJ8v9VxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfBJSbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:31:09 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53266 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBJSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:31:08 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so21005748ita.3;
        Sun, 10 Feb 2019 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilcLwDI9bORVA0GTmJ+IN5vPjiDB0Hmx6YN8GStGkUc=;
        b=sJ8v9VxI1cIJYjLIgdBR32yg2MaiYxH3D8zzH5bcMSYBtaHo/z6G3aF6dmt7+gCp8+
         JAay0bnU7Zzz6QI2btNjIMwatUwiuNSTONomfi/PyBeRm1vLgaYRHs8c5w2r02GvAjPX
         /17MGyrqciD8PWNkk49ebcvayKlQBAkWJLlWvHqN0xVipOIrBOMVpDbYqZvUxyuAMQsg
         nvGNmRB/bScac6xutc6/mGvj5/AzDJ02wpEpoT4SEeak6kGBmbuuBuBx+7h6trpwUSaQ
         08caDsoBTMlv0N21XnpYysih6nlOnVX2N4n26MlbjtY3/173ZdMRhM1/uqXdpDAtyyuu
         3Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilcLwDI9bORVA0GTmJ+IN5vPjiDB0Hmx6YN8GStGkUc=;
        b=DEYSZ5mOlaKAbokq2ElG0MAbNrnJxBute7Bc4T9alRPA8dOwrM2pW5E43qQUvIC39/
         E4OObEPdpTD6bq4JbAuLbeG90OctTj/sS7GBm7gjqawETWv5IW2l+ml3E1yhWK9yLFBZ
         6P6hAnsst6w1rtPoKBYimd3TVCMSuGvVJEQ1EA/7rBxQ/GTKqpn4EziywoGvuGItTGYU
         C0LDjgKbSiFDvBjagXSBPh3FIqUgxh3F79zQEnHJbnYzBWkn7A9acssK4iw8IQDqqB6E
         6Y2S5Yka93eDMVzl13xY3BJXR4gBObv6VvJwAYwQsUnR2QBZguzDHMjm2FDvmqX27Vts
         PFOw==
X-Gm-Message-State: AHQUAuZfjlAw+oOJVWtgN0EuZqRz38+SKfubVS0QsuyFytXVyy40En2Z
        ihA3S3baa4ylbd+0hhwGuXHwjCfq5VJ+3OS3AuVpiw==
X-Google-Smtp-Source: AHgI3IZCHJ+GSY1ExbSxQesUhOOU1xIiwylMY9ZycYY8coRxTV2xhTSFaCb35Coq+Zs+wR4hOkb6QY1yxB0Vy15Gokw=
X-Received: by 2002:a24:3dd1:: with SMTP id n200mr4475793itn.61.1549823467614;
 Sun, 10 Feb 2019 10:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com> <f34543f5-d0fc-b998-9ce1-c8f3fd36db73@infradead.org>
In-Reply-To: <f34543f5-d0fc-b998-9ce1-c8f3fd36db73@infradead.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 10 Feb 2019 19:30:56 +0100
Message-ID: <CAKXUXMytERCG5C41teF0GGQYkOUoTaqH59oZhpdvZfA=RFHdmA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 7:22 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/10/19 10:10 AM, Lukas Bulwahn wrote:
> >  M:   James Bottomley <jejb@linux.ibm.com>
> > -M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > +M:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >  M:   Mimi Zohar <zohar@linuxibm.com>
>
> Just checking:  is that email address correct (@linuxibm.com)?
>
> Guess I'll see if it bounces.
>

Yes, it bounces. A follow-up patch is coming in a minute.

Lukas
