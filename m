Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B5BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3427827C71
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3427827C71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935590AbeF2JcN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:32:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35158 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933037AbeF2JcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:32:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id c1-v6so6825725edt.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8H9xDgFGFHyFL+HEPRvJRG9Nkpr+UrtEa/2IgpIsR4g=;
        b=RGD2u60pqn3GCs90JY7dHROo/pgFygrPugD2AncSWTTLQZecpQKhxWoQQWUe/e97gq
         nIp/Yf/UAK19zhUMY4vvdYN2rBOk3oFCZVyV8OUSHWViLZSkrgR6Kt6Xixvhx8Se/OzR
         JB4nLcZf2qk83zcGuMdGd9+DXy7O2/ThidjtozFuam0bq3thW0ZibS7aMfqDc9sOiD0Q
         ICT3IJ7XLHCKxTsLel+J5s0EMDyumdqxBz76qPXiqV8Ho6O+k0pjcu6ZnWrvxWxPg5t0
         V1UNOZNnid+2yIobfo2pbDdwXHcu4GgqwbRY1z7aZCEh5MZPXZ5LXqHGstCCiFLrxBOh
         022Q==
X-Gm-Message-State: APt69E243MKD4L4olOn+vnzDITC+8p5C6Bvh+JZeI7AmyCMpGzdtfKil
        nyL9R9D58hvWmZN4q+y9TgFioA==
X-Google-Smtp-Source: AAOMgpe4/RE6kAwQMjFhLIePN8sdwkIwixDTalELanBTZJ6+obLmdNTc4LRFt0hBfWgrm/IXlEjblA==
X-Received: by 2002:a50:d64a:: with SMTP id c10-v6mr12637665edj.178.1530264730368;
        Fri, 29 Jun 2018 02:32:10 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e33-v6sm3644085eda.56.2018.06.29.02.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:32:09 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the fbdev tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
References: <20180629110744.29b54355@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dff81030-46bd-b80b-3d66-8ccb925accc8@redhat.com>
Date:   Fri, 29 Jun 2018 11:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629110744.29b54355@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29-06-18 03:07, Stephen Rothwell wrote:
> Hi Bartlomiej,
> 
> After merging the fbdev tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: "dummycon_unregister_output_notifier" [drivers/video/fbdev/core/fb.ko] undefined!
> ERROR: "dummycon_register_output_notifier" [drivers/video/fbdev/core/fb.ko] undefined!
> 
> Caused by commit
> 
>    83d83bebf401 ("console/fbcon: Add support for deferred console takeover")
> 
> I have reverted that commit for today.
> 
> I note that this commit is in the drm-misc tree as well.

Ugh, my bad. I did not take the fb code being modular into account
here. I will submit a follow up patch fixing this today.

Regards,

Hans
