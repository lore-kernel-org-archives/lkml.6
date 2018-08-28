Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA7D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB3tLjG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA7D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeH1ThW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:37:22 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43487 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbeH1ThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:37:22 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so749847ywb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7DlMa3vtlcP1jtp+WszPCp9JLvftQPbKibnH9s9EMbI=;
        b=SB3tLjG10ruE4X7bmVICBuWqT7TJY6K8YKh/7nM0eSNzpykXhVpUzfbA6c9biWh/Lr
         RiAr6erqaUsNIK9LA/UoEd9mWwiOheCeYPyYRsQBIomROUKb/8pDPBmrcNDoIoDuS4Be
         pCMtwwBp+KMUpxYKe0bbXcCK8lrSx5X1Z1J8brTiZADJUFAQt3tbx8HonMhsz1Oc/Tik
         XBRiydttxAvFcwiRtb5KR7pKiWfyrVSNG/mg+2RtOzpL+l41cnIrgiXq3nSIBnexPyJJ
         rOdhY7ljt7y7VypCnUO2123hhgb6CmmVaYEx++pPLk90Hmihb/dOpqeyP2/tvMn6xuou
         K2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7DlMa3vtlcP1jtp+WszPCp9JLvftQPbKibnH9s9EMbI=;
        b=E5Xmj2v34mLGvfjC3/ot+lv1lhAJLtQjiibhHlk7BhqYUY0DDqkTRKtzsqmxp+fpiv
         8DEFDIgGNvj8a0DNS76I1U/rTnMk+7qJG5e5fuH3VyYgQCgGwlUrw8+vTzfvWXOvz9Fd
         SamlMG9Ww9YeVm4SsbR1+TL8aGRKevsZegelu2LzbDSzFZh190RVKSa+lZiOWVfwOdrI
         eAkF+lUlRo0ZpFrTcUWC+vjY8k9wWtwy6Pe/Jy7spNwh52zT1b2reZlEyc75uAQdTyJx
         30yjgwPXy0xPF9SIJNiTkFokAloocrYErgge87ii8g9hp4kNf4VAA2/CQJ21WyJD6hZA
         YOBg==
X-Gm-Message-State: APzg51BUCWDMbqF3VI8A2bDfJSDu6pZRuOPpBKhXFKG0T7beDkoqAxzr
        aVOm6lUYEYuU+6KEz7Yp6plsnWmJG5yc9uiNJLs=
X-Google-Smtp-Source: ANB0VdZpzsV2PQaXSkGMgsqWsJUYwUVqL1sowVUQgUGZoDcM6Fcd1jPvMywbFHemdjdVPaU9jXJFrAtdGX8xFcIvjYI=
X-Received: by 2002:a81:a014:: with SMTP id x20-v6mr1190553ywg.468.1535471107575;
 Tue, 28 Aug 2018 08:45:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5457:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 08:45:07
 -0700 (PDT)
In-Reply-To: <20180828015252.28511-8-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-8-robh@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 28 Aug 2018 08:45:07 -0700
Message-ID: <CAMo8BfL8MesEQsJ_-DEbzkuOTD170t-Q=Rj0mHZgRKTDfigHsQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 6:52 PM, Rob Herring <robh@kernel.org> wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/xtensa/platforms/xtfpga/setup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
