Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeCUJ6H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:58:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36624 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeCUJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:58:04 -0400
Date: Wed, 21 Mar 2018 10:57:58 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: questions about header.S
In-Reply-To: <b47b8ad8-4015-9437-d6b6-6e2d17ea117b@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1803211052110.3754@nanos.tec.linutronix.de>
References: <ac02a918-0c7a-2376-569d-c53a87bc1a42@cn.fujitsu.com> <b47b8ad8-4015-9437-d6b6-6e2d17ea117b@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2081520870-1521626278=:3754"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2081520870-1521626278=:3754
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 21 Mar 2018, Cao jin wrote:
> On 03/17/2018 06:01 PM, Cao jin wrote:
> >   I find two small questions which confuse me a little.
> > 
> > 1.
> > # Check signature at end of setup
> >        cmpl    $0x5a5aaa55, setup_sig
> >        jne     setup_bad
> > 
> > setup_sig is defined in setup.ld, which points to the constant also
> > defined in setup.ld, so I don't figure out in which case they don't
> > equal and jump to setup_bad?

That's a lame sanity check to make sure that nothing overwrote the loader.

> > In my test, drop these 2 lines seems fine, system can boot without any
> > obvious error.

Sure it does as long as you have no corruption.

> > 2.
> > # Zero the bss
> > 	movw	$__bss_start, %di
> > 	movw	$_end+3, %cx
> > 	xorl	%eax, %eax
> > 	subw	%di, %cx
> > 	shrw	$2, %cx
> > 	rep; stosl
> > 
> > It is not a big deal, but I think replace "_end" with "__bss_end" make
> > more sense, and "_end" is already aligned to word length. And, there is
> > no other code use symbol "__bss_end". So I don't know is there any
> > reason to use "_end" here?

It doesn't matter at all. But its also pointless to change it.

Thanks,

	tglx
--8323329-2081520870-1521626278=:3754--
