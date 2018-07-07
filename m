Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E96C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2EB208D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzM6LMJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2EB208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeGGVPe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:15:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44985 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932380AbeGGVPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:15:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so4339599pls.11;
        Sat, 07 Jul 2018 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xRkBlSZS5VkfWjJ1VwzOnlA5kCEf9t3eQO0cGORaGrU=;
        b=XzM6LMJwCJx1kNtkmPxNc6bm8pxBxICIwJaN6CPDqP9rdBtqajxM7VaXvOe6LvHoKF
         Lu/nvmOstsiXJ9jMyG1XNR9PYngxAvXa+L2pOdB3FJmXHfPYk3qCEIq2NG6iZZdWK68P
         PE3a/lJz2S6NpUyD6IVaBY9b2gCsOrgRiEgFZNOEsPURmtUIGLaDc6vLM7VBb0UodtvZ
         JHdRTZaP9wlNg1nt8a3j3uRPTZo98PwbFkFjVuR1ES8Ta3GOu3FOArV8dRIyWnymgSx8
         i67KlWoMc4qIEO0U88E/73VsvK98UJoc+wV/2T0Qs6ObWpJ1S0hnF/FdN/p+WHH7ZRBj
         D7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xRkBlSZS5VkfWjJ1VwzOnlA5kCEf9t3eQO0cGORaGrU=;
        b=R5ochTpra6r2om7KA1A9sT+2Nlan0JGFDxm+reXm3sq+ttCDhlvcTYI6p6kZ7sqK4m
         JKwpAVx0T9puL1tY+KctnsF3u4HZ0WVdnimxnw9zH1oS33uGn5HW9+wXD6EVb3lZMzj0
         xRTJb1ff1Xr8asZdyICgFIYi4r9+2TQN8a2zz0ZJmpUc1pf6Zsr57u2reHLIFlxnm5Tg
         /IqEwDaNqGg4f94ZJVzZG1LlLw7lQELvg1mXv3frGl1E0YqAI/lVGhHtI/NFczCH8Dhk
         VW6SCMgQyQIZZCt4YztcCZr8dV/wX1wPFaA08yScWqVDdkTKzlFsaCwE4UeP3N07CN8K
         BGeg==
X-Gm-Message-State: APt69E16TfDD9d0ICnNPbXYQfUrRRsgrt7E+uQADbQUW/yXDqI+9kp4J
        DMOzh1maXrluCyAjeGB4E1QDm7Dt
X-Google-Smtp-Source: AAOMgpcL/EPkuFqAYAPYKZ09ZLV7XDkU0f2bkJ2ApK72ZtT/EQVM/U6GRJb+zN7DjhLcEwji/GveSQ==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21-v6mr14819459pls.237.1530998130775;
        Sat, 07 Jul 2018 14:15:30 -0700 (PDT)
Received: from [192.168.1.54] (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.gmail.com with ESMTPSA id t192-v6sm19308175pgc.74.2018.07.07.14.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 14:15:29 -0700 (PDT)
Subject: Re: [PATCH v5 00/17] media: imx: Switch to subdev notifiers
To:     Sakari Ailus <sakari.ailus@iki.fi>,
        Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
 <20180702095119.t2adtiffpuaoanqk@valkosipuli.retiisi.org.uk>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <c38e01e7-dea2-d2df-b48d-adbf005e1c1a@gmail.com>
Date:   Sat, 7 Jul 2018 14:15:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702095119.t2adtiffpuaoanqk@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,


On 07/02/2018 02:51 AM, Sakari Ailus wrote:
> Hi Steve,
>
> On Fri, Jun 29, 2018 at 11:49:44AM -0700, Steve Longerbeam wrote:
>> This patchset converts the imx-media driver and its dependent
>> subdevs to use subdev notifiers.
>>
>> There are a couple shortcomings in v4l2-core that prevented
>> subdev notifiers from working correctly in imx-media:
>>
>> 1. v4l2_async_notifier_fwnode_parse_endpoint() treats a fwnode
>>     endpoint that is not connected to a remote device as an error.
>>     But in the case of the video-mux subdev, this is not an error,
>>     it is OK if some of the mux inputs have no connection. Also,
>>     Documentation/devicetree/bindings/media/video-interfaces.txt explicitly
>>     states that the 'remote-endpoint' property is optional. So the first
>>     patch is a small modification to ignore empty endpoints in
>>     v4l2_async_notifier_fwnode_parse_endpoint() and allow
>>     __v4l2_async_notifier_parse_fwnode_endpoints() to continue to
>>     parse the remaining port endpoints of the device.
>>
>> 2. In the imx-media graph, multiple subdevs will encounter the same
>>     upstream subdev (such as the imx6-mipi-csi2 receiver), and so
>>     v4l2_async_notifier_parse_fwnode_endpoints() will add imx6-mipi-csi2
>>     multiple times. This is treated as an error by
>>     v4l2_async_notifier_register() later.
>>
>>     To get around this problem, add an v4l2_async_notifier_add_subdev()
>>     which first verifies the provided asd does not already exist in the
>>     given notifier asd list or in other registered notifiers. If the asd
>>     exists, the function returns -EEXIST and it's up to the caller to
>>     decide if that is an error (in imx-media case it is never an error).
>>
>>     Patches 2-5 deal with adding that support.
>>
>> 3. Patch 6 adds v4l2_async_register_fwnode_subdev(), which is a
>>     convenience function for parsing a subdev's fwnode port endpoints
>>     for connected remote subdevs, registering a subdev notifier, and
>>     then registering the sub-device itself.
>>
>> 4. Patches 7-14 update the subdev drivers to register a subdev notifier
>>     with endpoint parsing, and the changes to imx-media to support that.
>>
>> 5. Finally, the last 3 patches endeavor to completely remove support for
>>     the notifier->subdevs[] array in platform drivers and v4l2 core. All
>>     platform drivers are modified to make use of
>>     v4l2_async_notifier_add_subdev() and its related convenience functions
>>     to add asd's to the notifier @asd_list, and any allocation or reference
>>     to the notifier->subdevs[] array removed. After that large patch,
>>     notifier->subdevs[] array is stripped from v4l2-async and v4l2-subdev
>>     docs are updated to reflect the new method of adding asd's to notifiers.
>>
>>
> Thanks for the update! This is beginning to look really nice. A few notes
> on the entire set. I'll separately review some of the patches; I mainly
> wanted to see how the async/fwnode framework changes end up:
>
> - The reason V4L2_MAX_SUBDEVS exists is to avoid drivers accidentally
>    allocating more space than intended. Now that the subdevs array will
>    disappear, the checks as well as the macro can be removed. I think the
>    num_subdevs field also becomes redundant as a result. Could you do this
>    in the patch that removes the subdevs array?

Yes, good idea, done! It was easy to do.

>
> - The notifier has register, unregister and cleanup operations. Now that
>    there's an obvious need to initialise it, it'd make sense to show that to
>    the drivers as an init operation --- rather than silently initialise it
>    based on the need.

That was actually my plan initially, but at the time, it meant modifying
all platform drivers to call v4l2_async_notifier_init(). But since this 
patchset
now touches all platform drivers anyway, might as well do it.

Of course doing this adds more risk, since I have to call 
v4l2_async_notifier_init()
in the correct places. But cross-my-fingers, I think I've done this 
correctly.

>
> - I'd assign j in its declaration in
>    v4l2_async_notifier_has_async_subdev().

Done.

>
> - No need to explicitly check that the notifier's asd_list is empty in
>    __v4l2_async_notifier_register --- list_for_each_entry() over the same
>    list will be nop in that case.
>

Done.

I'm submitting v8 shortly.

Steve


