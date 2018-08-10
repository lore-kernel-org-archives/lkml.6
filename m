Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF394C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6552F223B9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmeYWqEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6552F223B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeHJEm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbeHJEm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:42:56 -0400
Received: from [192.168.0.114] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F1C223B5;
        Fri, 10 Aug 2018 02:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533867315;
        bh=iosI23IYbeEOM9ZQMWS0T019jcSGAprvdtQXwp+1xDw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fmeYWqEBIO5wuiQLF1GQRTnS/5dzD8GRlbZOF3pdPOA7QaJrual9jpXLgYrP27aGm
         z8W03rejUKIjZ9b5IixBpSISzKDtLr85od2Lzqf2M0uK8oxI8Hi2K6Izae9JGadpFN
         uDpzuVBTTdMfrhFoae56C2ldj7xASftpXYba64ts=
Subject: Re: [PATCH 1/2] PCI/ACPI: correct error message for ASPM disabling
To:     Joe Perches <joe@perches.com>, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1533840383-7841-1-git-send-email-okaya@kernel.org>
 <307063ff7bbdcc0c3896f027b09245e542764f48.camel@perches.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <2a8b5c60-45ba-1fc4-d261-fcfbd7f16910@kernel.org>
Date:   Thu, 9 Aug 2018 22:15:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <307063ff7bbdcc0c3896f027b09245e542764f48.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2018 8:27 PM, Joe Perches wrote:
> I think this would read better not using a temporary and
> using a ternary instead.

Makes sense.
