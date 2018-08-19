Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C9C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770F920C10
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770F920C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeHSVHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 17:07:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:11043 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeHSVHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 17:07:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2018 10:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,261,1531810800"; 
   d="gz'50?scan'50,208,50";a="78200049"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2018 10:55:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1frRvK-0002ys-Os; Mon, 20 Aug 2018 01:55:34 +0800
Date:   Mon, 20 Aug 2018 01:55:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sedat Dilek <sedat.dilek@credativ.de>
Cc:     kbuild-all@01.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@credativ.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Message-ID: <201808200122.U9ZygZvJ%fengguang.wu@intel.com>
References: <20180819134540.8653-1-sedat.dilek@credativ.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20180819134540.8653-1-sedat.dilek@credativ.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sedat,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on v4.18 next-20180817]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sedat-Dilek/i2c-Remove-Wno-deprecated-declarations-compiler-warning/20180819-222255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: i386-randconfig-x016-201833 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers//i2c/i2c-core-base.c: In function 'i2c_do_add_adapter':
   drivers//i2c/i2c-core-base.c:1128:2: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
     if (driver->attach_adapter) {
     ^~
   In file included from drivers//i2c/i2c-core-base.c:31:0:
   include/linux/i2c.h:274:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   drivers//i2c/i2c-core-base.c:1128:2: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
     if (driver->attach_adapter) {
     ^~
   In file included from drivers//i2c/i2c-core-base.c:31:0:
   include/linux/i2c.h:274:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/acpi.h:25,
                    from drivers//i2c/i2c-core-base.c:24:
>> include/linux/compiler.h:61:17: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
      static struct ftrace_branch_data   \
                    ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
>> drivers//i2c/i2c-core-base.c:1128:2: note: in expansion of macro 'if'
     if (driver->attach_adapter) {
     ^~
   In file included from drivers//i2c/i2c-core-base.c:31:0:
   include/linux/i2c.h:274:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   drivers//i2c/i2c-core-base.c:1134:3: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
      driver->attach_adapter(adap);
      ^~~~~~
   In file included from drivers//i2c/i2c-core-base.c:31:0:
   include/linux/i2c.h:274:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_read
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_write
   Cyclomatic Complexity 1 include/linux/ioport.h:resource_type
   Cyclomatic Complexity 3 arch/x86/include/asm/bitops.h:clear_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:variable_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u32
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 1 include/linux/list.h:__list_add_valid
   Cyclomatic Complexity 1 include/linux/list.h:__list_del_entry_valid
   Cyclomatic Complexity 2 include/linux/list.h:__list_add
   Cyclomatic Complexity 1 include/linux/list.h:list_add_tail
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
   Cyclomatic Complexity 1 include/linux/list.h:list_del
   Cyclomatic Complexity 1 include/linux/list.h:hlist_empty
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_check
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_test_cpu
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_read
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_inc
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_dec
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_read
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_inc
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_dec
   Cyclomatic Complexity 1 include/linux/jump_label.h:static_key_count
   Cyclomatic Complexity 2 include/linux/jump_label.h:static_key_false
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_save_flags
   Cyclomatic Complexity 1 arch/x86/include/asm/irqflags.h:arch_irqs_disabled_flags
   Cyclomatic Complexity 1 arch/x86/include/asm/preempt.h:preempt_count
   Cyclomatic Complexity 7 arch/x86/include/asm/preempt.h:__preempt_count_add
   Cyclomatic Complexity 7 arch/x86/include/asm/preempt.h:__preempt_count_sub
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_read_lock_sched_notrace
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_read_unlock_sched_notrace
   Cyclomatic Complexity 56 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 67 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 9 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 1 include/linux/pm_wakeup.h:device_set_wakeup_capable
   Cyclomatic Complexity 1 include/linux/pm_wakeup.h:device_set_wakeup_enable
   Cyclomatic Complexity 1 include/linux/pm_wakeup.h:device_init_wakeup
   Cyclomatic Complexity 1 include/linux/acpi.h:acpi_device_clear_enumerated
   Cyclomatic Complexity 1 include/linux/of.h:of_node_clear_flag
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_lock_bus
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_trylock_bus
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_unlock_bus
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_get_functionality
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_check_functionality
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_adapter_id
   Cyclomatic Complexity 1 include/linux/irq.h:irqd_set_trigger_type
   Cyclomatic Complexity 1 include/linux/pm_domain.h:dev_pm_domain_attach
   Cyclomatic Complexity 1 include/linux/pm_domain.h:dev_pm_domain_detach
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_enable
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:__pm_runtime_disable
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_suspend_ignore_children
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_no_callbacks
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_disable
   Cyclomatic Complexity 1 include/linux/pm_wakeirq.h:dev_pm_set_wake_irq
   Cyclomatic Complexity 1 include/linux/pm_wakeirq.h:dev_pm_set_dedicated_wake_irq
   Cyclomatic Complexity 1 include/linux/pm_wakeirq.h:dev_pm_clear_wake_irq
   Cyclomatic Complexity 1 drivers//i2c/i2c-core.h:i2c_acpi_install_space_handler
   Cyclomatic Complexity 1 drivers//i2c/i2c-core.h:i2c_acpi_remove_space_handler
   Cyclomatic Complexity 1 include/linux/trace_events.h:bpf_prog_array_valid
   Cyclomatic Complexity 1 include/trace/events/i2c.h:trace_event_get_offsets_i2c_write
   Cyclomatic Complexity 1 include/trace/events/i2c.h:trace_event_get_offsets_i2c_read
   Cyclomatic Complexity 1 include/trace/events/i2c.h:trace_event_get_offsets_i2c_reply
   Cyclomatic Complexity 1 include/trace/events/i2c.h:trace_event_get_offsets_i2c_result
   Cyclomatic Complexity 1 drivers//i2c/i2c-core-base.c:dummy_probe
   Cyclomatic Complexity 1 drivers//i2c/i2c-core-base.c:dummy_remove
   Cyclomatic Complexity 11 include/trace/events/i2c.h:trace_event_define_fields_i2c_write
   Cyclomatic Complexity 11 include/trace/events/i2c.h:trace_event_define_fields_i2c_read
   Cyclomatic Complexity 11 include/trace/events/i2c.h:trace_event_define_fields_i2c_reply
   Cyclomatic Complexity 7 include/trace/events/i2c.h:trace_event_define_fields_i2c_result
   Cyclomatic Complexity 8 drivers//i2c/i2c-core-base.c:i2c_generic_bus_free
   Cyclomatic Complexity 7 drivers//i2c/i2c-core-base.c:i2c_check_addr_validity
   Cyclomatic Complexity 5 drivers//i2c/i2c-core-base.c:i2c_encode_flags_to_addr
   Cyclomatic Complexity 3 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/acpi.h:acpi_dev_name
   Cyclomatic Complexity 1 arch/x86/include/asm/stacktrace.h:caller_frame_pointer
   Cyclomatic Complexity 1 include/linux/perf_event.h:perf_fetch_caller_regs
   Cyclomatic Complexity 8 include/trace/events/i2c.h:perf_trace_i2c_write
   Cyclomatic Complexity 8 include/trace/events/i2c.h:perf_trace_i2c_read
   Cyclomatic Complexity 8 include/trace/events/i2c.h:perf_trace_i2c_reply
   Cyclomatic Complexity 8 include/trace/events/i2c.h:perf_trace_i2c_result
--
   drivers/i2c/i2c-core-base.c: In function 'i2c_do_add_adapter':
   drivers/i2c/i2c-core-base.c:1128:2: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
     if (driver->attach_adapter) {
     ^~
   In file included from drivers/i2c/i2c-core-base.c:31:0:
   include/linux/i2c.h:274:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   drivers/i2c/i2c-core-base.c:1128:2: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
     if (driver->attach_adapter) {
     ^~
   In file included from drivers/i2c/i2c-core-base.c:31:0:
   include/linux/i2c.h:274:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/acpi.h:25,
                    from drivers/i2c/i2c-core-base.c:24:
>> include/linux/compiler.h:61:17: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
      static struct ftrace_branch_data   \
                    ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   drivers/i2c/i2c-core-base.c:1128:2: note: in expansion of macro 'if'
     if (driver->attach_adapter) {
     ^~
   In file included from drivers/i2c/i2c-core-base.c:31:0:
   include/linux/i2c.h:274:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   drivers/i2c/i2c-core-base.c:1134:3: warning: 'attach_adapter' is deprecated [-Wdeprecated-declarations]
      driver->attach_adapter(adap);
      ^~~~~~
   In file included from drivers/i2c/i2c-core-base.c:31:0:
   include/linux/i2c.h:274:8: note: declared here
     int (*attach_adapter)(struct i2c_adapter *) __deprecated;
           ^~~~~~~~~~~~~~
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_read
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_write
   Cyclomatic Complexity 1 include/linux/ioport.h:resource_type
   Cyclomatic Complexity 3 arch/x86/include/asm/bitops.h:clear_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:variable_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u32
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 1 include/linux/list.h:__list_add_valid
   Cyclomatic Complexity 1 include/linux/list.h:__list_del_entry_valid
   Cyclomatic Complexity 2 include/linux/list.h:__list_add
   Cyclomatic Complexity 1 include/linux/list.h:list_add_tail
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
   Cyclomatic Complexity 1 include/linux/list.h:list_del
   Cyclomatic Complexity 1 include/linux/list.h:hlist_empty
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_check
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_test_cpu
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_read
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_inc
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_dec
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_read
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_inc
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_dec
   Cyclomatic Complexity 1 include/linux/jump_label.h:static_key_count
   Cyclomatic Complexity 2 include/linux/jump_label.h:static_key_false
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_save_flags
   Cyclomatic Complexity 1 arch/x86/include/asm/irqflags.h:arch_irqs_disabled_flags
   Cyclomatic Complexity 1 arch/x86/include/asm/preempt.h:preempt_count
   Cyclomatic Complexity 7 arch/x86/include/asm/preempt.h:__preempt_count_add
   Cyclomatic Complexity 7 arch/x86/include/asm/preempt.h:__preempt_count_sub
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_read_lock_sched_notrace
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_read_unlock_sched_notrace
   Cyclomatic Complexity 56 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 67 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 9 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 1 include/linux/pm_wakeup.h:device_set_wakeup_capable
   Cyclomatic Complexity 1 include/linux/pm_wakeup.h:device_set_wakeup_enable
   Cyclomatic Complexity 1 include/linux/pm_wakeup.h:device_init_wakeup
   Cyclomatic Complexity 1 include/linux/acpi.h:acpi_device_clear_enumerated
   Cyclomatic Complexity 1 include/linux/of.h:of_node_clear_flag
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_lock_bus
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_trylock_bus
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_unlock_bus
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_get_functionality
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_check_functionality
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_adapter_id
   Cyclomatic Complexity 1 include/linux/irq.h:irqd_set_trigger_type
   Cyclomatic Complexity 1 include/linux/pm_domain.h:dev_pm_domain_attach
   Cyclomatic Complexity 1 include/linux/pm_domain.h:dev_pm_domain_detach
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_enable
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:__pm_runtime_disable
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_suspend_ignore_children
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_no_callbacks
   Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_disable
   Cyclomatic Complexity 1 include/linux/pm_wakeirq.h:dev_pm_set_wake_irq
   Cyclomatic Complexity 1 include/linux/pm_wakeirq.h:dev_pm_set_dedicated_wake_irq
   Cyclomatic Complexity 1 include/linux/pm_wakeirq.h:dev_pm_clear_wake_irq
   Cyclomatic Complexity 1 drivers/i2c/i2c-core.h:i2c_acpi_install_space_handler
   Cyclomatic Complexity 1 drivers/i2c/i2c-core.h:i2c_acpi_remove_space_handler
   Cyclomatic Complexity 1 include/linux/trace_events.h:bpf_prog_array_valid
   Cyclomatic Complexity 1 include/trace/events/i2c.h:trace_event_get_offsets_i2c_write
   Cyclomatic Complexity 1 include/trace/events/i2c.h:trace_event_get_offsets_i2c_read
   Cyclomatic Complexity 1 include/trace/events/i2c.h:trace_event_get_offsets_i2c_reply
   Cyclomatic Complexity 1 include/trace/events/i2c.h:trace_event_get_offsets_i2c_result
   Cyclomatic Complexity 1 drivers/i2c/i2c-core-base.c:dummy_probe
   Cyclomatic Complexity 1 drivers/i2c/i2c-core-base.c:dummy_remove
   Cyclomatic Complexity 11 include/trace/events/i2c.h:trace_event_define_fields_i2c_write
   Cyclomatic Complexity 11 include/trace/events/i2c.h:trace_event_define_fields_i2c_read
   Cyclomatic Complexity 11 include/trace/events/i2c.h:trace_event_define_fields_i2c_reply
   Cyclomatic Complexity 7 include/trace/events/i2c.h:trace_event_define_fields_i2c_result
   Cyclomatic Complexity 8 drivers/i2c/i2c-core-base.c:i2c_generic_bus_free
   Cyclomatic Complexity 7 drivers/i2c/i2c-core-base.c:i2c_check_addr_validity
   Cyclomatic Complexity 5 drivers/i2c/i2c-core-base.c:i2c_encode_flags_to_addr
   Cyclomatic Complexity 3 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/acpi.h:acpi_dev_name

vim +/attach_adapter +61 include/linux/compiler.h

2bcd521a Steven Rostedt 2008-11-21  50  
2bcd521a Steven Rostedt 2008-11-21  51  #ifdef CONFIG_PROFILE_ALL_BRANCHES
2bcd521a Steven Rostedt 2008-11-21  52  /*
2bcd521a Steven Rostedt 2008-11-21  53   * "Define 'is'", Bill Clinton
2bcd521a Steven Rostedt 2008-11-21  54   * "Define 'if'", Steven Rostedt
2bcd521a Steven Rostedt 2008-11-21  55   */
ab3c9c68 Linus Torvalds 2009-04-07  56  #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
ab3c9c68 Linus Torvalds 2009-04-07  57  #define __trace_if(cond) \
b33c8ff4 Arnd Bergmann  2016-02-12  58  	if (__builtin_constant_p(!!(cond)) ? !!(cond) :			\
2bcd521a Steven Rostedt 2008-11-21  59  	({								\
2bcd521a Steven Rostedt 2008-11-21  60  		int ______r;						\
2bcd521a Steven Rostedt 2008-11-21 @61  		static struct ftrace_branch_data			\
2bcd521a Steven Rostedt 2008-11-21  62  			__attribute__((__aligned__(4)))			\
2bcd521a Steven Rostedt 2008-11-21  63  			__attribute__((section("_ftrace_branch")))	\
2bcd521a Steven Rostedt 2008-11-21  64  			______f = {					\
2bcd521a Steven Rostedt 2008-11-21  65  				.func = __func__,			\
2bcd521a Steven Rostedt 2008-11-21  66  				.file = __FILE__,			\
2bcd521a Steven Rostedt 2008-11-21  67  				.line = __LINE__,			\
2bcd521a Steven Rostedt 2008-11-21  68  			};						\
2bcd521a Steven Rostedt 2008-11-21  69  		______r = !!(cond);					\
97e7e4f3 Witold Baryluk 2009-03-17  70  		______f.miss_hit[______r]++;					\
2bcd521a Steven Rostedt 2008-11-21  71  		______r;						\
2bcd521a Steven Rostedt 2008-11-21  72  	}))
2bcd521a Steven Rostedt 2008-11-21  73  #endif /* CONFIG_PROFILE_ALL_BRANCHES */
2bcd521a Steven Rostedt 2008-11-21  74  

:::::: The code at line 61 was first introduced by commit
:::::: 2bcd521a684cc94befbe2ce7d5b613c841b0d304 trace: profile all if conditionals

:::::: TO: Steven Rostedt <srostedt@redhat.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--pf9I7BMVVzbSWLtt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
6zLEC8UBAA==

--pf9I7BMVVzbSWLtt--
