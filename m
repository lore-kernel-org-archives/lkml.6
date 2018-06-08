Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DOuhA86DGlt5QQAAmS7hNA
	; Fri, 08 Jun 2018 13:32:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 96917607E4; Fri,  8 Jun 2018 13:32:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHRR595y"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E9C6760590;
	Fri,  8 Jun 2018 13:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9C6760590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeFHNck (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:32:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37864 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeFHNcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:32:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21-v6so18130926lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/JH8PRbba3uYQKWOgdUFzVcqt5g+apdNhR/22Pwm4HQ=;
        b=IHRR595yD+110bC29wJXy7zP223jhkrkUc+36ZsAGWiXcyw0J2nrcnykSRBm0v8IP6
         T5k5SNMP0Mb8KZBobgXU3VouX1M7uY2VTYpKZ40qjffTR+ZeBPcOcsX0IIJGkjiwqPgM
         oN4dG6uB/5kfXHdDKaniln4lNHi8fVG/IXrtJM8/YPAzpn0HvhTh1Zib90k2z2BVK9l9
         Xnc1td0oPaaLqbkPux5n7i4KuhMYHVTOZdKq4H7AWm8Rt0qDA0lxo7/D33lwQxyVfWO+
         NijXm2b/SpQgdorQcocE/t1nLowQjH6MTrGR4VyzAj0e8qkwBlWM7U0K1tT2TVHNP0qD
         uo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/JH8PRbba3uYQKWOgdUFzVcqt5g+apdNhR/22Pwm4HQ=;
        b=kTYulHZkaIOpZ9RCMaCP0e42l47e5XU0QNUwAu3gENNx+RLCo3+qGSzVw5BE8A8VWa
         TddmFyZtY2p6iKp4AFeiUK5YCmLE8MKRthjxTaWbIsVCrpK9GF/EgVwoFoyB1jyJSUpx
         m1w5dDEcdhoc2Hx2+h8KR9jTFDUi61BXw10OZWEHYWTbtrJOZDYvAwVLzyawnGXcJvu7
         woKCdLtPGaKrQOh3sbA+XRjtyaLsVaWpqc9HK+lbHAzEpuPFEVMSE+VbAuKh4yo+6n2z
         2NUUPKyFch4dc6xfWDqOwopN0ptOIWPHBgU8YjZdBQITc0VDJ5dDwOE8zunCFuZxO3it
         j9+w==
X-Gm-Message-State: APt69E3soy9+20nsidHLVTwQqcm/+qweodP8e3OnZufp0wR/E+KFkeuj
        1PyrR59XtOJRn/ZplevDijEaQtNjZdYKcHNVAw==
X-Google-Smtp-Source: ADUXVKIpGgAyRcku+RLkgGBJ1bSKzb5sHx05Y7/lpQod65GnwqddR1sfu/C5znqx9douTmoKjtK3UMa5JIjx+fhtF08=
X-Received: by 2002:a2e:428e:: with SMTP id h14-v6mr4870397ljf.136.1528464758056;
 Fri, 08 Jun 2018 06:32:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:e45c:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 06:32:06 -0700 (PDT)
In-Reply-To: <1c8b3938-6656-5d5a-f65d-dfd2e55d989e@amd.com>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com> <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
 <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net> <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
 <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com> <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com>
 <20180608060223.GB24107@lst.de> <1c8b3938-6656-5d5a-f65d-dfd2e55d989e@amd.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Fri, 8 Jun 2018 15:32:06 +0200
Message-ID: <CAEJqkggkZynDvV8XxkFfy89x-DX5xDTyubUJ3oXBO6eUjBWBKw@mail.gmail.com>
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>,
        alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-08 8:52 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd.com>:
> Am 08.06.2018 um 08:02 schrieb Christoph Hellwig:
>>
>> On Thu, Jun 07, 2018 at 02:32:46PM +0200, Gabriel C wrote:
>>>
>>> Ok done.. bisect points to:
>>
>> What is the failure mode you are seeing?  Can't find anything in the
>> mail unfortunately.
>
>
> As far as I analyzed it we now get an -ENOMEM from dma_alloc_attrs() in
> drivers/gpu/drm/ttm/ttm_page_alloc_dma.c when IOMMU is enabled.
>
> Still need to figure out which parameters we want to use for the allocati=
on,
> but I think it is only 4k or 8k.

When you guys need me to test something , or run debug patches
or patches of any sort just let me know..

>
> Regards,
> Christian.

BR
