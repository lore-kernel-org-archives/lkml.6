Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138CFECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBC52086E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt/Hte9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBC52086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeGUOeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:34:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34429 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeGUOeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:34:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so9086609pgv.1;
        Sat, 21 Jul 2018 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=59OXgxrUqLjsIZUOgxj5qqVpfwZ6uCigoUi74NQ3mcU=;
        b=mt/Hte9XNEbN5AvEdrHzu+7n39S4xBFtwc35QliWOJ+kL2ABzeAjxqmr+Ahu/fKUfc
         L3YF/aU4WchZWVaFdfpQ8S4lcBcPLwxfzD1os2/gvZqTCxFLNj0z5V2mkRfpl/TdX7/A
         wh7HUrMHZLb/rSqN46n1TiSZZNz8GTz6RDKXpcrox+icnPuCb1Z6m2uMlVDjZPp2br1n
         m9jQ2Wp3Q7J6jIegZozbSI7hpjiDm/+FWd6mCFo/eMC++2YVM6bTQlGOsQ9EmunZyKpK
         19WP01t7TIXwB21PQt+mEDhbGezbKYWGTa9BUJkWr9wUyeZeJkPQANuoDlTU93x8HAvJ
         G1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=59OXgxrUqLjsIZUOgxj5qqVpfwZ6uCigoUi74NQ3mcU=;
        b=a8gMejAOKmbAVdq877RRb7ovJYnRpJ0HOre/l/wFnM5o4/3V8UyUs2o0Ri0gDaIEDs
         S4bg02Frm1TQfBfk6ztdN6+36N6Hktd/KCd097Ua/fnzcV3ptpq3ivCqo47BANKraXfy
         gHlh8ai7hkG6npixKr5nKpzeGFS05u2iSuGkVn90PBoB+uxETrmdNra8uuQzb/h6b47Y
         teUKfgJBObQpz0mLfbqs/EfP8v8B5lvdlweXLKH7pJA2ciRtesUi9cyeui2VrGMbxB7G
         U5Mm+zQ0MSmEOrQZDKeeOo3qmNHRnjWijEd6n7JQwWPv8OcbKPbcxAlEJijzSA5E/Hab
         VAzQ==
X-Gm-Message-State: AOUpUlESUFIhHOR9/cna6UwbfvZxm7a89nZPN2rRPNcJ+/eEKnUxbQz6
        5jGiZnqHkaig54fjZe/kBHWXt9gH
X-Google-Smtp-Source: AAOMgpfWVeURUBxfxHWBHLJjb6/WRn3MuxrkTfco1q4nmWP1buWpO7vOur2vMp3SprFpMNF0XiZYrg==
X-Received: by 2002:a63:3444:: with SMTP id b65-v6mr5628497pga.396.1532180491125;
        Sat, 21 Jul 2018 06:41:31 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 13-v6sm6361005pfw.131.2018.07.21.06.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:41:30 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/92] 4.14.57-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180720121417.206337808@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8680637d-316a-c68a-e80c-0dc9afbbe2cc@roeck-us.net>
Date:   Sat, 21 Jul 2018 06:41:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 05:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.57 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 22 12:13:50 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 174 pass: 174 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
