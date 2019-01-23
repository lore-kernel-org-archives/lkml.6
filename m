Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DC5C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B257820868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhfUgUnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfAWAta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:49:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40828 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfAWAt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:49:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so223151pgp.7;
        Tue, 22 Jan 2019 16:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d5n7/NNezEXEyOClcqhBWH86ElnBZS1l8ZVtliN87Is=;
        b=nhfUgUnXSKn/dQCOkPtjmwLYQci8Gs9P5WgUFMl+ezbZInvTneQXaQ8XltFqLP0Wgn
         6ZpjX8g8IRcDvZhj3Dk1kfHH4Qm8iUMtBjjqLHZGvPfzXA49eo4JkLQSuin2rXz6mhD7
         4N0jUDmbp98zZ+1Atqo3Fy1VOXq4eq9dpU08YKuOHe21+whx7mrSXuTKVXCa/ZwPZlOF
         34wAQKpcfF2hWPGgzPbTpfV8mf+AAUrwyvioOVttceSKY7dfenUCX2gKMf+huNeVB79e
         VbW7QFrFEKBmwf87y9DU8XdQlOPFt4slU+EIFJyoFfL1Mh3CwSBofozRuDqN/1ZfHfOE
         ReKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5n7/NNezEXEyOClcqhBWH86ElnBZS1l8ZVtliN87Is=;
        b=nBixfJWd0R5aH+ArYT5Do2jT6THXGg9Jb9AIU2PPq7KdZM7i4uzn14Syh8xaW3JHbk
         ldfIn79+v3ykXqNr3OEl2TCvXU7WxvNfTHtovHz8VSLaSmVIIrk1RPjcGzz+NXgoE93c
         Q0GyweVhIPk17N8dAybNIInKMVfy2aOjjNyZ7sBVkFniQo/Z8PbhfqoGct1AeS1ibGEL
         1jMcdtskfaKdAwgFgEaWK4aD6SgsITCHc42+tsQMuTOMP2BSBmiRzC9Pso+dnRXXyONC
         jcU6u6yjL05Pt91tRgSCZ6jK53z8YW9EpvNTrdRq+JewPzU+Nj20LrLsYba2N6w4NwxH
         6HlQ==
X-Gm-Message-State: AJcUukcJOlzDQLvt1MRp2k+j6sE20k4pTGEpB7W8DvFcoKIrpM7WucHV
        hZfsalQXuLNOnNUeOP8Y09g=
X-Google-Smtp-Source: ALg8bN5pK7+bt6lT0KEQPuWFyuIUUGgKaklwRgIkSq1Afz1Hl3cvSHjcjbDKQj52NGi7zMTfWjoToQ==
X-Received: by 2002:a65:5a4c:: with SMTP id z12mr141314pgs.188.1548204568974;
        Tue, 22 Jan 2019 16:49:28 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id o84sm33830911pfi.172.2019.01.22.16.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 16:49:28 -0800 (PST)
Date:   Wed, 23 Jan 2019 00:49:25 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Changbin Du <changbin.du@gmail.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: Fix vm entry failure caused by invalid vmexit
 controls
Message-ID: <20190123004924.2xprohspc74h5xnf@mail.google.com>
References: <20190122152952.8011-1-changbin.du@gmail.com>
 <20190122170045.GD28513@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122170045.GD28513@linux.intel.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 09:00:45AM -0800, Sean Christopherson wrote:
> On Tue, Jan 22, 2019 at 11:29:52PM +0800, Changbin Du wrote:
> > The commit c73da3f ("KVM: VMX: Properly handle dynamic VM Entry/Exit
> > controls") has a typo that cause invalid vmexit controls. The
> > VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL is against _vmentry_control.
> > 
> > KVM: entry failed, hardware error 0x7
> > EAX=00000000 EBX=00000000 ECX=00000000 EDX=000206c2
> > ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
> > EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> > ES =0000 00000000 0000ffff 00009300
> > CS =f000 ffff0000 0000ffff 00009b00
> > SS =0000 00000000 0000ffff 00009300
> > DS =0000 00000000 0000ffff 00009300
> > FS =0000 00000000 0000ffff 00009300
> > GS =0000 00000000 0000ffff 00009300
> > LDT=0000 00000000 0000ffff 00008200
> > TR =0000 00000000 0000ffff 00008b00
> > GDT= 00000000 0000ffff
> > IDT= 00000000 0000ffff
> > CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
> > DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
> > DR3=0000000000000000 DR6=00000000ffff0ff0 DR7=0000000000000400
> > EFER=0000000000000000
> > 
> > Fixes: c73da3f ("KVM: VMX: Properly handle dynamic VM Entry/Exit controls")
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> Patch already submitted[1].
> 
> Paolo/Radim, the VM-Exit fix needs to be queued asap.  The fix for the
> objtool warning[2] should also go into v5.0.
> 
echo. This bug breaks kvm on some old machines!

> [1] https://patchwork.kernel.org/patch/10763351/
> [2] https://patchwork.kernel.org/patch/10765309/
> 
> 
> 
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index f6915f10e584..0762fcab8fc9 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -2344,7 +2344,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
> >  		case 37: /* AAT100 */
> >  		case 44: /* BC86,AAY89,BD102 */
> >  		case 46: /* BA97 */
> > -			_vmexit_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> > +			_vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> >  			_vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> >  			pr_warn_once("kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
> >  					"does not work properly. Using workaround\n");
> > -- 
> > 2.19.1
> > 

-- 
Cheers,
Changbin Du
