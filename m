Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB80C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C11620874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545258147;
	bh=126KICSSkcFmbQaJqPhO+u5qpwrdVBDssOUMlacw0PY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zcO391aREF5XK7zBVSUTL3mC9ogN1/dI7hMoouH0Jg17cK/B1X+qeRQfgT0IVh5i2
	 X0+1UCQKbFJZDwy8B/HxJduFLSvFXSVnx33WDYrmVHKs6NQ5+ge84F43Euswkf7D9I
	 k43nh2GZOyRiueke1AAfUeA/Xzg6JNKr/ZFQTG6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeLSWW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbeLSWWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:22:25 -0500
Received: from [192.168.1.29] (host92-112-dynamic.25-79-r.retail.telecomitalia.it [79.25.112.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A7122086C;
        Wed, 19 Dec 2018 22:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545258145;
        bh=126KICSSkcFmbQaJqPhO+u5qpwrdVBDssOUMlacw0PY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oXwaU46bM/arFHDd2EKV8lxo8G/mU/7oF9fFGU91jsnRbbLWpAcdoXRK5M4JDWSsG
         880hGM/pv3SCV9q70YMJs0khVvV/6iWtbMligk6LaHbgFWheV6w+0MvN98pC7uDKw+
         kOV1ZMCVgyaKcCCpHknJ0/9CqS6ly8iQob8kCuZI=
Subject: Re: [PATCH v11 2/7] ACPI / OSL: Stub out
 acpi_os_(read/write)_pci_configurations()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-3-okaya@kernel.org>
 <20181218073231.GB8612@infradead.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <24aefa0d-743c-dd06-79b7-ebcc01dbbb12@kernel.org>
Date:   Wed, 19 Dec 2018 23:22:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181218073231.GB8612@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/2018 8:32 AM, Christoph Hellwig wrote:
>> +
>> +	rc = pr_warn_once("PCI configuration space access is not supported\n");
>> +	return rc ? AE_SUPPORT : AE_OK;
>> +#endif
> Normally we provide a full separate stub version.  If we have enough
> of them in a separate file.
> 

I removed the dependent functions from ACPICA and moved #ifdef outside of these
two function scopes.

Got rid of the inline piece.
