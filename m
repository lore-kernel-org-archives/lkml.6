Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9984FC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7352084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="Y6vYbB8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmYkWBYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7352084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbeJ3L5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:57:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59813 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbeJ3L5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:57:31 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 607F5223C3;
        Mon, 29 Oct 2018 23:05:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Oct 2018 23:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=yGNTUXV4BI8lmADm8Ca3TRwqrD
        O+Gcg/2BSnyqQU6/4=; b=Y6vYbB8FWx+zIBHkaGwPDinlC3jkPp5bNV6NtSxpty
        DbyK5YFBWkeUmiIAbclS5wJQn99UfBy9nVmYnHry+3jE6vzc/Ed0uww9Zv2Wl1ck
        l1wpQTBYGfWCHLSao27WNMP/uoeG9QthJ6BoMpN24X2l4D4cOLBSFZCqoPmbT+JT
        7GQKnsaQQ8UF4jKhxNyrJDdhfF3+zDTHQDuwDCM+qkxzKQsMjNqgJIXK/qvKH9Z6
        KdpijNJuzq8qj6rvPGEIOfEaW+YZx6lu65DwKun+EyfDHnjOcCDzgpx11La+JXXd
        YseanpnASlSzwzw+WNWv1BXjW/J7qc4PKJYDlTkio5Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=yGNTUXV4BI8lmADm8Ca3TRwqrDO+Gcg/2BSnyqQU6
        /4=; b=AmYkWBYjQfQobPBTSn6AYVRWvwVNVmNd5t2Z1ccbDVsR4lzCZii/T59kj
        HrDLH1iVbAam81zahkiNL7QkbbKxyz6Tcrv1mfy6AzO3xOzHJwUy+B5N6/oXlas2
        wdIc0lmCex7iI0rKklMyKkHP7DNg6UmIKv5zbD94g2WtXVqtV97q6/YumTSe6qOx
        aPvJQV0XSTWsu63L6whEoo5+XZyZVL9Kl2QGo81FkwCn9eId44tGFObrUwDYscir
        WZLpKqhpMt6u30UtVvadZDl/83Ic9p+1mFPRkoeNR8yRVU5AdyTEk5hYCi+7rhlE
        mobkiY7TWV6aQV/M/r5EftJG44P1A==
X-ME-Sender: <xms:kcrXW3zjNTAMA12UjAxdT3jfsmYmXNhZwL6o7D7nbmGCxu95SaHE4A>
X-ME-Proxy: <xmx:kcrXW-rNmZMl8L3GXNnizrjxBI2U2RLJrdwiHvP21GSeOW1wxBNpDQ>
    <xmx:kcrXW6BR9VqPtqo8ZIawR79iKS-__ZL3wNRGgw2UYDM_2YHBgxlVAA>
    <xmx:kcrXW8uRu-P7Kr2qMGJvOj6GsS_h64n9mnwkQxSAbzn7ux4CpIqktQ>
    <xmx:kcrXW5I3eHYqHqGifYqFfZfON3-UqO5K7CFrpb3enIKz3B5IIdj_xQ>
    <xmx:kcrXWzZbLaz5Z5AovYOq85gWJ66a--NwRSBMGadPMDJJYtQa-IDRCQ>
    <xmx:ksrXW2P8npErHokJqa8bzzU3AOhwm5CXYE1-R8q9yxeF6-JUgpFKBA>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85548102FA;
        Mon, 29 Oct 2018 23:05:51 -0400 (EDT)
Message-ID: <c64d1e440e2469ad0125b6c27c3bc4c59723bdb9.camel@mendozajonas.com>
Subject: Re: [PATCH net-next v2 6/6] net/ncsi: Configure multi-package,
 multi-channel modes with failover
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Justin.Lee1@Dell.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Tue, 30 Oct 2018 14:05:48 +1100
In-Reply-To: <93324b3c0a9b4929aa64801b4ed9c25c@AUSX13MPS306.AMER.DELL.COM>
References: <20181023215201.27315-1-sam@mendozajonas.com>
         <20181023215201.27315-7-sam@mendozajonas.com>
         <93324b3c0a9b4929aa64801b4ed9c25c@AUSX13MPS306.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-26 at 21:48 +0000, Justin.Lee1@Dell.com wrote:
> Hi Samuel,
> 
> There is one place that we assume the next available TX channel is under the same package.
> Please see the comment below.
> 
> Thanks,
> Justin
> 
> 
> +/* Change the active Tx channel in a multi-channel setup */
> +int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
> > +			   struct ncsi_package *np,
> > +			   struct ncsi_channel *disable,
> > +			   struct ncsi_channel *enable)
> > +{
> > +	struct ncsi_cmd_arg nca;
> > +	struct ncsi_channel *nc;
> > +	int ret = 0;
> > +
> > +	if (!np->multi_channel)
> > +		netdev_warn(ndp->ndev.dev,
> > +			    "NCSI: Trying to update Tx channel in single-channel mode\n");
> > +	nca.ndp = ndp;
> > +	nca.package = np->id;
> 
> If the channel may be on different package, the package ID here may not be correct
> in some cases.
> 
> > +	nca.req_flags = 0;
> > +
> > +	/* Find current channel with Tx enabled */
> > +	if (!disable) {
> > +		NCSI_FOR_EACH_CHANNEL(np, nc)
> > +			if (nc->modes[NCSI_MODE_TX_ENABLE].enable)
> > +				disable = nc;
> > +	}
> > +
> > +	/* Find a suitable channel for Tx */
> > +	if (!enable) {
> > +		if (np->preferred_channel &&
> > +		    ncsi_channel_has_link(np->preferred_channel)) {
> > +			enable = np->preferred_channel;
> > +		} else {
> > +			NCSI_FOR_EACH_CHANNEL(np, nc) {
> > +				if (!(np->channel_whitelist & 0x1 << nc->id))
> > +					continue;
> > +				if (nc->state != NCSI_CHANNEL_ACTIVE)
> > +					continue;
> > +				if (ncsi_channel_has_link(nc)) {
> > +					enable = nc;
> > +					break;
> > +				}
> > +			}
> 
> When we search, we need to consider the other available channel might be on the
> package.

Good point, I've updated this to allow for enabling Tx on a different
package.

Thanks,
Sam

> 
> > +		}
> > +	}
> > +
> > +	if (disable == enable)
> > +		return -1;
> > +
> > +	if (!enable)
> > +		return -1;
> > +
> > +	if (disable) {
> > +		nca.channel = disable->id;
> > +		nca.type = NCSI_PKT_CMD_DCNT;
> > +		ret = ncsi_xmit_cmd(&nca);
> > +		if (ret)
> > +			netdev_err(ndp->ndev.dev,
> > +				   "Error %d sending DCNT\n",
> > +				   ret);
> > +	}
> 
> I remove the cable from ncsi0 and it doesn't failover to ncsi3 as ncsi0 and ncsi3 are not under
> the same package.
> 
> cat /sys/kernel/debug/ncsi_protocol/ncsi_device_
> IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC CS PS LS RU CR NQ HA
> ======================================================================
>   2   eth2   ncsi0  000 000 1  1  1  1  1  1  1  3  0  0  1  1  0  1
>   2   eth2   ncsi1  000 001 0  0  1  1  1  0  0  1  0  1  1  1  0  1
>   2   eth2   ncsi2  001 000 0  0  1  1  1  0  0  1  0  1  1  1  0  1
>   2   eth2   ncsi3  001 001 1  0  1  1  1  1  0  2  1  1  1  1  0  1
> ======================================================================
> MP: Multi-mode Package     WP: Whitelist Package
> MC: Multi-mode Channel     WC: Whitelist Channel
> PC: Primary Channel        CS: Channel State
> PS: Poll Status            LS: Link Status
> RU: Running                CR: Carrier OK
> NQ: Queue Stopped          HA: Hardware Arbitration


