Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902CBC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BF12084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8xMhVFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfALRos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:44:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37293 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:44:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so7665976pgb.4;
        Sat, 12 Jan 2019 09:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qQHhQlHzfLIIP7Sb/inEkyt94Ak6DvfF4SiSrn04424=;
        b=r8xMhVFbstDrNHAiZsuf3xe/NkwzUx8gTRYHzCWI+4hKIR1EbjViexIo5tAPCBpMS1
         TAehrRkV6x0yShtcfc/e8e8gUu58TvEi/iTo/XomeZuy3do0ENGYYjp8yk8FxCohs2Q3
         SYzFp5LxWqHUEB+JRVKrRS4SpPLYbEmnlDPljUy7w04q/oSvATOOzeUfXTX4NInir72r
         MBF/zFR1jdX5JouiSOVCSrn7zDzkjkELFcAGZqT26p8tgRiGoqgHnAKjLpgjXUurowlQ
         PEG1V85C/Fa65hWU7iI8W8s6qW46aVwT4IUfjcnumY7uBf1O0wg7YEHahtduWdbqKvKE
         JAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQHhQlHzfLIIP7Sb/inEkyt94Ak6DvfF4SiSrn04424=;
        b=NzgL9OTkd+w1UQG6g+gV+GEtmq7eGDKW4ItQlcJbPAVqYB1e9RmtQrBZ+Cy016AXH1
         yoRXAzpOo5pAkHGAbuL9V2s80xCmB77ac/5oBk0zS1UpEKjPM0MEoV3Kdi2+m80gpqZA
         v4db7NW2kMurBeJwkYlKELPRife57iJMoPO+clCUlW6Q5Q5yFO75s6AxPYpm27bUK1sb
         bN8nSjz9nMA5wY+Tsx6EmRyBGzOSDH6Q+Sn8hQIwjLEcDAEXBZ7NAo+hkOGFtd3FBzxw
         Q2YNq8Y2ABKbrzBLPhf+dfBBFAvOCM2Qv0wnjgmICviHyO3xMcK2O7j8eKAbhdENhxzo
         Htxg==
X-Gm-Message-State: AJcUukc0YLa59wQxGHlR9xrmf9uLP2dTgemtP5uI5veJP8EEX2SP467T
        vd/jf9uI9x4aChmTk+nboKWJU6yh
X-Google-Smtp-Source: ALg8bN7rNokQN35leBxpbtjjKxuSo4KW4L29gUg19GOqu15I31HKR+GWY/sHavD21mp3PNM9818vZA==
X-Received: by 2002:a62:36c1:: with SMTP id d184mr19372349pfa.242.1547315086827;
        Sat, 12 Jan 2019 09:44:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g70sm139163670pfg.98.2019.01.12.09.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 09:44:46 -0800 (PST)
Subject: Re: [PATCH 4.19 000/148] 4.19.15-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190111131114.337122649@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <582d197e-e7e9-ab4f-201a-2958da9e9d0c@roeck-us.net>
Date:   Sat, 12 Jan 2019 09:44:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 6:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.15 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jan 13 13:10:11 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 332 pass: 332 fail: 0

Guenter
