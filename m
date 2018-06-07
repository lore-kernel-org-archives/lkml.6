Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vcz2BWexGFtnSgAAmS7hNA
	; Thu, 07 Jun 2018 04:15:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 040166089E; Thu,  7 Jun 2018 04:15:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 423E260115;
	Thu,  7 Jun 2018 04:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 423E260115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeFGEPc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 00:15:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60683 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeFGEPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 00:15:30 -0400
Received: from mail-pg0-f70.google.com ([74.125.83.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fQmKf-0001L7-2u
        for linux-kernel@vger.kernel.org; Thu, 07 Jun 2018 04:15:29 +0000
Received: by mail-pg0-f70.google.com with SMTP id o19-v6so2997626pgn.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 21:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a/MEX5W5+yd1EUbSI0uI9gatx759xfd2dJPxYwJ/GP0=;
        b=U4WWzB4RiwJ+D2AU9RKjU/o4j7Xsf+EGFrJHeAiYDIE+oYtaWGiS5xxh3+FMSCm/DE
         F/sg3zRBVBGmTZZFpgOz12khHnMIJCJX+f/E67CheXPcMgkN8VF2g6Y0pfgxa2+jcsut
         OxUB7OXu//pfKGjrhc9Y6mrQF9vgfaS+ImYt8e9WJiDM/npcvZAoW+5SqyN/EG0tayQA
         yT53GdcZiJrqfGVICOVEB2U5h1EAduAG0uUal+1ydUs4kPxO9JKRHB8e+LigT5gWyvFy
         S0L2Ml2a+FrKst+t/vncud8rHO27PTHYV5Ounj7BR/WcNTR1OCA0d7pi0x8ra3wEMuDp
         Aj9Q==
X-Gm-Message-State: APt69E3zxmKNIny8eJUlpFPMkdoo1J+RSIVgGWjlWnZx1DBuA3lMIu1U
        FqK7Vs67J0yWpoHL5r3t3sS56PewFbh4YUKr1RcGHj08v/DAj2A0xQLc98CX2wwZk+l4VkEHK+Z
        CPPX59xwNr3ysYUGera7m7fOi21Kh7aWCa/OKvueacw==
X-Received: by 2002:a65:5284:: with SMTP id y4-v6mr220254pgp.297.1528344927735;
        Wed, 06 Jun 2018 21:15:27 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKIrR1oa1WZRFvvcQmtCFKPzrnSfDRmNZ+NMqOk6Ob9OYdGtGQO8e36ewqFNNwxRdubYQJNcBw==
X-Received: by 2002:a65:5284:: with SMTP id y4-v6mr220234pgp.297.1528344927386;
        Wed, 06 Jun 2018 21:15:27 -0700 (PDT)
Received: from [10.101.46.95] ([175.41.48.77])
        by smtp.gmail.com with ESMTPSA id m11-v6sm28995848pfk.42.2018.06.06.21.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 21:15:26 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180606123425.GA14898@lunn.ch>
Date: Thu, 7 Jun 2018 12:15:23 +0800
Cc: David Miller <davem@davemloft.net>,
        Hayes Wang <hayeswang@realtek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, romieu@fr.zoreil.com,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryankao <ryankao@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <86FC28DC-437A-4AA4-8C06-05701FCAA5C9@canonical.com>
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <20180605141114.GC14873@lunn.ch>
 <8BAED2AC-DA94-4F63-BA16-EB3D54649BC5@canonical.com>
 <20180606123425.GA14898@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 6, 2018, at 8:34 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>
>> Hi Andrew,
>>
>> Sure.
>>
>> Do you think we should also strip out the enable/disable logic?
>>
>> Or just remove the parameter?
>
> Hi Kai-Heng
>
> How would you use the logic if you remove the parameter?

Hi Andrew,

Just in case someone needs it.
But I get what you mean, I'll remove them completely.

Kai-Heng

>
>     Andrew
