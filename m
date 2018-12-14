Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDCBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D72F204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbeLNTSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:18:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:42473 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730123AbeLNTSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:18:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 11:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,354,1539673200"; 
   d="scan'208";a="110454612"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.147]) ([10.7.153.147])
  by orsmga003.jf.intel.com with ESMTP; 14 Dec 2018 11:18:03 -0800
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
To:     Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "james.feist@linux.intel.com" <james.feist@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20181213195319.1333402-1-vijaykhemka@fb.com>
 <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
 <B6C3C92D-1F9E-4425-ABF5-718D1A6755EB@fb.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <c1e35845-cb07-048f-bcf7-d7239a387027@linux.intel.com>
Date:   Fri, 14 Dec 2018 11:18:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <B6C3C92D-1F9E-4425-ABF5-718D1A6755EB@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

On 12/14/2018 10:11 AM, Vijay Khemka wrote:
> On 12/13/18, 2:56 PM, "Joel Stanley" <joel@jms.id.au> wrote:

<snip>

>      > +               oemname0 = "MB_P3V3";
>      > +               oemname1 = "MB_P5V";
>      > +               oemname2 = "MB_P12V";
>      > +               oemname3 = "MB_P1V05";
>      > +               oemname4 = "MB_PVNN_PCH_STBY";
>      > +               oemname5 = "MB_P3V3_STBY";
>      > +               oemname6 = "MB_P5V_STBY";
>      
>      "oemname" isn't part of the upstream bindings. Is this something you
>      have patches for?
> This is a workaround field used by dbus-sensors application to avoid overlay for dynamic detection of devices based on json file definition.
> 
> Can you please also review other 3 patches in this series.
>      
> 

These oemname settings should not be added into here. You can add these
information into configuration of entity manager which uses overlay
templates for dbus-sensors. Also, as Joel said, "oemname" isn't part of
the upstream bindings.

Cheers,
Jae
