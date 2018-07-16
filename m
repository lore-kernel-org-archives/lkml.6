Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2A02098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTkNZbuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2A02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeGPKUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:20:42 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34456 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeGPKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:20:41 -0400
Received: by mail-wr1-f52.google.com with SMTP id c13-v6so31173838wrt.1;
        Mon, 16 Jul 2018 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPClG2d08cdqNq/x2Sads1UEH9fo0j7qniwYj2VH6vY=;
        b=oTkNZbucxydChcLL8ITMs3v0wbBz28jNbruRQ16AORP1sARg2tqaYi4sl8jZ9Rc/8w
         TQx3356KJMbD8LyhzSBflbwLqEyMJlVWsv6py2h2jIpnNt+7Ryb1M3jAdBEDeEPhtSEY
         cj+WBMviDjC1H9PVmTe6L9VZ9GgJqprOQlDtcfSbZvHOGxVOMNuxlKuWbfGytTkaNHEY
         AwizkACylpubYfI45P29Ey8f9jxM0ce35uScipgYAb8lWjXkqQnhy6D/5YJhhylODE9z
         xo15DKYyit7vVhBsG6gAQVOk2/pWyxws+vA+EVPouaVMc5mDSv742yypi/ohJoRTHp71
         2Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jPClG2d08cdqNq/x2Sads1UEH9fo0j7qniwYj2VH6vY=;
        b=X2GqcZMPhLeT3BWbEQPPXU21JDCDhi+W9rdcD8iekU+9leR6Wh6L5P8CZFf5MrWNwD
         mvrmwBhLm6H4IFj9oeqc8UzxH3uZ/esPzsjCHCDqlgk9nYJoOXQwHbYwdf6lhj/k7IsY
         hwSEhWma8aejkTPMNNksycml1We+B4JUtjYikoQG4IcWwwyLCwNXlwEQ/EszysdPatZA
         0wc+wqmVDaqYgmiUoE0ta4sEjUMUbRx8SDqjKnF+xQMM1ifJNBy0hLNOcqyAOYnDc/tS
         FqUvni+0C9RNmaWmepGPDy8YtCGKPNTTT4oj2mSvzmdD7uFg+Ip0Y7DfI368SxlccE9n
         zAdQ==
X-Gm-Message-State: AOUpUlFNzjSuuxt0YjEsXmEiB1V3iY4i/w3PGRE8+0cQFvC1kNmBVbC+
        UwxKs7l7TRfKS6eInkYgo+Ohu8VX
X-Google-Smtp-Source: AAOMgpd9Mw++ad88kbr/arFSy9b0DxMy/NSRZGZclNX2HTt16uWSDY+lpryb6JJfcCjj+qUYyQKfNQ==
X-Received: by 2002:adf:ad38:: with SMTP id p53-v6mr12047176wrc.10.1531734842911;
        Mon, 16 Jul 2018 02:54:02 -0700 (PDT)
Received: from [10.178.50.179] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id k7-v6sm7437411wmb.13.2018.07.16.02.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 02:54:02 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commits in the arm-soc tree
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Eric Anholt <eric@anholt.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180716075718.4e5ef491@canb.auug.org.au>
 <CAOesGMhVeo6Wc=nMcEnusa+FfwQBWJnxs0LY-zXm4HMau+SMhg@mail.gmail.com>
 <6a9fa6f3-7aef-a83b-72a6-dc9492964b5e@gmail.com>
 <CAGb2v667K4Z6o-KEQROWuCbgJbKLNX_OCpCBOWaECb_qfRMBpw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <311493fa-18de-cfe2-30b1-6e018e434b44@gmail.com>
Date:   Mon, 16 Jul 2018 02:54:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v667K4Z6o-KEQROWuCbgJbKLNX_OCpCBOWaECb_qfRMBpw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/16/2018 02:24 AM, Chen-Yu Tsai wrote:
> On Mon, Jul 16, 2018 at 5:13 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>> On 07/15/2018 03:50 PM, Olof Johansson wrote:
>>> Thanks Stephen, I keep saying every time you catch these that I need
>>> to run the same script. :(
>>>
>>> Florian, I wonder if this happened when you rebased to squash in the fix?
>>
>> Humm, could be, all I did (and it was not the first time) was to do an
>> interactive rebase with --preserve-merges. AFAICT, all of these commits
>> came from Eric's pull request, so what I typically do is just sign off
>> on the merge commit, but do not apply my SoB to all commits coming from
>> that pull request if that makes sense?
> 
> When you rebase, if the commit is re-applied, the committer changes to
> you, so you need to add your SoB to all commits you rebased.

Indeed, thanks for bringing that up Chen-Yu.

> 
> I suppose you could override it with GIT_COMMITTER_NAME and
> GIT_COMMITTER_EMAIL environment variables, but that sort of distorts
> the SoB if any changes were added due to rebasing, such as resolution
> of merge conflicts.
> 
> ChenYu
> 

-- 
Florian
