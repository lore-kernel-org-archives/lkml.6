Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CFBC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8006220867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8006220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIDNK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:10:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44308 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeIDNK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:10:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so3001212wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wR9FjxXSBKbwQZmFLAMO5SjH9p/lg20JPnRGuFJHnyI=;
        b=sTygJabLxt8CErseW6/1IJ7a1zUBvlqheG4S5YnW0+IsbEqSp95LPkRt01+NFFjA+L
         d21vP1SvwyTrpPZLjhu9dPdzYqZOitWmIrl5E6pcjXnPZxVhEX10V5qHNxlv8+9jJ545
         9axBFv/sEl2JhI8QcSdB9PP6fKnAHspvSKjHKXRySUNteSphmTbQqeiNiUg6dauYv9rb
         IpYAy/RkGXOiIhP+/02jcb99/2pS4wbJ3BZi4Ia++m412aLueBVil3fj7MZeNwDRddeD
         swLkK1BmUA39FqDU/WX2F2b6OQcZzQvxBDccC8XEEfnlUcH8aKWPAHWC+vgoYe+eMkaq
         6Tcw==
X-Gm-Message-State: APzg51BMiKG64Bfl6htUdnAeysv8U2Yf4MNhLVkooVQGicouYBnnkawo
        gos9Yr5FSoze8+tQ/ILhHDj2YA==
X-Google-Smtp-Source: ANB0VdbohDtqR0S5ZLWI4vGqs9BrbqRyqfq57ri94t3NY/dWbmEFItwPXtwbNOVzJgDIPQW45xqVtg==
X-Received: by 2002:a5d:5383:: with SMTP id d3-v6mr21956484wrv.191.1536050777675;
        Tue, 04 Sep 2018 01:46:17 -0700 (PDT)
Received: from [192.168.1.13] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id x24-v6sm30913581wrd.13.2018.09.04.01.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 01:46:16 -0700 (PDT)
Subject: Re: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2 async
 notifier complete
To:     "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        Bing Bu Cao <bingbu.cao@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Zheng, Jian Xu" <jian.xu.zheng@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
References: <20180831152045.9957-1-javierm@redhat.com>
 <cd307d41-ed19-5ab0-cbdb-a743cdb76e09@linux.intel.com>
 <c1e54228-a21a-b4a2-1083-c75b2dda797c@redhat.com>
 <b15b236e-e0a7-8b2f-1e1f-196c9dc04f4d@linux.intel.com>
 <44eb94a8-3712-155b-b3ab-35538f5b6b38@redhat.com>
 <F4B393EC1A37C8418714AECDAAEF72A93C9A39FC@shsmsx102.ccr.corp.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <1404b391-3fdc-9ccd-6467-bf65b4d10ec9@redhat.com>
Date:   Tue, 4 Sep 2018 10:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <F4B393EC1A37C8418714AECDAAEF72A93C9A39FC@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tian Shu,

On 09/04/2018 07:01 AM, Qiu, Tian Shu wrote:
> Hi,
> 
> Raise my point.
> The case here is that we have multiple sensors connected to CIO2. The sensors work independently. So failure on one sensor should not block the function of the other.
> That is, we should not rely on that all sensors are ready before allowing user to operate on the ready cameras.
> Sometimes due to hardware issues or incompleteness, we did met the case that one sensor is not probing properly. And in this case, the current implementation blocks us using the working one.
> What I can think now to solve this are:

After discussing this with Sakari over IRC, I agree with you that $SUBJECT can
do more harm than good and the patch should just be dropped.

> 1. Register multiple media devices. One for each sensor path. This will increase media device count.
> 2. Use .bound callback to create the link and register the subdev node for each sensor. Leave .complete empty.
>      Not sure if this breaks the rule of media framework. And also have not found an API to register one single subdev node.
>

I agree with your comment on (2) since currently the driver isn't able to cope
with the case that you are describing, as you mention the links and the subdev
node registration are done in the .complete callback. So that logic should be
moved to the .bound callback instead, so the media graph is usable even if one
of the drivers for a pending subdevice fails to probe.

> Thanks
> Tianshu Qiu
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
