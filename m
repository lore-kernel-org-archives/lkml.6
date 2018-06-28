Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D382C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3336324547
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XgwOOsoU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DJswhCKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3336324547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935208AbeF1Jo7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:44:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935092AbeF1Jo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:44:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 25EF360B1A; Thu, 28 Jun 2018 09:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530179097;
        bh=oiQWCBRv3HzUzWpnxwTCgSHhiTWaPaS5tdjHPMD4iLQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XgwOOsoU2NAbrNSFuCRvAv+hUmgiI8cRx+HzayuFCjmpg2Um4rn+U37xGnAt2PaPq
         yjLf/ia1+kActaRr0MqInBNrl7pgGBzvQPzf86wX58NjZ0l9rTxagZ7SxzN6DkNECh
         9V4tRczvjTgEzPmyuC7z6tDPhnLtXsDR5S6MT5Ec=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9521260711;
        Thu, 28 Jun 2018 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530179096;
        bh=oiQWCBRv3HzUzWpnxwTCgSHhiTWaPaS5tdjHPMD4iLQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=DJswhCKSXWY2DNfxtlD86E/+Iit8NEHAibuhMH/tnlJhRar5Dw9kPbd540UHEzB2y
         yOo08Z3T9dx16g/eJo2Zuz/UVj7VikvTGCRtcu+wZ5Yj2jAAiltqYJSpdDv0sGi5tw
         T4O87yLqw+bGa6vYtZH6g22DrTpf4qcqW6i0poQU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9521260711
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] ath10k: transmit queued frames after processing rx packets
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180523221508.26391-1-niklas.cassel@linaro.org>
References: <20180523221508.26391-1-niklas.cassel@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180628094457.25EF360B1A@smtp.codeaurora.org>
Date:   Thu, 28 Jun 2018 09:44:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Cassel <niklas.cassel@linaro.org> wrote:

> When running iperf on ath10k SDIO, TX can stop working:
> 
> iperf -c 192.168.1.1 -i 1 -t 20 -w 10K
> [  3]  0.0- 1.0 sec  2.00 MBytes  16.8 Mbits/sec
> [  3]  1.0- 2.0 sec  3.12 MBytes  26.2 Mbits/sec
> [  3]  2.0- 3.0 sec  3.25 MBytes  27.3 Mbits/sec
> [  3]  3.0- 4.0 sec   655 KBytes  5.36 Mbits/sec
> [  3]  4.0- 5.0 sec  0.00 Bytes  0.00 bits/sec
> [  3]  5.0- 6.0 sec  0.00 Bytes  0.00 bits/sec
> [  3]  6.0- 7.0 sec  0.00 Bytes  0.00 bits/sec
> [  3]  7.0- 8.0 sec  0.00 Bytes  0.00 bits/sec
> [  3]  8.0- 9.0 sec  0.00 Bytes  0.00 bits/sec
> [  3]  9.0-10.0 sec  0.00 Bytes  0.00 bits/sec
> [  3]  0.0-10.3 sec  9.01 MBytes  7.32 Mbits/sec
> 
> There are frames in the ieee80211_txq and there are frames that have
> been removed from from this queue, but haven't yet been sent on the wire
> (num_pending_tx).
> 
> When num_pending_tx reaches max_num_pending_tx, we will stop the queues
> by calling ieee80211_stop_queues().
> 
> As frames that have previously been sent for transmission
> (num_pending_tx) are completed, we will decrease num_pending_tx and wake
> the queues by calling ieee80211_wake_queue(). ieee80211_wake_queue()
> does not call wake_tx_queue, so we might still have frames in the
> queue at this point.
> 
> While the queues were stopped, the socket buffer might have filled up,
> and in order for user space to write more, we need to free the frames
> in the queue, since they are accounted to the socket. In order to free
> them, we first need to transmit them.
> 
> This problem cannot be reproduced on low-latency devices, e.g. pci,
> since they call ath10k_mac_tx_push_pending() from
> ath10k_htt_txrx_compl_task(). ath10k_htt_txrx_compl_task() is not called
> on high-latency devices.
> Fix the problem by calling ath10k_mac_tx_push_pending(), after
> processing rx packets, just like for low-latency devices, also in the
> SDIO case. Since we are calling ath10k_mac_tx_push_pending() directly,
> we also need to export it.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

3f04950f32d5 ath10k: transmit queued frames after processing rx packets

-- 
https://patchwork.kernel.org/patch/10422451/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

