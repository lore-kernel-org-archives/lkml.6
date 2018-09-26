Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89237C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2743A20685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WuBtF53m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2743A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeIZGlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:41:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41519 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeIZGlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:41:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id n3-v6so14196739qkn.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CfPM9gYc94a/9S4AXFUXDFug7hI1BrgOyn5R1CqetSM=;
        b=WuBtF53maI4ggdm7pfsYfNea0OKUVBOzhnxnCDkYBGcsD4+VOdXffcIbGdpsYD3wDU
         rbQeqrG3HuWDVUIeT9APly2nsdxzbAsc8w6ElxBV8uFwyjiyO/l1RFMNTudzPTcN2ihH
         aoBNn4NuMs5c4oYQYRjD/oIBxPpT3kEapKIDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CfPM9gYc94a/9S4AXFUXDFug7hI1BrgOyn5R1CqetSM=;
        b=PcBa1BYq4vfTXg8pA73rt9uuAwIR7+sX8/r/LuhC/z/FeP+zAwhwSwhxSaxDJUmYrS
         Aivhdld3EVB4kxDQ/qXo1VCVKI0iGnO6E3f2FFTOxKSjUZEghRR2nuxzGAIvaphAidCn
         iX/Jb5EOc9viHrpBjIEsHZMsF1FpwO4zW5u1bvlLRhc/osY0LzZ0yREOjpopO8TObmqi
         aD8kVb5zExzRcAIy5kAZXRyGxQbkU+XnI4YT623RMVwsohMU9kbUmGpuT+HOjFvh55xo
         IBLB49fr25+BmLBigwUn4wxPY0pD49eQbSrXAgzYxE+NebCLkHMHSAykJqdhT329dO9m
         pp1w==
X-Gm-Message-State: ABuFfogW58Xz4NfU4q69XTQTrd0DxbHjWfdj8vV+nr9B0O11FbBlLLtD
        irtieZtH+74IeQnCSsID0x5cWb7AQuuYQg==
X-Google-Smtp-Source: ACcGV60yAf/m7lYrGYI6ftONG/0BakhNj6TzqRhLmWkvxmml0Bx2m638mTyyiV8rZgRjuju/VRYVJA==
X-Received: by 2002:ae9:e314:: with SMTP id v20-v6mr2615845qkf.69.1537921902084;
        Tue, 25 Sep 2018 17:31:42 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x6-v6sm1450080qtj.77.2018.09.25.17.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 17:31:41 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] staging: bcm2835-camera: Clean up completed TODO
To:     Aymen Qader <qader.aymen@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
 <20180925083401.22533-4-qader.aymen@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <51a078ef-41d2-d631-7f38-f752095ca117@broadcom.com>
Date:   Tue, 25 Sep 2018 17:31:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925083401.22533-4-qader.aymen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good now.


On 18-09-25 01:33 AM, Aymen Qader wrote:
> Update the bcm2835-camera driver to remove a TODO and an unused header
> include. These were made unnecessary in
>
> commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
> flush operations")
>
> Aymen Qader (2):
>    staging: bcm2835-camera: Update TODO
>    staging: bcm2835-camera: Remove unused header
>
> --
> v2: Make commit message clearer
> v3: Separate patch into two, clean up commit messages
>
>   drivers/staging/vc04_services/bcm2835-camera/TODO         | 6 ------
>   drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
>   2 files changed, 7 deletions(-)
>
Acked-by: Scott Branden <scott.branden@broadcom.com>
