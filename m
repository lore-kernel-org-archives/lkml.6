Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36626C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A7820684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6A0+dzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A7820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeIZTTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:19:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33886 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIZTTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:19:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id t15so19045477wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d25qKmMLxsI0vpAKzYGdmjduIQZ2TL9pnNWl1n3eVME=;
        b=j6A0+dzHyzbzcOjdpa+vKroWjf9dqcFkUgK0f39a3WDhSrhb5NBTy/uiGpIh4957Ef
         8vY3e93DmTJCdfpU+JOiXpFXZkrBK65+uRAdhRBg9xTr4lDSQvbBe6IODF7flpcKfnSj
         D93utgItqCf5Rd0i9EXOyWLTpOJB/EP593WZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d25qKmMLxsI0vpAKzYGdmjduIQZ2TL9pnNWl1n3eVME=;
        b=VefUkg/JmeYiXERUVZnz9QIe0QhT3k1GweqGkz9XtE+2EibEhN1NUQAVyQZWbrVSK5
         05R7/7O6pUAYv1WlN7kl5dbSa2KRWNIqnc8Nb8onbJ2N3hCbcjwJo9VAsxKZ0reOZ3H5
         7P/Xy3+0wYAnwO08/i8jMmltE635BxhSzVDwvIEeRiDpu9nB8Don/UBKnbqgNoARW7XZ
         0ESKmQ0DOp8ovaT/H2h1KuWDqJly6btsfKXlaABVb0RDzZ7qz8AGi6cp1i6wSMgSSLAK
         3E/w0CBeNxlhRMPJ5yv32TmoBhfGE4SGqLEdCh7IqpalOWXtwaqRmm/mqblTY1bSete1
         svXQ==
X-Gm-Message-State: ABuFfojKj5t6YZdNWF++kJnrpdvMI2qSNZQ8rikmiM1laypPdLlescAR
        FFgBo7lGjaICyHszxA4Wu0fgtg==
X-Google-Smtp-Source: ACcGV63lP2gRmcUddDmH6iBlQi29B9mBa+lUeYdghx4OhvbhkTvk2UygP5KGgZ1GFFS0AFNLTROb/w==
X-Received: by 2002:adf:9799:: with SMTP id s25-v6mr4825673wrb.283.1537967201860;
        Wed, 26 Sep 2018 06:06:41 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id b13-v6sm5641163wru.51.2018.09.26.06.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 06:06:41 -0700 (PDT)
Subject: Re: [PATCH] rpmsg: core: add support to power domains for devices
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Suman Anna <s-anna@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>
References: <20180615095939.1331-1-srinivas.kandagatla@linaro.org>
 <a80cce14-9e57-32a2-760f-3d29de009f99@ti.com>
 <91dda9df-8074-925d-dcd3-d7c01e6f2363@st.com>
 <9afb010d-397f-2103-6692-bb4ca55b8236@ti.com>
 <4e1b6773-c4da-4638-eee7-2f996d387903@st.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0c06bde3-59f2-fad4-90ff-5818e9bab853@linaro.org>
Date:   Wed, 26 Sep 2018 14:06:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4e1b6773-c4da-4638-eee7-2f996d387903@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/09/18 13:48, Arnaud Pouliquen wrote:
> Sorry something was wrong in my fw used yesterday for testing...so
> forget my previous status.
> 
> I re-tested it and I have the same issue (-ENODEV) with rpmsg device
> probed on ns announcement rpmsg from remote side.
> So we confirm the issue.


A revert patch is in the stable queue now for 4.14 and 4.18 stable.
http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Issue reported should be fixed soon!!

--srini
