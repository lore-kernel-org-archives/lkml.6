Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC07C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247FB20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7RY+3kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247FB20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbeISFbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:31:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40021 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeISFbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:31:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so1731709plp.7;
        Tue, 18 Sep 2018 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mZPKAldKbCcI01OFz/Et49NVhd51bahvI7+K7L24FTU=;
        b=D7RY+3kxyayw9rvSqd46Ivs3rfhqGfd2jBr19+59STUU0WGc6/IuaXToC5KyTJ7k9v
         LLB9wf1AI7mWZ0k2TFMfP88FE8RV6QlL9ymoc/rJrkOZWa1TktlhmgPjf4O0PF/M318p
         G9cbhzZQv0sXk9eKLVMealsOm/cpv/9TEf6LPpt47vDlbGZi2z6WxhuE53QpyJeawuNx
         jWH8O0fMiYH7OCggYPxAebBYxyLvrDHlI3WIldyKKhv9EXMYJOoDT5aWmx8PNtcD505m
         xK5IrctziLlyrwF+RoQvYjvYPH0x4QvA7oHpzyWTvNA/kKGmY7F31zEZX7Xd6pDKtlhK
         SlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mZPKAldKbCcI01OFz/Et49NVhd51bahvI7+K7L24FTU=;
        b=taUJyEmDwccpEiX965VOFdj/Gk2bGnvRGc3sYQnNk8WDW/rJievcCgybGQ2I4bbQAP
         d0VEDrEEmDg5iokACch6mPsyra31ljNo0+zq8T9LnBT7tPSeoKzHhE24/xlTS0hobTOj
         OL68viDzpoVZ3bl9qPU/BMORA1co737q9AtWEeZ779LizacRoOANcCNw0wODbXYeAxU0
         pzL/6p0OMAtjGEbKVKeFaIg0RZLBOU++S2+y0gV1L5EjfPxbIzOGhh7eOxnhNNZNqnmq
         fIdthGaaAC3Oc58EupA1owSsXAdFbP5YbWpKo27kMSYfu7IPlXZqaJDbZDacS6G8+Bz4
         MpTA==
X-Gm-Message-State: APzg51BANDQQ8FHmerVRFu0fsu7Vcw21tebJSn937LdShF7vU/2qMuS8
        pODHIq3MIUnNW5Fq2+jTNaw=
X-Google-Smtp-Source: ANB0VdYuL46JKJhQIQz5lvfdujAXt6Gbe2/Exs+jAO7vxjgMmqHmdLHl2dljFPTFJZ5KUQ1H8SJ5mQ==
X-Received: by 2002:a17:902:5a06:: with SMTP id q6-v6mr32077835pli.330.1537314975910;
        Tue, 18 Sep 2018 16:56:15 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id y64-v6sm20819155pgd.65.2018.09.18.16.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 16:56:15 -0700 (PDT)
Subject: Re: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>, ahs3@redhat.com,
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
Message-ID: <29258606-8255-847c-b22f-8793999ce6fe@gmail.com>
Date:   Tue, 18 Sep 2018 16:56:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c32598b4-3f80-f83f-9b86-1c168752d1e2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/18/2018 04:27 PM, Eric Dumazet wrote:
> 

> I remember one of the napi_complete_done() change had to be reverted,
> for some obscure reason.



That was not exactly a revert,  :

commit 129c6cda2de2a8ac44fab096152469999b727faf
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Sep 18 13:03:43 2017 -0700

    8139too: revisit napi_complete_done() usage
    
    It seems we have to be more careful in napi_complete_done()
    use. This patch is not a revert, as it seems we can
    avoid bug that Ville reported by moving the napi_complete_done()
    test in the spinlock section.
    
    Many thanks to Ville for detective work and all tests.
    
    Fixes: 617f01211baf ("8139too: use napi_complete_done()")
    Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
    Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
    
    Signed-off-by: David S. Miller <davem@davemloft.net>




     
