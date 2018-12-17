Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E42C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54BA21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbeLQTuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:50:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:41532 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeLQTuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:50:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 11:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="101389927"
Received: from skyhawk.jf.intel.com (HELO [10.54.51.81]) ([10.54.51.81])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2018 11:50:00 -0800
Subject: Re: [Potential Spoof] Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors
 devices for Facebook
To:     Vijay Khemka <vijaykhemka@fb.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <E3F1FFD7-1C5A-43DE-BCA6-5B50EEEF577F@fb.com>
From:   James Feist <james.feist@linux.intel.com>
Message-ID: <024aee07-0444-cdaf-d274-b07244aec7b2@linux.intel.com>
Date:   Mon, 17 Dec 2018 11:50:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <E3F1FFD7-1C5A-43DE-BCA6-5B50EEEF577F@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 11:39 AM, Vijay Khemka wrote:
> 
> 
> ﻿On 12/14/18, 12:42 PM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com@lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:
> 
>      
>      
>      On 12/14/18, 11:22 AM, "openbmc on behalf of Jae Hyun Yoo" <openbmc-bounces+vijaykhemka=fb.com@lists.ozlabs.org on behalf of jae.hyun.yoo@linux.intel.com> wrote:
>      
>          Hi Vijay,
>          
>          On 12/14/2018 10:11 AM, Vijay Khemka wrote:
>          > On 12/13/18, 2:56 PM, "Joel Stanley" <joel@jms.id.au> wrote:
>          
>          <snip>
>          
>          >      > +               oemname0 = "MB_P3V3";
>          >      > +               oemname1 = "MB_P5V";
>          >      > +               oemname2 = "MB_P12V";
>          >      > +               oemname3 = "MB_P1V05";
>          >      > +               oemname4 = "MB_PVNN_PCH_STBY";
>          >      > +               oemname5 = "MB_P3V3_STBY";
>          >      > +               oemname6 = "MB_P5V_STBY";
>          >
>          >      "oemname" isn't part of the upstream bindings. Is this something you
>          >      have patches for?
>          > This is a workaround field used by dbus-sensors application to avoid overlay for dynamic detection of devices based on json file definition.
>          >
>          > Can you please also review other 3 patches in this series.
>          >
>          >
>          
>          These oemname settings should not be added into here. You can add these
>          information into configuration of entity manager which uses overlay
>          templates for dbus-sensors. Also, as Joel said, "oemname" isn't part of
>          the upstream bindings.
>      
>      Overlay templates from entity manager is not working for fan and adc sensors that's why it is a workaround suggested by James Feist (Author of dbus-sensors).
> 
> @james.feist@linux.intel.com,
> Please comment on above patch, please advise if I need to fix this.

Yes, this is a workaround. It should not be added to your device tree. 
This has already been fixed for the fans, someone just needs to spend a 
little bit of time to fix the ADCs then it won't be needed.

Thanks,

James


>          
>          Cheers,
>          Jae
>          
>      
>      
> 
