Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C4BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC4D214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub8lV9wV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC4D214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbeIRWLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:11:10 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38522 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbeIRWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:11:09 -0400
Received: by mail-ot1-f47.google.com with SMTP id n5-v6so2656920otl.5;
        Tue, 18 Sep 2018 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VZs5gu9VeFKZSibqK+Xlu8440jTsIjOk4EkOPNtPH3c=;
        b=Ub8lV9wVzSLY1T476QbusMWO1IgPcSgZr7E1maUAXRv/DNCV9Cc7RfdfuN5UQz1CjU
         Rcdkts3L3wArHZHUMr3lqNqZt6v3y3TkqGaSlE+WTBYnJ4ly62cXUhOjEmag3pC1Do98
         9SsaCrRsHLOQcH0gyb+Hz5M/1/8QFBnvgxu/W9yef20r2FjzyxlGfJmvf1wux9xgmHlz
         /XtCZJZj1by8Yg7xP429us1VxLTwCsDtvjA9yROSrH5tkrdFlma6sI1zeLgOsvpIIZvr
         89l53US5cx2jO7N+8X1Pxz+TDz5neA6RqESkWeLRm0LQzzYJ+jur79stryGRYUnTQWSs
         ZU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZs5gu9VeFKZSibqK+Xlu8440jTsIjOk4EkOPNtPH3c=;
        b=dMCAwj7MBCyIfd7j7MZG5aLHDsCk82sKz8EXCnvWttb89fMxqoh1sk+iFgNNEU3x70
         Z8iRbkvLsGzkFYC3LltggLzC5FtYgwLP5kCxxKMEsOEmGSql45LV9v4EDshmRDgVsCWy
         ndf/E1EHtUZjjXPFFwqk2iIo4qlhjzy6WUkpc4Yt2+6z7WdOwL5MfuzEXB+oDlRAwfHM
         F26yWpuBvjfHJpaWxQmJ0hz+PJeuKJuomVffsluxl4erRZP3mt7Ud2AqezWp7i2YxvJO
         TElV1+tJv0zvmeZCFWM043+KAtnFgmYopPiFzkGrG6Pzl+HWkfBl26BeIvZa/gNXvB7F
         YZ5A==
X-Gm-Message-State: APzg51C5EPGQY7onbn74IzwMwr6XhJ2E07Tw/duknNi2LoR6BHq7wIiH
        R5e/MgzCrFxMKzdC//ZZOPPpSC6T
X-Google-Smtp-Source: ANB0VdbwSJwv3Xk2ljaV8yJ6JPdznEDVCQ2Sj0cs2QdEkK3QGuQNRaTx70cFSI+42sM48nxabtkL8g==
X-Received: by 2002:a9d:47:: with SMTP id 65-v6mr15944720ota.6.1537288666529;
        Tue, 18 Sep 2018 09:37:46 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v5-v6sm7980467oix.36.2018.09.18.09.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:37:46 -0700 (PDT)
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     jmorris@namei.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
 <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
 <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
 <1537253993.20009.62.camel@infradead.org>
 <14067.1537285833@warthog.procyon.org.uk>
 <745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
 <19247.1537288419@warthog.procyon.org.uk>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <14f91823-474e-1b46-d305-12229dac8967@gmail.com>
Date:   Tue, 18 Sep 2018 00:51:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <19247.1537288419@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> It passes it to each parser in turn till one says it can parse it.  It's not
> ideal, but it seems to work - so far.  Better would be to annotate it in some
> way.  I have considered annotating the type field so that the payload doesn't
> have to have it added:
> 
> 	keyctl padd asymmetric.x509 "" @s </tmp/foo.x509
> 	keyctl padd asymmetric.pkcs#8 ...
> 	keyctl padd asymmetric.tpm ...
> 
> However, this doesn't work with "keyctl update" or "keyctl instantiate".
> 

In theory the PEM file already contains the type of the certificate, at 
least at a high level.  E.g. private, public, tpm.  So if we accept PEM 
files directly that could be potentially a faster way of determining the 
parser to use and would still work with keyctl update/instantiate, right?

Regards,
-Denis
