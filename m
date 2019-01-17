Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6432520859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="j3c6YOrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfAQXYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:24:38 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:41854 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQXYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:24:38 -0500
Received: by mail-qt1-f176.google.com with SMTP id l12so13317970qtf.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=yNimR4kGEBayGU7oXivveTqt8Zx3mvahFcSu8k2A83Y=;
        b=j3c6YOrjji4cQyCQAu6lVkPgUVp+jGuO5wtJXKClALL1eUBUgy6STd5CuIu8Q0gx+C
         rAYfURrFd4OZ5dYNysddFpaWhf7oPWRt3ddS8IJNpdFFdXz6+KrCLB1JPnwE7SDHHDlQ
         wS0+XqZSO9RctCHCbOrU4W7oQ9B8z6Wp5xtDIYsT3SA3ic/yYScUVHLOM9E+Ruc5+P0p
         lJByP72OeR8+uSBjON6hIanHTZaRu2o+HJdIeoEYcqhlLaAJA3e1gXrxK6z4IeycnMPA
         A41sMJ3D3XBMEEzVHlIBIlqapGBE+LY+DoKFZzc6t27MwfTGjbH0JawWSrd9+qiBep6/
         ZtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=yNimR4kGEBayGU7oXivveTqt8Zx3mvahFcSu8k2A83Y=;
        b=e+9yj1B6bmeblMbIqVF0HfXtggSLdwZv1G6nPNNfhkeLpogWFsTdrBb+yy8amKLqeY
         9qMRP3E1N38Jq8k5zvLwNkIA5LnXpfsiA8NDWXa+FL77vz5KmtTj7iEkzLInZztFC0Zc
         xwpB8/pSuv6nUVMAopEdYDVfQcBiZn15TtLvah1DHtI48ZyN01xXzSrPAGR8lM46QZFB
         TeCl3NoVaHXMM9ifjZnYTpsbcQlwwvdPKgykKDKjn8PdAlVczmYVTHofi0/jxYWaMHnq
         lh0QV6STZu2Eg2QXqDP6mSdHEA/nYDtLIOS+PkZtVH3QAsw6PEUrBifOEA8k15TQmI/D
         AuQg==
X-Gm-Message-State: AJcUukdjWa5r72bEkn4VYMSGQhoy9OwoPiRh7C8VCL+aKsZ45GH2Wr6Q
        Zd5S97PswwtWajAp8zn0G/mUow==
X-Google-Smtp-Source: ALg8bN4O1hF4GoE/ebHH680ePWTyeJk2VLX20aNEfMSocHQFGtOF9K7SjODHYC3ya29GrmBGUndoBA==
X-Received: by 2002:a0c:9359:: with SMTP id e25mr13339154qve.203.1547767477122;
        Thu, 17 Jan 2019 15:24:37 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k62sm45313183qte.86.2019.01.17.15.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 15:24:37 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:24:30 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        YueHaibing <yuehaibing@huawei.com>, Yonghong Song <yhs@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Sean Young <sean@mess.org>, Jiri Benc <jbenc@redhat.com>,
        David Calavera <david.calavera@gmail.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        David Ahern <dsahern@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Petar Penkov <ppenkov@stanford.edu>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Stephen Hemminger <stephen@networkplumber.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        okash.khawaja@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch 8/9] tools: bpftool: Cleanup license mess
Message-ID: <20190117152430.7e47764e@cakuba.netronome.com>
In-Reply-To: <20190117231501.560475279@linutronix.de>
References: <20190117231416.111952141@linutronix.de>
        <20190117231501.560475279@linutronix.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 00:14:24 +0100, Thomas Gleixner wrote:
> Precise and non-ambiguous license information is important. The recent
> relicensing of the bpftools introduced a license conflict.
> 
> The files have now:
> 
>      SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause
> 
> and
> 
>      * This program is free software; you can redistribute it and/or
>      * modify it under the terms of the GNU General Public License
>      * as published by the Free Software Foundation; either version
>      * 2 of the License, or (at your option) any later version
> 
> Amazingly about 20 people acked that change and neither they nor the
> committer noticed. Oh well.

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Sorry about that!  

These files as you found out are from Stephen, so we probably don't
need the full litany of acks.
