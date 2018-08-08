Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F5C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1958A2175F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedgreg-com.20150623.gappssmtp.com header.i=@embeddedgreg-com.20150623.gappssmtp.com header.b="GvNfB0rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1958A2175F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedgreg.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeHHPO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:14:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44913 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeHHPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:14:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so2171775qtp.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 05:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=slPYLlMOlOBPvjIq4vX/J+ZysUZnpIWAGHvmrhffGc4=;
        b=GvNfB0rYAr0Cxv7xvN6DbcqROlBaPbTi1pAdaJwTil5PMSiFTWF/hSdTb68t50YncT
         pOZEhei5Z9BR8hVdn+PMFV0Y/vKR1m7dANpabwSGO6vd4BTt6wsoF7nOVC4KJKTLbxHR
         Tg3yXvtmg7d17i1DGUCjVb02edFpxYkxgcyQ1XGvAEWKdHkQsJz2tK9GNAy8znojuXas
         N9d11dQjdPPMrwAhQvkReHT07WML+0dLBFLSGe/z3z93ShNPmHbtnS6AR0U/NJNncl2J
         j269Awr7obn3W/Bq4kI19N9rOIotTy5EDlmupvbvc8DiMwF8W0ARAhL+bd0mE4hAuK/e
         F+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=slPYLlMOlOBPvjIq4vX/J+ZysUZnpIWAGHvmrhffGc4=;
        b=Wnp4rWWUGHpHcybMIRS4PW9hfI0jXhrgejiFWRtzvJaPZf8+3DLU6sIoM0wUEtb2jq
         zaqwtoi6FffYu4bRbpZs2pXK2SFAT+7hjVCvH1F82qppRg6sfxebuxKdCR4IcREXfFzo
         dDmRgAghD1NnVFdY9hVvuVVkx7e4v00XgOcFRgEmQAGPSAmQascxAJdvT65SFbZ7bdFg
         IHnaUiHYvs2AUPmkR7Br+tpIvmbEKWAqenNGlbuRDtu63G1LmrKRGwvNcyZKNTUjCF2V
         R+n9/bb1VJgAsKXyZD5fNdy5X/PfOBnU99J9Pg/8HphXJKzhVsy7V0Mh6F+aXZpcH857
         iV8A==
X-Gm-Message-State: AOUpUlFydaRN+9YkFcZM91eOVGVlsWyDrDMYYmDidr31Dq3SGWmmrDJy
        rcStKZ/voiq4cPrY/Gn+mVJtWw==
X-Google-Smtp-Source: AA+uWPyBO80SEGmgtoSORhySidO1FgpOgIHOsE+phxUfhx1mM8pLg3DdeKQauZtFoV7IRFTP5C6Weg==
X-Received: by 2002:a0c:814e:: with SMTP id 72-v6mr2268068qvc.29.1533732892216;
        Wed, 08 Aug 2018 05:54:52 -0700 (PDT)
Received: from [192.168.86.28] ([97.107.227.14])
        by smtp.gmail.com with ESMTPSA id s25-v6sm2852098qth.59.2018.08.08.05.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 05:54:51 -0700 (PDT)
Subject: Re: [PATCH v2] staging/bcm2835-audio: Fix alignment of function
 arguments - Style
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20180808014048.18456-1-greg@embeddedgreg.com>
 <20180808122604.GA27932@kroah.com>
From:   Greg Gallagner <greg@embeddedgreg.com>
Message-ID: <872dfe2f-59cf-baf9-490b-8b489c44ba5f@embeddedgreg.com>
Date:   Wed, 8 Aug 2018 08:54:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808122604.GA27932@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 08:26 AM, Greg Kroah-Hartman wrote:
> On Tue, Aug 07, 2018 at 09:40:47PM -0400, Greg Gallagher wrote:
>> Fix warnings generated by checkpatch.pl for alignment should match open
>> parenthesis.  This is a coding style change only.
>>
>> Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
>> ---
>> Changes in v2:
>>     - Clean up all the alignment warnings in the file
>> ---
>>  .../staging/vc04_services/bcm2835-audio/bcm2835-ctl.c  | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
> You sent 2 patches that did the same thing, with different subjects :(
>
> Please fix up and send only the "correct" one.
>
> greg k-h
Sorry, the first one was a mistake and I should have sent something saying
to ignore it.  I will double check the second one is correct.  Is there
a best
practice when I'd like a patch ignored?

thanks

Greg
