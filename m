Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAABECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F2C206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DasNPpLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F2C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeIOK2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 06:28:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37341 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeIOK2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 06:28:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id n11-v6so3929225wmc.2;
        Fri, 14 Sep 2018 22:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=V1HaSVHTB26yNDKC/4vLD/pGKwRab3hUnXOO2t/0S0c=;
        b=DasNPpLJhLf8RYpf8IG439Jp6vuGzl+5Tzr9FE+QHNOhLHCRVvqnYSeqU+4ZU6KYrS
         hj6XueLydmMfQRh/z7HdADtPBu378v1S06IztNakImqsj7nNwjgmK/0TtSkMVyL9pJdX
         V76fVVPeFFowQHVVz3TZjkd8HxVi7G+QDwr8al2UcfyAgwjAuMoKBiFO0XzHxAtHaBYV
         nMHp6MEdpLj+5QzS2J4WKBoI1FJUJFwBjXdguXoF0WrYlsEhmrDY1HsaYY1PJVTtA9No
         m/8aytNOUysKi0fSeOXzsXYan3mWk2weCEA+QTC17p85U43u8FApSZHlg9pyjWbI5K2m
         qnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=V1HaSVHTB26yNDKC/4vLD/pGKwRab3hUnXOO2t/0S0c=;
        b=j6iAj+V5293j24YPxc8DVmM1HnwZh3L50QkVN2pbkp30Vcn+otkzz17ewe7p/5BL8y
         /owuIZJZFwo1rMJ/IxNjPbi0Ru+wQbogdafNqkBxcgSLFaIQ6xw7gauw4ji3f4zEDbIL
         Cz1+gcRmJf+7Iw27SttefexkSMml4axWcjqIRgRwQ8Mj7h1Q2qLwDpAR7xKtvMGhkBbT
         UP+y4ONulZ6AizrrGGjd8d9r62pqrIjxQ09l7NyATOtiU9pb1qGQxMOiDbzF73B1X08+
         0z1+s/Z72tmWaEloSjjJe3AQtBUSnGOA0vLJ3HU3qsR4PzUmz5sN2s8nT6tcsEF8AwFN
         McpA==
X-Gm-Message-State: APzg51DQw0u1mRXOKuNPh5MPUTnx1mkYCLgWvN85pQ8Ffd9c19sQjW3+
        hOp7Heyxj+53z7g1Aj31Xnc=
X-Google-Smtp-Source: ANB0Vda9aZ+GtLYfJdW9laIBNy5C4JnWVk0u+sSV8SQGBsUI7zrgBdxVQY1wPrDX+fniPAqGtWYZMg==
X-Received: by 2002:a1c:ba84:: with SMTP id k126-v6mr4591627wmf.96.1536988234515;
        Fri, 14 Sep 2018 22:10:34 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w3-v6sm8655137wru.93.2018.09.14.22.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 22:10:33 -0700 (PDT)
Date:   Fri, 14 Sep 2018 22:10:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Clang warning in drivers/hwmon/scmi-hwmon.c
Message-ID: <20180915051032.GA23900@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sundeep and others,

A group of us are trying to clean up all the warnings we see with an
'allyesconfig' arm64 build done with Clang and this one came up:

drivers/hwmon/scmi-hwmon.c:59:24: warning: address of array 'sensor->name' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (sensor && sensor->name)
                   ~~ ~~~~~~~~^~~~
1 warning generated.

Would it be appropriate to just delete that check or does the check
need to be adjusted in some way (such as checking for the first value
'sensor->name[0]')? Either option technically solves the warning but I
don't have the hardware to check if this breaks the driver.

Thanks,
Nathan
