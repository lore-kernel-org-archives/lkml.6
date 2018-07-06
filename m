Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E23FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044B823FDF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZbks8sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044B823FDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbeGFHLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:11:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37538 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeGFHLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:11:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so3092032wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9rw4Ium1tKYZDh6jKoI//lh1yxHjpYekwpDgHrZgDyE=;
        b=IZbks8spMSgSKvpm04gx0HbbckOjZZDohRyGPcS804U2K98BbKgPZSGWOk05+GxwDm
         LfmjHYcgMTYDF5709CTeHeH/4Vfm/SjCmmfvYRtcpwOLJSXnEfL/VBLoT4LtKwkE045N
         3/3W9MlbWSCaVk5XAW6zt0LD/1S6TmBWf5eGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9rw4Ium1tKYZDh6jKoI//lh1yxHjpYekwpDgHrZgDyE=;
        b=t/g7ilJZwBhMvqscVOP3SUihj4xmvDT6+nLb8h/DnGLBj/UM2MzdhP+7ecIXaP4wBm
         puMnyQ9zcOPJDm8knLAmzfxpkgqBf8rLGOue1+eCro9PG+m1qMoGbnteyaugUduh5qra
         og5WU3x6KScbC/N29KWEZPXzPSP9PEIJ56a16xUWLjNH6BwJ3nD/lAmAJ60sR+JHSHqW
         PclQTDWlQpjUCcDFhzRsO5kk/lF9z3aawIrSvkajwuDo71/0FB5efqZMvBXzaqIXbwsM
         ULP9tlsPd2wpmq2IJsIADwtMlFUgjooT8faqfM/l/uTS5bMAMa7mdxrtiJ2k/r17Z0pK
         XTnw==
X-Gm-Message-State: APt69E1JWEDRIAKSJXS6mngh0nJcPODezp0maQhKTw41tKmr/VucFVCR
        j2iVazjnbB6xphOB4LOmK04m7g==
X-Google-Smtp-Source: AAOMgpebGQcTzC+dBriEAGIV1TJd9irJrpD9VlIUCJfVWRI+7MzfHJm5uUgUIVny1YFKVpYdqwOvBw==
X-Received: by 2002:adf:b309:: with SMTP id j9-v6mr6224118wrd.207.1530861068768;
        Fri, 06 Jul 2018 00:11:08 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm3781837wrs.59.2018.07.06.00.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 00:11:08 -0700 (PDT)
Subject: Re: [PATCH v5 00/27] Venus updates
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
 <CAAFQd5CQCF=QvTgq8v6K6W6C0Cy27CzHsMxQn+FnML97w9xnCw@mail.gmail.com>
 <150eb3b4-8b64-6050-6a4e-e06cfaf113cc@xs4all.nl>
 <6abf8da2-b2e1-1b4f-2727-f9d074081c30@linaro.org>
 <CAPBb6MWoysaL_i8i7HaegRCsfF29bnOy2L5ZHgEwDuSJ7HVO2w@mail.gmail.com>
 <CAPBb6MXoiGLdSuufbJ39va4emswC20VZq+U4X8+_PUa++yh=AQ@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b0d3c876-9f3c-7af9-0b4c-cc8293aa6437@linaro.org>
Date:   Fri, 6 Jul 2018 10:11:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPBb6MXoiGLdSuufbJ39va4emswC20VZq+U4X8+_PUa++yh=AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/06/2018 06:55 AM, Alexandre Courbot wrote:
> On Fri, Jul 6, 2018 at 12:00 AM Alexandre Courbot <acourbot@chromium.org> wrote:
>>
>> On Thu, Jul 5, 2018 at 11:52 PM Stanimir Varbanov
>> <stanimir.varbanov@linaro.org> wrote:
>>>
>>> Hi,
>>>
>>> On 07/05/2018 05:08 PM, Hans Verkuil wrote:
>>>> On 05/07/18 16:07, Tomasz Figa wrote:
>>>>> Hi Stanimir,
>>>>>
>>>>> On Thu, Jul 5, 2018 at 10:05 PM Stanimir Varbanov
>>>>> <stanimir.varbanov@linaro.org> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Changes since v4:
>>>>>>  * 02/27 re-write intbufs_alloc as suggested by Alex, and
>>>>>>    moved new structures in 03/27 where they are used
>>>>>>  * 11/27 exit early if error occur in vdec_runtime_suspend
>>>>>>    venc_runtime_suspend and avoid ORing ret variable
>>>>>>  * 12/27 fixed typo in patch description
>>>>>>  * added a const when declare ptype variable
>>>>>>
>>>>>> Previous v4 can be found at https://lkml.org/lkml/2018/6/27/404
>>>>>
>>>>> Thanks for the patches!
>>>>>
>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>
>>> Thanks Tomasz!
>>>
>>>>
>>>> Are we waiting for anything else? Otherwise I plan to make a pull request for
>>>> this tomorrow.
>>>
>>> I think we are done.
>>
>> I would just like to give this one last test - will be done by tomorrow JST.
> 
> Confirmed my unit tests were still running with this version and had a
> quick look at the changes.
> 
> The series,
> 
> Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
> Tested-by: Alexandre Courbot <acourbot@chromium.org>

Thanks Alex!

-- 
regards,
Stan
