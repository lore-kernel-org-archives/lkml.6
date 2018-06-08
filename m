Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id F1NdOGTyGluuLgAAmS7hNA
	; Fri, 08 Jun 2018 21:17:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6A495607E7; Fri,  8 Jun 2018 21:17:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R3p+FDzd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D2857605A2;
	Fri,  8 Jun 2018 21:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2857605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbeFHVRt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:17:49 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55601 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeFHVRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:17:48 -0400
Received: by mail-it0-f65.google.com with SMTP id x25-v6so2559030ith.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mos0gfpd6w10j36phegu4oQKBIBl9TOnyIwdVPZ7BXg=;
        b=R3p+FDzdacbMIi3UDOi/g29WjxiDZMjN9rvZzUZTA2KkyvdikEofBuTUXhZXb8TRu8
         bBvF1PwQ04wNBiqKjGvNM0wCMXnrgra07njJLYVIYOP3BudxMdIGa1d23uDPWXo9XDIh
         TsaljeSWaRc10oY0b7teNexS0VUSth/C/aMwd5Ogwn4FXCTB4VW02RZbANNoZ9Rx0X7F
         dgtTCqnEU7XhFDIO35RhWbkuiXFYoIxkGg7MdFF97ReffgX6DfJBDQcFUTdUmt2KNY7k
         z8kAwYevF1IVuivf2ga2VgHKNIhh8fkbLoekmrXDMhARwavPXEtBQhq2IV5L5T9hBYx7
         68Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mos0gfpd6w10j36phegu4oQKBIBl9TOnyIwdVPZ7BXg=;
        b=aUPXAdzlCnwv/kvDJpglZfPHdHUTbK0VLuJOre4zEDscZcFMMqLYNiuzhU/Qf/0kvc
         QuHYScou8z3aRYuBXjxwlh8vc0YxXER3T0Euxo+L1j+cX90kUSOQyD1+61sgDE54h4Jk
         YYQwtqoGeaehvhUKwytVXBXBs7KAtMZtMbk4r9cqYvNVgSUsDJx+eVlqarMsqsPFxhlu
         1Bt157KBzMT6SPoE1Dho/qMBHLjZIEnB0p738CmC3v3R2IYkxdigM6cnTtu5/PXsm0/f
         P/jgyAKi85cnUYkFjduIfbroJQLvOtatvZ0VQj1H3jK33c8QmNExB1jccv3sIazV0xXT
         OYbg==
X-Gm-Message-State: APt69E0aSQk6+siBb9A6ljbKdH0V4AaE4FKl4tju3pfj7cP0DEf/YJyh
        UauOTaPKgnzcUhrKuzmqe7NKKw==
X-Google-Smtp-Source: ADUXVKIDksPTWXmmkO5Vacgc9crRjpGykCRiOY/Sg1yWA28j85/ZNiYUPgio9+ZBkM8TWsBJQvFmcQ==
X-Received: by 2002:a24:6285:: with SMTP id d127-v6mr3373825itc.52.1528492667765;
        Fri, 08 Jun 2018 14:17:47 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id r6-v6sm8249451ioj.74.2018.06.08.14.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 14:17:45 -0700 (PDT)
Subject: Re: next-20180605 - kernel tried to execute NX-protected page -
 exploit attempt?
To: valdis.kletnieks@vt.edu, Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <21051.1528404057@turing-police.cc.vt.edu>
 <20180607211401.GD4481@redhat.com>
 <136327.1528411295@turing-police.cc.vt.edu>
 <248061.1528488439@turing-police.cc.vt.edu>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4d8ac96b-8537-6f6a-1223-5bf6f75769e5@kernel.dk>
Date: Fri, 8 Jun 2018 15:17:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <248061.1528488439@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/18 2:07 PM, valdis.kletnieks@vt.edu wrote:
> On Thu, 07 Jun 2018 18:41:35 -0400, valdis.kletnieks@vt.edu said:
>> On Thu, 07 Jun 2018 17:14:01 -0400, Mike Snitzer said:
>>> Can you please share what you test is?  We've gotten lots of reports
>>> with failure following wake_up but I don't have a canned test to trigger
>>
>> Just a laptop with 16G of RAM, no clear reproducer -  Chrome with a lot of
>> tabs, a mail reader, a bunch of SSH windows, and the next thing I know, it's
>> locked up good and solid with wreckage in /sys/fs/pstore :)
>>
>> I got bit a third time a little while ago.  Will test the patches and see if
>> they help - looks like I'm averaging two hours or so of active use before it
>> hits, so it shouldn't take long before I know if the issue is swatted...
> 
> Looks like those two patches from Jens fixed the issue - this build has been up for
> 20 hours, and has survived a kernel build, an OpenWRT/Lede build, and a backup,
> along with a bunch of other stuff.

Thanks for testing - I've sent the pull request to Linus, so hopefully it'll
soon be fixed in mainline as well.

-- 
Jens Axboe
