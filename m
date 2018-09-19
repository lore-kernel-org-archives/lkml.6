Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47433C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26CD214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdfNMj8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26CD214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbeISFjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:39:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38837 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISFjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:39:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id t25-v6so4757324wmi.3;
        Tue, 18 Sep 2018 17:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xi8BYVwnTmnFsPXuYxzHa2DGhNwhWSYIhtGMQslQI10=;
        b=XdfNMj8tCq8R/IQ+vgJ7gwpwBMiA78xLDUXGCOTVJ4YXR1CZ3L5b7O3/fL/kneAVsO
         ydxG5XojOAFKl4x9N/b7o2W7Qhu9NgG5uw1UQJSeRuNixuldT9/wwEvYGvzmEPwkkfsK
         rL7uHm72nREcfa3j98XJa2PAmBQd5cLapINrXs6pToIV0QWILX/Obp/7RB8uM6RstlLB
         Fv24C3oYiOiP7LGRTwvulfNL7mGdYY+qAVGZlrTuoUWPxYoKDyseY9p2M8oaFUWvTuq/
         4fsWqIvFRgCb3v5RdhdY0c6+sQG87bEAWiZeV2Wn1p6ILIn7RpyOQ0oaBz6TN7MLoI+g
         SN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xi8BYVwnTmnFsPXuYxzHa2DGhNwhWSYIhtGMQslQI10=;
        b=uPePEy5/mX6x3y+Kgm0UpJOHR/S29dju72vkVkV0op2voFq/r7FYyEondoK78BD1KA
         oyKkCzcdYAv8xpiR5ea64k2+ZQTGo3aakI4Kp+FEpkqG7fp7Qgnv6pZUi/nCXR9rPzcB
         Fq6LlLYxz8EMhOBaZtB29Kij82yEQ/SRRbZ5vXMrdVZ01sUY6exTBPNvfDisgJpCDcRD
         8Yv7h6bIle3F0+A34QQjpK4wmQYrHCBZdZo//sa6Fdr0Jjnjfph5gUiOpcMKdYPcPY0v
         qE3Gw21TjLqC5X+mpE9J/Z5ALvvm3oEJrWRwBIiuDhZKaxFQ5XNYrGjiN3XshKKSgZvF
         VfFQ==
X-Gm-Message-State: APzg51DqR4LMDQTwdWyG2AIbRz3ucf8xryJ+oDyyyO6Zucpp+iuGeF+D
        1QhP1dE5jyh+w3tR1rbV8Yk=
X-Google-Smtp-Source: ANB0VdaekRZFnnobPma2APLdIDUY36tsQagbU/P1ncKklYj6lBBlZ20m6aXZmMB6s74M9aMbnU4n/A==
X-Received: by 2002:a1c:c345:: with SMTP id t66-v6mr6513539wmf.100.1537315442198;
        Tue, 18 Sep 2018 17:04:02 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 75-v6sm5443270wml.21.2018.09.18.17.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 17:04:01 -0700 (PDT)
Subject: Re: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
To:     Eric Dumazet <eric.dumazet@gmail.com>, ahs3@redhat.com,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "isubramanian@apm.com" <isubramanian@apm.com>,
        "kchudgar@apm.com" <kchudgar@apm.com>,
        "qnguyen@apm.com" <qnguyen@apm.com>
References: <20180917233533.28626-1-ahs3@redhat.com>
 <20180917.193531.1424852853827678152.davem@davemloft.net>
 <a5adee73-dde7-d00f-e7ef-1f81dc7c813a@amd.com>
 <4929e93d-508a-4670-9450-66e4fc85be7e@redhat.com>
 <cdb8a00c-a3bf-72e0-38b2-3c4b2427270a@gmail.com>
 <c32598b4-3f80-f83f-9b86-1c168752d1e2@gmail.com>
 <29258606-8255-847c-b22f-8793999ce6fe@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <0e0f3aa6-9b6e-edd5-226f-2e23de9b5a0f@gmail.com>
Date:   Tue, 18 Sep 2018 17:03:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <29258606-8255-847c-b22f-8793999ce6fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 04:56 PM, Eric Dumazet wrote:
> 
> 
> On 09/18/2018 04:27 PM, Eric Dumazet wrote:
>>
> 
>> I remember one of the napi_complete_done() change had to be reverted,
>> for some obscure reason.
> 
> 
> 
> That was not exactly a revert,  :

This is what I have so far for the drivers that both use
napi_complete_done() without checking the return value and implement a
ndo_poll_controller() callback:

https://github.com/ffainelli/linux/commits/napi-check

> 
> commit 129c6cda2de2a8ac44fab096152469999b727faf
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Mon Sep 18 13:03:43 2017 -0700
> 
>     8139too: revisit napi_complete_done() usage
>     
>     It seems we have to be more careful in napi_complete_done()
>     use. This patch is not a revert, as it seems we can
>     avoid bug that Ville reported by moving the napi_complete_done()
>     test in the spinlock section.
>     
>     Many thanks to Ville for detective work and all tests.
>     
>     Fixes: 617f01211baf ("8139too: use napi_complete_done()")
>     Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>     Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>     
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> 
> 
> 
>      
> 


-- 
Florian
