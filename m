Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E88ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E0B20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RktRJ3sP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E0B20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbeIRKTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 06:19:31 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36031 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeIRKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 06:19:31 -0400
Received: by mail-ua1-f65.google.com with SMTP id c12-v6so293810uan.3;
        Mon, 17 Sep 2018 21:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCeqD8XWE5WL7/cdB42pK0alXNOOYrm6UVG1LOA50aw=;
        b=RktRJ3sPDy4HFnxuSVgDYl979iuiGn3onhyEKtloddCXXalK4jJ3q3imooMI9Ajb01
         Wt+nHubPflkx7GhYX5a8jkL8U8aykLMVbxBqezSCjcY3eesP+ZhJE5puNgYI399na+WW
         drXFathKvbEfhpJpVmrBI6i4Nncf8c2WYJXIvcgukk9YuceuDHFrwNeSXxK+r0Ou7GVj
         xM2juycp68yEnUrw43d4WfNXVkS8gDlJxYsHSJRYCp0QzXM7nczIGtrFyEo5DGjD36Mm
         pSYw/N3e/HlPTa2gepjqVWSExUO7BfZHMHrVxxpuwJNGcmbXBcMza3CQeaayTht2MeJV
         dpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCeqD8XWE5WL7/cdB42pK0alXNOOYrm6UVG1LOA50aw=;
        b=eN5hv3h582Mxd0XR+w3DjzuKoj7bBjVbTkYmAINwW14SMBFHsbjnrGToXPFpXcfi/E
         7NntO1mi2i/wQz99jksly5zJRastCigyP08S5mJS+B3G1O/qgRhHVCDCeU+eMUQqaKZf
         c5FykecVlR/+BjA5tyagbfmaanJm9MD3x2mSzl0bNY3jpjbBtnLamBWdobT4bsqP2g8P
         Fxib1ABRHKNVktAsk0fLCURPrh++RWgNaol3MTFG1OeiAToIFgYG9dMFF9cO6ynTKTRC
         MuxmMs+4LMJKpZyXDNWTeXXzvDF6/05fonh9cAYJ77WId5H3fjDb4qSSs+juJr2YEXDT
         mEkA==
X-Gm-Message-State: APzg51BNTJ4dpcMr0jW5qh/fdEIR79l2vx94xvDy8YuLBeniWdx3Sz7M
        alFWLO177zQmdiOK+nAU7e04fX4zYOuwZxBGVpY=
X-Google-Smtp-Source: ANB0VdbGezHs0sLTJjyoD+398KHM/C1rdYDoI8YR6wl1ZV1eZ+C8XCcpfXoHWFSo9Nkw8To7YKnnd1MaQgWcqhrDMh0=
X-Received: by 2002:ab0:7558:: with SMTP id k24-v6mr7481505uaq.170.1537246123857;
 Mon, 17 Sep 2018 21:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180918014534.26128-1-yuehaibing@huawei.com>
In-Reply-To: <20180918014534.26128-1-yuehaibing@huawei.com>
From:   Y Song <ys114321@gmail.com>
Date:   Mon, 17 Sep 2018 21:48:06 -0700
Message-ID: <CAH3MdRWv7AV3xDHpCLwiFV6hvDGedtUUODmpjju68aMqVkMA8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples/bpf: remove duplicated includes
To:     yuehaibing@huawei.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 6:46 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated includes.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
