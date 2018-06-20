Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50205C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE91820693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DYKaT8pX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f+jND5+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE91820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbeFTDCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:02:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58576 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753862AbeFTDCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:02:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 57C3D608C1; Wed, 20 Jun 2018 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529463740;
        bh=2kgsuIe7F+WYGj4r7sZe8zp9Ey20N3QHafHL8jKjBw0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DYKaT8pXNTWwCpYrlE/s5WalaqZDHZOnbaJ85l6nhMMnJmCy9NHDzJ1vcbsswoijI
         NrdUry5mp/qkfk+76U1pCdnUV6z0DnQmcpUl2dfdduPxGbVyC6pybqz6hrUj6XJFdt
         Kl67z4Ym7Wfc0+2FYTai9PzIxC+38ugX2htcRY/A=
Received: from [192.168.1.125] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: timur@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20D5C607EB;
        Wed, 20 Jun 2018 03:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529463739;
        bh=2kgsuIe7F+WYGj4r7sZe8zp9Ey20N3QHafHL8jKjBw0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f+jND5+6HWKsB9p3kgf/EtVUU3UtDukrrUezmDU+l7nwQxKx0I15nDIsDRQiRQHlg
         zpveoU/PTjFAdrNM0ExGMxMvAiVNWnLoNOpE9AXOuKWifwa5j08pJkAz/6BipfaBBT
         CEOg0zHvxUNeSPOpokqhyjU+RAdlDq+NrA4zX6v4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20D5C607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
To:     Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
From:   Timur Tabi <timur@codeaurora.org>
Message-ID: <dafc272d-0748-90ee-5d34-be5b2a2e5725@codeaurora.org>
Date:   Tue, 19 Jun 2018 22:02:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/18 9:14 PM, Sinan Kaya wrote:
> +	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
> +		return;
> +
> +	dev->eetlp_prefix = 1;

How about:

	if (cap & PCI_EXP_DEVCAP2_E2ETLP)
		dev->eetlp_prefix = 1;

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
