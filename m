Return-Path: <borntraeger@de.ibm.com>
X-Google-Smtp-Source: AB8JxZoPa/tMgNGzIXDRFvzo0T0t3aH7y9rqnoyR6uHugc5Zj/2UhYM/AInQ/GCcEeyIUDe5dYcq
ARC-Seal: i=1; a=rsa-sha256; t=1524841812; cv=none;
        d=google.com; s=arc-20160816;
        b=hYIAykS4AwW3xMxzQc/O2iVOD/P3hPC0jQpzpVlE2Dl6eTEuiNcBz7zWmuwD95VgHl
         1QrY+4H7828V3li5jdH60jIn3By8X44M3U/jeFsuzRn5KUy5uypRr70wfImb5fQtquFh
         +WG9Lc6q51CqXhOC1h68U7zWj2Lut8igFwVa3GXl+bm+uNb+vvkbI7fWdC3gxxYtWxFl
         Q9HISqnetcZsqw0G1klN+N6q9iByipt0YwBP+K54tSoaqDsKF9/nJPgxrfGBUVo9mQpL
         KCNxC5QBrYpyCqoQj8vj7uG6vLukAzZFERqqhaeBEsPrwQsiLi/03AV+FSpgKQWyNpNF
         dJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:openpgp:from:references:cc:to:subject
         :arc-authentication-results;
        bh=GhuM+DiOn4EWWPdXjF763JQScHnYSE/wA3BRWu3v7ro=;
        b=RrZrnvs3FSAzOen21uTiE+uxO/c5/ZF9t5jUDaqIh9/Np5ZPT817ee1KJZKdmW6Wh9
         dPgUtVeKz9XM2oxm/VNZIpouxs+WxPaWQPkXwfNOWeiXWWAhnxquDcFBfIecFNq9Xuvq
         KkKvaEDoqQc860XlpAWRJhebfyxqYzR/9/vrc2zTbaMhk2dv9QQZI2usoATLkBEbLyp4
         uuKSG1Tu4yKbJN5BXrKTwKPjYPwXFOciH+GpyN4mqGyNv3qQi62UMeCStsGIz/Mxo6/l
         /t8l1ARQl24juFPEeSwTc0RbGP6xDpzeS3iZ+flQYSSLacNYxj9rvi6hzbW7Y6uAEk7V
         Z/cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 4.4 12/50] KVM: s390: wire up bpb feature
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180427135655.623669681@linuxfoundation.org>
 <20180427135656.428437126@linuxfoundation.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Date: Fri, 27 Apr 2018 17:10:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180427135656.428437126@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042715-0040-0000-0000-00000452C5EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042715-0041-0000-0000-000020F6D406
Message-Id: <2764478b-8acb-653b-779f-1fb51d9a5931@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270145
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598908252112326742?=
X-GMAIL-MSGID: =?utf-8?q?1598912527950807208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/27/2018 03:58 PM, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> 
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> [ Upstream commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60 ]
> 
> The new firmware interfaces for branch prediction behaviour changes
> are transparently available for the guest. Nevertheless, there is
> new state attached that should be migrated and properly resetted.
> Provide a mechanism for handling reset, migration and VSIE.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [Changed capability number to 152. - Radim]
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Something went wrong during the backport of this to 4.4

[...]
> ---
>  arch/s390/include/asm/kvm_host.h |    3 ++-
>  arch/s390/include/uapi/asm/kvm.h |    3 +++
>  arch/s390/kvm/kvm-s390.c         |   13 ++++++++++++-
>  include/uapi/linux/kvm.h         |    1 +
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -1286,7 +1291,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu
>  	if (test_fp_ctl(current->thread.fpu.fpc))
>  		/* User space provided an invalid FPC, let's clear it */
>  		current->thread.fpu.fpc = 0;
> -

unrelated whitespace change

>  	save_access_regs(vcpu->arch.host_acrs);
>  	restore_access_regs(vcpu->run->s.regs.acrs);
>  	gmap_enable(vcpu->arch.gmap);
> @@ -1327,6 +1331,7 @@ static void kvm_s390_vcpu_initial_reset(
>  	current->thread.fpu.fpc = 0;
>  	vcpu->arch.sie_block->gbea = 1;
>  	vcpu->arch.sie_block->pp = 0;
> +	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>  	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
>  	kvm_clear_async_pf_completion_queue(vcpu);
>  	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
> @@ -2162,6 +2167,7 @@ static void store_regs(struct kvm_vcpu *
>  	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
>  	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
>  	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
> +	kvm_run->s.regs.bpbc = (vcpu->arch.sie_block->fpf & FPF_BPBC) == FPF_BPBC;
>  }
>  
>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> @@ -2194,6 +2200,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
>  		kvm_run->exit_reason = KVM_EXIT_INTR;
>  		rc = -EINTR;
>  	}
> +	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_BPBC) &&
> +	    test_kvm_facility(vcpu->kvm, 82)) {
> +		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
> +		vcpu->arch.sie_block->fpf |= kvm_run->s.regs.bpbc ? FPF_BPBC : 0;
> +	}
>  


This looks misplaced and should go into the sync_regs function.
