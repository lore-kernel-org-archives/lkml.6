Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D919C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5DB20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U7ASr5Pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5DB20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeIDUUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:20:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39978 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeIDUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:20:54 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84Ft6oK048043;
        Tue, 4 Sep 2018 10:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536076506;
        bh=z5H3N2US+8PfrHnnd0sEO83F1aP24RpESiGFcCU4D5Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U7ASr5PfaLDiji53lIbm+dqMOsn2vT9pnep9zrLOnVd71PAH/7xc4I18V0M8SaeSb
         +0EJjh9yB/h1pWO5/J4kwKsfb0qTTcz47FeemF9rPeI7jqMrmUIqhrk+U8TcIx7uaH
         Wspe1TFdZxRTTmVO6ejEEbdWQAwAIiOKx79t0NlI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84Ft5Gx018582;
        Tue, 4 Sep 2018 10:55:05 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 10:55:05 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 10:55:05 -0500
Received: from [172.22.184.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84Ft5Hm011411;
        Tue, 4 Sep 2018 10:55:05 -0500
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification
 handling
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20180831181737.29516-1-afd@ti.com>
 <20180903113038.GG10302@sirena.org.uk>
 <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
 <20180904145740.GE12993@sirena.org.uk>
 <f6c7df62-a98f-009a-2169-0e5564f4b675@ti.com>
 <20180904154905.GH12993@sirena.org.uk>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <6c1cc350-b806-2f9b-8cf4-72390f13a0ec@ti.com>
Date:   Tue, 4 Sep 2018 10:55:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904154905.GH12993@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 10:49 AM, Mark Brown wrote:
> On Tue, Sep 04, 2018 at 10:03:40AM -0500, Andrew F. Davis wrote:
>> On 09/04/2018 09:57 AM, Mark Brown wrote:
> 
>>> It's there to save us having to rewrite the register cache if we asked
>>> for the device to be powered down but that didn't actually happen due to
>>> other constraints, we know all the registers are still as we left them.
> 
>> I don't see that happening for any other user of this, we will still
>> have to re-write the cache when the device goes from OFF->STANDBY, and
> 
> You will?  All the power_off() code seems to do is mark the regmap as
> cache only and turn off the regulators.
> 

OFF->STANDBY will call power_on(). That is what is needed to start back
up after a regulator notification event.

>> if it stays in standby and never went off, then we are still broken as
>> we switched to using the register cache only, but never turned on real
>> writes again.
> 
> regmap can remember which registers were written to while in cache only
> mode and only sync the ones that are actually dirty, or you can
> invalidate the entire cache.
> 

If we never turn off cache only after a regulator notification then that
doesn't matter.
