Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8ifTCNR8GlttFwAAmS7hNA
	; Fri, 08 Jun 2018 12:56:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 349206089E; Fri,  8 Jun 2018 12:56:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMNuUJOr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AE1DC606FA;
	Fri,  8 Jun 2018 12:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE1DC606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeFHM4J (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:56:09 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40675 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbeFHM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:56:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id l41-v6so13299753wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rgwhMFeqPU2cHPKoJVFBYpBUce4YVH0kPTyi3IJl3vE=;
        b=CMNuUJOrFr/542bLiC38dGo7EAYJ3ntddiq10/U2xhSWkQSzXJUn0/H95fI1hAzIkF
         DrqeEnfaXiNxZs3OB4yQama5xHQ0Ffc0KOFBnL8BRH1lKMedRHnaOUmA1HEoU1gTVyT6
         anFSCk/acKnt6fLfAYpfT80HHVkgfmLPNFabE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rgwhMFeqPU2cHPKoJVFBYpBUce4YVH0kPTyi3IJl3vE=;
        b=h7BHE+r6YcfEpH5SmPY0rb5z3QV9bnln56G/Jf38HIqDPhsom99Yh8s0aIqch5wA28
         Rn6D9/4ISZKRMJnZVfuNWq9+r+Xk8YXnqJ2lBKam9FDR4VBnon2T5sTlwI7l7/YhDUtc
         9rBd5+QT7KixWFBQk9XFe3qkQQyuZQaGzNcVyzQo3Ertgng1hSJ8L8l+PfH/m3T6EaG0
         IOP4YDbCZ2duRo2RTF2gxZLFjETmWAWZcd3b4JXAEVi60kRP0cEeXXOFg2XwQs9noOkA
         RfSzjMuwT7Ca/rlJNPGWdzh7k9gz4EgEvn5kzo4ocr31L88eARphzc8LnpRzEQ4b/dQL
         3Baw==
X-Gm-Message-State: APt69E2ouJifKtRPGrrTwUiOuc36oqc/OwADn7uG0v+SQh8MwE7Mgrpg
        J9mXpIwDdJCvd4hlYbauSlWlKT9lfqE=
X-Google-Smtp-Source: ADUXVKJXcD8LJaFOWbY9dPlf44xO9Rj6DewZ/fhNiHboPuEQzfadw2L1wvG1AHuLGabZeMcIk6/OIg==
X-Received: by 2002:adf:ea0f:: with SMTP id q15-v6mr5407629wrm.9.1528462566694;
        Fri, 08 Jun 2018 05:56:06 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id v68-v6sm2328214wmd.12.2018.06.08.05.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 05:56:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] media: v4l2-ctrl: Add control for VP9 profile
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20180530071613.125768-1-keiichiw@chromium.org>
 <20180530071613.125768-2-keiichiw@chromium.org>
 <a16dca32-4198-72c1-cf22-83f18a8cfcb6@xs4all.nl>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <bd56e330-91d2-dfde-4cfb-40b466953dad@linaro.org>
Date: Fri, 8 Jun 2018 15:56:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a16dca32-4198-72c1-cf22-83f18a8cfcb6@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 06/08/2018 12:29 PM, Hans Verkuil wrote:
> On 05/30/2018 09:16 AM, Keiichi Watanabe wrote:
>> Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for selecting desired
>> profile for VP9 encoder and querying for supported profiles by VP9 encoder
>> or decoder.
>>
>> An existing control V4L2_CID_MPEG_VIDEO_VPX_PROFILE cannot be
>> used for querying since it is not a menu control but an integer
>> control, which cannot return an arbitrary set of supported profiles.
>>
>> The new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE is a menu control as
>> with controls for other codec profiles. (e.g. H264)
> 
> Please ignore my reply to patch 2/2. I looked at this a bit more and what you
> should do is to change the type of V4L2_CID_MPEG_VIDEO_VPX_PROFILE to enum.
> 
> All other codec profile controls are all enums, so the fact that VPX_PROFILE
> isn't is a bug. Changing the type should not cause any problems since the same
> control value is used when you set the control.
> 
> Sylwester: I see that s5p-mfc uses this control, but it is explicitly added
> as an integer type control, so the s5p-mfc driver should not be affected by
> changing the type of this control.
> 
> Stanimir: this will slightly change the venus driver, but since it is a very
> recent driver I think we can get away with changing the core type of the
> VPX_PROFILE control. I think that's better than ending up with two controls
> that do the same thing.

I agree. Actually the changes shouldn't be so much in venus driver.

-- 
regards,
Stan
