Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616CA20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616CA20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbeGWRqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:46:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43260 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388574AbeGWRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:46:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id m12-v6so937268lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 09:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=geLEKATQKwPDoEH4wArb60fD152g1b62tODtYSwLx90=;
        b=uPu782t5AjfFHuDbahYKmIiV1SGlxTfel2awSVIgAoiWKRSZOW3f1KRIizxWhV4TOH
         7U4Pt6fCr0wE/XmKdrshV5qZeK/ev8fuzTWEx0rhsNNhgnB0e2X5PWwVpeQe32vAbTth
         zj5XSQE7sw2f2sclY4qMQgmHKENtafPMNSyzGuJAyhfwzjt0UCvAUoUVrD8UnpTmU0kn
         NtnY0dtbjCY2sm2PuEVSaCSn6jyRpCLQAO904a4eoJkKhRKZLagNnfTYoT75wEGMMWyd
         7nTsaEn+upm33MFQPlpkIjsKijCpnq/xy5WKjto5rsHwzn8BcQUbUC4jDQEGvysXoC6D
         QqjQ==
X-Gm-Message-State: AOUpUlHJAB8sJ00AZzVt8pKcv3mA+NQFTv5kAyeeeFrqW9g7LT+9HSlx
        LPjaP59pG4fwpLUaHsTN4KX95wWPTt525Y9MUAQ5mGD3
X-Google-Smtp-Source: AAOMgpd6f4NLXP4A0t9J6LD4U1/8wy4v7adZA6b/qDLN/RZCg6v82ewUqgUrUusjD8SKw/1PA09/d7miqqEFOa1kqQQ=
X-Received: by 2002:a19:f22:: with SMTP id e34-v6mr7600615lfi.1.1532364284505;
 Mon, 23 Jul 2018 09:44:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:4e8a:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 09:44:03
 -0700 (PDT)
In-Reply-To: <20180723092539.177749b8@lwn.net>
References: <20180713172806.17387-1-pdhamdhe@redhat.com> <20180723092539.177749b8@lwn.net>
From:   Prashant Dhamdhere <pdhamdhe@redhat.com>
Date:   Mon, 23 Jul 2018 22:14:03 +0530
Message-ID: <CAF1GLk==0cuBE_CGk_o_--2srJWA4k7BZ+yX7UCSdp3HYmmokA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: proc.txt: Adding 'HardwareCorrupted'
 field and description.
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 8:55 PM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 13 Jul 2018 22:58:06 +0530
> Prashant Dhamdhere <pdhamdhe@redhat.com> wrote:
>
>> This patch talks about the 'HardwareCorrupted' field currently missing from
>> the 'meminfo' section of 'proc.txt' file. It also includes short description
>> of 'HardwareCorrupted' field.
>
> I've gone ahead and applied this.  Please note, though, that the "this
> patch..." style of changelogging strongly irritates some developers;
> please use an imperative style in the future.  I rewrote the changelog to:
>
>         Documentation: proc.txt: Adding 'HardwareCorrupted' field and
>         description.
>
>         Fill in missing documentation for the HardwareCorrupted field in
>         proc.txt.
>
> Thanks,
>
> jon


Sure. Thank you for correcting it.

--
Prashant
