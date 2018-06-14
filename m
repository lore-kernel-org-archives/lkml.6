Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0E1E1C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AD7208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7hu8+G2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AD7208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754896AbeFNKHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:07:24 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38820 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754709AbeFNKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:07:22 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so8512880lfh.5;
        Thu, 14 Jun 2018 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lah5Gb3LjbyT/v0bjCif2j1q5nF8aHLOdsVULUBXikA=;
        b=h7hu8+G2AWLVDBEteXIZx8fFPuIkgnKUTWbTmbOs+H+QTmIWK/qqzkG6w+kGzi4Ams
         ebPCyFF/GXV6uLDu+d2L7sVJ6qfEef6Tyfdoa78idXYwxrf4NU6X8wDTIteAJhUOCIfD
         oZQlzfCw1RFMe2+lo+T+kSeEM9DLe0gfBd6/AxeHPhaCWyZUoEoA2YSll5s+QTzLgVgp
         LIe4E7l88/H2+uqQdpo26I8WleNACbQQrsHZRB8YAGaAKl9QhUsYluneFbZnmGWgYNzH
         cbkdmodQBumlVfWFlU4TW1lTVDlk+SONfQuZNxJVqzBxx6idfiesELh1z6Efh9MThhi1
         Yk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lah5Gb3LjbyT/v0bjCif2j1q5nF8aHLOdsVULUBXikA=;
        b=dKHp8JD1H6EpeeBWRjS9mSBmsZG5qjcXovQKITjTAHSoVO5HYB27+kyarE7dKUzcml
         qaf8CR3DRA/XvuCaFXtIadal5HDL4+vIL8dObluYSNyX/xEhww4e8YkEeFSyA7lFlZCe
         4mRvnmhn9Y6wjYWvbjVsJqpahs/2LV+7iqcA79UbOB5Pc6MEBQ03qlULNHja6Io7XYSI
         11Em5g+ye3Ri9MaIYeYcD+gR3PDOJuLc6J/KebKJd4EBoDGnf8AC374+GG0xtbX/vpep
         1Yyc2XXUqDqiYUXK81k40MxHpA3ag9L7fskEu4VuSlWasZrsusv+CA2nuOaYsV0h5jlK
         NoVg==
X-Gm-Message-State: APt69E3gxDVxhGi+RSmfNfRh2zIaGPww9Dp3ddnJiHVXiUtV2B1/rrnN
        sjqpnsPjFwukVZO6+gC3g7OYazd5HiC9XBBAoBOR0tO4
X-Google-Smtp-Source: ADUXVKIJ8qWAVRB5bQ5MRhz+OZpP9pxupJT/g9aAwOUMkkHaWkTEC9dplmKc7KfSHYQk1OUPdHHUi2v3P+isLS/nnOc=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr5828419lfc.55.1528970840104;
 Thu, 14 Jun 2018 03:07:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:07:19
 -0700 (PDT)
In-Reply-To: <20180612054034.4969-5-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com> <20180612054034.4969-5-songjun.wu@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jun 2018 12:07:19 +0200
X-Google-Sender-Auth: _wKB8UeZIwZ5de5NPaloC9YPF9U
Message-ID: <CAK8P3a0K6qezHLcjkeq0zd+iQJQc_qbT2JhtZGrCNRT495sUvQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Previous implementation uses platform-dependent functions
> ltq_w32()/ltq_r32() to access registers. Those functions are not
> available for other SoC which uses the same IP.
> Change to OS provided readl()/writel() and readb()/writeb(), so
> that different SoCs can use the same driver.
>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>

Are there any big-endian machines using this driver? The original definition
of ltq_r32() uses non-byteswapping __raw_readl() etc, which suggests
that the registers might be wired up in a way that matches the CPU
endianess (this is usally a bad idea in hardware design, but nothing
we can influence in the OS).

When you change it to readl(), that will breaks all machines that rely
on the old behavior on big-endian kernels.

      Arnd
