Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F239AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 04:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11882075B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 04:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11882075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeHXIWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 04:22:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:37321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbeHXIWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 04:22:24 -0400
Received: from homer.simpson.net ([185.221.149.242]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ma1pn-1fXOZo3qAh-00Lnno; Fri, 24
 Aug 2018 06:49:00 +0200
Message-ID: <1535086138.4661.9.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Young <dyoung@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Date:   Fri, 24 Aug 2018 06:48:58 +0200
In-Reply-To: <20180823035705.GA5743@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
         <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
         <1533800010.5087.71.camel@gmx.de>
         <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
         <CAKv+Gu8KKwNkUdx7tSxEosRvydxmQ2yaasHRJn_LcHPs7p2UYQ@mail.gmail.com>
         <20180822102310.GA19827@dhcp-128-65.nay.redhat.com>
         <20180823035705.GA5743@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EjxL/Q+WTUNa+9zdXUDybQdEbVmezTXf9+X39ei8cj+eWn3IKVL
 Al6O4ZzF2N6TiIA1RiscjkRs8zQVZ7FauHD32mxT/oZjbSSHWxnCHAEi6gVWztn2f82iRmE
 VZrsSesuc8O/l+przdFenIATEdLkJYT+lUtgwQQc1NIPFve9iPG8tNKjh6d1coBwMcJisZv
 F2HI8uWgZa/YgoHNacShA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xk/SAjc/26c=:5UgiCok4hl+6MTYvPc00+b
 2G0d/h/q8/21Zlo+CUV/WMXdNqrCAOxTzzCQb02k5su4ZJbPBX4QjMGvcNw+uO18JjW/c7fAf
 qanycM51h7tls++1Ny4r0HatTtsv+FnAOVPhTtjb+V9+ooFO4tdcQVTsd2Sh+Q56vb4JJUeyn
 V9QIMepTVe1ZUPP4/WJu5w7fil/MX6pWPtT9pdORW5d+a2YNVvta+3JdZnr9W17xqjVcZavLu
 gv9lwpw/L4qWyRb3XhaH0C5OzRkvDTU24pZxiDvR1aBBu9FVBdx5fwwkK0knkdpPW97i/jdR2
 PIlcZGd4dUqLiE+df/D8+odq+3KSIfAFuxbObLh/vCeG6t6GG3pyaWD1uDreR+MRLq62WQcZx
 x/LOZMrJRDdyLzJT46gGQ+Lc2LHfTDNovGaP3rVnBF+WEIumdSh54dRd1HHgETro83aN8lMR8
 4OvbFOw2Den8aocKikwFUtHnhY38nIr7fCOxV+vzwP+i2uh/3FZBReJ9fX/KScdn6XFALDPqz
 KDMLtLzFjpQqChq0joksoywX1V68PYGF0L+VTT540BLkiXR0yQ5ClIzgjS3dE18hxTCky2Z1+
 o1j7bQAQ8Dr/ZHYc7fyEXRHSsXch56FwPKZHHGxrEqGaz6T3oKFiKTURXtNGg+nffJSZCpLwG
 af6aMCHfDxiKiD7arnDJHLmC5XsNPig7pehF4f49/cgGjy5p3quG13Y226yarzzxDv34OsYnl
 kzqxwx+6lcH42zksvcfDjPaRxYS8zotxMaGfbSrvgyVBOLlF3MR8dyixJ45wZOmm2ip7AgIQA
 4ePk/ST
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 11:57 +0800, Dave Young wrote:
> 
> Mike, since we are going this way, I'm working on a kexec code cleanup,
> but it needs careful testing so still need some time.
> 
> Can you help test below efi fix and provide you tested-by if it works?

While it averts the efi=noruntime oops on kdump kernel load, the kernel
does not boot when kdump is triggered.  Bailing in setup_efi_state() in
addition restores functionality.

	-Mike
