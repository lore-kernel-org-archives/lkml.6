Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A2020850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akjH+2eW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfARDxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:53:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37383 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfARDxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:53:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so5400301pgb.4;
        Thu, 17 Jan 2019 19:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7yhRch6FR1X0atml6/N3oFIVRlkdBvqnao2ux+lG9kY=;
        b=akjH+2eWJp+159BLzoIqxs6OSGZ/iV3uC0DA6rs3FLF1pYSm5f2IqhlR4FxvhewwTp
         jiwSjqQYO3kt2LuqAVk/NuFSx0L5m57F3VjXP9EbJ5S7Xf96H9dNXIkuSEYqKCwsx+bw
         wpSkfUAMWq65uzPu9yDvS3I+9xD47IpG+kpLt+Q1wYJHjWReONj+UUF1Oe3KK09Q5SMH
         KdTXmRVyljMPbbxOYiGWaB7aNHQf28ut12Iyj9gvzFjcOMSchFb1tqtLD+hS+PyeX38d
         VKQQPVVCXtLtpOsASePsV9qGOcNpFa1u3Maw+2ovbtNR+vIsq7Spo30VCwOmwH3lARwL
         zYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7yhRch6FR1X0atml6/N3oFIVRlkdBvqnao2ux+lG9kY=;
        b=lkBqx+a/+EN2V4B/i2OVcXVUmJQ0xtEv6mZxjiZGLWCzwFT82+BWqgxuJJbPOz1G8c
         k4burtb0n8Rz2zoeQadmq5es9NZJvGEtX88Z/DpI9cDYesti1Xr7bM6+DLxQiY1vPce3
         6E5Oj1Df41RaW82KMGJvzKsr+JwjKhm2eXnIANFNcupfxkxEGKKy+Svlsy+3iGm1Ff6z
         DiUwQUXOyiGfyKa1i7DDfT+gTn0vdc6BI+hv/mdiEEbpRP0SP5/ss4Qgo9C8sop85inF
         6p3tXefGPbM6fKA27M5cZaXa/G83At22+9v37eW0kKQ4MxnzIZwHdYBm+R0oPWsNGgP7
         SvNw==
X-Gm-Message-State: AJcUukfv585mvNajLzLQDxcEmDmZzz0ToafeDDXS8iO7ksUOHMALc3YU
        lHSZkzyd0BxCNEaXht9Mvw+St3kQ
X-Google-Smtp-Source: ALg8bN6kpFtPikooXqnq3ypqTXw2kfkZv2UM/0Kf9AJL3fT3PGNuNVJBeWV4Q72EJKj16gYP44ZIJg==
X-Received: by 2002:a62:68c5:: with SMTP id d188mr18217276pfc.194.1547783629598;
        Thu, 17 Jan 2019 19:53:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p7sm4954066pfa.22.2019.01.17.19.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 19:53:48 -0800 (PST)
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
 <20190117181603.GA14800@roeck-us.net>
 <bae21498-32be-6842-adce-1fc5b9c7e263@codeaurora.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a10264b5-74a2-2d80-a523-2ab1f4ca02b9@roeck-us.net>
Date:   Thu, 17 Jan 2019 19:53:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bae21498-32be-6842-adce-1fc5b9c7e263@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 6:58 PM, Sai Prakash Ranjan wrote:
> On 1/17/2019 11:46 PM, Guenter Roeck wrote:
>> On Thu, Jan 17, 2019 at 08:49:42PM +0530, Sai Prakash Ranjan wrote:
>>> This adds the support for qcom watchdog suspend and resume
>>> when entering and exiting deep sleep states. Otherwise
>>> having watchdog active after suspend would result in unwanted
>>> crashes/resets if resume happens after a long time.
>>>
>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
> 
> Thanks Guenter. Should I send a v3 with your reviewed-by?
> 

I add it to my watchdog-next branch and Wim will pick it up from there.
No need to resend.

Guenter
