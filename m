Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E4FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A593B24639
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CNvudrRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A593B24639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbeFVRB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:01:58 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:43545 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeFVRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:01:56 -0400
Received: by mail-pg0-f54.google.com with SMTP id a14-v6so3224194pgw.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=Xy4ncE9MGddoD2sMPgMz8TjmzwXSTPtcf1vLb4HmQbs=;
        b=CNvudrRKyEQ83GN811SiTqZmfAGaWtRZol+RjiNCtCBcnU3XxJ/aDvVQgux1IMeQUY
         4RS6RHfhftj9bNYQeXh4ny92Wictfm3M6xmVBSwK/u9ZUeGucW8Y1HDY3HnnNsOhJ9G6
         Nkzbqq8jAhc2mh1YymjA+tslUGNCEnIVHkp13O+Qcot4Jaj070IcMma678U7GcJhlc0Z
         W5Jx3QfE13MboxHvPgfQ7pS7ozZ7L8ZthwcWWuqUnU0ocu7Kq7FYf3YIO+4Sv98K+kIv
         BxgiJdRIl0MK0H1gR/BQDRiNnWEnm3caz+KGV1shXC9Fmk4y7bamgrxZsMnz9pGCSU6q
         WMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=Xy4ncE9MGddoD2sMPgMz8TjmzwXSTPtcf1vLb4HmQbs=;
        b=hNUxDPejogh6ePZOoglUw4tjHwpD0c5ez8i5el8Pl8A8/9wJZtsrD+PO3BUv5nXQGJ
         +PnFeZJMbUEucy+bXUYHiWCKvwKRDn+DV3L9VzS+lk36J0GZeU9WtV5L0kcafi/xt6z/
         R0k9fpmQDPL87tPE/gmTKT8rVXi5R2HadrKi/H/MCChmEop28AMr49B2FABU31123ePV
         lFE202hvTY9t/0HftDTdwi/6r5v1Ua4kOOR19b1c/onAiF3XJzYUkvYAYMB8FnBVQZ+Z
         iCF4FvKWjYTAQ03irFfs/WH9CTTRvDmYpKJOyMWqTpxDIUqbg1n0UsraBJth74Cob2Ub
         Sddw==
X-Gm-Message-State: APt69E20ecPTELsIpxA3ZoB+dVb2Yh3YMhdb8tz0HH3ustTTTOz0KZll
        XSjQKvOTA5hP5+ra9opp5wN2EQ==
X-Google-Smtp-Source: ADUXVKJ7Rhm4ujwaQidR/9oKv4eihZLB6qaEfE6RjveVjL/j7GdMUlZ7bccyag5E4WsypsvUsuzcjw==
X-Received: by 2002:a65:4a10:: with SMTP id s16-v6mr2162120pgq.57.1529686916101;
        Fri, 22 Jun 2018 10:01:56 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u1-v6sm11318126pgc.80.2018.06.22.10.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 10:01:55 -0700 (PDT)
Subject: Re: Finish the GENERIC_IRQ_MULTI_HANDLER conversion
Date:   Fri, 22 Jun 2018 10:01:21 -0700
Message-Id: <20180622170126.6308-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621181756.12493-1-palmer@sifive.com>
References: <20180621181756.12493-1-palmer@sifive.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        Arnd Bergmann <arnd@arndb.de>, nicolas.pitre@linaro.org,
        vladimir.murzin@arm.com, keescook@chromium.org,
        jinb.park7@gmail.com, yamada.masahiro@socionext.com,
        alexandre.belloni@bootlin.com, Palmer Dabbelt <palmer@sifive.com>,
        pombredanne@nexb.com, Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, jhogan@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:17 AM, Palmer Dabbelt <palmer@sifive.com> wrote:
> A while ago I sent a patch set that adds a GENERIC_IRQ_MULTI_HANDLER,
> which is an exact copy of the existing IRQ_MULTI_HANDLER support in the
> arm port, which is being used unconditionally by arm64 and openrisc.
> GENERIC_IRQ_MULTI_HANDLER is currently being used by the RISC-V port.  I
> managed to make a few mistakes in my original patch set and as a result
> my conversion of the other architectures of GENERIC_IRQ_MULTI_HANDLER
> was dropped.
> 
> This patch set finishes up my original patch set by converting arm,
> arm64, and openrisc over to the new GENERIC_IRQ_MULTI_HANDLER support
> and then removing MULTI_IRQ_HANDLER as it's obselete.
> 
> At the time I wrote this I gave it fairly extensive build testing, but
> went I recently rebased it I just tested the full patch set on arm,
> arm64, and openrisc defconfigs.
> 
> Various flavors of this patch set have bounced around a few times
> before, but I'm calling this a whole new patch set as it builds on top
> of what was merged.

Looks like I managed to lose the patches.  They should be threaded under
this message...
