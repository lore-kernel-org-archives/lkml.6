Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B61C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E402083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbOAZUKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E402083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeJOUhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:37:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42129 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeJOUhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:37:07 -0400
Received: by mail-io1-f68.google.com with SMTP id n18-v6so14117865ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oJdKDqKj6lg8ObchE/zG44OerZwdeVTtfW5364MEj0Y=;
        b=BbOAZUKrbWPNLVbiHWNo2Zov/S4zM2e//4wU+z9sBZQnghKAhZGn3Ifer1DaYF2hcp
         JsnAKrfgEBQeFEwmlB+5bfRgDoAWwk5oW/7l5sU30+lqvMpMIirk18Uwa9uCD7llbRRL
         rlft6AmR2WAYhSGg+9bcPBGr+OioeG6ZZaJpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oJdKDqKj6lg8ObchE/zG44OerZwdeVTtfW5364MEj0Y=;
        b=Em6HYt2PiBaCqWEeWTcjK9MRRgDOXlrvDeM6I5ojW/qiv++hR2vgWtEo/0fjMWSsgY
         tLtKSTqsjkH9Hlb01zujBKRbN6Z8ushjiJTOzIlkFT3cDWJQX/zw/xCLqS2VJcfNXwdo
         l15GUqT9AgS+1kupBsN7EKUNRsAMM9pdPSG6vuv1+yOofiHRArtEf+v8X4fcAxYdg4bF
         UVjlxasNmPdV4ScE40ubKxR2v1LqTL6cPKG4XFTNVpNFjmiS2D+W3V/9FFiiUBV1Db66
         ikAD/t2Si+ViP1PnKZehURX+0bxKHe7Nse7pjMFc+GFj5Pib7C+PrtQDQYdkp+wkiS0B
         l/wg==
X-Gm-Message-State: ABuFfojOTPkDQJKrMDZtZ+dClLOz88DKdEhvWgXWu2HHFXKB3TRtqdu0
        3I+dJsWcpEGV2qVCldtfBitSeWCIbd+/6KdlmrzrEA==
X-Google-Smtp-Source: ACcGV62Db1U7QHYuZ0hFUteWI+8Q62xOEoJWZ67EfAzoV9e6ibYySTMlQAFPacH5bTVw4UP+L6X6ixkUAiSd+de4j3Q=
X-Received: by 2002:a6b:8fcb:: with SMTP id r194-v6mr5348658iod.266.1539607916329;
 Mon, 15 Oct 2018 05:51:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 05:51:15
 -0700 (PDT)
In-Reply-To: <20181015073339.GB981@kunai>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <20181014223311.GE3260@kunai> <CAK7LNATPf4mEdH16eZzLg4x3tP-jvXcTWqqY0DgCpmGjt9x9zg@mail.gmail.com>
 <20181015073339.GB981@kunai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Oct 2018 14:51:15 +0200
Message-ID: <CAPDyKFpAa=ucJvTLhNi-fQ3Fvd1in8rstxQouPY+_k_bFoAjZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 October 2018 at 09:33, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Some sub-systems rebase, and some do not.
>> It is up to the sub-system maintainer.
>
> We used to have a very strict rule to not rebase anything which ends up
> in linux-next. Dunno what happened to this rule but I liked it.
>
>> I know what you are saying, but this is how we develop in linux-next.
>
> I wonder about that...
>
>> You need to use "git rebase --onto".
>
> And what about lists with commit IDs tracking patches on their way
> upstream? Yes, there is git-patch-id, yet I think it is easier to admit
> that incremental changes happen anyway. I know Ulf view differs...
>

For this particular case I can avoid the re-base, as you prefer.
However, in general can't commit to not rebase, as it depends on case
by case basis.

Kind regards
Uffe
