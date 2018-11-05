Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADE9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4621D20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8MLgKNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4621D20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeKESLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:11:31 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36318 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKESLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:11:31 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so13336850qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 00:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8JMYtjfNYxLfbYDC9OvzWnhNZN5UoKOiwiG13yTWbTE=;
        b=D8MLgKNLezWGWd7LOpCrLZDP5Nr+JaEOE7X6Xqbg2a/Eyh46nZ1ApM2bDPcFC3jwKr
         XPt7RrF8cp36pkH/mtNlUvElB/ak5HyiC9RQm6aZ9mkll9yyotYT1K/xQ9+lvfPFEWSX
         9a+4CRE9k+tOnrLIPPZhBtdpWh3dithgTisXhwlwjd9GiI7aPvroqnx2lQTvcN9Ck3JP
         KqONQ/EGDrV0nCtKR6Z7miCULypvSDozUxVGqtTddwe2ORpuLbJUqu7Maanuz7OAGPhi
         kx7l7AmiCNXpCY1bMZHhns8Ri45Yeu2OZuLBQ/p4UNTmJphtKahAtJX4/1g74VHtel7x
         X7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8JMYtjfNYxLfbYDC9OvzWnhNZN5UoKOiwiG13yTWbTE=;
        b=TWufWhcpdG7gxPuTW1TiGypGAFkjZoaSDRAnoY5aENxUP2GEMqX9sps6vOzfyv8Dlm
         G+2joPtHlrHzn8BrOg3kKl2RjM+P9d/ZY/2PPXaID7Fr0sIPupWkR5gt1cPhmvxXY4HE
         X2U4Lr+U4gjiFyZPvgqKQnMgLkQtkKvRg5sdFNK3JBmO/sR9jrgDfohUU2H94uKymNDc
         35Ap2W84a/NZNq87l5YJnBqwt0cNNuFqAcXMJH3rgiowUXK9Us/iS+Kp8FnrkiXB7ED0
         YjgqUC1vwNhyt+IJ5fhuQItqppjmUWpckEP9S0U9IM702k1opmPYniLYRmveeGHyQWyg
         RSJA==
X-Gm-Message-State: AGRZ1gLqH0oBBAZv9tHqiHfORNuGVCMkwUIEDnVh5tpCKg0TmkJKewhF
        QBvASzXlIi36MRnGg4vowLQ67B0eGzLAQLNIdHo=
X-Google-Smtp-Source: AJdET5dLcTAkwp9cARYapZYvWFyATrmLu/B6uVtF7HO3WXgZlcFDLisAuDY3POGB3YUMnu9iMatiKZiE/Va4je2jxWQ=
X-Received: by 2002:a37:a3c6:: with SMTP id m189mr19797249qke.173.1541407973298;
 Mon, 05 Nov 2018 00:52:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 00:52:52 -0800 (PST)
In-Reply-To: <20181105070551.GA7274@infradead.org>
References: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
 <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
 <20181101174857.du2zu4vnrhpu5asf@excalibur.cnev.de> <20181105065807.GA1286@andestech.com>
 <20181105070551.GA7274@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Nov 2018 09:52:52 +0100
X-Google-Sender-Auth: o-kIcVGL0PLGM20_dbB_NR5HFxM
Message-ID: <CAK8P3a2c98VVPArCkdAR=-nnDBq1gYRCLDDgQB71eGiTSRdb4A@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vincent Chen <vincentc@andestech.com>, aou@eecs.berkeley.edu,
        alankao@andestech.com, greentime@andestech.com, palmer@sifive.com,
        linux-kernel@vger.kernel.org, zong@andestech.com,
        kito@andestech.com, linux-riscv@lists.infradead.org,
        deanbo422@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Nov 05, 2018 at 02:58:07PM +0800, Vincent Chen wrote:
>> Many thanks for kinds of comments. I quickly synthesize the comments and
>> list them as below.
>> 1. The kernel image shall include all vendor-specific code.
>
> I fundamentally disagree with this=E2=80=A6 and think it should be the co=
ntrary.
>
> 1. The kernel shall support no vendor specific instructions whatsoever,
> period.

I think what was meant above is

1. If a vendor extension requires kernel support, that support
must be able to be built into a kernel image without breaking support
for CPUs that do not have that extension, to allow building a single
kernel image that works on all CPUs.

       Arnd
