Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965365AbeE2RGe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:06:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964848AbeE2RGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:06:31 -0400
Subject: Re: [PATCH] kvm: no need to check return value of debugfs_create
 functions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kvm@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Eric Auger <eric.auger@redhat.com>,
        Andre Przywara <andre.przywara@arm.com>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
References: <20180529162204.11757-1-gregkh@linuxfoundation.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <46079df1-2ebf-7ddb-582a-9f644a7802a0@redhat.com>
Date: Tue, 29 May 2018 19:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529162204.11757-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2018 18:22, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> This cleans up the error handling a lot, as this code will never get
> hit.
> 
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: kvm-ppc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: kvm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/powerpc/kvm/book3s_hv.c   |  3 +--
>  virt/kvm/arm/vgic/vgic-debug.c | 17 ++++-----------
>  virt/kvm/arm/vgic/vgic.h       |  4 ++--
>  virt/kvm/kvm_main.c            | 40 +++++++---------------------------
>  4 files changed, 15 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 4d07fca5121c..67d7de1470cc 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3950,8 +3950,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
>  	 */
>  	snprintf(buf, sizeof(buf), "vm%d", current->pid);
>  	kvm->arch.debugfs_dir = debugfs_create_dir(buf, kvm_debugfs_dir);
> -	if (!IS_ERR_OR_NULL(kvm->arch.debugfs_dir))
> -		kvmppc_mmu_debugfs_init(kvm);
> +	kvmppc_mmu_debugfs_init(kvm);
>  
>  	return 0;
>  }
> diff --git a/virt/kvm/arm/vgic/vgic-debug.c b/virt/kvm/arm/vgic/vgic-debug.c
> index 10b38178cff2..0140b29079b6 100644
> --- a/virt/kvm/arm/vgic/vgic-debug.c
> +++ b/virt/kvm/arm/vgic/vgic-debug.c
> @@ -263,21 +263,12 @@ static const struct file_operations vgic_debug_fops = {
>  	.release = seq_release
>  };
>  
> -int vgic_debug_init(struct kvm *kvm)
> +void vgic_debug_init(struct kvm *kvm)
>  {
> -	if (!kvm->debugfs_dentry)
> -		return -ENOENT;
> -
> -	if (!debugfs_create_file("vgic-state", 0444,
> -				 kvm->debugfs_dentry,
> -				 kvm,
> -				 &vgic_debug_fops))
> -		return -ENOMEM;
> -
> -	return 0;
> +	debugfs_create_file("vgic-state", 0444, kvm->debugfs_dentry, kvm,
> +			    &vgic_debug_fops);
>  }
>  
> -int vgic_debug_destroy(struct kvm *kvm)
> +void vgic_debug_destroy(struct kvm *kvm)
>  {
> -	return 0;
>  }
> diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
> index 830e815748a0..3c38c5349953 100644
> --- a/virt/kvm/arm/vgic/vgic.h
> +++ b/virt/kvm/arm/vgic/vgic.h
> @@ -229,8 +229,8 @@ void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>  int vgic_lazy_init(struct kvm *kvm);
>  int vgic_init(struct kvm *kvm);
>  
> -int vgic_debug_init(struct kvm *kvm);
> -int vgic_debug_destroy(struct kvm *kvm);
> +void vgic_debug_init(struct kvm *kvm);
> +void vgic_debug_destroy(struct kvm *kvm);
>  
>  bool lock_all_vcpus(struct kvm *kvm);
>  void unlock_all_vcpus(struct kvm *kvm);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c7b2e927f699..0ad400f353fc 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -572,10 +572,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
>  		return 0;
>  
>  	snprintf(dir_name, sizeof(dir_name), "%d-%d", task_pid_nr(current), fd);
> -	kvm->debugfs_dentry = debugfs_create_dir(dir_name,
> -						 kvm_debugfs_dir);
> -	if (!kvm->debugfs_dentry)
> -		return -ENOMEM;
> +	kvm->debugfs_dentry = debugfs_create_dir(dir_name, kvm_debugfs_dir);
>  
>  	kvm->debugfs_stat_data = kcalloc(kvm_debugfs_num_entries,
>  					 sizeof(*kvm->debugfs_stat_data),
> @@ -591,11 +588,8 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
>  		stat_data->kvm = kvm;
>  		stat_data->offset = p->offset;
>  		kvm->debugfs_stat_data[p - debugfs_entries] = stat_data;
> -		if (!debugfs_create_file(p->name, 0644,
> -					 kvm->debugfs_dentry,
> -					 stat_data,
> -					 stat_fops_per_vm[p->kind]))
> -			return -ENOMEM;
> +		debugfs_create_file(p->name, 0644, kvm->debugfs_dentry,
> +				    stat_data, stat_fops_per_vm[p->kind]);
>  	}
>  	return 0;
>  }
> @@ -3896,29 +3890,18 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>  	kfree(env);
>  }
>  
> -static int kvm_init_debug(void)
> +static void kvm_init_debug(void)
>  {
> -	int r = -EEXIST;
>  	struct kvm_stats_debugfs_item *p;
>  
>  	kvm_debugfs_dir = debugfs_create_dir("kvm", NULL);
> -	if (kvm_debugfs_dir == NULL)
> -		goto out;
>  
>  	kvm_debugfs_num_entries = 0;
>  	for (p = debugfs_entries; p->name; ++p, kvm_debugfs_num_entries++) {
> -		if (!debugfs_create_file(p->name, 0644, kvm_debugfs_dir,
> -					 (void *)(long)p->offset,
> -					 stat_fops[p->kind]))
> -			goto out_dir;
> +		debugfs_create_file(p->name, 0644, kvm_debugfs_dir,
> +				    (void *)(long)p->offset,
> +				    stat_fops[p->kind]);
>  	}
> -
> -	return 0;
> -
> -out_dir:
> -	debugfs_remove_recursive(kvm_debugfs_dir);
> -out:
> -	return r;
>  }
>  
>  static int kvm_suspend(void)
> @@ -4046,20 +4029,13 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
>  	kvm_preempt_ops.sched_in = kvm_sched_in;
>  	kvm_preempt_ops.sched_out = kvm_sched_out;
>  
> -	r = kvm_init_debug();
> -	if (r) {
> -		pr_err("kvm: create debugfs files failed\n");
> -		goto out_undebugfs;
> -	}
> +	kvm_init_debug();
>  
>  	r = kvm_vfio_ops_init();
>  	WARN_ON(r);
>  
>  	return 0;
>  
> -out_undebugfs:
> -	unregister_syscore_ops(&kvm_syscore_ops);
> -	misc_deregister(&kvm_dev);
>  out_unreg:
>  	kvm_async_pf_deinit();
>  out_free:
> 

Queued, thanks.

Paolo
