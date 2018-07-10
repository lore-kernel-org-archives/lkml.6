Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EA1C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345C52098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345C52098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeGJWNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:13:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:19795 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbeGJWNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:13:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 15:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,335,1526367600"; 
   d="scan'208";a="214978086"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2018 15:11:36 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fd0rA-000H3f-1f; Wed, 11 Jul 2018 06:11:36 +0800
Date:   Wed, 11 Jul 2018 06:11:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] KVM: Add coalesced PIO support
Message-ID: <201807110536.hM9HI7QB%fengguang.wu@intel.com>
References: <1531216516-19623-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531216516-19623-1-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wanpeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvm/linux-next]
[also build test WARNING on v4.18-rc4 next-20180710]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wanpeng-Li/KVM-Add-coalesced-PIO-support/20180710-182037
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/trace/events/kvm.h:213:1: sparse: expression using sizeof(void)
   include/trace/events/kvm.h:213:1: sparse: expression using sizeof(void)
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2767:57: sparse: cast removes address space of expression
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2767:57: sparse: incorrect type in argument 2 (different address spaces) @@    expected struct compat_sigset_t const [noderef] [usertype] <asn:1>*compat @@    got sn:1>*compat @@
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2767:57:    expected struct compat_sigset_t const [noderef] [usertype] <asn:1>*compat
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2767:57:    got void *<noident>
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2939:14: sparse: undefined identifier 'KVM_CAP_COALESCED_PIO'
>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:2939:14: sparse: incompatible types for 'case' statement
   include/linux/overflow.h:220:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/overflow.h:220:13: sparse: incorrect type in conditional
   include/linux/overflow.h:220:13:    got void
   include/linux/slab.h:631:13: sparse: call with no type!
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2939:14: sparse: Expected constant expression in case statement
   arch/x86/kvm/../../../virt/kvm/kvm_main.c: In function 'kvm_vm_ioctl_check_extension_generic':
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2939:7: error: 'KVM_CAP_COALESCED_PIO' undeclared (first use in this function); did you mean 'KVM_CAP_COALESCED_MMIO'?
     case KVM_CAP_COALESCED_PIO:
          ^~~~~~~~~~~~~~~~~~~~~
          KVM_CAP_COALESCED_MMIO
   arch/x86/kvm/../../../virt/kvm/kvm_main.c:2939:7: note: each undeclared identifier is reported only once for each function it appears in

vim +/case +2939 arch/x86/kvm/../../../virt/kvm/kvm_main.c

  2740	
  2741	#ifdef CONFIG_KVM_COMPAT
  2742	static long kvm_vcpu_compat_ioctl(struct file *filp,
  2743					  unsigned int ioctl, unsigned long arg)
  2744	{
  2745		struct kvm_vcpu *vcpu = filp->private_data;
  2746		void __user *argp = compat_ptr(arg);
  2747		int r;
  2748	
  2749		if (vcpu->kvm->mm != current->mm)
  2750			return -EIO;
  2751	
  2752		switch (ioctl) {
  2753		case KVM_SET_SIGNAL_MASK: {
  2754			struct kvm_signal_mask __user *sigmask_arg = argp;
  2755			struct kvm_signal_mask kvm_sigmask;
  2756			sigset_t sigset;
  2757	
  2758			if (argp) {
  2759				r = -EFAULT;
  2760				if (copy_from_user(&kvm_sigmask, argp,
  2761						   sizeof(kvm_sigmask)))
  2762					goto out;
  2763				r = -EINVAL;
  2764				if (kvm_sigmask.len != sizeof(compat_sigset_t))
  2765					goto out;
  2766				r = -EFAULT;
> 2767				if (get_compat_sigset(&sigset, (void *)sigmask_arg->sigset))
  2768					goto out;
  2769				r = kvm_vcpu_ioctl_set_sigmask(vcpu, &sigset);
  2770			} else
  2771				r = kvm_vcpu_ioctl_set_sigmask(vcpu, NULL);
  2772			break;
  2773		}
  2774		default:
  2775			r = kvm_vcpu_ioctl(filp, ioctl, arg);
  2776		}
  2777	
  2778	out:
  2779		return r;
  2780	}
  2781	#endif
  2782	
  2783	static int kvm_device_ioctl_attr(struct kvm_device *dev,
  2784					 int (*accessor)(struct kvm_device *dev,
  2785							 struct kvm_device_attr *attr),
  2786					 unsigned long arg)
  2787	{
  2788		struct kvm_device_attr attr;
  2789	
  2790		if (!accessor)
  2791			return -EPERM;
  2792	
  2793		if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
  2794			return -EFAULT;
  2795	
  2796		return accessor(dev, &attr);
  2797	}
  2798	
  2799	static long kvm_device_ioctl(struct file *filp, unsigned int ioctl,
  2800				     unsigned long arg)
  2801	{
  2802		struct kvm_device *dev = filp->private_data;
  2803	
  2804		switch (ioctl) {
  2805		case KVM_SET_DEVICE_ATTR:
  2806			return kvm_device_ioctl_attr(dev, dev->ops->set_attr, arg);
  2807		case KVM_GET_DEVICE_ATTR:
  2808			return kvm_device_ioctl_attr(dev, dev->ops->get_attr, arg);
  2809		case KVM_HAS_DEVICE_ATTR:
  2810			return kvm_device_ioctl_attr(dev, dev->ops->has_attr, arg);
  2811		default:
  2812			if (dev->ops->ioctl)
  2813				return dev->ops->ioctl(dev, ioctl, arg);
  2814	
  2815			return -ENOTTY;
  2816		}
  2817	}
  2818	
  2819	static int kvm_device_release(struct inode *inode, struct file *filp)
  2820	{
  2821		struct kvm_device *dev = filp->private_data;
  2822		struct kvm *kvm = dev->kvm;
  2823	
  2824		kvm_put_kvm(kvm);
  2825		return 0;
  2826	}
  2827	
  2828	static const struct file_operations kvm_device_fops = {
  2829		.unlocked_ioctl = kvm_device_ioctl,
  2830		.release = kvm_device_release,
  2831		KVM_COMPAT(kvm_device_ioctl),
  2832	};
  2833	
  2834	struct kvm_device *kvm_device_from_filp(struct file *filp)
  2835	{
  2836		if (filp->f_op != &kvm_device_fops)
  2837			return NULL;
  2838	
  2839		return filp->private_data;
  2840	}
  2841	
  2842	static struct kvm_device_ops *kvm_device_ops_table[KVM_DEV_TYPE_MAX] = {
  2843	#ifdef CONFIG_KVM_MPIC
  2844		[KVM_DEV_TYPE_FSL_MPIC_20]	= &kvm_mpic_ops,
  2845		[KVM_DEV_TYPE_FSL_MPIC_42]	= &kvm_mpic_ops,
  2846	#endif
  2847	};
  2848	
  2849	int kvm_register_device_ops(struct kvm_device_ops *ops, u32 type)
  2850	{
  2851		if (type >= ARRAY_SIZE(kvm_device_ops_table))
  2852			return -ENOSPC;
  2853	
  2854		if (kvm_device_ops_table[type] != NULL)
  2855			return -EEXIST;
  2856	
  2857		kvm_device_ops_table[type] = ops;
  2858		return 0;
  2859	}
  2860	
  2861	void kvm_unregister_device_ops(u32 type)
  2862	{
  2863		if (kvm_device_ops_table[type] != NULL)
  2864			kvm_device_ops_table[type] = NULL;
  2865	}
  2866	
  2867	static int kvm_ioctl_create_device(struct kvm *kvm,
  2868					   struct kvm_create_device *cd)
  2869	{
  2870		struct kvm_device_ops *ops = NULL;
  2871		struct kvm_device *dev;
  2872		bool test = cd->flags & KVM_CREATE_DEVICE_TEST;
  2873		int ret;
  2874	
  2875		if (cd->type >= ARRAY_SIZE(kvm_device_ops_table))
  2876			return -ENODEV;
  2877	
  2878		ops = kvm_device_ops_table[cd->type];
  2879		if (ops == NULL)
  2880			return -ENODEV;
  2881	
  2882		if (test)
  2883			return 0;
  2884	
  2885		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
  2886		if (!dev)
  2887			return -ENOMEM;
  2888	
  2889		dev->ops = ops;
  2890		dev->kvm = kvm;
  2891	
  2892		mutex_lock(&kvm->lock);
  2893		ret = ops->create(dev, cd->type);
  2894		if (ret < 0) {
  2895			mutex_unlock(&kvm->lock);
  2896			kfree(dev);
  2897			return ret;
  2898		}
  2899		list_add(&dev->vm_node, &kvm->devices);
  2900		mutex_unlock(&kvm->lock);
  2901	
  2902		if (ops->init)
  2903			ops->init(dev);
  2904	
  2905		ret = anon_inode_getfd(ops->name, &kvm_device_fops, dev, O_RDWR | O_CLOEXEC);
  2906		if (ret < 0) {
  2907			mutex_lock(&kvm->lock);
  2908			list_del(&dev->vm_node);
  2909			mutex_unlock(&kvm->lock);
  2910			ops->destroy(dev);
  2911			return ret;
  2912		}
  2913	
  2914		kvm_get_kvm(kvm);
  2915		cd->fd = ret;
  2916		return 0;
  2917	}
  2918	
  2919	static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
  2920	{
  2921		switch (arg) {
  2922		case KVM_CAP_USER_MEMORY:
  2923		case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
  2924		case KVM_CAP_JOIN_MEMORY_REGIONS_WORKS:
  2925		case KVM_CAP_INTERNAL_ERROR_DATA:
  2926	#ifdef CONFIG_HAVE_KVM_MSI
  2927		case KVM_CAP_SIGNAL_MSI:
  2928	#endif
  2929	#ifdef CONFIG_HAVE_KVM_IRQFD
  2930		case KVM_CAP_IRQFD:
  2931		case KVM_CAP_IRQFD_RESAMPLE:
  2932	#endif
  2933		case KVM_CAP_IOEVENTFD_ANY_LENGTH:
  2934		case KVM_CAP_CHECK_EXTENSION_VM:
  2935			return 1;
  2936	#ifdef CONFIG_KVM_MMIO
  2937		case KVM_CAP_COALESCED_MMIO:
  2938			return KVM_COALESCED_MMIO_PAGE_OFFSET;
> 2939		case KVM_CAP_COALESCED_PIO:
  2940			return KVM_PIO_PAGE_OFFSET;
  2941	#endif
  2942	#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
  2943		case KVM_CAP_IRQ_ROUTING:
  2944			return KVM_MAX_IRQ_ROUTES;
  2945	#endif
  2946	#if KVM_ADDRESS_SPACE_NUM > 1
  2947		case KVM_CAP_MULTI_ADDRESS_SPACE:
  2948			return KVM_ADDRESS_SPACE_NUM;
  2949	#endif
  2950		case KVM_CAP_MAX_VCPU_ID:
  2951			return KVM_MAX_VCPU_ID;
  2952		default:
  2953			break;
  2954		}
  2955		return kvm_vm_ioctl_check_extension(kvm, arg);
  2956	}
  2957	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
