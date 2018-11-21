Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1BAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DD4214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6sDTIAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DD4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbeKVFTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:19:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45188 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbeKVFTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:19:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so6704131plm.12;
        Wed, 21 Nov 2018 10:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ngUlne4OB6sriFMy4tl23qmWkINjAs380FKgCzKCdW8=;
        b=W6sDTIAz84nhbpN0yXIYq7kDSmKAV+ZHWOacc3oTnRRMCtPBC/f7hEFFpxe+6izknx
         KNiN8zBKQ0s0l5IMWK5eRGVofj0tpzGKRt3ShckcrRRNdvH8wozaOwMuxECgrOvKP7Qc
         nbBJcxO81SaxN/swqCCokP2AmMxg4VtKZvL2hEQenGr1r6BwEhrdwP54EEC/L3KenOlG
         wN+j9r3dpUxQs4boSJcT2dHgdijHdkI1UdPz2KZMjsaTP7Kb7ypx7h5sUOIYMslbRJvz
         KOEycXzJgIT/Y9mJ/5u2RQ2wAjMcYT1axfsEZQQFPCjlU8CXA7681eaCUu7hVHlhOy0Q
         3oUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ngUlne4OB6sriFMy4tl23qmWkINjAs380FKgCzKCdW8=;
        b=Z2xhgXnsmhAf3YoHuiaUXN6uxPeZUnWfR3QjRGrbLKitiGcRkTc8HmmYjcnOLqkAC1
         mmZL+mpnO+iI6cry9hWElMkWoxDuBV1Tq0pzljYiT8QobY6siqiQlUMJRCZc6JBH3yFj
         l2fMvQr44lHtc3ikoDDW3YvZGc0UfpY7P0pSob+re+OeWbykDQX4VTT1QiThl1kAsdq4
         mn85M4aEnh3icMfCR/o5xZUmmM/adeiu4BNiP1Atd5tNvd8htbtbM4JhuJqAr4zJT+J6
         InXTOM8vVRJd5XVj8cP/Sn0MhbpVWcheI1St90RtuOPF0mTTi9gqkfbB+GMdBgkMngVz
         /Z6g==
X-Gm-Message-State: AA+aEWYifG7PG0Qi+uWepjl3PYZgnSALC/uw7gJJZwqDyfsCZulxMUwZ
        EAkyhQW1spI/RCm53H4ERBE=
X-Google-Smtp-Source: AFSGD/XVmRw8WVUR+PHeVCXKXdWISahtsANj+tLuzWGw8sJmwiVPCFF9TZs3wUuZ0LlEL46reS3wig==
X-Received: by 2002:a63:6dc8:: with SMTP id i191mr6754140pgc.215.1542825846858;
        Wed, 21 Nov 2018 10:44:06 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g190sm48155060pgc.28.2018.11.21.10.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 10:44:05 -0800 (PST)
Date:   Wed, 21 Nov 2018 10:44:03 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Harry Cutts <hcutts@chromium.org>
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HID: revert the Logitech High Resolution wheel
 support
Message-ID: <20181121184403.GA72827@dtor-ws>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
 <CA+jURctziob_scb36s-JxvD-FFrH1xn4Npd_i56g3DxxVEpZ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+jURctziob_scb36s-JxvD-FFrH1xn4Npd_i56g3DxxVEpZ4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:37:13AM -0800, Harry Cutts wrote:
> On Wed, 21 Nov 2018 at 07:27, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > The TL;DR, we need to revert the current series before it gets out in
> > a released kernel and work on a better approach for 4.21.
> >
> > This patch series has informally been acked by Dmitry, Harry, Jiri, Nestor
> > and Peter, but I wouldn't mind a public ack before I push this to
> > the for-linus branch.
> 
> Thanks Benjamin!
> 
> For the series:
> Acked-by: Harry Cutts <hcutts@chromium.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks!

-- 
Dmitry
