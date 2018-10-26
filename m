Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA24ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B52420848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B52420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJZTLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:11:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35439 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJZTLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:11:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id e2-v6so851895edn.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 03:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XYGUc1ATUYL8gpeUhaZaD4K0YAQd36Xi99NprINFxPs=;
        b=TQuC3PgE4TALc2Og21y30CisR7I8umxosS1s+TF2Qlhhqw7tesb6BSJ9nDiZrkrQBi
         TOPhldAyyDBLf0UhFz2F1YgcbMSJ5V7Oxd5FIaVahPJYIM+qQ9llEdkIm6kmQFO7q5jv
         vuPBH2wujGfWdAqervYhCnA3cMv6YQzjK9DIU8Lyyc0jeQAqtdla3tTDJf4o7Cfzm2au
         hJjkzaMMZHKybOz7+/9UbgTFTejBpFzGYgLsVeBkA2QkTRXzC6JO9+5hiES6lLSPza/L
         mERccyYhpno5rauGAxGkygkrjupMD5SONezJEQ2xUwc8lQY6YRc/837W0ZqH7KEYtD1C
         dalQ==
X-Gm-Message-State: AGRZ1gIaePeWLbT3Hh5sJeU4Jakv9cVFlmKsK/COW/d+FG0/lZnUe+iR
        fRH8+OTvkEGmy4in2TAJzf7Us2HATqE=
X-Google-Smtp-Source: AJdET5fkxYXYLc5MmqE+pR/epZEa3USv6+B2gEXCltlh0CoTUlfsF5pb7aLm4SrS72qJsofsR+WI+w==
X-Received: by 2002:a50:af22:: with SMTP id g31-v6mr2467737edd.106.1540550075282;
        Fri, 26 Oct 2018 03:34:35 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b25-v6sm2210655ejo.74.2018.10.26.03.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 03:34:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] staging: vboxvideo: Remove chekpatch issues
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1540490962.git.shayenneluzmoura@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e59aeb92-b2f9-ae8d-f910-4410ba9c732a@redhat.com>
Date:   Fri, 26 Oct 2018 12:34:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1540490962.git.shayenneluzmoura@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25-10-18 21:40, Shayenne da Luz Moura wrote:
> This series cleans the following checkpatch.pl issues:
> 
> CHECK: Prefer kernel type 'u32' over 'uint32_t'
> CHECK: Avoid using bool structure members because of possible alignment issues
> 
> Shayenne da Luz Moura (2):
>    staging: vboxvideo: Change uint32_t to u32
>    staging: vboxvideo: Use unsigned int instead bool

Why am I receiving only the cover letter of this series? Please resend
so that I get all the patches.

Also at least the first patch is wrong, the drm headers use uint32_t
in the prototype definition of the callback functions we are defining,
so the vboxvideo code should use the same even if the compiler does not
warn about the callback implementation having different parameter types
in this case.

Regards,

Hans




> 
>   drivers/staging/vboxvideo/vbox_drv.h        | 14 +++++++-------
>   drivers/staging/vboxvideo/vbox_mode.c       |  2 +-
>   drivers/staging/vboxvideo/vboxvideo_guest.h |  2 +-
>   3 files changed, 9 insertions(+), 9 deletions(-)
> 
