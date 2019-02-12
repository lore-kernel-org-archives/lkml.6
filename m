Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D46C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DBE20855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZLq2QXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfBLQjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:39:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33903 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbfBLQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:39:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so1561173pfe.1;
        Tue, 12 Feb 2019 08:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L02z1FIBkBikazFzN+eP0RP+ZCxyeWB9p9OSSilPHAI=;
        b=uZLq2QXOcXDVgQjvtgpbj+40vFbvckRDqYybJIH5M6IR1brtaA9x6uMGOF2AruHTvy
         13BysocKgVyJw0nV7QuHlzhnhj8EPWR0pmRaB9mJG4kzVG8hu1BzxVsXpxe16hO4KV0v
         Dh62JEbiHtmWe0H/IClczeQmipoWZ0AIjclkFHba9vGz3QApwvyrmd9HxgNoJEfwaSq1
         Sncg0y4fUm5I0anZrrsFqK4lFzfmjTuJCtU8FmWZL5vTwghg8HJAfx4SZOaqNbwWIKuR
         +ESQVmgEyVwL+Ia3E2cuGwGcLetia9X/jqSBPjkfSlXVtGGndxgPpbzGDyMY9YUo4RnO
         I49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L02z1FIBkBikazFzN+eP0RP+ZCxyeWB9p9OSSilPHAI=;
        b=JRfR7yYKtPMjW9ihA/m9e6NPZ+ZgJj24hJklYgFyZjVdOCoE6jmxZ94q3ltn+tqOkg
         KasbrqLI029MNsIDuUv6X8gZMSgqijVE1ste2/174OBJ8SqhAlL+5VDHwtv9UyzI4K04
         0A5b0aZkkjJxpNuw3Ju15nJdNGyLHkFZTatuz4kBhAJqFNexBvBJNQ1GFMrpK2qzA+bN
         HeWOf7Z1y4FRQCzzZut4mi7vAc45g6L6qiNCta9Fl5qii89zmvSn7ZUAcPwvG6JhmsyA
         cdQP2tGbXy6JPp795hysclOx/dfTuXLUKmTNRmcjAZOMYnsfX4fiOinGci2YGpDVO+ZX
         TOxA==
X-Gm-Message-State: AHQUAuaCB+21TF908ep6UaFfxKGmhaNhZtXq8xadTmk3SuSjTGRTmiYZ
        yLh9KfTvo8HyAlgp6bradxGEMCHf
X-Google-Smtp-Source: AHgI3IZpS8rfGbKvsCROAFifPMhBpElX2ScHn5D66L1GvaFWBOi2++BRwL00/yyNNNIGb3BR0oWLrA==
X-Received: by 2002:aa7:8497:: with SMTP id u23mr4841299pfn.253.1549989586332;
        Tue, 12 Feb 2019 08:39:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p64sm23450554pfi.56.2019.02.12.08.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:39:45 -0800 (PST)
Subject: Re: [PATCH 4.9 000/137] 4.9.156-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190211141811.964925535@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <da866ae2-93fa-038f-e084-85f056ba34e5@roeck-us.net>
Date:   Tue, 12 Feb 2019 08:39:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 6:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.156 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 13 14:17:22 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
