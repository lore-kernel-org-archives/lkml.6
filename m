Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D545FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 10:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE5721878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 10:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO2HGyAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE5721878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeHRNqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 09:46:00 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:33798 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeHRNp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 09:45:59 -0400
Received: by mail-pg1-f174.google.com with SMTP id y5-v6so4660451pgv.1;
        Sat, 18 Aug 2018 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=CxrGHl22FhycNsy73R6KXkzdB7r1spBU17GyU16CtrM=;
        b=YO2HGyAaaCQGw2ULHOovdlL9/W8u9d+Clbf+eDX5GG4uDVCQIKo7YwbC811EriHSWa
         uzynjS07UOX0U2hj1/x15YC3LnyjKYuBiPaQ9AeeGCfxAOitS7DqE5U/hb1IndlvnmsN
         yBwsocU5MwLFnuMfheoRews//Rp6qkwfRHaLH5CnCHqiENEGSx426/EU4+98Ed11FmPH
         gnj+XBLQ0BD8msr9jnkSPWGQ1SN73USEX3VNF+5Dq0o3DzWxUaLS+qTfcYz2ShMay5G3
         WCV7AUaVrznlVQj7V2x7XLTqsMCPwAvLYnQBgU7SPQdSmfZ5f7U6Cy54W7mbDQvMA0j3
         oq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CxrGHl22FhycNsy73R6KXkzdB7r1spBU17GyU16CtrM=;
        b=A6C9020/m+1aydheyIOWmrohBLqIQcqQSC1iQ9C2eaEqpmnLl/s6p/6YVTNUOckEgT
         fHs2lsb3zVCMbEDUbOps8yXKAL0YGmubqYv73VjkxrJYoXBlptSbgiSuIAtWyapQdu00
         ggKuM9GVQ6yWKHA7oSzbSEAkwya035OytJlT07VNRLZsXu2IjfKMP/cZKX1kkUHoI+1h
         /62ayvHTPYaEB34sNGxardQN4ZprLGhKGb64BKXu0xxp+JejYVQGDQd5ASK4bzbc2jlj
         3rbhgippvguqv2joJ3Q+YXHDedrcKWgD2hRdSn5b0XQSCS+mGJBDjybQgdiaUQ+mVgN3
         MwOg==
X-Gm-Message-State: AOUpUlE1xZfFM3fWi/t9RiGCdzrLgrvohFiPtZANTrSNHJC/aWcREnoh
        sIiW/ZaTL30o3tQgNjto2XSY+EYibbs=
X-Google-Smtp-Source: AA+uWPziLBVc9m+1mI+pYW0imecw13yjEgpH38fo8jVNhl5phXZ91CVSFpOTj+Yr6keOSerujSpxxQ==
X-Received: by 2002:a62:43c8:: with SMTP id l69-v6mr40666053pfi.196.1534588728639;
        Sat, 18 Aug 2018 03:38:48 -0700 (PDT)
Received: from [172.31.199.222] ([47.52.143.187])
        by smtp.gmail.com with ESMTPSA id 14-v6sm7065087pft.93.2018.08.18.03.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 03:38:48 -0700 (PDT)
Subject: Re: How delete node or property in overlayd dts?
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CADUUTHBZ---U7YNYYry7qJY=vt_QpXpytymqJQc9xLFE_NjsAg@mail.gmail.com>
 <c342562e-f915-a853-c2a8-eecefd94b88d@gmail.com>
 <CAL_JsqLV5d5cL3o3Dx=--zGD37c5O09rL9AXyRFmceTfBHt3Zg@mail.gmail.com>
From:   Zhang Bo <zbsdta@gmail.com>
Message-ID: <78f06f2d-7561-dde9-c155-9f1612f9067a@gmail.com>
Date:   Sat, 18 Aug 2018 18:38:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLV5d5cL3o3Dx=--zGD37c5O09rL9AXyRFmceTfBHt3Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2018/8/18 1:47, Rob Herring 写道:
> On Tue, Aug 14, 2018 at 7:26 PM Frank Rowand <frowand.list@gmail.com> wrote:
>> On 08/14/18 07:46, 张波 wrote:
>>> /delete-node/ /delete-prop/ could be used in dtsi files without device
>>> tree overlay.
>>>
>>> but with device tree overlay,  /delete-node/ and  /delete-prop/ are not work.
>>> How to delete property and node in overlay dts?
>>>
>>> for example,
>>> in basel.dts have following node
>>> node1 {
>>>      property1;
>>>      property3;
>>>      node2 {
>>>          property2;
>>>      }
>>> }
>>>
>>> in overlay.dts as following
>>>   node1 {
>>>      /delete-property/ property1;
>>>      /delete-node/ node2;
>>> }
>>>
>>> after overlay, property1 and node2 is not deleted.
>>>
>> The /delete-node/ and /delete-prop/ directives are only used by the
>> dtc compiler within a single compilation.
>>
>> There is nothing in the format of a devicetree blob to represent the
>> notion of deleting a property or a node.
>>
>> You can not delete a property or a node in an overlay dtb.
> Though you can add/override 'status' with 'status = "disabled";' which
> should be treated very similar to a node not being present. I say
> similar because it's a source of bugs for the OS to fail to pay
> attention to status property.

there is document in 
https://android.googlesource.com/kernel/msm/+/android-7.0.0_r0.11/Documentation/devicetree/overlay-notes.txt,

In above document, remove node or property by adding - operator before 
node or property. but I didn't find it in released kernel source code, 
Is there any update plan about this problem?

{

     property-a;       /* add property-a to the target */

     -proptery-b;     /* remove property-b from the target */

     -node-b {          /* remove an exiting node-b */

         ...

     }

}

