Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6287ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323C5205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Sw1IUYa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323C5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeJYFKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:10:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44403 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYFKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:10:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so2872061pgs.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=f3Nvcbf0Gw3YkxjzeP8g/4jyAF8rPdusxreoDtLe9Hg=;
        b=Sw1IUYa80rtIliU8t37XuCJiVaXpSAv+bg2DJL3O6WZ/4KUvDeqeGyQioxD+E0jW2v
         mMBCdMFXv1IDuK56l5FtBtywQitS15Mv4n194iWXEYI1+EZ0xbpe0d6qQ+AwufVg9hdu
         6hDtxQHoyhvSdy+LcRewChmKhj8xRkHUcaA4JEJBWBeR++xSarzjGvXHCQ82HVkA45Xw
         6WKhaKxRjWM/+Sg+ubGhl5gNXSJzPlMBpCi5OBBmEAko9V93ggoYC9j+EPYJhvM23CWk
         ADnH9Qva/sEyjEMTjXm8vzggmOxUyV4yGTAFr+c9U2GVkx+SFyTmfeC1Kr1gyXy5ppPo
         QEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=f3Nvcbf0Gw3YkxjzeP8g/4jyAF8rPdusxreoDtLe9Hg=;
        b=RlGYFSTqKOQzB9i3CmL5p2udRAfaTYnZfjfb0nLd833WCMsF4s1BllBgcjsER0owEG
         SMKlc+M9vPoyHueZbf/0+FGt/bT34AIQmJOyPGsUA/rwLGJfbvMsZQcX8IXiFW7hKHcg
         jjmfQy0qoQTBErmdYKgFRaWHsKulTtutXuhW4+pLf5qIymVv5nRrTeFcthp6TJnLWtNn
         XSkHAP9yfME5FLC1TGbS/eRX4IKIQT6KV1gnCWHBDzm39qfaO7AMT1zPUXDF5+McEn6F
         MQ8/jAj736ds61iQcZ5SBzHGSPnu9bZFJqEJmg7BlYkWuPbvkJ5KGJBVE5NXx/zM6u6Y
         Ijyw==
X-Gm-Message-State: AGRZ1gKyGfU/dcrOFiCobctCYX4hngxm7ZCAj/5eOJpxjXcTujuyciYC
        Oza+4Cp8k01hAAhPTQKd77wuXA==
X-Google-Smtp-Source: AJdET5ekDwAqPzLVvSCKc9c/kWl601c6s0nYtt43/Bn86+aFf87PVchiBPEU9CNKK2H15JVbURyDzQ==
X-Received: by 2002:a63:5a57:: with SMTP id k23mr2496689pgm.5.1540413649439;
        Wed, 24 Oct 2018 13:40:49 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f28-v6sm6257711pgb.9.2018.10.24.13.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:40:48 -0700 (PDT)
Subject: [PATCH 0/2] RISC-V: Add support for SECCOMP
Date:   Wed, 24 Oct 2018 13:40:34 -0700
Message-Id: <20181024204036.8799-1-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        paul@paul-moore.com, eparis@redhat.com, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org,
        Wesley Terpstra <wesley@sifive.com>, dhowells@redhat.com,
        tglx@linutronix.de, pombredanne@nexb.com,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        david.abdurachmanov@gmail.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 01:20:28 PDT (-0700), david.abdurachmanov@gmail.com wrote:
> On Tue, Oct 23, 2018 at 3:20 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
>> I'm pretty sure this is our largest patch set since the original kernel
>> contribution, and it's certainly the one with the most contributors.
>> While I don't have anything else I know I'm going to submit for the
>> merge window, I would be somewhat surprised if I didn't screw anything
>> up.
>
> Hi Palmer,
>
> Do you plan to land wip-seccomp in 4.20?
>
> It was mentioned back in August:
> http://lists.infradead.org/pipermail/linux-riscv/2018-August/001182.html
>
> david

I've updated the patches to live on top of 4.19 as well as cleaning up
the Kconfig entry.  Unless anyone has any comments I'll add them to
for-next and submit a PR next week.

Thanks for the reminder!


