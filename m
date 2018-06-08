Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EcSZMWpoGlshSwAAmS7hNA
	; Fri, 08 Jun 2018 11:28:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AA1966089E; Fri,  8 Jun 2018 11:28:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l69mvJZg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EBFB0601D2;
	Fri,  8 Jun 2018 11:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBFB0601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeFHL2k (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:28:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38105 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeFHL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:28:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id e18-v6so4782815wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m+6alswFcWaGbit5bjpApTQ0eoFkRWLFw92lGqyVEzY=;
        b=l69mvJZg8CMcziYukhJGxuiq8ysnmxolMGdrqKe+171ZsRNR3Wkse0IUMFZwg7gQsH
         wXp2t2qjTdhUG5RUVoxkfydMSbhsyPe8QZTMBnynNgLKXTXiEC05IKRV0hujjRaH+nYw
         pgj4xzJ8DRYZbOQEnxnnuruhXsscoTUrd5G+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m+6alswFcWaGbit5bjpApTQ0eoFkRWLFw92lGqyVEzY=;
        b=CjskLH0s7JI5MI9JYvo9W47nePxsrOmCqV0nvow5n2KySDMfDTChD2lxQl6UJYoQUQ
         rDPP7sbEourxQpgCN6VFS2VuiGd8huHOaewNNPq0AZgQdLp0pODa7rQUPyTUB3lPm5G2
         fOMKWVjqE6U6cCWDha6W1zXfgoFrsX/HfueN+9J4BlPtWYCMumEnXqe/1ft4+fSbV7+y
         wJRnWnFrJBsdMpiEahwp/xKt2zLZfuqCK2MYMmM1oamn/cY/RK1+CDpACJecG/BQA37t
         zM1HFeJCEImWfsYTMQNKP7TpJ1O2Mq38ah8KMKNaqTLYty21xEhmWqzCGUIGk0kyCdUP
         DctQ==
X-Gm-Message-State: APt69E0zNApYhfunBDv6oQSZRWyyrn/VauewAWqMoxsqME1ZqHZ7IVvk
        tsMwspMWTF/MLAGIT08IxFS65VESptU=
X-Google-Smtp-Source: ADUXVKJ94FFI9IDeWOA4T9b4YIEPsF44QvxmXm05ZMLwTslDBKkdhGSBJwsXCi8A5GsY0U+alczDZA==
X-Received: by 2002:a5d:4906:: with SMTP id x6-v6mr4750597wrq.66.1528457315759;
        Fri, 08 Jun 2018 04:28:35 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id t1-v6sm1407045wmt.40.2018.06.08.04.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 04:28:34 -0700 (PDT)
Date: Fri, 8 Jun 2018 13:28:26 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        virtualization@lists.linux-foundation.org, astrachan@google.com,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, tstellar@redhat.com,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>, mawilcox@microsoft.com,
        David Rientjes <rientjes@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, Brijesh Singh <brijesh.singh@amd.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 1/3] compiler-gcc.h: add gnu_inline to all inline
 declarations
Message-ID: <20180608112826.GA7484@andrea>
References: <20180607204927.219329-1-ndesaulniers@google.com>
 <20180607204927.219329-2-ndesaulniers@google.com>
 <CAK8P3a0yi+MrOS=+pjCeUu==YBE_AppB8vfqdsQS-1NpSO2c4A@mail.gmail.com>
 <CA+icZUXDoeo5ktZZPFcFyLzk3xthM-98N88QJFzesg6t+Vr5cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXDoeo5ktZZPFcFyLzk3xthM-98N88QJFzesg6t+Vr5cQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 12:04:36PM +0200, Sedat Dilek wrote:
> On Fri, Jun 8, 2018 at 9:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jun 7, 2018 at 10:49 PM, Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >> Functions marked extern inline do not emit an externally visible
> >> function when the gnu89 C standard is used. Some KBUILD Makefiles
> >> overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
> >> an explicit C standard specified, the default is gnu11. Since c99, the
> >> semantics of extern inline have changed such that an externally visible
> >> function is always emitted. This can lead to multiple definition errors
> >> of extern inline functions at link time of compilation units whose build
> >> files have removed an explicit C standard compiler flag for users of GCC
> >> 5.1+ or Clang.
> >>
> >> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> >> Suggested-by: Joe Perches <joe@perches.com>
> >
> > I suspect this will break Geert's gcc-4.1.2, which I think doesn't have that
> > attribute yet (4.1.3 or higher have it according to the documentation.
> >
> > It wouldn't be hard to work around that if we want to keep that version
> > working, or we could decide that it's time to officially stop supporting
> > that version, but we should probably decide on one or the other.
> >
> 
> Good point.
> What is the minimum requirement of GCC version currently?

Good question ;-)  (I recently had the impression that
Documentation/process/changes.rst was making fun of me ;-)


> AFAICS x86/asm-goto support requires GCC >= 4.5?
> 
> Just FYI...
> ...saw the last days in upstream commits that kbuild/kconfig for
> 4.18-rc1 offers possibilities to check for cc-version dependencies.

Good to know!  Mind retrieving/sharing the commit id(s)
or links to the corresponding discussion on LKML?

Thanks,
  Andrea


> 
> - sed@ -
