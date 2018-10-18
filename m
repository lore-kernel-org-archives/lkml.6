Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296CFECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E198520866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FLg4dDnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E198520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeJRWd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:33:26 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56220 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbeJRWdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:33:25 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so556546itd.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VoJhrDFFSdNFykxnSQmukvxeeAbXQKHlcNCkqmZPgeM=;
        b=FLg4dDnz6mvJX3qG5D9hgKmeA9hBI5erpQKQaXG3Z9b5nNqKGEJdlsW1xxUezlnGq/
         MOOPmw4AJYrJx3J4D50mTR+ysxfdgCWJnSZ4mju6zN9bIHn4tLk4jvVnuzlCAFlWbCpa
         PK5WmL+z1Q3uXJrNCZcXbFciNac1EWzQv+OvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VoJhrDFFSdNFykxnSQmukvxeeAbXQKHlcNCkqmZPgeM=;
        b=Fv1aDw7pgDBIOHtGfbpjOTejPHQdNjWNNkgQ8gurlQJ4g65ziImXr+WKlWQtaK6QFT
         MA9eynw8Lqo+GbzS3au7nxYWKTlID3S/KQW+L+9CWszsCrLdjsWODq1FydHHkH1iNXAC
         OMoXz0FI4V3kU2tmb0BwZJcLu7D3DhHYfKz9ZcuAmTzLxENolLqjRWtEwwvKS7Rl0piP
         PRYGGDJomf90iyrQitYtEWPKD7BTzKtqDbu3SdJIID76a0t8dvfx00zGw95wVWKLysfV
         YXmyXQcRbfTD6+fJPQOPmb0opkA6aD72t6nCvD+yu4pCHGgCd3DnLitfh9a8zfPk//gy
         JBAA==
X-Gm-Message-State: ABuFfogcTcuvf4lZrxMtdNO5w/03jgq1dIBUmXP9EiUe5uQcU+l6dxhD
        hRwazjgZ9EdeVoSdPPjAGvcChNZ6wys5OE2lSbgEhw==
X-Google-Smtp-Source: ACcGV63suUTKtfYB/6jxOKLsZbr5MaunjApCbm72llF973VFDMjh6FuX2q4pWYDL9qwInixgpK+xN/XA1OE55EHus+s=
X-Received: by 2002:a02:982:: with SMTP id 2-v6mr21826393jam.78.1539873128869;
 Thu, 18 Oct 2018 07:32:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 07:32:08
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <875zxzxuo9.fsf@mid.deneb.enyo.de>
References: <20181018131125.6303-1-mszeredi@redhat.com> <20181018131125.6303-2-mszeredi@redhat.com>
 <875zxzxuo9.fsf@mid.deneb.enyo.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 18 Oct 2018 16:32:08 +0200
Message-ID: <CAJfpeguM-TU=nxj=T4t1DshniiEFBGq6yo+qo7Cx1QDnoNocMw@mail.gmail.com>
Subject: Re: [PATCH 2/3] uapi: get rid of STATX_ALL
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:15 PM, Florian Weimer <fw@deneb.enyo.de> wrote:
> * Miklos Szeredi:
>
>>  #define STATX__RESERVED              0x80000000U     /* Reserved for future struct statx expansion */
>
> What about this?  Isn't it similar to STATX_ALL in the sense that we
> don't know yet what it will mean?

Kernel will return -EINVAL if request_mask contains STATX__RESERVED,
so it's definitely different from other flag values.

Specifying this in the UAPI sort of implies that other flag values
will *not* need a struct statx expansion, so it's safe to pass in any
random value not containing STATX__RESERVED on any past or future
kernel and it will not write beyond the current struct statx boundary.
Not sure if that's a useful thing or not, but it's not actively
harmful, like the STATX_ALL flag.

Thanks,
Miklos
