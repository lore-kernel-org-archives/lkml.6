Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA16DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8872054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500880;
	bh=MvcRrZ5Vx+OmZeYyfaIm8JfWG3AWxslBL1Iq393xUXU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LAnvCui+4A+LlfBo8ENVYfzuebdLmvezJEzYZbFSPlQpgCGSU7oO7Gs7jWIWYwk3s
	 8uslZq/6NEmNWmUgnmQl/qyTLLOi+3rk3piGCVTguMj7VQ1EF6uE44uxlkcRTOmny/
	 O5HUK7V95vA7QsnVnMrJDFEEY6liqYQMDcFIgcUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404534AbeLVRr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391420AbeLVRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:15 -0500
Received: from [192.168.43.85] (unknown [5.92.228.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A9B21972;
        Sat, 22 Dec 2018 08:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545467702;
        bh=MvcRrZ5Vx+OmZeYyfaIm8JfWG3AWxslBL1Iq393xUXU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QvqAnZZEqZC64podMAOn7oqGM+HhsYRFbGbEmnla0d8VIMVGgVwpKhvgHlDiwNUow
         fNYZdQsRHxoYizYg7C4tG3Zb1xtr1/1o/p9tHtnTyLw0CSqDaC5TcEm0cRM/l77dPR
         WFATc7LvXYSHKsgx7L6/qj35ZbbxvjeLw9XU3zAg=
Subject: Re: [PATCH v1 08/11] ASoC: Intel: Make PCI dependency explicit
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
 <20181222001452.7474-9-okaya@kernel.org>
 <eb27ab03-4f42-2e2e-9873-16d9a6927e2b@infradead.org>
 <CAK9iUCN77U5tQn-WWaL27v244GkEAgRBxKK1H_+xUhOZ2aCERw@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <cda9b574-375a-10c7-7a24-9f6fe4aa62b7@kernel.org>
Date:   Sat, 22 Dec 2018 09:34:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAK9iUCN77U5tQn-WWaL27v244GkEAgRBxKK1H_+xUhOZ2aCERw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/2018 7:26 AM, Sinan Kaya wrote:
> On Sat, Dec 22, 2018 at 4:19 AM Randy Dunlap<rdunlap@infradead.org>  wrote:
>> On 12/21/18 4:14 PM, Sinan Kaya wrote:
>>> IOSF_MBI driver depends on CONFIG_PCI set but this is not specified
>>> anywhere.
>> wrong patch description...?
> Not really...
> Code does unconditional select for IOSF_MBI.
> 

I'll put the above comment into the commit message to make this change cleaner.
