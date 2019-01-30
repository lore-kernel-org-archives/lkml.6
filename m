Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3E1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3BF218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g++mkcpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfA3Xni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:43:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44668 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Xni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:43:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so556963plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Wvobjb7NXQXMRdiH7DXdrRGNV4CSwZvCBzL1HMhp2k=;
        b=g++mkcpNt4ogoblxrJB7HU2HhGK0ymLo3U2/y+ghDam7ii19bVVW5Zms7g2g9VRYUW
         XheG0BrJOUy1pEdQ7J4PDnsg5C8cyb0gNbzuGZdMn8QBH8lmk4EbxSreyNS2tN4JBM5F
         hAsfPJeXKaFMjXbYJ1yzUimNcIPN9FZ6up++Ha0o0tN1JRNMxvmm45I9ecCs0T26/TDD
         zJKWB4OtumoqGhd9njn1OapXfnWvUCaCikO1xc3ttg1fm21vMI3aBOMFN02K+5DNfuko
         UpSs697MF6vKR4JtKzHKDprB6YvOjz9LVbXsh4Qb4srjkfxkBmXUVg8AYVhJy3flYkwI
         ucyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Wvobjb7NXQXMRdiH7DXdrRGNV4CSwZvCBzL1HMhp2k=;
        b=fhoY5gvBzgILSqKnJ6vWC/GQmCZ1/js+MxeeCypsGL4igivQWUfi4MuZv45sxThSrl
         7+2xHDW7gJMk80GofJdDk8b6lCLqVY/zQ8NoZ3VhwutGQIlD23HIIRFuXYcna9eSPuSV
         FQnek26v7pkVkXPmiuoA6uA4SkNmToOeIqDhCDalq4mIIglQzvQ+c9zJxiJO2ZRea0Wz
         zXnwjiJ8WJjPC9uLU8p5BNLlcUS+UAskhUZ12njlB5o9Pcs321CzJPHw3UIRZHT6cbfp
         MabpgJySvfQKUf4VvWRAYkbLLRO1cpzmBtMhyixawtJQoB2ynVVfUTzJkRzQ7gdVaasD
         T5LQ==
X-Gm-Message-State: AJcUukcKMqHL+dXp9I/utBGT5/maTxuozGj0BmEGvAtCNn64jNoALOmf
        9vfnrbWVLxpHcnoIsgb37kk=
X-Google-Smtp-Source: ALg8bN72QtYBpvMlaKHQYPmdt+RCjdmqAgw+yiRjJsepixkCR+Rp4t979WFU/SjNIeLYGMxIt9k2ig==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr33224195plb.306.1548891411914;
        Wed, 30 Jan 2019 15:36:51 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id d68sm4850566pfa.64.2019.01.30.15.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 15:36:51 -0800 (PST)
Subject: Re: [PATCH] Documentation/process: hardcoded core.abbrev considered
 harmful!
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <1396949135-27122-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <20181220000112.24891-1-avarab@gmail.com>
 <20190130111846.0a6b8e2c@canb.auug.org.au>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <82a0b13b-edfc-46cc-ac7c-005f973009c4@gmail.com>
Date:   Wed, 30 Jan 2019 15:36:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190130111846.0a6b8e2c@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 4:18 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 20 Dec 2018 01:01:12 +0100 Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>>
>> Stop recommending that core.abbrev=12 be hardcoded when referring to
>> kernel commits, and instead rely on the git's default abbreviation.
>>
>> Hardcoding this at "12" was done in
>> 8401aa1f5997 ("Documentation/SubmittingPatches: describe the Fixes:
>> tag", 2014-06-06), back then Linus's git/git@e6c587c733 ("abbrev: auto
>> size the default abbreviation", 2016-09-30) had not yet landed, and
>> the default abbreviation was "7".
>>
>> At the time linux.git had around 3.5 million objects, so if the auto
>> sizing had been in effect "11" would have been picked. Now "12" is
>> what we pick by default anyway.
>>
>> More importantly, we'll roll over to "13" at around 16 million
>> objects, which given the growth rate isn't that far off. At that point
>> this documentation will be worse than the default.
>>
>> Let's just stop doing this. Git versions as of 2.11 released over 2
>> years ago use the auto-sizing, and it seems like a fair assumption
>> that kernel developers use a fairly recent git version.

That might not be a fair assumption.  The two systems that I submit
patches from have git versions older than 2.11.

-Frank


>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> 
> Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Since I have been checking Fixes: tags, it has become obvious that some
> kernel developers have core.abbrev set to 7, 9 or 10 (or maybe they are
> running very old versions of git).  Hopefully this will encourage them
> to remove that setting (and upgrade).
> 
> Can someone (Jon?) please apply this patch?
> 

