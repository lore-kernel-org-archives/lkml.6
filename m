Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bwiAD4VxGludNQAAmS7hNA
	; Fri, 08 Jun 2018 12:07:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8795D608B8; Fri,  8 Jun 2018 12:07:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGzd4d/Y"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1C5A1605A5;
	Fri,  8 Jun 2018 12:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C5A1605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeFHMH4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:07:56 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36390 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbeFHMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:07:54 -0400
Received: by mail-lf0-f67.google.com with SMTP id u4-v6so19732108lff.3;
        Fri, 08 Jun 2018 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1tnaKvjh8k1b0CZs+mpV6H2ERiDZglxlgKGfZM67iks=;
        b=tGzd4d/YMVvaSLnphrnWlAtXYtOXzxjViYxIVSFshVg51X7jc5JMjc+FQCS2eM7AjB
         biMadR44uPO2X8jDuyBdZKjhGOyTOiB/ZJTiMKu1cOE7pRZVAOUDGiPYJbX26xdwDLZn
         cgItXiVxgt3N3EEW5AfWCchyrMg1VpARvPP6A84HwKxMqjO3qLrwHoMN3vdk0Ijk/dIL
         vCMAymJJi0TqkC9PhavysmPOwPwVTbEjuHHG5aJK/VWUdp0x2qkNmFA8QepT6ILQJ9uE
         3F8IJXRmWaAkmgw73tkCJA46IF9QksomFLe/f0zlzi3fQPVr2tQgV0KXZOUhwxMLSHx3
         t2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1tnaKvjh8k1b0CZs+mpV6H2ERiDZglxlgKGfZM67iks=;
        b=l1Ve1D6fC9YMM5PNBMWjoWc4zIE5VvKY7wrxY4h9eWbm12eDHazKSSLAVEWigwazun
         XsxncuOGIXWJdcFySjbkBxCkWsrnHKuEf7GVZzE8pHBpFWq5jt/xBdhsbZMECEfQ2Jwq
         bWCmPJs4tJHryaljfuw7nk4Lj3v9cizB8mp4jK3W7Yn7wSIWqADPl3Io7RwwWb7GfMKt
         YTeWFbXL/5kXRdNLYttD5E0NANDbfXI/bTlQXBuh9UlpDiPEAjE7B4EadDY/d/MRxXAw
         orCdy23J3ssPaJIe9DGafqXQ4RSwr+AGG3nOLZYoTT8hexfYIIZP4hsy1zXokPg5B5XV
         cucg==
X-Gm-Message-State: APt69E2Qo/4wtNX3RqX6QJ0DNye8jK8ORzBcg38Vxdtqufks4IBJ8SAe
        sxoS9eGXfUydx3R2g9VL4DBxAILp
X-Google-Smtp-Source: ADUXVKJkmRmWk3+39u2FngCtJWEjeY7gwXnY65o4alSu9muuxLfwP+LFor6VV/4O2YsgkS72n3VNlA==
X-Received: by 2002:a19:b587:: with SMTP id g7-v6mr4019082lfk.144.1528459672277;
        Fri, 08 Jun 2018 05:07:52 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id j64-v6sm2245121lfe.64.2018.06.08.05.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 05:07:51 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id D8A3C460756; Fri,  8 Jun 2018 15:07:50 +0300 (MSK)
Date: Fri, 8 Jun 2018 15:07:50 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Subject: Re: [PATCH 03/10] x86/cet: Signal handling for shadow stack
Message-ID: <20180608120750.GB2525@uranus>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-4-yu-cheng.yu@intel.com>
 <CALCETrWo77RS_wOzskw5OG-LdC1S-b_NY=uPWUmPbQEnNwANgQ@mail.gmail.com>
 <20180607200714.GA2525@uranus>
 <CALCETrXAoPsHK49c1Dpa8N0ccsxjwnVOTktKVaY++xjHxdmUzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXAoPsHK49c1Dpa8N0ccsxjwnVOTktKVaY++xjHxdmUzg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 01:57:03PM -0700, Andy Lutomirski wrote:
...
> >
> > I didn't read the whole series of patches in details
> > yet, hopefully will be able tomorrow. Thanks Andy for
> > CC'ing!
> 
> We have uc_flags.  It might be useful to carve out some of the flag
> space (24 bits?) to indicate something like the *size* of sigcontext
> and teach the kernel that new sigcontext fields should only be parsed
> on sigreturn() if the size is large enough.

Yes, this should do the trick.
