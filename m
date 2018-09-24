Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AF0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C98120C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="huZFyatj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oE4mDh/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C98120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeIXOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:49:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56062 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeIXOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:49:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 59EC0607A2; Mon, 24 Sep 2018 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537778883;
        bh=n7AITtKARulfNUSfXJtsqKnjsZjKQ9zhN/HqebvXRVc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=huZFyatjFiAACA8dkO0b503/C498iHXlBE3KOUxl0NTnr5CyhV+jlgv9bDEMozaZs
         UCK/kkLtavbHXW93v9Ac6NL+0Hbza1Oe3irp63lVclpPwPLtQxPS6M/vX+JTL6I5MK
         MAL0JaOkwgv/cd7y+n5dyiMsseCyRRCYzPFjcLJ4=
Received: from [10.242.6.76] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4061605FD;
        Mon, 24 Sep 2018 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537778882;
        bh=n7AITtKARulfNUSfXJtsqKnjsZjKQ9zhN/HqebvXRVc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oE4mDh/dybs2uebiNuVjYG9euIX5yFs7gYA1alkDBryTBo3YiCbHiq/rUEu2WZb0v
         oPx8fyHoBgzjOitFtotbFUinkGTIXMFb3fb7g86GzN07Bqi/D/QaucwHJYqeZx4rky
         uInTz7hdIgCXAcl96dE1D1sYHzliMMSbuu1EmZD4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4061605FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V14 1/2] scsi: ufs: set the device reference clock setting
To:     Avri Altman <Avri.Altman@wdc.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>
Cc:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org>
 <1537770516-28410-2-git-send-email-sayalil@codeaurora.org>
 <SN6PR04MB49250F1D665127DBA82137A3FC170@SN6PR04MB4925.namprd04.prod.outlook.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <0761c2c2-4366-0a20-6789-10c4c9498908@codeaurora.org>
Date:   Mon, 24 Sep 2018 14:17:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB49250F1D665127DBA82137A3FC170@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/2018 1:28 PM, Avri Altman wrote:
>> +static struct ufs_ref_clk ufs_ref_clk_freqs[] = {
>> +       {19200000, REF_CLK_FREQ_19_2_MHZ},
>> +       {26000000, REF_CLK_FREQ_26_MHZ},
>> +       {38400000, REF_CLK_FREQ_38_4_MHZ},
>> +       {52000000, REF_CLK_FREQ_52_MHZ},
>> +       {0, REF_CLK_FREQ_INVAL},
>> +};
>> +
>> +static inline enum ufs_ref_clk_freq
>> +ufs_get_bref_clk_from_hz(u32 freq)
>> +{
>> +       int i = 0;
>> +
>> +       while (ufs_ref_clk_freqs[i].freq_hz != freq) {
>> +               if (!ufs_ref_clk_freqs[i].freq_hz)
>> +                       return REF_CLK_FREQ_INVAL;
> Is the if clause really needed?
> you will return REF_CLK_FREQ_INVAL anyway
Yes. the if condition makes sure to return REF_CLK_FREQ_INVAL if freq is 
not what we expect.
>
>> +               i++;
> You might overrun here if freq is not what you've expected
Above if condition "if (!ufs_ref_clk_freqs[i].freq_hz)" prevents such 
overrun
as we will reach end of ufs_ref_clk_freqs[] (i.e upto  0, 
REF_CLK_FREQ_INVAL) when there is no match and thus we will return 
REF_CLK_FREQ_INVAL.
>> +       }
>> +
>> +       return ufs_ref_clk_freqs[i].val;
>> +}

