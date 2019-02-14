Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E71C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D858222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjigDruB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbfBNRU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:20:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34032 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfBNRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:20:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id u21so5143472lfu.1;
        Thu, 14 Feb 2019 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IJEyexNwgLB+lQdCMLxMVur31Tw2nw21FQRm0j40h+c=;
        b=PjigDruBpNjrBeWs2K20MYsxDjFsuZ/an6XxAaybCQ+1HzGuWBAQGD+zabU05pLCIx
         +kC4J4QC/niniToLYXxsW9upm0XLnXsRj1JlbnNyfMb6GTyLuNcM5NQK5gO/YCJDb8fq
         cUSUA91CGEcimoVhJOiFIn9nOk7tu+Ebceyhl5L0Wy+Kc5tbJWEzc9w29wcGg74GQJrT
         dZHsLKbGGuiYlhuJ+0ybf0enBqEsR4eaNjZJ3nnSsgwhBsIMdEInMR2WNp0y7sQwsiLI
         XwjSFRi2mzZLYuU76w9De3rRYWtHu5yD33EH62N9QYjQhRi9sM42PS2p0Ci4i9GspUQK
         9bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IJEyexNwgLB+lQdCMLxMVur31Tw2nw21FQRm0j40h+c=;
        b=mnetODRJfFDKhhGbdzOwbGkBfKTF3josEp0yL5qfFf5Trs0oWWCWKz3Yg3qfmOOzFi
         vectwok2pgkpW2uWa6kG2vKLo9P2Y3iukfWqjzO0dgpeVedXlKa4uKnPxkueQdIuN2IT
         3qnl/ywrrl4NJNNdBxs5YOcUR6aUQlt3LeCnmq2pKDy/EV2AJ25igHDAuj8aWcGcaRRs
         uG4X1WyZRBjvtyPBTSLNxm96U1PupvrJp2JsFGaZO2cA7Was79OU3KVLDvHayVcSbKCD
         P3zvv83NQ0alWWrpWK7kaXT2efxnBSo2BeevKS06wxjH2CYiScu1bppjFdFA8OIVoaDS
         G1KA==
X-Gm-Message-State: AHQUAubB4QtU5HwewVsE7I5yMexZ/e6T3UJl6fQgMTVcAwWMAaqk7THc
        monkMR9gu4u/OfTGLhxAZvA=
X-Google-Smtp-Source: AHgI3IZDXYkapPzfwXzjwQ3xjyF+Ky4cLZMrQuVzu3uASeuQKNVLnXPfSNrG4+abj+DCM4Ym/ylJaw==
X-Received: by 2002:a19:7613:: with SMTP id c19mr2960104lff.103.1550164826109;
        Thu, 14 Feb 2019 09:20:26 -0800 (PST)
Received: from im-mac (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id v65sm546342lje.77.2019.02.14.09.20.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Feb 2019 09:20:25 -0800 (PST)
Message-ID: <73a47433515f092b3045f4462197b6b1726e9b27.camel@gmail.com>
Subject: Re: [RFC PATCH 0/2] Fix for the internal card reader and suspend on
 MacBooks
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Martin Liu <liumartin@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Harry Pan <harry.pan@intel.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Samuel Sadok <samuel.sadok@bluewin.ch>
Date:   Thu, 14 Feb 2019 22:20:22 +0500
In-Reply-To: <b85e3801-aff5-89fb-d33a-88568821d4c0@linux.intel.com>
References: <20190213211323.6072-1-mironov.ivan@gmail.com>
         <b85e3801-aff5-89fb-d33a-88568821d4c0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 17:03 +0200, Mathias Nyman wrote:
> This card reader prevents second system suspend on latest kernels, see thread:
> https://marc.info/?l=linux-usb&m=154816680816246&w=2
> 
> In that case the card reader fails to resume from usb3 U3 suspend state,
> and ends up stuck in USB3 polling state, which now prevents suspend
> 
> Could you try a testpatch (attached) to see if it helps?
> 
> Thanks
> -Mathias

Hi Mathias,

thanks for your patch. I applied it on top of current master (5.0.0-
rc6+ 1f947a7a011fcceb14cb912f5481a53b18f1879a) and tested it.
Unfortunately, without success.

Card reader disappeared after the first suspend/resume cycle. Second
suspend failed.

Complete dmesg is here: https://raw.githubusercontent.com/im-0/investigate-card-reader-suspend-problem-on-mbp11.4/master/test-18/dmesg

