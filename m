Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EVqBMwIWHltKdgAAmS7hNA
	; Mon, 11 Jun 2018 06:26:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1203A60791; Mon, 11 Jun 2018 06:26:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7FDB360385;
	Mon, 11 Jun 2018 06:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FDB360385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753990AbeFKG0T (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:26:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38330 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbeFKG0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:26:18 -0400
Received: from mail-pg0-f72.google.com ([74.125.83.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fSGHR-0001FG-7c
        for linux-kernel@vger.kernel.org; Mon, 11 Jun 2018 06:26:17 +0000
Received: by mail-pg0-f72.google.com with SMTP id d2-v6so2302260pgq.22
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 23:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=qOQKzYYxEDKUPAe6+ipKXvO11GL/2Fj0MGEGacU09tw=;
        b=mBBg9DlVVGymFbkyuPsw/y2Ip1NgKcm4SkWdZHOTplOcl/QyTjmJxd8CQ5WuOZslkr
         Ly2N80R3HhIbW4l86wFuhvsPlX/MK0FA/xm0UoBxJn2xYDa1G7+YmXKlcNv1IX65cNve
         J3wOBqdxQsSdQS09+278ICQ5etkNNuN05rQjj1PiZEI6lTI96Zenw/BjshC3DJ1FmgE5
         t5hml5mc9LA8KEJhUlMyz9AzyJ+3XiwbL83CUsBWPESSBGh6MUAPouiOyZu+CWRfs+3b
         R37KZAMgZQu1G8X16nVzJ7ytJ5fgOxDLdL2Dk4JwERM27mbfwmPoqR/UpLNX1i5A/lCT
         GF0A==
X-Gm-Message-State: APt69E0DilYlMIUf/YgAalF8C78X6ncniL+iD4kELfMZCUk2qyTCMlub
        BfLV1PhoreAc/j1byK0E6YnwxfEbu4oYQXWMlHD+27hCzGu3/fQIpOMd5djsbVfOvfpqPsTdNPE
        WvFTtWf9TQ99pk2LHbQQ0l/jnJ/8NmsYpFa5+jH04ZQ==
X-Received: by 2002:a62:9804:: with SMTP id q4-v6mr16173074pfd.65.1528698375956;
        Sun, 10 Jun 2018 23:26:15 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKKU53slhice0vSYOiEz/PDLKVvtoIyZPtwJmD2SEmrjgu4iz0Vq4gzb852kebnKq7EE2CwH+g==
X-Received: by 2002:a62:9804:: with SMTP id q4-v6mr16173063pfd.65.1528698375720;
        Sun, 10 Jun 2018 23:26:15 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id r20-v6sm1408923pgu.25.2018.06.10.23.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 23:26:15 -0700 (PDT)
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Possible regression caused by commit a192aa923b66a
Message-Id: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
Date: Mon, 11 Jun 2018 14:26:12 +0800
Cc: Ulf Hansson <ulf.hansson@linaro.org>, perryhelionsemail@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

There's a regression report [1] that says commit a192aa923b66a ("ACPI /  
LPSS: Consolidate runtime PM and system sleep handling") is the first bad  
commit.

 From the looks of it, it didn't introduce any behavioral change. So your  
help is appreciated.

[1] https://bugs.launchpad.net/bugs/1774950

Kai-Heng
