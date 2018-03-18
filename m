Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754242AbeCRRRf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 13:17:35 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:39920 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCRRRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 13:17:32 -0400
X-Google-Smtp-Source: AG47ELs18cAOXFOllWnijnbmtoTKpFxcxjpr5B1T5ZYiwxX0IYvWa4Q6d7RMtQ2jks3PnmaK+3OjHw==
Date: Sun, 18 Mar 2018 18:16:32 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clang-format: add configuration file
Message-ID: <20180318171632.qfkemw3mwbcukth6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-format is a tool to format C/C++/... code according to a set
of rules and heuristics. Like most tools, it is not perfect nor
covers every single case, but it is good enough to be helpful.

In particular, it is useful for quickly re-formatting blocks of code
automatically, for reviewing full files in order to spot coding style
mistakes, typos and possible improvements. It is also handy for
sorting ``#includes``, for aligning variables and macros, for reflowing
text and other similar tasks. It also serves as a teaching tool/guide
for newcomers.

The tool itself has been already included in the repositories of popular
Linux distributions for a long time. The rules in this file are intended
for clang-format >= 4, which is easily available in most distributions.

This commit adds the configuration file that contains the rules that
the tool uses to know how to format the code according to the kernel
coding style. This gives us several advantages:

  * clang-format works out of the box with reasonable defaults;
    avoiding that everyone has to re-do the configuration.

  * Everyone agrees (eventually) on what is the most useful default
    configuration for most of the kernel.

  * If it becomes commonplace among kernel developers, clang-format
    may feel compelled to support us better. They already recognize
    the Linux kernel and its style in their documentation and in one
    of the style sub-options.

Some of clang-format's features relevant for the kernel are:

  * Uses clang's tooling support behind the scenes to parse and rewrite
    the code. It is not based on ad-hoc regexps.

  * Supports reasonably well the Linux kernel coding style.

  * Fast enough to be used at the press of a key.

  * There are already integrations (either built-in or third-party)
    for many common editors used by kernel developers (e.g. vim,
    emacs, Sublime, Atom...) that allow you to format an entire file
    or, more usefully, just your selection.

  * Able to parse unified diffs -- you can, for instance, reformat
    only the lines changed by a git commit.

  * Able to reflow text comments as well.

  * Widely supported and used by hundreds of developers in highly
    complex projects and organizations (e.g. the LLVM project itself,
    Chromium, WebKit, Google, Mozilla...). Therefore, it will be
    supported for a long time.

See more information about the tool at:

    https://clang.llvm.org/docs/ClangFormat.html
    https://clang.llvm.org/docs/ClangFormatStyleOptions.html

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 .clang-format                          | 429 +++++++++++++++++++++++++++++++++
 .gitignore                             |   1 +
 Documentation/process/4.Coding.rst     |   8 +
 Documentation/process/clang-format.rst | 185 ++++++++++++++
 Documentation/process/coding-style.rst |   8 +
 5 files changed, 631 insertions(+)
 create mode 100644 .clang-format
 create mode 100644 Documentation/process/clang-format.rst

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 000000000000..6cdf4aa4e974
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,429 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# clang-format configuration file. Intended for clang-format >= 4.
+#
+# For more information, see:
+#
+#   Documentation/process/clang-format.rst
+#   https://clang.llvm.org/docs/ClangFormat.html
+#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
+#
+---
+AccessModifierOffset: -4
+AlignAfterOpenBracket: Align
+AlignConsecutiveAssignments: false
+AlignConsecutiveDeclarations: false
+#AlignEscapedNewlines: Left # Unknown to clang-format-4.0
+AlignOperands: true
+AlignTrailingComments: false
+AllowAllParametersOfDeclarationOnNextLine: false
+AllowShortBlocksOnASingleLine: false
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: None
+AllowShortIfStatementsOnASingleLine: false
+AllowShortLoopsOnASingleLine: false
+AlwaysBreakAfterDefinitionReturnType: None
+AlwaysBreakAfterReturnType: None
+AlwaysBreakBeforeMultilineStrings: false
+AlwaysBreakTemplateDeclarations: false
+BinPackArguments: true
+BinPackParameters: true
+BraceWrapping:
+  AfterClass: false
+  AfterControlStatement: false
+  AfterEnum: false
+  AfterFunction: true
+  AfterNamespace: true
+  AfterObjCDeclaration: false
+  AfterStruct: false
+  AfterUnion: false
+  #AfterExternBlock: false # Unknown to clang-format-5.0
+  BeforeCatch: false
+  BeforeElse: false
+  IndentBraces: false
+  #SplitEmptyFunction: true # Unknown to clang-format-4.0
+  #SplitEmptyRecord: true # Unknown to clang-format-4.0
+  #SplitEmptyNamespace: true # Unknown to clang-format-4.0
+BreakBeforeBinaryOperators: None
+BreakBeforeBraces: Custom
+#BreakBeforeInheritanceComma: false # Unknown to clang-format-4.0
+BreakBeforeTernaryOperators: false
+BreakConstructorInitializersBeforeComma: false
+#BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
+BreakAfterJavaFieldAnnotations: false
+BreakStringLiterals: false
+ColumnLimit: 80
+CommentPragmas: '^ IWYU pragma:'
+#CompactNamespaces: false # Unknown to clang-format-4.0
+ConstructorInitializerAllOnOneLineOrOnePerLine: false
+ConstructorInitializerIndentWidth: 8
+ContinuationIndentWidth: 8
+Cpp11BracedListStyle: false
+DerivePointerAlignment: false
+DisableFormat: false
+ExperimentalAutoDetectBinPacking: false
+#FixNamespaceComments: false # Unknown to clang-format-4.0
+
+# Taken from:
+#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ \
+#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'," \
+#   | sort | uniq
+ForEachMacros:
+  - 'apei_estatus_for_each_section'
+  - 'ata_for_each_dev'
+  - 'ata_for_each_link'
+  - 'ax25_for_each'
+  - 'ax25_uid_for_each'
+  - 'bio_for_each_integrity_vec'
+  - '__bio_for_each_segment'
+  - 'bio_for_each_segment'
+  - 'bio_for_each_segment_all'
+  - 'bio_list_for_each'
+  - 'bip_for_each_vec'
+  - 'blkg_for_each_descendant_post'
+  - 'blkg_for_each_descendant_pre'
+  - 'blk_queue_for_each_rl'
+  - 'bond_for_each_slave'
+  - 'bond_for_each_slave_rcu'
+  - 'btree_for_each_safe128'
+  - 'btree_for_each_safe32'
+  - 'btree_for_each_safe64'
+  - 'btree_for_each_safel'
+  - 'card_for_each_dev'
+  - 'cgroup_taskset_for_each'
+  - 'cgroup_taskset_for_each_leader'
+  - 'cpufreq_for_each_entry'
+  - 'cpufreq_for_each_entry_idx'
+  - 'cpufreq_for_each_valid_entry'
+  - 'cpufreq_for_each_valid_entry_idx'
+  - 'css_for_each_child'
+  - 'css_for_each_descendant_post'
+  - 'css_for_each_descendant_pre'
+  - 'device_for_each_child_node'
+  - 'drm_atomic_crtc_for_each_plane'
+  - 'drm_atomic_crtc_state_for_each_plane'
+  - 'drm_atomic_crtc_state_for_each_plane_state'
+  - 'drm_for_each_connector_iter'
+  - 'drm_for_each_crtc'
+  - 'drm_for_each_encoder'
+  - 'drm_for_each_encoder_mask'
+  - 'drm_for_each_fb'
+  - 'drm_for_each_legacy_plane'
+  - 'drm_for_each_plane'
+  - 'drm_for_each_plane_mask'
+  - 'drm_mm_for_each_hole'
+  - 'drm_mm_for_each_node'
+  - 'drm_mm_for_each_node_in_range'
+  - 'drm_mm_for_each_node_safe'
+  - 'for_each_active_drhd_unit'
+  - 'for_each_active_iommu'
+  - 'for_each_available_child_of_node'
+  - 'for_each_bio'
+  - 'for_each_board_func_rsrc'
+  - 'for_each_bvec'
+  - 'for_each_child_of_node'
+  - 'for_each_clear_bit'
+  - 'for_each_clear_bit_from'
+  - 'for_each_cmsghdr'
+  - 'for_each_compatible_node'
+  - 'for_each_console'
+  - 'for_each_cpu'
+  - 'for_each_cpu_and'
+  - 'for_each_cpu_not'
+  - 'for_each_cpu_wrap'
+  - 'for_each_dev_addr'
+  - 'for_each_dma_cap_mask'
+  - 'for_each_drhd_unit'
+  - 'for_each_dss_dev'
+  - 'for_each_efi_memory_desc'
+  - 'for_each_efi_memory_desc_in_map'
+  - 'for_each_endpoint_of_node'
+  - 'for_each_evictable_lru'
+  - 'for_each_fib6_node_rt_rcu'
+  - 'for_each_fib6_walker_rt'
+  - 'for_each_free_mem_range'
+  - 'for_each_free_mem_range_reverse'
+  - 'for_each_func_rsrc'
+  - 'for_each_hstate'
+  - 'for_each_if'
+  - 'for_each_iommu'
+  - 'for_each_ip_tunnel_rcu'
+  - 'for_each_irq_nr'
+  - 'for_each_lru'
+  - 'for_each_matching_node'
+  - 'for_each_matching_node_and_match'
+  - 'for_each_memblock'
+  - 'for_each_memblock_type'
+  - 'for_each_memcg_cache_index'
+  - 'for_each_mem_pfn_range'
+  - 'for_each_mem_range'
+  - 'for_each_mem_range_rev'
+  - 'for_each_migratetype_order'
+  - 'for_each_msi_entry'
+  - 'for_each_net'
+  - 'for_each_netdev'
+  - 'for_each_netdev_continue'
+  - 'for_each_netdev_continue_rcu'
+  - 'for_each_netdev_feature'
+  - 'for_each_netdev_in_bond_rcu'
+  - 'for_each_netdev_rcu'
+  - 'for_each_netdev_reverse'
+  - 'for_each_netdev_safe'
+  - 'for_each_net_rcu'
+  - 'for_each_new_connector_in_state'
+  - 'for_each_new_crtc_in_state'
+  - 'for_each_new_plane_in_state'
+  - 'for_each_new_private_obj_in_state'
+  - 'for_each_node'
+  - 'for_each_node_by_name'
+  - 'for_each_node_by_type'
+  - 'for_each_node_mask'
+  - 'for_each_node_state'
+  - 'for_each_node_with_cpus'
+  - 'for_each_node_with_property'
+  - 'for_each_of_allnodes'
+  - 'for_each_of_allnodes_from'
+  - 'for_each_of_pci_range'
+  - 'for_each_old_connector_in_state'
+  - 'for_each_old_crtc_in_state'
+  - 'for_each_oldnew_connector_in_state'
+  - 'for_each_oldnew_crtc_in_state'
+  - 'for_each_oldnew_plane_in_state'
+  - 'for_each_oldnew_private_obj_in_state'
+  - 'for_each_old_plane_in_state'
+  - 'for_each_old_private_obj_in_state'
+  - 'for_each_online_cpu'
+  - 'for_each_online_node'
+  - 'for_each_online_pgdat'
+  - 'for_each_pci_bridge'
+  - 'for_each_pci_dev'
+  - 'for_each_pci_msi_entry'
+  - 'for_each_populated_zone'
+  - 'for_each_possible_cpu'
+  - 'for_each_present_cpu'
+  - 'for_each_prime_number'
+  - 'for_each_prime_number_from'
+  - 'for_each_process'
+  - 'for_each_process_thread'
+  - 'for_each_property_of_node'
+  - 'for_each_reserved_mem_region'
+  - 'for_each_resv_unavail_range'
+  - 'for_each_rtdcom'
+  - 'for_each_rtdcom_safe'
+  - 'for_each_set_bit'
+  - 'for_each_set_bit_from'
+  - 'for_each_sg'
+  - 'for_each_sg_page'
+  - '__for_each_thread'
+  - 'for_each_thread'
+  - 'for_each_zone'
+  - 'for_each_zone_zonelist'
+  - 'for_each_zone_zonelist_nodemask'
+  - 'fwnode_for_each_available_child_node'
+  - 'fwnode_for_each_child_node'
+  - 'fwnode_graph_for_each_endpoint'
+  - 'gadget_for_each_ep'
+  - 'hash_for_each'
+  - 'hash_for_each_possible'
+  - 'hash_for_each_possible_rcu'
+  - 'hash_for_each_possible_rcu_notrace'
+  - 'hash_for_each_possible_safe'
+  - 'hash_for_each_rcu'
+  - 'hash_for_each_safe'
+  - 'hctx_for_each_ctx'
+  - 'hlist_bl_for_each_entry'
+  - 'hlist_bl_for_each_entry_rcu'
+  - 'hlist_bl_for_each_entry_safe'
+  - 'hlist_for_each'
+  - 'hlist_for_each_entry'
+  - 'hlist_for_each_entry_continue'
+  - 'hlist_for_each_entry_continue_rcu'
+  - 'hlist_for_each_entry_continue_rcu_bh'
+  - 'hlist_for_each_entry_from'
+  - 'hlist_for_each_entry_from_rcu'
+  - 'hlist_for_each_entry_rcu'
+  - 'hlist_for_each_entry_rcu_bh'
+  - 'hlist_for_each_entry_rcu_notrace'
+  - 'hlist_for_each_entry_safe'
+  - '__hlist_for_each_rcu'
+  - 'hlist_for_each_safe'
+  - 'hlist_nulls_for_each_entry'
+  - 'hlist_nulls_for_each_entry_from'
+  - 'hlist_nulls_for_each_entry_rcu'
+  - 'hlist_nulls_for_each_entry_safe'
+  - 'ide_host_for_each_port'
+  - 'ide_port_for_each_dev'
+  - 'ide_port_for_each_present_dev'
+  - 'idr_for_each_entry'
+  - 'idr_for_each_entry_continue'
+  - 'idr_for_each_entry_ul'
+  - 'inet_bind_bucket_for_each'
+  - 'inet_lhash2_for_each_icsk_rcu'
+  - 'iov_for_each'
+  - 'key_for_each'
+  - 'key_for_each_safe'
+  - 'klp_for_each_func'
+  - 'klp_for_each_object'
+  - 'kvm_for_each_memslot'
+  - 'kvm_for_each_vcpu'
+  - 'list_for_each'
+  - 'list_for_each_entry'
+  - 'list_for_each_entry_continue'
+  - 'list_for_each_entry_continue_rcu'
+  - 'list_for_each_entry_continue_reverse'
+  - 'list_for_each_entry_from'
+  - 'list_for_each_entry_from_reverse'
+  - 'list_for_each_entry_lockless'
+  - 'list_for_each_entry_rcu'
+  - 'list_for_each_entry_reverse'
+  - 'list_for_each_entry_safe'
+  - 'list_for_each_entry_safe_continue'
+  - 'list_for_each_entry_safe_from'
+  - 'list_for_each_entry_safe_reverse'
+  - 'list_for_each_prev'
+  - 'list_for_each_prev_safe'
+  - 'list_for_each_safe'
+  - 'llist_for_each'
+  - 'llist_for_each_entry'
+  - 'llist_for_each_entry_safe'
+  - 'llist_for_each_safe'
+  - 'media_device_for_each_entity'
+  - 'media_device_for_each_intf'
+  - 'media_device_for_each_link'
+  - 'media_device_for_each_pad'
+  - 'netdev_for_each_lower_dev'
+  - 'netdev_for_each_lower_private'
+  - 'netdev_for_each_lower_private_rcu'
+  - 'netdev_for_each_mc_addr'
+  - 'netdev_for_each_uc_addr'
+  - 'netdev_for_each_upper_dev_rcu'
+  - 'netdev_hw_addr_list_for_each'
+  - 'nft_rule_for_each_expr'
+  - 'nla_for_each_attr'
+  - 'nla_for_each_nested'
+  - 'nlmsg_for_each_attr'
+  - 'nlmsg_for_each_msg'
+  - 'nr_neigh_for_each'
+  - 'nr_neigh_for_each_safe'
+  - 'nr_node_for_each'
+  - 'nr_node_for_each_safe'
+  - 'of_for_each_phandle'
+  - 'of_property_for_each_string'
+  - 'of_property_for_each_u32'
+  - 'pci_bus_for_each_resource'
+  - 'ping_portaddr_for_each_entry'
+  - 'plist_for_each'
+  - 'plist_for_each_continue'
+  - 'plist_for_each_entry'
+  - 'plist_for_each_entry_continue'
+  - 'plist_for_each_entry_safe'
+  - 'plist_for_each_safe'
+  - 'pnp_for_each_card'
+  - 'pnp_for_each_dev'
+  - 'protocol_for_each_card'
+  - 'protocol_for_each_dev'
+  - 'queue_for_each_hw_ctx'
+  - 'radix_tree_for_each_contig'
+  - 'radix_tree_for_each_slot'
+  - 'radix_tree_for_each_tagged'
+  - 'rbtree_postorder_for_each_entry_safe'
+  - 'resource_list_for_each_entry'
+  - 'resource_list_for_each_entry_safe'
+  - 'rhl_for_each_entry_rcu'
+  - 'rhl_for_each_rcu'
+  - 'rht_for_each'
+  - 'rht_for_each_continue'
+  - 'rht_for_each_entry'
+  - 'rht_for_each_entry_continue'
+  - 'rht_for_each_entry_rcu'
+  - 'rht_for_each_entry_rcu_continue'
+  - 'rht_for_each_entry_safe'
+  - 'rht_for_each_rcu'
+  - 'rht_for_each_rcu_continue'
+  - '__rq_for_each_bio'
+  - 'rq_for_each_segment'
+  - 'scsi_for_each_prot_sg'
+  - 'scsi_for_each_sg'
+  - 'sctp_for_each_hentry'
+  - 'sctp_skb_for_each'
+  - 'shdma_for_each_chan'
+  - '__shost_for_each_device'
+  - 'shost_for_each_device'
+  - 'sk_for_each'
+  - 'sk_for_each_bound'
+  - 'sk_for_each_entry_offset_rcu'
+  - 'sk_for_each_from'
+  - 'sk_for_each_rcu'
+  - 'sk_for_each_safe'
+  - 'sk_nulls_for_each'
+  - 'sk_nulls_for_each_from'
+  - 'sk_nulls_for_each_rcu'
+  - 'snd_pcm_group_for_each_entry'
+  - 'snd_soc_dapm_widget_for_each_path'
+  - 'snd_soc_dapm_widget_for_each_path_safe'
+  - 'snd_soc_dapm_widget_for_each_sink_path'
+  - 'snd_soc_dapm_widget_for_each_source_path'
+  - 'tb_property_for_each'
+  - 'udp_portaddr_for_each_entry'
+  - 'udp_portaddr_for_each_entry_rcu'
+  - 'usb_hub_for_each_child'
+  - 'v4l2_device_for_each_subdev'
+  - 'v4l2_m2m_for_each_dst_buf'
+  - 'v4l2_m2m_for_each_dst_buf_safe'
+  - 'v4l2_m2m_for_each_src_buf'
+  - 'v4l2_m2m_for_each_src_buf_safe'
+  - 'zorro_for_each_dev'
+
+#IncludeBlocks: Preserve # Unknown to clang-format-5.0
+IncludeCategories:
+  - Regex: '.*'
+    Priority: 1
+IncludeIsMainRegex: '(Test)?$'
+IndentCaseLabels: false
+#IndentPPDirectives: None # Unknown to clang-format-5.0
+IndentWidth: 8
+IndentWrappedFunctionNames: true
+JavaScriptQuotes: Leave
+JavaScriptWrapImports: true
+KeepEmptyLinesAtTheStartOfBlocks: false
+MacroBlockBegin: ''
+MacroBlockEnd: ''
+MaxEmptyLinesToKeep: 1
+NamespaceIndentation: Inner
+#ObjCBinPackProtocolList: Auto # Unknown to clang-format-5.0
+ObjCBlockIndentWidth: 8
+ObjCSpaceAfterProperty: true
+ObjCSpaceBeforeProtocolList: true
+
+# Taken from git's rules
+#PenaltyBreakAssignment: 10 # Unknown to clang-format-4.0
+PenaltyBreakBeforeFirstCallParameter: 30
+PenaltyBreakComment: 10
+PenaltyBreakFirstLessLess: 0
+PenaltyBreakString: 10
+PenaltyExcessCharacter: 100
+PenaltyReturnTypeOnItsOwnLine: 60
+
+PointerAlignment: Right
+ReflowComments: false
+SortIncludes: false
+#SortUsingDeclarations: false # Unknown to clang-format-4.0
+SpaceAfterCStyleCast: false
+SpaceAfterTemplateKeyword: true
+SpaceBeforeAssignmentOperators: true
+#SpaceBeforeCtorInitializerColon: true # Unknown to clang-format-5.0
+#SpaceBeforeInheritanceColon: true # Unknown to clang-format-5.0
+SpaceBeforeParens: ControlStatements
+#SpaceBeforeRangeBasedForLoopColon: true # Unknown to clang-format-5.0
+SpaceInEmptyParentheses: false
+SpacesBeforeTrailingComments: 1
+SpacesInAngles: false
+SpacesInContainerLiterals: false
+SpacesInCStyleCastParentheses: false
+SpacesInParentheses: false
+SpacesInSquareBrackets: false
+Standard: Cpp03
+TabWidth: 8
+UseTab: Always
+...
+
diff --git a/.gitignore b/.gitignore
index 1be78fd8163b..ab5cbc1e85f6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -81,6 +81,7 @@ modules.builtin
 !.gitignore
 !.mailmap
 !.cocciconfig
+!.clang-format
 
 #
 # Generated include files
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index 26b106071364..eb4b185d168c 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -58,6 +58,14 @@ can never be transgressed.  If there is a good reason to go against the
 style (a line which becomes far less readable if split to fit within the
 80-column limit, for example), just do it.
 
+Note that you can also use the ``clang-format`` tool to help you with
+these rules, to quickly re-format parts of your code automatically,
+and to review full files in order to spot coding style mistakes,
+typos and possible improvements. It is also handy for sorting ``#includes``,
+for aligning variables/macros, for reflowing text and other similar tasks.
+See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
+for more details.
+
 
 Abstraction layers
 ******************
diff --git a/Documentation/process/clang-format.rst b/Documentation/process/clang-format.rst
new file mode 100644
index 000000000000..a0236d051dcd
--- /dev/null
+++ b/Documentation/process/clang-format.rst
@@ -0,0 +1,185 @@
+.. _clangformat:
+
+clang-format
+============
+
+``clang-format`` is a tool to format C/C++/... code according to
+a set of rules and heuristics. Like most tools, it is not perfect
+nor covers every single case, but it is good enough to be helpful.
+
+``clang-format`` can be used for several purposes:
+
+  - Quickly reformat a block of code to the kernel style. Specially useful
+    when moving code around and aligning/sorting. See clangformatreformat_.
+
+  - Spot style mistakes, typos and possible improvements in files
+    you maintain, patches you review, diffs, etc. See clangformatreview_.
+
+  - Help you follow the coding style rules, specially useful for those
+    new to kernel development or working at the same time in several
+    projects with different coding styles.
+
+Its configuration file is ``.clang-format`` in the root of the kernel tree.
+The rules contained there try to approximate the most common kernel
+coding style. They also try to follow :ref:`Documentation/process/coding-style.rst <codingstyle>`
+as much as possible. Since not all the kernel follows the same style,
+it is possible that you may want to tweak the defaults for a particular
+subsystem or folder. To do so, you can override the defaults by writing
+another ``.clang-format`` file in a subfolder.
+
+The tool itself has already been included in the repositories of popular
+Linux distributions for a long time. Search for ``clang-format`` in
+your repositories. Otherwise, you can either download pre-built
+LLVM/clang binaries or build the source code from:
+
+    http://releases.llvm.org/download.html
+
+See more information about the tool at:
+
+    https://clang.llvm.org/docs/ClangFormat.html
+
+    https://clang.llvm.org/docs/ClangFormatStyleOptions.html
+
+
+.. _clangformatreview:
+
+Review files and patches for coding style
+-----------------------------------------
+
+By running the tool in its inline mode, you can review full subsystems,
+folders or individual files for code style mistakes, typos or improvements.
+
+To do so, you can run something like::
+
+    # Make sure your working directory is clean!
+    clang-format -i kernel/*.[ch]
+
+And then take a look at the git diff.
+
+Counting the lines of such a diff is also useful for improving/tweaking
+the style options in the configuration file; as well as testing new
+``clang-format`` features/versions.
+
+``clang-format`` also supports reading unified diffs, so you can review
+patches and git diffs easily. See the documentation at:
+
+    https://clang.llvm.org/docs/ClangFormat.html#script-for-patch-reformatting
+
+To avoid ``clang-format`` formatting some portion of a file, you can do::
+
+    int formatted_code;
+    // clang-format off
+        void    unformatted_code  ;
+    // clang-format on
+    void formatted_code_again;
+
+While it might be tempting to use this to keep a file always in sync with
+``clang-format``, specially if you are writing new files or if you are
+a maintainer, please note that people might be running different
+``clang-format`` versions or not have it available at all. Therefore,
+you should probably refrain yourself from using this in kernel sources;
+at least until we see if ``clang-format`` becomes commonplace.
+
+
+.. _clangformatreformat:
+
+Reformatting blocks of code
+---------------------------
+
+By using an integration with your text editor, you can reformat arbitrary
+blocks (selections) of code with a single keystroke. This is specially
+useful when moving code around, for complex code that is deeply intended,
+for multi-line macros (and aligning their backslashes), etc.
+
+Remember that you can always tweak the changes afterwards in those cases
+where the tool did not do an optimal job. But as a first approximation,
+it can be very useful.
+
+There are integrations for many popular text editors. For some of them,
+like vim, emacs, BBEdit and Visual Studio you can find support built-in.
+For instructions, read the appropiate section at:
+
+    https://clang.llvm.org/docs/ClangFormat.html
+
+For Atom, Eclipse, Sublime Text, Visual Studio Code, XCode and other
+editors and IDEs you should be able to find ready-to-use plugins.
+
+For this use case, consider using a secondary ``.clang-format``
+so that you can tweak a few options. See clangformatextra_.
+
+
+.. _clangformatmissing:
+
+Missing support
+---------------
+
+``clang-format`` is missing support for some things that are common
+in kernel code. They are easy to remember, so if you use the tool
+regularly, you will quickly learn to avoid/ignore those.
+
+In particular, some very common ones you will notice are:
+
+  - Aligned blocks of one-line ``#defines``, e.g.::
+
+        #define TRACING_MAP_BITS_DEFAULT       11
+        #define TRACING_MAP_BITS_MAX           17
+        #define TRACING_MAP_BITS_MIN           7
+
+    vs.::
+
+        #define TRACING_MAP_BITS_DEFAULT 11
+        #define TRACING_MAP_BITS_MAX 17
+        #define TRACING_MAP_BITS_MIN 7
+
+  - Aligned designated initializers, e.g.::
+
+        static const struct file_operations uprobe_events_ops = {
+                .owner          = THIS_MODULE,
+                .open           = probes_open,
+                .read           = seq_read,
+                .llseek         = seq_lseek,
+                .release        = seq_release,
+                .write          = probes_write,
+        };
+
+    vs.::
+
+        static const struct file_operations uprobe_events_ops = {
+                .owner = THIS_MODULE,
+                .open = probes_open,
+                .read = seq_read,
+                .llseek = seq_lseek,
+                .release = seq_release,
+                .write = probes_write,
+        };
+
+
+.. _clangformatextra:
+
+Extra features/options
+----------------------
+
+Some features/style options are not enabled by default in the configuration
+file in order to minimize the differences between the output and the current
+code. In other words, to make the difference as small as possible,
+which makes reviewing full-file style, as well diffs and patches as easy
+as possible.
+
+In other cases (e.g. particular subsystems/folders/files), the kernel style
+might be different and enabling some of these options may approximate
+better the style there.
+
+For instance:
+
+  - Aligning assignments (``AlignConsecutiveAssignments``).
+
+  - Aligning declarations (``AlignConsecutiveDeclarations``).
+
+  - Reflowing text in comments (``ReflowComments``).
+
+  - Sorting ``#includes`` (``SortIncludes``).
+
+They are typically useful for block re-formatting, rather than full-file.
+You might want to create another ``.clang-format`` file and use that one
+from your editor/IDE instead.
+
diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index a20b44a40ec4..55d8b6624e78 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -622,6 +622,14 @@ options ``-kr -i8`` (stands for ``K&R, 8 character indents``), or use
 re-formatting you may want to take a look at the man page.  But
 remember: ``indent`` is not a fix for bad programming.
 
+Note that you can also use the ``clang-format`` tool to help you with
+these rules, to quickly re-format parts of your code automatically,
+and to review full files in order to spot coding style mistakes,
+typos and possible improvements. It is also handy for sorting ``#includes``,
+for aligning variables/macros, for reflowing text and other similar tasks.
+See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
+for more details.
+
 
 10) Kconfig configuration files
 -------------------------------
-- 
2.14.1
