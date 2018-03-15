Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeCOT3G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:29:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54414 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbeCOT3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:29:04 -0400
Date: Thu, 15 Mar 2018 20:28:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
In-Reply-To: <20180315170202.GA5180@flask>
Message-ID: <alpine.DEB.2.21.1803152027370.1520@nanos.tec.linutronix.de>
References: <20180309140249.2840-1-vkuznets@redhat.com> <20180309140249.2840-8-vkuznets@redhat.com> <2747cc75-b549-61bb-9c1b-0f554a49b536@redhat.com> <87zi399xih.fsf@vitty.brq.redhat.com> <20180315170202.GA5180@flask>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-351697842-1521142140=:1520"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-351697842-1521142140=:1520
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT

On Thu, 15 Mar 2018, Radim Krèmáø wrote:
> 2018-03-15 16:19+0100, Vitaly Kuznetsov:
> > This works. But hell, this is a crude hack :-) Not sure if there's a
> > cleaner way to find what needs to be patched without something like jump
> > label table ...
> 
> Yeah, I can see us accidently patching parts of other instructions. :)
> 
> The target instruction address can be made into a C-accessible symbol
> with the same trick that vmx_return uses -- add a .global containing the
> address of a label (not sure if a more direct approach would work).
> 
> The evil in me likes it.  (The good is too lazy to add a decent patching
> infrastructure for just one user.)

Can we just use jump labels please? There is agreement that 4.17 will have
a dependency on a jump label capable compiler for x86.

Thanks,

	tglx


--8323329-351697842-1521142140=:1520--
