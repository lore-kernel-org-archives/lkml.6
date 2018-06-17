Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8147C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E266208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 13:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E266208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755125AbeFQNjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 09:39:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:40979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753970AbeFQNju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 09:39:50 -0400
Received: from homer.simpson.net ([188.174.240.203]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LztHH-1gGirC39SV-0150dV; Sun, 17
 Jun 2018 15:38:41 +0200
Message-ID: <1529242717.4472.3.camel@gmx.de>
Subject: Re: [tip:x86/pti] x86/asm: Pad assembly functions with INT3
 instructions
From:   Mike Galbraith <efault@gmx.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>
Date:   Sun, 17 Jun 2018 15:38:37 +0200
In-Reply-To: <20180617120012.GB16877@zn.tnic>
References: <20180507213755.GA32406@avx2>
         <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
         <1529235613.4572.7.camel@gmx.de> <20180617120012.GB16877@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pwCDEx0mG02bUtnWVpbGK0xYugS/A5fGADDKPwvcBIKucazboKV
 GiHDlRIDY5KuMC5UzSUBiWVSg5u1krMKeeppj1RVIvIKYB0gfsgDoJ+DagXq03Ot6/+YjXT
 o//c0tlaNSLGG5mXHDTG6MVsNDtKIS+EXjKOlIk4Iai3qcOAtVIrkv5+pqUt1RPMAEBiWPI
 smUFuPyoGBkHBJBMam3jQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zDnIGCRwvXc=:ebuhYf7/7oJ5SsE+TVR4ui
 O1lWhQTsY2oSMHza3Ymcy4ZVDHrQMaEsKRC16ReGE2Qde8CCbX0RzupyvsWGV6RrKC2BNs6Zd
 0GtDTF6fBFYeVh7+cKS901d9+9se8h1y9IV+uolfJFSzxAi6Fhbj+AOB9BNGy324v3gGB9F+Q
 PKW1b+kyDpDOY6POdvXkaVi+P7gGoAzocFLNbitPFuxTio2C4FjMtFUXK3DmlnH43UGr61tBn
 DEVhGl9H3P4xYF4aziFGx3PZvTOUfH4jWljAGFTL3Jg1AB/48DwoVUJKnjdOEzdiQu+MJxvRT
 MhZmx3iCANYJTkU07n6bQBl+wvWXJ2QjtELHjuSiAih4YHeWiKeHA6xEKJF0LnndUSdM90zm8
 +uxFb1uZme42bmO8FjvGotS5cL467ZOM1gemaiYlcAQEgaYDgjvgktcFxRDsScX650iypPNAX
 PA2d67/xTyL4Af5tHDPGFx5N0OkqtLNSSz1NXeydEyIAyXjPogxQS807VJDw3ZbufqxevTf+H
 X14Z3rKRav35P+BJ3zby2uCKO57pptVI5flbh+jq4C1I5sSa5HUGoeMSf/EnnEIIpMEqJf6d6
 0c2p5yYXLClA6sRD0K8vgUFlNIvQFY097U2QLILzjEkLXOX1BA/JhnxXXIMbN3UwwJvk+0s80
 8Lxu/kqH94puILVpDPZpeKVl7kRbaahpCedHu4jbSRQD4bcriVifn2Yvx+DQcjHJXNavigF42
 TzrQmJbsgBYDhgxulKJwR1B/F7rwTp/MGaBL0f8WB46jn7zfakjVoHZ9DqTSZClo+PbezmNvL
 zCy8cW5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-17 at 14:00 +0200, Borislav Petkov wrote:
> On Sun, Jun 17, 2018 at 01:40:13PM +0200, Mike Galbraith wrote:
> > On Mon, 2018-05-14 at 05:53 -0700, tip-bot for Alexey Dobriyan wrote:
> > > Commit-ID:  51bad67ffbce0aaa44579f84ef5d05597054ec6a
> > > Gitweb:     https://git.kernel.org/tip/51bad67ffbce0aaa44579f84ef5d05597054ec6a
> > > Author:     Alexey Dobriyan <adobriyan@gmail.com>
> > > AuthorDate: Tue, 8 May 2018 00:37:55 +0300
> > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > CommitDate: Mon, 14 May 2018 11:43:03 +0200
> > > 
> > > x86/asm: Pad assembly functions with INT3 instructions
> > > 
> > > Use INT3 instead of NOP. All that padding between functions is
> > > an illegal area, no legitimate code should jump into it.
> > 
> > Is dinky patchlet suggesting cryptomgr is being naughty?
> > 
> > (revert silences spew, but..)
> > 
> > ...
> > [   21.041608] int3: 0000 [#1] SMP PTI
> > [   21.041754] CPU: 3 PID: 935 Comm: cryptomgr_test Tainted: G            E     4.17.0.g075a1d3-tip-default #146
> > [   21.041888] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> > [   21.042035] RIP: 0010:crypto_aegis128_aesni_enc_tail+0x74/0x80 [aegis128_aesni]
> > [   21.042171] Code: 38 dc ca 66 0f 38 dc d3 66 0f 38 dc de 66 0f ef e5 f3 0f 7f 27 f3 0f 7f 47 10 f3 0f 7f 4f 20 f3 0f 7f 57 30 f3 0f 7f 5f 40 cc <cc> cc cc cc cc cc cc cc cc cc cc cc 48 83 fe 10 0f 82 c3 03 00 00
> 
> Looks like it misses a RET:

Bingo.

[   28.751069] RIP: 0010:crypto_aegis128l_aesni_enc_tail+0xcd/0xd0 [aegis128l_aesni]

Next next next..

> ---
> From 6ac281ee69f4cb5b581d5f49662fb56b6326155a Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <bp@suse.de>
> Date: Sun, 17 Jun 2018 13:57:42 +0200
> Subject: [PATCH] x86/crypto: Add a missing RET
> 
> crypto_aegis128_aesni_enc_tail() needs to return too.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/crypto/aegis128-aesni-asm.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
> index 9254e0b6cc06..717bf0776421 100644
> --- a/arch/x86/crypto/aegis128-aesni-asm.S
> +++ b/arch/x86/crypto/aegis128-aesni-asm.S
> @@ -535,6 +535,7 @@ ENTRY(crypto_aegis128_aesni_enc_tail)
>  	movdqu STATE3, 0x40(STATEP)
>  
>  	FRAME_END
> +	ret
>  ENDPROC(crypto_aegis128_aesni_enc_tail)
>  
>  .macro decrypt_block a s0 s1 s2 s3 s4 i
> -- 
> 2.17.0.582.gccdcbd54c
> 
