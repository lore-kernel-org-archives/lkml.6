Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E89EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3842A208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cb4vgNW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3842A208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeHIKyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:54:09 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:45731 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeHIKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:54:09 -0400
Received: by mail-oi0-f49.google.com with SMTP id q11-v6so8411202oic.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/sl4SLdRyWoDU6c666JvurRqjZDVtvsMZJ1+tRfGL+o=;
        b=cb4vgNW1XVmYzTYUq2e425AWNEpGTOZV9/QhNUw4te9u9ycYaHTBvQJz2ZfIvKHrzE
         DGZ5Zi734cWrbUZqTsWf+FvpPOeqRd8WBql2vRYODTgIPLlBIXUzyNLzQCesdwIMm3MT
         PQNSdnlRTLnFZvEbG5phtmFxW4JQx93+zMFcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/sl4SLdRyWoDU6c666JvurRqjZDVtvsMZJ1+tRfGL+o=;
        b=Ts8jW1pAgs5CDfoGue49YSKpgT/NQmq1NIbVHgGTj52xnRN1a5JOEkAWp3Q8b6C5ie
         6ShjB+m6kC+32dL0hvf9znua1zppPAQmtvJUq6+upfZ8R8gl4MnHbg/6vFao8lCc+q7v
         5PlyG7SwbGYTHTVBleure6yRsjDKIvn/cJCq7zZ2riAANLOws/9ZSiG7dacu5jG0N+KV
         g0eIPfKIxXNchzh/xrVYnSPPWzaYnzV8qS+GQ1jQxqDI80TM/tQzLp3mvAWj1CFzoag3
         s2AJ5Cjx4sXvwP7CkdChBiIclu8JSu17X5NPtzY6vbn8/7evW6kmg1Q3geBs/83HkmYJ
         9aqQ==
X-Gm-Message-State: AOUpUlF0+Ve8sz3atS8SZTGR7B0zOISwSb8u6fjBpH67KctyLMlh9aPl
        ZiZq0VLdzWYY18LjrcfvtSPPj/+Rzg2XH4BHF6wEQO84D/4=
X-Google-Smtp-Source: AA+uWPzmyGJaUSGM3NGDWg9lzHFPt+wEGZlY1HTN4HD0oaxmRd1+zE4k+kOnLV0wUHkyoK0Pea81dy6NYFNG1DnDMQQ=
X-Received: by 2002:aca:e350:: with SMTP id a77-v6mr1273877oih.250.1533803423477;
 Thu, 09 Aug 2018 01:30:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 01:30:22 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <EA52CBCF76D5E04D95BED55B83577BE7A67744@MBX50.360buyAD.local>
References: <EA52CBCF76D5E04D95BED55B83577BE7A67744@MBX50.360buyAD.local>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 9 Aug 2018 10:30:22 +0200
Message-ID: <CAJfpegscozvNV3R4h1NZCGLq_Te8AHXEAxymRJNj96OkmPFFJw@mail.gmail.com>
Subject: Re: FUSE: write operations trigger balance_dirty_pages when using
 writeback cache
To:     =?UTF-8?B?5YiY56GV54S2?= <liushuoran@jd.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 9:31 AM, =E5=88=98=E7=A1=95=E7=84=B6 <liushuoran@jd.=
com> wrote:
> Thank you for the prompt reply.
>
> I tried this config, but still can get balance_dirty_pages triggered.

I think it may be due to BDI_CAP_STRICTLIMIT used by fuse.  If you
remove that setting from fuse in the kernel you should not be getting
the balance_dirty_pages() as often.

Not sure if that's the realproblem, though, that depends on how much
time is spent in balance_dirty_pages().  You can try profiling the
kernel to find that out.

My guess is that the real cause of the slowdown is some other place.
There's for example a known issue with selinux related getxattr
thrashing.  Disabling getxattr on your filesystem may significantly
improve performance.

Thanks,
Miklos
