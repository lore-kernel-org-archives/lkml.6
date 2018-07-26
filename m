Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D21BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1C52083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgBxSAPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1C52083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbeGZPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:34:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44743 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbeGZPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:34:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so630837pff.11;
        Thu, 26 Jul 2018 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=QIv84B36GI+yM/RQrR2EPODN/OBpNxf8uZJNLY+OWEM=;
        b=PgBxSAPN0cFe1nTzDqs4JCu7dcmuAwp/Fbq8rb/CAMiQYR6EyN/oqpO03Og83U47Ze
         RGKX+QjyQSPVkwJwanLlxrynHD2zcqNqUhq8JFdc4AlTJLFdiGcHrCMHjv6638JjPYWi
         BP7vK57V2nJ+jcippgrQg8sT/n+Yehvx4rYS44HfpXvFB4Dfs3koO8E/K66KrlCBTZEj
         J8Y9MNIyH69u9WKllpFcabGt6jXs3gEd9BtYdcmsfydSZW6rGG4QSK8WjRfdjQm4jg1Q
         hzdnljQ7iRUzynIbaP1GGjxlwhB2QOIKQXrEosUoM0Ok9yFFtCcAg/eFw+rpTrJjY3U/
         fqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=QIv84B36GI+yM/RQrR2EPODN/OBpNxf8uZJNLY+OWEM=;
        b=ofqu4exqi31u+bZV3a7o4pzwcQO+BbRQZPiDnUYFfoEbx3mGYFr9vcOsc/YABlJjPV
         xfiT1eTeDD+VisZZtuBwTVw6yrR0yCbtaqQbtlH3Cp2Cbz1Zbk8G+cbPcv7MTwL+bPRP
         /AkDK+s2wnIFg5gs4aVQ6LXxxi3VT+kRx7uVRVLO+TxiSwIjBwKXHi8k3yxYzILvCVkv
         +cjTeP8n+D6fl0zwXyWdUaro7T45KhJqMTncYBSqJK+VV2Tr8BeGFw4h8kPPe1DN/ldz
         MYbJPeAFlQvEXtzAGC5GyaZY1m3zFbgwnTYNyD74zXuFgbvYZuvwDdyX9OJUz4l7OeN0
         RaAw==
X-Gm-Message-State: AOUpUlGJPU4ujZCDUszP91hI2SAXjZx9o4D0A/Cb76hvOAIdeeRPaVy4
        ++5YyHh482R1ooS8WIhyRMX+VwlW
X-Google-Smtp-Source: AAOMgpdMG4pjdQ9R93g6qhQgTprpIYlQ9m5JZe/aeG0cHRrKce4ULV6d+SVYD4VXaXs0QeSYobnEOw==
X-Received: by 2002:a63:2ec3:: with SMTP id u186-v6mr2114233pgu.225.1532614666803;
        Thu, 26 Jul 2018 07:17:46 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:4414:6c14:7712:e625:1be4? ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id m20-v6sm3084483pfg.61.2018.07.26.07.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 07:17:46 -0700 (PDT)
From:   bai <baijiaju1990@gmail.com>
Subject: [BUG] video: fbdev: broadsheetfb: Possible null function pointers
To:     b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <cb43741a-83af-0b55-f53b-489bf7cb8b61@gmail.com>
Date:   Thu, 26 Jul 2018 22:17:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Linux-4.16, drivers/video/fbdev/broadsheetfb.c,

158. static void broadsheet_mmio_send_cmdargs(...) {
             ......
163.     par->board->mmio_write(...);
             ......
166.     par->board->mmio_write(...);
167. }

For x86 kernel configuration, I find that there is no assignment of the 
function pointer ".mmio_write" in the kernel code.
So calling the function pointer in lines 163 and 166 may cause a null 
pointer dereference.

In this file, there are many calls to this function pointer...


Best wishes,
Jia-Ju Bai
