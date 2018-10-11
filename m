Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB8AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83AB2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC8xs2iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83AB2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeJKV77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:59:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35385 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKV77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:59:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so9968160wrt.2;
        Thu, 11 Oct 2018 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aq4CO+ucwvp4OpOtB2Rc4m7DV25+n63yBFoirgILx5w=;
        b=YC8xs2iQTEoYOTIRv8xAfdXVRvNLdLBLbDEPosZ8cu1I9k6S7FfOGR3eAM59fJ1tMQ
         g5sgEjmu0R3HTYwnkUVgCadE+TlDARU/ArkSwIbMJYXL7P0fMCji6ntn95/Y/Ti5sMv0
         ZNYaU7gViJgtrk3Nh4dMreMoUUFmoOxQz3eziwGHSYgELSQ+JrWL1H2iT+RjDMQP1Ouq
         A/lLbnATqiRFhqGrm5/fhXEVt+uoYiLhaS9toR88Rfs/kJUbAXqGsjXGlsFcCc8gFj30
         s/UFScbXZjZjDC5kJKgJwS7nXnR/Sbj3TNoY8WGdgTJh7+j7hWvJBX1i8zlBe0FXHjXu
         BtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Aq4CO+ucwvp4OpOtB2Rc4m7DV25+n63yBFoirgILx5w=;
        b=g23bs53NpBAzpUm31zgrris7qFbGXLF8IrpejB6fVH45J5F2lXKNj06rd0Cs5C1PHK
         XpySI9rrTAelRU1fb5KGXhZQHmVFSrfo4H9yE2kzkwsKaklA13zWQYF+B962iw7TxLLe
         UrvMaNch6YTKerKgQv997ZG8Z10UjnG5aT0ajJUJPm8nLtdhOOmT+B64NWsC81ntsqcU
         CQ3AGmM8QhxaZKE4P1xOhU2sZA8zCD+ONJ+uSp2BkNQs1unwoqs+HowAH+6+GbmiiY7l
         /sVmFZ257eBoSsp5eZ6pj2ydpDwrEgUHyBSVvMmitzLEysPoaZ1yvFxBEvILi449n9fO
         FPJw==
X-Gm-Message-State: ABuFfogblel04qB3qtA9P4+yKKoURUGaauA0qjCNNZtfOEstY9bDDhuk
        WEGO9b0mCTQhKyY+FpB3VfU=
X-Google-Smtp-Source: ACcGV61FA0kYdolN0m2DJZiG4dAdkFVLa0Ufsv78cw9a0N4hwm9822fuUbeaC+TNjDqPK5tg5aQ1mQ==
X-Received: by 2002:a5d:68d0:: with SMTP id p16-v6mr1806495wrw.47.1539268350533;
        Thu, 11 Oct 2018 07:32:30 -0700 (PDT)
Received: from [10.32.181.140] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id t194-v6sm25891223wmd.48.2018.10.11.07.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 07:32:29 -0700 (PDT)
Subject: Re: kernel BUG at arch/x86/kvm/x86.c:LINE! (2)
To:     Du Changbin <duchangbin3@huawei.com>,
        syzbot <syzbot+f9b42efadea9f5453100@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, changbin.du@huawei.com,
        Dmitry Vyukov <dvyukov@google.com>
References: <0000000000004ab2c40577db2115@google.com>
 <c4d02cc1-0298-533d-bc07-bb4195c2eea9@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <44d8f927-85bb-cde5-1ddc-93da5ea048ae@redhat.com>
Date:   Thu, 11 Oct 2018 16:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c4d02cc1-0298-533d-bc07-bb4195c2eea9@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 04:57, Du Changbin wrote:
> I think the issue is that using vmx instructions after vmx off. The
> scenario is:
> 1. kernel is rebooting and vmx is turned off by notification handler
> kvm_reboot(),
>    and 'kvm_rebooting' is set.
> 2. But there is a pending KVM_CREATE_VCPU ioctl which will invoke
> vmcs_clear()->
>    ____kvm_handle_fault_on_reboot()->kvm_spurious_fault()->BUG().
> 
> Need to improve the handler for such case so won't hang kernel.

Why would the kernel be rebooting, given the reproducer (listed below my
signature, or at https://syzkaller.appspot.com/x/repro.c?x=131e37c9400000)?

I think this is a duplicate of

   WARNING: refcount bug in kvm_vm_ioctl
   BUG: unable to handle kernel paging request in
refcount_inc_not_zero_checked

In all cases the refcounts seem to be broken, and kvm_destroy_kvm is
called prematurely (which in this case results in hardware_disable_all
being called, so that the vmclear fails).

Dmitry, have such bugs been reported for subsystems other than KVM?

Paolo

#syz dup: WARNING: refcount bug in kvm_vm_ioctl

> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> #{"threaded":true,"repeat":true,"procs":6,"sandbox":"","fault_call":-1,"tmpdir":true}
> r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000080)='/dev/kvm\x00', 0x0, 0x0)
> r1 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)
> r2 = ioctl$KVM_CREATE_VCPU(r1, 0xae41, 0x0)
> ioctl$KVM_SET_VCPU_EVENTS(r2, 0x4040aea0, &(0x7f0000000000)={0x5, 0x7, 0x40, 0x0, 0x0, 0x0, 0x0, 0x492, 0x5, 0x1, 0xffff, 0x0, 0x0, 0xef, 0x100000000, 0x0, 0x100})
> ioctl$KVM_SET_USER_MEMORY_REGION(r1, 0x4020ae46, &(0x7f0000000040)={0x0, 0x0, 0x0, 0x2000, &(0x7f0000ffe000/0x2000)=nil})
> ioctl$KVM_SET_SREGS(r2, 0x4138ae84, &(0x7f00000003c0)={{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, 0x8005001f, 0x0, 0x0, 0x28, 0x0, 0x6500})
> ioctl$KVM_RUN(r2, 0xae80, 0x0)
