Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495FEC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3D5204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL/wHA6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3D5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeIJRyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:54:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39135 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJRyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:54:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so21389482wmq.4;
        Mon, 10 Sep 2018 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tR/j/RoXUEJTASIIoGcSfNGZbqRPk4f6bTy4VI6P01I=;
        b=RL/wHA6JaOEJXoJ18VSjXIoBCD6HCuFcV0wu4Qu10SyetIcx7HrD35UUkEsDG/Av2L
         PEXz+GDdErqz5otLTUgHB4HoAzVYfRyhBjL+7njWPNrgAr/fcDhsbWALW9mDp+pYYMfe
         FJSaA7QtcEb+Td0mq935I7wLFV91jTticI7WGE93DHMQhBqsHtKyGtLBM8U0lmHeG2iQ
         flp3WlqTpLHv0BmnoKJXR+jIp6cnkf/RAVGlHxaEp46aW2PuLIinHElTq5Ief7f/26Nz
         uiv6MLAPRD9QkNFAK5ipSeu/D2VfImt8H3mtEfKbmtmZy8gbWoiDdGh86fG+Nw4jbphJ
         Z2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tR/j/RoXUEJTASIIoGcSfNGZbqRPk4f6bTy4VI6P01I=;
        b=qVzGrrvVRkcjtMzn57J6TMh8ZNBQItNEShG+ryIP8fDy7Q8OL/Xser2c26S4lg7i+W
         un7MirXrJ+wE87CiAtkvWJ8AgUjsQj22v4DK7bsiOH9VnhBeAZ+eEuNtYz0+8KAyp171
         OSUee0QiGRqb3dZiZfxIZj3G0rC7ZNhayv9WS1Gwjbk+LmLe9H9+r9lIdMpo+OK1IX3S
         PBG726jyi/gd/i9Fr9HRMrraW7jlm+VyCSH47YLI7DR5w5fd6WT780icXvLjgsXWVEl3
         T9TnDrkse1ijIw07674co1cYroa8I87cdv01eraIVEeb4/WPDDKiWeMwPsHxaM1vBumD
         E87w==
X-Gm-Message-State: APzg51ChMzSC8DqPd2IdftJRX4H3qjdNlpAEftv4YjFit7/gpVK6oQha
        qx3oamL/k4ThF3LvbUI3ZJI=
X-Google-Smtp-Source: ANB0VdaFZWfMF/LmgJkxKfSztlKXBCTfpHy1kMZYjGLlhQ/Sx9rAZSGM49gzUCvEjqguIwbfM3sZ2g==
X-Received: by 2002:a1c:1314:: with SMTP id 20-v6mr659808wmt.55.1536584433128;
        Mon, 10 Sep 2018 06:00:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x16-v6sm11214008wro.84.2018.09.10.06.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 06:00:32 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:00:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH v7 00/10] x86: macrofying inline asm for better
 compilation
Message-ID: <20180910130029.GA66583@gmail.com>
References: <20180809201554.168804-1-namit@vmware.com>
 <4EDCB9E5-22C4-4168-A80A-4EC81ECE43EF@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EDCB9E5-22C4-4168-A80A-4EC81ECE43EF@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> Ping.

Masahiro Yamada noted that some Reviewed-by tags were not added - could you please double check 
past mails and add them and re-send against the latest kernel?

Thanks,

	Ingo
