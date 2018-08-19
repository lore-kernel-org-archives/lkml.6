Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC1C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 06:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C646B2159D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 06:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2BEwVdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C646B2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeHSJXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 05:23:14 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38720 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeHSJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 05:23:14 -0400
Received: by mail-pg1-f181.google.com with SMTP id k8-v6so1262865pgq.5;
        Sat, 18 Aug 2018 23:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A+ZELs+iZQrVnYTm8rq1/6Tl96GzyJg6lp9sJ2hUsQI=;
        b=d2BEwVdfUYajWNUUVHZSIV7bcoj3hhZE+3fyYkIJAD25SR3Y+ckQGeR8AQfSj7ETO0
         CdzOOj4Ic19S60ydJfCt0xX2PaZ2XSRfAabnpvswg3v9zR4gInjfVxOBhsd4OttqS3Pw
         mpFPpvOD8MpURp5BBVs0mulRx9nIqq9Rs80p87Wf3/x7EVqC19nyRIDBhjvw/y20gMAL
         rO8BCx2fLTLXoaymDliFSCXsoqSEyeAjxVqSiNKQiuB3+w1NlgjjAAcEEMfh1oHKeb1a
         1AsTKr1QlZlH6/gPWOT1idWfd99jR3ef2M9Q67Y0mN17oNCSkS0C2OL3Y0Gk+Nn7A8VP
         XsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A+ZELs+iZQrVnYTm8rq1/6Tl96GzyJg6lp9sJ2hUsQI=;
        b=HkMqM8seROv8DzzRny8k7XIzGOFScY7XRno7WrrgjavLdDIOJgRnk0HqidlojieCbc
         zrHCLXeZzmtAV3fp3jon13mVMhcr9dGFhG3RwWdjyql5+P5mitJkor35hO62QGIcze1w
         YhM7ZYO7aOe9HTv8X496Rcxik2P9Xj5B1tWe80UETRmjgS4xSBVNCKqPMwodR5zZUwFr
         5j+88x328KSO3impi/eCMC3tjrcy5Bt5RyfOt/im3cz5Apth4A0EmNNf0ILajH/basfK
         hd/+I/8bwlZ/thwGgHFbUQNm0ELmKVwbnG+L75m087kGJtVr+8t5LEN2OsynPUjwdWgN
         XJDQ==
X-Gm-Message-State: AOUpUlE47xAzyMzazBHW2xnTimdGJk0oqODN5GVQ0qQBsoV9lkP0dVb1
        oFwDvcjHtMqOqc5Kj0pXLkI=
X-Google-Smtp-Source: AA+uWPzRFrO9weHMbxPaggGuIu6D10REMBhZRZdlGX3AqdQAWj3YJk4d+MI/8BKky6fVjLlGrB0opw==
X-Received: by 2002:a62:1449:: with SMTP id 70-v6mr43251847pfu.222.1534659170881;
        Sat, 18 Aug 2018 23:12:50 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id x7-v6sm9454172pgk.9.2018.08.18.23.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 23:12:50 -0700 (PDT)
Subject: Re: How delete node or property in overlayd dts?
To:     Zhang Bo <zbsdta@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CADUUTHBZ---U7YNYYry7qJY=vt_QpXpytymqJQc9xLFE_NjsAg@mail.gmail.com>
 <c342562e-f915-a853-c2a8-eecefd94b88d@gmail.com>
 <CAL_JsqLV5d5cL3o3Dx=--zGD37c5O09rL9AXyRFmceTfBHt3Zg@mail.gmail.com>
 <78f06f2d-7561-dde9-c155-9f1612f9067a@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d554d6aa-1301-9bf4-482b-8d8f2bb37f93@gmail.com>
Date:   Sat, 18 Aug 2018 23:12:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <78f06f2d-7561-dde9-c155-9f1612f9067a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/18 03:38, Zhang Bo wrote:
> 
> 在 2018/8/18 1:47, Rob Herring 写道:
>> On Tue, Aug 14, 2018 at 7:26 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>> On 08/14/18 07:46, 张波 wrote:
>>>> /delete-node/ /delete-prop/ could be used in dtsi files without device
>>>> tree overlay.
>>>>
>>>> but with device tree overlay,  /delete-node/ and  /delete-prop/ are not work.
>>>> How to delete property and node in overlay dts?
>>>>
>>>> for example,
>>>> in basel.dts have following node
>>>> node1 {
>>>>      property1;
>>>>      property3;
>>>>      node2 {
>>>>          property2;
>>>>      }
>>>> }
>>>>
>>>> in overlay.dts as following
>>>>   node1 {
>>>>      /delete-property/ property1;
>>>>      /delete-node/ node2;
>>>> }
>>>>
>>>> after overlay, property1 and node2 is not deleted.
>>>>
>>> The /delete-node/ and /delete-prop/ directives are only used by the
>>> dtc compiler within a single compilation.
>>>
>>> There is nothing in the format of a devicetree blob to represent the
>>> notion of deleting a property or a node.
>>>
>>> You can not delete a property or a node in an overlay dtb.
>> Though you can add/override 'status' with 'status = "disabled";' which
>> should be treated very similar to a node not being present. I say
>> similar because it's a source of bugs for the OS to fail to pay
>> attention to status property.
> 
> there is document in https://android.googlesource.com/kernel/msm/+/android-7.0.0_r0.11/Documentation/devicetree/overlay-notes.txt> 
> In above document, remove node or property by adding - operator before node or property. but I didn't find it in released kernel source code, Is there any update plan about this problem?
> 
> {
> 
>     property-a;       /* add property-a to the target */
> 
>     -proptery-b;     /* remove property-b from the target */
> 
>     -node-b {          /* remove an exiting node-b */
> 
>         ...
> 
>     }
> 
> }
> 
> 

As far as I can tell, this version of overlay-notes.txt has never been
in the mainline kernel source.

There is no plan to support such a syntax.

-Frank
