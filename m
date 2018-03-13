Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+bh2n/x4dhNN0Qo+R6y+v2998XA1Au0uQY5zWPfXYZTiMyQBtBC3WrDOsG919sKrYfebE
ARC-Seal: i=1; a=rsa-sha256; t=1520955205; cv=none;
        d=google.com; s=arc-20160816;
        b=PFALB3M9qCCiFBsQndBAwdu3n1+CK5hAxrHLnDkFFef4kkNmO1payqi7Lz3p4LzslK
         3rDjfjaZG7d4Xf/PWVcZeGE/UvBvDl01W6WATiMHodUiQQN7EocgB1bI8DuSHXgOHZgY
         QKEbsxUAQUXW4xwjaZzJ7wzSYYx9yzrLRgfwW2wA4l90m+/O0tlPmEnuoAJ6ff2uO81c
         AS9U7OX4kXD+1cm4DT7ai7LoVWKDdkV3TK+2jyUxw7c4cOBiMF3LrpuhotulK7+EEne8
         IsUCpqBpy4OYoyuesIuz6/QElfgMD2e0sJf+wML00/j/ztxFiwlD7vC8KxVXaey4E+/p
         ivnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AgjtkANxet+SrELAK+SeGmPWldHESCAeJcEehZdZxvg=;
        b=O+VNel1gR+L9rDBd+WLDE17TnoFQDdpcFHM+sF5cJk3GJyISNAZKV61WQq07DqN0sj
         Ux9Z5aFTVY+qgCfDNpfmOyvdJysbuhXQX02WBSzbP5cA8RGyJz2Qyxuyrnrn+MqOSZCo
         Clv3ZL7bkeXWP9GSLRf/+uSVGExJ9LCwn+5xbvgDp6FMAsIwcZtlER36+bRrR8pWAeOK
         tME4Jd6hMzr2zl1KsnLHIwbTePea1IsauzdYeIT45qbU6pIemjTvFSVc/8MnQBL3dgYv
         r/tyHaTKW2tHLcgTSIo/N2HXAyPBbLKu8KHS35r6rvxsPzOWoIlB1ZS36sK3AcH13CHM
         nLGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Prarit Bhargava <prarit@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 4.15 123/146] x86/xen: Calculate __max_logical_packages on PV domains
Date: Tue, 13 Mar 2018 16:24:50 +0100
Message-Id: <20180313152329.734294228@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837126147365336?=
X-GMAIL-MSGID: =?utf-8?q?1594837126147365336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prarit Bhargava <prarit@redhat.com>

commit 63e708f826bb21470155d37b103a75d8a9e25b18 upstream.

The kernel panics on PV domains because native_smp_cpus_done() is
only called for HVM domains.

Calculate __max_logical_packages for PV domains.

Fixes: b4c0a7326f5d ("x86/smpboot: Fix __max_logical_packages estimate")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Tested-and-reported-by: Simon Gaiser <simon@invisiblethingslab.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: xen-devel@lists.xenproject.org
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/smp.h |    1 +
 arch/x86/kernel/smpboot.c  |   10 ++++++++--
 arch/x86/xen/smp.c         |    2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -129,6 +129,7 @@ static inline void arch_send_call_functi
 void cpu_disable_common(void);
 void native_smp_prepare_boot_cpu(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
+void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
 void common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1282,11 +1282,10 @@ void __init native_smp_prepare_boot_cpu(
 	cpu_set_state_online(me);
 }
 
-void __init native_smp_cpus_done(unsigned int max_cpus)
+void __init calculate_max_logical_packages(void)
 {
 	int ncpus;
 
-	pr_debug("Boot done\n");
 	/*
 	 * Today neither Intel nor AMD support heterogenous systems so
 	 * extrapolate the boot cpu's data to all packages.
@@ -1294,6 +1293,13 @@ void __init native_smp_cpus_done(unsigne
 	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
 	__max_logical_packages = DIV_ROUND_UP(nr_cpu_ids, ncpus);
 	pr_info("Max logical packages: %u\n", __max_logical_packages);
+}
+
+void __init native_smp_cpus_done(unsigned int max_cpus)
+{
+	pr_debug("Boot done\n");
+
+	calculate_max_logical_packages();
 
 	if (x86_has_numa_in_package)
 		set_sched_topology(x86_numa_in_package_topology);
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -122,6 +122,8 @@ void __init xen_smp_cpus_done(unsigned i
 
 	if (xen_hvm_domain())
 		native_smp_cpus_done(max_cpus);
+	else
+		calculate_max_logical_packages();
 
 	if (xen_have_vcpu_info_placement)
 		return;
