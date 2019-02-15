Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8EB20643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bTWdmCAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbfBOI0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:26:45 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54724 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfBOI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:26:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F8PwpA127459;
        Fri, 15 Feb 2019 02:25:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550219158;
        bh=Aww6y1AGIDmPXQGYERMuPKfa6BgNmUmnIxsJzXZsKEo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bTWdmCAqWTsWXls+NyusC/m40enWhe4Rf2eO4T7wnY2UcbfZ0NmMQmHXd8cxIn+h+
         gbElFqtuUWBktdSSX7Dbme2lqEJR1RzM3BXEyw9cOufeZQDyKl50Lll6yExNMtNYM8
         /LtMclJVHpxOgpAnBwHWJoyNVn75MM8XekP/+kAk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F8Pvu1008991
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 02:25:57 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 02:25:57 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 02:25:57 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F8Ps5m022240;
        Fri, 15 Feb 2019 02:25:54 -0600
Subject: Re: [PATCH v2 0/2] drm/omap: panel-tpo-td028ttec1: add backlight
 support
To:     Andreas Kemnade <andreas@kemnade.info>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <laurent.pinchart@ideasonboard.com>, <sre@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <letux-kernel@openphoenux.org>
References: <20190205063813.14873-1-andreas@kemnade.info>
 <a54e7427-ff84-d105-aab7-c5eab42e6df9@ti.com>
 <20190215081242.21cc9953@kemnade.info>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <94353858-9f0e-b842-9766-6f7d3ff6cc2a@ti.com>
Date:   Fri, 15 Feb 2019 10:25:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215081242.21cc9953@kemnade.info>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 09:12, Andreas Kemnade wrote:
> Hi,
> 
> On Fri, 8 Feb 2019 11:13:33 +0200
> Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 
>> On 05/02/2019 08:38, Andreas Kemnade wrote:
>>> This panel has a backlight, so add a property describing that and
>>> add the code to use that.
>>> This makes things like xset dpms force off
>>> also turn off the backlight, so we do not need to rely on additional
>>> userspace programs to do that.
>>>
>>> Andreas Kemnade (2):
>>>   drm/omap: panel-tpo-td028ttec1: add backlight support
>>>   dt-bindings: panel: td028ttec1: add backlight property
>>>
>>>  .../devicetree/bindings/display/panel/tpo,td028ttec1.txt       |  2 ++
>>>  drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c        | 10 ++++++++++
>>>  2 files changed, 12 insertions(+)
>>>   
>>
>> Thanks, I'll pick these up.
>>
> 
> hmm, that sounds like: patch accepted, will appear in linux-next soon.
> I have not seen it there, or is it just in some branch not merged into
> linux-next. Any new obstacles?

It's too late to get it to the next merge window, so I'll have to wait
until the merge window is closed before I can send these to drm-next.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
