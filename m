Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03013C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9986F20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="i69rsCq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9986F20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeIDOSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:18:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33342 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeIDOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:18:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id m26-v6so2460492lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wtvx+B8HYw0Bv9bEPYWrDOz0YfKqZWVnFMfoxsost9Y=;
        b=i69rsCq/cvoHTWEuLAMvtQayzQWl9LTcHegH0sg/A6M7AGWACajzVksHVQke+iqizs
         cIFRBmthu+hUV6DnPfacBETN2tq/XxvUX0pqCAhfKclB6WDpzcX5Pu/XD4mUIeZ3W9fE
         qPFbfauDElvsyXoyO5yF47IbExMpiSmnpG14hzoLNkZokFEI69RbuaP02CdWLvf1DGaZ
         ZxNYpN9L8g6qOCxBs3LS2ed1yx+f033pTkcHLiz9/KoEFPyo/26Vmqr6Ty3A991N1rj1
         moCbo/By+3bzMBKrfBXCmoKnMB12lAskzpYzHPwFbNscqSwqW3/poQCHQjWS7KZVtDOH
         UFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wtvx+B8HYw0Bv9bEPYWrDOz0YfKqZWVnFMfoxsost9Y=;
        b=HULBo2xmGAyUA0W8YuegGrKFSbB5JxD0FkCxCeWDn7HWIcw8ss4EHMOUNsFZN0y1Rk
         HX+nvGxVO0fvGh+QJXJf5OR3z/NBjraqJSCw2ffsj5k7EPVifbx9g/sAwmiyWoGLwCWE
         5np9cnzOCEhXYas8ydOCZokfhoMRlLE6h+v4M9Gu9MxNNIPrLWS0jOfDWaqTqHuF0Zc3
         gohjwmVWA5IbqUZP1Dc4jLM6J4XXi5f95x7ukrZ6g7NQuwLsuc7WlJ1Ft1lGfvwZ8Ggf
         UzZzw6JIMYOldSmBgVdDL4Zl8CHU/lp10+eWce4Jbfg0Zkyxn1i/a30O+Qs4sbv8p9tw
         to9A==
X-Gm-Message-State: APzg51BXlu3afSxeB0/g0t5i0hyM+fNefuUeJn02KcGDtknnqrLdYTvN
        EUnzMKqBgMtdzykaJM/svuvcGQ==
X-Google-Smtp-Source: ANB0VdajGkw4TgQDFjPfiXI8W5I0zpGOUksbjAgLdNVMAoxrM5FzMZPQbwYpXWdkDPvRClcDkxSn4g==
X-Received: by 2002:a19:655d:: with SMTP id c29-v6mr8230739lfj.138.1536054865402;
        Tue, 04 Sep 2018 02:54:25 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id f18-v6sm3840277lja.85.2018.09.04.02.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 02:54:24 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
To:     javier@cnexlabs.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hans.holmberg@cnexlabs.com
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
 <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
 <7FBEB635-C943-484D-A970-D3BF870BAFFB@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <95ae2794-c671-5dc7-3a2d-2b062ea86fba@lightnvm.io>
Date:   Tue, 4 Sep 2018 11:54:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <7FBEB635-C943-484D-A970-D3BF870BAFFB@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 11:16 AM, Javier Gonzalez wrote:
>> On 31 Aug 2018, at 15.57, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/31/2018 03:34 PM, Javier González wrote:
>>> Matias,
>>> This patchset implements support for retrieving chunk metadata when
>>> submitting a reset/erase command. Patches 0 and 1 are small fixes that
>>> can be directly merged into your patch:
>>>       lightnvm: move bad block and chunk state logic to core
>>> Also, note that these do not apply on top of your for-4.20/core due them
>>> depending on patches that I sent before that you have not picked up yet.
>>> You can see them though in for-4.20/pblk. I'll rebase as patches in the
>>> list appear in your tree.
>>
>> Thanks. It is really confusing when you guys maintains an implicit order and posts the patches separately. I will appreciate that patches that are related are posted together, such that I don't have to manually track what comes before another. That makes it less of a pain for me to keep track of and we can keep the reviews together.
>>
>> This is the patches that I have in the pipeline (from before the e-mails from today):
>>
>>   - This serie - Pending review
>>   - Serie: pblk: support variable OOB size - Waiting on review from Igor
>>   - lightnvm: pblk: recover open lines on 2.0 devices. Which doesn't apply due to the fixes to the pad distance patch.
>>
> 
> Yes, I know and I apologize - we should have a better flow. What do you
> say that for windows like this, where we have a number of patches that
> have dependencies that we post them in meaningful patchsets and point to
> a branch where they are ordered, like in a PR? Then we can rebase and
> propagate changes properly?

I am with the patchset posted, that should have the order. I just wanted 
to mention it. One thing that would be good, if you do have patches you 
have upstream, feel free to push them in smaller increments, so we can 
pull them in as we go. Only a nitpick, it is obviously up to you guys 
how you want to do it :)

> 
> For this window, I'll rebase the rest of the patches in for-4.20/pblk on
> top of your for-4.20/core, then we can propagate changes as they come.
> 
> Javier
> 

