Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 52DF2C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8AB208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="diCVvGrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8AB208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936005AbeFNKji (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:39:38 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:45304 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755002AbeFNKjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:39:33 -0400
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5EAdHKN026845;
        Thu, 14 Jun 2018 19:39:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5EAdHKN026845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528972758;
        bh=6lxQGs4/Zp94XsfVWUsHxNXUU+anTV9EOM3BNR8Wzzo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=diCVvGrpIku+ta58Zy5VeKUBtFWK8Bv5PnT+wXdof0GpJBSoQbVJU3Ph6kMlcMvin
         mKgiSZsRKDDWOJiO4lOleW/vw2Y535ehNzLL6zEmkmYFHQNumKVj1Sh0fggnRfDmd+
         YcOfzgollGDBFw3TokVIDoi0AfNZXeGTZTmrpM+y3a061KH4nyDB3T/Vw9I+By5Mck
         y7mKQUgq/vghgZF74g76D9ES0p0aEqSNset+G63fljsIbVMsBzIXs0dSDxOVTtQe2G
         aRwQAt5BGhnUR7Kse3/9BMBPMNajUfHueLdPnzmFJNPfOBxi7L6i4rvODy6SsJWXne
         Wbf50G8n+E3nA==
X-Nifty-SrcIP: [209.85.213.50]
Received: by mail-vk0-f50.google.com with SMTP id x4-v6so3349359vkx.11;
        Thu, 14 Jun 2018 03:39:18 -0700 (PDT)
X-Gm-Message-State: APt69E0oo7UkNAkBAX+M/D9RuMu1ovYjkk0EgwIxmQkqGqBeNGaWDInS
        2byrfwTUT0dhPt3l8gWFz2Eafd/pn0Ymsz4ymCc=
X-Google-Smtp-Source: ADUXVKJZiKfTsKyrqSdBF+zyLz89E6FEs9z+pgWg4wJHyJgmz4nbU0wGCtdyGy2VKf4AsQI+uPdhYQMOX7abNo+G3cM=
X-Received: by 2002:a1f:cc85:: with SMTP id c127-v6mr1185065vkg.166.1528972757047;
 Thu, 14 Jun 2018 03:39:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:38:36
 -0700 (PDT)
In-Reply-To: <CA+55aFyHcEojRqf+pvGuZF1nExY_SFWX7QZ7ifBZPtJfB_BWDg@mail.gmail.com>
References: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
 <CA+55aFyxY9f9_eGv3CvA0zwzo8K5WeNbNPDFuyhtCrzRyic85A@mail.gmail.com>
 <CA+55aFy2KEzTiF=0nG8_RFoPpycaqc=n-hf-mQSbKotMzYJG-w@mail.gmail.com>
 <CAK7LNASd7Mc8eU76L24ZC0OFdUf566adNGVvX9Ou987cT3CCWw@mail.gmail.com>
 <CA+55aFz7KGMcvABxJfYs719ySyt2JouDX9t0SAV4Qu9yY9tfPA@mail.gmail.com>
 <CAK7LNAT4m8JgOttC5D16ALKqvMtt-6Vi4nFUdVaTMQSQPwYN-w@mail.gmail.com> <CA+55aFyHcEojRqf+pvGuZF1nExY_SFWX7QZ7ifBZPtJfB_BWDg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Jun 2018 19:38:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQtVZujrViSRa=8BZHXo184qK7uLhBXxfacwcgXJoZOqQ@mail.gmail.com>
Message-ID: <CAK7LNAQtVZujrViSRa=8BZHXo184qK7uLhBXxfacwcgXJoZOqQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for 4.18 (2nd round)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


2018-06-14 15:26 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Thu, Jun 14, 2018 at 3:16 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> Could you run sed directly in your tree?
>
> Sure, I did that on the  plane. Now on the ground, pushed out.
> Somebody should double- and triple-check it.
>

I double-checked it.
Yes, renaming is perfect.  Thank you!


However, while I was checking it, I noticed some other issues.

I have sent three patches.
If they look good, could you apply them please?


-- 
Best Regards
Masahiro Yamada
