Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCD4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B7E2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HdRlZBjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B7E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIDTgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:36:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60636 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeIDTgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:36:08 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84FAPOB066673;
        Tue, 4 Sep 2018 10:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536073825;
        bh=OETzwtq61qtMmbilZ9uTfd0LxLxyrQ/vhyABHFmg/aA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HdRlZBjXqbEvFr2msCn2yY6Agr2fQHDF98doi5d2rx9RCHDJkdxdG5KpJGTbQjxvO
         QEKZKcQt1PVqC1ENIlzofgnflLeGqB+acYfFKM3qDCPGNKI9BhQN8dgpXEtLPWsyqr
         DPbXG+SNlHu3rDtDVH/5l9JGZ9d1k3agqaMi3vEs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84FAP70002474;
        Tue, 4 Sep 2018 10:10:25 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 10:10:24 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 10:10:24 -0500
Received: from [172.22.184.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84FAOXp004270;
        Tue, 4 Sep 2018 10:10:24 -0500
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off setting
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
 <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
 <20180904144159.GC12993@sirena.org.uk>
 <7163381a-ae09-ad3b-064d-990c98f13ccb@ti.com>
 <20180904145503.GD12993@sirena.org.uk>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <85973bf4-1acb-1731-d93e-29c8141a3c53@ti.com>
Date:   Tue, 4 Sep 2018 10:10:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904145503.GD12993@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 09:55 AM, Mark Brown wrote:
> On Tue, Sep 04, 2018 at 09:43:03AM -0500, Andrew F. Davis wrote:
>> On 09/04/2018 09:41 AM, Mark Brown wrote:
> 
>>>>> If we really want to pay attention to something setting this up we'd
>>>>> need to completely remove the widget - what the code is doing at the
>>>>> minute is setting the voltage that the bias will go to when enabled,
>>>>> there's still a widget for turning it on and off.  There's some chance
>>>>> that this will break existing boards.
> 
>>>> Turning on bias is controlled separately, automatically in user-space in
>>>> many cases, not based on the board. The DT needs to have a way to state
>>>> that 0v is the needed bias on this board, without this you can not set
>>>> 0v bias and 2v is chosen by default (which is IMHO should be 0v but that
>>>> would change existing behavior so I won't touch that).
> 
>>> Surely turning on MICBIAS at 0V is equivalent to leaving the bias off?
> 
>> It is, but DT doesn't control when or why MICBIAS is turned on or off,
>> only what voltage on should be.
> 
> The DT controls this in so far as it will arrange for the bias to be
> connected to something, if it's not connected to anything then it will
> only be turned on if the machine driver explicitly forces it on which is
> a potential source of problems but seems comfortably in "you broke it,
> you get to keep the pieces" territory.  If we really want to have a way
> of explicitly specifying that some widgets should never be turned on
> then it feels like rather than have something device and widget specific
> like this we should instead have a higher level way of doing that which
> can be applied to any widget, that is something that could be useful
> especially with things like speaker drivers where there's real potential
> for physical damage to the system.
> 


Not sure how that could even look, it would need to be in DT as only
that layer knows the connections, but then the it would also have to
have internal knowledge of the widgets used in the driver..


> Like I said in my original reply I'm also worried that this will break
> existing boards by causing them to change to a voltage of 0 when they
> had managed to end up with the default of 2V which happened to work for
> them.
> 

Then only time this could happen is if they specified MICBIAS_OFF in DT
but got the default 2v instead. In which case, yes, the behavior would
change, but it would also be changing to the correct behavior. We can't
avoid fixing code on the off chance someone depended on the broken
behavior, no progress could ever be made.
