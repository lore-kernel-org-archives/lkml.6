Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6519ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D32720779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is+DBOwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D32720779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbeGWRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:47:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44231 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388574AbeGWRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:47:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so199562pff.11;
        Mon, 23 Jul 2018 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FrzEIpKlhR3jgT5HasOkgioc5dTOl32mD2+oJ0Gbwho=;
        b=is+DBOwYivHF0UxhSgpp+fs6ZfmnBqv0ARE4PqcwfKNgvIbM8nOcKjetzgCNxxpCmm
         lGjBPzSPiQJO4uyDAxe1MI+ogwdLQ1cyYNH2KebU+R/tW7H+v7FQEvfBriyoUvAB3iV+
         KSlnsmdO6EaZJVSeUDMDHHvi5dRO5jDHTWuEGjm46p/Xey6ChfLxTD+GQMf+XgOFDll0
         AK3vsVzDjSuYMZx2A7qzAN+asYqjXd69zr0BTA2XbWkl6NPYTQDcWQ9WWqRGJZQA7F9X
         +kqNQA3XBNi2aqfFp0qbWyyepKLcOHzLjg3JjHyQAocy3TEkV7+MnQaPs1A7Bo1kTvHO
         d3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FrzEIpKlhR3jgT5HasOkgioc5dTOl32mD2+oJ0Gbwho=;
        b=EmMQBTK5a1UEYq+EDK2YDui7Z4Or3eNblHg/51wXl77g2cMli81CV3/TRQLSZXfrT1
         b3yIymhinCjHHguX+IrgS+nsh8KzOLbaPvM2xCOGUVl9BXrGRFKrlBWIrThoS7BDE5W9
         CdtKzF/WIdmhAgF+X6wTOrw7meMh6hy9exqaTgyv+Gl1ONmrgXuIsV20ejPDk+IdcgB3
         Tx0REHMbz0N20wNZfg4sEr773xADwqIcBNwFqpXJMYllQCc4YlQDstsyPwQPRbGYE1H1
         NaeSU4jhYstSsU6ly0pCMpwjB7RvQ1MHVE98qotnUAiA4X492PiWDVcFfVqY5AJpwDsV
         sKTA==
X-Gm-Message-State: AOUpUlEUJKpDzELN3Swo2m26S41lunPE6jsudgvjo+PYRWi8HZ7bvLzD
        hcIJoKGLtrADblPCWlpMyKW4PzKj
X-Google-Smtp-Source: AAOMgpcusH3BMGyiz6G2CGWETWGKDzcKm3T8CMRyUgdxdTp4adQ8J2okZG97QA3Kd8eURw6zbfhuYw==
X-Received: by 2002:a62:f610:: with SMTP id x16-v6mr14096624pfh.169.1532364300399;
        Mon, 23 Jul 2018 09:45:00 -0700 (PDT)
Received: from [192.168.1.52] (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id a20-v6sm18901945pfc.14.2018.07.23.09.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 09:44:59 -0700 (PDT)
Subject: Re: [PATCH v6 16/17] media: v4l2: async: Remove notifier subdevs
 array
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-media@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
 <1531175957-1973-17-git-send-email-steve_longerbeam@mentor.com>
 <20180723123557.bfxxsqqhlaj3ccwc@valkosipuli.retiisi.org.uk>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <a040c77f-2bee-5d0d-57ec-852ff30448e9@gmail.com>
Date:   Mon, 23 Jul 2018 09:44:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723123557.bfxxsqqhlaj3ccwc@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2018 05:35 AM, Sakari Ailus wrote:
> Hi Steve,
>
> Thanks for the update.
>
> On Mon, Jul 09, 2018 at 03:39:16PM -0700, Steve Longerbeam wrote:
>> All platform drivers have been converted to use
>> v4l2_async_notifier_add_subdev(), in place of adding
>> asd's to the notifier subdevs array. So the subdevs
>> array can now be removed from struct v4l2_async_notifier,
>> and remove the backward compatibility support for that
>> array in v4l2-async.c.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> This set removes the subdevs and num_subdevs fieldsfrom the notifier (as
> discussed previously) but it doesn't include the corresponding
> driver changes. Is there a patch missing from the set?

Hi Sakari, yes somehow patch 15/17 (the large patch to all drivers)
got dropped by the ML, maybe because the cc-list was too big?

I will resend with only linux-media and cc: you.

Steve

