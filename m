Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83AEC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 10:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B20820989
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 10:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUAGsdb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B20820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeGAKr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 06:47:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50510 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeGAKr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 06:47:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so5219217wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8gWo01FTGDnLnCL990+wPkqI6ClCjnS70+ct7Bnju+E=;
        b=BUAGsdb3lJii5kGPiE61vumJibXfVXrQgJb5Maf0xBjK8zwxe6E05KC4I2BoOyQupa
         AFmKg/FYglstH2ozNdYW6X5w/oJYNWiCY68jDFXm/Wgi7cCv02mlEpBmacMNRhUhRdd6
         AbhhOkAAV++bksCmNVklRdffid+Iuyh54b8G1XUJNCvVlHkaGk54/AV2phcjrXNWuRmm
         7gfTTht50cqOeaj+pG64P42cnCbLN0VK/73wqm6+wcmSWw09MX/TVmnU3Rdd813hllzE
         Bi9UO8+FnNoCqVEO9wsSS1dNqlHG6ZdKcDrLHko3sm54EbPDwlk4uZVj3tIUjw3w9yQZ
         dgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8gWo01FTGDnLnCL990+wPkqI6ClCjnS70+ct7Bnju+E=;
        b=PiDZBnU6HihEebBVKAn+9b80rpCNccvUCZaMfMLMHmqVHSSFyG151yYroUkXzfQ5Y0
         GyCYYrXNqhmRNjIN7VfczUl2m8EkTj+BLqVRjrDLbChE5IJ7l9YbonLbkb1VL5zasW7y
         KtXUgjmlNCG0XTn88v72UV8fMpwLcj3GrVBccNX14kytOaV5843wmOT6xIBmm3K9Hz+w
         wI3yLASfEYRUfRXSt/R94uq9SbuoTH4wCAkC66xX+eHjRylyhUOEmftkofhZzNy92jIu
         Lv+BE+jst2aSBrrGs9wIKOi0H4JNSZ7H3Tm+om2wAjjGaTHsR4rDVyD649J8rMPLC4Tk
         dVBg==
X-Gm-Message-State: APt69E2czJrmd8EH0m9TAVW5TOySLrWIfQUnCikCKBdPy95aMAZBw9Vr
        MG0uohQBxgSn9Q8hhqnxsX+Ks8Oh
X-Google-Smtp-Source: AAOMgpco0vCTjX+qQbSedXQCWqrjlxEcorn2VgpZsY8MRVnX70R2kfu/90bjexfQ6mn0hJhmJZB6Aw==
X-Received: by 2002:a1c:1983:: with SMTP id 125-v6mr6074874wmz.79.1530442074794;
        Sun, 01 Jul 2018 03:47:54 -0700 (PDT)
Received: from [192.168.1.4] (x4db08e9e.dyn.telefonica.de. [77.176.142.158])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3852788wrl.18.2018.07.01.03.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 03:47:54 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: remove rtw_ioctl_rtl.h
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180630145941.13118-1-straube.linux@gmail.com>
 <CAHp75VcEXHbOAHgf5jTaP9ZP99wGFBVhXkuohsVd-cD6QQWBkQ@mail.gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <c76079d8-0745-8459-b40d-2bccadffbc69@gmail.com>
Date:   Sun, 1 Jul 2018 12:47:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcEXHbOAHgf5jTaP9ZP99wGFBVhXkuohsVd-cD6QQWBkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/18 11:14, Andy Shevchenko wrote:
> On Sat, Jun 30, 2018 at 5:59 PM, Michael Straube
> <straube.linux@gmail.com> wrote:
>> The header rtw_ioctl_rtl.h is not used anywhere.
>> Running 'grep -r rtw_ioctl_rtl *' from kernel root
>> directory returns nothing, remove the file.
> 
> Just a side note, using `git grep` is much more efficient against
> kernel source tree.
> Something like `git grep -n rtw_ioctl_rtl.h` in this case.
> 

Ah, I did not know about `git grep`, thanks!

Michael
