Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035BC16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA37720893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYSL/udG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA37720893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeG3Rn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeG3Rn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:43:58 -0400
Received: from [10.82.11.247] (unknown [131.107.174.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1A49205C9;
        Mon, 30 Jul 2018 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532966899;
        bh=qZXpE5mGpYT1zj4n+NFfnLudp/q+xUcvS+yiRIoXyVY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IYSL/udGL0WynBLZs8TD8ncsrYyDbFxuYxzqnvjHuH0YXm7G2bwr9ur2PMVNmD831
         3by/Dzk8XFpjwKzlrojbLpGPV7E+mRauI9oGPwHHbwwtrA2dt/MzTqHODCkmPjP1h6
         CtR1nLjjUHZSCBlcnTKmMrdAICOG/zvfRDcJUkIY=
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayurkumar.patel@intel.com, rajatxjain@gmail.com,
        Richard Hughes <rhughes@redhat.com>,
        Carlos Garnacho <cgarnach@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pali Rohar <pali.rohar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
 <5a102163-73bc-c596-8266-186e222e7ceb@kernel.org>
 <20180730141428.GK173328@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <2fbc0d1b-0d14-6bab-74c5-a9dd2ae417bb@kernel.org>
Date:   Mon, 30 Jul 2018 09:08:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730141428.GK173328@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/2018 7:14 AM, Bjorn Helgaas wrote:
> However, the end of sec 5.4.1 does make it clear that the functions
> need not have the same ASPM configuration, and it gives rules for how
> those different settings should affect the shared link.  Since it
> mentions different ASPM Control fields for the different functions, I
> assume the policy combining those per-function settings into the
> single link behavior must be implemented in the hardware.

Very interesting. This is news for me.
