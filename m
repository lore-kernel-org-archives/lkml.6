Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F17CC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3172081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MrVqwu3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3172081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeKBAhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:37:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35295 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBAhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:37:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so14502790lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egKIjUBO7rTC1Nw+Ekbq2UHQPHX01tyVGykEgaGfB4s=;
        b=MrVqwu3Kc87dpUvdaDLIQTp88fAAekaljK2k2yhDdkH19sDNRC9COQXL7HdeSbmKPQ
         btGFbvU+sSQ6ts9iPHU4XbKb2KpCkGYR0RH25f0ZJMP+cUvUHgtvRSH0QtS8PZ5DvbnO
         5DQ/zRfvYW13ktNghb35agLIlElLTZekxy4sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egKIjUBO7rTC1Nw+Ekbq2UHQPHX01tyVGykEgaGfB4s=;
        b=EgSE5KSXcCAOxMc6DIfNcAK5aKZtCGo8iRAbIaOl0TmNqZ0aid8vxBWLxcHUE3lBQG
         aOSgw+NinFAr/LInQHNd5GnTRPCDZtw0ToJk98WPzGqIHztmUdfF4F1TuBxAkjTRUnWE
         K4sULJQRciYOoTQb2tpJ0P5m4LJwHh0JputjsTp9YmZ1UB1nTh3WyTDVX8ym8AXpecE6
         DIzycOVONe5lIbWKUoxGGFdC6LtXd0zYWWTlHUlVLzmu8os31fC1BZ26xUWzXQ2m0bfc
         chjxQZPRunFzG8AEx3spEt+uKSCwDNcQabQOvDWj0RGrM4VaEEXfvKnxX0z+PZgb8ayl
         zGOQ==
X-Gm-Message-State: AGRZ1gKjGi9kku5YOQWQ54Y/kB9p5+rzeKenvL7G0PwSwBBPiK2pOrsi
        kcMSv2lOwOGJR6rJQCj8L1jwHcvZBuA=
X-Google-Smtp-Source: AJdET5dj+4AOqLFd6X37fbp85M6MI//MsjlWpuczDyOpiUJnmj5lGVOhdT0P6wmpgx36+dzJy1vB7A==
X-Received: by 2002:a19:4287:: with SMTP id p129mr4930790lfa.135.1541086432975;
        Thu, 01 Nov 2018 08:33:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r199sm2092082lff.50.2018.11.01.08.33.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:33:52 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id p17so8039261lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:33:52 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr4493834lfi.138.1541086431420;
 Thu, 01 Nov 2018 08:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 08:33:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk-2c4XvWjdzc-bs9Hbgvy-p7ASSnKKphggr5qDoXRDQ@mail.gmail.com>
Message-ID: <CAHk-=wjk-2c4XvWjdzc-bs9Hbgvy-p7ASSnKKphggr5qDoXRDQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.21 00/16] rseq updates, new cpu_opv system call (v2)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        boqun.feng@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, tglx@linutronix.de, luto@amacapital.net,
        davejwatson@fb.com, pjt@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Peter Anvin <hpa@zytor.com>, andi@firstfloor.org,
        Christoph Lameter <cl@linux.com>, bmaurer@fb.com,
        rostedt@goodmis.org, josh@joshtriplett.org,
        Catalin Marinas <catalin.marinas@arm.com>, will.deacon@arm.com,
        mtk.manpages@gmail.com, joelaf@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:59 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Here is an updated patchset submitted as RFC for 4.21 (next merge
> window).

So I'm not willing to take the cpu_opv system call until I see the the
regular rseq code getting more real-life use.

Maybe people are using it. Maybe they aren't. I want to hold off and
wait until we _know_ it's getting used, and not just in test
libraries.

                   Linus
