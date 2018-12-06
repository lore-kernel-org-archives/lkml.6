Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19316C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18E920838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="UvNI1Ae/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18E920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeLFQO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:14:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40311 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLFQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:14:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so1225416edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LCW1bCSteb3gKdzMEzfg9xFg+S1/4JBxkabx/QOmQt4=;
        b=UvNI1Ae/XAJAEMLrHi/X84bsM6L3+s0QDsNB9fD5RQ0wOG+IHYxgphLV/gyqMIoeo3
         Dzft/OIEDnha22DxE1w/XCtyXFFXumtN+DxFwt5/uJZfVSTg5LO+xQ6HqD4OZIa93Pi4
         kmX4+5TzBDU5JUS5edLfqim1QGtxKSU7Kh26fpHBm4GOihDFlUNmaSQtmo/TDlILmRxz
         FRoG9rrO6yp0A+/5hri4+GYS/K6xn/YRFmgP6m77/UJv6NrkhuMh62or9++ftAMhtVQT
         mGPfbrFpMgf6Qyg8pCcWer6KN7AlqyA+VzWzENQVDmJp0s6henJAvALOP1Ng04HUjfeK
         CyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LCW1bCSteb3gKdzMEzfg9xFg+S1/4JBxkabx/QOmQt4=;
        b=C+/0x8AebKE5rY4opIxxhygM2W+qJ1hIUIgLyQ9GsIVeuYazA8qfYs/2uenyYUFJ+A
         SVPAEC9Bf+4UEN0N5xRdD88BeRdy3w/h29ihb+z4YDrRMYOo0NuSdrq40KQx4fQ8Ajxr
         kWGSn9kH3RSFj+r3e9KDZITu49wGaLlyUi30i4AYosnxR8nf4iLS/8lAYDmrPQEsisDQ
         5yR9OT/4/R/ust533Te2zFjWZmYSDiVtHSjthxM9oFL8X/Ejm/oFGuBdN7aGNBhs1mVp
         5OpAa2+RnZJQ1qUWdX9Uf0z9c+ZWPJT88ernmYWaqPQhfRI/wWvAxFbAJxFAcSzJ5PCC
         Mkfw==
X-Gm-Message-State: AA+aEWa2A3rQoZ/oAdgnW7Epnqs2oi2zC0SlzKYxGmk2nR7vQiGzmC0l
        dhWaWTtKTwZUEKTFg5yHjD0+AOnbI/Y=
X-Google-Smtp-Source: AFSGD/XWg6NVmPFSXmaxV/yKRDZz6AMKc32AxCkllxm8c3OwOQTyjFfSRkUw80ex4ttntURJ2ubkbQ==
X-Received: by 2002:a50:bdc8:: with SMTP id z8mr25016785edh.46.1544112895551;
        Thu, 06 Dec 2018 08:14:55 -0800 (PST)
Received: from [192.168.192.38] ([80.111.179.123])
        by smtp.gmail.com with ESMTPSA id s5-v6sm158227eji.25.2018.12.06.08.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:14:54 -0800 (PST)
Subject: Re: [PATCH 2/2] staging: greybus: Added space between string
 concatenated
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sicilia Cristian <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
 <5b215b50d4da9a7730450a83fb5e3a167b65e03a.1543956271.git.sicilia.cristian@gmail.com>
 <42632636-9b08-bd75-b789-88ef82f52c2c@nexus-software.ie>
 <20181205210034.GA24054@peano>
 <e7902148-4f80-2d9c-7f51-d6bd21bf9eff@nexus-software.ie>
 <20181206150516.GA1774@kroah.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <131a4c41-2c5f-a660-5190-52ce5d59e532@nexus-software.ie>
Date:   Thu, 6 Dec 2018 16:14:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181206150516.GA1774@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 15:05, Greg Kroah-Hartman wrote:
> On Thu, Dec 06, 2018 at 09:43:46AM +0000, Bryan O'Donoghue wrote:
>> On 05/12/2018 21:00, Sicilia Cristian wrote:
>>> It doesn't change the result string
>>
>> So why do it then ?
> 
> Because it is easier to read this way and odds are checkpatch is
> happier.

Fine.

Sicilia could you please amend your commit.

'This patch fixes the checkpatch error "CHECK: Concatenated strings 
should use spaces between elements"'

and then feel free to add my

Acked-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

---
bod
