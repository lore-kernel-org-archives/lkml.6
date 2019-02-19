Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ADFC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F122083B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLmJjV5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfBSR07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:26:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37886 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfBSR07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:26:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so10447208pgq.4;
        Tue, 19 Feb 2019 09:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MHJIbAPU7GTnzrirBn8DEkYlbojHmUetgKSoJwzWQkg=;
        b=tLmJjV5VD1Pko2PiN67xORCglmPaByZzX/uYaIjnhdMjrmI0p6BpVaTWWBxaal/ZYO
         Ww1DwvPwvl9wwOvXKRgUKedRWDZUmXHxJVljJYucg1fMR37TySsUgyP4w99sHU/F5u7M
         1qzAaWg0W8jcHFExfTQMoLiQy9qhDtA7ijXAs73TwRG1UpMNt7WYl9nqPgiPlzK9pUi2
         6u6bJ2Lm0vBTwT9spwYsW7wiXBaEVguKHrsxtrWhCRFDlYHDtO19CaHkxxDgaxPQe2ld
         /JBxQu5EucNebMwx8zoVUHSbPNLdKSCLEdeASU91Gv/4QIE8IXHw8BPNU8T5j0lTW9HZ
         B7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MHJIbAPU7GTnzrirBn8DEkYlbojHmUetgKSoJwzWQkg=;
        b=Kf5VbPYSlNP1jbwqHmHUx2YMYl2MGK/WPubuLGukOhPrBTv/22b5iNtBSrCzKZm1KP
         NWYvqdH3wCZzJ+KWmbKHba+/3sZeD6f85PxujDShTjmah2bWAvib7OjlkRF5cqoZoU0N
         0orb4pIm5yH9Qe7juzHRZtjCXsewxqeNIx+4z0G17ibcKKHoScvt8CDsNBNlTXwZ1K8d
         H8omSnhIiJW6sa3jeohG7k5oTp/PjqZEN4nyoTXk96I+9YUzdoUcWPAVyCtOq3dsrQbN
         5/pUmkX2jmjMIgensCn1dEBoxsU34UVAouoNinLhpDWlTkhIXklPcMNrh3394E2RM+Of
         CxCg==
X-Gm-Message-State: AHQUAuaKcGaCMa74Iyoz8TgmEn5YEnSdoVw4l6JNedSkp5tVxmVKG536
        YjkMVevdw6LbjutEw+ig92TWgI7v
X-Google-Smtp-Source: AHgI3IatcTcVJbIZolI1XlCIzgAUQCYefv2ZMKyI62n9MNZrWqeLikgHhHpT4mwBjs2qqIo4F0+lIw==
X-Received: by 2002:a65:664d:: with SMTP id z13mr7621270pgv.389.1550597218627;
        Tue, 19 Feb 2019 09:26:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d129sm36699394pgc.59.2019.02.19.09.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 09:26:58 -0800 (PST)
Subject: Re: [PATCH 4.9 00/58] 4.9.159-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190218133508.567416115@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4ded156c-b22a-dc9e-6b72-3e33c56c0355@roeck-us.net>
Date:   Tue, 19 Feb 2019 09:26:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 5:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.159 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:40 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
