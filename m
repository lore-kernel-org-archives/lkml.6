Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81228C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A832156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="guhgFSAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A832156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeI0TcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:32:05 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:40706 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0TcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:32:05 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 15:32:04 EDT
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 909E0B009B9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:08:33 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1538053713; x=1538917714; bh=iZZh84RmzbSfK8tv+zx6sj5H1HsW6jYrq3i
        w8vCaNHA=; b=guhgFSAHjgm8V9duUUXzkFxfxJ+J6UjupcTO4ixsA9uD0EkyeXF
        VXx0cU6JptiztktQ+MC1hd4mEYUBMT01CkiRLfOzCWf/qVri0GcBo/qlM5vlM2f0
        NvG3//8bX2X+PL3E+xmRL4s4akC3pT8XGFoP3oStcSfANWKq7RCI0tws=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FDNWPf5n73If for <linux-kernel@vger.kernel.org>;
        Thu, 27 Sep 2018 15:08:33 +0200 (CEST)
Received: from [192.168.0.105] (78-134-29-36.v4.ngi.it [78.134.29.36])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id A89E4B001D9;
        Thu, 27 Sep 2018 15:08:32 +0200 (CEST)
Subject: Re: [PATCH 0/5] Add CDTech 4.3" and 7" to panel-simple
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
 <20180927115938.GD29102@ulmo>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <88156978-a46e-7879-239f-0df289658641@micronovasrl.com>
Date:   Thu, 27 Sep 2018 15:08:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927115938.GD29102@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thierry,

Il 27/09/2018 13:59, Thierry Reding ha scritto:
> On Tue, Jul 31, 2018 at 01:11:12AM +0200, Giulio Benetti wrote:
>> Add CDTech 4.3" S043WQ26H-CT7 support
>> Add CDTech 7" S070WV95-CT16 support
>>
>> Giulio Benetti (5):
>>    dt-bindings: Add vendor prefix for CDTech(H.K.) Electronics Limited
>>    drm/panel: add panel CDTech S070WV95-CT16 to panel-simple
>>    dt-bindings: Add CDTech S070WV95-CT16 panel bindings
>>    drm/panel: add panel CDTech S043WQ26H-CT7 to panel-simple
>>    dt-bindings: Add CDTech S043WQ26H-CT7 panel bindings
>>
>>   .../display/panel/cdtech,s043wq26h-ct7.txt    | 12 ++++
>>   .../display/panel/cdtech,s070wv95-ct16.txt    | 12 ++++
>>   .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>>   drivers/gpu/drm/panel/panel-simple.c          | 55 +++++++++++++++++++
>>   4 files changed, 80 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
>>   create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
> 
> All applied, thanks. One small note, though: in the future please send
> DT bindings patches before the driver patches. This is important because
> checkpatch, which is run as pre-commit script, warns about undocumented
> compatible strings if you send driver changes before the bindings.

Ok, thanks for both applying and pointing me this important detail.

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
