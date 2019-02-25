Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F1A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfBYTO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:14:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51089 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfBYTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:14:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so88053wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j90fx/Rj8Vh/DS11KF27qkmgdsqJvUNaE26KxWMEx+0=;
        b=YGrPynFYLV+NEB4MOm3ghx2D2AoJUbCeuEhGhz3TEIorKwwHWq4oWukzo+ja6cUZN5
         nJXuRmv5MMp9xXOQKWKSf4AZK1f/nbLiar19f+PbdAbEVY1IUPciiOBg0uvY93qPKhjn
         /LPJiuRHN1EXw00rYdyGwP+cIhR5geFy5SnhVZx3j8MaKpBJrJGDfvOY4qIPGgVcbS16
         9xzeGaqhjwlDpRi9F8i0v268P1Q7ycchKyRawuKcXsdnbmUsG7fRVRnq2YXE5s1O8r9A
         To5lqbqvHmYCNlu5Lzvgg5iFm4kkcHJ3FwWvWG6eYTj1HJQLB+lsy0j6dCyThrSZMqHk
         acrQ==
X-Gm-Message-State: AHQUAuZbCZ4mf4H1wu/sVen03sms1OI7sdA0lZ0YTz7Xl754+S4GdAeI
        IgOs/N+JDIxrUczqbJBdWZTKpP8fHfY=
X-Google-Smtp-Source: AHgI3IaE3Z4r8IBmsbZ5dj4pCJCK0ffAVuEps4YM1KG6knjs2QR8bO4ZCg2+Iys8uNlVrx5bklCk4w==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr213957wmg.53.1551122096752;
        Mon, 25 Feb 2019 11:14:56 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id u4sm7861543wmb.25.2019.02.25.11.14.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:14:56 -0800 (PST)
Subject: Re: [PATCH 0/2] platform/x86: intel_cht_int33fe: Start using software
 nodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
 <d0e10d6f-efb5-0139-d6c9-edb66c97c0b6@redhat.com>
 <20190225154823.GA2808@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <be150dea-7c55-f0f4-501f-5818e0b3873c@redhat.com>
Date:   Mon, 25 Feb 2019 20:14:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190225154823.GA2808@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25-02-19 16:48, Heikki Krogerus wrote:
> On Fri, Feb 22, 2019 at 05:31:32PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 2/19/19 12:59 PM, Heikki Krogerus wrote:
>>> Hi guys,
>>>
>>> The software nodes support node hierarchy. By using them with fusb302
>>> we can add a separate fwnode also for the USB connector as a child of
>>> fusb302. We can then use the "standard" USB connector device
>>> properties with the connector node, and stop using the deprecated
>>> fusb302 specific properties.
>>>
>>> Since the goal is to ultimately move to the software node API from the
>>> old device property API, converting also max17047 in this series.
>>>
>>> If you test this now (before v5.1-rc1 is out), then the series depends
>>> Greg's latest usb-next:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/?h=usb-next
>>>
>>> and on a patch in Rafael's latest linux-next branch:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=344798206f171c5abea7ab1f9762fa526d7f539d
>>
>> Interesting series, I like the direction this is heading in.
>>
>> Question, I currently have this hack to test DP over Type-C on the
>> GPD-pocket / GPD-win:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/f481b7032030dcdda1ccc39875eb59f996d3e775
>>
>> Do this properly we need to add alt-modes support for usb-c-connector nodes to:
>> Documentation/devicetree/bindings/connector/usb-connector.txt
> 
> Yes, this is a topic I wanted to talk about.
> 
>> Do you have any ideas for what the binding this should look like, we need to
>> specify a svid, mode and vdo tripple in this case. Maybe use an u32 array
>> with 3, 6, 9, ... entries depending on how much alt-modes the fwnode needs to
>> specify ?
> 
> My idea was to use sub-nodes, i.e. every alt mode a connector supports
> would need to have its own child node under the connector node. Those
> sub-nodes could then have a device property "svid" and another device
> property "vdo", etc.

Right, after sending this mail I realized myself that using child-nodes
to group the svid and vdo together was the right answer. So we
could add child-nodes with a binding like this:

Optionally an "usb-c-connector" can have child nodes, describing
supported alt-modes.

Required properties for usb-c-connector altmode child-nodes:
compatible:  "usb-type-c-altmode"
svid:        integer, Standard or Vendor ID for the altmode (u16 stored in an u32) property and an u32
vdo:         integer, Vendor Data Object, VDO describing the altmode capabilies, SVID specific

I'm not sure if we also need to specify the altmode index here, or
we simple assign each alt-mode an index while enumerating?

> I think that approach would be OK in DT, and we can now support it also
> with the software nodes, and even in ACPI there are now something
> called "data nodes" which can be used for this purpose.

Ack.

> There are some questions though. That "USB connector" node description
> relies on OF graph, so should we just extend those "endpoint" nodes
> (which are sub-nodes), or should be still have dedicated sub-nodes for
> the alt modes? I think we may need dedicated nodes for the alt modes
> in any case if we choose to use this approach.

Right I'm thinking dedicated nodes for the alt modes.

I guess an alt-mode could have a port child-node to point to say the
DisplayPort pins / mux connection ?  I'm not entirely sure how the graph
stuff will work here, but I guess that from a DT pov it will be desirable
to be able to describe where the datalines for the alt-mode come from,
maybe in combination with what the "mux/select" value is for the mux ???

Regards,

Hans
