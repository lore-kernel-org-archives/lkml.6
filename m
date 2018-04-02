Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeDBRzA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:55:00 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40480 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeDBRyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:54:51 -0400
Date: Mon, 02 Apr 2018 13:54:48 -0400 (EDT)
Message-Id: <20180402.135448.1305022382829537893.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32HtG3b030219


This is more like it:

1) Support offloading wireless authentication to userspace via
   NL80211_CMD_EXTERNAL_AUTH, from Srinivas Dasari.

2) A lot of work on network namespace setup/teardown from Kirill
   Tkhai.  Setup and cleanup of namespaces now all run asynchronously
   and thus performance is significantly increased.

3) Add rx/tx timestamping support to mv88e6xxx driver, from Brandon
   Streiff.

4) Support zerocopy on RDS sockets, from Sowmini Varadhan.

5) Use denser instruction encoding in x86 eBPF JIT, from Daniel
   Borkmann.

6) Support hw offload of vlan filtering in mvpp2 dreiver, from Maxime
   Chevallier.

7) Support grafting of child qdiscs in mlxsw driver, from Nogah
   Frankel.

8) Add packet forwarding tests to selftests, from Ido Schimmel.

9) Deal with sub-optimal GSO packets better in BBR congestion control,
   from Eric Dumazet.

10) Support 5-tuple hashing in ipv6 multipath routing, from David
    Ahern.

11) Add path MTU tests to selftests, from Stefano Brivio.

12) Various bits of IPSEC offloading support for mlx5, from Aviad
    Yehezkel, Yossi Kuperman, and Saeed Mahameed.

13) Support RSS spreading on ntuple filters in SFC driver, from
    Edward Cree.

14) Lots of sockmap work from John Fastabend.  Applications can use eBPF
    to filter sendmsg and sendpage operations.

15) In-kernel receive TLS support, from Dave Watson.

16) Add XDP support to ixgbevf, this is significant because it should
    allow optimized XDP usage in various cloud environments.  From
    Tony Nguyen.

17) Add new Intel E800 series "ice" ethernet driver, from Anirudh
    Venkataramanan et al.

18) IP fragmentation match offload support in nfp driver, from Pieter
    Jansen van Vuuren.

19) Support XDP redirect in i40e driver, from Björn Töpel.

20) Add BPF_RAW_TRACEPOINT program type for accessing the arguments
    of tracepoints in their raw form, from Alexei Starovoitov.

21) Lots of striding RQ improvements to mlx5 driver with many
    performance improvements, from Tariq Toukan.

22) Use rhashtable for inet frag reassembly, from Eric Dumazet.

Please pull, thanks a lot!

The following changes since commit b5dbc28762fd3fd40ba76303be0c7f707826f982:

  Merge tag 'kbuild-fixes-v4.16-3' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2018-03-30 18:53:57 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 

for you to fetch changes up to 159f02977b2feb18a4bece5e586c838a6d26d44b:

  Merge branch 'net-mvneta-improve-suspend-resume' (2018-04-02 11:14:03 -0400)

----------------------------------------------------------------
Al Viro (1):
      sctp: use proc_remove_subtree()

Alaa Hleihel (1):
      net/mlx5: Change teardown with force mode failure message to warning

Alan Brady (6):
      i40e: fix typo in function description
      i40e: use changed_flags to check I40E_FLAG_DISABLE_FW_LLDP
      i40e: broadcast filters can trigger overflow promiscuous
      i40e: refactor promisc_changed in i40e_sync_vsi_filters
      i40e: do not force filter failure in overflow promiscuous
      i40e/i40evf: use SW variables for hang detection

Alex Lu (1):
      Bluetooth: btrtl: Add RTL8723D and RTL8821C devices

Alexander Aring (11):
      ieee802154: 6lowpan: set IFF_NO_QUEUE
      net: sched: act: fix code style
      net: sched: act: add extack to init
      net: sched: act: fix code style
      net: sched: act: add extack to init
      net: sched: act: handle generic action errors
      net: sched: act: add extack to init callback
      net: sched: act: add extack for lookup callback
      net: sched: act: add extack for walk callback
      net: sched: act: handle extack in tcf_generic_walker
      net: sched: act: mirred: add extack support

Alexander Duyck (9):
      i40e/i40evf: Only track one ITR setting per ring instead of Tx/Rx
      i40e/i40evf: Clean up logic for adaptive ITR
      i40e/i40evf: Clean-up of bits related to using q_vector->reg_idx
      i40e/i40evf: Don't bother setting the CLEARPBA bit
      i40e/i40evf: Use usec value instead of reg value for ITR defines
      i40evf: Correctly populate rxitr_idx and txitr_idx
      i40e/i40evf: Split container ITR into current_itr and target_itr
      i40e/i40evf: Add support for new mechanism of updating adaptive ITR
      i40evf: Reorder configure_clsflower to avoid deadlock on error

Alexander Kurz (2):
      net: usb: asix88179_178a: set permanent address once only
      net: usb: asix88179_178a: de-duplicate code

Alexei Starovoitov (13):
      Merge branch 'x86-jit'
      Merge branch 'bpf-kselftest-improvements'
      Merge branch 'bpftool-visualization'
      treewide: remove large struct-pass-by-value from tracepoint arguments
      net/mediatek: disambiguate mt76 vs mt7601u trace events
      net/mac802154: disambiguate mac80215 vs mac802154 trace events
      net/wireless/iwlwifi: fix iwlwifi_dev_ucode_error tracepoint
      macro: introduce COUNT_ARGS() macro
      bpf: introduce BPF_RAW_TRACEPOINT
      libbpf: add bpf_raw_tracepoint_open helper
      samples/bpf: raw tracepoint test
      selftests/bpf: test for bpf_get_stackid() from raw tracepoints
      Merge branch 'nfp-bpf-updates'

Alexey Dobriyan (2):
      net: make kmem caches as __ro_after_init
      xfrm: mark kmem_caches as __ro_after_init

Alexey Kodanev (1):
      ip6_gre: remove redundant 'tunnel' setting in ip6erspan_tap_init()

Amitkumar Karwar (2):
      rsi: fix error path handling in SDIO probe
      rsi: fix kernel panic observed on 64bit machine

Anders Roxell (1):
      selftests/net: enable fragments for fib-onlink-tests

Andrea Parri (1):
      ptr_ring: Remove now-redundant smp_read_barrier_depends()

Andrew Lunn (20):
      net: ptp: Add stub for ptp_classify_raw()
      net: dsa: mv88e6xxx: Release mutex between each statistics read
      net: dsa: mv88e6xxx: Release mutex between each ATU read
      net: dsa: mv88e6xxx: scratch registers and external MDIO pins
      net: dsa: mv88e6xxx: Poll when no interrupt defined
      arm: mvebu: 370-rd: Enable PHY interrupt handling
      dsa: Pass the port to get_sset_count()
      net: dsa: mv88e6xxx: Hold mutex while doing stats operations
      net: dsa: mv88e6xxx: Allow the SERDES interfaces to have statistics
      net: dsa: mv88e6xxx: Add helper to determining if port has SERDES
      net: dsa: mv88e6xxx: Get mv88e6352 SERDES statistics
      net: dsa: mv88e6xxx: Fix irq free'ing
      net: dsa: mv88e6xxx: Fix IRQ when loading module
      net: dsa: mv88e6xxx: Add missing g1 IRQ numbers
      net: dsa: mv88e6xxx: Add number of internal PHYs
      net: dsa: mv88e6xxx: Add MDIO interrupts for internal PHYs
      net: dsa: mv88e6xxx: Use the DT IRQ trigger mode
      net: dsa: mv88e6xxx: Call the common IRQ free code
      net: dsa: mv88e6xxx: Keep ATU/VTU violation statistics
      net: dsa: mv88e6xxx: Make VTU miss violations less spammy

Andrey Ignatov (9):
      bpf: Check attach type at prog load time
      libbpf: Support expected_attach_type at prog load
      bpf: Hooks for sys_bind
      selftests/bpf: Selftest for sys_bind hooks
      net: Introduce __inet_bind() and __inet6_bind
      bpf: Hooks for sys_connect
      selftests/bpf: Selftest for sys_connect hooks
      bpf: Post-hooks for sys_bind
      selftests/bpf: Selftest for sys_bind post-hooks.

Andy Shevchenko (2):
      r8169: Dereference MMIO address immediately before use
      r8169: switch to device-managed functions in probe (part 2)

Anilkumar Kolli (2):
      ath10k: add memory dump support QCA9984
      ath10k: advertize beacon_int_min_gcd

Anirudh Venkataramanan (15):
      ice: Add basic driver framework for Intel(R) E800 Series
      ice: Add support for control queues
      ice: Start hardware initialization
      ice: Get switch config, scheduler config and device capabilities
      ice: Get MAC/PHY/link info and scheduler topology
      ice: Initialize PF and setup miscellaneous interrupt
      ice: Add support for VSI allocation and deallocation
      ice: Add support for switch filter programming
      ice: Configure VSIs for Tx/Rx
      ice: Implement transmit and NAPI support
      ice: Add support for VLANs and offloads
      ice: Add stats and ethtool support
      ice: Update Tx scheduler tree for VSI multi-Tx queue support
      ice: Support link events, reset and rebuild
      ice: Implement filter sync, NDO operations and bump version

Antoine Tenart (1):
      net: mvpp2: enable UDP/TCP checksum over IPv6

Antonio Cardace (1):
      x25: use %*ph to print small buffer

Arend Van Spriel (20):
      brcmfmac: move brcmf_bus_preinit() call just after changing bus state
      brcmfmac: move allocation of control rx buffer to brcmf_sdio_bus_preinit()
      brcmfmac: call brcmf_attach() just before calling brcmf_bus_started()
      brcmfmac: usb: call brcmf_usb_up() during brcmf_bus_preinit()
      brcmfmac: move brcmf_attach() function in core.c
      brcmfmac: remove brcmf_bus_started() from bus api
      brcmfmac: change log level for some low-level sdio functions
      brcmfmac: remove duplicate pointer variable from brcmf_sdio_firmware_callback()
      brcmfmac: do not convert linux error to firmware error string
      brcmfmac: use brcmf_chip_name() to store name in revinfo
      brcmfmac: use brcmf_chip_name() for consistency
      brcmfmac: allocate struct brcmf_pub instance using wiphy_new()
      brcmfmac: use wiphy debugfs dir entry
      brcmfmac: derive firmware filenames from basename mapping
      brcmfmac: pass struct in brcmf_fw_get_firmwares()
      brcmfmac: introduce brcmf_fw_alloc_request() function
      brcmfmac: add extension to .get_fwname() callbacks
      brcmfmac: get rid of brcmf_fw_map_chip_to_name()
      brcmfmac: get rid of brcmf_fw_get_full_name()
      brcmfmac: add kerneldoc for struct brcmf_bus::msgbuf

Arjun Vynipadath (5):
      cxgb4vf: Forcefully link up virtual interfaces
      cxgb4: Add HMA support
      cxgb4: Fix queue free path of ULD drivers
      cxgb4: Setup FW queues before registering netdev
      cxgb4: copy vlan_id in ndo_get_vf_config

Arkadi Sharshevsky (8):
      mlxsw: spectrum: Use NL_SET_ERR_MSG_MOD
      devlink: Move size validation to core
      devlink: Perform cleanup of resource_set cb
      mlxsw: spectrum_kvdl: Add support for linear division resources
      mlxsw: spectrum_kvdl: Add support for dynamic partition set
      mlxsw: spectrum_kvdl: Add support for per part occupancy
      selftests: Extend the tc action test for action mirror
      devlink: Change dpipe/resource get privileges

Arnd Bergmann (10):
      dsa: ptp: mark dummy helpers as 'inline'
      mlxsw: spectrum_kvdl: use div_u64() for 64-bit division
      mlxsw: spectrum_kvdl: avoid uninitialized variable warning
      ipvlan: fix building with modular IPV6
      rtlwifi: rtl8192cu: remove pointless memcpy
      ixgbevf: fix unused variable warning
      net: fix sysctl_fb_tunnels_only_for_init_net link error
      pktgen: use dynamic allocation for debug print buffer
      Bluetooth: btrsi: rework dependencies
      sctp: fix unused lable warning

Arushi Singhal (2):
      netfilter: Replace printk() with pr_*() and define pr_fmt()
      netfilter: Merge assignment with return

Arvind Yadav (1):
      ssb: use put_device() if device_register fail

Atul Gupta (12):
      tls: support for Inline tls record
      ethtool: enable Inline TLS in HW
      cxgb4: Inline TLS FW Interface
      cxgb4: LLD driver changes to support TLS
      crypto: chcr - Inline TLS Key Macros
      crypto: chtls - structure and macro for Inline TLS
      crypto: chtls - Register chtls with net tls
      crypto : chtls - CPL handler definition
      crypto: chtls - Inline TLS record Tx
      crypto: chtls - Inline TLS record Rx
      crypto: chtls - Program the TLS session Key
      crypto: chtls - Makefile Kconfig

Aviad Yehezkel (14):
      IB/mlx5: Removed not used parameters
      net/mlx5: Fixed compilation issue when CONFIG_MLX5_ACCEL is disabled
      net/mlx5e: Wait for FPGA command responses with a timeout
      net/mlx5e: Fixed sleeping inside atomic context
      net/mlx5e: Removed not need synchronize_rcu
      net/mlx5: Add empty egress namespace to flow steering core
      net/mlx5: Flow steering cmd interface should get the fte when deleting
      net/mlx5: IPSec, Add command V2 support
      net/mlx5: Export ipsec capabilities
      net/mlx5: Added required metadata capability for ipsec
      net/mlx5: Refactor accel IPSec code
      net/mlx5: Add flow-steering commands for FPGA IPSec implementation
      net/mlx5e: Added common function for to_ipsec_sa_entry
      net/mlx5: IPSec, Add support for ESN

Avinash Dayanand (6):
      i40evf: Fix link up issue when queues are disabled
      i40e: Enable ADq and create queue channel/s on VF
      i40evf: Alloc queues for ADq on VF
      i40e: Delete queue channel for ADq on VF
      i40e: Service request to configure bandwidth for ADq on a VF
      i40e: Add and delete cloud filter

Aviv Heller (1):
      net/mlx5e: Add VLAN offload features to hw_enc_features

Ayala Beker (1):
      iwlwifi: fw api: support the new scan request FW API version

BTaskaya (1):
      tc: python3, string formattings

Ben Greear (1):
      mac80211: Add txq flags to debugfs

Ben Hutchings (1):
      netfilter: x_tables: Add note about how to free percpu counters

Benjamin Beichler (4):
      mac80211_hwsim: add permanent mac address option for new radios
      mac80211_hwsim: add nl_err_msg in hwsim_new_radio in netlink case
      mac80211_hwsim: add generation count for netlink dump operation
      mac80211_hwsim: fix use-after-free bug in hwsim_exit_net

Bernie Harris (2):
      netfilter: ebtables: Add support for specifying match revision
      netfilter: ebtables: Add string filter

Biju Das (1):
      dt-bindings: net: renesas-ravb: Add support for r8a77470 SoC

Björn Töpel (3):
      ixgbe: tweak page counting for XDP_REDIRECT
      i40e: tweak page counting for XDP_REDIRECT
      i40e: add support for XDP_REDIRECT

Boris Pismenny (2):
      IB/mlx5: Pass mlx5_flow_act struct instead of multiple arguments
      {net,IB}/mlx5: Add flow steering helpers

Brad Mouring (4):
      net: macb: Reorganize macb_mii bringup
      net: macb: Remove redundant poll irq assignment
      net: macb: Add phy-handle DT support
      Documentation: macb: Document phy-handle binding

Brandon Streiff (10):
      net: dsa: mv88e6xxx: export g2 register accessors
      net: dsa: mv88e6xxx: add accessors for PTP/TAI registers
      net: dsa: mv88e6xxx: expose switch time as a PTP hardware clock
      net: dsa: mv88e6xxx: add support for GPIO configuration
      net: dsa: mv88e6xxx: add support for event capture
      net: dsa: forward hardware timestamping ioctls to switch driver
      net: dsa: forward timestamping callbacks to switch drivers
      net: dsa: mv88e6xxx: add rx/tx timestamping support
      net: dsa: mv88e6xxx: add workaround for 6341 timestamping
      dt-bindings: net: dsa: marvell: describe compatibility string

Brenda J. Butler (12):
      tools: tc-testing: Command line parms
      tools: tc-testing: Refactor test-runner
      tools: tc-testing: Introduce plugin architecture
      tools: tc-testing: rootPlugin
      tools: tc-testing: nsPlugin
      tools: tc-testing: valgrindPlugin
      tools: tc-testing: Update README and TODO
      tools: tc-testing: Fix indentation
      tools: tc-testing: better error reporting
      tools: tc-testing: Add notap option
      tools: tc-testing: Can refer to $TESTID in test spec
      tools: tc-testing: Can pause just before post-suite

Bryan Whitehead (2):
      lan743x: Add main source files for new lan743x driver
      lan743x: Update MAINTAINERS to include lan743x driver

Carl Huang (1):
      ath10k: fix use-after-free in ath10k_wmi_cmd_send_nowait

Chas Williams (1):
      bridge: Allow max MTU when multiple VLANs present

Christian Brauner (2):
      net: add uevent socket member
      netns: send uevent messages

Christian Lamparter (1):
      ath10k: fix recent bandwidth conversion bug

Christophe JAILLET (1):
      igb: Fix a test with HWTSTAMP_TX_ON

Claudiu Manoil (1):
      MAINTAINERS: Update my email address from freescale to nxp

Colin Ian King (30):
      esp4: remove redundant initialization of pointer esph
      net: dsa: mv88e6xxx: avoid unintended sign extension on a 16 bit shift
      mac80211: remove redundant initialization to pointer 'hdr'
      atm: idt77252: remove redundant bit-wise or'ing of zero
      wil6210: fix spelling mistake: "preperation"-> "preparation"
      ixgbe: remove redundant initialization of 'pool'
      sfc: falcon: remove duplicated bit-wise or of LOOPBACK_SGMII
      xen-netback: make function xenvif_rx_skb static
      ixgbevf: remove redundant initialization of variable 'dma'
      i40evf: pass struct virtchnl_filter by reference rather than by value
      i40e: check that pointer VSI is not null before dereferencing it
      i40evf: remove redundant array comparisons to 0 checks
      wireless: zd1211rw: remove redundant assignment of pointer 'q'
      brcmsmac: remove duplicated bit-wise or of IEEE80211_CHAN_NO_IR
      ath5k: remove duplicated re-assignment to pointer 'tq'
      ieee802154: remove unused variable 'val'
      net/usb/kalmia: use ARRAY_SIZE for various array sizing calculations
      net: phy: Fix spelling mistake: "advertisment"-> "advertisement"
      net: amd8111e: remove redundant assignment to 'tx_index'
      rds: remove redundant variable 'sg_off'
      lan743x: remove some redundant variables and assignments
      lan743x: make functions lan743x_csr_read and lan743x_csr_read static
      rxrpc: remove redundant initialization of variable 'len'
      net: mvpp2: use correct index on array mvpp2_pools
      gre: fix TUNNEL_SEQ bit check on sequence numbering
      net: qualcomm: rmnet: check for null ep to avoid null pointer dereference
      rsi: remove redundant duplicate assignment of buffer_size
      rtlwifi: rtl8821ae: fix spelling mistake: "Aboslute" -> "Absolute"
      net/ncsi: check for null return from call to nla_nest_start
      samples/bpf: fix spelling mistake: "revieve" -> "receive"

Cong Wang (1):
      netfilter: make xt_rateest hash table per net

Corentin Labbe (1):
      i40e: remove i40e_fcoe files

Corinna Vinschen (1):
      igb: add VF trust infrastructure

Dan Carpenter (5):
      i40e: remove some stray indenting
      net/ncsi: use kfree_skb() instead of kfree()
      net/ncsi: unlock on error in ncsi_set_interface_nl()
      ibmvnic: Potential NULL dereference in clean_one_tx_pool()
      test_bpf: Fix NULL vs IS_ERR() check in test_skb_segment()

Daniel Borkmann (23):
      Merge branch 'bpf-misc-selftest-improvements'
      bpf, x64: save one byte per shl/shr/sar when imm is 1
      bpf, x64: save several bytes by using mov over movabsq when possible
      bpf, x64: save several bytes when mul dest is r0/r3 anyway
      bpf, x64: save few bytes when mul is in alu32
      bpf, x64: save 5 bytes in prologue when ebpf insns came from cbpf
      bpf: add various jit test cases
      bpf: unify rlimit handling in selftests
      bpf: add tail call tests to test_verifier
      bpf, x64: remove bpf_flush_icache
      Merge branch 'bpf-bpftool-batch-improvements'
      Merge branch 'bpf-perf-sample-addr'
      Merge branch 'bpf-tools-makefile-improvements'
      Merge branch 'bpf-stackmap-build-id'
      Merge branch 'bpf-tools-build-improvements'
      Merge branch 'bpf-sockmap-ulp'
      bpf, doc: add description wrt native/bpf clang target and pointer size
      Merge branch 'bpf-print-insns-api'
      Merge branch 'bpf-verifier-log-btf-prep'
      Merge branch 'bpf-raw-tracepoints'
      Merge branch 'bpf-sockmap-ingress'
      Merge branch 'bpf-sockmap-sg-api-fixes'
      Merge branch 'bpf-cgroup-bind-connect'

Daniel Mack (1):
      wcn36xx: dequeue all pending indicator messages

Dave Ertman (1):
      i40e: i40e: Change ethtool check from MAC to HW flag

Dave Watson (6):
      tls: Generalize zerocopy_from_iter
      tls: Move cipher info to a separate struct
      tls: Pass error code explicitly to tls_err_abort
      tls: Refactor variable names
      tls: RX path for ktls
      tls: Add receive path documentation

David Ahern (46):
      net/ipv4: Simplify fib_select_path
      net/ipv4: Unexport fib_multipath_hash and fib_select_path
      selftests: fib_tests: simplify ip commands in a namespace
      selftests: fib_tests: Make test results more verbose
      selftests: fib_tests: Move admin of dummy0 to helpers
      selftests: fib_tests: sleep after changing carrier
      selftests: Add FIB onlink tests
      net: Make dn_ptr depend on CONFIG_DECNET
      net: Make ax25_ptr depend on CONFIG_AX25
      net: Make atalk_ptr depend on ATALK or IRDA
      net: Remove atalk header from socket.c
      net: Move ipv4 set_lwt_redirect helper to lwtunnel
      net/ipv4: Remove fib table id from rtable
      net: Only honor ifindex in IP_PKTINFO if non-0
      selftests: Add fib-onlink-tests.sh to TEST_PROGS
      selftests: forwarding: Only check tc version for tc tests
      selftests: forwarding: Handle 0 for packet difference in multipath tests
      selftests: forwarding: Use PING6 instead of ping for ipv6 multipath test
      selftests: forwarding: Add description to the multipath tests
      net/ipv4: Pass net to fib_multipath_hash instead of fib_info
      net: Align ip_multipath_l3_keys and ip6_multipath_l3_keys
      net/ipv4: Simplify fib_multipath_hash with optional flow keys
      net/ipv6: Make rt6_multipath_hash similar to fib_multipath_hash
      net: Rename NETEVENT_MULTIPATH_HASH_UPDATE
      net/ipv6: Pass skb to route lookup
      net/ipv6: Add support for path selection using hash of 5-tuple
      mlxsw: spectrum_router: Add support for ipv6 hash policy update
      net: Remove unused get_hash_from_flow functions
      selftests: forwarding: Add multipath test for L4 hashing
      selftests: forwarding: Add suppport to create veth interfaces
      net/ipv6: Refactor gateway validation on route add
      net/ipv6: Change address check to always take a device argument
      net/ipv6: Add l3mdev check to ipv6_chk_addr_and_flags
      selftests: fib_tests: Use an alias for ip command
      selftests: fib_tests: Allow user to run a specific test
      selftests: fib_tests: Add IPv6 nexthop spec tests
      selftests: Add multipath tests for onlink flag
      devlink: Remove top_hierarchy arg to devlink_resource_register
      devlink: Remove top_hierarchy arg for DEVLINK disabled path
      net: Fix fib notifer to return errno
      net: Move call_fib_rule_notifiers up in fib_nl_newrule
      net/ipv4: Move call_fib_entry_notifiers up for new routes
      net/ipv4: Allow notifier to fail route replace
      net/ipv6: Move call_fib6_entry_notifiers up for route adds
      netdevsim: Add simple FIB resource controller via devlink
      netdevsim: Change nsim_devlink_setup to return error to caller

David Howells (13):
      rxrpc: Trace resend
      rxrpc, afs: Use debug_ids rather than pointers in traces
      rxrpc: Trace call completion
      rxrpc: Fix firewall route keepalive
      rxrpc: Fix a bit of time confusion
      rxrpc: Fix Tx ring annotation after initial Tx failure
      rxrpc: Don't treat call aborts as conn aborts
      rxrpc: Fix checker warnings and errors
      rxrpc: Fix potential call vs socket/net destruction race
      rxrpc: Add a tracepoint to track rxrpc_local refcounting
      rxrpc: Fix apparent leak of rxrpc_local objects
      rxrpc: Add a tracepoint to track rxrpc_peer refcounting
      rxrpc: Fix leak of rxrpc_peer objects

David S. Miller (185):
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'Replacing-net_mutex-with-rw_semaphore'
      Merge branch 'mlxsw-IPIP-cleanups'
      Merge branch 'mlxsw-SPAN-cleanups'
      Merge branch 'sctp-rename-sctp-diag-file-and-add-file-comments-for-it'
      Merge branch 'selftests-fib_tests-simplifications-verbosity-and-a-race'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'net-dev-Make-protocol-ptr-dependent-on-CONFIG'
      Merge branch 'PTP-support-for-DSA-and-mv88e6xxx-driver'
      Merge branch 'cxgb4-speed-up-reading-on-chip-memory'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'tunchr-get-netns'
      Merge branch 'tc-testing-plugin-architecture'
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth-next
      Merge branch 'tipc-de-generealize-topology-server'
      Merge branch 'dsa-mv88e6xxx-Improve-PTP-access-latency'
      Merge branch 'net-sched-act-add-extack-support'
      net: Revert sched action extack support series.
      Merge branch 'RDS-zerocopy-support'
      Merge branch 'net-sched-act-add-extack-support'
      Merge branch 'nfp-whitespace-sync-and-flower-TCP-flags'
      Merge branch 'dwmac-meson8b-small-cleanup'
      Merge branch 'pernet_ops-conversions-part-2'
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'net-Get-rid-of-net_mutex-and-simplify-cleanup_list-queueing'
      Merge branch 'net-Expose-KVD-linear-parts-as-resources'
      Merge branch 'stmmac-multi-queue-fixes-and-cleanups'
      Merge branch '8390-cleanups'
      Merge branch 'ibmvnic-Make-driver-resources-dynamic'
      Merge branch 'tcp-remove-non-GSO-code'
      Merge branch 'ipvlan-deps'
      Merge tag 'mlx5-updates-2018-02-21' of git://git.kernel.org/.../mellanox/linux
      Merge tag 'mac80211-next-for-davem-2018-02-22' of git://git.kernel.org/.../jberg/mac80211-next
      Merge branch 'nfp-build-and-FW-initramfs-updates'
      Merge git://git.kernel.org/.../davem/net
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge branch 'mv88e6xxx-Poll-when-no-interrupt-defined'
      Merge branch 'tools-tc-testing-better-error-reporting'
      Merge branch 'sonic-ethernet-cleanups'
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'pernet_operations-convert-part-3'
      Merge branch 'ieee802154-for-davem-2018-02-26' of git://git.kernel.org/.../sschmidt/wpan-next
      Merge branch 'DPAA-Ethernet-fixes'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'RDS-optimized-notification-for-zerocopy-completion'
      Merge branch 'stmmac-barrier-fixes-and-cleanup'
      Merge branch 'ibmvnic-Miscellaneous-driver-fixes-and-enhancements'
      Merge branch 'mlxsw-Offloading-encapsulated-SPAN'
      Merge branch 'mlx4-misc'
      Merge tag 'mlx5-updates-2018-02-23' of git://git.kernel.org/.../mellanox/linux
      Merge branch 'SFP-updates'
      Merge branch 'macmace-cleanups'
      Merge branch 'mlxsw-mq-red-offload'
      Merge branch 'selftests-forwarding-Add-VRF-based-tests'
      Merge branch '100GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'fib_rules-support-sport-dport-and-proto-match'
      Merge branch 'ipv4-ipv6-mcast-align'
      Merge branch 'smc-link-layer-control-enhancements'
      Merge branch 'forwarding-selftest-fixes'
      Merge branch 'mac89x0-fixes-and-cleanups'
      Merge branch 'net-phy-Reduce-duplication'
      Merge branch 'tcp_bbr-more-GSO-work'
      Merge tag 'mac80211-next-for-davem-2018-03-02' of git://git.kernel.org/.../jberg/mac80211-next
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge branch 'sctp-clean-up-sctp_sendmsg'
      Merge branch 'net-ipv6-Add-support-for-path-selection-using-hash-of-5-tuple'
      Merge branch 'dsa-serdes-stats'
      Merge branch 'enic-update'
      Merge branch 'gre-seq-collect_md'
      Merge tag 'batadv-next-for-davem-20180302' of git://git.open-mesh.org/linux-merge
      Merge branch 'convert-pernet_operations-part4'
      Merge branch 'mvpp2-jumbo-frames-support'
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'sctp-add-support-for-some-msg_control-options-from-RFC6458'
      Merge branch 'lan743x-driver'
      Merge branch '1GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'net-phy-remove-phy_error-from-phy_disable_interrupts'
      Merge tag 'mlx5-updates-2018-02-28-1' of git://git.kernel.org/.../mellanox/linux
      Merge branch 'mvpp2-ucast-filter'
      Merge branch 'RDS-zerocopy-code-enhancements'
      Merge branch 'hns3-next'
      Merge branch 'pernet-convert-part5'
      Merge branch 'ibmvnic-Clean-up-net-close-and-fix-reset-bug'
      Merge tag 'mlx5-updates-2018-02-28-2' of git://git.kernel.org/.../mellanox/linux
      Merge branch 'ntuple-filters-with-RSS'
      Merge branch 'sched-action-events'
      Merge branch 'hns3-fixes-for-configuration-lost-problems'
      Merge branch 's390-qeth-next'
      Merge branch 'selftests-forwarding-Tweaks-and-a-new-test'
      Merge branch 'hns3-next'
      Merge branch 'mlxsw-Removing-dependency-of-mlxsw-on-GRE'
      ipv6: Use ip6_multipath_hash_policy() in rt6_multipath_hash().
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'ibmvnic-Fix-VLAN-and-other-device-errata'
      Merge branch 'pernet-convert-part6'
      Merge branch 'sfc-support-FEC-configuration'
      Merge branch 'smc-fixes'
      Merge branch 'sctp-add-support-for-some-sctp-auth-APIs-from-RFC6458'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'macb-Introduce-phy-handle-DT-functionality'
      Merge branch 'net-ipv6-Address-checks-need-to-consider-the-L3-domain'
      Merge branch 'rtnl_lock_killable'
      Merge branch 'net-smc-IPv6-support'
      Merge branch 'pernet-convert-part8'
      Merge branch 'tipc-obsolete-zone-concept'
      Merge branch 'hv_netvsc-minor-enhancements'
      Merge branch 'ibmvnic-Update-TX-pool-and-TX-routines'
      Merge branch 'selftests-pmtu-Add-further-vti-vti6-MTU-and-PMTU-tests'
      Merge branch 'mv88e6xxx-auto-phy-intr'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'mlxsw-Adapt-driver-to-upcoming-firmware-versions'
      Merge branch 'dsa-mv88e6xxx-some-fixes'
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge tag 'batadv-next-for-davem-20180319' of git://git.open-mesh.org/linux-merge
      Merge branch 'r8169-small-improvements'
      Merge branch 'cxgb4-rdma'
      Merge branch 'fix-some-bugs-for-HNS3-driver'
      Merge branch 'mlxsw-Update-supported-firmware-version'
      Merge branch 'tipc-diag'
      Merge branch 'rmnet-next'
      Merge branch 'Rework-ip_ra_chain-protection'
      Merge branch 'hns3-VF-reset'
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'tls-RX'
      Merge branch 'pernet-convert-part11'
      Merge branch 'tipc-introduce-128-bit-auto-configurable-node-id'
      Merge branch 'liquidio-Tx-queue-cleanup'
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'net-permit-skb_segment-on-head_frag-frag_list-skb'
      Merge branch 'hv_netvsc-Fix-improve-RX-path-error-handling'
      Merge branch 'mv88e6xxx-module-reloading'
      Merge branch 'broadcom-Adaptive-interrupt-coalescing'
      Merge tag 'wireless-drivers-next-for-davem-2018-03-24' of git://git.kernel.org/.../kvalo/wireless-drivers-next
      Merge branch 'ethernet-ave-add-UniPhier-PXs3-support'
      Merge branch 'Drop-NETDEV_UNREGISTER_FINAL'
      Merge branch 'hns3-fixes-next'
      Merge branch 'sh_eth-unify-the-SoC-feature-checks'
      Merge branch 'net-driver-barriers'
      Merge branch 'nfp-flower-add-ip-fragmentation-offloading-support'
      Merge branch 'pernet-convert-part7.1'
      Merge branch 'mlxsw-Offload-IPv6-multicast-routes'
      Merge branch '100GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'net-mvpp2-Remove-unnecessary-dynamic-allocs'
      Merge tag 'mlx5-updates-2018-03-22' of git://git.kernel.org/.../saeed/linux
      Merge branch 'pernet-all-async'
      Merge branch 'sfc-filter-locking'
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec-next
      Merge tag 'rxrpc-next-20180327' of git://git.kernel.org/.../dhowells/linux-fs
      Merge branch 'net-bgmac-Couple-of-small-bgmac-changes'
      Merge branch 'Introduce-net_rwsem-to-protect-net_namespace_list'
      Merge tag 'mlx5-updates-2018-03-27' of git://git.kernel.org/.../saeed/linux
      Merge branch 'net-Allow-FIB-notifiers-to-fail-add-and-replace'
      Merge branch 'qed-flash-upgrade-support'
      Merge branch 'dsa-Add-ATU-VTU-statistics'
      Merge tag 'mac80211-next-for-davem-2018-03-29' of git://git.kernel.org/.../jberg/mac80211-next
      Merge tag 'wireless-drivers-next-for-davem-2018-03-29' of git://git.kernel.org/.../kvalo/wireless-drivers-next
      Merge branch 'net-Broadcom-drivers-coalescing-fixes'
      Merge branch 'phylink-API-changes'
      Merge branch 'nfp-flower-handle-MTU-changes'
      Merge branch 'Implement-of_get_nvmem_mac_address-helper'
      Merge branch 'Close-race-between-un-register_netdevice_notifier-and-pernet_operations'
      Merge git://git.kernel.org/.../pablo/nf-next
      Merge branch 'do-not-allow-adding-routes-if-disable_ipv6-is-enabled'
      Merge branch 'stmmac-DWMAC5'
      Merge branch 'ieee802154-for-davem-2018-03-29' of git://git.kernel.org/.../sschmidt/wpan-next
      Merge branch 'meson8b'
      Merge branch 'thunderx-DMAC-filtering'
      Merge branch 'bridge-mtu'
      Merge branch 'tipc-slim-down-name-table'
      Merge branch 'net_rwsem-fixes'
      Merge tag 'rxrpc-next-20180330' of git://git.kernel.org/.../dhowells/linux-fs
      Merge tag 'mlx5-updates-2018-03-30' of git://git.kernel.org/.../saeed/linux
      Merge branch 'bnxt_en-next'
      Merge branch 'inet-frags-bring-rhashtables-to-IP-defrag'
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge branch 'chelsio-inline-tls'
      Merge branch 'mlxsw-cleanups'
      Revert "net: usb: asix88179_178a: de-duplicate code"
      Merge branch 'inet-factorize-sk_wmem_alloc-updates'
      Merge branch 'sh_eth-remove-SH_ETH_OFFSET_INVALID-abuses'
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth-next
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'net-bgmac-Couple-of-sparse-warnings'
      Merge branch 'net-mvneta-improve-suspend-resume'

Davide Caratti (4):
      net: sched: fix unbalance in the error path of tca_action_flush()
      tc-testing: add selftests for 'bpf' action
      net/sched: remove tcf_idr_cleanup()
      net/sched: act_vlan: declare push_vid with host byte order

Denis 'GNUtoo' Carikli (1):
      bcma: add HP Stream Notebook

Denis Kenzior (12):
      uapi: Add 802.11 Preauthentication to if_ether
      cfg80211: Support all iftypes in autodisconnect_wk
      nl80211: Add SOCKET_OWNER support to JOIN_IBSS
      nl80211: Add SOCKET_OWNER support to JOIN_MESH
      nl80211: Add SOCKET_OWNER support to START_AP
      nl80211: Add CMD_CONTROL_PORT_FRAME API
      nl80211: Implement TX of control port frames
      nl80211: Add CONTROL_PORT_OVER_NL80211 attribute
      nl80211: Add control_port_over_nl80211 for ibss
      nl80211: Add control_port_over_nl80211 to mesh_setup
      mac80211: Add support for tx_control_port
      mac80211: Send control port frames over nl80211

Denys Vlasenko (1):
      net: make getname() functions return length rather than use int* parameter

Dirk van der Merwe (1):
      nfp: advertise firmware for mixed 10G/25G mode

Dmitry Lebed (4):
      cfg80211/nl80211: add CAC_STARTED event
      cfg80211/nl80211: add DFS offload flag
      cfg80211: fix CAC_STARTED event handling
      cfg80211: enable use of non-cleared DFS channels for DFS offload

Donald Sharp (2):
      net: Allow a rule to track originating protocol
      net: fib_rules: Add new attribute to set protocol

Doug Dziggel (1):
      i40e: Fix incorrect return types

Edward Cree (10):
      net: ethtool: extend RXNFC API to support RSS spreading of filter matches
      sfc: support RSS spreading of ethtool ntuple filters
      sfc: update MCDI protocol headers
      sfc: support FEC configuration through ethtool
      sfc: replace asynchronous filter operations
      sfc: give ef10 its own rwsem in the filter table instead of filter_lock
      sfc: use a semaphore to lock farch filters too
      sfc: return a better error if filter insertion collides with MC reboot
      sfc: protect list of RSS contexts under a mutex
      sfc: fix flow type handling for RSS filters

Emil Tantilov (9):
      ixgbevf: use page_address offset from page
      ixgbevf: add ethtool private flag for legacy Rx
      ixgbevf: add support for using order 1 pages to receive large frames
      ixgbevf: setup queue counts
      ixgbevf: add support for padding packet
      ixgbevf: make sure all frames fit minimum size requirements
      ixgbevf: allocate the rings as part of q_vector
      ixgbevf: break out Rx buffer page management
      ixgbevf: add build_skb support

Emmanuel Grumbach (2):
      iwlwifi: bump the max API version for 9000 and 22000 devices
      mac80211: don't WARN on bad WMM parameters from buggy APs

Eran Ben Elisha (7):
      net/mlx4_en: Add physical RX/TX bytes/packets counters
      net/mlx4_en: Remove unnecessary warn print in reset config
      net/mlx5e: Move all TX timeout logic to be under state lock
      mlx5_{ib,core}: Add query SQ state helper function
      mlx5: Move dump error CQE function out of mlx5_ib for code sharing
      net/mlx5e: Dump xmit error completions
      net/mlx5e: Recover Send Queue (SQ) from error state

Eric Dumazet (36):
      tcp: try to keep packet if SYN_RCV race is lost
      tcp: switch to GSO being always on
      tcp: remove sk_can_gso() use
      tcp: remove sk_check_csum_caps()
      tcp: tcp_sendmsg() only deals with CHECKSUM_PARTIAL
      tcp: remove dead code from tcp_set_skb_tso_segs()
      tcp: remove dead code after CHECKSUM_PARTIAL adoption
      tcp_bbr: better deal with suboptimal GSO (II)
      tcp_bbr: remove bbr->tso_segs_goal
      net/mlx4_en: try to use high order pages for RX rings
      ip6mr: remove synchronize_rcu() in favor of SOCK_RCU_FREE
      net: do not create fallback tunnels for non-default namespaces
      ipv6: export ip6 fragments sysctl to unprivileged users
      ipv6: frag: remove unused field
      inet: frags: change inet_frags_init_net() return value
      inet: frags: add a pointer to struct netns_frags
      inet: frags: refactor ipv6_frag_init()
      inet: frags: refactor lowpan_net_frag_init()
      inet: frags: refactor ipfrag_init()
      rhashtable: add schedule points
      inet: frags: use rhashtables for reassembly units
      inet: frags: remove some helpers
      inet: frags: get rif of inet_frag_evicting()
      inet: frags: remove inet_frag_maybe_warn_overflow()
      inet: frags: break the 2GB limit for frags storage
      inet: frags: do not clone skb in ip_expire()
      ipv6: frags: rewrite ip6_expire_frag_queue()
      rhashtable: reorganize struct rhashtable layout
      inet: frags: reorganize struct netns_frags
      inet: frags: get rid of ipfrag_skb_cb/FRAG_CB
      ipv6: frags: get rid of ip6frag_skb_cb/FRAG6_CB
      inet: frags: get rid of nf_ct_frag6_skb_cb/NFCT_FRAG6_CB
      net/mlx4_en: CHECKSUM_COMPLETE support for fragments
      ipv4: factorize sk_wmem_alloc updates done by __ip_append_data()
      ipv6: factorize sk_wmem_alloc updates done by __ip6_append_data()
      ipv6: frags: fix /proc/sys/net/ipv6/ip6frag_low_thresh

Eyal Birger (1):
      net: sched: add em_ipt ematch for calling xtables matches

Felix Fietkau (4):
      mac80211: support AP 4-addr mode fast-rx
      mac80211: support fast-rx with incompatible PS capabilities when PS is disabled
      mac80211: support station 4-addr mode fast-rx
      mac80211: support A-MSDU in fast-rx

Fengguang Wu (2):
      net: dsa: mv88e6xxx: fix boolreturn.cocci warnings
      enic: fix boolreturn.cocci warnings

Filip Sadowski (2):
      i40e: Add delay after EMP reset for firmware to recover
      i40e: Fix permission check for VF MAC filters

Finn Thain (14):
      net/8390: Remove redundant make dependencies
      net/8390: Fix msg_enable patch snafu
      net/mac8390: Convert to nubus_driver
      net/mac8390: Fix log messages
      net/macsonic: Convert to nubus_driver
      net/macsonic: Drop redundant MACH_IS_MAC test
      net/sonic: Clean up and modernize log messages
      net/sonic: Replace custom debug logging with netif_* calls
      net/macmace: Fix and clean up log messages
      net/macmace: Drop redundant MACH_IS_MAC test
      net/mac89x0: Remove redundant code
      net/mac89x0: Convert to platform_driver
      net/mac89x0: Fix and modernize log messages
      net/mac89x0: Replace custom debug logging with netif_* calls

Florian Fainelli (16):
      net: phy: aquantia: Utilize genphy_c45_aneg_done()
      net: phy: Export gen10g_* functions
      net: phy: teranetics: Utilize generic functions
      net: phy: cortina: Utilize generic functions
      net: phy: marvell10g: Utilize gen10g_no_soft_reset()
      net: dsa: mv88e6xxx: Fix missing register lock in serdes_get_stats
      net: systemport: Implement adaptive interrupt coalescing
      net: bcmgenet: Add support for adaptive RX coalescing
      net: bgmac: Use interface name to request interrupt
      net: bgmac: Mask interrupts during probe
      net: systemport: Remove adaptive TX coalescing
      net: systemport: Fix coalescing settings handling
      net: bcmgenet: Fix coalescing settings handling
      net: phy: phylink: Provide PHY interface to mac_link_{up, down}
      net: bgmac: Correctly annotate register space
      net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()

Florian Westphal (13):
      netfilter: x_tables: check standard verdicts in core
      netfilter: x_tables: check error target size too
      netfilter: x_tables: move hook entry checks into core
      netfilter: x_tables: enforce unique and ascending entry points
      netfilter: x_tables: cap allocations at 512 mbyte
      netfilter: x_tables: limit allocation requests for blob rule heads
      netfilter: x_tables: add counters allocation wrapper
      netfilter: compat: prepare xt_compat_init_offsets to return errors
      netfilter: compat: reject huge allocation requests
      netfilter: x_tables: make sure compat af mutex is held
      netfilter: x_tables: ensure last rule in base chain matches underflow/policy
      netfilter: x_tables: fix build with CONFIG_COMPAT=n
      Revert "netfilter: x_tables: ensure last rule in base chain matches underflow/policy"

Frans Meulenbroeks (1):
      fix typo in command value in drivers/net/phy/mdio-bitbang.

Fuyun Liang (15):
      net: hns3: add existence check when remove old uc mac address
      net: hns3: fix for netdev not running problem after calling net_stop and net_open
      net: hns3: fix for ipv6 address loss problem after setting channels
      net: hns3: unify the pause params setup function
      net: hns3: reallocate tx/rx buffer after changing mtu
      net: hns3: change GL update rate
      net: hns3: change the time interval of int_gl calculating
      net: hns3: fix for getting wrong link mode problem
      net: hns3: add get_link support to VF
      net: hns3: add querying speed and duplex support to VF
      net: hns3: fix for not returning problem in get_link_ksettings when phy exists
      net: hns3: fix for returning wrong value problem in hns3_get_rss_key_size
      net: hns3: fix for returning wrong value problem in hns3_get_rss_indir_size
      net: hns3: fix for the wrong shift problem in hns3_set_txbd_baseinfo
      net: hns3: fix for not initializing VF rss_hash_key problem

Gal Pressman (8):
      net: Fix spelling mistake "greater then" -> "greater than"
      net: Make RX-FCS and LRO mutually exclusive
      net: Make RX-FCS and HW GRO mutually exclusive
      net/mlx5e: Remove redundant check in get ethtool stats
      net/mlx5e: Make choose LRO timeout function static
      net/mlx5e: Add a helper macro in set features ndo
      net/mlx5e: Remove unused max inline related code
      net: Call add/kill vid ndo on vlan filter feature toggling

Ganapathi Bhat (4):
      Revert "mwifiex: fix incorrect ht capability problem"
      mwifiex: fix incorrect ht capability problem
      mwifiex: get_channel from firmware
      mwifiex: remove warnings in mwifiex_cmd_append_11n_tlv()

Ganesh Goudar (8):
      cxgb4: remove dead code when allocating filter
      cxgb4: Add TP Congestion map entry for single-port
      cxgb4: increase max tx rate limit to 100 Gbps
      cxgb4: do not display 50Gbps as unsupported speed
      cxgb4/cxgb4vf: check fw caps to set link mode mask
      cxgb4: notify fatal error to uld drivers
      cxgb4: depend on firmware event for link status
      cxgb4: support new ISSI flash parts

Geert Uytterhoeven (1):
      netfilter: xt_limit: Spelling s/maxmum/maximum/

GhantaKrishnamurthy MohanKrishna (3):
      tipc: modify socket iterator for sock_diag
      tipc: implement socket diagnostics for AF_TIPC
      tipc: step sk->sk_drops when rcv buffer is full

Govind Singh (1):
      ath10k: fix log message for hif power on failure

Govindarajulu Varadarajan (7):
      enic: Check inner ip proto for pseudo header csum
      enic: Add vxlan offload support for IPv6 pkts
      enic: Check if hw supports multi wq with vxlan offload
      enic: set UDP rss flag
      enic: enable rq before updating rq descriptors
      enic: set IG desc cache flag in open
      enic: drop IP proto check for vxlan tunnel delete

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: enable vlan rx vlan offload

Gustavo A R Silva (1):
      i40evf/i40evf_main: Fix variable assignment in i40evf_parse_cls_flower

Gustavo A. R. Silva (18):
      net: dsa: mv88e6xxx: hwtstamp: remove unnecessary range checking tests
      rds: send: mark expected switch fall-through in rds_rm_size
      ssb: return boolean instead of integer in ssb_dma_translation_special_bit
      netfilter: ipt_ah: return boolean instead of integer
      xfrm_policy: use true and false for boolean values
      tipc: bcast: use true and false for boolean values
      ipv6: ndisc: use true and false for boolean values
      cxgb3: remove VLA usage
      pktgen: Remove VLA usage
      ipvs: use true and false for boolean values
      pktgen: Fix memory leak in pktgen_if_write
      netfilter: cttimeout: remove VLA usage
      netfilter: nfnetlink_cthelper: Remove VLA usage
      netfilter: nf_tables: remove VLA usage
      net/mlx5: Fix use-after-free
      dpaa_eth: use true and false for boolean values
      qed: Use true and false for boolean values
      Bluetooth: Mark expected switch fall-throughs

Haim Dreyfuss (4):
      iwlwifi: api: Add geographic profile information to MCC_UPDATE_CMD
      cfg80211: read wmm rules from regulatory database
      mac80211: limit wmm params to comply with ETSI requirements
      cfg80211: Add API to allow querying regdb for wmm_rule

Haiyang Zhang (3):
      hv_netvsc: Fix the return status in RX path
      hv_netvsc: Add range checking for rx packet offset and length
      hv_netvsc: Clean up extra parameter from rndis_filter_receive_data()

Hangbin Liu (1):
      vlan: also check phy_driver ts_info for vlan's real device

Hans de Goede (6):
      Bluetooth: hci_bcm: Add irq_polarity module option
      Bluetooth: hci_bcm: Treat Interrupt ACPI resources as always being active-low
      Bluetooth: hci_bcm: Add 6 new ACPI HIDs
      Bluetooth: hci_bcm: Remove duplication in gpio-mappings declaration
      Bluetooth: hci_bcm: Do not tie GPIO pin order to a specific ACPI HID
      Bluetooth: hci_bcm: Add ACPI HIDs found in Windows .inf files and DSTDs

Harry Morris (1):
      ieee802154: ca8210: fix uninitialised data read

Harshitha Ramamurthy (8):
      i40evf: Use an iterator of the same type as the list
      i40evf: Make VF reset warning message more clear
      virtchnl: Add virtchl structures to support queue channels
      i40evf: add ndo_setup_tc callback to i40evf
      i40evf: Add support to configure bw via tc tool
      virtchnl: Add a macro to check the size of a union
      virtchnl: Add filter data structures
      i40evf: Add support to apply cloud filters

Heiner Kallweit (14):
      r8169: remove some WOL-related dead code
      r8169: remove not needed PHY soft reset in rtl8168e_2_hw_phy_config
      r8169: disable WOL per default
      r8169: simplify and improve check for dash
      r8169: improve interrupt handling
      r8169: convert remaining feature flag and remove enum features
      r8169: fix interrupt number after adding support for MSI-X interrupts
      net: phy: remove phy_error from phy_disable_interrupts
      net: phy: use phy_disable_interrupts in phy_stop
      net: phy: set link state to down when creating the phy_device
      r8169: simplify rtl_set_mac_address
      r8169: change type of first argument in rtl_tx_performance_tweak
      r8169: change type of argument in rtl_disable/enable_clock_request
      r8169: add helper tp_to_dev

Hernán Gonzalez (2):
      qlogic/qed: Constify *pkt_type_str[]
      emulex/benet: Constify *be_misconfig_evt_port_state[]

Ian W MORRISON (1):
      Bluetooth: hci_bcm: Remove DMI quirk for the MINIX Z83-4

Ido Schimmel (16):
      mlxsw: spectrum_switchdev: Allow port enslavement to a VLAN-unaware bridge
      team: Use extack to report enslavement failures
      selftests: forwarding: Add initial testing framework
      selftests: forwarding: Add a test for FDB learning
      selftests: forwarding: Add a test for flooded traffic
      selftests: forwarding: Add a test for basic IPv4 and IPv6 routing
      selftests: forwarding: Create test topology for multipath routing
      selftests: forwarding: Test IPv4 weighted nexthops
      selftests: forwarding: Test IPv6 weighted nexthops
      selftests: forwarding: Add a test for VLAN-unaware bridge
      selftests: forwarding: Exit with error when missing dependencies
      selftests: forwarding: Exit with error when missing interfaces
      selftests: forwarding: Allow creation of interfaces without a config file
      mlxsw: spectrum_acl: Adapt ACL configuration to new firmware versions
      mlxsw: spectrum_acl: Do not invalidate already invalid ACL groups
      mlxsw: spectrum_span: Prevent duplicate mirrors

Ignacio Nunez Hernanz (1):
      ath10k: make ath10k report discarded packets to mac80211

Ilan Peer (3):
      mac80211: Call mgd_prep_tx before transmitting deauthentication
      mac80211: agg-rx: Accept ADDBA request update if timeout did not change
      iwlwifi: mvm: Allow iwl_mvm_mac_mgd_prepare_tx() when associated

Inbar Karmy (3):
      net/mlx5e: Expose PFC stall prevention counters
      ethtool: Add support for configuring PFC stall prevention in ethtool
      net/mlx5e: PFC stall prevention support

Intiyaz Basha (19):
      liquidio: Corrected Rx bytes counting
      liquidio: Resolved mbox read issue while reading more than one 64bit data
      liquidio: Simplified napi poll
      liquidio: Added support for trusted VF
      liquidio: Moved common function txqs_stop to octeon_network.h
      liquidio: Moved common function txqs_wake to octeon_network.h
      liquidio: Moved common function txqs_start to octeon_network.h
      liquidio: Moved common function skb_iq to to octeon_network.h
      liquidio: Removed one line function stop_txq
      liquidio: Removed start_txq function
      liquidio: Removed netif_is_multiqueue check
      liquidio: Removed one line function stop_q
      liquidio: Removed one line function wake_q
      liquidio: Function call skb_iq for deriving queue from skb
      liquidio: Renamed txqs_wake to wake_txqs
      liquidio: Renamed txqs_stop to stop_txqs
      liquidio: Renamed txqs_start to start_txqs
      liquidio: Removed duplicate Tx queue status check
      liquidio: Prioritize control messages

Jack Ma (1):
      netfilter: xt_conntrack: Support bit-shifting for CONNMARK & MARK targets.

Jacob Keller (19):
      i40evf: use __dev_[um]c_sync routines in .set_rx_mode
      ixgbe: prevent ptp_rx_hang from running when in FILTER_ALL mode
      fm10k: fix function doxygen comments
      fm10k: fix incorrect warning for function prototype
      fm10k: bump version number
      i40e: Cleanup i40e_vlan_rx_register
      i40e: track filter type statistics when deleting invalid filters
      i40e: factor out re-enable functions for ATR and SB
      i40e: restore TCPv4 input set when re-enabling ATR
      i40e: add doxygen comment for new mode parameter
      i40evf: remove flags that are never used
      i40e: move I40E_FLAG_FILTER_SYNC to a state bit
      i40e: move I40E_FLAG_UDP_FILTER_SYNC to the state field
      i40e: move AUTO_DISABLED flags into the state field
      i40e: move I40E_FLAG_TEMP_LINK_POLLING to state field
      i40e: move client flags into state bits
      i40e: hold the RTNL lock while changing interrupt schemes
      i40e: stop using cmpxchg flow in i40e_set_priv_flags()
      i40e: re-number feature flags to remove gaps

Jaganath Kanakkassery (1):
      Bluetooth: Fix data type of appearence

Jake Moroni (2):
      dpaa_eth: fix incorrect comment
      dpaa_eth: fix pause capability advertisement logic

Jakub Kicinski (17):
      nfp: add Makefiles to all directories
      aquantia: add Makefiles to all directories
      tools: bpftool: fix dependency file path
      tools: bpftool: fix potential format truncation
      tools: bpf: cleanup PHONY target
      tools: bpf: remove feature detection output
      nfp: bpf: rename map_lookup_stack() to map_call_stack_common()
      nfp: bpf: add helper for validating stack pointers
      nfp: bpf: add helper for basic map call checks
      nfp: bpf: add map updates from the datapath
      nfp: bpf: add map deletes from the datapath
      bpf: add parenthesis around argument of BPF_LDST_BYTES()
      nfp: bpf: add basic support for atomic adds
      nfp: bpf: expose command delay slots
      nfp: bpf: add support for atomic add of unknown values
      nfp: bpf: add support for bpf_get_prandom_u32()
      nfp: bpf: improve wrong FW response warnings

Jan Sokolowski (1):
      i40e: Properly check allowed advertisement capabilities

Jason Wang (2):
      virtio-net: re enable XDP_REDIRECT for mergeable buffer
      tuntap: XDP_TX can use native XDP

Jay Vosburgh (1):
      virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS

Jeff Kirsher (1):
      intel: add SPDX identifiers to all the Intel drivers

Jerome Brunet (1):
      net: phy: mdio-mux: slience probe defer error

Jesper Dangaard Brouer (2):
      net: avoid including xdp.h in filter.h
      selftests/bpf: fix Makefile for cgroup_helpers.c

Jesus Sanchez-Palencia (1):
      sock: Fix SO_ZEROCOPY switch case

Jia-Ju Bai (4):
      Bluetooth: hci_ath: Replace mdelay with msleep in ath_wakeup_ar3k
      Bluetooth: btmrvl_main: Replace GFP_ATOMIC with GFP_KERNEL in btmrvl_send_sync_cmd
      Bluetooth: hci_ll: Replace mdelay with msleep in download_firmware
      bcma: Replace mdelay with usleep_range in bcma_pmu_resources_init

Jian Shen (4):
      net: hns3: fix error type definition of return value
      net: hns3: fix return value error of hclge_get_mac_vlan_cmd_status()
      net: hns3: add existence checking before adding unicast mac address
      net: hns3: add result checking for VF when modify unicast mac address

Jiong Wang (10):
      tools: bpftool: remove unnecessary 'if' to reduce indentation
      tools: bpftool: factor out xlated dump related code into separate file
      tools: bpftool: detect sub-programs from the eBPF sequence
      tools: bpftool: partition basic-block for each function in the CFG
      tools: bpftool: add out edges for each basic-block
      tools: bpftool: generate .dot graph from CFG information
      tools: bpftool: new command-line option and documentation for 'visual'
      nfp: bpf: read from packet data cache for PTR_TO_PACKET
      nfp: bpf: support unaligned read offset
      nfp: bpf: detect packet reads could be cached, enable the optimisation

Jiri Benc (7):
      tools: bpftool: silence 'missing initializer' warnings
      tools: bpf: respect output directory during build
      tools: bpf: consistent make bpf_install
      tools: bpf: make install should build first
      tools: bpf: call descend in Makefile
      tools: bpf: respect quiet/verbose build
      tools: bpf: silence make by not deleting intermediate file

Jiri Olsa (2):
      bpf: Remove struct bpf_verifier_env argument from print_bpf_insn
      bpftool: Adjust to new print_bpf_insn interface

Jiri Pirko (18):
      selftests: forwarding: Add tc offload check helper
      selftests: forwarding: Add MAC get helper
      selftests: forwarding: Allow to get netdev interfaces names from commandline
      selftests: forwarding: Introduce tc flower matching tests
      selftests: forwarding: Introduce tc actions tests
      selftests: forwarding: Introduce basic tc chains tests
      selftests: forwarding: Introduce basic shared blocks tests
      selftests: forwarding: fix "ok" action test
      selftests: forwarding: fix flags passed to first drop rule in gact_drop_and_ok_test
      mlxsw: spectrum_acl: Fix flex actions header ifndef define construct
      mlxsw: spectrum_kvdl: Fix handling of resource_size_param
      mlxsw: Constify devlink_resource_ops
      mlxsw: spectrum: Change KVD linear parts from list to array
      mlxsw: remove kvd_hash_granularity from config profile struct
      mlxsw: core: Fix arg name of MLXSW_CORE_RES_VALID and MLXSW_CORE_RES_GET
      mlxsw: Move "used_kvd_sizes" check to mlxsw_pci_config_profile
      mlxsw: Move "resources_query_enable" out of mlxsw_config_profile
      mlxsw: spectrum: Pass mlxsw_core as arg of mlxsw_sp_kvdl_resources_register()

Jisheng Zhang (3):
      net: mvneta: remove duplicate *_coal assignment
      net: mvneta: split rxq/txq init and txq deinit into SW and HW parts
      net: mvneta: improve suspend/resume

Joe Perches (10):
      net: drivers/net: Remove unnecessary skb_copy_expand OOM messages
      net: Use octal not symbolic permissions
      drivers/net: Use octal not symbolic permissions
      ethernet: Use octal not symbolic permissions
      wireless: Use octal not symbolic permissions
      ipv6: addrconf: Use normal debugging style
      ath: Remove unnecessary ath_bcast_mac and use eth_broadcast_addr
      netfilter: ebt_stp: Use generic functions for comparisons
      netfilter: ipset: Use is_zero_ether_addr instead of static and memcmp
      ethernet: hisilicon: hns: hns_dsaf_mac: Use generic eth_broadcast_addr

Joe Stringer (4):
      selftests/bpf: Print unexpected output on fail
      selftests/bpf: Count tests skipped by unpriv
      selftests/bpf: Only run tests if !bpf_disabled
      bpf: Remove unused callee_saved array

Johan Hovold (2):
      net: kalmia: clean up bind error path
      net: cdc_eem: clean up bind error path

Johannes Berg (7):
      nl80211: remove unnecessary genlmsg_cancel() calls
      mac80211: support reporting A-MPDU EOF bit value/known
      brcmfmac: reject too long PSK
      mac80211_hwsim: fix secondary MAC address assignment
      cfg80211: don't require RTNL held for regdomain reads
      mac80211: remove shadowing duplicated variable
      Merge branch 'eapol-over-nl80211' into mac80211-next

John Allen (2):
      ibmvnic: Fix reset return from closed state
      ibmvnic: Disable irqs before exiting reset from closed state

John Fastabend (22):
      sock: make static tls function alloc_sg generic sock helper
      sockmap: convert refcnt to an atomic refcnt
      net: do_tcp_sendpages flag to avoid SKBTX_SHARED_FRAG
      net: generalize sk_alloc_sg to work with scatterlist rings
      bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data
      bpf: sockmap, add bpf_msg_apply_bytes() helper
      bpf: sockmap, add msg_cork_bytes() helper
      bpf: sk_msg program helper bpf_sk_msg_pull_data
      bpf: add map tests for BPF_PROG_TYPE_SK_MSG
      bpf: add verifier tests for BPF_PROG_TYPE_SK_MSG
      bpf: sockmap sample, add option to attach SK_MSG program
      bpf: sockmap sample, add sendfile test
      bpf: sockmap sample, add data verification option
      bpf: sockmap, add sample option to test apply_bytes helper
      bpf: sockmap sample support for bpf_msg_cork_bytes()
      bpf: sockmap add SK_DROP tests
      bpf: sockmap sample test for bpf_msg_pull_data
      bpf: sockmap test script
      bpf: sockmap redirect ingress support
      bpf: sockmap, add BPF_F_INGRESS tests
      bpf: sockmap, BPF_F_INGRESS flag for BPF_SK_SKB_STREAM_VERDICT:
      bpf: sockmap, more BPF_SK_SKB_STREAM_VERDICT tests

John Hurley (2):
      nfp: modify app MTU setting callbacks
      nfp: flower: offload phys port MTU change

Jon Maloy (30):
      tipc: apply bearer link tolerance on running links
      tipc: remove redundant code in topology server
      tipc: remove unnecessary function pointers
      tipc: eliminate struct tipc_subscriber
      tipc: simplify interaction between subscription and topology connection
      tipc: simplify endianness handling in topology subscriber
      tipc: collapse subscription creation functions
      tipc: some prefix changes
      tipc: make struct tipc_server private for server.c
      tipc: separate topology server listener socket from subcsriber sockets
      tipc: rename tipc_server to tipc_topsrv
      tipc: fix bug on error path in tipc_topsrv_kern_subscr()
      tipc: obsolete TIPC_ZONE_SCOPE
      tipc: remove zone publication list in name table
      tipc: remove zone_list member in struct publication
      tipc: merge two lists in struct publication
      tipc: some name changes
      tipc: refactor function tipc_enable_bearer()
      tipc: some cleanups in the file discover.c
      tipc: remove restrictions on node address values
      tipc: allow closest-first lookup algorithm when legacy address is configured
      tipc: remove direct accesses to own_addr field in struct tipc_net
      tipc: add 128-bit node identifier
      tipc: handle collisions of 32-bit node address hash values
      tipc: obtain node identity from interface by default
      tipc: replace name table service range array with rb tree
      tipc: refactor name table translate function
      tipc: permit overlapping service ranges in name table
      tipc: tipc: rename address types in user api
      tipc: avoid possible string overflow

Jon Nettleton (1):
      sfp: add high power module support

Jonathan Neuschäfer (3):
      net: core: dst_cache: Fix a typo in a comment
      net: core: dst_cache_set_ip6: Rename 'addr' parameter to 'saddr' for consistency
      net: core: dst: Add kernel-doc for 'net' parameter

Jose Abreu (2):
      net: stmmac: Rework and fix TX Timeout code
      net: stmmac: Add support for DWMAC5 and implement Safety Features

Julian Wiedmann (12):
      s390/qeth: use __ipa_cmd() for casting an IPA cmd buffer
      s390/qeth: remove outdated portname debug msg
      s390/qeth: support SG for more device types
      s390/qeth: advertise IFF_UNICAST_FLT
      s390/qeth: pass correct length to header_ops->create()
      s390/qeth: allocate skb from NAPI cache
      s390/qeth: reduce RX skb setup
      s390/qeth: reset NAPI context during queue init
      s390/qeth: restructure IP notification handlers
      s390/qeth: simplify card look-up on IP notification
      s390/qeth: extract helpers for managing special IPs
      s390/qeth: shrink qeth_ipaddr struct

Kai-Heng Feng (1):
      sky2: Increase D3 delay to sky2 stops working after suspend

Kalle Valo (5):
      Merge ath-next from git://git.kernel.org/.../kvalo/ath.git
      Merge git://git.kernel.org/.../kvalo/wireless-drivers.git
      Merge tag 'iwlwifi-next-for-kalle-2018-03-28' of git://git.kernel.org/.../iwlwifi/iwlwifi-next
      ath10k: refactor ath10k_pci_dump_memory() in preparation for QCA9984 support
      Merge ath-next from git://git.kernel.org/.../kvalo/ath.git

Karsten Graul (11):
      net/smc: move netinfo function to file smc_clc.c
      net/smc: remove unused fields from smc structures
      net/smc: respond to test link messages
      net/smc: process confirm/delete rkey messages
      net/smc: do not allow eyecatchers in rmbe
      net/smc: process add/delete link messages
      net/smc: prevent new connections on link group
      net/smc: schedule free_work when link group is terminated
      net/smc: restructure netinfo for CLC proposal msgs
      net/smc: add ipv6 support to CLC layer
      net/smc: enable ipv6 support for smc

Karthikeyan Periyasamy (2):
      ath10k: Fix kernel panic while using worker (ath10k_sta_rc_update_wk)
      Revert "ath10k: send (re)assoc peer command when NSS changed"

Kevin Lo (1):
      rtlwifi: correct comment

Kirill Tkhai (158):
      net: Assign net to net_namespace_list in setup_net()
      net: Cleanup in copy_net_ns()
      net: Introduce net_sem for protection of pernet_list
      net: Move mutex_unlock() in cleanup_net() up
      net: Allow pernet_operations to be executed in parallel
      net: Convert proc_net_ns_ops
      net: Convert net_ns_ops methods
      net: Convert sysctl_pernet_ops
      net: Convert netfilter_net_ops
      net: Convert nf_log_net_ops
      net: Convert net_inuse_ops
      net: Convert net_defaults_ops
      net: Convert netlink_net_ops
      net: Convert rtnetlink_net_ops
      net: Convert audit_net_ops
      net: Convert uevent_net_ops
      net: Convert proto_net_ops
      net: Convert pernet_subsys ops, registered via net_dev_init()
      net: Convert fib_* pernet_operations, registered via subsys_initcall
      net: Convert subsys_initcall() registered pernet_operations from net/sched
      net: Convert genl_pernet_ops
      net: Convert wext_pernet_ops
      net: Convert sysctl_core_ops
      net: Convert pernet_subsys, registered from inet_init()
      net: Convert unix_net_ops
      net: Convert packet_net_ops
      net: Convert ipv4_sysctl_ops
      net: Convert addrconf_ops
      net: Convert loopback_net_ops
      net: Convert default_device_ops
      net: Convert diag_net_ops
      net: Convert netlink_tap_net_ops
      net: Make extern and export get_net_ns()
      net: Export open_related_ns()
      tun: Add ioctl() SIOCGSKNS cmd to allow obtaining net ns of tun device
      net: Convert inet6_net_ops
      net: Convert cfg80211_pernet_ops
      net: Convert ip6mr_net_ops
      net: Convert icmpv6_sk_ops, ndisc_net_ops and igmp6_net_ops
      net: Convert raw6_net_ops, udplite6_net_ops, ipv6_proc_ops, if6_proc_net_ops and ip6_route_net_late_ops
      net: Convert ipv6_inetpeer_ops
      net: Convert fib6_rules_net_ops
      net: Convert tcpv6_net_ops
      net: Convert ipv6_sysctl_net_ops
      net: Convert ping_v6_net_ops
      net: Convert ip6_flowlabel_net_ops
      net: Convert xfrm6_net_ops
      net: Convert fib6_net_ops, ipv6_addr_label_ops and ip6_segments_ops
      net: Convert ip6_frags_ops
      net: Convert ip_tables_net_ops, udplite6_net_ops and xt_net_ops
      net: Convert iptable_filter_net_ops
      net: Kill net_mutex
      net: Make cleanup_list and net::cleanup_list of llist type
      net: Queue net_cleanup_work only if there is first net added
      net: Convert /proc creating and destroying pernet_operations
      net: Convert hashlimit_net_ops and recent_net_ops
      net: Convert synproxy_net_ops
      net: Convert nfs_net_ops
      net: Convert simple pernet_operations
      net: Convert cma_pernet_operations
      net: Convert sysctl creating and destroying pernet_operations
      net: Convert tc_action_net_init() and tc_action_net_exit() based pernet_operations
      net: Convert bond_net_ops
      net: Convert geneve_net_ops
      net: Convert gtp_net_ops
      net: Convert ppp_net_ops
      net: Convert vxlan_net_ops
      net: Convert br_net_ops
      net: Convert ipgre_net_ops, ipgre_tap_net_ops, erspan_net_ops, vti_net_ops and ipip_net_ops
      net: Convert ip6gre_net_ops
      net: Convert ip6_tnl_net_ops
      net: Convert vti6_net_ops
      net: Convert sit_net_ops
      net: Convert cfg802154_pernet_ops
      net: Convert ipvlan_net_ops
      net: Convert brnf_net_ops
      net: Convert clusterip_net_ops
      net: Convert defrag4_net_ops
      net: Convert ila_net_ops
      net: Convert defrag6_net_ops
      net: Convert selinux_net_ops
      net: Convert smack_net_ops
      mac80211_hwsim: Make hwsim_netgroup IDA
      net: Convert hwsim_net_ops
      net: Convert broute_net_ops, frame_filter_net_ops and frame_nat_net_ops
      net: Convert log pernet_operations
      net: Convert arp_tables_net_ops and ip6_tables_net_ops
      net: Convert caif_net_ops
      net: Convert cangw_pernet_ops
      net: Convert dccp_v4_ops
      net: Convert dccp_v6_ops
      net: Convert fou_net_ops
      net: Convert ip_set_net_ops
      net: Convert nf_conntrack_net_ops
      net: Convert ctnetlink_net_ops
      net: Convert proto_gre_net_ops
      net: Make account struct net to memcg
      net: Convert ip6 tables pernet_operations
      net: Convert xfrm_user_net_ops
      net: Convert nf_tables_net_ops
      net: Convert nfnetlink_net_ops
      net: Convert nfnl_acct_ops
      net: Convert cttimeout_ops
      net: Convert nfnl_log_net_ops
      net: Convert nfnl_queue_net_ops
      net: Convert pg_net_ops
      net: Convert arptable_filter_net_ops
      net: Convert iptable_mangle_net_ops
      net: Convert iptable_nat_net_ops
      net: Convert iptable_raw_net_ops
      net: Convert iptable_security_net_ops
      net: Convert ipv4_net_ops
      net: Convet ipv6_net_ops
      net: Convert sctp_defaults_ops
      net: Convert sctp_ctrlsock_ops
      net: Convert tipc_net_ops
      net: Convert rds_tcp_net_ops
      net: Add comment about pernet_operations methods and synchronization
      net: Add rtnl_lock_killable()
      net: Use rtnl_lock_killable() in register_netdev()
      net: Convert l2tp_net_ops
      net: Convert mpls_net_ops
      net: Convert ovs_net_ops
      net: Convert ipvs_core_ops
      net: Convert ipvs_core_dev_ops
      net: Convert ip_vs_ftp_ops
      net: Convert can_pernet_ops
      net: Convert lowpan_frags_ops
      net: Convert nf_ct_net_ops
      net: Revert "ipv4: get rid of ip_ra_lock"
      net: Move IP_ROUTER_ALERT out of lock_sock(sk)
      net: Revert "ipv4: fix a deadlock in ip_ra_control"
      net: Make ip_ra_chain per struct net
      net: Replace ip_ra_lock with per-net mutex
      net: Convert udp_sysctl_ops
      net: Convert rxrpc_net_ops
      net: Make NETDEV_XXX commands enum { }
      infiniband: Replace usnic_ib_netdev_event_to_string() with netdev_cmd_to_name()
      net: Drop NETDEV_UNREGISTER_FINAL
      net: Convert rpcsec_gss_net_ops
      net: Convert sunrpc_net_ops
      net: Convert nfs4_dns_resolver_ops
      net: Convert nfs4blocklayout_net_ops
      net: Convert nfsd_net_ops
      net: Reflect all pernet_operations are converted
      net: Drop pernet_operations::async
      net: Rename net_sem to pernet_ops_rwsem
      net: Add more comments
      net: Introduce net_rwsem to protect net_namespace_list
      net: Don't take rtnl_lock() in wireless_nlevent_flush()
      security: Remove rtnl_lock() in selinux_xfrm_notify_policyload()
      ovs: Remove rtnl_lock() from ovs_exit_net()
      net: Remove rtnl_lock() in nf_ct_iterate_destroy()
      xfrm: Register xfrm_dev_notifier in appropriate place
      netfilter: Rework xt_TEE netdevice notifier
      net: Close race between {un, }register_netdevice_notifier() and setup_net()/cleanup_net()
      net: Remove net_rwsem from {, un}register_netdevice_notifier()
      net: Do not take net_rwsem in __rtnl_link_unregister()

Kunihiko Hayashi (2):
      dt-bindings: net: ave: add PXs3 support
      net: ethernet: ave: add UniPhier PXs3 support

Larry Finger (1):
      Bluetooth: btusb: Add device ID for RTL8822BE

Leo Yan (1):
      samples/bpf: Add program for CPU state statistics

Leon Romanovsky (2):
      net/mlx5: Fix wrongly assigned CQ reference counter
      net/mlx5: Protect from command bit overflow

Li RongQing (1):
      net: sched: do not emit messages while holding spinlock

Linus Lüssing (3):
      batman-adv: Avoid redundant multicast TT entries
      batman-adv: add DAT cache netlink support
      batman-adv: add multicast flags netlink support

Lior David (8):
      wil6210: add wil6210_vif structure for per-VIF data
      wil6210: support concurrency record in FW file
      wil6210: infrastructure for multiple virtual interfaces
      wil6210: add support for adding and removing virtual interfaces
      wil6210: multiple VIFs support for start/stop AP
      wil6210: rename p2p_wdev_mutex to vif_mutex
      wil6210: multiple VIFs support for connections and data path
      wil6210: add debugfs 'mids' file

Loic Poulain (3):
      wcn36xx: Fix warning due to duplicate scan_completed notification
      wcn36xx: Fix firmware crash due to corrupted buffer address
      Bluetooth: hci_bcm: use gpiod cansleep version

Lorenzo Bianconi (16):
      mt76x2: remove warnings in mt76x2_mac_write_txwi()
      mt7601u: move mt7601u_set_macaddr in mac related code
      mt7601u: set device mac address in mt7601u_add_interface()
      mt7601u: make write with mask access atomic
      mt76: initialize available_antennas_{tx,rx} info
      mt76: add mt76_init_stream_cap routine
      mt76x2: add mac80211 {set,get}_antenna callbacks
      mt7601u: remove a warning in mt7601u_efuse_physical_size_check()
      mt76x2: remove unnecessary len variable in mt76x2_eeprom_load()
      mt7601u: simplify mt7601u_mcu_msg_alloc signature
      mt7601u: let mac80211 validate rx CCMP PN
      mt76: use mt76_poll_msec routine in mt76pci_load_firmware()
      mt76x2: fix possible NULL pointer dereferencing in mt76x2_tx()
      mt76x2: fix warning in ieee80211_get_key_rx_seq()
      ipv6: do not set routes if disable_ipv6 has been enabled
      Documentation: ip-sysctl.txt: clarify disable_ipv6

Luca Coelho (2):
      iwlwifi: mvm: check if mac80211_queue is valid in iwl_mvm_disable_txq
      iwlwifi: add a bunch of new 9000 PCI IDs

Lucas Bates (2):
      tc-testing: Correct compound statements for namespace execution
      tc-testing: Add newline when writing test case files

Madalin Bucur (4):
      dpaa_eth: fix SG mapping
      dpaa_eth: make sure all Rx errors are counted
      dpaa_eth: refactor frag count checking
      fsl/fman: remove unnecessary set_dma_ops() call and HAS_DMA dependency

Maharaja Kennadyrajan (1):
      ath10k: debugfs support to get final TPC stats for 10.4 variants

Manikanta Pubbisetty (1):
      mac80211: allow AP_VLAN operation on crypto controlled devices

Marc Dionne (1):
      rxrpc: Fix resend event time calculation

Marcel Holtmann (5):
      Bluetooth: hci_bcm: Use default baud rate if missing shutdown GPIO
      Bluetooth: hci_ll: Use skb_put_u8 instead of struct hcill_cmd
      Bluetooth: hci_ll: Convert to use h4_recv_buf helper
      Bluetooth: bpa10x: Use separate h4_recv_buf helper
      Bluetooth: Remove unused btuart_cs driver

Mariusz Stachura (2):
      i40e: link_down_on_close private flag support
      i40e: fix for wrong partition id calculation on OCP mezz cards

Mark Bloch (15):
      net/mlx5: E-Switch, Add callback to get representor device
      net/mlx5: E-Switch, Move representors definition to a global scope
      net/mlx5: E-Switch, Increase number of FTEs in FDB in switchdev mode
      net/mlx5: E-Switch, Optimize HW steering tables in switchdev mode
      net/mlx5: E-Switch, Add definition of IB representor
      IB/mlx5: Add basic regiser/unregister representors code
      IB/mlx5: Allocate flow DB only on PF IB device
      IB/mlx5: Add match on vport when in switchdev mode
      IB/mlx5: Listen to netdev register/unresiter events in switchdev mode
      IB/mlx5: When in switchdev mode, expose only raw packet capabilities
      IB/mlx5: Don't expose MR cache in switchdev mode
      IB/mlx5: E-Switch, Add rule to forward traffic to vport
      IB/mlx5: Add proper representors support
      net/mlx5: E-Switch, Reload IB interface when switching devlink modes
      IB/mlx5: Disable self loopback check when in switchdev mode

Markus Elfring (2):
      Bluetooth: btmrvl: Delete an unnecessary variable initialisation in btmrvl_sdio_register_dev()
      Bluetooth: btmrvl: Delete an unnecessary variable initialisation in btmrvl_sdio_card_to_host()

Martin Blumenstingl (5):
      net: stmmac: dwmac-meson8b: simplify clock registration
      net: stmmac: dwmac-meson8b: only keep struct device around
      net: stmmac: dwmac-meson8b: make the clock configurations private
      dt-bindings: net: meson-dwmac: add support for the Meson8m2 SoC
      net: stmmac: dwmac-meson8b: Add support for the Meson8m2 SoC

Martin KaFai Lau (2):
      bpf: Rename bpf_verifer_log
      bpf: Add bpf_verifier_vlog() and bpf_verifier_log_needed()

Matan Barak (4):
      net/mlx5: FPGA and IPSec initialization to be before flow steering
      {net,IB}/mlx5: Add has_tag to mlx5_flow_act
      net/mlx5: Add shim layer between fs and cmd
      net/mlx5: Embed mlx5_flow_act into fs_fte

Mathias Kresin (2):
      net: phy: intel-xway: add VR9 version number
      net: phy: intel-xway: add VR9 v1.1 phy ids

Matt Redfearn (2):
      ssb: Prevent build of PCI host features in module
      bcma: Prevent build of PCI host features in module

Matteo Croce (2):
      ipvlan: drop ipv6 dependency
      ipvlan: selects master_l3 device instead of depending on it

Matthew Wilcox (1):
      mlx5: Remove call to ida_pre_get

Matthias Kaehlcke (1):
      rtlwifi: rtl8192cu: Remove variable self-assignment in rf.c

Matthias Schiffer (3):
      batman-adv: always assume 2-byte packet alignment
      netfilter: ebtables: add support for matching ICMP type and code
      netfilter: ebtables: add support for matching IGMP type

Maxim Zhukov (5):
      Bluetooth: ath3k: replace hardcode numbers with define
      Bluetooth: ath3k: do not init variables
      Bluetooth: ath3k: remove blank line after if
      Bluetooth: ath3k: Fix warning: quoted string split across lines
      Bluetooth: ath3k: fix checkpatch warning

Maxime Chevallier (5):
      net: mvpp2: Add hardware offloading for VLAN filtering
      net: mvpp2: Simplify MAC filtering function parameters
      net: mvpp2: Add support for unicast filtering
      net: mvpp2: Make mvpp2_prs_hw_read a parser entry init function
      net: mvpp2: Don't use dynamic allocs for local variables

Michael Chan (12):
      bnxt_en: Update firmware interface to 1.9.1.15.
      bnxt_en: Adjust default rings for multi-port NICs.
      bnxt_en: Use a dedicated VNIC mode for RDMA.
      bnxt_en: Check max_tx_scheduler_inputs value from firmware.
      bnxt_en: Improve resource accounting for SRIOV.
      bnxt_en: Improve valid bit checking in firmware response message.
      bnxt_en: Improve ring allocation logic.
      bnxt_en: Change IRQ assignment for RDMA driver.
      bnxt_en: Add IRQ remapping logic.
      bnxt_en: Refactor bnxt_need_reserve_rings().
      bnxt_en: Reserve completion rings and MSIX for bnxt_re RDMA driver.
      bnxt_en: Add ULP calls to stop and restart IRQs.

Michael Rapson (1):
      nfp: standardize FW header whitespace

Michal Kalderon (1):
      qed*: Utilize FW 8.33.11.0

Mika Westerberg (1):
      igb: Do not call netif_device_detach() when PCIe link goes missing

Mike Looijmans (2):
      of_net: Implement of_get_nvmem_mac_address helper
      net: macb: Try to retrieve MAC addess from nvmem provider

Mitch Williams (1):
      i40e: don't leak memory addresses

Mordechay Goodstein (1):
      iwlwifi: set default timstamp marker cmd

Moritz Fischer (2):
      dt-bindings: net: Add bindings for National Instruments XGE netdev
      net: ethernet: nixge: Add support for National Instruments XGE netdev

Moshe Shemesh (4):
      net/mlx5: Add support for QUERY_VNIC_ENV command
      net/mlx5e: Add vnic steering drop statistics
      net/mlx5: Add packet dropped while vport down statistics
      net/mlx5e: Add interface down dropped packets statistics

Nathan Fontenot (7):
      ibmvnic: Rename active queue count variables
      ibmvnic: Move active sub-crq count settings
      ibmvnic: Free and re-allocate scrqs when tx/rx scrqs change
      ibmvnic: Make napi usage dynamic
      ibmvnic: Allocate max queues stats buffers
      ibmvnic: Correct goto target for tx irq initialization failure
      ibmvnic: Split counters for scrq/pools/napi

Neil Horman (1):
      sctp: Fix double free in sctp_sendmsg_to_asoc

Nikita V. Shirokov (1):
      bpf: Add sock_ops R/W access to ipv4 tos

Niklas Cassel (11):
      net: stmmac: set MSS for each tx DMA channel
      net: stmmac: do not clear tx_skbuff entries in stmmac_xmit()/stmmac_tso_xmit()
      net: stmmac: WARN if tx_skbuff entries are reused before cleared
      net: stmmac: rename dwmac4_tx_queue_routing() to match reality
      net: stmmac: call correct function in stmmac_mac_config_rx_queues_routing()
      net: stmmac: add error handling in stmmac_mtl_setup()
      net: stmmac: honor error code from stmmac_dt_phy()
      net: stmmac: ensure that the MSS desc is the last desc to set the own bit
      net: stmmac: use correct barrier between coherent memory and MMIO
      net: stmmac: ensure that the device has released ownership before reading data
      net: stmmac: make dwmac4_release_tx_desc() clear all descriptor fields

Niklas Söderlund (2):
      ravb: add support for changing MTU
      ravb: remove erroneous comment

Nikolay Aleksandrov (3):
      net: bridge: fix direct access to bridge vlan_enabled and use helper
      net: bridge: set min MTU on port events and allow user to set max
      net: bridge: disable bridge MTU auto tuning if it was set manually

Nogah Frankel (10):
      mlxsw: spectrum: qdiscs: Support qdisc per tclass
      mlxsw: spectrum: Add priority counters
      mlxsw: spectrum: qdiscs: Add priority map per qdisc
      mlxsw: spectrum: qdiscs: Collect stats for sch_red based on priomap
      mlxsw: spectrum: qdiscs: Update backlog handling of a child qdiscs
      net: sch: Don't warn on missmatching qlen and backlog for offloaded qdiscs
      mlxsw: spectrum: Update sch_prio stats to include sch_red related drops
      mlxsw: spectrum: qdiscs: prio: Delete child qdiscs when removing bands
      net: sch: prio: Add offload ability for grafting a child
      mlxsw: spectrum: qdiscs: prio: Handle graft command

Or Gerlitz (3):
      net/mlx5: E-Switch, Use same source for offloaded actions check
      net/mlx5: Add core support for vlan push/pop steering action
      net/mlx5e: Offload tc vlan push/pop using HW action

Pablo Neira Ayuso (9):
      netfilter: nft_ct: add NFT_CT_{SRC,DST}_{IP,IP6}
      netfilter: ctnetlink: synproxy support
      netfilter: add flowtable documentation
      netfilter: nf_tables: rename struct nf_chain_type
      netfilter: nf_tables: nft_register_chain_type() returns void
      netfilter: nf_tables: build-in filter chain type
      netfilter: nf_tables: enable conntrack if NAT chain is registered
      netfilter: nf_tables: rename to nft_set_lookup_global()
      netfilter: nf_tables: use nft_set_lookup_global from nf_tables_newsetelem()

Pali Rohár (4):
      wl1251: Update wl->nvs_len after wl->nvs is valid
      wl1251: Generate random MAC address only if driver does not have valid
      wl1251: Parse and use MAC address from supplied NVS data
      wl1251: Set generated MAC address back to NVS data

Paolo Abeni (7):
      tipc: don't call sock_release() in atomic context
      ipvlan: egress mcast packets are not exceptional
      ipvlan: use per device spinlock to protect addrs list updates
      ipvlan: forbid vlan devices on top of ipvlan
      net: unpollute priv_flags space
      ipvlan: properly annotate rx_handler access
      net: introduce IFF_NO_RX_HANDLER

Patryk Małek (2):
      i40e: Prevent setting link speed on KX_X722
      i40e: Prevent setting link speed on I40E_DEV_ID_25G_B

Paul Greenwalt (3):
      ixgbe: fix disabling hide VLAN on VF reset
      ixgbe: add status reg reads to ixgbe_check_remove
      ixgbe: fix read-modify-write in x550 phy setup

Paweł Jabłoński (4):
      i40e: Warn when setting link-down-on-close while in MFP
      i40evf: Fix double locking the same resource
      i40e: Fix attach VF to VM issue
      i40e: Fix the polling mechanism of GLGEN_RSTAT.DEVSTATE

Peng Li (11):
      net: hns3: VF should get the real rss_size instead of rss_size_max
      net: hns3: set the cmdq out_vld bit to 0 after used
      net: hns3: fix endian issue when PF get mbx message flag
      net: hns3: fix the queue id for tqp enable&&reset
      net: hns3: set the max ring num when alloc netdev
      net: hns3: add support for VF driver inner interface hclgevf_ops.get_tqps_and_rss_info
      net: hns3: fix rx path skb->truesize reporting bug
      net: hns3: add support for querying pfc puase packets statistic
      net: hns3: fix the VF queue reset flow error
      net: hns3: increase the max time for IMP handle command
      net: hns3: never send command queue message to IMP when reset

Peter Große (1):
      ath9k: spelling s/premble/preamble/

Petr Machata (25):
      mlxsw: spectrum_ipip: Add a forgotten include
      mlxsw: spectrum: Distinguish between IPv4/6 tunnels
      mlxsw: spectrum: Fix a coding style nit
      mlxsw: spectrum: Drop struct span_entry.used
      mlxsw: spectrum: Move SPAN code to separate module
      mlxsw: spectrum_ipip: Extract mlxsw_sp_l3addr_is_zero
      mlxsw: spectrum_ipip: Support decoding IPv6 tunnel addresses
      net: GRE: Add is_gretap_dev, is_ip6gretap_dev
      ip_tunnel: Rename & publish init_tunnel_flow
      mlxsw: reg: Add SPAN encapsulation to MPAT register
      mlxsw: reg: Extend mlxsw_reg_mpat_pack()
      mlxsw: span: Remove span_entry by span_id
      mlxsw: spectrum_span: Initialize span_entry.id eagerly
      mlxsw: spectrum_span: Extract mlxsw_sp_span_entry_{de, }configure()
      mlxsw: spectrum: Keep mirror netdev in mlxsw_sp_span_entry
      mlxsw: spectrum_span: Generalize SPAN support
      mlxsw: Handle config changes pertinent to SPAN
      mlxsw: Move a mirroring check to mlxsw_sp_span_entry_create
      mlxsw: spectrum_span: Support mirror to gretap
      mlxsw: spectrum_span: Support mirror to ip6gretap
      net: ipv6: Introduce ip6_multipath_hash_policy()
      mlxsw: spectrum: Move mlxsw_sp_span_gretap4_route()
      mlxsw: spectrum: Don't depend on ip_gre and ip6_gre
      mlxsw: spectrum_span: Fix initialization of struct mlxsw_sp_span_parms
      mlxsw: spectrum: Don't use resource ID of 0

Pieter Jansen van Vuuren (4):
      nfp: flower: implement tcp flag match offload
      net/sched: cls_flower: Add support to handle first frag as match field
      nfp: flower: refactor shared ip header in match offload
      nfp: flower: implement ip fragmentation match offload

Ping-Ke Shih (22):
      rtlwifi: enable mac80211 fast-tx support
      rtlwifi: Add Support VHT to spec_ver
      rtlwifi: Use 6 bits as sequence number of TX report
      rtlwifi: Extend tx_power_by_rate_offset size for newer IC
      rtlwifi: Add rate section and its related definition and comment
      rtlwifi: Fix VHT NSS in RC
      rtlwifi: add definition radio_mask for RF and maximum bandwidth
      rtlwifi: add efuse ops for other components
      rtlwifi: btcoex: add routine to set default port id
      rtlwifi: btcoex: Add 8822be btcoex supported files for wifi only
      rtlwifi: btcoex: fix argument typo of if-statement found by Coccinelle
      rtlwifi: Add modifier static to functions reported by sparse
      rtlwifi: remove redundant statement found by static checker
      rtlwifi: btcoex: Add enum DM_INFO for btcoex to query dm's counters
      rtlwifi: btcoex: Add customer_id to do special deal to oem vendor
      rtlwifi: btcoex: Get status of multichannel concurrence
      rtlwifi: btcoex: Add rate table for the use of btcoex
      rtlwifi: btcoex: Add interaction with phydm
      rtlwifi: btcoex: Add pre- and post- normal LPS function
      rtlwifi: btcoex: add assoc type v2 to connection notify
      rtlwifi: btcoex: new definitions introduced by 8822be
      rtlwifi: btcoex: Add new but dummy definitions introduced by 8822b

Pradeep Kumar Chitrapu (1):
      mac80211: notify driver for change in multicast rates

Prameela Rani Garnepudi (9):
      rsi: add rx control block to handle rx packets in USB
      rsi: add header file rsi_91x
      rsi: add coex support
      Bluetooth: btrsi: add new rsi bluetooth driver
      rsi: add module parameter operating mode
      rsi: sdio changes to support BT
      rsi: improve RX handling in SDIO interface
      rsi: use dynamic RX control blocks instead of MAX_RX_URB
      rsi: improve RX packet handling in USB interface

Prasad Kanneganti (1):
      liquidio: avoid doing useless work

Prashant Bhole (8):
      bpf: samples/sockmap fix Makefile for build error
      bpf: samples/sockmap detach sock ops program
      selftests/net: fixes psock_fanout eBPF test case
      samples/bpf: detach prog from cgroup
      selftests: rtnetlink: remove testns on test fail
      selftests/net: fix in_netns.sh script
      lib/scatterlist: add sg_init_marker() helper
      bpf: sockmap: initialize sg table entries properly

Priyaranjan Jha (2):
      tcp: add send queue size stat in SCM_TIMESTAMPING_OPT_STATS
      tcp: add ca_state stat in SCM_TIMESTAMPING_OPT_STATS

Quentin Monnet (6):
      tools: bpftool: add bash completion for CFG dump
      tools: bpftool: support comments in batch files
      tools: bpftool: support continuation lines in batch files
      tools: bpftool: read from stdin when batch file name is "-"
      tools: bpftool: add support for quotations in batch files
      bpf: comment why dots in filenames under BPF virtual FS are not allowed

Radu Bulie (1):
      dpaa_eth: Add allmulti option

Raghu Vatsavayi (1):
      liquidio: prevent rx queues from getting stalled

Rahul Lakkireddy (2):
      cxgb4: rework on-chip memory read
      cxgb4: speed up on-chip memory read

Rajkumar Manoharan (1):
      ath10k: fix vdev stats for 10.4 firmware

Raju Rangoju (5):
      cxgb4: Adds CPL support for Shared Receive Queues
      cxgb4: Add support to initialise/read SRQ entries
      cxgb4: Add support to query HW SRQ parameters
      cxgb4: Support firmware rdma write with immediate work request.
      cxgb4: Support firmware rdma write completion work request.

Rakesh Pillai (1):
      ath10k: dma unmap mgmt tx buffer if wmi cmd send fails

Ramon Fried (5):
      wcn36xx: reduce verbosity of drivers messages
      wcn36xx: calculate DXE control registers values
      wcn36xx: calculate DXE default channel values
      wcn36xx: Check DXE IRQ reason
      wcn36xx: turn off probe response offloading

Randy Dunlap (1):
      net/wireless: fix spaces and grammar copy/paste in vendor Kconfig help text

Richard Cochran (2):
      net: phylink: Remove redundant netdev.phydev assignment
      ptp: Fix documentation to match code.

Roman Mashak (10):
      net sched actions: corrected extack message
      tc-testing: add csum tests
      net sched actions: update Add/Delete action API with new argument
      net sched actions: add new tc_action_ops callback
      net sched actions: calculate add/delete event message size
      net sched actions: implement get_fill_size routine in act_gact
      tc-testing: add TC vlan action tests
      tc-testing: updated gact tests with batch test cases
      tc-testing: updated police, mirred, skbedit and skbmod with more tests
      tc-testing: add connmark action tests

Ronak Doshi (1):
      MAINTAINERS: update vmxnet3 driver maintainer

Roopa Prabhu (6):
      net: fib_rules: support for match on ip_proto, sport and dport
      ipv4: fib_rules: support match on sport, dport and ip proto
      ipv6: fib6_rules: support for match on sport, dport and ip proto
      ipv6: route: dissect flow in input path if fib rules need it
      ipv6: route: dissect flow in input path if fib rules need it
      fib_rules: FRA_GENERIC_POLICY updates for ip proto, sport and dport attrs

Russell King (5):
      sfp: support 1G BiDi (eg, FiberStore SFP-GE-BX) modules
      phylink,sfp: negotiate interface format with MAC
      dt-bindings: add maximum power level to SFP binding
      sfp: allow cotsworks modules
      sfp/phylink: move module EEPROM ethtool access into netdev core ethtool

Ryan Hsu (3):
      ath10k: update the IRAM bank number for QCA9377
      ath10k: enable QCA6174/QCA9377 to read the chip temperature
      ath10k: add FW API 6 firmware image for QCA9377

Sabrina Dubroca (2):
      tun: export flags, uid, gid, queue information over netlink
      ipv6: allow userspace to add IFA_F_OPTIMISTIC addresses

Saeed Mahameed (9):
      net/mlx5: CQ Database per EQ
      net/mlx5: Add missing likely/unlikely hints to cq events
      net/mlx5: EQ add/del CQ API
      net/mlx5: CQ hold/put API
      net/mlx5: Move CQ completion and event forwarding logic to eq.c
      net/mlx5: Remove redundant EQ API exports
      net/mlx5: Use MLX5_IPSEC_DEV macro for ipsec caps
      net/mlx5e: Use eq ptr from cq
      net/mlx5: Eliminate query xsrq dead code

Salil Mehta (9):
      net: hns3: Changes to make enet watchdog timeout func common for PF/VF
      net: hns3: Add VF Reset Service Task to support event handling
      net: hns3: Add VF Reset device state and its handling
      net: hns3: Add support to request VF Reset to PF
      net: hns3: Add support to reset the enet/ring mgmt layer
      net: hns3: Add support to re-initialize the hclge device
      net: hns3: Changes to support ARQ(Asynchronous Receive Queue)
      net: hns3: Add *Asserting Reset* mailbox message & handling in VF
      net: hns3: Changes required in PF mailbox to support VF reset

Salvatore Mesoraca (3):
      net: llc: drop VLA in llc_sap_mcast()
      net: rds: drop VLA in rds_for_each_conn_info()
      net: rds: drop VLA in rds_walk_conn_path_info()

Samuel Mendoza-Jonas (1):
      net/ncsi: Add generic netlink family

Sara Sharon (5):
      mac80211: add get TID helper
      iwlwifi: mvm: flip AMSDU addresses only for 9000 family
      iwlwifi: mvm: take RCU lock before dereferencing
      iwlwifi: mvm: move TSO segment to a separate function
      iwlwifi: mvm: save low latency causes in an enum

Sathishkumar Muruganandam (1):
      ath10k: suppress "Unknown eventid: 36925" warnings

Scott Branden (1):
      bnxt_en: fix clear flags in ethtool reset handling

Sebastian Andrzej Siewior (1):
      rxrpc: remove unused static variables

Sebastian Gottschall (1):
      ath9k: fix crash in spectral scan

Sergei Maksimenko (1):
      qtnfmac: enable reloading of qtnfmac kernel modules

Sergei Shtylyov (10):
      sh_eth: simplify sh_eth_check_reset()
      sh_eth: TSU_QTAG0/1 registers the same as TSU_QTAGM0/1
      sh_eth: fix TSU init on SH7734/R8A7740
      sh_eth: add sh_eth_cpu_data::soft_reset() method
      sh_eth: add sh_eth_cpu_data::edtrr_trns value
      sh_eth: add sh_eth_cpu_data::xdfar_rw flag
      sh_eth: add sh_eth_cpu_data::no_tx_cntrs flag
      sh_eth: add sh_eth_cpu_data::cexcr flag
      sh_eth: add sh_eth_cpu_data::no_xdfar flag
      sh_eth: kill useless check in __sh_eth_get_regs()

Sergey Matyukevich (2):
      qtnfmac: fix releasing Tx/Rx data buffers
      qtnfmac: implement asynchronous firmware loading

Shahar S Matityahu (1):
      iwlwifi: wrt: add fw force restart via triggers

Shalom Toledo (1):
      mlxsw: pci: Set mbox dma addresses to zero when not used

Shannon Nelson (8):
      esp: check the NETIF_F_HW_ESP_TX_CSUM bit before segmenting
      ixgbe: check for 128-bit authentication
      ixgbe: fix ipsec trailer length
      ixgbe: remove unneeded ipsec state free callback
      ixgbe: no need for ipsec csum feature check
      ixgbe: remove unneeded ipsec test in TX path
      ixgbe: no need for esp trailer if GSO
      ixgbe: enable TSO with IPsec offload

Shaohua Li (1):
      bpf: follow idr code convention

Shiraz Saleem (1):
      i40e: Close client on suspend and restore client MSIx on resume

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sinan Kaya (7):
      net: qla3xxx: Eliminate duplicate barriers on weakly-ordered archs
      qlcnic: Eliminate duplicate barriers on weakly-ordered archs
      bnx2x: Replace doorbell barrier() with wmb()
      bnx2x: Eliminate duplicate barriers on weakly-ordered archs
      net: qlge: Eliminate duplicate barriers on weakly-ordered archs
      bnxt_en: Eliminate duplicate barriers on weakly-ordered archs
      net: ena: Eliminate duplicate barriers on weakly-ordered archs

Siva Rebbagondla (2):
      rsi: add bluetooth rx endpoint
      rsi: handle BT traffic in driver

Soheil Hassas Yeganeh (1):
      socket: skip checking sk_err for recvmmsg(MSG_ERRQUEUE)

Song Liu (2):
      bpf: extend stackmap to save binary_build_id+offset instead of address
      bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID

Sowmini Varadhan (15):
      skbuff: export mm_[un]account_pinned_pages for other modules
      rds: hold a sock ref from rds_message to the rds_sock
      sock: permit SO_ZEROCOPY on PF_RDS socket
      rds: support for zcopy completion notification
      rds: zerocopy Tx support.
      selftests/net: add support for PF_RDS sockets
      selftests/net: add zerocopy support for PF_RDS test case
      rds: rds_msg_zcopy should return error of null rm->data.op_mmp_znotifier
      selftests/net: revert the zerocopy Rx path for PF_RDS
      rds: deliver zerocopy completion notification with data
      selftests/net: reap zerocopy completions passed up as ancillary data.
      rds: refactor zcopy code into rds_message_zcopy_from_user
      rds: use list structure to track information for zerocopy completion notification
      rds: tcp: must use spin_lock_irq* and not spin_lock_bh with rds_tcp_conn_lock
      rds: tcp: remove register_netdevice_notifier infrastructure.

Srinivas Dasari (4):
      cfg80211/nl80211: Optional authentication offload to userspace
      nl80211: Allow SAE Authentication for NL80211_CMD_CONNECT
      nl80211: Fix external_auth check for offloaded authentication
      ieee80211: Increase PMK maximum length to 64 bytes

Sriram R (1):
      ath: fix false radar detection in JP region

Stefan Chulski (3):
      net: mvpp2: use the same buffer pool for all ports
      net: mvpp2: update the BM buffer free/destroy logic
      net: mvpp2: jumbo frames support

Stefan Raspl (1):
      net/smc: cleanup smc_llc.h and smc_clc.h headers

Stefano Brivio (12):
      selftests: net: Introduce first PMTU test
      selftests: pmtu: Reverse return codes of functions
      selftests: pmtu: Use namespace command prefix to fetch route mtu
      selftests: pmtu: Factor out MTU parsing helper
      selftests: pmtu: Introduce support for multiple tests
      selftests: pmtu: Add pmtu_vti4_default_mtu test
      selftests: pmtu: Add pmtu_vti6_default_mtu test
      selftests: pmtu: Add test_pmtu_vti4_exception test
      selftests: pmtu: Add pmtu_vti4_link_add_mtu test
      selftests: pmtu: Add pmtu_vti6_link_add_mtu test
      selftests: pmtu: Add pmtu_vti6_link_change_mtu test
      selftests: pmtu: Drop prints to kernel log from pmtu_vti6_link_change_mtu

Stephen Hemminger (4):
      inet: whitespace cleanup
      doc: remove out of date links and info from packet mmap
      hv_netvsc: pass netvsc_device to rndis halt
      hv_netvsc: add trace points

Subash Abhinov Kasiviswanathan (5):
      net: qualcomm: rmnet: Fix casting issues
      net: qualcomm: rmnet: Update copyright year to 2018
      net: qualcomm: rmnet: Remove unnecessary device assignment
      net: qualcomm: rmnet: Export mux_id and flags to netlink
      net: qualcomm: rmnet: Implement fill_info

Sudarsana Reddy Kalluru (5):
      qed: Populate nvm image attribute shadow.
      qed: Fix PTT entry leak in the selftest error flow.
      qed: Add APIs for flash access.
      qed: Adapter flash update support.
      qede: Ethtool flash update support.

Sudhir Sreedharan (1):
      rtl8187: Fix NULL pointer dereference in priv->conf_mutex

Sunil Dutt (1):
      nl80211: Introduce scan flags to emphasize requested scan behavior

Sven Eckelmann (3):
      batman-adv: Update copyright years for 2018
      batman-adv: Fix indentation of batadv_seq_before
      batman-adv: Avoid relation operator comparison with bool

Taehee Yoo (4):
      netfilter: nfnetlink_acct: remove useless parameter
      netfilter: xt_cluster: get rid of xt_cluster_ipv6_is_multicast
      netfilter: nf_conntrack_broadcast: remove useless parameter
      netfilter: ebtables: use ADD_COUNTER macro

Takashi Iwai (1):
      brcmsmac: allocate ucode with GFP_KERNEL

Tal Bar (3):
      mlxsw: spectrum: Reserved field in mbox profile shouldn't be set
      mlxsw: spectrum: Update the supported firmware to version 13.1620.192
      mlxsw: spectrum: Add support for auto-negotiation disable mode

Tal Gilboa (2):
      Documentation/networking: Add net DIM documentation
      net/mlx5e: Set EQE based as default TX interrupt moderation mode

Talat Batheesh (1):
      net/mlx5e: IPoIB, Fix spelling mistake

Tariq Toukan (22):
      net/mlx4_en: Combine checks of end-cases in RX completion function
      net/mlx4_en: RX csum, pre-define enabled protocols for IP status masking
      net/mlx5e: Unify slow PCI heuristic
      net/mlx5e: Disable Striding RQ when PCI is slower than link
      net/mlx5e: Remove unused define MLX5_MPWRQ_STRIDES_PER_PAGE
      net/mlx5e: Separate dma base address and offset in dma_sync call
      net/mlx5e: Use no-offset function in skb header copy
      net/mlx5e: Remove RQ MPWQE fields from params
      net/mlx5e: Remove rq_headroom field from params
      net/mlx5e: Do not reset Receive Queue params on every type change
      net/mlx5e: Add ethtool priv-flag for Striding RQ
      net/mlx5e: Save MTU in channels params
      net/mlx5e: Derive Striding RQ size from MTU
      net/mlx5e: Code movements in RX UMR WQE post
      net/mlx5e: Do not busy-wait for UMR completion in Striding RQ
      net/mlx5e: Use inline MTTs in UMR WQEs
      net/mlx5e: Use linear SKB in Striding RQ
      net/mlx5e: Refactor RQ XDP_TX indication
      net/mlx5e: Support XDP over Striding RQ
      net/mlx5e: Remove page_ref bulking in Striding RQ
      net/mlx5e: Keep single pre-initialized UMR WQE per RQ
      net/mlx5e: RX, Recycle buffer of UMR WQEs

Tedd Ho-Jeong An (1):
      Bluetooth: btusb: Add support for Intel Bluetooth device 22560 [8087:0026]

Teng Qin (2):
      bpf: add support to read sample address in bpf program
      samples/bpf: add example to test reading address

Thomas Falcon (23):
      ibmvnic: Keep track of supplementary TX descriptors
      ibmvnic: Fix TX descriptor tracking
      ibmvnic: Fix TX descriptor tracking again
      ibmvnic: Allocate statistics buffers during probe
      ibmvnic: Harden TX/RX pool cleaning
      ibmvnic: Report queue stops and restarts as debug output
      ibmvnic: Do not attempt to login if RX or TX queues are not allocated
      ibmvnic: Clean up device close
      ibmvnic: Reorganize device close
      ibmvnic: Do not disable device during failover or partition migration
      ibmvnic: Account for VLAN tag in L2 Header descriptor
      ibmvnic: Account for VLAN header length in TX buffers
      ibmvnic: Pad small packets to minimum MTU size
      ibmvnic: Handle TSO backing device errata
      ibmvnic: Fix recent errata commit
      ibmvnic: Generalize TX pool structure
      ibmvnic: Update and clean up reset TX pool routine
      ibmvnic: Update release TX pool routine
      ibmvnic: Update TX pool initialization routine
      ibmvnic: Update TX and TX completion routines
      ibmvnic: Improve TX buffer accounting
      ibmvnic: Update TX pool cleaning routine
      ibmvnic: Remove unused TSO resources in TX pool structure

Timothy Redaelli (1):
      ath9k: fix DFS detector synchronization

Tobin C. Harding (1):
      rsi: Remove stack VLA usage

Toke Høiland-Jørgensen (1):
      ath9k: Protect queue draining by rcu_read_lock()

Tom Herbert (1):
      kcm: Call strp_stop before strp_done in kcm_attach

Tonghao Zhang (4):
      ixgbe: Avoid to write the RETA table when unnecessary
      ixgbe: Add receive length error counter
      udp: Move the udp sysctl to namespace.
      doc: Change the udp/sctp rmem/wmem default value.

Tony Nguyen (5):
      ixgbevf: Add XDP support for pass and drop actions
      ixgbevf: Add support for XDP_TX action
      ixgbevf: Delay tail write for XDP packets
      ixgbevf: Add support for meta data
      ixgbevf: Add XDP queue stats reporting

Tosoni (1):
      mac80211: inform wireless layer when frame RSSI is invalid

Tushar Dave (1):
      samples/bpf: adjust rlimit RLIMIT_MEMLOCK for xdp_redirect

Ursula Braun (2):
      net/smc: pay attention to MAX_ORDER for CQ entries
      net/smc: free link group without pending free_work only

Uwe Kleine-König (3):
      net: dsa: mv88e6xxx: Fix name of switch 88E6141
      net: dsa: mv88e6xxx: Fix typo in a comment
      net: dsa: mv88e6xxx: Fix interrupt name for g2 irq

Vadim Lomovtsev (7):
      net: thunderx: move filter register related macro into proper place
      net: thunderx: add MAC address filter tracking for LMAC
      net: thunderx: add multicast filter management support
      net: thunderx: add new messages for handle ndo_set_rx_mode callback
      net: thunderx: add XCAST messages handlers for PF
      net: thunderx: add workqueue control structures for handle ndo_set_rx_mode request
      net: thunderx: add ndo_set_rx_mode callback implementation for VF

Vaibhav Murkute (1):
      drivers: vhost: vsock: fixed a brace coding style issue

Vasanthakumar Thiagarajan (1):
      ath10k: add sta rx packet stats per tid

Vasundhara Volam (3):
      bnxt_en: Add support for ndo_set_vf_trust
      bnxt_en: Include additional hardware port statistics in ethtool -S.
      bnxt_en: Add extended port statistics support

Veerasenareddy Burru (2):
      liquidio: fix ndo_change_mtu to always return correct status to the caller
      liquidio: Add support for liquidio 10GBase-T NIC

Venkateswara Naralasetty (2):
      cfg80211: send ack_signal to user in probe client response
      mac80211: Add tx ack signal support in sta info

Vic Wei (1):
      Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_QCA_ROME

Vicente Bergas (1):
      Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB

Vinicius Costa Gomes (1):
      selftests/txtimestamp: Add more configurable parameters

Wadim Egorov (2):
      net: phy: dp83867: Add binding for the CLK_OUT pin muxing option
      net: phy: dp83867: Add documentation for CLK_OUT pin muxing

Wei Yongjun (13):
      i40e: Make local function i40e_get_link_speed static
      i40evf: use GFP_ATOMIC under spin lock
      mlxsw: spectrum_kvdl: Make some functions static
      sctp: fix error return code in sctp_sendmsg_new_asoc()
      net: aquantia: Make function hw_atl_utils_mpi_set_speed() static
      tipc: fix error handling in tipc_udp_enable()
      tipc: tipc_node_create() can be static
      net: bcmgenet: return NULL instead of plain integer
      net: cavium: use module_pci_driver to simplify the code
      cxgb4: fix error return code in adap_init0()
      net: hns3: remove unnecessary pci_set_drvdata() and devm_kfree()
      vlan: vlan_hw_filter_capable() can be static
      Bluetooth: btrsi: remove unused including <linux/version.h>

Willem de Bruijn (2):
      selftests/net: ignore background traffic in psock_fanout
      sock: remove zerocopy sockopt restriction on closed tcp state

William Tu (3):
      gre: add sequence number for collect md mode.
      samples/bpf: add gre sequence number test.
      openvswitch: fix vport packet length check.

Wojciech Dubowik (2):
      ath9k: Fix airtime calculation for quarter/half channels
      ath9k: Fix ack SIFS time for quarter/half channels

Xin Long (22):
      sctp: rename sctp_diag.c as diag.c
      sctp: add file comments in diag.c
      sctp: factor out sctp_sendmsg_to_asoc from sctp_sendmsg
      sctp: factor out sctp_sendmsg_new_asoc from sctp_sendmsg
      sctp: factor out sctp_sendmsg_check_sflags from sctp_sendmsg
      sctp: factor out sctp_sendmsg_get_daddr from sctp_sendmsg
      sctp: factor out sctp_sendmsg_parse from sctp_sendmsg
      sctp: factor out sctp_sendmsg_update_sinfo from sctp_sendmsg
      sctp: remove the unnecessary transport looking up from sctp_sendmsg
      sctp: improve some variables in sctp_sendmsg
      sctp: adjust some codes in a better order in sctp_sendmsg
      netfilter: unlock xt_table earlier in __do_replace
      sctp: add support for PR-SCTP Information for sendmsg
      sctp: add support for SCTP_DSTADDRV4/6 Information for sendmsg
      sctp: add support for snd flag SCTP_SENDALL process in sendmsg
      sctp: add refcnt support for sh_key
      sctp: add support for SCTP AUTH Information for sendmsg
      sctp: add sockopt SCTP_AUTH_DEACTIVATE_KEY
      sctp: add SCTP_AUTH_FREE_KEY type for AUTHENTICATION_EVENT
      sctp: add SCTP_AUTH_NO_AUTH type for AUTHENTICATION_EVENT
      sctp: remove unnecessary asoc in sctp_has_association
      route: check sysctl_fib_multipath_use_neigh earlier than hash

Xinming Hu (2):
      mwifiex: set different mac address for interfaces with same bss type
      mwifiex: correct antenna number with high bits reserved

Xue Liu (3):
      ieee802154: Add device tree documentation for MCR20A
      ieee802154: Add entry in MAINTAINTERS for MCR20a driver
      ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver

Yafang Shao (2):
      tcp: remove the hardcode in the definition of TCPF Macro
      bpf: NULL pointer check is not needed in BPF_CGROUP_RUN_PROG_INET_SOCK

Yan Markman (2):
      net: mvpp2: use a data size of 10kB for Tx FIFO on port 0
      net: mvpp2: Use relaxed I/O in data path

Yi-Hung Wei (2):
      netfilter: Refactor nf_conncount
      netfilter: conncount: Support count only use case

Yingying Tang (4):
      ath10k: enable TDLS peer buffer STA feature
      ath10k: enable TDLS peer inactivity detection
      ath10k: avoid to set WEP key for TDLS peer
      ath10k: fix TDLS peer TX data failure issue on encryped AP

Yonatan Cohen (1):
      IB/mlx5: Implement fragmented completion queue (CQ)

Yonghong Song (3):
      tools/bpf: adjust rlimit RLIMIT_MEMLOCK for test_tcpbpf_user
      net: permit skb_segment on head_frag frag_list skb
      net: bpf: add a test for skb_segment in test_bpf module

Yossi Kuperman (2):
      net/mlx5: IPSec, Generalize sandbox QP commands
      net/mlx5e: IPSec, Add support for ESP trailer removal by hardware

Yousuk Seung (2):
      tcp: add snd_ssthresh stat in SCM_TIMESTAMPING_OPT_STATS
      net-tcp_bbr: set tp->snd_ssthresh to BDP upon STARTUP exit

Yunsheng Lin (13):
      net: hns3: refactor the hclge_get/set_rss function
      net: hns3: refactor the hclge_get/set_rss_tuple function
      net: hns3: fix for RSS configuration loss problem during reset
      net: hns3: fix for pause configuration lost during reset
      net: hns3: fix for use-after-free when setting ring parameter
      net: hns3: refactor the get/put_vector function
      net: hns3: fix for coalesce configuration lost during reset
      net: hns3: refactor the coalesce related struct
      net: hns3: fix for coal configuation lost when setting the channel
      net: hns3: fix for loopback failure when vlan filter is enable
      net: hns3: fix for buffer overflow smatch warning
      net: hns3: fix for vlan table lost problem when resetting
      net: hns3: export pci table of hclge and hclgevf to userspace

Yuval Mintz (26):
      ipmr,ipmr6: Define a uniform vif_device
      ip6mr: Make mroute_sk rcu-based
      ip6mr: Align hash implementation to ipmr
      mroute*: Make mr_table a common struct
      ipmr, ip6mr: Unite creation of new mr_table
      ipmr, ip6mr: Make mfc_cache a common structure
      ipmr, ip6mr: Unite logic for searching in MFC cache
      ipmr, ip6mr: Unite mfc seq logic
      ipmr, ip6mr: Unite vif seq functions
      ip6mr: Remove MFC_NOTIFY and refactor flags
      ipmr, ip6mr: Unite dumproute flows
      ipmr: Make vif fib notifiers common
      ipmr: Make MFC fib notifiers common
      ipmr: Make ipmr_dump() common
      ip6mr: Support fib notifications
      ip6mr: Add API for default_rule fib
      ip6mr: Add refcounting to mfc
      mlxsw: reg: Configure RIF to forward IPv6 multicast packets
      mlxsw: reg: Add register settings for IPv6 multicast routing
      mlxsw: spectrum_mr: Pass protocol as part of catchall route params
      mlxsw: spectrum_router: Support IPv6 multicast to host CPU
      mlxsw: spectrum_mr: Convert into using mr_mfc
      mlxsw: spectrum_router: Make IPMR-related APIs family agnostic
      mlxsw: spectrum_mr: Add ipv6 specific operations
      mlxsw: spectrum_router: Process IP6MR fib notification
      mlxsw: spectrum: Add multicast router trap for PIMv6

Zamir, Roee (2):
      iwlwifi: mvm: add adaptive dwell support
      iwlwifi: mvm: add support for oce

kbuild test robot (6):
      netfilter: nf_tables: nf_tables_obj_lookup_byhandle() can be static
      net: mvpp2: mvpp2_check_hw_buf_num() can be static
      rds: rds_message_zcopy_from_user() can be static
      rds: rds_info_from_znotifier() can be static
      net: hns3: hclge_inform_reset_assert_to_vf() can be static
      tipc: tipc_disc_addr_trial_msg() can be static

tamizhr@codeaurora.org (5):
      cfg80211: Add support to notify station's opmode change to userspace
      mac80211: Add support to notify ht/vht opmode modification.
      cfg80211: fix data type of sta_opmode_info parameter
      mac80211: Use proper smps_mode enum in sta opmode event
      mac80211: Use proper chan_width enum in sta opmode event

Łukasz Rymanowski (1):
      Bluetooth: Fix incorrect bits for LE states

 Documentation/bpf/bpf_devel_QA.txt                                        |   12 +
 Documentation/devicetree/bindings/net/dsa/marvell.txt                     |   11 +-
 Documentation/devicetree/bindings/net/ethernet.txt                        |    2 +
 Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt               |   23 +
 Documentation/devicetree/bindings/net/macb.txt                            |    1 +
 Documentation/devicetree/bindings/net/meson-dwmac.txt                     |    5 +-
 Documentation/devicetree/bindings/net/nixge.txt                           |   32 +
 Documentation/devicetree/bindings/net/renesas,ravb.txt                    |    1 +
 Documentation/devicetree/bindings/net/sff,sfp.txt                         |    5 +
 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt         |    1 +
 Documentation/devicetree/bindings/net/ti,dp83867.txt                      |    2 +
 Documentation/networking/ice.txt                                          |   39 +
 Documentation/networking/ip-sysctl.txt                                    |   30 +-
 Documentation/networking/msg_zerocopy.rst                                 |    5 -
 Documentation/networking/net_dim.txt                                      |  174 +++
 Documentation/networking/nf_flowtable.txt                                 |  112 ++
 Documentation/networking/packet_mmap.txt                                  |   22 +-
 Documentation/networking/tls.txt                                          |   66 +-
 Documentation/ptp/ptp.txt                                                 |    5 +-
 Documentation/sysctl/net.txt                                              |   12 +
 MAINTAINERS                                                               |   21 +-
 arch/arm/boot/dts/armada-370-rd.dts                                       |   32 +
 arch/m68k/mac/config.c                                                    |    4 +
 arch/x86/net/bpf_jit_comp.c                                               |  234 ++--
 drivers/atm/idt77252.c                                                    |   12 +-
 drivers/bcma/Kconfig                                                      |    2 +-
 drivers/bcma/driver_chipcommon_pmu.c                                      |    2 +-
 drivers/bcma/host_pci.c                                                   |    1 +
 drivers/bluetooth/Kconfig                                                 |   30 +-
 drivers/bluetooth/Makefile                                                |    3 +-
 drivers/bluetooth/ath3k.c                                                 |   28 +-
 drivers/bluetooth/bpa10x.c                                                |    2 +-
 drivers/bluetooth/btmrvl_main.c                                           |    2 +-
 drivers/bluetooth/btmrvl_sdio.c                                           |    4 +-
 drivers/bluetooth/btrsi.c                                                 |  187 +++
 drivers/bluetooth/btrtl.c                                                 |  119 +-
 drivers/bluetooth/btuart_cs.c                                             |  675 ---------
 drivers/bluetooth/btusb.c                                                 |   14 +
 drivers/bluetooth/h4_recv.h                                               |  160 +++
 drivers/bluetooth/hci_ath.c                                               |    4 +-
 drivers/bluetooth/hci_bcm.c                                               |  305 ++++-
 drivers/bluetooth/hci_ll.c                                                |  224 +--
 drivers/crypto/chelsio/Kconfig                                            |   11 +
 drivers/crypto/chelsio/Makefile                                           |    1 +
 drivers/crypto/chelsio/chcr_algo.h                                        |   42 +
 drivers/crypto/chelsio/chcr_core.h                                        |   55 +-
 drivers/crypto/chelsio/chtls/Makefile                                     |    4 +
 drivers/crypto/chelsio/chtls/chtls.h                                      |  482 +++++++
 drivers/crypto/chelsio/chtls/chtls_cm.c                                   | 2126 +++++++++++++++++++++++++++++
 drivers/crypto/chelsio/chtls/chtls_cm.h                                   |  203 +++
 drivers/crypto/chelsio/chtls/chtls_hw.c                                   |  412 ++++++
 drivers/crypto/chelsio/chtls/chtls_io.c                                   | 1822 +++++++++++++++++++++++++
 drivers/crypto/chelsio/chtls/chtls_main.c                                 |  578 ++++++++
 drivers/infiniband/core/cma.c                                             |    2 +-
 drivers/infiniband/core/roce_gid_mgmt.c                                   |    2 +
 drivers/infiniband/hw/cxgb4/device.c                                      |    1 +
 drivers/infiniband/hw/hfi1/file_ops.c                                     |    2 +-
 drivers/infiniband/hw/hfi1/trace_ctxts.h                                  |   12 +-
 drivers/infiniband/hw/mlx5/Makefile                                       |    1 +
 drivers/infiniband/hw/mlx5/cq.c                                           |   72 +-
 drivers/infiniband/hw/mlx5/ib_rep.c                                       |  192 +++
 drivers/infiniband/hw/mlx5/ib_rep.h                                       |   72 +
 drivers/infiniband/hw/mlx5/main.c                                         |  394 ++++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                      |   38 +-
 drivers/infiniband/hw/mlx5/mr.c                                           |    5 +-
 drivers/infiniband/hw/mlx5/qp.c                                           |   41 +-
 drivers/infiniband/hw/qedr/main.c                                         |    4 +-
 drivers/infiniband/hw/qedr/qedr_hsi_rdma.h                                |    4 +-
 drivers/infiniband/hw/qedr/verbs.c                                        |    4 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c                               |   28 +-
 drivers/infiniband/hw/usnic/usnic_transport.c                             |    5 +-
 drivers/isdn/mISDN/socket.c                                               |    5 +-
 drivers/net/Kconfig                                                       |    5 +-
 drivers/net/Space.c                                                       |    6 -
 drivers/net/bonding/bond_procfs.c                                         |    2 +-
 drivers/net/bonding/bond_sysfs.c                                          |   73 +-
 drivers/net/bonding/bond_sysfs_slave.c                                    |    4 +-
 drivers/net/caif/caif_serial.c                                            |   32 +-
 drivers/net/caif/caif_spi.c                                               |   16 +-
 drivers/net/caif/caif_virtio.c                                            |   16 +-
 drivers/net/can/at91_can.c                                                |    3 +-
 drivers/net/can/cc770/cc770.c                                             |    4 +-
 drivers/net/can/cc770/cc770_isa.c                                         |   16 +-
 drivers/net/can/grcan.c                                                   |    4 +-
 drivers/net/can/janz-ican3.c                                              |    6 +-
 drivers/net/can/sja1000/sja1000_isa.c                                     |   14 +-
 drivers/net/can/softing/softing_main.c                                    |    4 +-
 drivers/net/can/spi/mcp251x.c                                             |    2 +-
 drivers/net/can/usb/esd_usb2.c                                            |    6 +-
 drivers/net/can/vcan.c                                                    |    2 +-
 drivers/net/dsa/b53/b53_common.c                                          |    2 +-
 drivers/net/dsa/b53/b53_priv.h                                            |    2 +-
 drivers/net/dsa/dsa_loop.c                                                |    2 +-
 drivers/net/dsa/lan9303-core.c                                            |    2 +-
 drivers/net/dsa/microchip/ksz_common.c                                    |    2 +-
 drivers/net/dsa/mt7530.c                                                  |    2 +-
 drivers/net/dsa/mv88e6xxx/Kconfig                                         |   10 +
 drivers/net/dsa/mv88e6xxx/Makefile                                        |    4 +
 drivers/net/dsa/mv88e6xxx/chip.c                                          |  437 ++++--
 drivers/net/dsa/mv88e6xxx/chip.h                                          |  135 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c                                   |   12 +-
 drivers/net/dsa/mv88e6xxx/global1_vtu.c                                   |   11 +-
 drivers/net/dsa/mv88e6xxx/global2.c                                       |   43 +-
 drivers/net/dsa/mv88e6xxx/global2.h                                       |  115 +-
 drivers/net/dsa/mv88e6xxx/global2_avb.c                                   |  193 +++
 drivers/net/dsa/mv88e6xxx/global2_scratch.c                               |  291 ++++
 drivers/net/dsa/mv88e6xxx/hwtstamp.c                                      |  576 ++++++++
 drivers/net/dsa/mv88e6xxx/hwtstamp.h                                      |  172 +++
 drivers/net/dsa/mv88e6xxx/ptp.c                                           |  381 ++++++
 drivers/net/dsa/mv88e6xxx/ptp.h                                           |  108 ++
 drivers/net/dsa/mv88e6xxx/serdes.c                                        |  109 +-
 drivers/net/dsa/mv88e6xxx/serdes.h                                        |    6 +-
 drivers/net/dsa/qca8k.c                                                   |    2 +-
 drivers/net/dummy.c                                                       |    2 +
 drivers/net/ethernet/8390/Makefile                                        |    6 +-
 drivers/net/ethernet/8390/apne.c                                          |    2 +-
 drivers/net/ethernet/8390/ax88796.c                                       |    3 -
 drivers/net/ethernet/8390/axnet_cs.c                                      |    2 -
 drivers/net/ethernet/8390/etherh.c                                        |   17 -
 drivers/net/ethernet/8390/hydra.c                                         |    4 -
 drivers/net/ethernet/8390/lib8390.c                                       |    4 +-
 drivers/net/ethernet/8390/mac8390.c                                       |  171 ++-
 drivers/net/ethernet/8390/mcf8390.c                                       |    4 -
 drivers/net/ethernet/8390/ne.c                                            |    4 +-
 drivers/net/ethernet/8390/ne2k-pci.c                                      |    2 +-
 drivers/net/ethernet/8390/pcnet_cs.c                                      |    4 -
 drivers/net/ethernet/8390/smc-ultra.c                                     |    2 +-
 drivers/net/ethernet/8390/stnic.c                                         |    2 +-
 drivers/net/ethernet/8390/wd.c                                            |    4 +-
 drivers/net/ethernet/8390/zorro8390.c                                     |    5 -
 drivers/net/ethernet/Kconfig                                              |    1 +
 drivers/net/ethernet/Makefile                                             |    1 +
 drivers/net/ethernet/altera/altera_tse_main.c                             |    6 +-
 drivers/net/ethernet/amazon/ena/ena_com.c                                 |    8 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.h                             |    8 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c                              |    5 +-
 drivers/net/ethernet/amd/amd8111e.c                                       |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                                  |   10 +-
 drivers/net/ethernet/amd/xgbe/xgbe-main.c                                 |    2 +-
 drivers/net/ethernet/apple/macmace.c                                      |   25 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/Makefile                    |    2 +
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c              |    2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c                                |  130 +-
 drivers/net/ethernet/broadcom/bcmsysport.h                                |   13 +
 drivers/net/ethernet/broadcom/bgmac.c                                     |    7 +-
 drivers/net/ethernet/broadcom/bgmac.h                                     |    6 +-
 drivers/net/ethernet/broadcom/bnx2.c                                      |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h                               |   12 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                           |    5 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h                           |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c                       |    5 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c                          |   16 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c                          |    4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                 |  341 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                 |   30 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h                             |    5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                         |   56 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h                             |  289 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                           |   61 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h                           |    3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                             |  144 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h                             |   22 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                            |  145 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                            |   12 +
 drivers/net/ethernet/broadcom/sb1250-mac.c                                |   10 +-
 drivers/net/ethernet/broadcom/tg3.c                                       |    6 +-
 drivers/net/ethernet/brocade/bna/bnad.c                                   |    2 +-
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c                           |   10 +-
 drivers/net/ethernet/cadence/macb_main.c                                  |   96 +-
 drivers/net/ethernet/cavium/common/cavium_ptp.c                           |   13 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c                           |  145 +-
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c                        |   24 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c                           |  440 +++---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c                        |  278 +---
 drivers/net/ethernet/cavium/liquidio/liquidio_common.h                    |   30 +-
 drivers/net/ethernet/cavium/liquidio/octeon_device.h                      |    2 +
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c                        |   83 +-
 drivers/net/ethernet/cavium/liquidio/octeon_droq.h                        |   11 +-
 drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c                     |    5 +-
 drivers/net/ethernet/cavium/liquidio/octeon_network.h                     |   73 +
 drivers/net/ethernet/cavium/liquidio/request_manager.c                    |    8 +-
 drivers/net/ethernet/cavium/liquidio/response_manager.c                   |    6 +-
 drivers/net/ethernet/cavium/thunder/nic.h                                 |   29 +
 drivers/net/ethernet/cavium/thunder/nic_main.c                            |   45 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c                          |  112 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c                         |  201 ++-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h                         |   19 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c                           |    6 +-
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c                                |    8 +-
 drivers/net/ethernet/chelsio/cxgb4/Makefile                               |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c                            |   86 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h                                |   23 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c                        |  122 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c                        |   24 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c                         |    6 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                           |  333 ++++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c                            |    3 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h                            |   13 +-
 drivers/net/ethernet/chelsio/cxgb4/sched.h                                |    4 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c                                  |  107 +-
 drivers/net/ethernet/chelsio/cxgb4/srq.c                                  |  138 ++
 drivers/net/ethernet/chelsio/cxgb4/srq.h                                  |   65 +
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                                |  215 ++-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h                               |  193 ++-
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h                              |    2 +
 drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h                             |  226 +++-
 drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c                       |   61 +-
 drivers/net/ethernet/cirrus/mac89x0.c                                     |  158 +--
 drivers/net/ethernet/cisco/enic/enic.h                                    |    3 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c                            |   36 +
 drivers/net/ethernet/cisco/enic/enic_main.c                               |   86 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.c                                |   22 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.h                                |    3 +-
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h                             |    5 +
 drivers/net/ethernet/cisco/enic/vnic_nic.h                                |    1 +
 drivers/net/ethernet/ec_bhf.c                                             |    2 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c                               |    2 +-
 drivers/net/ethernet/emulex/benet/be_cmds.h                               |    2 +-
 drivers/net/ethernet/emulex/benet/be_main.c                               |    6 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                            |   65 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c                        |    4 +-
 drivers/net/ethernet/freescale/fman/Kconfig                               |    1 -
 drivers/net/ethernet/freescale/fman/fman_dtsec.c                          |   19 +
 drivers/net/ethernet/freescale/fman/fman_dtsec.h                          |    1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c                          |   32 +-
 drivers/net/ethernet/freescale/fman/fman_memac.h                          |    1 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c                           |   33 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.h                           |    1 +
 drivers/net/ethernet/freescale/fman/mac.c                                 |    4 +-
 drivers/net/ethernet/freescale/fman/mac.h                                 |    2 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                         |    6 +-
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h                           |   18 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                               |   18 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                           |  398 ++++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h                           |   18 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c                        |  153 +--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h                    |    4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c                    |   16 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                   |  559 +++++---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h                   |   27 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c                    |   94 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c                   |    6 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c                     |   76 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h                     |    8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c                  |    6 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h                  |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c                 |  475 ++++++-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h                 |   35 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c                  |   95 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c                                 |    7 +-
 drivers/net/ethernet/ibm/ibmveth.c                                        |    2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                                        |  626 +++++----
 drivers/net/ethernet/ibm/ibmvnic.h                                        |   16 +-
 drivers/net/ethernet/intel/Kconfig                                        |   14 +
 drivers/net/ethernet/intel/Makefile                                       |    1 +
 drivers/net/ethernet/intel/e100.c                                         |    1 +
 drivers/net/ethernet/intel/e1000/Makefile                                 |    1 +
 drivers/net/ethernet/intel/e1000/e1000.h                                  |    1 +
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c                          |    1 +
 drivers/net/ethernet/intel/e1000/e1000_hw.c                               |    1 +
 drivers/net/ethernet/intel/e1000/e1000_hw.h                               |    1 +
 drivers/net/ethernet/intel/e1000/e1000_main.c                             |    1 +
 drivers/net/ethernet/intel/e1000/e1000_osdep.h                            |    1 +
 drivers/net/ethernet/intel/e1000/e1000_param.c                            |    1 +
 drivers/net/ethernet/intel/e1000e/80003es2lan.c                           |    1 +
 drivers/net/ethernet/intel/e1000e/80003es2lan.h                           |    1 +
 drivers/net/ethernet/intel/e1000e/82571.c                                 |    1 +
 drivers/net/ethernet/intel/e1000e/82571.h                                 |    1 +
 drivers/net/ethernet/intel/e1000e/Makefile                                |    1 +
 drivers/net/ethernet/intel/e1000e/defines.h                               |    1 +
 drivers/net/ethernet/intel/e1000e/e1000.h                                 |    1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c                               |    1 +
 drivers/net/ethernet/intel/e1000e/hw.h                                    |    1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c                               |    1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.h                               |    1 +
 drivers/net/ethernet/intel/e1000e/mac.c                                   |    1 +
 drivers/net/ethernet/intel/e1000e/mac.h                                   |    1 +
 drivers/net/ethernet/intel/e1000e/manage.c                                |    1 +
 drivers/net/ethernet/intel/e1000e/manage.h                                |    1 +
 drivers/net/ethernet/intel/e1000e/netdev.c                                |    1 +
 drivers/net/ethernet/intel/e1000e/nvm.c                                   |    1 +
 drivers/net/ethernet/intel/e1000e/nvm.h                                   |    1 +
 drivers/net/ethernet/intel/e1000e/param.c                                 |    1 +
 drivers/net/ethernet/intel/e1000e/phy.c                                   |    1 +
 drivers/net/ethernet/intel/e1000e/phy.h                                   |    1 +
 drivers/net/ethernet/intel/e1000e/ptp.c                                   |    1 +
 drivers/net/ethernet/intel/e1000e/regs.h                                  |    1 +
 drivers/net/ethernet/intel/fm10k/Makefile                                 |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k.h                                  |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_common.c                           |    6 +-
 drivers/net/ethernet/intel/fm10k/fm10k_common.h                           |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c                            |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c                          |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c                          |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c                              |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_main.c                             |    5 +-
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c                              |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.h                              |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c                           |   11 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c                              |   14 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c                               |    5 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h                               |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_tlv.c                              |    8 +-
 drivers/net/ethernet/intel/fm10k/fm10k_tlv.h                              |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_type.h                             |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c                               |    1 +
 drivers/net/ethernet/intel/fm10k/fm10k_vf.h                               |    1 +
 drivers/net/ethernet/intel/i40e/Makefile                                  |    1 +
 drivers/net/ethernet/intel/i40e/i40e.h                                    |   82 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c                             |    1 +
 drivers/net/ethernet/intel/i40e/i40e_adminq.h                             |    1 +
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h                         |   38 +
 drivers/net/ethernet/intel/i40e/i40e_alloc.h                              |    1 +
 drivers/net/ethernet/intel/i40e/i40e_client.c                             |   24 +-
 drivers/net/ethernet/intel/i40e/i40e_client.h                             |    1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c                             |   64 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c                                |    1 +
 drivers/net/ethernet/intel/i40e/i40e_dcb.h                                |    1 +
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c                             |    1 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                            |   53 +-
 drivers/net/ethernet/intel/i40e/i40e_devids.h                             |    1 +
 drivers/net/ethernet/intel/i40e/i40e_diag.c                               |    1 +
 drivers/net/ethernet/intel/i40e/i40e_diag.h                               |    1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                            |  127 +-
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c                               | 1571 ---------------------
 drivers/net/ethernet/intel/i40e/i40e_fcoe.h                               |  127 --
 drivers/net/ethernet/intel/i40e/i40e_hmc.c                                |    1 +
 drivers/net/ethernet/intel/i40e/i40e_hmc.h                                |    1 +
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c                            |    1 +
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h                            |    1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c                               |  465 ++++---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                                |    1 +
 drivers/net/ethernet/intel/i40e/i40e_osdep.h                              |    1 +
 drivers/net/ethernet/intel/i40e/i40e_prototype.h                          |    5 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                                |    1 +
 drivers/net/ethernet/intel/i40e/i40e_register.h                           |    1 +
 drivers/net/ethernet/intel/i40e/i40e_status.h                             |    1 +
 drivers/net/ethernet/intel/i40e/i40e_trace.h                              |    1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                               |  542 +++++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h                               |   73 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h                               |    6 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                        | 1091 +++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h                        |   21 +
 drivers/net/ethernet/intel/i40evf/Makefile                                |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c                           |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq.h                           |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h                       |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_alloc.h                            |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_common.c                           |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_devids.h                           |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_hmc.h                              |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h                          |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_osdep.h                            |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h                        |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_register.h                         |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_status.h                           |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_trace.h                            |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c                             |  428 ++++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h                             |   68 +-
 drivers/net/ethernet/intel/i40evf/i40e_type.h                             |    1 +
 drivers/net/ethernet/intel/i40evf/i40evf.h                                |   79 +-
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c                        |   53 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c                           |  934 ++++++++++++-
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c                       |  339 ++++-
 drivers/net/ethernet/intel/ice/Makefile                                   |   17 +
 drivers/net/ethernet/intel/ice/ice.h                                      |  312 +++++
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                           | 1352 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.c                               | 2233 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h                               |   86 ++
 drivers/net/ethernet/intel/ice/ice_controlq.c                             | 1066 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_controlq.h                             |   94 ++
 drivers/net/ethernet/intel/ice/ice_devids.h                               |   19 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c                              |  940 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h                           |  266 ++++
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h                            |  473 +++++++
 drivers/net/ethernet/intel/ice/ice_main.c                                 | 5495 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_nvm.c                                  |  236 ++++
 drivers/net/ethernet/intel/ice/ice_osdep.h                                |   73 +
 drivers/net/ethernet/intel/ice/ice_sched.c                                | 1659 +++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sched.h                                |   43 +
 drivers/net/ethernet/intel/ice/ice_status.h                               |   32 +
 drivers/net/ethernet/intel/ice/ice_switch.c                               | 1883 ++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_switch.h                               |  161 +++
 drivers/net/ethernet/intel/ice/ice_txrx.c                                 | 1782 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.h                                 |  192 +++
 drivers/net/ethernet/intel/ice/ice_type.h                                 |  394 ++++++
 drivers/net/ethernet/intel/igb/Makefile                                   |    1 +
 drivers/net/ethernet/intel/igb/e1000_82575.c                              |    1 +
 drivers/net/ethernet/intel/igb/e1000_82575.h                              |    1 +
 drivers/net/ethernet/intel/igb/e1000_defines.h                            |    1 +
 drivers/net/ethernet/intel/igb/e1000_hw.h                                 |    1 +
 drivers/net/ethernet/intel/igb/e1000_i210.c                               |    1 +
 drivers/net/ethernet/intel/igb/e1000_i210.h                               |    1 +
 drivers/net/ethernet/intel/igb/e1000_mac.c                                |    1 +
 drivers/net/ethernet/intel/igb/e1000_mac.h                                |    1 +
 drivers/net/ethernet/intel/igb/e1000_mbx.c                                |    1 +
 drivers/net/ethernet/intel/igb/e1000_mbx.h                                |    1 +
 drivers/net/ethernet/intel/igb/e1000_nvm.c                                |    1 +
 drivers/net/ethernet/intel/igb/e1000_nvm.h                                |    1 +
 drivers/net/ethernet/intel/igb/e1000_phy.c                                |    1 +
 drivers/net/ethernet/intel/igb/e1000_phy.h                                |    1 +
 drivers/net/ethernet/intel/igb/e1000_regs.h                               |    1 +
 drivers/net/ethernet/intel/igb/igb.h                                      |    2 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c                              |    1 +
 drivers/net/ethernet/intel/igb/igb_hwmon.c                                |    3 +-
 drivers/net/ethernet/intel/igb/igb_main.c                                 |   36 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c                                  |    1 +
 drivers/net/ethernet/intel/igbvf/Makefile                                 |    1 +
 drivers/net/ethernet/intel/igbvf/defines.h                                |    1 +
 drivers/net/ethernet/intel/igbvf/ethtool.c                                |    1 +
 drivers/net/ethernet/intel/igbvf/igbvf.h                                  |    1 +
 drivers/net/ethernet/intel/igbvf/mbx.c                                    |    1 +
 drivers/net/ethernet/intel/igbvf/mbx.h                                    |    1 +
 drivers/net/ethernet/intel/igbvf/netdev.c                                 |    1 +
 drivers/net/ethernet/intel/igbvf/regs.h                                   |    1 +
 drivers/net/ethernet/intel/igbvf/vf.c                                     |    1 +
 drivers/net/ethernet/intel/igbvf/vf.h                                     |    1 +
 drivers/net/ethernet/intel/ixgb/Makefile                                  |    1 +
 drivers/net/ethernet/intel/ixgb/ixgb.h                                    |    1 +
 drivers/net/ethernet/intel/ixgb/ixgb_ee.h                                 |    1 +
 drivers/net/ethernet/intel/ixgb/ixgb_hw.h                                 |    1 +
 drivers/net/ethernet/intel/ixgb/ixgb_ids.h                                |    1 +
 drivers/net/ethernet/intel/ixgb/ixgb_osdep.h                              |    1 +
 drivers/net/ethernet/intel/ixgbe/Makefile                                 |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                                  |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c                            |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c                            |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c                           |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h                           |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h                              |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c                        |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.h                        |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.h                        |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                          |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h                             |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c                            |   69 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h                            |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c                              |    1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                             |   82 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h                              |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_model.h                            |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h                              |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                            |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h                            |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c                            |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                             |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h                             |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                             |    4 +-
 drivers/net/ethernet/intel/ixgbevf/Makefile                               |    1 +
 drivers/net/ethernet/intel/ixgbevf/defines.h                              |    1 +
 drivers/net/ethernet/intel/ixgbevf/ethtool.c                              |  116 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h                              |  101 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c                         | 1214 +++++++++++------
 drivers/net/ethernet/intel/ixgbevf/mbx.h                                  |    1 +
 drivers/net/ethernet/intel/ixgbevf/regs.h                                 |    1 +
 drivers/net/ethernet/intel/ixgbevf/vf.h                                   |    1 +
 drivers/net/ethernet/marvell/mvneta.c                                     |  188 ++-
 drivers/net/ethernet/marvell/mvpp2.c                                      | 1264 +++++++++++------
 drivers/net/ethernet/marvell/skge.c                                       |    2 +-
 drivers/net/ethernet/marvell/sky2.c                                       |    4 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c                           |   14 +
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c                            |    8 +-
 drivers/net/ethernet/mellanox/mlx4/en_port.c                              |   38 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c                                |   41 +-
 drivers/net/ethernet/mellanox/mlx4/main.c                                 |   16 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h                              |    1 +
 drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h                           |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/accel/ipsec.c                     |   59 +-
 drivers/net/ethernet/mellanox/mlx5/core/accel/ipsec.h                     |   98 +-
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c                           |   37 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                             |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/cq.c                              |  113 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c                             |    8 +
 drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.c              |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h              |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h                              |  138 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c                  |  323 +++--
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h                  |   24 +
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c             |   39 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h             |    5 +
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                      |  210 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                         |  675 +++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                          |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                           |  306 +++--
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                        |  132 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h                        |   10 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                           |   16 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                           |   27 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                              |   92 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                         |   54 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                         |   55 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                |  134 +-
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c                      | 1290 +++++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.h                      |   76 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c                          |  217 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h                          |   72 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                         |  145 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h                         |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c                              |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c                     |   31 +-
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c                |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c                            |   49 +-
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h                       |   33 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c                            |   64 +-
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c                        |   46 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c                           |   26 +
 drivers/net/ethernet/mellanox/mlx5/core/wq.c                              |   18 +-
 drivers/net/ethernet/mellanox/mlx5/core/wq.h                              |   22 +-
 drivers/net/ethernet/mellanox/mlxsw/Kconfig                               |    2 +
 drivers/net/ethernet/mellanox/mlxsw/Makefile                              |    2 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c                                |    5 +-
 drivers/net/ethernet/mellanox/mlxsw/core.h                                |   14 +-
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c               |   19 +-
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.h               |    9 +-
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c                          |   10 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c                                 |   20 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h                                 |  230 +++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                            |  557 +-------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h                            |   47 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c                        |   52 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_actions.c           |   34 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_actions.h           |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c                   |    5 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c                       |  174 +--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h                       |   15 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c                       |  265 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c                         |  292 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.h                         |    9 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr_tcam.c                    |  105 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c                      |  206 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c                     |  144 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h                     |    1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c                       |  824 +++++++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h                       |  107 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c                  |   16 +-
 drivers/net/ethernet/mellanox/mlxsw/switchib.c                            |    1 -
 drivers/net/ethernet/mellanox/mlxsw/switchx2.c                            |    9 +-
 drivers/net/ethernet/mellanox/mlxsw/trap.h                                |    1 +
 drivers/net/ethernet/microchip/Kconfig                                    |   10 +
 drivers/net/ethernet/microchip/Makefile                                   |    3 +
 drivers/net/ethernet/microchip/lan743x_main.c                             | 2771 +++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h                             |  597 ++++++++
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c                          |   32 +-
 drivers/net/ethernet/natsemi/jazzsonic.c                                  |   32 +-
 drivers/net/ethernet/natsemi/macsonic.c                                   |  244 ++--
 drivers/net/ethernet/natsemi/sonic.c                                      |   99 +-
 drivers/net/ethernet/natsemi/sonic.h                                      |    2 +
 drivers/net/ethernet/natsemi/xtsonic.c                                    |   30 +-
 drivers/net/ethernet/netronome/nfp/bpf/Makefile                           |    2 +
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c                             |   12 +-
 drivers/net/ethernet/netronome/nfp/bpf/fw.h                               |    1 +
 drivers/net/ethernet/netronome/nfp/bpf/jit.c                              |  462 ++++++-
 drivers/net/ethernet/netronome/nfp/bpf/main.c                             |   22 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.h                             |   85 +-
 drivers/net/ethernet/netronome/nfp/bpf/offload.c                          |   45 +-
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c                         |  217 ++-
 drivers/net/ethernet/netronome/nfp/flower/Makefile                        |    2 +
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c                          |   41 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h                          |   35 +-
 drivers/net/ethernet/netronome/nfp/flower/main.c                          |   87 +-
 drivers/net/ethernet/netronome/nfp/flower/main.h                          |   20 +
 drivers/net/ethernet/netronome/nfp/flower/match.c                         |   93 +-
 drivers/net/ethernet/netronome/nfp/flower/offload.c                       |   49 +
 drivers/net/ethernet/netronome/nfp/nfp_app.h                              |   25 +-
 drivers/net/ethernet/netronome/nfp/nfp_asm.c                              |    2 +
 drivers/net/ethernet/netronome/nfp/nfp_asm.h                              |    7 +
 drivers/net/ethernet/netronome/nfp/nfp_main.c                             |    1 +
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c                       |    2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h                         |  280 ++--
 drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c                      |    6 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c                         |   13 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/Makefile                       |    2 +
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000/Makefile               |    2 +
 drivers/net/ethernet/netronome/nfp/nic/Makefile                           |    2 +
 drivers/net/ethernet/ni/Kconfig                                           |   27 +
 drivers/net/ethernet/ni/Makefile                                          |    1 +
 drivers/net/ethernet/ni/nixge.c                                           | 1310 ++++++++++++++++++
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c                      |   14 +-
 drivers/net/ethernet/qlogic/qed/qed.h                                     |   15 +
 drivers/net/ethernet/qlogic/qed/qed_debug.c                               |  415 +++---
 drivers/net/ethernet/qlogic/qed/qed_dev.c                                 |   38 +-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h                                 | 1899 +++++++++++++-------------
 drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c                       |  103 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c                               |    9 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c                                  |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                                 |   13 -
 drivers/net/ethernet/qlogic/qed/qed_main.c                                |  338 +++++
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                                 |  219 ++-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h                                 |   56 +-
 drivers/net/ethernet/qlogic/qed/qed_selftest.c                            |    9 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c                           |    9 +
 drivers/net/ethernet/qlogic/qla3xxx.c                                     |    5 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c                       |    2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c                         |   30 +-
 drivers/net/ethernet/qlogic/qlge/qlge.h                                   |   16 +
 drivers/net/ethernet/qlogic/qlge/qlge_main.c                              |    3 +-
 drivers/net/ethernet/qualcomm/qca_debug.c                                 |    2 +-
 drivers/net/ethernet/qualcomm/qca_spi.c                                   |    1 -
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c                        |   75 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h                        |    2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c                      |   12 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h                           |    8 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c                   |    4 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c                      |    5 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_private.h                       |    8 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c                           |    2 +-
 drivers/net/ethernet/realtek/r8169.c                                      | 1154 ++++++----------
 drivers/net/ethernet/renesas/ravb.h                                       |    1 +
 drivers/net/ethernet/renesas/ravb_main.c                                  |   33 +-
 drivers/net/ethernet/renesas/sh_eth.c                                     |  247 ++--
 drivers/net/ethernet/renesas/sh_eth.h                                     |   13 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c                           |    4 +-
 drivers/net/ethernet/sfc/ef10.c                                           |  796 +++++------
 drivers/net/ethernet/sfc/efx.c                                            |   91 +-
 drivers/net/ethernet/sfc/efx.h                                            |   19 +-
 drivers/net/ethernet/sfc/ethtool.c                                        |  218 ++-
 drivers/net/ethernet/sfc/falcon/enum.h                                    |    1 -
 drivers/net/ethernet/sfc/farch.c                                          |   91 +-
 drivers/net/ethernet/sfc/filter.h                                         |    7 +-
 drivers/net/ethernet/sfc/mcdi_mon.c                                       |    2 +-
 drivers/net/ethernet/sfc/mcdi_pcol.h                                      | 2822 ++++++++++++++++++++++++--------------
 drivers/net/ethernet/sfc/mcdi_port.c                                      |  150 ++
 drivers/net/ethernet/sfc/net_driver.h                                     |   68 +-
 drivers/net/ethernet/sfc/nic.h                                            |    7 +-
 drivers/net/ethernet/sfc/rx.c                                             |  119 +-
 drivers/net/ethernet/sfc/siena.c                                          |   27 +-
 drivers/net/ethernet/socionext/sni_ave.c                                  |    8 +
 drivers/net/ethernet/stmicro/stmmac/Makefile                              |    2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h                              |   22 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c                       |  213 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h                              |    4 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                         |   45 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c                        |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c                          |    6 +
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c                              |  298 ++++
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h                              |   52 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                              |   14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c                      |   39 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                         |  168 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c                     |   34 +-
 drivers/net/ethernet/sun/niu.c                                            |   10 +-
 drivers/net/ethernet/ti/cpsw.c                                            |   67 +-
 drivers/net/ethernet/ti/davinci_cpdma.c                                   |    2 +-
 drivers/net/ethernet/ti/davinci_cpdma.h                                   |    2 +
 drivers/net/hamradio/bpqether.c                                           |    3 +-
 drivers/net/hamradio/yam.c                                                |    2 +-
 drivers/net/hyperv/Makefile                                               |    2 +-
 drivers/net/hyperv/hyperv_net.h                                           |    1 +
 drivers/net/hyperv/netvsc.c                                               |   51 +-
 drivers/net/hyperv/netvsc_drv.c                                           |    6 +-
 drivers/net/hyperv/netvsc_trace.c                                         |    7 +
 drivers/net/hyperv/netvsc_trace.h                                         |  182 +++
 drivers/net/hyperv/rndis_filter.c                                         |   32 +-
 drivers/net/ieee802154/Kconfig                                            |   11 +
 drivers/net/ieee802154/Makefile                                           |    1 +
 drivers/net/ieee802154/at86rf230.c                                        |    2 +-
 drivers/net/ieee802154/ca8210.c                                           |   14 +-
 drivers/net/ieee802154/mcr20a.c                                           | 1411 +++++++++++++++++++
 drivers/net/ieee802154/mcr20a.h                                           |  498 +++++++
 drivers/net/ifb.c                                                         |    2 +
 drivers/net/ipvlan/ipvlan.h                                               |    7 +
 drivers/net/ipvlan/ipvlan_core.c                                          |  103 +-
 drivers/net/ipvlan/ipvlan_main.c                                          |  118 +-
 drivers/net/netdevsim/Makefile                                            |    4 +
 drivers/net/netdevsim/devlink.c                                           |  296 ++++
 drivers/net/netdevsim/fib.c                                               |  263 ++++
 drivers/net/netdevsim/netdev.c                                            |   16 +-
 drivers/net/netdevsim/netdevsim.h                                         |   44 +
 drivers/net/phy/aquantia.c                                                |   20 +-
 drivers/net/phy/bcm7xxx.c                                                 |    2 +-
 drivers/net/phy/cortina.c                                                 |   18 +-
 drivers/net/phy/dp83867.c                                                 |   19 +
 drivers/net/phy/intel-xway.c                                              |   44 +-
 drivers/net/phy/marvell.c                                                 |    2 +-
 drivers/net/phy/marvell10g.c                                              |   13 +-
 drivers/net/phy/mdio-bitbang.c                                            |    2 +-
 drivers/net/phy/mdio-mux-mmioreg.c                                        |    5 +-
 drivers/net/phy/phy-c45.c                                                 |   28 +-
 drivers/net/phy/phy-core.c                                                |    4 +-
 drivers/net/phy/phy.c                                                     |   22 +-
 drivers/net/phy/phy_device.c                                              |    2 +-
 drivers/net/phy/phylink.c                                                 |   77 +-
 drivers/net/phy/sfp-bus.c                                                 |  168 ++-
 drivers/net/phy/sfp.c                                                     |  191 ++-
 drivers/net/phy/spi_ks8995.c                                              |    2 +-
 drivers/net/phy/teranetics.c                                              |   32 +-
 drivers/net/ppp/ppp_generic.c                                             |    2 +-
 drivers/net/ppp/pppoe.c                                                   |    8 +-
 drivers/net/ppp/pptp.c                                                    |    6 +-
 drivers/net/team/team.c                                                   |   16 +-
 drivers/net/tun.c                                                         |   91 +-
 drivers/net/usb/ax88179_178a.c                                            |    1 -
 drivers/net/usb/cdc_eem.c                                                 |    5 +-
 drivers/net/usb/cdc_ncm.c                                                 |   12 +-
 drivers/net/usb/hso.c                                                     |    8 +-
 drivers/net/usb/kalmia.c                                                  |   14 +-
 drivers/net/usb/lg-vl600.c                                                |    6 +-
 drivers/net/virtio_net.c                                                  |    2 +-
 drivers/net/vrf.c                                                         |   12 +-
 drivers/net/wimax/i2400m/usb-rx.c                                         |    3 -
 drivers/net/wireless/admtek/Kconfig                                       |    4 +-
 drivers/net/wireless/ath/Kconfig                                          |    4 +-
 drivers/net/wireless/ath/ath.h                                            |    2 -
 drivers/net/wireless/ath/ath10k/core.c                                    |    9 +-
 drivers/net/wireless/ath/ath10k/core.h                                    |   88 ++
 drivers/net/wireless/ath/ath10k/coredump.c                                |   90 ++
 drivers/net/wireless/ath/ath10k/coredump.h                                |    2 +
 drivers/net/wireless/ath/ath10k/debug.c                                   |  154 +++
 drivers/net/wireless/ath/ath10k/debug.h                                   |   41 +
 drivers/net/wireless/ath/ath10k/debugfs_sta.c                             |  286 ++++
 drivers/net/wireless/ath/ath10k/htt_rx.c                                  |  113 +-
 drivers/net/wireless/ath/ath10k/mac.c                                     |   54 +-
 drivers/net/wireless/ath/ath10k/pci.c                                     |  101 +-
 drivers/net/wireless/ath/ath10k/trace.h                                   |   12 +-
 drivers/net/wireless/ath/ath10k/txrx.c                                    |   12 +-
 drivers/net/wireless/ath/ath10k/wmi-ops.h                                 |   56 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c                                 |  116 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h                                 |   18 +
 drivers/net/wireless/ath/ath10k/wmi.c                                     |  462 ++++++-
 drivers/net/wireless/ath/ath10k/wmi.h                                     |   94 +-
 drivers/net/wireless/ath/ath5k/attach.c                                   |    2 +-
 drivers/net/wireless/ath/ath5k/base.c                                     |    6 +-
 drivers/net/wireless/ath/ath5k/debug.c                                    |   37 +-
 drivers/net/wireless/ath/ath5k/qcu.c                                      |    2 -
 drivers/net/wireless/ath/ath5k/sysfs.c                                    |    8 +-
 drivers/net/wireless/ath/ath6kl/debug.c                                   |   43 +-
 drivers/net/wireless/ath/ath9k/common-debug.c                             |    9 +-
 drivers/net/wireless/ath/ath9k/common-init.c                              |    2 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c                          |   22 +-
 drivers/net/wireless/ath/ath9k/debug.c                                    |   40 +-
 drivers/net/wireless/ath/ath9k/debug_sta.c                                |    6 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c                                |    4 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c                            |   16 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c                             |    2 +-
 drivers/net/wireless/ath/ath9k/hw.c                                       |   14 +-
 drivers/net/wireless/ath/ath9k/init.c                                     |   11 +-
 drivers/net/wireless/ath/ath9k/tx99.c                                     |    4 +-
 drivers/net/wireless/ath/ath9k/xmit.c                                     |    4 +
 drivers/net/wireless/ath/carl9170/debug.c                                 |    8 +-
 drivers/net/wireless/ath/carl9170/main.c                                  |    4 +-
 drivers/net/wireless/ath/dfs_pattern_detector.c                           |    2 +-
 drivers/net/wireless/ath/wcn36xx/debug.c                                  |    5 +-
 drivers/net/wireless/ath/wcn36xx/dxe.c                                    |   69 +-
 drivers/net/wireless/ath/wcn36xx/dxe.h                                    |  221 ++-
 drivers/net/wireless/ath/wcn36xx/main.c                                   |   14 +-
 drivers/net/wireless/ath/wcn36xx/smd.c                                    |  115 +-
 drivers/net/wireless/ath/wcn36xx/txrx.c                                   |   32 +-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h                                |    2 +
 drivers/net/wireless/ath/wil6210/cfg80211.c                               |  744 +++++++---
 drivers/net/wireless/ath/wil6210/debug.c                                  |    9 +-
 drivers/net/wireless/ath/wil6210/debugfs.c                                |  117 +-
 drivers/net/wireless/ath/wil6210/ethtool.c                                |    4 +-
 drivers/net/wireless/ath/wil6210/fw.h                                     |   38 +-
 drivers/net/wireless/ath/wil6210/fw_inc.c                                 |   52 +-
 drivers/net/wireless/ath/wil6210/interrupt.c                              |    8 +-
 drivers/net/wireless/ath/wil6210/main.c                                   |  333 +++--
 drivers/net/wireless/ath/wil6210/netdev.c                                 |  382 +++++-
 drivers/net/wireless/ath/wil6210/p2p.c                                    |  175 +--
 drivers/net/wireless/ath/wil6210/pcie_bus.c                               |   57 +-
 drivers/net/wireless/ath/wil6210/pm.c                                     |  132 +-
 drivers/net/wireless/ath/wil6210/pmc.c                                    |    8 +-
 drivers/net/wireless/ath/wil6210/rx_reorder.c                             |   45 +-
 drivers/net/wireless/ath/wil6210/txrx.c                                   |  177 ++-
 drivers/net/wireless/ath/wil6210/txrx.h                                   |   22 +-
 drivers/net/wireless/ath/wil6210/wil6210.h                                |  217 ++-
 drivers/net/wireless/ath/wil6210/wmi.c                                    |  460 +++++--
 drivers/net/wireless/atmel/Kconfig                                        |    4 +-
 drivers/net/wireless/broadcom/Kconfig                                     |    4 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c                   |    6 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c                 |    2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h                    |    8 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c               |   89 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h               |   17 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c                   |   14 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h                   |    3 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c                 |   80 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c                   |  151 ++-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h                   |    4 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c                  |   42 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h                  |   17 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c                |    3 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h                |    7 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c               |  242 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h               |   82 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c                   |    3 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c               |   11 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h               |    1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c                 |    8 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c                    |    2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c                   |  177 +--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c                  |    3 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h                  |    7 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c                   |  244 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c                    |  129 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c                |    1 -
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c                  |    2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c            |    6 +-
 drivers/net/wireless/cisco/Kconfig                                        |    4 +-
 drivers/net/wireless/cisco/airo.c                                         |    6 +-
 drivers/net/wireless/intel/Kconfig                                        |    4 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c                              |   29 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c                              |   51 +-
 drivers/net/wireless/intel/ipw2x00/libipw_module.c                        |    2 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c                            |   35 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c                            |   19 +-
 drivers/net/wireless/intel/iwlegacy/4965-rs.c                             |    8 +-
 drivers/net/wireless/intel/iwlegacy/common.c                              |    4 +-
 drivers/net/wireless/intel/iwlegacy/debug.c                               |   58 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c                            |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c                             |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c                          |   78 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                             |    7 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c                               |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h                       |   20 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h                          |   73 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                               |   10 +
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c                           |   26 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.h                           |    5 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h                              |   16 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h                 |   39 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c                         |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                              |   43 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h                        |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c                      |   51 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c                          |  110 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                         |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                              |   48 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                              |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c                            |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                               |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                             |   25 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                             |  199 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                               |  158 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c                            |   26 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                             |  157 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                           |   12 +-
 drivers/net/wireless/intersil/Kconfig                                     |    4 +-
 drivers/net/wireless/intersil/p54/main.c                                  |    2 +-
 drivers/net/wireless/mac80211_hwsim.c                                     |  103 +-
 drivers/net/wireless/mac80211_hwsim.h                                     |    9 +-
 drivers/net/wireless/marvell/Kconfig                                      |    4 +-
 drivers/net/wireless/marvell/mwifiex/11n.c                                |   32 +
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                           |   40 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c                             |    3 +-
 drivers/net/wireless/marvell/mwifiex/decl.h                               |   17 +
 drivers/net/wireless/marvell/mwifiex/fw.h                                 |    7 +
 drivers/net/wireless/marvell/mwifiex/main.c                               |   24 +-
 drivers/net/wireless/marvell/mwifiex/main.h                               |   29 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c                            |   22 +
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c                        |   19 +
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c                          |   56 +-
 drivers/net/wireless/mediatek/Kconfig                                     |    4 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c                              |   10 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c                             |   68 +-
 drivers/net/wireless/mediatek/mt76/mt76.h                                 |    3 +
 drivers/net/wireless/mediatek/mt76/mt76x2.h                               |    1 +
 drivers/net/wireless/mediatek/mt76/mt76x2_debugfs.c                       |    8 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_eeprom.c                        |   12 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_init.c                          |    3 +
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c                           |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_main.c                          |   47 +
 drivers/net/wireless/mediatek/mt76/mt76x2_mcu.c                           |   13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_phy.c                           |   55 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_regs.h                          |    2 +
 drivers/net/wireless/mediatek/mt76/mt76x2_tx.c                            |    5 +-
 drivers/net/wireless/mediatek/mt7601u/debugfs.c                           |   16 +-
 drivers/net/wireless/mediatek/mt7601u/eeprom.c                            |   26 +-
 drivers/net/wireless/mediatek/mt7601u/initvals.h                          |    1 +
 drivers/net/wireless/mediatek/mt7601u/mac.c                               |   26 +-
 drivers/net/wireless/mediatek/mt7601u/mac.h                               |    1 +
 drivers/net/wireless/mediatek/mt7601u/main.c                              |    3 +
 drivers/net/wireless/mediatek/mt7601u/mcu.c                               |    7 +-
 drivers/net/wireless/mediatek/mt7601u/mt7601u.h                           |    3 +-
 drivers/net/wireless/mediatek/mt7601u/trace.h                             |    6 +-
 drivers/net/wireless/mediatek/mt7601u/usb.c                               |   52 +-
 drivers/net/wireless/quantenna/Kconfig                                    |    4 +-
 drivers/net/wireless/quantenna/qtnfmac/bus.h                              |    3 +-
 drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c                       |  418 +++---
 drivers/net/wireless/quantenna/qtnfmac/pearl/pcie_ipc.h                   |    1 +
 drivers/net/wireless/quantenna/qtnfmac/pearl/pcie_regs_pearl.h            |    1 +
 drivers/net/wireless/ralink/Kconfig                                       |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2500usb.c                            |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c                            |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c                            |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c                            |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00debug.c                          |   64 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c                              |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt73usb.c                              |    2 +-
 drivers/net/wireless/ray_cs.c                                             |    8 +-
 drivers/net/wireless/realtek/Kconfig                                      |    4 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c                        |    2 +-
 drivers/net/wireless/realtek/rtlwifi/base.c                               |   35 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c          |    3 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c          |    6 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c          |   33 -
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c          |    4 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8822bwifionly.c      |   55 +
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8822bwifionly.h      |   25 +
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c             |  108 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h             |  124 ++
 drivers/net/wireless/realtek/rtlwifi/efuse.c                              |   13 +
 drivers/net/wireless/realtek/rtlwifi/efuse.h                              |    2 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c                                |    1 +
 drivers/net/wireless/realtek/rtlwifi/rc.c                                 |   55 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/pwrseq.h                   |    4 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c                       |    3 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c                      |    1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/pwrseq.h                   |    4 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/pwrseq.h                   |    4 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/pwrseq.h                   |    4 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c                       |   16 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/pwrseq.h                   |    4 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c                       |    1 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h                               |   72 +-
 drivers/net/wireless/rsi/Kconfig                                          |   15 +-
 drivers/net/wireless/rsi/Makefile                                         |    1 +
 drivers/net/wireless/rsi/rsi_91x_coex.c                                   |  179 +++
 drivers/net/wireless/rsi/rsi_91x_core.c                                   |   20 +-
 drivers/net/wireless/rsi/rsi_91x_hal.c                                    |   56 +-
 drivers/net/wireless/rsi/rsi_91x_main.c                                   |  129 +-
 drivers/net/wireless/rsi/rsi_91x_mgmt.c                                   |    2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c                                   |  113 +-
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c                               |   65 +-
 drivers/net/wireless/rsi/rsi_91x_usb.c                                    |  187 ++-
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c                                |   31 +-
 drivers/net/wireless/rsi/rsi_coex.h                                       |   37 +
 drivers/net/wireless/rsi/rsi_common.h                                     |    5 +-
 drivers/net/wireless/rsi/rsi_hal.h                                        |   22 +
 drivers/net/wireless/rsi/rsi_main.h                                       |   21 +-
 drivers/net/wireless/rsi/rsi_mgmt.h                                       |    3 +
 drivers/net/wireless/rsi/rsi_sdio.h                                       |   10 +
 drivers/net/wireless/rsi/rsi_usb.h                                        |   17 +-
 drivers/net/wireless/st/Kconfig                                           |    4 +-
 drivers/net/wireless/st/cw1200/debug.c                                    |    6 +-
 drivers/net/wireless/st/cw1200/main.c                                     |    2 +-
 drivers/net/wireless/ti/Kconfig                                           |    4 +-
 drivers/net/wireless/ti/wl1251/main.c                                     |  102 +-
 drivers/net/wireless/ti/wl1251/tx.c                                       |    4 +-
 drivers/net/wireless/ti/wl18xx/main.c                                     |   27 +-
 drivers/net/wireless/ti/wlcore/main.c                                     |    8 +-
 drivers/net/wireless/ti/wlcore/sdio.c                                     |    2 +-
 drivers/net/wireless/ti/wlcore/sysfs.c                                    |    7 +-
 drivers/net/wireless/zydas/Kconfig                                        |    4 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c                              |    1 -
 drivers/net/xen-netback/rx.c                                              |    2 +-
 drivers/net/xen-netback/xenbus.c                                          |    4 +-
 drivers/net/xen-netfront.c                                                |    6 +-
 drivers/of/of_net.c                                                       |   40 +
 drivers/s390/net/qeth_core.h                                              |    8 -
 drivers/s390/net/qeth_core_main.c                                         |   40 +-
 drivers/s390/net/qeth_l2_main.c                                           |   34 +-
 drivers/s390/net/qeth_l3.h                                                |   34 +-
 drivers/s390/net/qeth_l3_main.c                                           |  419 ++----
 drivers/s390/net/qeth_l3_sys.c                                            |   51 +-
 drivers/scsi/iscsi_tcp.c                                                  |   14 +-
 drivers/soc/qcom/qmi_interface.c                                          |    3 +-
 drivers/ssb/Kconfig                                                       |    2 +-
 drivers/ssb/main.c                                                        |    4 +-
 drivers/staging/ipx/af_ipx.c                                              |    6 +-
 drivers/staging/irda/net/af_irda.c                                        |    8 +-
 drivers/staging/lustre/lnet/lnet/lib-socket.c                             |    7 +-
 drivers/target/iscsi/iscsi_target_login.c                                 |   18 +-
 drivers/usb/gadget/function/f_eem.c                                       |    1 -
 drivers/vhost/net.c                                                       |    7 +-
 drivers/vhost/vsock.c                                                     |    4 +-
 fs/afs/internal.h                                                         |    1 +
 fs/afs/rxrpc.c                                                            |   12 +-
 fs/dlm/lowcomms.c                                                         |    7 +-
 fs/nsfs.c                                                                 |    1 +
 fs/ocfs2/cluster/tcp.c                                                    |    6 +-
 include/asm-generic/vmlinux.lds.h                                         |   10 +
 include/dt-bindings/net/ti-dp83867.h                                      |   14 +
 include/linux/atalk.h                                                     |    2 +
 include/linux/avf/virtchnl.h                                              |  107 +-
 include/linux/bpf-cgroup.h                                                |   68 +-
 include/linux/bpf.h                                                       |    6 +-
 include/linux/bpf_types.h                                                 |    3 +
 include/linux/bpf_verifier.h                                              |   13 +-
 include/linux/ethtool.h                                                   |    5 +
 include/linux/filter.h                                                    |   34 +-
 include/linux/ieee80211.h                                                 |   14 +-
 include/linux/if_vlan.h                                                   |   24 +
 include/linux/kernel.h                                                    |    7 +
 include/linux/mlx5/accel.h                                                |  144 ++
 include/linux/mlx5/cq.h                                                   |   20 +-
 include/linux/mlx5/device.h                                               |    7 +
 include/linux/mlx5/driver.h                                               |   94 +-
 include/linux/mlx5/eswitch.h                                              |   58 +
 include/linux/mlx5/fs.h                                                   |   12 +
 include/linux/mlx5/fs_helpers.h                                           |  134 ++
 include/linux/mlx5/mlx5_ifc.h                                             |  132 +-
 include/linux/mlx5/mlx5_ifc_fpga.h                                        |   92 +-
 include/linux/mlx5/port.h                                                 |    6 +
 include/linux/mlx5/transobj.h                                             |    2 +-
 include/linux/mlx5/vport.h                                                |    3 +
 include/linux/mroute.h                                                    |  117 +-
 include/linux/mroute6.h                                                   |   70 +-
 include/linux/mroute_base.h                                               |  474 +++++++
 include/linux/net.h                                                       |    8 +-
 include/linux/netdev_features.h                                           |    2 +
 include/linux/netdevice.h                                                 |  125 +-
 include/linux/netfilter/nfnetlink_acct.h                                  |    3 +-
 include/linux/netfilter/x_tables.h                                        |    5 +-
 include/linux/of_net.h                                                    |    6 +
 include/linux/phy.h                                                       |    8 +
 include/linux/phylink.h                                                   |   17 +-
 include/linux/ptp_classify.h                                              |    4 +
 include/linux/ptr_ring.h                                                  |    7 +-
 include/linux/qed/common_hsi.h                                            |    2 +-
 include/linux/qed/eth_common.h                                            |    2 +-
 include/linux/qed/iscsi_common.h                                          |    4 +-
 include/linux/qed/qed_if.h                                                |   19 +
 include/linux/qed/rdma_common.h                                           |    2 +
 include/linux/qed/roce_common.h                                           |    3 +
 include/linux/rhashtable.h                                                |    8 +-
 include/linux/rtnetlink.h                                                 |    4 +-
 include/linux/scatterlist.h                                               |   18 +
 include/linux/sfp.h                                                       |   18 +-
 include/linux/skbuff.h                                                    |    4 +
 include/linux/socket.h                                                    |    3 +
 include/linux/trace_events.h                                              |   42 +
 include/linux/tracepoint-defs.h                                           |    6 +
 include/net/Space.h                                                       |    2 -
 include/net/act_api.h                                                     |   20 +-
 include/net/addrconf.h                                                    |   11 +-
 include/net/af_rxrpc.h                                                    |   11 +-
 include/net/ax25.h                                                        |    2 +
 include/net/bluetooth/mgmt.h                                              |    2 +-
 include/net/cfg80211.h                                                    |  178 ++-
 include/net/devlink.h                                                     |    6 -
 include/net/dsa.h                                                         |   22 +-
 include/net/dst.h                                                         |    1 +
 include/net/dst_cache.h                                                   |    4 +-
 include/net/ethoc.h                                                       |    1 -
 include/net/fib_rules.h                                                   |   45 +-
 include/net/flow.h                                                        |   18 +-
 include/net/gre.h                                                         |    3 +
 include/net/ieee80211_radiotap.h                                          |    2 +
 include/net/inet_common.h                                                 |    4 +-
 include/net/inet_connection_sock.h                                        |   10 +-
 include/net/inet_frag.h                                                   |  126 +-
 include/net/ip.h                                                          |   26 +-
 include/net/ip6_fib.h                                                     |   29 +-
 include/net/ip6_route.h                                                   |   15 +-
 include/net/ip_fib.h                                                      |   31 +-
 include/net/ip_tunnels.h                                                  |   18 +
 include/net/ipv6.h                                                        |   52 +-
 include/net/lwtunnel.h                                                    |   15 +
 include/net/mac80211.h                                                    |   22 +
 include/net/net_namespace.h                                               |   37 +-
 include/net/netevent.h                                                    |    3 +-
 include/net/netfilter/nf_conntrack_count.h                                |    1 -
 include/net/netfilter/nf_conntrack_helper.h                               |    3 +-
 include/net/netfilter/nf_tables.h                                         |   33 +-
 include/net/netfilter/xt_rateest.h                                        |    4 +-
 include/net/netns/ipv4.h                                                  |    6 +
 include/net/netns/ipv6.h                                                  |    8 +-
 include/net/pkt_cls.h                                                     |    8 +
 include/net/regulatory.h                                                  |   28 +
 include/net/route.h                                                       |    2 -
 include/net/rsi_91x.h                                                     |   56 +
 include/net/sch_generic.h                                                 |    2 +-
 include/net/sctp/auth.h                                                   |   21 +-
 include/net/sctp/command.h                                                |    1 +
 include/net/sctp/sctp.h                                                   |   11 +-
 include/net/sctp/sm.h                                                     |    3 +-
 include/net/sctp/structs.h                                                |   20 +-
 include/net/sock.h                                                        |   20 +-
 include/net/tcp.h                                                         |    9 +-
 include/net/tcp_states.h                                                  |   26 +-
 include/net/tls.h                                                         |   91 +-
 include/net/udp.h                                                         |    1 +
 include/net/xfrm.h                                                        |   16 +-
 include/rdma/ib_verbs.h                                                   |    4 +-
 include/trace/bpf_probe.h                                                 |   92 ++
 include/trace/define_trace.h                                              |    1 +
 include/trace/events/afs.h                                                |   69 +-
 include/trace/events/f2fs.h                                               |    2 +-
 include/trace/events/rxrpc.h                                              |  291 +++-
 include/uapi/linux/batadv_packet.h                                        |   15 +-
 include/uapi/linux/batman_adv.h                                           |   84 +-
 include/uapi/linux/bpf.h                                                  |  108 +-
 include/uapi/linux/bpf_perf_event.h                                       |    1 +
 include/uapi/linux/ethtool.h                                              |   36 +-
 include/uapi/linux/fib_rules.h                                            |   11 +-
 include/uapi/linux/if_ether.h                                             |    1 +
 include/uapi/linux/if_link.h                                              |   39 +
 include/uapi/linux/ncsi.h                                                 |  115 ++
 include/uapi/linux/netfilter/nf_conntrack_common.h                        |    1 +
 include/uapi/linux/netfilter/nf_tables.h                                  |   12 +-
 include/uapi/linux/netfilter/nfnetlink_conntrack.h                        |   10 +
 include/uapi/linux/netfilter/xt_connmark.h                                |   10 +
 include/uapi/linux/netfilter_bridge/ebt_ip.h                              |   15 +-
 include/uapi/linux/netfilter_bridge/ebtables.h                            |   16 +-
 include/uapi/linux/nl80211.h                                              |  136 +-
 include/uapi/linux/pkt_cls.h                                              |    4 +-
 include/uapi/linux/rds.h                                                  |    8 +
 include/uapi/linux/sctp.h                                                 |   43 +-
 include/uapi/linux/tc_ematch/tc_em_ipt.h                                  |   20 +
 include/uapi/linux/tcp.h                                                  |    3 +
 include/uapi/linux/tipc.h                                                 |  161 ++-
 include/uapi/linux/tipc_netlink.h                                         |   21 +
 include/uapi/linux/tipc_sockets_diag.h                                    |   17 +
 include/uapi/linux/tls.h                                                  |    2 +
 kernel/bpf/cgroup.c                                                       |   39 +-
 kernel/bpf/disasm.c                                                       |   52 +-
 kernel/bpf/disasm.h                                                       |    5 +-
 kernel/bpf/inode.c                                                        |    3 +
 kernel/bpf/sockmap.c                                                      | 1020 +++++++++++++-
 kernel/bpf/stackmap.c                                                     |  257 +++-
 kernel/bpf/syscall.c                                                      |  198 ++-
 kernel/bpf/verifier.c                                                     |   73 +-
 kernel/trace/bpf_trace.c                                                  |  226 +++-
 lib/kobject_uevent.c                                                      |   96 +-
 lib/rhashtable.c                                                          |    2 +
 lib/scatterlist.c                                                         |    9 +-
 lib/test_bpf.c                                                            |   93 +-
 net/8021q/vlan.c                                                          |   21 +
 net/8021q/vlan.h                                                          |    3 +
 net/8021q/vlan_core.c                                                     |  101 +-
 net/8021q/vlan_dev.c                                                      |    6 +-
 net/8021q/vlanproc.c                                                      |    6 +-
 net/appletalk/atalk_proc.c                                                |    8 +-
 net/appletalk/ddp.c                                                       |    5 +-
 net/atm/atm_sysfs.c                                                       |   12 +-
 net/atm/clip.c                                                            |    2 +-
 net/atm/lec.c                                                             |    2 +-
 net/atm/proc.c                                                            |    2 +-
 net/atm/pvc.c                                                             |    5 +-
 net/atm/svc.c                                                             |    5 +-
 net/ax25/af_ax25.c                                                        |   10 +-
 net/batman-adv/Kconfig                                                    |    2 +-
 net/batman-adv/Makefile                                                   |    2 +-
 net/batman-adv/bat_algo.c                                                 |    2 +-
 net/batman-adv/bat_algo.h                                                 |    2 +-
 net/batman-adv/bat_iv_ogm.c                                               |    2 +-
 net/batman-adv/bat_iv_ogm.h                                               |    2 +-
 net/batman-adv/bat_v.c                                                    |    2 +-
 net/batman-adv/bat_v.h                                                    |    2 +-
 net/batman-adv/bat_v_elp.c                                                |    2 +-
 net/batman-adv/bat_v_elp.h                                                |    2 +-
 net/batman-adv/bat_v_ogm.c                                                |    2 +-
 net/batman-adv/bat_v_ogm.h                                                |    2 +-
 net/batman-adv/bitarray.c                                                 |    2 +-
 net/batman-adv/bitarray.h                                                 |    2 +-
 net/batman-adv/bridge_loop_avoidance.c                                    |    2 +-
 net/batman-adv/bridge_loop_avoidance.h                                    |    2 +-
 net/batman-adv/debugfs.c                                                  |    2 +-
 net/batman-adv/debugfs.h                                                  |    2 +-
 net/batman-adv/distributed-arp-table.c                                    |  156 ++-
 net/batman-adv/distributed-arp-table.h                                    |   10 +-
 net/batman-adv/fragmentation.c                                            |    2 +-
 net/batman-adv/fragmentation.h                                            |    2 +-
 net/batman-adv/gateway_client.c                                           |    2 +-
 net/batman-adv/gateway_client.h                                           |    2 +-
 net/batman-adv/gateway_common.c                                           |    2 +-
 net/batman-adv/gateway_common.h                                           |    2 +-
 net/batman-adv/hard-interface.c                                           |    2 +-
 net/batman-adv/hard-interface.h                                           |    2 +-
 net/batman-adv/hash.c                                                     |    2 +-
 net/batman-adv/hash.h                                                     |    2 +-
 net/batman-adv/icmp_socket.c                                              |    2 +-
 net/batman-adv/icmp_socket.h                                              |    2 +-
 net/batman-adv/log.c                                                      |    2 +-
 net/batman-adv/log.h                                                      |    2 +-
 net/batman-adv/main.c                                                     |    2 +-
 net/batman-adv/main.h                                                     |   16 +-
 net/batman-adv/multicast.c                                                |  295 +++-
 net/batman-adv/multicast.h                                                |   20 +-
 net/batman-adv/netlink.c                                                  |   90 +-
 net/batman-adv/netlink.h                                                  |    2 +-
 net/batman-adv/network-coding.c                                           |    2 +-
 net/batman-adv/network-coding.h                                           |    2 +-
 net/batman-adv/originator.c                                               |    2 +-
 net/batman-adv/originator.h                                               |    2 +-
 net/batman-adv/routing.c                                                  |    2 +-
 net/batman-adv/routing.h                                                  |    2 +-
 net/batman-adv/send.c                                                     |    2 +-
 net/batman-adv/send.h                                                     |    2 +-
 net/batman-adv/soft-interface.c                                           |    2 +-
 net/batman-adv/soft-interface.h                                           |    2 +-
 net/batman-adv/sysfs.c                                                    |    2 +-
 net/batman-adv/sysfs.h                                                    |    2 +-
 net/batman-adv/tp_meter.c                                                 |    2 +-
 net/batman-adv/tp_meter.h                                                 |    2 +-
 net/batman-adv/translation-table.c                                        |    2 +-
 net/batman-adv/translation-table.h                                        |    2 +-
 net/batman-adv/tvlv.c                                                     |    2 +-
 net/batman-adv/tvlv.h                                                     |    2 +-
 net/batman-adv/types.h                                                    |    2 +-
 net/bluetooth/hci_request.c                                               |    6 +-
 net/bluetooth/hci_sock.c                                                  |    4 +-
 net/bluetooth/l2cap_sock.c                                                |    5 +-
 net/bluetooth/mgmt.c                                                      |    1 +
 net/bluetooth/rfcomm/sock.c                                               |    6 +-
 net/bluetooth/rfcomm/tty.c                                                |    4 +-
 net/bluetooth/sco.c                                                       |    5 +-
 net/bridge/br.c                                                           |    2 +-
 net/bridge/br_device.c                                                    |    4 +-
 net/bridge/br_if.c                                                        |   35 +-
 net/bridge/br_private.h                                                   |    3 +-
 net/bridge/br_sysfs_br.c                                                  |    2 +-
 net/bridge/br_sysfs_if.c                                                  |   36 +-
 net/bridge/netfilter/Kconfig                                              |    2 +-
 net/bridge/netfilter/Makefile                                             |    1 -
 net/bridge/netfilter/ebt_ip.c                                             |   58 +-
 net/bridge/netfilter/ebt_stp.c                                            |    6 +-
 net/bridge/netfilter/ebtables.c                                           |   74 +-
 net/bridge/netfilter/nf_tables_bridge.c                                   |   79 --
 net/can/af_can.c                                                          |    2 +-
 net/can/gw.c                                                              |    2 +-
 net/can/raw.c                                                             |    6 +-
 net/ceph/ceph_common.c                                                    |    2 +-
 net/core/dev.c                                                            |   75 +-
 net/core/devlink.c                                                        |   44 +-
 net/core/dst_cache.c                                                      |    4 +-
 net/core/ethtool.c                                                        |   78 +-
 net/core/fib_notifier.c                                                   |   12 +-
 net/core/fib_rules.c                                                      |  110 +-
 net/core/filter.c                                                         |  754 ++++++++++-
 net/core/flow_dissector.c                                                 |   16 -
 net/core/net-procfs.c                                                     |    6 +-
 net/core/net-sysfs.c                                                      |   12 +-
 net/core/net_namespace.c                                                  |  123 +-
 net/core/pktgen.c                                                         |   15 +-
 net/core/rtnetlink.c                                                      |   19 +-
 net/core/skbuff.c                                                         |   37 +-
 net/core/sock.c                                                           |   90 +-
 net/core/sysctl_net_core.c                                                |   12 +
 net/decnet/af_decnet.c                                                    |    8 +-
 net/decnet/dn_dev.c                                                       |    2 +-
 net/decnet/dn_neigh.c                                                     |    2 +-
 net/decnet/dn_route.c                                                     |    2 +-
 net/dns_resolver/dns_key.c                                                |    2 +-
 net/dsa/dsa.c                                                             |   36 +
 net/dsa/master.c                                                          |    4 +-
 net/dsa/slave.c                                                           |   61 +-
 net/ieee802154/6lowpan/6lowpan_i.h                                        |   26 +-
 net/ieee802154/6lowpan/core.c                                             |    1 +
 net/ieee802154/6lowpan/reassembly.c                                       |  148 +-
 net/ipv4/Kconfig                                                          |    5 +
 net/ipv4/Makefile                                                         |    1 +
 net/ipv4/af_inet.c                                                        |   76 +-
 net/ipv4/arp.c                                                            |    2 +-
 net/ipv4/esp4.c                                                           |    2 +-
 net/ipv4/esp4_offload.c                                                   |    2 +
 net/ipv4/fib_rules.c                                                      |   19 +
 net/ipv4/fib_semantics.c                                                  |   36 +-
 net/ipv4/fib_trie.c                                                       |   38 +-
 net/ipv4/igmp.c                                                           |    4 +-
 net/ipv4/inet_fragment.c                                                  |  358 +----
 net/ipv4/inetpeer.c                                                       |    3 +-
 net/ipv4/ip_fragment.c                                                    |  253 ++--
 net/ipv4/ip_gre.c                                                         |   13 +-
 net/ipv4/ip_input.c                                                       |    5 +-
 net/ipv4/ip_output.c                                                      |   17 +-
 net/ipv4/ip_sockglue.c                                                    |   34 +-
 net/ipv4/ip_tunnel.c                                                      |   54 +-
 net/ipv4/ipconfig.c                                                       |    2 +-
 net/ipv4/ipmr.c                                                           |  698 +++-------
 net/ipv4/ipmr_base.c                                                      |  365 +++++
 net/ipv4/netfilter/Kconfig                                                |    4 +-
 net/ipv4/netfilter/Makefile                                               |    2 -
 net/ipv4/netfilter/arp_tables.c                                           |   33 +-
 net/ipv4/netfilter/ip_tables.c                                            |   31 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                                        |    2 +-
 net/ipv4/netfilter/ipt_SYNPROXY.c                                         |    8 +-
 net/ipv4/netfilter/ipt_ah.c                                               |    2 +-
 net/ipv4/netfilter/nf_tables_arp.c                                        |   58 -
 net/ipv4/netfilter/nf_tables_ipv4.c                                       |   67 -
 net/ipv4/netfilter/nft_chain_nat_ipv4.c                                   |   20 +-
 net/ipv4/netfilter/nft_chain_route_ipv4.c                                 |    6 +-
 net/ipv4/ping.c                                                           |    2 +-
 net/ipv4/proc.c                                                           |   13 +-
 net/ipv4/raw.c                                                            |    4 +-
 net/ipv4/route.c                                                          |   91 +-
 net/ipv4/sysctl_net_ipv4.c                                                |   34 +-
 net/ipv4/tcp.c                                                            |   79 +-
 net/ipv4/tcp_bbr.c                                                        |   38 +-
 net/ipv4/tcp_input.c                                                      |    7 +-
 net/ipv4/tcp_ipv4.c                                                       |   44 +-
 net/ipv4/tcp_minisocks.c                                                  |    4 +-
 net/ipv4/tcp_output.c                                                     |   55 +-
 net/ipv4/tunnel4.c                                                        |    2 +-
 net/ipv4/udp.c                                                            |  102 +-
 net/ipv4/xfrm4_policy.c                                                   |    2 -
 net/ipv6/Kconfig                                                          |    1 +
 net/ipv6/addrconf.c                                                       |   91 +-
 net/ipv6/af_inet6.c                                                       |   71 +-
 net/ipv6/anycast.c                                                        |   14 +-
 net/ipv6/datagram.c                                                       |    5 +-
 net/ipv6/esp6_offload.c                                                   |    2 +
 net/ipv6/exthdrs_core.c                                                   |    1 -
 net/ipv6/fib6_rules.c                                                     |   35 +-
 net/ipv6/icmp.c                                                           |    5 +-
 net/ipv6/ip6_fib.c                                                        |   19 +-
 net/ipv6/ip6_flowlabel.c                                                  |    2 +-
 net/ipv6/ip6_gre.c                                                        |   26 +-
 net/ipv6/ip6_output.c                                                     |   19 +-
 net/ipv6/ip6_tunnel.c                                                     |   18 +-
 net/ipv6/ip6_vti.c                                                        |    2 +-
 net/ipv6/ip6mr.c                                                          | 1111 +++++++--------
 net/ipv6/ipv6_sockglue.c                                                  |    1 -
 net/ipv6/mcast.c                                                          |    8 +-
 net/ipv6/ndisc.c                                                          |    4 +-
 net/ipv6/netfilter/Kconfig                                                |    2 +-
 net/ipv6/netfilter/Makefile                                               |    1 -
 net/ipv6/netfilter/ip6_tables.c                                           |   33 +-
 net/ipv6/netfilter/ip6t_SYNPROXY.c                                        |    8 +-
 net/ipv6/netfilter/ip6t_rpfilter.c                                        |    2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c                                   |  123 +-
 net/ipv6/netfilter/nf_tables_ipv6.c                                       |   65 -
 net/ipv6/netfilter/nft_chain_nat_ipv6.c                                   |   20 +-
 net/ipv6/netfilter/nft_chain_route_ipv6.c                                 |    6 +-
 net/ipv6/netfilter/nft_fib_ipv6.c                                         |    3 +-
 net/ipv6/proc.c                                                           |   12 +-
 net/ipv6/raw.c                                                            |    2 +-
 net/ipv6/reassembly.c                                                     |  235 ++--
 net/ipv6/route.c                                                          |  306 +++--
 net/ipv6/seg6_local.c                                                     |    4 +-
 net/ipv6/sit.c                                                            |    5 +-
 net/ipv6/sysctl_net_ipv6.c                                                |   27 +
 net/ipv6/tcp_ipv6.c                                                       |   29 +-
 net/ipv6/udp.c                                                            |   72 +-
 net/ipv6/xfrm6_state.c                                                    |    1 -
 net/iucv/af_iucv.c                                                        |    5 +-
 net/kcm/kcmproc.c                                                         |    4 +-
 net/kcm/kcmsock.c                                                         |    1 +
 net/l2tp/l2tp_ip.c                                                        |    5 +-
 net/l2tp/l2tp_ip6.c                                                       |    5 +-
 net/l2tp/l2tp_ppp.c                                                       |    7 +-
 net/llc/af_llc.c                                                          |    5 +-
 net/llc/llc_proc.c                                                        |    4 +-
 net/llc/llc_sap.c                                                         |    7 +-
 net/mac80211/agg-rx.c                                                     |   14 +-
 net/mac80211/cfg.c                                                        |   13 +
 net/mac80211/debugfs.c                                                    |    1 +
 net/mac80211/debugfs_sta.c                                                |   10 +-
 net/mac80211/ht.c                                                         |   15 +
 net/mac80211/ibss.c                                                       |    3 +-
 net/mac80211/ieee80211_i.h                                                |   12 +
 net/mac80211/iface.c                                                      |    5 +-
 net/mac80211/key.c                                                        |    8 +-
 net/mac80211/main.c                                                       |   10 +-
 net/mac80211/mesh.c                                                       |    3 +-
 net/mac80211/michael.c                                                    |    2 +-
 net/mac80211/mlme.c                                                       |  182 +--
 net/mac80211/rc80211_minstrel.c                                           |    2 +-
 net/mac80211/rc80211_minstrel_debugfs.c                                   |    8 +-
 net/mac80211/rc80211_minstrel_ht.c                                        |    2 +-
 net/mac80211/rc80211_minstrel_ht_debugfs.c                                |    8 +-
 net/mac80211/rx.c                                                         |  229 +++-
 net/mac80211/scan.c                                                       |    4 +-
 net/mac80211/sta_info.c                                                   |    6 +
 net/mac80211/sta_info.h                                                   |    2 +
 net/mac80211/status.c                                                     |   11 +-
 net/mac80211/tx.c                                                         |   57 +-
 net/mac80211/util.c                                                       |   47 +-
 net/mac80211/vht.c                                                        |   39 +
 net/mac80211/wpa.c                                                        |    8 +-
 net/mac802154/trace.h                                                     |    8 +-
 net/ncsi/Makefile                                                         |    2 +-
 net/ncsi/internal.h                                                       |    3 +
 net/ncsi/ncsi-manage.c                                                    |   30 +-
 net/ncsi/ncsi-netlink.c                                                   |  427 ++++++
 net/ncsi/ncsi-netlink.h                                                   |   20 +
 net/netfilter/Kconfig                                                     |    4 +-
 net/netfilter/Makefile                                                    |    9 +-
 net/netfilter/ipset/ip_set_core.c                                         |    2 +-
 net/netfilter/ipset/ip_set_hash_mac.c                                     |    7 +-
 net/netfilter/ipvs/ip_vs_lblc.c                                           |    4 +-
 net/netfilter/ipvs/ip_vs_lblcr.c                                          |    4 +-
 net/netfilter/nf_conncount.c                                              |   14 +-
 net/netfilter/nf_conntrack_acct.c                                         |    6 +-
 net/netfilter/nf_conntrack_broadcast.c                                    |    1 -
 net/netfilter/nf_conntrack_core.c                                         |    4 +-
 net/netfilter/nf_conntrack_ecache.c                                       |    6 +-
 net/netfilter/nf_conntrack_netbios_ns.c                                   |    7 +-
 net/netfilter/nf_conntrack_netlink.c                                      |   92 +-
 net/netfilter/nf_conntrack_snmp.c                                         |    7 +-
 net/netfilter/nf_conntrack_standalone.c                                   |    2 +-
 net/netfilter/nf_conntrack_timestamp.c                                    |    6 +-
 net/netfilter/nf_log.c                                                    |    2 +-
 net/netfilter/nf_nat_core.c                                               |    4 +-
 net/netfilter/nf_nat_ftp.c                                                |    7 +-
 net/netfilter/nf_nat_irc.c                                                |    7 +-
 net/netfilter/nf_synproxy_core.c                                          |    2 +-
 net/netfilter/nf_tables_api.c                                             |  115 +-
 net/netfilter/nf_tables_inet.c                                            |   75 -
 net/netfilter/nf_tables_netdev.c                                          |  142 --
 net/netfilter/nfnetlink_acct.c                                            |    3 +-
 net/netfilter/nfnetlink_cthelper.c                                        |   25 +-
 net/netfilter/nfnetlink_cttimeout.c                                       |   26 +-
 net/netfilter/nfnetlink_queue.c                                           |   14 +-
 net/netfilter/nft_chain_filter.c                                          |  398 ++++++
 net/netfilter/nft_ct.c                                                    |   38 +
 net/netfilter/nft_dynset.c                                                |    5 +-
 net/netfilter/nft_lookup.c                                                |    4 +-
 net/netfilter/nft_objref.c                                                |    5 +-
 net/netfilter/x_tables.c                                                  |  191 ++-
 net/netfilter/xt_IDLETIMER.c                                              |    2 +-
 net/netfilter/xt_RATEEST.c                                                |   91 +-
 net/netfilter/xt_TEE.c                                                    |   73 +-
 net/netfilter/xt_cluster.c                                                |   10 +-
 net/netfilter/xt_connlimit.c                                              |    4 +-
 net/netfilter/xt_connmark.c                                               |   77 +-
 net/netfilter/xt_hashlimit.c                                              |    3 +-
 net/netfilter/xt_limit.c                                                  |    2 +-
 net/netfilter/xt_nfacct.c                                                 |    2 +-
 net/netfilter/xt_rateest.c                                                |   10 +-
 net/netfilter/xt_recent.c                                                 |    4 +-
 net/netfilter/xt_string.c                                                 |    1 +
 net/netfilter/xt_time.c                                                   |   13 +-
 net/netlink/af_netlink.c                                                  |    5 +-
 net/netrom/af_netrom.c                                                    |   15 +-
 net/nfc/llcp_sock.c                                                       |    5 +-
 net/openvswitch/datapath.c                                                |    4 +-
 net/openvswitch/vport.c                                                   |    8 +-
 net/packet/af_packet.c                                                    |   10 +-
 net/phonet/socket.c                                                       |    5 +-
 net/qrtr/qrtr.c                                                           |    5 +-
 net/rds/af_rds.c                                                          |   14 +-
 net/rds/connection.c                                                      |    7 +-
 net/rds/ib.c                                                              |    3 +
 net/rds/message.c                                                         |  163 ++-
 net/rds/rds.h                                                             |   31 +-
 net/rds/recv.c                                                            |   42 +-
 net/rds/send.c                                                            |   54 +-
 net/rds/tcp.c                                                             |  115 +-
 net/rose/af_rose.c                                                        |   13 +-
 net/rxrpc/af_rxrpc.c                                                      |   15 +-
 net/rxrpc/ar-internal.h                                                   |   77 +-
 net/rxrpc/call_accept.c                                                   |   27 +-
 net/rxrpc/call_event.c                                                    |    5 +-
 net/rxrpc/call_object.c                                                   |   32 +-
 net/rxrpc/conn_client.c                                                   |    3 +-
 net/rxrpc/conn_event.c                                                    |    6 +-
 net/rxrpc/conn_object.c                                                   |   10 +-
 net/rxrpc/conn_service.c                                                  |    1 +
 net/rxrpc/input.c                                                         |   23 +-
 net/rxrpc/local_object.c                                                  |   65 +-
 net/rxrpc/net_ns.c                                                        |   24 +-
 net/rxrpc/output.c                                                        |   59 +-
 net/rxrpc/peer_event.c                                                    |   98 +-
 net/rxrpc/peer_object.c                                                   |   93 +-
 net/rxrpc/proc.c                                                          |    6 +
 net/rxrpc/recvmsg.c                                                       |    2 +-
 net/rxrpc/rxkad.c                                                         |    2 +
 net/rxrpc/security.c                                                      |    3 -
 net/rxrpc/sendmsg.c                                                       |   10 +-
 net/sched/Kconfig                                                         |   12 +
 net/sched/Makefile                                                        |    1 +
 net/sched/act_api.c                                                       |  199 ++-
 net/sched/act_bpf.c                                                       |   10 +-
 net/sched/act_connmark.c                                                  |   11 +-
 net/sched/act_csum.c                                                      |   10 +-
 net/sched/act_gact.c                                                      |   24 +-
 net/sched/act_ife.c                                                       |   10 +-
 net/sched/act_ipt.c                                                       |   20 +-
 net/sched/act_mirred.c                                                    |   25 +-
 net/sched/act_nat.c                                                       |   11 +-
 net/sched/act_pedit.c                                                     |   10 +-
 net/sched/act_police.c                                                    |   11 +-
 net/sched/act_sample.c                                                    |   10 +-
 net/sched/act_simple.c                                                    |   10 +-
 net/sched/act_skbedit.c                                                   |   10 +-
 net/sched/act_skbmod.c                                                    |   10 +-
 net/sched/act_tunnel_key.c                                                |   10 +-
 net/sched/act_vlan.c                                                      |   12 +-
 net/sched/cls_api.c                                                       |    5 +-
 net/sched/cls_flower.c                                                    |    6 +
 net/sched/em_ipt.c                                                        |  257 ++++
 net/sched/sch_api.c                                                       |    7 +-
 net/sched/sch_htb.c                                                       |   11 +-
 net/sched/sch_prio.c                                                      |   45 +-
 net/sctp/Makefile                                                         |    2 +
 net/sctp/auth.c                                                           |  146 +-
 net/sctp/chunk.c                                                          |   14 +
 net/sctp/{sctp_diag.c => diag.c}                                          |   31 +
 net/sctp/endpointola.c                                                    |    8 +-
 net/sctp/input.c                                                          |   13 +-
 net/sctp/ipv6.c                                                           |    8 +-
 net/sctp/objcnt.c                                                         |    8 -
 net/sctp/output.c                                                         |   18 +-
 net/sctp/proc.c                                                           |   90 +-
 net/sctp/protocol.c                                                       |   61 +-
 net/sctp/sm_make_chunk.c                                                  |   33 +-
 net/sctp/sm_sideeffect.c                                                  |   13 +
 net/sctp/sm_statefuns.c                                                   |   56 +-
 net/sctp/socket.c                                                         |  828 ++++++-----
 net/smc/af_smc.c                                                          |  211 +--
 net/smc/smc.h                                                             |    9 +-
 net/smc/smc_clc.c                                                         |  214 ++-
 net/smc/smc_clc.h                                                         |   22 +-
 net/smc/smc_core.c                                                        |  100 +-
 net/smc/smc_core.h                                                        |   16 +-
 net/smc/smc_ib.c                                                          |   10 +-
 net/smc/smc_llc.c                                                         |  408 +++++-
 net/smc/smc_llc.h                                                         |   41 +-
 net/smc/smc_wr.h                                                          |    1 -
 net/socket.c                                                              |   51 +-
 net/sunrpc/auth_gss/svcauth_gss.c                                         |    2 +-
 net/sunrpc/cache.c                                                        |   10 +-
 net/sunrpc/clnt.c                                                         |    6 +-
 net/sunrpc/debugfs.c                                                      |    6 +-
 net/sunrpc/rpc_pipe.c                                                     |   42 +-
 net/sunrpc/svcsock.c                                                      |   13 +-
 net/sunrpc/xprtsock.c                                                     |    3 +-
 net/tipc/Kconfig                                                          |    8 +
 net/tipc/Makefile                                                         |    7 +-
 net/tipc/addr.c                                                           |  159 +--
 net/tipc/addr.h                                                           |   47 +-
 net/tipc/bcast.c                                                          |    2 +-
 net/tipc/bearer.c                                                         |  160 ++-
 net/tipc/bearer.h                                                         |    2 +-
 net/tipc/core.c                                                           |    6 +-
 net/tipc/core.h                                                           |   23 +-
 net/tipc/diag.c                                                           |  114 ++
 net/tipc/discover.c                                                       |  392 +++---
 net/tipc/discover.h                                                       |    8 +-
 net/tipc/group.c                                                          |    2 +-
 net/tipc/link.c                                                           |   39 +-
 net/tipc/link.h                                                           |    4 +-
 net/tipc/msg.c                                                            |    2 +-
 net/tipc/msg.h                                                            |   23 +-
 net/tipc/name_distr.c                                                     |  152 +--
 net/tipc/name_distr.h                                                     |    3 +-
 net/tipc/name_table.c                                                     | 1164 +++++++---------
 net/tipc/name_table.h                                                     |   66 +-
 net/tipc/net.c                                                            |   80 +-
 net/tipc/net.h                                                            |    5 +-
 net/tipc/node.c                                                           |  129 +-
 net/tipc/node.h                                                           |    9 +-
 net/tipc/server.c                                                         |  710 ----------
 net/tipc/socket.c                                                         |  187 ++-
 net/tipc/socket.h                                                         |   10 +-
 net/tipc/subscr.c                                                         |  361 +----
 net/tipc/subscr.h                                                         |   68 +-
 net/tipc/topsrv.c                                                         |  703 ++++++++++
 net/tipc/{server.h => topsrv.h}                                           |   57 +-
 net/tipc/udp_media.c                                                      |   14 +
 net/tls/Kconfig                                                           |    1 +
 net/tls/tls_main.c                                                        |  206 ++-
 net/tls/tls_sw.c                                                          |  713 ++++++++--
 net/unix/af_unix.c                                                        |   10 +-
 net/vmw_vsock/af_vsock.c                                                  |    4 +-
 net/wireless/ap.c                                                         |    1 +
 net/wireless/chan.c                                                       |    9 +-
 net/wireless/core.h                                                       |   12 +-
 net/wireless/ibss.c                                                       |   27 +-
 net/wireless/mesh.c                                                       |   16 +-
 net/wireless/mlme.c                                                       |    9 +-
 net/wireless/nl80211.c                                                    |  408 +++++-
 net/wireless/rdev-ops.h                                                   |   30 +
 net/wireless/reg.c                                                        |  206 ++-
 net/wireless/sme.c                                                        |   43 +-
 net/wireless/trace.h                                                      |   72 +-
 net/wireless/util.c                                                       |    5 +-
 net/wireless/wext-core.c                                                  |    6 +-
 net/wireless/wext-proc.c                                                  |    2 +-
 net/x25/af_x25.c                                                          |    4 +-
 net/x25/x25_proc.c                                                        |   12 +-
 net/x25/x25_subr.c                                                        |    3 +-
 net/xfrm/xfrm_device.c                                                    |    2 +-
 net/xfrm/xfrm_input.c                                                     |    3 +-
 net/xfrm/xfrm_policy.c                                                    |    7 +-
 net/xfrm/xfrm_proc.c                                                      |    2 +-
 samples/bpf/Makefile                                                      |    5 +
 samples/bpf/bpf_load.c                                                    |   22 +-
 samples/bpf/cookie_uid_helper_example.c                                   |    2 +-
 samples/bpf/cpustat_kern.c                                                |  281 ++++
 samples/bpf/cpustat_user.c                                                |  219 +++
 samples/bpf/tcbpf2_kern.c                                                 |    6 +-
 samples/bpf/test_cgrp2_sock.sh                                            |    1 +
 samples/bpf/test_cgrp2_sock2.sh                                           |    3 +
 samples/bpf/test_overhead_raw_tp_kern.c                                   |   17 +
 samples/bpf/test_overhead_user.c                                          |   12 +
 samples/bpf/test_tunnel_bpf.sh                                            |    5 +-
 samples/bpf/trace_event_kern.c                                            |    4 +
 samples/bpf/trace_event_user.c                                            |   15 +
 samples/bpf/xdp_redirect_user.c                                           |    7 +
 samples/sockmap/Makefile                                                  |    2 +-
 samples/sockmap/sockmap_kern.c                                            |  239 +++-
 samples/sockmap/sockmap_test.sh                                           |  488 +++++++
 samples/sockmap/sockmap_user.c                                            |  360 ++++-
 security/apparmor/include/path.h                                          |    7 +-
 security/selinux/include/xfrm.h                                           |    4 +-
 security/tomoyo/network.c                                                 |    5 +-
 sound/firewire/amdtp-stream-trace.h                                       |    2 +-
 tools/bpf/Makefile                                                        |   78 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst                          |   18 +-
 tools/bpf/bpftool/Makefile                                                |    6 +-
 tools/bpf/bpftool/bash-completion/bpftool                                 |   13 +-
 tools/bpf/bpftool/cfg.c                                                   |  514 +++++++
 tools/bpf/bpftool/cfg.h                                                   |   43 +
 tools/bpf/bpftool/main.c                                                  |  104 +-
 tools/bpf/bpftool/prog.c                                                  |  305 +----
 tools/bpf/bpftool/xlated_dumper.c                                         |  338 +++++
 tools/bpf/bpftool/xlated_dumper.h                                         |   64 +
 tools/include/uapi/linux/bpf.h                                            |  107 +-
 tools/lib/bpf/bpf.c                                                       |   55 +-
 tools/lib/bpf/bpf.h                                                       |   18 +-
 tools/lib/bpf/libbpf.c                                                    |  114 +-
 tools/lib/bpf/libbpf.h                                                    |    8 +
 tools/testing/selftests/bpf/Makefile                                      |   25 +-
 tools/testing/selftests/bpf/bpf_helpers.h                                 |   12 +
 tools/testing/selftests/bpf/bpf_rlimit.h                                  |   28 +
 tools/testing/selftests/bpf/connect4_prog.c                               |   45 +
 tools/testing/selftests/bpf/connect6_prog.c                               |   61 +
 tools/testing/selftests/bpf/sockmap_parse_prog.c                          |   15 +-
 tools/testing/selftests/bpf/sockmap_tcp_msg_prog.c                        |   33 +
 tools/testing/selftests/bpf/sockmap_verdict_prog.c                        |    7 +
 tools/testing/selftests/bpf/test_align.c                                  |    6 +-
 tools/testing/selftests/bpf/test_dev_cgroup.c                             |    6 +-
 tools/testing/selftests/bpf/test_lpm_map.c                                |   14 +-
 tools/testing/selftests/bpf/test_lru_map.c                                |    6 +-
 tools/testing/selftests/bpf/test_maps.c                                   |   62 +-
 tools/testing/selftests/bpf/test_progs.c                                  |  230 +++-
 tools/testing/selftests/bpf/test_sock.c                                   |  479 +++++++
 tools/testing/selftests/bpf/test_sock_addr.c                              |  588 ++++++++
 tools/testing/selftests/bpf/test_sock_addr.sh                             |   57 +
 tools/testing/selftests/bpf/test_stacktrace_build_id.c                    |   60 +
 tools/testing/selftests/bpf/test_tag.c                                    |    4 +-
 tools/testing/selftests/bpf/test_tcpbpf_user.c                            |    2 +
 tools/testing/selftests/bpf/test_verifier.c                               |  304 ++++-
 tools/testing/selftests/bpf/test_verifier_log.c                           |    8 +-
 tools/testing/selftests/bpf/urandom_read.c                                |   22 +
 tools/testing/selftests/net/Makefile                                      |    2 +-
 tools/testing/selftests/net/config                                        |    5 +
 tools/testing/selftests/net/fib-onlink-tests.sh                           |  467 +++++++
 tools/testing/selftests/net/fib_tests.sh                                  |  664 +++++----
 tools/testing/selftests/net/forwarding/.gitignore                         |    1 +
 tools/testing/selftests/net/forwarding/README                             |   56 +
 tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh               |   88 ++
 tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh             |   86 ++
 tools/testing/selftests/net/forwarding/config                             |   12 +
 tools/testing/selftests/net/forwarding/forwarding.config.sample           |   35 +
 tools/testing/selftests/net/forwarding/lib.sh                             |  577 ++++++++
 tools/testing/selftests/net/forwarding/router.sh                          |  125 ++
 tools/testing/selftests/net/forwarding/router_multipath.sh                |  376 +++++
 tools/testing/selftests/net/forwarding/tc_actions.sh                      |  202 +++
 tools/testing/selftests/net/forwarding/tc_chains.sh                       |  122 ++
 tools/testing/selftests/net/forwarding/tc_common.sh                       |   25 +
 tools/testing/selftests/net/forwarding/tc_flower.sh                       |  196 +++
 tools/testing/selftests/net/forwarding/tc_shblocks.sh                     |  122 ++
 tools/testing/selftests/net/in_netns.sh                                   |   23 +
 tools/testing/selftests/net/msg_zerocopy.c                                |  131 +-
 tools/testing/selftests/net/pmtu.sh                                       |  471 +++++++
 tools/testing/selftests/net/psock_fanout.c                                |   35 +-
 tools/testing/selftests/net/rtnetlink.sh                                  |    6 +
 tools/testing/selftests/net/run_afpackettests                             |    4 +-
 tools/testing/selftests/networking/timestamping/txtimestamp.c             |   21 +-
 tools/testing/selftests/tc-testing/README                                 |  173 ++-
 tools/testing/selftests/tc-testing/TODO.txt                               |   25 +-
 tools/testing/selftests/tc-testing/TdcPlugin.py                           |   74 +
 tools/testing/selftests/tc-testing/creating-plugins/AddingPlugins.txt     |  104 ++
 tools/testing/selftests/tc-testing/creating-testcases/AddingTestCases.txt |   35 +-
 tools/testing/selftests/tc-testing/plugin-lib/README-PLUGINS              |   27 +
 tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py                 |  141 ++
 tools/testing/selftests/tc-testing/plugin-lib/rootPlugin.py               |   19 +
 tools/testing/selftests/tc-testing/plugin-lib/valgrindPlugin.py           |  142 ++
 tools/testing/selftests/tc-testing/plugins/__init__.py                    |    0
 tools/testing/selftests/tc-testing/tc-tests/actions/bpf.json              |  289 ++++
 tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json         |  291 ++++
 tools/testing/selftests/tc-testing/tc-tests/actions/csum.json             |  410 ++++++
 tools/testing/selftests/tc-testing/tc-tests/actions/gact.json             |   71 +
 tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json           |  192 +++
 tools/testing/selftests/tc-testing/tc-tests/actions/police.json           |  144 ++
 tools/testing/selftests/tc-testing/tc-tests/actions/skbedit.json          |  168 +++
 tools/testing/selftests/tc-testing/tc-tests/actions/skbmod.json           |   24 +
 tools/testing/selftests/tc-testing/tc-tests/actions/vlan.json             |  410 ++++++
 tools/testing/selftests/tc-testing/tdc.py                                 |  576 +++++---
 tools/testing/selftests/tc-testing/tdc_batch.py                           |    8 +-
 tools/testing/selftests/tc-testing/tdc_helper.py                          |   15 +-
 1674 files changed, 101698 insertions(+), 28185 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
 create mode 100644 Documentation/devicetree/bindings/net/nixge.txt
 create mode 100644 Documentation/networking/ice.txt
 create mode 100644 Documentation/networking/net_dim.txt
 create mode 100644 Documentation/networking/nf_flowtable.txt
 create mode 100644 drivers/bluetooth/btrsi.c
 delete mode 100644 drivers/bluetooth/btuart_cs.c
 create mode 100644 drivers/bluetooth/h4_recv.h
 create mode 100644 drivers/crypto/chelsio/chtls/Makefile
 create mode 100644 drivers/crypto/chelsio/chtls/chtls.h
 create mode 100644 drivers/crypto/chelsio/chtls/chtls_cm.c
 create mode 100644 drivers/crypto/chelsio/chtls/chtls_cm.h
 create mode 100644 drivers/crypto/chelsio/chtls/chtls_hw.c
 create mode 100644 drivers/crypto/chelsio/chtls/chtls_io.c
 create mode 100644 drivers/crypto/chelsio/chtls/chtls_main.c
 create mode 100644 drivers/infiniband/hw/mlx5/ib_rep.c
 create mode 100644 drivers/infiniband/hw/mlx5/ib_rep.h
 create mode 100644 drivers/net/dsa/mv88e6xxx/global2_avb.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/global2_scratch.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/hwtstamp.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/hwtstamp.h
 create mode 100644 drivers/net/dsa/mv88e6xxx/ptp.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/ptp.h
 create mode 100644 drivers/net/ethernet/aquantia/atlantic/hw_atl/Makefile
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/srq.c
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/srq.h
 delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_fcoe.c
 delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_fcoe.h
 create mode 100644 drivers/net/ethernet/intel/ice/Makefile
 create mode 100644 drivers/net/ethernet/intel/ice/ice.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_common.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_common.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_controlq.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_controlq.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_devids.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hw_autogen.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_main.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_nvm.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_osdep.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sched.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sched.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_status.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_switch.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_switch.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txrx.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txrx.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_type.h
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
 create mode 100644 drivers/net/ethernet/microchip/lan743x_main.c
 create mode 100644 drivers/net/ethernet/microchip/lan743x_main.h
 create mode 100644 drivers/net/ethernet/netronome/nfp/bpf/Makefile
 create mode 100644 drivers/net/ethernet/netronome/nfp/flower/Makefile
 create mode 100644 drivers/net/ethernet/netronome/nfp/nfpcore/Makefile
 create mode 100644 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000/Makefile
 create mode 100644 drivers/net/ethernet/netronome/nfp/nic/Makefile
 create mode 100644 drivers/net/ethernet/ni/Kconfig
 create mode 100644 drivers/net/ethernet/ni/Makefile
 create mode 100644 drivers/net/ethernet/ni/nixge.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac5.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac5.h
 create mode 100644 drivers/net/hyperv/netvsc_trace.c
 create mode 100644 drivers/net/hyperv/netvsc_trace.h
 create mode 100644 drivers/net/ieee802154/mcr20a.c
 create mode 100644 drivers/net/ieee802154/mcr20a.h
 create mode 100644 drivers/net/netdevsim/devlink.c
 create mode 100644 drivers/net/netdevsim/fib.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8822bwifionly.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8822bwifionly.h
 create mode 100644 drivers/net/wireless/rsi/rsi_91x_coex.c
 create mode 100644 drivers/net/wireless/rsi/rsi_coex.h
 create mode 100644 include/linux/mlx5/accel.h
 create mode 100644 include/linux/mlx5/eswitch.h
 create mode 100644 include/linux/mlx5/fs_helpers.h
 create mode 100644 include/linux/mroute_base.h
 create mode 100644 include/net/rsi_91x.h
 create mode 100644 include/trace/bpf_probe.h
 create mode 100644 include/uapi/linux/ncsi.h
 create mode 100644 include/uapi/linux/tc_ematch/tc_em_ipt.h
 create mode 100644 include/uapi/linux/tipc_sockets_diag.h
 delete mode 100644 net/bridge/netfilter/nf_tables_bridge.c
 create mode 100644 net/ipv4/ipmr_base.c
 delete mode 100644 net/ipv4/netfilter/nf_tables_arp.c
 delete mode 100644 net/ipv4/netfilter/nf_tables_ipv4.c
 delete mode 100644 net/ipv6/netfilter/nf_tables_ipv6.c
 create mode 100644 net/ncsi/ncsi-netlink.c
 create mode 100644 net/ncsi/ncsi-netlink.h
 delete mode 100644 net/netfilter/nf_tables_inet.c
 delete mode 100644 net/netfilter/nf_tables_netdev.c
 create mode 100644 net/netfilter/nft_chain_filter.c
 create mode 100644 net/sched/em_ipt.c
 rename net/sctp/{sctp_diag.c => diag.c} (92%)
 create mode 100644 net/tipc/diag.c
 delete mode 100644 net/tipc/server.c
 create mode 100644 net/tipc/topsrv.c
 rename net/tipc/{server.h => topsrv.h} (55%)
 create mode 100644 samples/bpf/cpustat_kern.c
 create mode 100644 samples/bpf/cpustat_user.c
 create mode 100644 samples/bpf/test_overhead_raw_tp_kern.c
 create mode 100755 samples/sockmap/sockmap_test.sh
 create mode 100644 tools/bpf/bpftool/cfg.c
 create mode 100644 tools/bpf/bpftool/cfg.h
 create mode 100644 tools/bpf/bpftool/xlated_dumper.c
 create mode 100644 tools/bpf/bpftool/xlated_dumper.h
 create mode 100644 tools/testing/selftests/bpf/bpf_rlimit.h
 create mode 100644 tools/testing/selftests/bpf/connect4_prog.c
 create mode 100644 tools/testing/selftests/bpf/connect6_prog.c
 create mode 100644 tools/testing/selftests/bpf/sockmap_tcp_msg_prog.c
 create mode 100644 tools/testing/selftests/bpf/test_sock.c
 create mode 100644 tools/testing/selftests/bpf/test_sock_addr.c
 create mode 100755 tools/testing/selftests/bpf/test_sock_addr.sh
 create mode 100644 tools/testing/selftests/bpf/test_stacktrace_build_id.c
 create mode 100644 tools/testing/selftests/bpf/urandom_read.c
 create mode 100755 tools/testing/selftests/net/fib-onlink-tests.sh
 create mode 100644 tools/testing/selftests/net/forwarding/.gitignore
 create mode 100644 tools/testing/selftests/net/forwarding/README
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
 create mode 100644 tools/testing/selftests/net/forwarding/config
 create mode 100644 tools/testing/selftests/net/forwarding/forwarding.config.sample
 create mode 100644 tools/testing/selftests/net/forwarding/lib.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_multipath.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_actions.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_chains.sh
 create mode 100644 tools/testing/selftests/net/forwarding/tc_common.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_flower.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_shblocks.sh
 create mode 100755 tools/testing/selftests/net/in_netns.sh
 create mode 100755 tools/testing/selftests/net/pmtu.sh
 create mode 100644 tools/testing/selftests/tc-testing/TdcPlugin.py
 create mode 100644 tools/testing/selftests/tc-testing/creating-plugins/AddingPlugins.txt
 create mode 100644 tools/testing/selftests/tc-testing/plugin-lib/README-PLUGINS
 create mode 100644 tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
 create mode 100644 tools/testing/selftests/tc-testing/plugin-lib/rootPlugin.py
 create mode 100644 tools/testing/selftests/tc-testing/plugin-lib/valgrindPlugin.py
 create mode 100644 tools/testing/selftests/tc-testing/plugins/__init__.py
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/bpf.json
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/csum.json
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/vlan.json
