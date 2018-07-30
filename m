Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6DF160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8030208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8030208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeG3RCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:02:17 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39186 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeG3RCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:02:16 -0400
Received: by mail-ed1-f49.google.com with SMTP id h4-v6so4317539edi.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TnHFGFu58Z7yUPm88ROb3pfi7Jz6EYmtyqLNLtLx89U=;
        b=pG4A11zLf0hEXoEknQqS3robkRrWGkeQ1QqxCoKzp+et3uG8PMCUx0GDbeSsbiLXQM
         2c5KVM78FZv/WdHauWT4Xs5YUghCiiQbEl5qcrqNXJIdgN6g++zWYLow3duZWEBqM+UO
         4oorv2Iv8Wz4UAXP5G3+P1kh8biilMqeFThamOPecFNtSSmzqUJ0YfrWuuTUO54GqZqW
         PzCLaXJVuT55KE26N/eLTLiTU/BpM48/yAaf2xYpFDQ72eco6llQmgyID/obgb6wFHZo
         fEvgfoPxvcDBEK8RUuL4kRtXJO+eOklTykBGhekaLl0CrlpFJOP0KAqyQECkZrxlG0zL
         5A8Q==
X-Gm-Message-State: AOUpUlGCUmuRFxk82A5Ds7DhDy+N9RdTn3cmWMGO1Ammblr8u086qZj+
        WceQ8Ur5RzVrLaXSCbTxGIKokNl8clY=
X-Google-Smtp-Source: AAOMgpeUUs06x0wY08d6SaudTj7oXDxH5N6/LnXrGMakH/Ajffz+pXwbtg+UGpyiiT7uJc4GK2q6Yw==
X-Received: by 2002:a50:8406:: with SMTP id 6-v6mr8687203edp.97.1532964406457;
        Mon, 30 Jul 2018 08:26:46 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p3-v6sm2453588edp.47.2018.07.30.08.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:26:45 -0700 (PDT)
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
To:     Tejun Heo <tj@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
Date:   Mon, 30 Jul 2018 17:26:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-07-18 17:22, Tejun Heo wrote:
> On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas Pandruvada wrote:
>> Hi Tejan,
>>
>> On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
>>> Some minor fixes to be able to correctly set devslp register
>>> to optimize power.
>>>
>>> Srinivas Pandruvada (2):
>>>    ata: libahci: Correct setting of DEVSLP register
>>>    ata: libahci: Allow reconfigure of DEVSLP register
>>>
>> Are you applying this series?
> 
> I was waiting for Hans's reviews.  Hans, what do you think?

Ah I missed that this was another series. With the caveat that
I do not really know that much about devslp, both patches
seem sensible to me, so both are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

