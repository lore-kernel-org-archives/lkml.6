Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7802063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBbrDnCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfANMOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:14:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47033 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfANMOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:14:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so10061531ply.13;
        Mon, 14 Jan 2019 04:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9rDzKOuL0UG5qQGT2nWf2dhs7fmgU+oCSfvYTEpYImY=;
        b=pBbrDnCxBKp/SJuRdXcl+9i0ufQYwz6AalCV8iIiIqNGD9npyX1NOlTqDUopV+bQV4
         6l1jv48D9uH3tNBQppzuMH+ofIwu1BD1nU5QSLw5vXRSceGHxFHha+71fCVdrx8QYiqF
         KkuqYldcZXNAY26wnm8q5cGodugN9QB596lD/56t1rjFSgEFX0E94U1xaa/SdacqAdoE
         PfyUvJ+tt2VfDO47MG2vS0drJkHSNZz6n51fqxWHu5qDRN+t24BKt95+KAfYivAkuzPx
         FYnaERSa8Pc0J9fmF1ozTACMvqVQKoSwjJIJgTqGP20bPfDFSWi8bmTZKKyM/GzOQrY/
         Gfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9rDzKOuL0UG5qQGT2nWf2dhs7fmgU+oCSfvYTEpYImY=;
        b=qS7ajZe1H5zMR4FQb7QTk+2JQEXX56OOX+5CIypGnNkbM/tryxh69+fKEcXBrN/oat
         u4gIbMK/Y/EJGvSoRRRR40t14cIoq7febs2MZeSA+S8GRXcEj6ogyskdvEJYJnkVE7fm
         EOzURmEyKSApl9075M0eSuVbrPUR9yyahW87b/odJoQO2/bdcCbB3o7o6MrGpxmf4UzC
         D34hzf1p5qMII1aoiMQZ7V2pdG4UJz+yIfQK8G3JMawNWENwW7d0XnJ9rIL7hjzjAeAS
         7AXUvc3S11yGasqjDhGBLJ17UqivRnnzQLc2EpkBHV8lLsK6PLGEo3X/mnMz/47YvEUr
         K5aw==
X-Gm-Message-State: AJcUukezPlMq91ik3IhqXGRizTq8xxjozRbaMnI7qhRIv9+6SMJ23/S6
        JzAem3P+Zpp8bPo/usJGqMc=
X-Google-Smtp-Source: ALg8bN6vONMdv/cln8lQbUiW9tABKWpS0tNZBKGzuMdSUwCuDQui4P121o0Rx6T8lRoUghX4sDKfZQ==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr25465192plu.127.1547468043821;
        Mon, 14 Jan 2019 04:14:03 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id e24sm325936pfi.153.2019.01.14.04.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 04:14:02 -0800 (PST)
Date:   Mon, 14 Jan 2019 23:13:59 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190114121359.GB26056@350D>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104175017.GA7157@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 05:50:18PM +0000, Mark Rutland wrote:
> Hi Torsten,
> 
> On Fri, Jan 04, 2019 at 03:10:53PM +0100, Torsten Duwe wrote:
> > Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
> > of each function. Replace the first NOP thus generated with a quick LR
> > saver (move it to scratch reg x9), so the 2nd replacement insn, the call
> > to ftrace, does not clobber the value. Ftrace will then generate the
> > standard stack frames.
> >

Do we know what the overhead would be, if this was a link time change
for the first instruction?

Also, I was under the impression that some arch's do ftrace_call_replace
under stop_machine(), is that a possibility here?

Balbir Singh 
