Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EACFC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A9C26076
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBGMpvF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A9C26076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934846AbeF0Pwq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:52:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41059 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934712AbeF0Pwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:52:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so1239174ply.8;
        Wed, 27 Jun 2018 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RzIFuYG4YHYyN57UPgGrHT4kwybdYtRQzfdVERfqgIU=;
        b=SBGMpvF0tojKgJYhhM6gSFKFD6PSLynKKqt8kCY2zk+IRPb45ISYGB6unJgrOnoCWg
         r+TBlUuvJ2ugNKcrKioX91bQyTbUuYcretNEUxQwg0LFs7W8zkgrZJ6YeaF5qT2gfQ+5
         fziWeDd4TN494jUOr+jmqj7fZ08po+I6Ki0xhN7zULjCjd9TeHOfu47HCrhrZphcDWNU
         BN/VwQvg4ngnE/g4txfe9sKsgSVaEtELRWesfeQ+mZmG5rhtatGkv/KjPmVETjfu1yjn
         ue8My3zs256IQHYriUPFP76DV1fqLrnbxL3VDEnzJ8xmNmj5DKhYSA3OlwSGIb4+nqKD
         d3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RzIFuYG4YHYyN57UPgGrHT4kwybdYtRQzfdVERfqgIU=;
        b=YLSEmKrptH0nzE0hr8ezJu2OvI5qngbIQolY1jd2NDzS4x8TT40c0HlEQ5lQ7yfsoG
         TkZxg/abcNMZvS62HTYZ2cwXKTorY+L7umD8Zugk8c9k+AyA1gAOnXSsCKIuNczZL6Hp
         BOHrPFT0n1mC0oTyYCJS6RgW7VzbYa94pHz66ArLCAqHaqAy9Z/nePR/r3EC1235CZED
         s9VTr9iGiR8PzxWbHE+bua1x0vOIVjUh0rBJJ/f1pXYJhYK5/BSlzN6sAwU2z9SDMS4V
         YPTfIRiU//x0HYZIaTz1zVzazMKV6iXeWRQmzuM0v9nzpoddOzreC7AEy/A6v1V6TB3j
         lUew==
X-Gm-Message-State: APt69E297MG2aoL8TQqrLVfBtHIEhBpjzFrLP+J8/sCJGKufyA9mgmcl
        UkRiBczR8dg+bXuIeSV6KTUvbzZH
X-Google-Smtp-Source: ADUXVKLR3Nw+kG9hN0PFvfCUylQb7M//jUugvSOTOX/qUwkGF2j6Hia2PR9QCQ4UEMAVyUACLgSvOA==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6-v6mr6714331plp.21.1530114764000;
        Wed, 27 Jun 2018 08:52:44 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id t3-v6sm12503489pfk.161.2018.06.27.08.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:52:43 -0700 (PDT)
Subject: Re: [PATCH net-next] tcp: replace LINUX_MIB_TCPOFODROP with
 LINUX_MIB_TCPRMEMFULLDROP for drops due to receive buffer full
To:     Yafang Shao <laoar.shao@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1530100216-13070-1-git-send-email-laoar.shao@gmail.com>
 <c89b70f9-e70d-35a5-b9a7-7e3ed7d34edf@gmail.com>
 <CALOAHbCdRjq2n37GpeBdorcbxXMDX2vNDLftypViJd5hRTA28A@mail.gmail.com>
 <72f02552-9375-bf81-6a03-42656168b583@gmail.com>
 <CALOAHbCRJWThE6oLH0m9ZV8xRMMCaZFM68eSGcm8awRbCLqOsw@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <62f71b1a-6f2c-a475-a8df-4c4ba3a32285@gmail.com>
Date:   Wed, 27 Jun 2018 08:52:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALOAHbCRJWThE6oLH0m9ZV8xRMMCaZFM68eSGcm8awRbCLqOsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 08:38 AM, Yafang Shao wrote:
> On Wed, Jun 27, 2018 at 11:27 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>> On 06/27/2018 08:14 AM, Yafang Shao wrote:
>>
>>> Got it!
>>>
>>> What about introduce a new counter, i.e. TCPRcvQFullDrop ?
>>
>> tcp_try_rmem_schedule() can fail for many different reasons,
>> not related to how occupied the socket receive queue is.
> 
> Yes. So TCPRcvQDrop would be more specific ?

Yes, this looks better.

