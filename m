Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E495FC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45A02077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="kpcXt28I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfBLJkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:40:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44838 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBLJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:40:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id b20so672769edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=m40E0RFz2+bZWJt8CP0U1q4pqgosoM86BVYaFPqHB+o=;
        b=kpcXt28IUyxT+naLA33FpJH12VeaVKKzyS/SxRdlD1PZlLCFaV0ptQ0d8OBB0Ybf1a
         4NECvs9zYfN6m1uF1kD1MgzSDBH5dkzRew9k00oro0YvAQnZTf6TE33TO6MpM7xc3FI9
         nrTt0Yjiv2no2DU2DqHe+IeCWflRS8ubR5aIo8fzZ6VdEH7bR7Uiqcwcwh88AgN7zTOK
         nzId/krcrI+Ix9PWtqCmAlSXEvX3j0pAMNtneucmfey9nnRZ7n1ZinmiSjSQPDiNeEMn
         xHHVFgwm4yZH6qRm8jQRT22o1qQABYUOoQ1ToRZ2A8ZUFd2yEaS/3Hg9XFa1YvRCczBk
         mroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m40E0RFz2+bZWJt8CP0U1q4pqgosoM86BVYaFPqHB+o=;
        b=WWklkrMmyNWFPbGoAdBrx3mBUz5Tkx94ySIyBPCyvcoSw0/8Iba2xdhr6p595/nA2m
         MBSJfW5UHFr/Pm7llsl8ORD3ZMGCkz8BNkbwZCxKomRD6xo3x0fwYorFqU5Gcdep1Yzn
         8GeRgMFYNIq/LFFObYMZdjMEgcl1cQbuhRYtYkhtQ5psGgeL/DZBb60QEvDRgtc2eArU
         bQR1lMu8CtEfboT+rO7t2YW2puAESjorZ1uzLiYxeB16WSnCkXRCVx2GFoO6yinO3m+C
         dSuJeDSMLYLQ1UntTjOPiyq5ElxO8GPDNyoI3H4zrnkNbF465i8igqOXwbwRWkin1XsD
         diAQ==
X-Gm-Message-State: AHQUAuZQxcRLuzXIzMIAb2hTW5OxjHQ0V50PUADZZ1kpfEO7b5PjO26G
        C+r532n8KLicnVmz7kcGuUIhgg==
X-Google-Smtp-Source: AHgI3IaQsCKn9lsYZJDD+TCuI5Tm52FaoL00TPKEV0Wuiw1kOmY1dmWRtzJqI48YUgmo1I8YRIh4Rw==
X-Received: by 2002:a50:cf01:: with SMTP id c1mr2347724edk.94.1549964415546;
        Tue, 12 Feb 2019 01:40:15 -0800 (PST)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id p7-v6sm826700ejf.64.2019.02.12.01.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:40:14 -0800 (PST)
Subject: Re: [PATCH 4.20 018/352] ath9k: dynack: use authentication messages
 for late ack
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141847.541071852@linuxfoundation.org>
 <e3740a06-8735-eed3-b427-e924f3e185ae@ncentric.com>
 <20190211170252.GE21634@kroah.com>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <b76468d1-13db-b4e6-beb1-097251f5627c@ncentric.com>
Date:   Tue, 12 Feb 2019 10:40:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211170252.GE21634@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.02.19 18:02, Greg Kroah-Hartman wrote:
>>
>> Dear Greg,
>>
>> No idea if this is the proper location to report this or if I should inform
>> stable@vger.. , but:
>>
>> This backport alone is useless without backporting following 2 commits below
>> also, unless the 2 wifi devices using dynack start off at very close
>> distance.
>>
>> Their commits messages indicate them as improvements, but they should be
>> considered as fixes.
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc6&id=0c60c490830a1a756c80f8de8d33d9c6359d4a36
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc6&id=9d3d65a91f027b8a9af5e63752d9b78cb10eb92d
>>
>>
>> It's safe to add them to all stables involved (4.20, 4.19, 4.14, 4.9)
> Thanks, that looks reasonable, now queued up.
>
> greg k-h


Hi Greg,

Just noticed the primary dynack patch also got merged into 4.4 stable rc

Could you also apply the 2 fixes above to 4.4?


Checked older versions (< 4.4) .. and they are not required there.


Highly appreciated,

Koen

