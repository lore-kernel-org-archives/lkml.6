Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B20CC65BBA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D4820875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EndqdA2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D4820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeJFCCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:02:48 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46187 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeJFCCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:02:47 -0400
Received: by mail-yb1-f196.google.com with SMTP id o8-v6so5840467ybk.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J2IVob/3KxqCbHNI/uAHh+5ZTOhDNy3iqyANn3Y8xbw=;
        b=EndqdA2JZzR5E0xNC7uFiswCYLFSiw6S0wPD1LPDrrY2XlMzPjGS8ZHGWT4KJDe+gn
         EIPHmplSlUY7+C58GjE0FuPZI7YIHzX+a3o115/8MRlQfWZhsMdjH1/W/S6TM8+KCnIK
         1qMzyQoBbkMYAzsqHv8EoTygl8TsJO+297yfi9qv0LI8xa33yfpQRaMe18Lc8sxjdr58
         poaXWOPqlm62PWz4lBd10wcpFNhfZ8MF9QZzXnApCFQlE+p8pFde6A5D2y+IizAW+DdY
         dUSwBXqS+ioGKkpXv6/hrILgkTanMd6+oi4r/wh1CarLlCUF/g5Rl1bhiu5qvMop82jy
         5Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J2IVob/3KxqCbHNI/uAHh+5ZTOhDNy3iqyANn3Y8xbw=;
        b=UX2KNTtdg208YBqs1cwD6mrVSvY30B4jQu2bcXhluDwNk7TDHZnoUrBKiRYyZo//Vf
         vhx/5dlh+/nn0sspwDF4YxYp82dulRrB6WOUDOqLcKZquoKouxcdla/IqpjH3pyBkYta
         Mn3PAhdPgQySKQoOaK3mSX2AEZl94Bl0DOQZhpgmVHs+x9SrNo3xhMawXpg4GRtV7vAA
         c67eVQ7xwK/7+hO1PyC5pOxq8eph9Qhvc5Qz9jQDVQeZJxc9yVgHddYcEAMUTx7keLVH
         J6immkCWdIgz9HYlsdRregrfKEkgbgJJSUciBEEFQ4HbY/Lgda8Xj1BgAPkEAdLsXHep
         wI9A==
X-Gm-Message-State: ABuFfohSep8W//lgnw52vRQU6Wg4P0f2cVKZ87cp7NNhvo/yRow9aBIm
        XJzstVeFFnz4HZSKMSK0UI1myApn
X-Google-Smtp-Source: ACcGV61sZXRsSyQYXEVeOnDJaT4WwAFria/YzErITgTHfjEpPLLGd0CRZkiBzga0ReLkkKSCPy4YWQ==
X-Received: by 2002:a25:7613:: with SMTP id r19-v6mr7169840ybc.204.1538766165082;
        Fri, 05 Oct 2018 12:02:45 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s187-v6sm3332686ywe.10.2018.10.05.12.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 12:02:44 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] mm: Fix for movable_node boot option
To:     Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
 <alpine.DEB.2.21.1809272241130.8118@nanos.tec.linutronix.de>
 <20181002140111.GW18290@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Message-ID: <166980d0-03fc-382b-84a9-a7431dae1580@gmail.com>
Date:   Fri, 5 Oct 2018 15:02:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181002140111.GW18290@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have not reviewed them yet. I am waiting for Masayoshi to send a new
series with correct order as Ingo requested.

Pavel

On 10/2/18 10:01 AM, Michal Hocko wrote:
> On Thu 27-09-18 22:41:36, Thomas Gleixner wrote:
>> On Tue, 25 Sep 2018, Masayoshi Mizuma wrote:
>>
>>> This patch series are the fix for movable_node boot option
>>> issue which was introduced by commit 124049decbb1 ("x86/e820:
>>> put !E820_TYPE_RAM regions into memblock.reserved").
>>>
>>> First patch, revert the commit. Second and third patch fix the
>>> original issue.
>>
>> Can the mm folks please comment on this?
> 
> I was under impression that Pavel who authored the original change which
> got reverted here has reviewed these patches.
> 
