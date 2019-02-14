Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5457BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0DD222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTvMd8aF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439268AbfBNOeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:34:50 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:40376 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfBNOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:34:50 -0500
Received: by mail-wm1-f46.google.com with SMTP id q21so6310746wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4h4vZJi5hhl9iXh8VCUUK7rgNbzEiKYIBsKiagCWhAg=;
        b=kTvMd8aF+72XjqhXNfEqlvg7npXq55iWAaGmhpD0eKWPr+JQhueOkNnfRrRBQcf3wJ
         42sRiG+tAI/vjVqwJZciIcFCmGkVTUYQYmzj4aLgBMe/zNjktLEzp6elfabmB0WMAm7t
         ytYWvVt4mLhC+AYEY5rWLMkEg+smEATlrFAHcsNQTvIPpUsIt1YesnrE7vJe3Zobw7KW
         u7NFE/mbUyVmq2dlRuc0QeUogSt02xTiaL8dzFO+m93u1dfLYVMXR/SkAA0JCSAhWEMv
         WA62G2hGNn7gaGjIcJyHr/A+crdFVV54nmaEf4eF7IDHpJQbYPGP0QMzvsFjQ6OibnNU
         JLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4h4vZJi5hhl9iXh8VCUUK7rgNbzEiKYIBsKiagCWhAg=;
        b=B/6c8xTjTvLQBbzgDbvXNaB4PfVUW7cMkOIU+flIeaojsY7P1uDuZXXJk7BPGWHrw3
         1h0JG8zGiWb5p/QGeSKE70x0nvEYqiNHA81rwCNfQLj1ZHxuMYgn1CzqWhR8IXyt4FEp
         s6YBZ08ziLXmw6l9qWmjtL3sih4ob5cQPJ6wGedjMClUGnJBhpV3cCuqJqMFSMBx81Sh
         5AXaF4wk+bjujNcx0rPjuHvxfuK7YPpQ7T6TqmCeqLWQhZdRJjJOQ7kQQYsKEXJNV/6i
         zmjMqq3z5LCnmCrja/IWFNGUvs/mE9RBH/iGNVUzSENyo0YKuMjSHOXzu6XMgkQasA+i
         kruA==
X-Gm-Message-State: AHQUAuYWawh1GCaALm34jCfrcfsDlT+s+B3DvQFL4OR4PCjSm9YQqjhU
        BajOZQp78p99lkFkSb0vVNPlrQ==
X-Google-Smtp-Source: AHgI3IYx2hhB4Vr2rFX7oM5Msokpf08RzloR28vqrLZrWzHieu+zXq4WKowysraIA1xEBh5D0YkAMw==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr3114321wmj.78.1550154887949;
        Thu, 14 Feb 2019 06:34:47 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id u15sm4780505wmu.17.2019.02.14.06.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:34:47 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <Marc.Zyngier@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: How to know if there is a pending interrupt when they are masked?
Message-ID: <bf2e6e81-7218-05e0-fd6e-27c9c5418813@linaro.org>
Date:   Thu, 14 Feb 2019 15:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

today we have the possibility to mask the local interrupt with the
command local_irq_disable / local_irq_enable.

The power management path disables the local interrupt in order to
initiate a power down sequence. If there is a pending interrupt this one
will make the power down function to abort, thus exiting right after
calling the shutdown function after costly operations. It could be
interesting to check if there is a pending interrupt before initiating
the power down sequence.

Is there a way to know if there is a pending interrupt on the current
CPU when the local interrupt are disabled? Something like,
local_irq_pending() function ?

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

