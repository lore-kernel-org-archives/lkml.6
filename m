Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE2C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mj/tubEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE2C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeLJVgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:36:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52290 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbeLJVgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:36:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so163737wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zIQjiS4QCt4AkoDN+Y9dTrrxkvV6/u+IfiXkC0gUyBg=;
        b=Mj/tubEBwQdrt0/+vE/YdBpflj5r3F2Nc4s1CgotndK/33d9LnAH3D4BuY6Cyrf+6U
         A+nQrPDvK3Jcw3PEv0JNkE02qFMl9TDw2hDbmCTLr+JG2WYpqVWIoZS66wg82TLbwRPK
         WveVklOg4cQqe5A9EMJBRylRWHMt99VUyVtxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIQjiS4QCt4AkoDN+Y9dTrrxkvV6/u+IfiXkC0gUyBg=;
        b=kA1Es6GeAXXpoOl31bOjfJT6uMH8F3GbxxwGQ567aKhmxYYxU5NAfh+LmaJEUcz9nk
         UuA/sRCQGOFjk6fL/70yaQaURO/yNC70Xp4MJcSVO4cmoSm+LHWqETGWZisnzIy5kc8k
         etlHWSMxkWe4xAzbp8SuB6VijzHsxgkd6TgjYQuKJAal/x56lipiI+5LnzXWzGdXSdyQ
         we4lRIs0/xWkjv6e3+LkM4mt61xMZo6e+bk1KMhnd6WIhm1bmM7Un0H6r/78HdaZGZfB
         uQB+CKPPW1cxuAE/yfB24MGJLPuRBKM4bSJs+UVLb1hTMtmPHtP7lSckzNB1m4nLbu5R
         U97Q==
X-Gm-Message-State: AA+aEWZYBNJN0bHhqp+Zo7S+o/yySmO4dPJYFf23nxcHm0gqvNZa7lMU
        ugYqQhDUqur5SwM73/L292cjbw==
X-Google-Smtp-Source: AFSGD/Wtg8Ru7N+irRF39jEpwysxPX9IcjyxT5sNrl2UYL7DEQUcU5tjvAtObaagmWl0YnaJxnKbTg==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr73744wmd.36.1544477811099;
        Mon, 10 Dec 2018 13:36:51 -0800 (PST)
Received: from [192.168.1.8] (hst-221-5.medicom.bg. [84.238.221.5])
        by smtp.googlemail.com with ESMTPSA id a1sm8494192wrw.76.2018.12.10.13.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 13:36:50 -0800 (PST)
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
To:     Andy Gross <andy.gross@linaro.org>
Cc:     arm@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
 <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
 <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
 <20181210190513.GA25288@hector.attlocal.net>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <84d1b299-2898-2df3-8b78-f9510f7bc229@linaro.org>
Date:   Mon, 10 Dec 2018 23:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210190513.GA25288@hector.attlocal.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.12.18 г. 21:05 ч., Andy Gross wrote:
> On Mon, Dec 10, 2018 at 02:20:47PM +0200, Stanimir Varbanov wrote:
>> Hi Andy,
>>
>> On 12/8/18 7:13 AM, Andy Gross wrote:
>>> The following changes since commit b601f73130a375c912d9f2ec93c5f3cea5d6a3da:
>>>
>>>    drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)
>>>
>>> are available in the git repository at:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21-2
>>>
>>> for you to fetch changes up to 92def04bd7b46f5b186f985d5c9d3804858c3c2f:
>>>
>>>    MAINTAINERS: Change Todor Tomov's email address (2018-12-05 16:45:34 -0600)
>>>
>>> ----------------------------------------------------------------
>>> Qualcomm ARM Based Driver Updates for v4.21 Part 2
>>>
>>> * Fix MAINTAINERS email address for Todor
>>> * Fix SCM compilation error
>>>
>>> ----------------------------------------------------------------
>>> Jonathan Marek (1):
>>>        firmware: qcom: scm: fix compilation error when disabled
>>>
>>> Todor Tomov (1):
>>>        MAINTAINERS: Change Todor Tomov's email address
>>
>> I saw this patch is applied also in media_tree.git, not sure that is
>> problem though.
> 
> Which one?  The maintainer or the scm?

the maintainer one.

regards,
Stan
