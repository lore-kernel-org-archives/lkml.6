Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EGNrJ/+SGVtLPgAAmS7hNA
	; Thu, 07 Jun 2018 20:18:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 019C16089E; Thu,  7 Jun 2018 20:18:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="A4YC8HnX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 680BF605A2;
	Thu,  7 Jun 2018 20:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 680BF605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeFGUSe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:18:34 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44656 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932212AbeFGUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:18:33 -0400
Received: by mail-ot0-f194.google.com with SMTP id w13-v6so13046993ote.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=34tLBRJDgxgMjWBDnQa7mB2YN+JDR82PKmjSLthhxhw=;
        b=A4YC8HnXBABrY7qvjAFAV+0MuAI/SqZ08Pel2IytA8TX0lj7D95f+V34y2hTga54fK
         MLP+ir210+naR179NAvfuSvGPiFwW0QvGQ3VlY+o4BQDiLxYVxmIxjU4sdBUZ9h5Xs21
         t+2DrS+7vIXMuYoU8H/aYl7z85cqJM0CQWMcgumn8ZbYJkUUiipCAU6glEuSmpmQzyzo
         YreR+kS8my/JZEknFM77vrsx0KnMsc2XKz7P/LHy25HmKyySyIx9k5MJwqkVVZ92VO9I
         WYJ0fJQBJ8RO9XetGrSuR/ELSFpjKsSuuqPpjk2EOINVFu2S7/mx5AxwnRQz4+N30jJM
         x7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=34tLBRJDgxgMjWBDnQa7mB2YN+JDR82PKmjSLthhxhw=;
        b=pRvIvXHLMY8KFb4dp6jpRkPfnv3DyNDPmRXJA7l7lAAPb1vl+F7T9yR615olkSrxad
         zFpYMDsBMO/varwpyFp/Nx89lveXDw+Ww9qiwLr6VC5gSF2XSZEOTsYX9QjubMxc7Oko
         FXRWPxbayaWrZgXFCDBbISWS/HLmhyRv8p6z+MPG96fzaVRy3OE0C5qWu+KVqys0TADq
         NV5H5v7yZ7SyMA+vKdk/1Sa0QPqwqaUPXCZoMrKri1djgbvi20vMxv0Rx5xw8ZgbYxgy
         6X4Kr7a8GbXU4Ny+y9IwmVR6hDgIVHTzRWUJuuTDdekkv3nt8kCZ2mBhlqSaMGAZast1
         Z48A==
X-Gm-Message-State: APt69E3NaZ41E52RnJyAwInyR1yM39AKH9QdHDQ1aOF1YHpS02k1dwSQ
        gZSejKU6+VDOm/KoCvACOaStQKMNcE+OW0+8QcZQTg==
X-Google-Smtp-Source: ADUXVKKQDws2VREwhvZhjBoyBif0P/V63QGHaAu6pl7xfo1JGZ9e6vEiBAHUEeAEg8oydvv3sH3pGODmyNS0gWKWcgc=
X-Received: by 2002:a9d:7311:: with SMTP id e17-v6mr1867112otk.162.1528402712355;
 Thu, 07 Jun 2018 13:18:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 13:18:31 -0700 (PDT)
In-Reply-To: <20180607174337.GA22594@agluck-desk>
References: <cover.1527283897.git.tony.luck@intel.com> <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com>
 <20180607174337.GA22594@agluck-desk>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 7 Jun 2018 13:18:31 -0700
Message-ID: <CAPcyv4hNjnm+CawtRzU=ROUo02+XsBxjUmMGMcpjHKnL5M42Jw@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/mce: Check for alternate indication of machine
 check recovery on Skylake
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 10:43 AM, Luck, Tony <tony.luck@intel.com> wrote:
> On Fri, May 25, 2018 at 02:42:09PM -0700, Tony Luck wrote:
>> Currently we just check the "CAPID0" register to see whether the CPU
>> can recover from machine checks.
>>
>> But there are also some special SKUs which do not have all advanced
>> RAS features, but do enable machine check recovery for use with NVDIMMs.
>>
>> Add a check for any of bits {8:5} in the "CAPID5" register (each
>> reports some NVDIMM mode available, if any of them are set, then
>> the system supports memory machine check recovery).
>>
>> Cc: stable@vger.kernel.org # 4.9
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> ---
>
> Has this stalled somewhere?  I'd like to see this one go into the
> 4.18 merge because it unbreaks some real hardware.
>
> Parts 1 & 2 are nice-to-have, but they just make for better error
> messages so aren't as critical.

I'm making an effort to get all persistent memory error handling holes
covered this cycle, so I think it makes sense for this to go through
the nvdimm tree. This looks sufficiently non-controversial that I
could justify sending it to Linus along with the other pmem updates.
