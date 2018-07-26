Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82680C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAA82064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVW0BSa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAA82064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbeGZPfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:35:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36236 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbeGZPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:35:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id d14-v6so639813pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z1nnKfLgrUe+CwRsREMPheJR9cnGJMJthCy04x3oiXQ=;
        b=IVW0BSa11WgcbH7HZgvwzlBTZ34ON20jjNFI+tIO4ETV/Z8Y32SKrDoNNQdzxQDE3Y
         R0QpopmODzkKP5tCmjqbmlzhlOK6BxWoIC1cdWjBrRPwKa25li4c7YFQ6RZJ/WGpJcXk
         CAuTfCo7xnHkAij2ulNFs69Uc8A2JAidciMzxfGPEcQDbxw47roSNNQPhJVeBdw+2z0y
         tvHYDa4HAZ0PE6TCBVrXZWhZaZ1Ypv31evkfeNbYM6NhAFhcruhERFwbtIOJZGvlxsCN
         8EkmSdOVSlA9pYOj7r/JP1TdkUSw+2it673K67JZ7Afzka3gooDVkxfIi/JJ/jCVVSbp
         xHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z1nnKfLgrUe+CwRsREMPheJR9cnGJMJthCy04x3oiXQ=;
        b=r54Ok61bYUT3GZsfeAuEkdOUQ+QuIAZ1GsW/t22CA635i8weWj88hTGuUyI+8/YFQh
         Za2NpBO4TjesdVIOhHpN8HQpLg2mqOJpCAQHLxloYrPhuFRnjOlHfXTMZsWmf2X9iMSQ
         PtXc5W57JOPYWaFyX1pBijbxFhfmUjTmYE3yfpPfUDERxfEG6mYu0k6+FO1fO3r9mLyQ
         6UWAzv6SAqm9yaqr7xGsRmA5l60tI1jrniPbc+AYE58NOlsmOvMf8mbBJGbpKsVR5JV7
         t8SmiOlY5gq8pnFn7X8vObv2Dvcf2bq0Tl132Ce5iG8bY+rPe1W9/EcxERR5ghrhpQ3a
         Maig==
X-Gm-Message-State: AOUpUlFlZspBesZapjUO3OKAEcV05KKi6ARgdeaEMONB+2t2w88ToXHm
        S6qOb09BnP+IztKjH/9Qmdeg2EuB
X-Google-Smtp-Source: AAOMgpfLXS2seGC0GBOrk+/EQHXknLRNs7SuP85oG4iX4exjX22mc5wayGgnyoe3r9QwkhU+h2i+Nw==
X-Received: by 2002:a62:23c2:: with SMTP id q63-v6mr2325801pfj.91.1532614720985;
        Thu, 26 Jul 2018 07:18:40 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:101.5.211.5? ([2402:f000:1:1501:200:5efe:6505:d305])
        by smtp.gmail.com with ESMTPSA id 203-v6sm3506832pgb.14.2018.07.26.07.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 07:18:40 -0700 (PDT)
Subject: Re: [BUG] staging: lustre: Possible null function pointer in
 ctx_refresh_timeout()
To:     Greg KH <greg@kroah.com>
Cc:     oleg.drokin@intel.com, andreas.dilger@intel.com,
        jsimmons@infradead.org, paf@cray.com, namit@vmware.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lustre-devel@lists.lustre.org
References: <6920e093-ad62-56dc-6f58-36cf8d7ed3b4@gmail.com>
 <20180726141227.GA12445@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <001325ce-9edd-74a7-1359-c47b3ee66df1@gmail.com>
Date:   Thu, 26 Jul 2018 22:18:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180726141227.GA12445@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/26 22:12, Greg KH wrote:
> On Thu, Jul 26, 2018 at 10:02:22PM +0800, Jia-Ju Bai wrote:
>> In Linux-4.16, drivers/staging/lustre/lustre/ptlrp/sec.c,
> Please look at the 4.18-rc6 release for this file.
>
> In short, nothing to worry about anymore :)

Looks good now :)


Best wishes,
Jia-Ju Bai
