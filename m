Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323ADC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B376C2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="0T36tJWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B376C2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeGJEol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 00:44:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51347 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeGJEog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 00:44:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so23188578wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 21:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5CAhnSxIJEKTYjytTWId3m2rOMwEQD565W4yXRNyd8g=;
        b=0T36tJWnXOAeqeL45EtDTKeZNr3PUBzqThE94a1L3L3AxMwohQ4ojd6R4ercZqtXbb
         pJgGeG9IInRBmi5kYCaEhgw/ONgx3LvkEbTcDqbWh7ntYz5MKOobvaSnAWs+YWvNHVf+
         4Xp28k9lvkPw7k8Q9jrFd+WHXDAXJvoSQBhpxb3SqD8PjtYLpDf0THt9yP4LW+zUFbRB
         vuryk21MjO9JXj4eN3QHQ58LtVuk+bBk9hxnqq0ebOMXD50jz13L7E8mAyLFL/xxn1pW
         mOVPUiCETv+wJNfHu0VjxHACnv6DL5iBFMLMjBt0tER9fBt2TGuraPC/2ZWcvQ9OP6yY
         cJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5CAhnSxIJEKTYjytTWId3m2rOMwEQD565W4yXRNyd8g=;
        b=SUYerbXviwOc7Y30bSyBrnGwguiehIhzp3epSOocFTBVr5ZAkw+HHEI+j5iuuI+WEv
         eVi2XdbU+Fm/NFVnsyR+KSlNhH8zleSaCyHA912UgjE/0g9LudTD2Bm8xuUzEMdf+zQo
         o5E3+nScltFzM/Ln3io68mJKpJKRVscpVu9R8CrD8uUcNThNiUnmJni71JZbiCbpbtrP
         CtkfNqiNCkF+INuxYzCqKsz5L9kaeWTZlriA+BRvqNpJPJCfSoGEP0oyinHfyRTTlKnm
         WaYX16jc0EcUTNFrUOwlobCESl/Jlh01syA7YXHuKIuZh/BXsw9gJAIuo85Y6chjB5IU
         97yw==
X-Gm-Message-State: APt69E3IiM44l0an4gH7IJAyWQ1ffevbAEr6tGjlvpc2t4mN9k7/svpH
        bcjmvELoi0x7TWwkQp1NsbvGkQ==
X-Google-Smtp-Source: AAOMgpcS9XSh2Fa+Fk5LSjpM60nCNkTkFwADe7zsFlELyRuAp1sxdtU4KgNXkgKxv7nXsX6jqjShPg==
X-Received: by 2002:a1c:98a:: with SMTP id 132-v6mr14130957wmj.86.1531197875219;
        Mon, 09 Jul 2018 21:44:35 -0700 (PDT)
Received: from localhost.localdomain (p200300D993D05D004F14CE920FFE0B2C.dip0.t-ipconnect.de. [2003:d9:93d0:5d00:4f14:ce92:ffe:b2c])
        by smtp.googlemail.com with ESMTPSA id q8-v6sm32130922wmb.3.2018.07.09.21.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 21:44:34 -0700 (PDT)
Subject: Re: [PATCH 0/12 V2] ipc: cleanups & bugfixes, rhashtable update
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>
References: <20180709151019.1336-1-manfred@colorfullife.com>
 <20180709200927.cnypbuyociatmxae@linux-r8p5>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <be986d6d-4388-5d4e-e1cb-5ae28212d120@colorfullife.com>
Date:   Tue, 10 Jul 2018 06:44:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709200927.cnypbuyociatmxae@linux-r8p5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

On 07/09/2018 10:09 PM, Davidlohr Bueso wrote:
> On Mon, 09 Jul 2018, Manfred Spraul wrote:
>
>> @Davidlohr:
>> Please double check that I have taken the correct patches, and
>> that I didn't break anything.
>
> Everything seems ok.
>
> Patch 8 had an alternative patch that didn't change nowarn semantics for
> the rhashtable resizing operations (https://lkml.org/lkml/2018/6/22/732),
> but nobody complained about the one you picked up (and also has 
> Michal's ack).
>
Which patch do you prefer?
I have seen two versions, and if I have picked up the wrong one, then I 
can change it.

--
     Manfred
