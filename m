Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC5EC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F7720841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F7720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeGLRTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:19:10 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:41056 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeGLRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:19:10 -0400
Received: by mail-qk0-f172.google.com with SMTP id d22-v6so15787397qkc.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mxVJfEER+J5B3l40i01U/7LJQDG8BOPAQdROdUmpqm0=;
        b=XXIo/BZKa8UFNTztu23Xo3JtELcjLEWE9jOCHSGPAOManTrItV2DynCrGn4zdpEcXU
         mltiebFHq+j8ZEDPf6HE4cAh+n9aBsaqq4WCf26SaDzsFF6/eZF3AlUo8tOuGOWkG5f7
         9DMZQ753UEHe81Z7PT+mJm7X78oS0Gc/V9wJSAgDRiHh76YrPkAyV/9z5zrRZm9BheI7
         RGsWvMzNTj6KbUkmCE2KMQ3fNbivk1mLGGSe8d253xd4DYuowUB7+SQGefbhS9f7GYsw
         FBXUxi+xitIUG/4KmH5t4P7KFJIRMnpRTkiC0zQpS8nS/uFgil/kEsJkS8TM+uEwFEyt
         FEiA==
X-Gm-Message-State: AOUpUlGXzApaZzT6f2D5enVia/+wM5cRHkYJLSB+TBpnEs2SUl65qhNE
        ERIWz0Voe/SFiY2nZhNSxM/FXg==
X-Google-Smtp-Source: AAOMgpdl7Df4FkMNu0WERfwCdyYU5HVoOvA+qRN2c24YR7fBMA6qKy6M5mA7MzC06poW3ajUE9bHtQ==
X-Received: by 2002:a37:4951:: with SMTP id w78-v6mr2585312qka.2.1531415324419;
        Thu, 12 Jul 2018 10:08:44 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::1941? ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id s1-v6sm1792244qte.89.2018.07.12.10.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 10:08:42 -0700 (PDT)
Subject: Re: [PATCHv2 0/7] HOSTFLAGS and HOSTLDFLAGS from the environment
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Jarry <robin.jarry@6wind.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20180710004602.21599-1-labbott@redhat.com>
 <CAK7LNAQ0dWqaYkLjevCuboCBovcsTV1cMh48qv__wwMZs-vAxg@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <bd8bd678-c42d-4b04-fa55-00c6f524a4bb@redhat.com>
Date:   Thu, 12 Jul 2018 10:08:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ0dWqaYkLjevCuboCBovcsTV1cMh48qv__wwMZs-vAxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 03:13 AM, Masahiro Yamada wrote:
> 2018-07-10 9:45 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>>
>> Hi,
>>
>> This is v2 of the series to set HOSTCFLAGS and HOSTLDFLAGS from the
>> environment. The changes are mostly minor fixups requested and also
>> include documentation of the new options.
> 
> 
> 
> I checked this series.
> 
> 
> I left minor comments for 3/7 and 7/7.
> 
> Unless you disagree,
> I will fix them up locally
> and queue it to my tree.
> 

The fixes look fine.

Thanks,
Laura


