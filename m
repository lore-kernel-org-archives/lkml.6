Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A750FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9A221780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="5gf6cxwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9A221780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeKNQ2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:28:21 -0500
Received: from cmta20.telus.net ([209.171.16.93]:51245 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbeKNQ2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:28:21 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id Mod6gceUVVltLMod7gyGk2; Tue, 13 Nov 2018 23:26:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1542176790; bh=Z44n7rQpXhGQF8whUYwJw64l1wpYsHXowSq4fpIIpFI=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=5gf6cxwQdkfmLnRMdNY99KScdL7AH236D14TYu/NFJ4o0mHKL6G8Q1/B3jgEDzrvj
         232VXVF4OFDx8qMALTRx7RpNNQWM7XL/lcfWetkpDsXD91nIGYTvarhu4Im637HUWL
         luT+8kOUu7XgIjWLKcVF2eaE532AtpruWzxDC8gPVAuOeb9rewxYYPMCRhC+8oFJUM
         6rDkgbkczt37+HRLpk+ToWA2eYQ4VSSq4c+yxCNZ4miXUYdOapgNlH1RjmEPRgoM5M
         LtMj5CvvKMWHCT/d782bPcIPtpbiAHvrI/Wv8Pnq5w5og85UjDodQj9bWWpRfXfK6n
         sqYd54/VNTKBw==
X-Authority-Analysis: v=2.3 cv=d60kNirE c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=Z3ho9MQ1ZARmlecURzcA:9 a=CjuIK1q_8ugA:10 a=5JIPC4SmUL4A:10
 a=eM4ghy-HDjkA:10 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <000001d476bb$ec964520$c5c2cf60$@net> KfE8gqrRG7nW7KfEDgBkXZ
In-Reply-To: KfE8gqrRG7nW7KfEDgBkXZ
Subject: RE: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date:   Tue, 13 Nov 2018 22:26:22 -0800
Message-ID: <004901d47be2$fa1d0c20$ee572460$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdR3OVCeALNh8r9YQtagzos9/QD9hQEqMdoQ
X-CMAE-Envelope: MS4wfDvzmMqnoul+Jka1AepeAbSY0zK8cgExONv4cpccr2hVYDMbLrhWslyv7eD4B53jQFTsa87ozXPtURfiC0BWHA+61FbVV65jRTwsBdifGv7+2hWEy4qh
 itXATDlo5/1oU0HcmcEV/hJU/S1/bTCr0Th3tws735Nh2I4Ei4UPU/N2tshpwQ/sdDMDllwPoWti6wz2dtiI9WWVCAzscX6ylTv194IIUjx83myUGYhUE1OT
 oz46YskwrQYL4noZBfKze0OaDLJchV/eAHSocv5U0QF4ECrDRWJcCedk0x7nACnTz6jXezqRI9dukRIK4r0quK/tHxYQK46dIZp16hwiWa0gpr4vAOgZe6rd
 R9a7iMGT8bGIFUH2c0/lBNG+m/eM9ULTBxCjc9m5HuRhps7uFuu9z6lOpWr7IWKf7cEJI4CLGH8kuDdbMMsDTGKpCd/vjtzkyHWxZMuk01KGd1wSh4i8sEDg
 CG/AvYzMiAkNFErA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.11.08 00:00 Rafael J. Wysocki wrote:
> On Wednesday, November 7, 2018 6:04:12 PM CET Doug Smythies wrote:
>> On 2018.11.04 08:31 Rafael J. Wysocki wrote:

...[snip]...
>> The results are:
>> http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
>> http://fast.smythies.com/linux-pm/k420/histo_compare.htm

...[snip]...

>> There are some odd long idle durations with TEOv3 for idle
>> states 1, 2, and 3 that I'll watch for with v4 testing.
>
> That unfortunately is a result of bugs in the v4 (and v2 - v3 too).
>
> Namely, it doesn't take the cases when the tick has been stopped already
> into account correctly.  IOW, all of the data points beyond the tick boundary
> should go into the "final" peak.
>
> I'll send a v5.

With v5 there were no long idle durations for idle states 1, 2, and 3 for
this same Phoronix dbench test.

... Doug


