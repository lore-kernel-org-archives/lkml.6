Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935700AbeE2OrO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:47:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54873 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936654AbeE2Oqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:44 -0400
Date: Tue, 29 May 2018 16:46:40 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Enhance the information in
 cpu_show_spectre_v1()
Message-ID: <20180529164640.02faedcd@kitsune.suse.cz>
In-Reply-To: <1b720765-faf1-719e-ab76-b3eafa559896@c-s.fr>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
        <20180528131914.32231-1-msuchanek@suse.de>
        <1b720765-faf1-719e-ab76-b3eafa559896@c-s.fr>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 16:13:49 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 28/05/2018 à 15:19, Michal Suchanek a écrit :
> > We now have barrier_nospec as mitigation so print it in
> > cpu_show_spectre_v1 when enabled.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >   arch/powerpc/kernel/security.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/security.c
> > b/arch/powerpc/kernel/security.c index 0239383c7e4d..a0c32d53980b
> > 100644 --- a/arch/powerpc/kernel/security.c
> > +++ b/arch/powerpc/kernel/security.c
> > @@ -120,7 +120,10 @@ ssize_t cpu_show_spectre_v1(struct device
> > *dev, struct device_attribute *attr, c if
> > (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR)) return
> > sprintf(buf, "Not affected\n"); 
> > -	return sprintf(buf, "Vulnerable\n");
> > +	if (barrier_nospec_enabled)  
> 
> > +		return sprintf(buf, "Mitigation: __user pointer
> > sanitization\n");
> > +	else
> > +		return sprintf(buf, "Vulnerable\n");  
> 
> Checkpatch would tell you that an else is unneeded after a return. So 
> just leave it as it was before.

Where did you get your copy of checkpatch? The one in Linux tree does
not do that.

Thanks

Michal
