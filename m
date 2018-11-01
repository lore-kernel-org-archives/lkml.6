Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F5C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A14205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XCF15YnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A14205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeKBBJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:09:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46481 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeKBBJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:09:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id o2-v6so14552754lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cY808+7StwfKU7Pp/8PZ0sxupVTvZZyXB1cL9saqMlo=;
        b=XCF15YnDh9Oup7U9I2df1pXV7osiSCaLpEtIHJGtRTkonQGAqEFnw50JSxnlq7vwTa
         dYGzqfbDmNsLeySiyyWgSqi95b+929SuYY5N8qGER9MeWAQFhKSfN/BJgo1ptJEQ3DaB
         TDThad3Nd3RUBBdDRSltXXW9iKX8xo7WiTi/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY808+7StwfKU7Pp/8PZ0sxupVTvZZyXB1cL9saqMlo=;
        b=fh98ikup1IYjXk/XL+/7RDnhGrT8p7aiUDLSwVEy7zkjHM8V/9PYvVN738hniMWgh4
         QMVhmYd22KbVFqO8xVoJBSrxxak8OalpkCrMgXLSCfXWVO8HK+pXpp3VkVGes4Ok0cND
         qhfkKndsvwOsh046CKkB8oL8k/nypR9LTS9134q8lkHY5COnglB7/ndOSkthUTMFoNES
         mS0BdBZtRgOt25vcOAfYScRutGiyHqk+M2xl4rLBYFF2457B+bJ781QOEEcesouMi1NE
         SPp7tvXNFSvrbPQ3Y216FNSigUI9vIXkdjGb2E0R99/Cff1m5mqR5Cs1mPmKGEuSnJSk
         gX2A==
X-Gm-Message-State: AGRZ1gKW3XQ4QIHTg+flqPdrQWRHOdGVYde1ifTZFhmlM040ZJ3dGgOG
        qn+KfWn+oakjj/rh0tplzD2bK7n9+YDDvA==
X-Google-Smtp-Source: AJdET5eiKQ7YU4POl28hkgHvx4sVPNNq8hqxXrZ6VvOtdet7UbU3CWOt9aKUYNUSxvGdGuRwnH9fdg==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr4600304lfg.89.1541088369429;
        Thu, 01 Nov 2018 09:06:09 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o25sm1367039lfd.29.2018.11.01.09.06.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:06:08 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id o2-v6so14552687lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:06:08 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr5017776lfc.147.1541088367801;
 Thu, 01 Nov 2018 09:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <1541050105-14469-1-git-send-email-ren_guo@c-sky.com>
In-Reply-To: <1541050105-14469-1-git-send-email-ren_guo@c-sky.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 09:05:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAeGFuTPdNRpuanAHvetxtKa-oZ9JLw+Moo=EaSS0O_w@mail.gmail.com>
Message-ID: <CAHk-=wiAeGFuTPdNRpuanAHvetxtKa-oZ9JLw+Moo=EaSS0O_w@mail.gmail.com>
Subject: Re: [GIT PULL] fixup dtb Kbuild for C-SKY(csky) Port
To:     ren_guo@c-sky.com
Cc:     Arnd Bergmann <arnd@arndb.de>, robh@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, guoren1983@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:28 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> csky: dtb Kbuild fixup patches for linux-4.20-rc1

Pulled,

               Linus
