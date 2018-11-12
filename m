Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1612C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831402245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831402245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbeKMF6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:58:12 -0500
Received: from mail02.iobjects.de ([188.40.134.68]:53964 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeKMF6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:58:12 -0500
Received: from tux.wizards.de (p3EE2F45F.dip0.t-ipconnect.de [62.226.244.95])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 9E216416A1FC;
        Mon, 12 Nov 2018 21:03:25 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 42F03EEB923;
        Mon, 12 Nov 2018 21:03:25 +0100 (CET)
Subject: Re: [PATCH 4.19 025/361] ACPICA: AML interpreter: add region
 addresses in global list during initialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221623.163909820@linuxfoundation.org>
 <9da1c8e8-d237-11b3-8918-859a4bbdbcc4@applied-asynchrony.com>
 <20181112192546.GB2263@kroah.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <04e2dacd-7425-56e6-61e9-54c2a1d6c888@applied-asynchrony.com>
Date:   Mon, 12 Nov 2018 21:03:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112192546.GB2263@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 8:25 PM, Greg Kroah-Hartman wrote:
> On Mon, Nov 12, 2018 at 07:30:57PM +0100, Holger Hoffstätte wrote:
>> On 11/11/18 11:16 PM, Greg Kroah-Hartman wrote:
>>> 4.19-stable review patch.  If anyone has any objections, please let me know.
>>
>> As probably expected this patch causes problems. In my case one server
>> can no longer load the nct6775 hwmon module, which means the fan cannot be
>> monitored, and therefore my monitoring system promptly starts spamming me with
>> alerts that my fan has failed - which is of course not true.
>>
>> --snip--
>> Nov 12 18:08:56 tux kernel: nct6775: Found NCT6776D/F or compatible chip at 0x2e:0x290
>> Nov 12 18:08:56 tux kernel: ACPI Warning: SystemIO range 0x0000000000000295-0x0000000000000296 conflicts with OpRegion 0x0000000000000290-0x
>> Nov 12 18:08:56 tux kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
>> --snip--
>>
>> This is certainly caused by my old BIOS and its broken ACPI implementation,
>> however since it's working perfectly fine otherwise I see no reason to replace
>> it. That being said, I must be able to monitor my fan, so for now reverting
>> the patch immediately "fixed" the problem for me - the fan entries appeared
>> in sysfs again after successfully loading the module.
>>
>> Idea, workarounds or patches welcome.
> 
> So Linus's tree is also "broken" for your hardware?

Not tested yet (should I?) but I assume it will be, since it seems to be my
old BIOS' ACPI implemnetation's fault. As I wrote to Erik, I just added
acpi_enforce_resources=lax to the boot flags, and as expected it gives a
warning for the hwmon module, but still lets it pass and work, as before
or with the patch reverted. So I'm good for now.

thanks,
Holger
