Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA9AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4C320837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ae2OOy9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4C320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLGGQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:16:43 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55458 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:16:43 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so5295535itg.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=998y8pHq+kRnZsu/gJjJwmjSGRxH1Yh1ButahyP6q18=;
        b=Ae2OOy9X9FFuQB1eDZsoI1QniElK5oK8FpFiO+UbB6HkzU0sSIQJLlVCMtO0gqn3I0
         YmR6Coi+LqbN0lZmULOH0rVHI17CulqxScSn+VP9MqkmWr2g1D2Gbatewkq9FAKkswVu
         aMt5DQmzKkK3I8N0sX6S+lfR0rPwKZRu/jhVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=998y8pHq+kRnZsu/gJjJwmjSGRxH1Yh1ButahyP6q18=;
        b=bbrKS6tlwmPmJYiRj6GqpfVmSWzBat2SgekLgX9KL6Q5Nisvu4ee3tsincaDSBH50D
         Fd5csUwoBi62H+BWYl3yNlKezsFdj/ebblfhdU3e52PrBsVIcpAeTB8hrljw6IFp7vd0
         1zku0Bj6YmkP1qRPY7t5+RaBEzVzDcJcge0qcuvAUs0ACDsKYffz6LUWW4a2UflqcWkN
         q5AQerwyOFzlCCy1zKxlhQy1VCD15j9ueE9ZxBBFSv6uHlM1CJE+67IspGJm1akOU0zH
         FJPoP068XPX46l8EVfOPMet+YJu/bYdCmg1zbkEruIgy2ieNq79Ier1vEDp86H0BzTEW
         pIuA==
X-Gm-Message-State: AA+aEWbLgmSjavK6WMvyKhGFzmdEELuaPRLp9r319ipc7KVqrM95IwGm
        Jno/ioDU3OioK6EX912w2bPXbuuFGlZKzNKTe+ztUw==
X-Google-Smtp-Source: AFSGD/U3+GgbDTRzz1OZtRERgH0dFuTzHXMWawglO6JkGEH+J6GdvUuc5VzR68E6FWURnkzhHDqKckh1X8wBgdres7k=
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr1060805itd.148.1544163402432;
 Thu, 06 Dec 2018 22:16:42 -0800 (PST)
MIME-Version: 1.0
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 7 Dec 2018 11:46:30 +0530
Message-ID: <CALxhOnij8xO1yyZ87HX_jE8YdE-PbEe9a=yu50wvORnn-0_UvQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powerpc: system call table generation support
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++ sathnaga@linux.vnet.ibm.com,

Hi Satheesh,

On Fri, 7 Dec 2018 at 11:42, Firoz Khan <firoz.khan@linaro.org> wrote:
>
>
> Changes since v3:
>  - split compat syscall table out from native table.
>  - modified the script to add new line in the generated
>    file.

I have fixed few major issue. Could you perform boot test with v4
on the platform.

Thanks
Firoz
