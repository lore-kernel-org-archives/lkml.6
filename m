Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70332C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2432522419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ggYimpHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2432522419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbeKMQDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:03:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47005 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeKMQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:03:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so2498558ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TsdH83ImEuDenFbgPRUAEwAa3OlRMnUDZi1H5NM1uqw=;
        b=ggYimpHopcJHd8fUjzjaqO2j5XtMgTTpYv0SU52eSbSH9jR/NvORILA1rj6Kq0U/AF
         Jvf9cFmODGWLaatqQA8Eh2N2WGkbTgq2t/Z1xuKXXFedBLlSiNT1YOtyPnfVaSimenYX
         MoB8zel4z2Q7jAuRA1pTACWSmTcEUxB4b9tleXRCLKWk/O2U1Muu9E4C4xwx4GihFiHN
         ySjEGVrjKKkRTVrozxad/5ialMfzqMBVkQz2iPR1hr0rRURHeX5EDXr9mxKUM3xIMLuj
         7xWJnhovXVVuj0P0vO67pF+4L2hIJCh1uU5jaVsv8+sc9JMChPOsqhisyblh98wSEm+c
         OTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TsdH83ImEuDenFbgPRUAEwAa3OlRMnUDZi1H5NM1uqw=;
        b=PTQ8mkmWvIfqf7bF1SX26neOI/2gOxp/kofrS+W5Pcr6xWSFsmyE3yslsdIC1E7SaZ
         YAgqReRAm9bLP90Y/qWGowdjbCKn7GybySzUwiaNGumDkZJIKBaquCmo2z4bwYjse8SP
         89NopV8ui6SFLJZtKiA5PeiyhbQ+jfWP03lLo0oXNNRnCotXrJCly15PYUz/xFs8jKT5
         0nKPYB7/Szk54xTU2+ghR7Q/ZXgf2/ldZRqd4+5z7WtbpyH585eUMAaoMdAXBDl3PUOc
         DBEF5mOcnAFdYcdM0iijUuuAbtmfO+7eaTnk4c+vXzbwbSPnzFsydBu9mcAykjgXYHed
         hwcQ==
X-Gm-Message-State: AGRZ1gJ31q22iyWXkAHL/ENFhy346h55vsO4iTA/3FepOvXd4K2JZLwe
        9ZrcBTxFVaj36a+23qSSHHb+YaD3LukHnA==
X-Google-Smtp-Source: AJdET5fI9USVD+PudYzgJ1DFUy0+Q8ozkc9Plwjr26pabOp0cDXTcjqo3QzQqvxJfCyGhB4jJKTptA==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr1907685pls.167.1542089230090;
        Mon, 12 Nov 2018 22:07:10 -0800 (PST)
Received: from ?IPv6:2001:569:7bc5:9200:d0dd:4df:a733:be16? (node-1w7jr9qsvepeg3v6w8yp18e1i.ipv6.telus.net. [2001:569:7bc5:9200:d0dd:4df:a733:be16])
        by smtp.gmail.com with ESMTPSA id n26-v6sm21874828pfh.166.2018.11.12.22.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 22:07:09 -0800 (PST)
Subject: Re: [PATCH] bpf: Remove unused variable in nsim_bpf
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181112221042.11160-1-natechancellor@gmail.com>
 <20181112141414.4dacb194@cakuba.netronome.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <427c8392-ed04-d0bd-76bf-21af79a71eeb@netronome.com>
Date:   Tue, 13 Nov 2018 06:07:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181112141414.4dacb194@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-11-12 14:14 UTC-0800 ~ Jakub Kicinski <jakub.kicinski@netronome.com>
> On Mon, 12 Nov 2018 15:10:42 -0700, Nathan Chancellor wrote:
>> Clang warns:
>>
>> drivers/net/netdevsim/bpf.c:557:30: error: unused variable 'state'
>> [-Werror,-Wunused-variable]
>>         struct nsim_bpf_bound_prog *state;
>>                                     ^
>> 1 error generated.
>>
>> The declaration should have been removed in commit b07ade27e933 ("bpf:
>> pass translate() as a callback and remove its ndo_bpf subcommand").
>>
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> 

My bad, thanks for the fix!

Acked-by: Quentin Monnet <quentin.monnet@netronome.com>
