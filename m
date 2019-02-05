Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C5DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC67D2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPCP7Q1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfBEUXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:23:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55538 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfBEUXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:23:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so269384wmc.5;
        Tue, 05 Feb 2019 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=odC2PcUbX02j3uajrQG/GbGAAUtOSHQxHiuylIGhUsI=;
        b=TPCP7Q1QD1tRSvTYlm70AdoAIeZX09jrfeemUcD6DSq8pMnYKbe/Q/MNhbx7N06x7K
         w0TuipTUTJ9ZE7ilTaTREkiinlQeUWMvxEUE/QBOueNsjOcw1wxfr7edLhmiga5if9fi
         BEo7JdyKwxGUu9I1hwYvMhc+pE5yi2UhdbN/8TFbwByIEXKcgk2E3Rk+mYrR1oumMXAR
         Ib3w4rv+QdfGRft5sshlZL0JQhD8Ie+C5OfEszRPduCG1AluLY0042sWN3XQ6VzU3tg/
         +yTdeN/cLy1zzdrgibfPutPQ3LJlT5jpBsBLmTRtNsvvRmpLSJlNTCsRe8AxikbzIMkl
         4dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odC2PcUbX02j3uajrQG/GbGAAUtOSHQxHiuylIGhUsI=;
        b=pHPCr+Xuqczz3nS7xV7wbX7LejgK1hMZrG5vZnrlwXVZjcfcfdvtKMRorAc3jWdTPk
         h/Pl6SoneIvYyGx9Da4ogCbJwSBcrrL00n5x6E0BNTRfuwVmghW3bjnMiTpJELhBy5Bb
         cAMopyJx21hVJTClQ7lj0Hix7t2GfCgmQYud/90Z+DZBtEv6Ef4rC3DnZVZemUYtHgIV
         Mksj8HG20WpFqLfMRbcRQWm6rO++4VQW2nhH3FChffyOaG5NKT1ybbgy93csp9Y4SzME
         79szVc+qge3AzcWUxUDV/prGgarQNQ4Ld6Nb3wHUnyV+QTQM4xO36KLq23zZkmPNoCO3
         16Xg==
X-Gm-Message-State: AHQUAubfCLCPYOGXaBspzzmfiaWLcqRVkPBzzyg+TMqm+9jjs+XRs/ek
        oZiHKQcJZ/0QlCjUkYNfdRGIHN77
X-Google-Smtp-Source: AHgI3IYrxImaqY6KWOCkDsDQ41o0jmx6jqsdTqmqIfziAHTUSMw+/rz/skN+q6m6iTOwrrKy1nT3fQ==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr360049wmj.48.1549398213010;
        Tue, 05 Feb 2019 12:23:33 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:759b:8dd5:b995:6b39? (p200300EA8BF1E200759B8DD5B9956B39.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:759b:8dd5:b995:6b39])
        by smtp.googlemail.com with ESMTPSA id i186sm25809358wmd.19.2019.02.05.12.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 12:23:32 -0800 (PST)
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
To:     Joe Perches <joe@perches.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, thierry.reding@gmail.com
Cc:     andrew@lunn.ch, nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190204164213.30727-1-thierry.reding@gmail.com>
 <20190204164213.30727-2-thierry.reding@gmail.com>
 <20190204.192040.1074738183781998611.davem@davemloft.net>
 <8553086eaec167846992f1cff12aa388cee81767.camel@perches.com>
 <ca6ca816-af03-e1f9-739a-a06cc4837b80@gmail.com>
 <4aea523a3bc5be0d944f7ed9fadac276b7115002.camel@perches.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <ec6f4c11-ca76-5cd8-8b79-b896f502ddb0@gmail.com>
Date:   Tue, 5 Feb 2019 21:23:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <4aea523a3bc5be0d944f7ed9fadac276b7115002.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.02.2019 21:18, Joe Perches wrote:
> On Tue, 2019-02-05 at 12:04 -0800, Eric Dumazet wrote:
>>
>> On 02/05/2019 10:42 AM, Joe Perches wrote:
>>> It's declared after a pointer so it is already is 2 byte aligned.
>>>
>>> A lot of drivers wouldn't work otherwise.
>>
>> Maybe these drivers are only used on arches where this does not matter.
> 
> Possible.
> 
> I had only grepped through the sources looking for
> declarations using:
> 
> $ git grep -B1 '\[ETH_ALEN\];' -- '*.c' | grep -A1 '\*'
> 
> It's quite a few files in net/ too btw.
> 
> I still think adding __align(<even#>) is unnecessary here unless
> it follows something like a bool or a u8.
> 
> 
I there's such a controversy, then it may be better to stay with
the current code, or?
