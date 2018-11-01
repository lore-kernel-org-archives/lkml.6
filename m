Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE37C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A453205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A453205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeKAXiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:38:09 -0400
Received: from olimex.com ([184.105.72.32]:55188 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbeKAXiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:38:09 -0400
Received: from 195.238.85.143 ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 07:34:46 -0700
Subject: Re: [PATCH v3 1/1] drm/panel: Add support for Olimex LCD-OLinuXino
 panel
To:     Rob Herring <robh@kernel.org>, Stefan Mavrodiev <stefan@olimex.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1531383729-13932-1-git-send-email-stefan@olimex.com>
 <20180716150836.GA16895@rob-hp-laptop>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <e677488e-34e0-512c-db13-15ccf78c5ea0@olimex.com>
Date:   Thu, 1 Nov 2018 16:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180716150836.GA16895@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: bg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/18 6:08 PM, Rob Herring wrote:
> On Thu, Jul 12, 2018 at 11:21:53AM +0300, Stefan Mavrodiev wrote:
>> This patch adds Olimex Ltd. LCD-OLinuXino bridge panel driver. The
>> panel is used with different LCDs (currently from 480x272 to 1280x800).
>> Small EEPROM chip is used for identification, which holds some
>> factory data and timing requirements.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>> Changes for v3:
>>    - Change module license from "GPL v2" to "GPL"
>>    - Make use of backlight_enable()/backlight_disable() helpers
>>    - Rework backlight device request
>>    - Remove drm_panel_detach()
>>    - Use module_i2c_driver() for initialization
>>    - Make the first mode preferred
>>    - If num_modes value is invalid, overwrite it with 4, which is the maximum
>>    - Some variable types optimizations
>>
>> Changes for v2:
>>    - Changed lcd_olinuxino_funcs to static const
>>
>>   .../display/panel/olimex,lcd-olinuxino.txt         |  42 +++
> Reviewed-by: Rob Herring <robh@kernel.org>
>
>>   MAINTAINERS                                        |   6 +
>>   drivers/gpu/drm/panel/Kconfig                      |  10 +
>>   drivers/gpu/drm/panel/Makefile                     |   1 +
>>   drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 331 +++++++++++++++++++++
>>   5 files changed, 390 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
>>   create mode 100644 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c

I would like to ask if there will be any progress on this patch?

Best regards,
Stefan Mavrodiev

