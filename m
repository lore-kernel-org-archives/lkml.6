Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1569C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3682148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iz6ssnvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3682148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHVEwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 00:52:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54295 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeHVEwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 00:52:19 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so944674itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 18:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbqvM1rQTDGUCBiCiAxkPEC/iCCYUfmbaHFcnH47tmQ=;
        b=Iz6ssnvXzCYyj9E4ZhP/+Lu+3sKkGd3aN2UqB56o0Jkeao1i7WJBM2wgkftpLnPTee
         nG1MdtAJFB42Ac0ALdtJrMA/JXQYQk2w8ONRHSu9TZ2bKWirlXiHILoLOG5DCMTV8BXd
         y7F+TVYC8ph1bEQXuyJh2KnpIlnC1UfOR4hdevW1gCtN/mYjSA3vtNIPyEUChkvtbRc2
         oNUivvU2Zf6cb7M/r5n24PVrF/8rrkD03QPpYKHerT6siB6XTLHkU/A/NGtc6i4wLy0o
         a98eGBYXD3ikLWY9z6MI9dWb4VqQdszFWAo73tw6hBZzuZpU9LaudhbA/BFVKLMiofYM
         nCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbqvM1rQTDGUCBiCiAxkPEC/iCCYUfmbaHFcnH47tmQ=;
        b=OKEYuty0eRRCOjM/7vAk46j/w1Twf0xcXadu9ak8RBL0JVgsllgT4+mjlVplCgbCCl
         gL8+FaYQC0ugf/3IC6eouwphgIFOLKNeuXsEPNp51prqXWNVwpVctz480/obM6dAWSSB
         UK9vrKausl6kwtBvdNveXgmgGAxN9T0TpE+xzDDYlVGmJqeMX1H4bHFBdHBwC64jcYpb
         oiobyacLOw3kTiVQz51WUXNFi16SoVfKtnvQ00C/a0UwAam+LCSmu8HBJEfs6zsn4dsL
         hyvz4RaJRWGbeKYNIFHqkrm68fhk2bOgjbK9WF08XJHmvXPe4kjJ7ptqO6b/gUmnmPJK
         DJHg==
X-Gm-Message-State: AOUpUlHmPfYNNDDg9ffpV1LVI/beJTT96TpfS55PxSIM2Ceme4VijV2a
        I6+JcE9N4XyePcvRwdb2dvk/toLbRiX5R7xOtXrXdQ==
X-Google-Smtp-Source: AA+uWPz9PmidAJRbHdHJ0lea8ceAL9PGi2GfxK9AFSnjkY9jAmhCdQXGGrOxDP4ly+wiirr1SVx6nMUeXOT6Fa5uTsE=
X-Received: by 2002:a02:1103:: with SMTP id 3-v6mr44771531jaf.144.1534901385743;
 Tue, 21 Aug 2018 18:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180816015724.GB2793@jagdpanzerIV> <20180815203226.2c7e48b2f9395d2772ecfcb2@linux-foundation.org>
 <20180816014835.GA2793@jagdpanzerIV> <20180814164523.e0fdeed962917e23062ef958@linux-foundation.org>
 <20180821160307.GA63897@google.com> <20180822004504.GB2218@jagdpanzerIV>
In-Reply-To: <20180822004504.GB2218@jagdpanzerIV>
From:   Peter Kalauskas <peskal@google.com>
Date:   Tue, 21 Aug 2018 18:29:34 -0700
Message-ID: <CAOxpCJ-oyDf6DYf0m8Zmiau1aDSJZVegi+3caztBWBabai8eJQ@mail.gmail.com>
Subject: Re: [PATCH] zram: fix bug storing backing_dev
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 5:45 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> Hi,
>
> Did you intend to remove lkml mailing list from Cc?
>

No, that was an accident. I resent it so it's on the record.

I will submit a v2 patch with an updated commit message then.
