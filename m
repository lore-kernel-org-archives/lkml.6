Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1912DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C100520878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cGjCK1rj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cGjCK1rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C100520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJHP7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:59:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55760 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJHP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:59:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B110C6079B; Mon,  8 Oct 2018 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538988503;
        bh=+UDoz/CQpBmm3zwZmk5icXGeEEQUNqmd0CErF1xevI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cGjCK1rj1BcVNMFjr5QYkbXBN37j66gTDbqQbwrdkqwuh+zNA/3PNgbBtAsAs/es2
         ncApPB6X39prrwavpf/d+FUAYln2pHJsMJ4OVxe60n/Ym8yluz/QyvUW78fKeTxyNf
         etAiJPCKUh3Y4yBWRuYM6oBQQC8sRlqW4r9N/YXs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E542B6078C;
        Mon,  8 Oct 2018 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538988503;
        bh=+UDoz/CQpBmm3zwZmk5icXGeEEQUNqmd0CErF1xevI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cGjCK1rj1BcVNMFjr5QYkbXBN37j66gTDbqQbwrdkqwuh+zNA/3PNgbBtAsAs/es2
         ncApPB6X39prrwavpf/d+FUAYln2pHJsMJ4OVxe60n/Ym8yluz/QyvUW78fKeTxyNf
         etAiJPCKUh3Y4yBWRuYM6oBQQC8sRlqW4r9N/YXs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Oct 2018 16:48:22 +0800
From:   cang@codeaurora.org
To:     Evan Green <evgreen@chromium.org>
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, venkatg@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scsi: ufs: add 2 lane support
In-Reply-To: <CAE=gft6f9a2RoAvXR4+2tKZE-3chobb_HfbMDErfU1Q=_8uYwA@mail.gmail.com>
References: <20180302082346.8188-1-cang@codeaurora.org>
 <CAE=gft6f9a2RoAvXR4+2tKZE-3chobb_HfbMDErfU1Q=_8uYwA@mail.gmail.com>
Message-ID: <dfebd55dc6df88916876388dcdad3aa4@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 2018-10-04 02:34, Evan Green wrote:
> Hi,
> 
> On Wed, Oct 3, 2018 at 11:19 AM Can Guo <cang@codeaurora.org> wrote:
>> 
>> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> 
>> Qcom ufs controller v3.1.0 supports 2 lanes, add support
>> to configure 2 lanes during phy initialization.
> 
> I'm reviving this old chestnut, sorry I missed it initially. This
> description is a little terse, and I'm actually confused about it. The
> description makes it sounds like this patch is adding support for
> 2-lane UFS controllers, but the patch itself appears to only make the
> UFS controller tolerant of a missing lane (or more specifically, a
> missing lane clock). Can you describe a little more about what's going
> on here, and perhaps fix the description?
> 
> I notice that the global clock controller has clocks for TX symbol 0,
> and RX symbol 1, but seems to be missing GCC_UFS_PHY_TX_SYMBOL_1_CLK.
> Was that an oversight, or is it really not there?
> 

You are right. The name and commit message are not representing itself
correctly as most of the original commit has been upstreamed already.
I uploaded a new patch to address it.

As per Qcom's design Tx Lane1 clock derives from Tx Lane0. So only
one Tx Lane0 clock would make 2 Tx lanes work.

>> 
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  drivers/scsi/ufs/ufs-qcom.c | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
>> index 2b38db2..51889ad 100644
>> --- a/drivers/scsi/ufs/ufs-qcom.c
>> +++ b/drivers/scsi/ufs/ufs-qcom.c
>> @@ -113,10 +113,10 @@ static void ufs_qcom_disable_lane_clks(struct 
>> ufs_qcom_host *host)
>>         if (!host->is_lane_clks_enabled)
>>                 return;
>> 
>> -       if (host->hba->lanes_per_direction > 1)
>> +       if (host->tx_l1_sync_clk)
>>                 clk_disable_unprepare(host->tx_l1_sync_clk);
>>         clk_disable_unprepare(host->tx_l0_sync_clk);
>> -       if (host->hba->lanes_per_direction > 1)
>> +       if (host->rx_l1_sync_clk)
>>                 clk_disable_unprepare(host->rx_l1_sync_clk);
>>         clk_disable_unprepare(host->rx_l0_sync_clk);
>> 
>> @@ -147,18 +147,15 @@ static int ufs_qcom_enable_lane_clks(struct 
>> ufs_qcom_host *host)
>>                 if (err)
>>                         goto disable_tx_l0;
>> 
>> -               err = ufs_qcom_host_clk_enable(dev, 
>> "tx_lane1_sync_clk",
>> -                       host->tx_l1_sync_clk);
>> -               if (err)
>> -                       goto disable_rx_l1;
>> +               /* The tx lane1 clk could be muxed, hence keep this 
>> optional */
> 
> I'm confused by this comment. What do you mean the clock could be 
> muxed?
> 
>> +               if (host->tx_l1_sync_clk)
>> +                       ufs_qcom_host_clk_enable(dev, 
>> "tx_lane1_sync_clk",
>> +                                                
>> host->tx_l1_sync_clk);
>>         }
>> 
>>         host->is_lane_clks_enabled = true;
>>         goto out;
>> 
>> -disable_rx_l1:
>> -       if (host->hba->lanes_per_direction > 1)
>> -               clk_disable_unprepare(host->rx_l1_sync_clk);
>>  disable_tx_l0:
>>         clk_disable_unprepare(host->tx_l0_sync_clk);
>>  disable_rx_l0:
>> @@ -189,8 +186,9 @@ static int ufs_qcom_init_lane_clks(struct 
>> ufs_qcom_host *host)
>>                 if (err)
>>                         goto out;
>> 
>> -               err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
>> -                       &host->tx_l1_sync_clk);
>> +               /* The tx lane1 clk could be muxed, hence keep this 
>> optional */
>> +               ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
>> +                                       &host->tx_l1_sync_clk);
>>         }
>>  out:
>>         return err;
