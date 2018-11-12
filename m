Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8E1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58A62243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IQ808UC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58A62243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbeKLXaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:30:46 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34772 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbeKLXaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:30:46 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wACDawv8010241;
        Mon, 12 Nov 2018 07:36:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542029818;
        bh=63hG7wKv8IHIlfrxQ0Dn6bghH7nG0i0Dt5D3Nz24/ik=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IQ808UC0ybLu5kSH++seb5Szsfh2muzW/mh06hrBy1q6VrJGiIW/rMQFfh5zAGO/z
         UppjGzF5nKEIEzbQkMflZL5Aq/ZVibL3QB6SSqDw+wr3nj+uc0Kp+kzY2ekK6jPD4p
         5i/pVavr0p4RmFusd1cs2JkkEjPOFOVhprHIoCtA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wACDawSR022080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 07:36:58 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 12
 Nov 2018 07:36:57 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 12 Nov 2018 07:36:57 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wACDatTE016215;
        Mon, 12 Nov 2018 07:36:55 -0600
Subject: Re: [RFC 0/9] ASoC/ARM: Merge the davinci and omap audio directories
To:     Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, <tony@atomide.com>,
        <nsekhar@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jsarha@ti.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
 <1065fb8a-a8ec-fbe3-83eb-a308072ef6d6@bitmer.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <812b333e-cd01-ba32-8daa-7783072cb613@ti.com>
Date:   Mon, 12 Nov 2018 15:38:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1065fb8a-a8ec-fbe3-83eb-a308072ef6d6@bitmer.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-11-11 18:37, Jarkko Nikula wrote:
> On 11/8/18 10:37 AM, Peter Ujfalusi wrote:
>> The series also includes patches to updated the arch/arm/ files (defconfigs,
>> source files using audio Kconfig symbols).
>>
>> I believe with v1 all of this can be merged via ASoC tree as the chances of
>> conflicts are low for the touched arch/arm files. But Sekhar and Tony can
>> correct me if I'm wrong.
>>
>> I think I have catched all (I hope) issues regarding to Kconfig thanks to the
>> various autobuild machines out there kindly testing my linux-next-wip branch.
>>
>> I would appreciate any testing comments before I send the v1!
>>
> I applied on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git commit
> abd97b7c53ac ("Merge branch 'asoc-4.21' into asoc-next").
> 
> Patches 2 and 6 didn't apply and 7-8 I skipped. For my functional
> testing none of those were required.

Hrm, the series was based on next-20181019, but I will keep on eye on these!

> For the sound/soc/{omap => ti} conversion you may add:
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Thank you!

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
