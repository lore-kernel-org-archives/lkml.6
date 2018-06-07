Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AYkfN/6fGFsXQQAAmS7hNA
	; Thu, 07 Jun 2018 03:03:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0C5836089E; Thu,  7 Jun 2018 03:03:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 776FF607DC;
	Thu,  7 Jun 2018 03:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 776FF607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeFGDDW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 23:03:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59995 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeFGDDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 23:03:21 -0400
Received: from mail-pl0-f70.google.com ([209.85.160.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fQlCp-000606-UV
        for linux-kernel@vger.kernel.org; Thu, 07 Jun 2018 03:03:20 +0000
Received: by mail-pl0-f70.google.com with SMTP id c3-v6so4518411plz.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 20:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=Lm2DpBnIt9tYMgelltQq5rQTh7kf4PgcVuMCKK/5z4A=;
        b=bv2m33d73jCclw/Snko9JZZzap8T/Ww2YMGbszzMlwuYsoB3RlAmsJGUiQrS0eNeZA
         Gpsj1ZhNIyUi+tvo7/ZBg9HtTPz1Z10PXKSRnyfPmmgMe2+82ggnjLzDC4AfgdtAkWsA
         nrxS38hBJRS9Ccl27mbkGhprNRbSDQJlKJ30b0UjOGI1JU+odqEK/fRY8FN654YjuwFY
         29kfNw3yiFhgG5j/tOfdeJc7tmFYlnHLN//XNcJxoH+/d6+tHZqTsTJfueyicEYiV+L7
         cdchfDP6q199L/6MloYkwuexrg/dBBYYLGR7Ve2GAyuJqD2gQ3jA8iewYff1g/TTuL/m
         BBaQ==
X-Gm-Message-State: APt69E0mplnvsgfkweiwRXVkwivp/I5nlyQaQZJlhln+WrbCbJ9LJ2sH
        5Ww3WK590dLQMhRJ+TXYmZ0jCgKhf91kqkKjf3R4+aBlIpBYSvGbsGXKta2BEpfRukAPdz66G3M
        6+98l+u2naTlhMYCfaaYBfQqMbVXGpdb8oZPaE4wFQw==
X-Received: by 2002:a65:4d91:: with SMTP id p17-v6mr89941pgq.296.1528340598467;
        Wed, 06 Jun 2018 20:03:18 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKKV+1AhDU7EE2rR4/vX9DU6tndwO/rTB4qCEwc9d8aVLrW+3pQmSLhQceYcQqjj+NcnSr7g8A==
X-Received: by 2002:a65:4d91:: with SMTP id p17-v6mr89924pgq.296.1528340598151;
        Wed, 06 Jun 2018 20:03:18 -0700 (PDT)
Received: from [10.101.46.95] ([175.41.48.77])
        by smtp.gmail.com with ESMTPSA id e192-v6sm14189930pfg.187.2018.06.06.20.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 20:03:17 -0700 (PDT)
From: Kai Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Ryzen 2700 Temperature offset?
Message-Id: <C85830A6-BCC7-4137-84E5-38503873F278@canonical.com>
Date: Thu, 7 Jun 2018 11:03:13 +0800
Cc: Chris Ouellet <rabbit.of.war@gmail.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

A user thinks the Ryzen 2700 temperature may not be correct [1].
Can you take a look when you have time? Thanks.

Also, where can I find all these temperature offsets? I googled but with no  
result.

[1] https://bugs.launchpad.net/bugs/1774817

Kai-Heng
