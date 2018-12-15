Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68051C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F44206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="O4lVycTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeLOBxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 20:53:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33760 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLOBxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 20:53:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so8399142qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 17:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5fLN/04WiJj7PmtbOE2x1OBSl08T5I2Ie0RV1VKgEUE=;
        b=O4lVycTGef9WbcDjIsKfE3bJhLwq67YI4yLwUOWamvak6Uiw8KPHpqQ+dhDX/c3J9R
         Nqb2iriXc3X/rmKaP9ORc4a+ixfnc9Z1V0RLEvJmWJDO2WpB83WPNHPTK5kzL59ugbnK
         aUWi73JGF9hYhNlR9osQuDe7aduYqIW0zBTHvxOcMGaaTopr7eCZ1B3vNjc/VmG5dhZn
         ZXtDtAYCLN4luInbAMA8axm3ounsd2CEXjPZ4l/JbKMXECpxPVvqYrueln3WZ2kwZ1TS
         3+OJHQX6nXbGoGQSpG1RvBbGmqlPZVAHhdYy+mdF5kRM3SFgm0LVF9jvbrWg5Dogh/Yl
         nF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5fLN/04WiJj7PmtbOE2x1OBSl08T5I2Ie0RV1VKgEUE=;
        b=EAiHFRFyCOizCf0En09+1JiqT1xAW7svCgtF8/E8Mn6OVFZJIfpOzCEUEpUXt7rVsC
         nnFlUD0VzSVNPI4HzAJd9ki3ooz9KveAD6B+wMlfj4WlWby0rLsbun3tSklM6oMJuINy
         BG0mPlayqQdKK3w+9VECJKKSTYTBzYwR2jCLi1WB+uDwkc+kBPhTkUonFk40NhvxQvzp
         lG6aCShf6VkworGJDetfpc7pXJI1X1SZmh4Jj64zoNkLZeiWvc+/usX2dv/6rmNwV6/S
         XYuyjTzKZYrSPBNCZ3rFwpGgJv6ohZoQGm5wNXldd1REwAJNuKawqNcUaDYrpxiUfYxL
         U9Zg==
X-Gm-Message-State: AA+aEWa5pSf80q7pOBFCzgM6dPbmldHupFIV8rWZTcFKlBM9Pr4//sYR
        rcVyFSUXDraNy8Xkxe624bUlhTfTMsM=
X-Google-Smtp-Source: AFSGD/VCujxlpKTzIYUw7Q8DIO29P5UGCS9zMFKfbPXpQ3hwDbOqLJsd90b5eSTwIWSVaEV0c/R2tQ==
X-Received: by 2002:ac8:498c:: with SMTP id f12mr5147743qtq.130.1544838829975;
        Fri, 14 Dec 2018 17:53:49 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j36sm4097194qtk.15.2018.12.14.17.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 17:53:49 -0800 (PST)
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
 <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <bea04814-25d2-7bb2-0f74-0530fcd54210@lca.pw>
Date:   Fri, 14 Dec 2018 20:53:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 2:23 AM, Ard Biesheuvel wrote:
> On Fri, 14 Dec 2018 at 05:08, Qian Cai <cai@lca.pw> wrote:
>> Also tried to move the local TLB flush part around a bit inside
>> __cpu_setup(), although it did complete kdump some times, it did trigger
>> "Synchronous Exception" in EFI after a cold-reboot fairly often that
>> seems no way to recover remotely without reinstalling the OS.
> 
> This doesn't make any sense to me. If the system gets into a weird
> state out of cold reboot, how could this code be the culprit? Please
> check your firmware, and try to reproduce the issue on a system that
> doesn't have such defects.
> 

I'll continue investigating those "Synchronous Exception" although it is kind of
hard due to I don't have any source code of the firmware to confirm it is buggy
or not.

I did manage to reproduce this kdump issue on around 5 of those server running a
fairly recent version of the firmware (07/01/2018). I don't have access to other
large CPU machines.
