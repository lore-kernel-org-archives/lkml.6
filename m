Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A9DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8F220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8F220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeFRChO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:37:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:43981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754426AbeFRChM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:37:12 -0400
Received: from homer.simpson.net ([185.221.148.163]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdpcB-1fuUBE376h-00izQ6; Mon, 18
 Jun 2018 04:34:43 +0200
Message-ID: <1529289279.31745.3.camel@gmx.de>
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
Date:   Mon, 18 Jun 2018 04:34:39 +0200
In-Reply-To: <20180617194747.GA21160@zn.tnic>
References: <20180507213755.GA32406@avx2>
         <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
         <1529235613.4572.7.camel@gmx.de> <20180617120012.GB16877@zn.tnic>
         <1529242717.4472.3.camel@gmx.de> <1529244178.4674.1.camel@gmx.de>
         <20180617194747.GA21160@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LkseyzjGSYnNLEHKFzm8fPSubSIPuYj6vUKsqj4biRhmqe9NLQD
 deLSlzMsd1o2YRKTe3vPd+YtSKORI/1y/hE0y/mhOH8bfXBagzND+fnrQnZGa/B4NvN38Hl
 FjfmH2kSUz+fasJa3MW8ESxTdDidT20AN5a2Ntxmnz+mmt9oSxcGlTNJn7mMWptoQsSwjII
 ADKvu+1I1Z11UVFeH1gFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x9l+DyCx5Yk=:YJOLe5oH0maCBNz8N7VHsL
 4GA0pLAit/6Ge8uW6DEXxwQeVf90dLLQdKTXn5mPKjazPU/WB3WRW8OxWA6YmvhLCzms3bxK3
 /DCMg3KRk8EpOuJxvJQAOuvbyi/TJrB4A5jOFzhg7G/CIZu/Eg4GdOWh67XOV/aO/MB4f0xuE
 7LlWD35HZXRNOKUT8x5MShyVwhG9Mv7/zJrWDmbu0PQkWSGYRedGyxvK2hWEX1yD3eLlnBBcs
 t2PrrrqK/QAdQ6kpADyjR73k30uB42RkvTs084UianbUP4QV4S4xVDaCqQRRSpJgPc1ZEAS78
 Ijt9O5KkO07KNhshaZY64ZwTUxZkRGYpPtvuJfDPkNpoPE0IEKPJsOgs8lyNV4DwIKfJPKJwF
 E7dhu+zjqcBi+GANyKB9BeH8Nb7FAG00dtp5TFukS+OetOdwxkMf826GHssvkjkU2TQ1EO1Ca
 n0EbZhtTBKnBSVTYr7PmEydXKzeYVRBFvqVFKkmA+lsfvADbNNNwhxSYdP7WXAI3coLuMZkRU
 Ai6Htfz6rukGGAO+j1H6qBua89t+LLdiY2GQK6ceKfLyKRZU0628+A2Q7EPRk5a8mc/Lwtru8
 slD+/MNRSi7DGlYayTMgVVfFrh8FHI7O02x28HNr+RZO4q/1XShSquMJYLYDqdP7vEd9zEKTU
 H0Vr0EV5ncBZDFOSNZ1XSrsPqMptbO1SDR8WO1uTGlllKUoNmB4mYWojIaUa+hgTA8Blrj+jm
 wlFdAnkokvc3JgwiVn9eDsOjvAwlRWUp4V/yl4mOXdbvSwK93cOEn5IZG4zZA72XVFswlK2T5
 004sseM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-17 at 21:47 +0200, Borislav Petkov wrote:
> On Sun, Jun 17, 2018 at 04:02:58PM +0200, Mike Galbraith wrote:
> > (/me does that.. all better)
> > 
> > From 6ac281ee69f4cb5b581d5f49662fb56b6326155a Mon Sep 17 00:00:00 2001
> > From: Borislav Petkov <bp@suse.de>
> > Date: Sun, 17 Jun 2018 13:57:42 +0200
> > Subject: [PATCH] x86/crypto: Add a missing RET
> > 
> > crypto_aegis128_aesni_enc_tail() needs to return too.
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> 
> [ Mike: took care of the other tail calls. ]
> Signed-off-by: Mike Galbraith <efault@gmx.de>

I didn't think a sign-off was needed... it was your brain that wiggled
my fingers after all ;-)

	-Mike
