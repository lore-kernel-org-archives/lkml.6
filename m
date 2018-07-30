Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F93C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7461220870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9YMh2g6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7461220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeG3JOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:14:18 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:42769 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeG3JOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:14:18 -0400
Received: by mail-lf1-f54.google.com with SMTP id u202-v6so7420986lff.9;
        Mon, 30 Jul 2018 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jaXIxM0AplhJfDw6T3yPDNUxipBix88+pfP+rhs6lxg=;
        b=O9YMh2g65zvF2Nbq5OybefXtY7AVHI9fZZHMX3Kjxij6Ze/9PBnazCyXCe/Aos0PSn
         zSYflLBuJT7Ca2WLdZQyw26VRLL3/L/E2BT9G+cpOWOLdnQmICWpWqVz40kAn4MqFbGM
         Mn892O3EDO/O/GQWEZotypihcGs3j1evYyBXkhE4Ikcm4ka4wW8nZLHYc63KYN4Xt71G
         Y9ZNneyDSrQtKbPXkSxQUP4OiakgegFMwE8MKjZNgfb1jkQ7EeOIJOePtpbXKsYcBcwd
         tnMD6VBelYGv3znyC8LX0YmZDvMG7EmJ7fgyjacd8Fc94jnman4k7LF1NNoQAceEz+N/
         F8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jaXIxM0AplhJfDw6T3yPDNUxipBix88+pfP+rhs6lxg=;
        b=RrPdPHNlzBnT1ke3smSIas9yxMQ7VXcKUg/2h+yyjktHPyxyNxUD1+S2gJbNyPpW+N
         c+NQU4r6zQLoz4jwurHKjHK1PmzIDxaUWvhTi2evXaDvbrg+eEx7ZNAQUDJL5M85ZA0o
         Qdw1G3UfOu+30H2ysArMxHn7gck+NVw2CrT+nIEm8+A0F5oNELf9gqCazcyLh3i7Xt3v
         fAQ+5fLXcCAEUlylqfgbHgRPpY8KOIBWaZP5ud0EUwNXWATV/5FNLuntAsYDb1KDC7LX
         HNRvdBt3IKoAqBTrErKHwNehhqqqUIDmSdK+ZlONRwhqbLzPYVExg1qa1U2Z95+qYTRC
         qqTQ==
X-Gm-Message-State: AOUpUlGJ9OgSFbhHA7FDhRWxC5wTDo6cOvcYahRhaEC4RLSXJEwOGmJH
        0CK5TUwoHyWNsSZop25b6+s=
X-Google-Smtp-Source: AAOMgpeLqcGMuHMiyzDboYxLkP4uBww7acS3QePS+nxDINI7KAk4/mo+nFs5MW9wgVQa+m6E6X71PQ==
X-Received: by 2002:a19:6308:: with SMTP id x8-v6mr10059379lfb.104.1532936436277;
        Mon, 30 Jul 2018 00:40:36 -0700 (PDT)
Received: from [10.17.182.9] (ll-55.209.223.85.sovam.net.ua. [85.223.209.55])
        by smtp.gmail.com with ESMTPSA id t66-v6sm1934037lje.95.2018.07.30.00.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 00:40:35 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the xen-tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180730151213.4b1e1af4@canb.auug.org.au>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <06d1e71e-3f2d-9f97-3499-a448efa0321e@gmail.com>
Date:   Mon, 30 Jul 2018 10:40:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730151213.4b1e1af4@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 30 Jul 2018 15:08:21 +1000
> Subject: [PATCH] xen/gntdev: fix up for attach callback API change
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Thank you for your patch,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

