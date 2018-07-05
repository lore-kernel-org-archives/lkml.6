Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A023FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DE12411E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Shik1VAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DE12411E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeGEFsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:48:12 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:55808 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbeGEFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:48:10 -0400
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com [209.85.217.172]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w655m0nN024643;
        Thu, 5 Jul 2018 14:48:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w655m0nN024643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530769681;
        bh=d4rMbwA5+AfRd9DyPiTN2E7pB44leZf60CMrXtx6wDA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Shik1VAP+n2WxpHWBMdd8vxTCe6OskOqBDo4tHtSbaSVdmuAImw3JfKV7+DGvF25t
         8vOK6g0VDSDExGxwKIU+TWjL0r2N/BCsk2O4wpGFRUT7hockuB6o3lrD2AYmPIEkEL
         aff9wOBxXLoMOmHAWXSVU/OcNA9HAN+UB6zgBQI98xlGJl1wYuhWsvjitGUPFASFfD
         cV+BQp8g8xTLA6N9VGvZZSll4s5cHPItv6jgco2TVQAinoQwf0D4bdAQ21dPTaiBFa
         xFk7JyS8TDitPqnWZA/NfUuhOIjwEZjgGe+nwVDdF+My3m8oZf/5yajGxGujwDv8lF
         B6EgzP8tnYVOg==
X-Nifty-SrcIP: [209.85.217.172]
Received: by mail-ua0-f172.google.com with SMTP id v15-v6so4663695ual.11;
        Wed, 04 Jul 2018 22:48:01 -0700 (PDT)
X-Gm-Message-State: APt69E2DK0iPiN0c/3sOhd3f/oG96ZFPC749ECQltoIE+XmZ++P88/pr
        SgIdwJxoFbQ2al5HWJHvHBzERYb2jXy+arvSmXs=
X-Google-Smtp-Source: AAOMgpciqplD999RbO8Bmllac4dEQU9iJjigIFohmj5T4vTT9JMk9TQzcEjHPNCV4TPh088NyKSOqmbZyxoYy/GPnq0=
X-Received: by 2002:ab0:290:: with SMTP id 16-v6mr2531964uah.144.1530769680341;
 Wed, 04 Jul 2018 22:48:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 22:47:19 -0700 (PDT)
In-Reply-To: <20180702144711.22111-1-hch@lst.de>
References: <20180702144711.22111-1-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 5 Jul 2018 14:47:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS5md-Q3iyKNa4vraHWRa28E_RhuObJaxssBp2aWzrYDA@mail.gmail.com>
Message-ID: <CAK7LNAS5md-Q3iyKNa4vraHWRa28E_RhuObJaxssBp2aWzrYDA@mail.gmail.com>
Subject: Re: include architecture Kconfig files from top-level Kconfig
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-07-02 23:47 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> Hi Masahiro,
>
> what do you think about the series below, which moves the includes
> of all the architecture independ Kconfig files to the top-level
> Kconfig instead of duplicating the includes in all architectures?
>
> Note that this only handles the low-hanging fruite, there are a lot
> of other bits that should probably be cleaned up to be common,
> but those will be not entirely trivial.

Basically, I am positive about this work.

As you have already noticed,
the UML breakage should be fixed.

If the reported problems are stretched out,
I think this is a nice cleanup.

Thanks.


> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
