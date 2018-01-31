Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeAaUxo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:53:44 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:51814 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeAaUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:53:36 -0500
Date: Wed, 31 Jan 2018 15:53:27 -0500 (EST)
Message-Id: <20180131.155327.1552729615452088417.davem@davemloft.net>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0VKrufL001307


I did a test merge and there were two conflicts, both of which are
overlapping changes and easily resolved.  For example, a local
variable was removed in one commit that was one line above a variable
who had it's type changed in another commit.  That sort of thing.

1) Siginificantly shrink the core networking routing structures.
   Results of http://vger.kernel.org/~davem/seoul2017_netdev_keynote.pdf

2) Add netdevsim driver for testing various offloads, from Jakub
   Kicinski.

3) Support cross-chip FDB operations in DSA, from Vivien Didelot.

4) Add a 2nd listener hash table for TCP, similar to what was done
   for UDP.  From Martin KaFai Lau.

5) Add eBPF based queue selection to tun, from Jason Wang.

6) Lockless qdisc support, from John Fastabend.

7) SCTP stream interleave support, from Xin Long.

8) Smoother TCP receive autotuning, from Eric Dumazet.

9) Lots of erspan tunneling enhancements, from William Tu.

10) Add true function call support to BPF, from Alexei Starovoitov.

11) Add explicit support for GRO HW offloading, from Michael Chan.

12) Support extack generation in more netlink subsystems.  From
    Alexander Aring, Quentin Monnet, and Jakub Kicinski.

13) Add 1000BaseX, flow control, and EEE support to mvneta driver.
    From Russell King.

14) Add flow table abstraction to netfilter, from Pablo Neira Ayuso.

15) Many improvements and simplifications to the NFP driver bpf JIT,
    from Jakub Kicinski.

16) Support for ipv6 non-equal cost multipath routing, from Ido
    Schimmel.

17) Add resource abstration to devlink, from Arkadi Sharshevsky.

18) Packet scheduler classifier shared filter block support, from
    Jiri Pirko.

19) Avoid locking in act_csum, from Davide Caratti.

20) devinet_ioctl() simplifications from Al viro.

21) More TCP bpf improvements from Lawrence Brakmo.

22) Add support for onlink ipv6 route flag, similar to ipv4, from
    aDavid Ahern.

Please pull, thanks a lot!

The following changes since commit ba804bb4b72e57374b5f567b783aa0298fba0ce6:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-01-26 09:03:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 

for you to fetch changes up to a54667f6728c2714a400f3c884727da74b6d1717:

  tls: Add support for encryption using async offload accelerator (2018-01-31 10:26:30 -0500)

----------------------------------------------------------------
AceLan Kao (2):
      Bluetooth: btusb: Add support for 0cf3:e010
      ath9k: add a quirk to set use_msi automatically

Adiel Aloni (1):
      mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED

Ahmed Abdelsalam (1):
      netfilter: add IPv6 segment routing header 'srh' match

Al Viro (10):
      net: separate SIOCGIFCONF handling from dev_ioctl()
      devinet_ioctl(): take copyin/copyout to caller
      ip_rt_ioctl(): take copyin to caller
      kill dev_ifsioc()
      kill bond_ioctl()
      kill dev_ifname32()
      lift handling of SIOCIW... out of dev_ioctl()
      ipconfig: use dev_set_mtu()
      dev_ioctl(): move copyin/copyout to callers
      kill kernel_sock_ioctl()

Alan Brady (2):
      i40evf: ignore link up if not running
      i40e: fix FW_LLDP flag on init

Alan Liu (1):
      ath10k: add memory dump support for QCA6174/QCA9377

Alexander Aring (23):
      net: sched: sch_api: fix code style issues
      net: sched: sch_api: rearrange init handling
      net: sched: fix coding style issues
      net: sched: sch_api: handle generic qdisc errors
      net: sched: sch: add extack for init callback
      net: sched: sch: add extack for change qdisc ops
      net: sched: sch: add extack to change class
      net: sched: sch: add extack for block callback
      net: sched: sch: add extack for graft callback
      net: sch: api: add extack support in qdisc_get_rtab
      net: sch: api: add extack support in tcf_block_get
      net: sch: api: add extack support in qdisc_alloc
      net: sch: api: add extack support in qdisc_create_dflt
      net: sch: sch_cbq: add extack support
      net: sch: sch_cbs: add extack support
      net: sch: sch_drr: add extack support
      net: sched: cls: fix code style issues
      net: sched: cls_api: handle generic cls errors
      net: sched: cls: add extack support for change callback
      net: sched: cls: add extack support for tcf_exts_validate
      net: sched: cls: add extack support for delete callback
      net: sched: cls: add extack support for tcf_change_indev
      net: sched: cls_u32: add extack support

Alexander Duyck (22):
      ixgbe: Fix interaction between SR-IOV and macvlan offload
      ixgbe: Perform reinit any time number of VFs change
      ixgbe: Add support for macvlan offload RSS on X550 and clean-up pool handling
      ixgbe: There is no need to update num_rx_pools in L2 fwd offload
      ixgbe: Fix limitations on macvlan so we can support up to 63 offloaded devices
      ixgbe: Use ring values to test for Tx pending
      ixgbe: Drop l2_accel_priv data pointer from ring struct
      i40evf: Do not clear MSI-X PBA manually
      i40evf: Clean-up flags for promisc mode to avoid high polling rate
      i40evf: Drop i40evf_fire_sw_int as it is prone to races
      ixgbe: Assume provided MAC filter has been verified by macvlan
      ixgbe: Default to 1 pool always being allocated
      ixgbe: Don't assume dev->num_tc is equal to hardware TC config
      ixgbe/fm10k: Record macvlan stats instead of Rx queue for macvlan offloaded rings
      ixgbe: Do not manipulate macvlan Tx queues when performing macvlan offload
      ixgbe: avoid bringing rings up/down as macvlans are added/removed
      ixgbe: Fix handling of macvlan Tx offload
      net: Cap number of queues even with accel_priv
      fm10k: Fix configuration for macvlan offload
      i40e/i40evf: Use ring pointers to clean up _set_itr_per_queue
      i40e/i40evf: Record ITR register location in the q_vector
      i40e/i40evf: Update DESC_NEEDED value to reflect larger value

Alexei Starovoitov (39):
      bpf: fix stack state printing in verifier log
      bpf: print liveness info to verifier log
      bpf: don't mark FP reg as uninit
      bpf: improve verifier liveness marks
      bpf: improve JEQ/JNE path walking
      bpf: cleanup register_is_null()
      selftests/bpf: adjust test_align expected output
      Merge branch 'bpf-devel-doc'
      Merge branch 'bpf-tracing-multiprog-tp-query'
      Merge branch 'bpf-override-return'
      bpf: introduce function calls (function boundaries)
      bpf: introduce function calls (verification)
      selftests/bpf: add verifier tests for bpf_call
      bpf: teach verifier to recognize zero initialized stack
      selftests/bpf: add tests for stack_zero tracking
      libbpf: add support for bpf_call
      selftests/bpf: add bpf_call test
      selftests/bpf: add xdp noinline test
      bpf: add support for bpf_call to interpreter
      bpf: fix net.core.bpf_jit_enable race
      bpf: x64: add JIT support for multi-function programs
      bpf: arm64: add JIT support for multi-function programs
      bpf: arm64: fix uninitialized variable
      Merge branch 'bpftool-improvements-kallsymfix'
      bpf: fix maximum stack depth tracking logic
      selftests/bpf: additional stack depth tests
      bpf: fix max call depth check
      Merge branch 'xdp_rxq_info'
      bpf: fix verifier GPF in kmalloc failure path
      Merge branch 'error-injection'
      bpf: allow socket_filter programs to use bpf_prog_test_run
      selftests/bpf: make test_verifier run most programs
      Merge branch 'bpf-misc-improvements'
      selftests/bpf: speedup test_maps
      selftests/bpf: fix test_dev_cgroup
      selftests/bpf: make 'dubious pointer arithmetic' test useful
      Merge branch 'bpf-more-sock_ops-callbacks'
      Merge branch 'bpf-improvements-and-fixes'
      Merge branch 'fix-lpm-map'

Alexey Dobriyan (2):
      net: delete /proc THIS_MODULE references
      netfilter: delete /proc THIS_MODULE references

Alexey Kodanev (1):
      ip6_vti: adjust vti mtu according to mtu of lower device

Alice Michael (3):
      i40e: display priority_xon and priority_xoff stats
      i40e/i40evf: Bump driver versions
      i40e: change flags to use 64 bits

Amritha Nambiar (1):
      i40e: Fix channel addition in reset flow

Andrew Lunn (7):
      net: mdio: Only perform gpio reset for PHYs
      net: phy: marvell: mv88e6390 temperature sensor reading
      net: dsa: mv88e6xxx: Decode ATU problem interrupt
      net: dsa: mv88e6xxx: Decode VTU problem interrupt
      net: phy: Have __phy_modify return 0 on success
      net: dsa: mv88e6xxx: Return error from irq_find_mapping()
      net: dsa: mv88e6xxx: Free ATU/VTU irq only when there is chip irq

Andrew Morton (1):
      net/sched/sch_prio.c: work around gcc-4.4.4 union initializer issues

Andy Gospodarek (11):
      net/mlx5e: Move interrupt moderation structs to new file
      net/mlx5e: Move interrupt moderation forward declarations
      net/mlx5e: Remove rq references in mlx5e_rx_am
      net/mlx5e: Move AM logic enums
      net/mlx5e: Move generic functions to new file
      net/mlx5e: Change Mellanox references in DIM code
      net/mlx5e: Move dynamic interrupt coalescing code to include/linux
      net/dim: use struct net_dim_sample as arg to net_dim
      bnxt_en: add support for software dynamic interrupt moderation
      MAINTAINERS: add entry for Dynamic Interrupt Moderation
      bnxt_en: cleanup DIM work on device shutdown

Andy Shevchenko (6):
      Bluetooth: Utilize %*ph specifier
      Bluetooth: introduce DEFINE_SHOW_ATTRIBUTE() macro
      bridge: Use helpers to handle MAC address
      net: bonding: Replace mac address parsing
      net: pasemi: Replace mac address parsing
      net: amd-xgbe: Get rid of custom hex_dump_to_buffer()

Andy Spencer (1):
      gianfar: prevent integer wrapping in the rx handler

Anilkumar Kolli (3):
      ath10k: remove MAC80211_DEBUGFS dependency on ath10k_sta_statistics
      ath10k: move pktlog_filter out of ath10k_debug
      ath10k: add per peer tx stats support for 10.2.4

Antoine Tenart (4):
      net: mvpp2: only free the TSO header buffers when it was allocated
      net: mvpp2: align values in ethtool get_coalesce
      net: mvpp2: report the tx-usec coalescing information to ethtool
      net: mvpp2: adjust the coalescing parameters

Arend Van Spriel (7):
      brcmfmac: Rename buscore to core for consistency
      brcmfmac: More efficient and slightly easier to read fixup for 4339 chips
      brcmfmac: Remove array of functions
      brcmfmac: add comment block in brcmf_sdio_buscore_read()
      brcmfmac: rename brcmf_sdiod_buff_{read,write}() functions
      brcmfmac: assure bcdc dcmd api does not return value > 0
      brcmfmac: separate firmware errors from i/o errors

Arjun Vynipadath (3):
      cxgb4: Add support for ethtool i2c dump
      cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages
      cxgb3: assign port id to net_device->dev_port

Arkadi Sharshevsky (15):
      devlink: Add per devlink instance lock
      devlink: Add support for resource abstraction
      devlink: Add support for reload
      devlink: Add relation between dpipe and resource
      mlxsw: pci: Add support for performing bus reset
      mlxsw: spectrum: Register KVD resources with devlink
      mlxsw: spectrum_dpipe: Connect dpipe tables to resources
      mlxsw: spectrum: Add support for getting kvdl occupancy
      mlxsw: pci: Add support for getting resource through devlink
      mlxsw: core: Add support for reload
      mlxsw: documentation: Add resources ABI documentation
      mlxsw: spectrum_acl: Add support for mirroring action
      mlxsw: spectrum: Extend and export SPAN API
      mlxsw: spectrum: Extend mlxsw_afa_ops for counter index and implement for Spectrum
      mlxsw: spectrum_acl: Add support for mirror action

Arnd Bergmann (18):
      netxen: remove timespec usage
      openvswitch: use ktime_get_ts64() instead of ktime_get_ts()
      can: peak_usb: remove some 'struct timeval' users
      can: peak_usb: use ktime_t consistently
      wlcore: use boottime for fw time sync
      ath10k: use 64-bit crash dump timestamps
      wlcore: fix unused function warning
      wil6210: fix build warnings without CONFIG_PM
      net/mlx5e: hide an unused variable
      Bluetooth: hciuart: add nvmem dependency
      netfilter: improve flow table Kconfig dependencies
      net: socionext: include linux/io.h to fix build
      net: netsec: use dma_addr_t for storing dma address
      netfilter: nf_tables: flow_offload depends on flow_table
      netfilter: nf_defrag: mark xt_table structures 'const' again
      netfilter: nf_defrag: move NF_CONNTRACK bits into #ifdef
      can: m_can: mark runtime-PM handlers as __maybe_unused
      caif: reduce stack size with KASAN

Ashish Kalra (1):
      bcma: Adjust block comment

Avinash Dayanand (2):
      i40evf: Don't schedule reset_task when device is being removed
      i40e: Fix kdump failure

Aviv Heller (1):
      xfrm: Remove redundant state assignment in xfrm_input()

Avraham Stern (1):
      iwlwifi: mvm: add WFA vendor specific TPC report IE to probe request

Balaji Pothunoori (2):
      ath10k: handling qos at STA side based on AP WMM enable/disable
      ath10k: advertise TDLS wider bandwidth support for 5GHz

Ben Greear (1):
      ath10k: fix invalid STS_CAP_OFFSET_MASK

Benjamin Beichler (2):
      mac80211_hwsim: add hashtable with mac address keys for faster lookup
      mac80211_hwsim: add hwsim_tx_rate_flags to netlink attributes

Bert Kenward (5):
      sfc: update EF10 register definitions
      sfc: populate the timer reload field
      sfc: expose CTPIO stats on NICs that support them
      sfc: remove tx and MCDI handling from NAPI budget consideration
      sfc: add suffix to large constant in ptp

Bhumika Goyal (1):
      can: c_can_pci: make c_can_pci_data const

Bjorn Andersson (1):
      wcn36xx: Reduce spinlock in indication handler

Bjorn Helgaas (1):
      cxgb4: Simplify PCIe Completion Timeout setting

Bjørn Mork (1):
      qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect

Brian Norris (2):
      Revert "mwifiex: cancel pcie/sdio work in remove/shutdown handler"
      mwifiex: resolve reset vs. remove()/shutdown() deadlocks

Carl Heymann (14):
      nfp: debug dump ethtool ops
      nfp: load debug dump spec
      nfp: dump prolog
      nfp: dumpspec TLV traversal
      nfp: dump rtsyms
      nfp: dump all hwinfo
      nfp: dump single hwinfo field by key
      nfp: dump firmware name
      nfp: dump CPP, XPB and direct ME CSRs
      nfp: dump indirect ME CSRs
      nfp: debug dump - decrease endian conversions
      nfp: fix absolute rtsym handling in debug dump
      nfp: fix XPB register reads in debug dump
      nfp: fix fw dump handling of absolute rtsym size

Christian Brauner (4):
      rtnetlink: enable IFLA_IF_NETNSID in do_setlink()
      rtnetlink: enable IFLA_IF_NETNSID for RTM_SETLINK
      rtnetlink: enable IFLA_IF_NETNSID for RTM_DELLINK
      rtnetlink: enable IFLA_IF_NETNSID for RTM_NEWLINK

Christian Lamparter (3):
      net: ibm: emac: replace custom rgmii_mode_name with phy_modes
      net: ibm: emac: replace custom PHY_MODE_* macros
      net: ibm: emac: support RGMII-[RX|TX]ID phymode

Christopher Díaz Riveros (2):
      flow_netlink: Remove unneeded semicolons
      debugfs_sta: Remove unneeded semicolons

Chunhao Lin (1):
      r8169: fix RTL8168EP take too long to complete driver initialization.

Colin Ian King (26):
      atm: eni: fix several indentation issues
      netdevsim: make functions nsim_bpf_create_prog and nsim_bpf_destroy_prog static
      rtlwifi: rtl818x: remove redundant check for cck_power > 15
      wlcore, wl1251: fix spelling: "Couldnt" -> "Couldn't" and remove error on -ENOMEM
      brcmsmac: use ARRAY_SIZE on rfseq_updategainu_events
      net: alteon: acenic: clean up indentation issue
      bpf: fix spelling mistake: "funcation"-> "function"
      bpf: make function skip_callee static and return NULL rather than 0
      ath10k: wmi: remove redundant integer fc
      mt76: fix memcpy to potential null pointer on failed allocation
      wl1251: check return from call to wl1251_acx_arp_ip_filter
      Bluetooth: bpa10x: make array 'req' static, shrinks object size
      Bluetooth: btintel: make array 'param' static, shrinks object size
      wcn36xx: fix incorrect assignment to msg_body.min_ch_time
      be2net: use ARRAY_SIZE for array sizing calculation on array cmd_priv_map
      ipv6: use ARRAY_SIZE for array sizing calculation on array seg6_action_table
      i40e: remove redundant initialization of read_size
      ath10k: fix spelling mistake: "addrress" -> "address"
      ath10k: remove redundant -ve check against u32 integer size
      rtlwifi: btcoexist: remove redundant variable fw_ps_state
      bnxt_en: don't update cpr->rx_bytes with uninitialized length len
      devlink: fix memory leak on 'resource'
      net: caif: remove redundant re-assignment of pointer pfrm
      bnx2: remove redundant initializations of pointers txr and rxr
      ixgbevf: use ARRAY_SIZE for various array sizing calculations
      ixgbe: use ARRAY_SIZE for array sizing calculation on array buf

Cong Wang (12):
      net_sched: get rid of rcu_barrier() in tcf_block_put_ext()
      net_sched: remove unused parameter from act cleanup ops
      act_mirred: get rid of tcfm_ifindex from struct tcf_mirred
      act_mirred: get rid of mirred_list_lock spinlock
      netlink: make netlink tap per netns
      netlink: convert netlink tap spinlock to mutex
      net_sched: switch to exit_batch for action pernet ops
      net_sched: properly check for empty skb array on error path
      tun: avoid calling xdp_rxq_info_unreg() twice
      net: introduce helper dev_change_tx_queue_len()
      net_sched: plug in qdisc ops change_tx_queue_len
      net_sched: implement ->change_tx_queue_len() for pfifo_fast

Corinna Vinschen (1):
      igb: Allow to remove administratively set MAC on VFs

Dan Carpenter (5):
      bnxt_en: Uninitialized variable in bnxt_tc_parse_actions()
      ath9k_htc: Add a sanity check in ath9k_htc_ampdu_action()
      rtlwifi: check for array overflow
      tools/bpf_jit_disasm: silence a static checker warning
      ixgbe: Fix && vs || typo

Daniel Borkmann (48):
      Merge branch 'bpf-verifier-misc-improvements'
      Merge branch 'bpf-nfp-jmp-memcpy-improvements'
      Merge branch 'bpf-xdp-stack-uninit-and-offload-tests'
      bpf, doc: add bpf trees and tps to maintainers entry
      bpf, doc: add faq about bpf development process
      Merge branch 'bpf-bpftool-makefile-cleanups'
      Merge branch 'bpf-bpftool-cgroup-ops'
      Merge branch 'bpf-nfp-jit-adjust-head-support'
      selftests/bpf: additional bpf_call tests
      Merge branch 'bpf-to-bpf-function-calls'
      bpf: fix kallsyms handling for subprogs
      bpf: allow for correlation of maps and helpers in dump
      Merge branch 'bpf-stack-depth-tracking-fixes'
      Merge branch 'bpf-offload-report-dev'
      Merge branch 'bpf-bpftool-misc-fixes'
      Merge branch 'bpf-stacktrace-map-next-key-support'
      Merge branch 'bpf-xdp-rxq-fixes'
      Merge branch 'bpf-nfp-misc-improvements'
      Merge branch 'bpf-nfp-map-offload'
      Merge branch 'bpf-various-improvements'
      Merge branch 'bpf-libbpf-cleanups'
      Merge branch 'bpf-dump-and-disasm-nfp-jit'
      Merge branch 'bpf-improve-test-verifier-coverage'
      Merge branch 'bpf-array-map-offload-and-tests'
      Merge branch 'bpf-lpm-get-next-key'
      bpf, verifier: detect misconfigured mem, size argument pair
      bpf: add csum_diff helper to xdp as well
      bpf: add couple of test cases for signed extended imms
      bpf: add couple of test cases for div/mod by zero
      bpf: get rid of pure_initcall dependency to enable jits
      bpf: restrict access to core bpf sysctls
      bpf, x86: small optimization in alu ops with imm
      bpf: add upper complexity limit to verifier log
      bpf: move event_output to const_size_or_zero for xdp/skb as well
      Merge branch 'bpf-samples-sockmap-improvements'
      bpf: xor of a/x in cbpf can be done in 32 bit alu
      bpf: improve dead code sanitizing
      bpf: make unknown opcode handling more robust
      bpf: fix subprog verifier bypass by div/mod by 0 exception
      bpf, x86_64: remove obsolete exception handling from div/mod
      bpf, arm64: remove obsolete exception handling from div/mod
      bpf, s390x: remove obsolete exception handling from div/mod
      bpf, ppc64: remove obsolete exception handling from div/mod
      bpf, sparc64: remove obsolete exception handling from div/mod
      bpf, mips64: remove obsolete exception handling from div/mod
      bpf, mips64: remove unneeded zero check from div/mod with k
      bpf, arm: remove obsolete exception handling from div/mod
      bpf: add further test cases around div/mod and others

Daniel Hua (1):
      igb: Clear TXSTMP when ptp_tx_work() is timeout

Dave Ertman (1):
      i40e: Implement an ethtool private flag to stop LLDP in FW

David Ahern (8):
      samples/bpf: Convert magic numbers to names in multi-prog cgroup test case
      net: ipv6: Allow connect to linklocal address from socket bound to vrf
      net/ipv6: Do not allow route add with a device that is down
      net/ipv4: Allow send to local broadcast from a socket bound to a VRF
      net/ipv6: Move gateway validation into helper
      net/ipv6: Add flags and table id to ip6_nh_lookup_table
      net/ipv6: Add support for onlink flag
      net: ipv6: send unsolicited NA after DAD

David Decotigny (1):
      net: core: Expose number of link up/down transitions

David Lechner (9):
      Bluetooth: hci_ll: remove \n from kernel messages
      Bluetooth: serdev: hci_ll: Wait for CTS instead of using msleep
      Bluetooth: hci_ll: add constant for vendor-specific command
      Bluetooth: hci_ll: Add endianness conversion when setting baudrate
      Bluetooth: hci_ll: add support for setting public address
      dt-bindings: Add optional nvmem BD address bindings to ti,wlink-st
      Bluetooth: hci_ll: Add optional nvmem BD address source
      dt-bindings: net: add TI CC2560 Bluetooth chip
      Bluetooth: hci_ll: add "ti,cc2560" compatible string

David Miller (13):
      net: dst->rt_next is unused.
      decnet: Move dn_next into decnet route structure.
      ipv6: Move rt6_next from dst_entry into ipv6 route structure.
      net: Create and use new helper xfrm_dst_child().
      ipsec: Create and use new helpers for dst child access.
      xfrm: Move child route linkage into xfrm_dst.
      ipv6: Move dst->from into struct rt6_info.
      xfrm: Move dst->path into struct xfrm_dst
      net: Rearrange dst_entry layout to avoid useless padding.
      xfrm: Stop using dst->next in bundle construction.
      net: Remove dst->next
      libbpf: Fix build errors.
      bpf: sparc64: Add JIT support for multi-function programs.

David S. Miller (196):
      Merge branch 'net-dst_entry-shrink'
      Merge branch 'macb-rx-packet-filtering'
      Merge branch 'rds-tcp-netns-delete-related-fixes'
      Merge branch 'ethtool-reset-AP'
      Merge branch 'ip6_gre-add-erspan-native-tunnel-for-ipv6'
      Merge branch 'cpsw-ale-cleanups'
      Merge branch 'dsa-simplify-switchdev-prepare-phase'
      Merge branch 'dsa-cross-chip-FDB-support'
      Merge branch 'realtek-phy-improvements'
      Merge branch 'hv_netvsc-minor-optimizations'
      Merge branch 'tcp-2nd-listener-hash'
      Merge branch 'ipv6-gre-collect_md'
      Merge branch 'rtnetlink-rework-handler-registration'
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge tag 'linux-can-next-for-4.16-20171201' of git://git.kernel.org/.../mkl/linux-can-next
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'SFP-phylink-updates'
      Merge branch 'hns3-reset-refactor'
      Merge branch 'phylib-hard-resetting-devices'
      Merge branch 'ieee802154-for-davem-2017-12-04' of git://git.kernel.org/.../sschmidt/wpan-next
      Merge branch 'nfp-enhanced-debug-dump-via-ethtool'
      Merge branch 'sch_api-style'
      Merge branch 'dsa-use-per-port-upstream-port'
      Merge branch 'macb-rx-filter-cleanups'
      Merge branch 'ipv6-add-ip6erspan-collect_md-mode'
      Merge branch 'smc-fixes-next'
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge branch 'lockless-qdisc-series'
      Merge branch 'veth-and-GSO-maximums'
      Merge branch 'cxgb4-collect-hardware-logs-via-ethtool'
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'rhashtable-New-features-in-walk-and-bucket'
      Merge branch 'sctp-stream-interleave-part-1'
      Merge branch 'nfp-dead-code-clean-ups-and-slight-improvements'
      Merge branch 'tcp-better-receiver-autotuning'
      Merge branch 'mvpp2-various-improvements'
      Merge branch 'fec-fix-refclk-enable-for-SMSC-LAN8710-20'
      Merge branch 'hv_netvsc-Fix-default-and-limit-of-recv-buffer'
      Merge branch 'rmnet-Configuration-options'
      Merge branch 'r8169-device-managed'
      Merge branch 'phylink-dsa-prep'
      Merge branch 'hv_netvsc-minor-changes'
      Merge branch 'dsa-MT7530-vlan'
      Merge branch 'hnx3-vf'
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec-next
      Merge branch 'ipvlan-packet-scrub'
      Merge branch 'nfp-ethtool-flash-updates'
      Merge branch 'erspan-version-2'
      Merge branch 'nfp-fix-rtsym-and-XPB-register-handling-in-debug-dump'
      Merge branch 'sfp-SFF-module-support'
      Merge branch 'sctp-stream-interleave'
      Merge git://git.kernel.org/.../davem/net
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge branch 'sfc-Medford2'
      Merge branch 'phy-meson-gxl-clean-up-and-improvements'
      Merge branch 'sfp-phylink-fixes'
      Merge branch 'erspan-a-couple-fixes'
      Merge branch 'net-NETIF_F_GRO_HW'
      Merge branch 'net-speedup-vxlan-geneve-tunnel-dismantle'
      Merge branch 'bcm63xx_enet-remove-mac_id-usage'
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth-next
      Merge tag 'wireless-drivers-next-for-davem-2017-12-18' of git://git.kernel.org/.../kvalo/wireless-drivers-next
      Merge branch 'ibmvnic-Fix-and-increase-maximum-TX-RX-queues'
      Merge branch 'nfp-flower-add-Geneve-tunnel-support'
      Merge branch 'netdevsim-couple-of-build-warning-fixes'
      Merge branch 'replace-tcp_set_state-tracepoint-with-inet_sock_set_state'
      Merge tag 'batadv-next-for-davem-20171220' of git://git.open-mesh.org/linux-merge
      Merge branch 's390-net-next'
      Merge branch 'net-sched-extack'
      Merge branch 'sfc-Medford2'
      Merge branch 'flow_dissector-Provide-basic-batman-adv-unicast-handling'
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'hns3-next'
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec-next
      Merge branch 'l2tp-next'
      Merge branch 'rds-bug-fixes'
      Merge branch 'net-zerocopy-refine'
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge branch 'AVE-ethernet'
      Merge branch 'mlx4-misc-for-4.16'
      Merge tag 'mlx5-shared-4.16-1' of git://git.kernel.org/.../mellanox/linux
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'net-sched-Fix-RED-qdisc-offload-flag'
      Merge branch 's390-next'
      Merge branch 'qed-Advance-to-FW-8.33.1.0'
      Merge branch 'tcp-sctp-dccp-Replace-jprobe-usage-with-trace-events'
      Merge branch 'ena-next'
      Merge branch 'marvell10g-phy-updates'
      Merge branch 'further-sfp-phylink-updates'
      Merge branch 'net-stmmac-Couple-of-debug-prints-improvements'
      Merge branch 'net-Renesas-kill-redundant-checks'
      Merge branch 'mvneta-phylink'
      Merge branch 'net-Resolve-races-in-phy-accessors'
      Merge branch 'nfp-flower-repr-link-state'
      Merge branch 'dsa-lan9303-phy_addr_sel_strap-rename-and-retype'
      Merge tag 'mac80211-next-for-davem-2018-01-04' of git://git.kernel.org/.../jberg/mac80211-next
      Merge branch 'l2tp-remove-configurable-offset-parameters'
      Merge branch 'dsa-Move-padding-into-Broadcom-tagger'
      Merge branch 'tipc-two-small-cleanups'
      Merge branch 'rds-use-RCU-between-work-enqueue-and-connection-teardown'
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge branch 'ipv6-ipv4-nexthop-align'
      Merge branch 'net-qualcomm-rmnet-Enable-csum-offloads'
      Merge branch 'hns3-next'
      Merge git://git.kernel.org/.../pablo/nf-next
      Merge branch 'net-netdev_WARN_ONCE'
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'XDP-transmission-for-tuntap'
      Merge branch 'ethtool-ringparam-upper-bound'
      Merge branch 'tipc-improvements-to-group-messaging'
      Merge branch 'r8169-improve-runtime-pm'
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'Socionext-Synquacer-NETSEC-driver'
      Merge branch 'hns3-next'
      Merge tag 'mlx5-updates-2018-01-08' of git://git.kernel.org/.../saeed/linux
      Merge branch 'ipv6-Add-support-for-non-equal-cost-multipath'
      Merge branch 'net-create-dynamic-software-irq-moderation-library'
      Merge branch 'mlxsw-qdisc-refactoring'
      Merge branch 'sfc-support-25G-configuration-with-ethtool'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth-next
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'hns3-add-some-new-features-and-fix-some-bugs'
      Merge branch 'dsa-mv88e6xxx-ATU-VTU-irq'
      Merge branch 'mlxsw-Offload-PRIO-qdisc'
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'dsa-lan9303-check-error-value-from-devm_gpiod_get_optional'
      Merge tag 'wireless-drivers-next-for-davem-2018-01-13' of git://git.kernel.org/.../kvalo/wireless-drivers-next
      Merge branch 'sh_eth-simplify-TSU-initialization'
      Merge tag 'linux-can-next-for-4.16-20180105' of ssh://gitolite.kernel.org/.../mkl/linux-can-next
      Merge branch 'phy-add-helpers-for-setting-clearing-bits-in-PHY-registers'
      Merge branch 'devlink-resource'
      Merge branch 'net-thunderx-add-support-for-PTP-clock'
      Merge branch 'aquantia-next'
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'dwmac-meson8b-clock-fixes-for-Meson8b'
      Merge branch 'bnxt_en-next'
      Merge branch 'net-sched-allow-qdiscs-to-share-filter-block-instances'
      Merge branch 'tun-allow-to-attach-eBPF-filter'
      Merge tag 'linux-can-next-for-4.16-20180116' of ssh://gitolite.kernel.org/.../mkl/linux-can-next
      Merge tag 'wireless-drivers-next-for-davem-2018-01-19' of git://git.kernel.org/.../kvalo/wireless-drivers-next
      Merge tag 'linux-can-next-for-4.16-20180119' of ssh://gitolite.kernel.org/.../mkl/linux-can-next
      Merge branch 'cxgb4-reduce-memory-footprint-for-collecting-firmware-dump'
      Merge branch 'l2tp-set-l2specific_len-based-on-l2specific_type'
      Merge branch 'tcp-min-rtt'
      Merge branch 'nfp-devlink-capabilities-extensions-and-updates'
      Merge branch 'net-sched-cls-add-extack-support'
      Merge branch 'dsa-mv88e6xxx-ATU-VTU-irq-fixes'
      Merge git://git.kernel.org/.../davem/net
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge git://git.kernel.org/.../pablo/nf-next
      Merge tag 'mlx5-updates-2018-01-19' of git://git.kernel.org/.../saeed/linux
      Merge branch 'Aquantia-atlantic-driver-new-devices-support'
      Merge branch 'mlxsw-Add-support-for-mirror-action-with-flower'
      Merge branch 'mlxsw-spectrum_router-Optimize-LPM-trees'
      Merge tag 'mac80211-next-for-davem-2018-01-22' of git://git.kernel.org/.../jberg/mac80211-next
      Merge branch 'mvpp2-Armada-7k-8k-PP2-ACPI-support'
      Merge branch 'hns3-new-features'
      Merge branch 'net-sched-add-extack-support-for-cls-offloads'
      Merge branch 'Kernel-doc-fixes-for-networking'
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'GEHC-Bx50-Switch-Support'
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'act_csum-spinlock-remove'
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch 'bpf-and-netdevsim-test-updates'
      Merge branch 'net-smc-socket-closing-improvements'
      Merge branch 'cxgb4-fix-build-error'
      Merge branch 'pktgen-Behavior-flags-fixes'
      Merge branch 'net-sched-propagate-extack-to-cls-offloads-on-destroy-and-only-with-skip_sw'
      Merge branch '1GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge branch '100GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'rebased-net-ioctl' of git://git.kernel.org/.../viro/vfs
      Merge branch 'sfc-support-PTP-on-8000-and-X2000-series-NICs'
      Merge branch 'net-smc-more-socket-closing-improvements'
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth-next
      Merge branch 'use-tc_cls_can_offload_and_chain0-throughout-the-drivers'
      Merge branch 'net-erspan-add-support-for-openvswitch'
      Merge branch 'net-ipv6-Add-support-for-ONLINK-flag'
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec-next
      Merge branch 'net-smc-fixes-2018-01-26'
      Merge tag 'linux-can-next-for-4.16-20180126' of ssh://gitolite.kernel.org/.../mkl/linux-can-next
      Merge branch 'hns3-next'
      Merge branch 'cxgb4-fix-dump-collection-when-firmware-crashed'
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge git://git.kernel.org/.../bpf/bpf-next
      Merge branch '40GbE' of git://git.kernel.org/.../jkirsher/next-queue
      Merge tag 'wireless-drivers-next-for-davem-2018-01-26' of git://git.kernel.org/.../kvalo/wireless-drivers-next
      Merge git://git.kernel.org/.../davem/net
      Merge branch 'rtnetlink-enable-IFLA_IF_NETNSID-for-RTM_DELLINK-RTM_SETINK'
      Merge branch 'ptr_ring-fixes'
      Merge branch 'net-Ease-to-follow-an-interface-that-moves-to-another-netns'
      Merge branch 'net_sched-reflect-tx_queue_len-change-for-pfifo_fast'

David Spinadel (2):
      mac80211: Add MIC space only for TX key option
      nl80211: send deauth reason if locally generated

Davide Caratti (2):
      net/sched: act_csum: use per-core statistics
      net/sched: act_csum: don't use spinlock in the fast path

Dedy Lansky (4):
      wil6210: print human readable names of WMI commands and events
      wil6210: support Scheduled scan
      wil6210: remove leftover "FIXME"s
      wil6210: support flashless device

Denys Vlasenko (1):
      batman-adv: Deinline batadv_orig_hash_find, save 7339 bytes

Dirk van der Merwe (5):
      nfp: extend NSP infrastructure for configurable timeouts
      nfp: implement firmware flashing
      nfp: flower: obtain repr link state only from firmware
      nfp: add repr_preclean callback
      nfp: flower: implement the PORT_REIFY message

Dmitry Safonov (5):
      Documentation/pktgen: Clearify how-to use pktgen samples
      pktgen: Add missing !flag parameters
      pktgen: Add behaviour flags macro to generate flags/names
      pktgen: Remove brute-force printing of flags
      pktgen: Clean read user supplied flag mess

Double Lo (1):
      brcmfmac: Support 43455 save-restore (SR) feature if FW include -sr

Edward Cree (12):
      sfc: make mem_bar a function rather than a constant
      sfc: support VI strides other than 8k
      sfc: add Medford2 (SFC9250) PCI Device IDs
      sfc: improve PTP error reporting
      sfc: update MCDI protocol headers
      sfc: support variable number of MAC stats
      sfc: expose FEC stats on Medford2
      sfc: basic MCDI mapping of 25/50/100G link speeds
      sfc: support the ethtool ksettings API properly so that 25/50/100G works
      sfc: add bits for 25/50/100G supported/advertised speeds
      sfc: on 8000 series use TX queues for TX timestamps
      sfc: support second + quarter ns time format for receive datapath

Egil Hjelmeland (5):
      net: dsa: lan9303: Protect ALR operations with mutex
      net: dsa: lan9303: Introduce lan9303_read_wait
      net: dsa: lan9303: lan9303_csr_reg_wait cleanups
      net: dsa: lan9303: phy_addr_sel_strap rename and retype
      net: dsa: lan9303: Adjust phy_addr_base expressions

Elena Reshetova (2):
      net: convert lcs_reply.refcnt from atomic_t to refcount_t
      qeth: convert qeth_reply.refcnt from atomic_t to refcount_t

Emil Tantilov (13):
      ixgbe: enable multicast on shutdown for WOL
      ixgbe: remove unused enum latency_range
      ixgbevf: remove redundant setting of xcast_mode
      ixgbevf: add function for checking if we can reuse page
      ixgbevf: only DMA sync frame length
      ixgbevf: use length to determine if descriptor is done
      ixgbevf: add support for DMA_ATTR_SKIP_CPU_SYNC/WEAK_ORDERING
      ixgbevf: update code to better handle incrementing page count
      ixgbevf: add counters for Rx page allocations
      ixgbevf: clear rx_buffer_info in configure instead of clean
      ixgbevf: improve performance and reduce size of ixgbevf_tx_map()
      ixgbevf: don't bother clearing tx_buffer_info in ixgbevf_clean_tx_ring()
      ixgbe: don't set RXDCTL.RLPML for 82599

Emmanuel Grumbach (8):
      iwlwifi: mvm: rs: don't override the rate history in the search cycle
      iwlwifi: mvm: revert support new Coex firmware API
      iwlwifi: print the version number of the firmware in hex
      iwlwifi: fix the ALIVE notification layout
      iwlwifi: mvm: remove set but unused variable in iwl_mvm_roc_done_wk
      mac80211: always update the PM state of a peer on MGMT / DATA frames
      iwlwifi: fw: fix the enums in the rate scaling API
      iwlwifi: define and use if iwl_mvm_has_tlc_offload

Eran Ben Elisha (4):
      net/mlx5e: Print delta since last transmit per SQ upon TX timeout
      net/mlx5e: Add Event Queue meta data info for TX timeout logs
      net/mlx5e: Poll event queue upon TX timeout before performing full channels recovery
      net/mlx5e: Add per-channel counters infrastructure, use it upon TX timeout

Eric Dumazet (8):
      tcp: do not overshoot window_clamp in tcp_rcv_space_adjust()
      tcp: avoid integer overflows in tcp_rcv_space_adjust()
      tcp: smoother receiver autotuning
      tcp/dccp: avoid one atomic operation for timewait hashdance
      net: sk_pacing_shift_update() helper
      ipv6: mcast: remove dead code
      ipv6: addrconf: break critical section in addrconf_verify_rtnl()
      net_sched: gen_estimator: fix lockdep splat

Erik Stromdahl (3):
      ath10k: fix spelling error
      ath10k: remove unused prototype
      ath10k: bugfix: add USB case in ath10k_core_probe_fw

Eugenia Emantayev (5):
      net/core: Add drop counters to VF statistics
      net/mlx5e: E-switch, Add steering drop counters
      ethtool: Ensure new ring parameters are within bounds during SRINGPARAM
      net/mlx4_en: Align behavior of set ring size flow via ethtool
      net/mlx5e: Remove redundant checks in set_ringparam

Eyal Ilsar (1):
      wcn36xx: set default BTLE coexistence config

Fabio Estevam (1):
      dt-bindings: fec: Make the phy-reset-gpio polarity explicit

Fabrizio Castro (1):
      dt-bindings: can: rcar_can: document r8a774[35] can support

Faiz Abbas (3):
      can: m_can: Remove check for version when allocating m_can net device
      can: m_can: Move allocation of net device to probe
      can: m_can: Add PM Support

Felix Fietkau (19):
      dt-bindings: net: add mt76 wireless device binding
      mt76: add common code shared between multiple chipsets
      mt76: add driver code for MT76x2e
      mt76x2: remove some harmless WARN_ONs in tx status and rx path
      mt76x2: increase OFDM SIFS time
      mt76x2: add channel argument to eeprom tx power functions
      mt76x2: initialize channel power limits at probe time
      mt76x2: convert between per-chain tx power and combined output
      mt76x2: configure rx filter based on monitor mode setting
      mt76: fix transmission of encrypted management frames
      ath9k: discard undersized packets
      mt76: retry rx polling as long as there is budget left
      mt76: fix TSF value in probe responses
      mt76: add an intermediate struct for rx status information
      mt76: get station pointer by wcid and pass it to mac80211
      mt76: implement A-MPDU rx reordering in the driver code
      mt76: split mt76_rx_complete
      mt76: pass the per-vif wcid to the core for multicast rx
      mt76: validate rx CCMP PN

Felix Walter (1):
      macsec: Add support for GCM-AES-256 cipher suite

Fengguang Wu (2):
      mt76: fix debugfs_simple_attr.cocci warnings
      mt76: fix returnvar.cocci warnings

Feras Daoud (3):
      net/mlx5e: IPoIB, Use correct timestamp in child receive flow
      net/mlx5e: IPoIB, Add PTP ioctl support for child interface
      net/mlx5e: IPoIB, Add ethtool support to get child time stamping parameters

Florian Fainelli (21):
      net: dsa: bcm_sf2: Utilize b53_get_tag_protocol()
      net: dsa: Allow compiling out legacy support
      net: phy: phylink: Allow specifying PHY device flags
      net: phy: phylink: Use PHY device interface if N/A
      net: phy: phylink: Remove error message
      net: phy: phylink: Allow setting a custom link state callback
      net: phy: phylink: Report MoCA as PORT_BNC
      net: dsa: bcm_sf2: Update compatible string for 7278B0
      net: phy: phylink: Handle NULL fwnode_handle
      net: phy: broadcom: Add entry for 5395 switch PHYs
      net: dsa: Fix dsa_legacy_register() return value
      net: stmmac: Pad ring number with zeroes in display_ring()
      net: stmmac: Allow debug prints of frame_len/COE
      net: dsa: Move padding into Broadcom tagger
      net: systemport: Remove short packet padding
      net: bgmac: Remove short packet padding for DSA
      net: stmmac: Fix reception of Broadcom switches tags
      net: core: Fix kernel-doc for carrier_* attributes
      net: phy: sfp: Fix kernel doc warning
      net: core: Fix kernel-doc for call_netdevice_notifiers_info()
      net: core: Fix kernel-doc for netdev_upper_link()

Florian Westphal (29):
      net: rtnetlink: use rcu to free rtnl message handlers
      rtnetlink: get reference on module before invoking handlers
      net: use rtnl_register_module where needed
      rtnetlink: remove __rtnl_register
      rtnetlink: ipv6: convert remaining users to rtnl_register_module
      rtnetlink: fix rtnl_link msghandler rcu annotations
      netfilter: conntrack: remove nlattr_size pointer from l4proto trackers
      netfilter: conntrack: constify list of builtin trackers
      netfilter: conntrack: l4 protocol trackers can be const
      netfilter: conntrack: timeouts can be const
      netfilter: ipset: use nfnl_mutex_is_locked
      netfilter: ipset: add resched points during set listing
      netfilter: core: make nf_unregister_net_hooks simple wrapper again
      netfilter: core: remove synchronize_net call if nfqueue is used
      netfilter: core: free hooks with call_rcu
      netfilter: reduce size of hook entry point locations
      netfilter: add defines for arp/decnet max hooks
      netfilter: reduce hook array sizes to what is needed
      netfilter: don't allocate space for decnet hooks unless needed
      netfilter: don't allocate space for arp/bridge hooks unless needed
      netfilter: reduce NF_MAX_HOOKS define
      netfilter: xtables: add and use xt_request_find_table_lock
      netfilter: core: only allow one nat hook per hook point
      netfilter: nf_tables: reject nat hook registration if prio is before conntrack
      netfilter: connlimit: split xt_connlimit into front and backend
      netfilter: meta: secpath support
      netfilter: x_tables: unbreak module auto loading
      netfilter: clusterip: make sure arp hooks are available
      netfilter: x_tables: don't return garbage pointer on modprobe failure

Frank A. Cancio Bello (1):
      rtlwifi: Remove unnecessary parentheses

Franklin S Cooper Jr (5):
      dt-bindings: can: can-transceiver: Document new binding
      can: dev: Add support for limiting configured bitrate
      dt-bindings: can: m_can: Document new can transceiver binding
      can: m_can: Support higher speed CAN-FD bitrates
      can: m_can: Add call to of_can_transceiver

Fuyun Liang (19):
      net: hns3: cleanup mac auto-negotiation state query
      net: hns3: fix for getting auto-negotiation state in hclge_get_autoneg
      net: hns3: add Asym Pause support to phy default features
      net: hns3: fix for updating fc_mode_last_time
      net: hns3: fix for setting MTU
      net: hns3: fix for changing MTU
      net: hns3: add MTU initialization for hardware
      net: hns3: fix for not setting pause parameters
      net: hns3: add ethtool_ops.get_coalesce support to PF
      net: hns3: add ethtool_ops.set_coalesce support to PF
      net: hns3: refactor interrupt coalescing init function
      net: hns3: refactor GL update function
      net: hns3: remove unused GL setup function
      net: hns3: change the unit of GL value macro
      net: hns3: add int_gl_idx setup for TX and RX queues
      net: hns3: add support for get_regs
      net: hns3: add manager table initialization for hardware
      net: hns3: add get/set_coalesce support to VF
      net: hns3: add int_gl_idx setup for VF

Gal Pressman (12):
      net/mlx5e: E-Switch, Use the name of static array instead of its address
      net/mlx5: Fix ingress/egress naming mistake
      net/mlx5: Separate ingress/egress namespaces for each vport
      net: Fix netdev_WARN_ONCE macro
      net: No line break on netdev_WARN* formatting
      net/mlx5e: Replace WARN_ONCE with netdev_WARN_ONCE
      e1000: Replace WARN_ONCE with netdev_WARN_ONCE
      bnx2x: Replace WARN_ONCE with netdev_WARN_ONCE
      8139cp: Replace WARN_ONCE with netdev_WARN_ONCE
      net/mlx5e: IPoIB, Fix spelling mistake "functionts" -> "functions"
      net/mlx5e: Add likely to the common RX checksum flow
      net/mlx5e: IPoIB, Fix copy-paste bug in flow steering refactoring

Ganesh Goudar (16):
      cxgb4: Report tid start range correctly for T6
      cxgb4: RSS table is 4k for T6
      cxgb4: add new T5 and T6 device id's
      cxgb4: display VNI correctly
      cxgb4/cxgb4vf: support for XLAUI Port Type
      cxgb4: use CLIP with LIP6 on T6 for TCAM filters
      cxgb4: Check alignment constraint for T6
      cxgb4: add data structures to support vxlan
      cxgb4: implement udp tunnel callbacks
      cxgb4: add support for vxlan segmentation offload
      cxgb4: implement ndo_features_check
      cxgb4: restructure VF mgmt code
      cxgb4: IPv6 filter takes 2 tids
      cxgb4: add geneve offload support for T6
      cxgb4/cxgb4vf: add support for ndo_set_vf_vlan
      cxgb4: fix possible deadlock

Gao Feng (3):
      ipvlan: Add new func ipvlan_is_valid_dev instead of duplicated codes
      ipvlan: Eliminate duplicated codes with existing function
      netfilter: ipvs: Remove useless ipvsh param of frag_safe_skb_hp

Gianluca Borello (1):
      bpf: fix stacksafe exploration when comparing states

Girish Moodalbail (1):
      macvlan: fix memory hole in macvlan_dev

Golan Ben Ami (2):
      iwlwifi: support internal debug data collection for new devices
      iwlwifi: avoid duplicate sw reset executions in the code

Govind Singh (11):
      ath10k: Update rx descriptor for WCN3990 target
      ath10k: Add support for 64 bit HTT in-order indication msg
      ath10k: Add support for 64 bit htt rx ring cfg
      ath10k: Add support for 64 bit HTT frag descriptor
      ath10k: Add support for htt_data_tx_desc_64 descriptor
      ath10k: Add hw param for rx ring size support
      ath10k: Add paddrs_ring_64 support for 64bit target
      ath10k: Use dma_addr_t for ce buffers to support 64bit target
      ath10k: Add support for 64 bit ce descriptor
      ath10k: Add SNOC bus type for WCN3990 target
      ath10k: Add debug mask for SNOC bus type

Govindarajulu Varadarajan (2):
      enic: add sw timestamp support
      enic: add wq clean up budget

Gregory Greenman (7):
      iwlwifi: mvm: rs: introduce new API for rate scaling
      iwlwifi: mvm: rs: add ops for the new rate scaling in the FW
      iwlwifi: mvm: rs: add basic implementation of the new RS API handlers
      iwlwifi: mvm: rs: new rate scale API - add FW notifications
      iwlwifi: mvm: rs: new rate scale API - add debugfs hooks
      iwlwifi: mvm: rs: add size checks when printing to a buffer
      iwlwifi: mvm: rs: add sanity check when sending LQ command

Grygorii Strashko (11):
      net: ethernet: ti: cpsw: drop unused var poll from cpsw_update_channels_res
      net: ethernet: ti: cpsw: use proper io apis
      net: ethernet: ti: cpsw: move platform data struct to .c file
      net: ethernet: ti: cpsw: move mac_hi/lo defines in cpsw.h
      net: ethernet: ti: cpsw: fix ale port numbers
      net: ethernet: ti: ale: use proper io apis
      net: ethernet: ti: ale: disable ale from stop()
      net: ethernet: ti: ale: optimize ale entry mask bits configuartion
      net: ethernet: ti: ale: move static initialization in cpsw_ale_create()
      net: ethernet: ti: ale: use devm_kzalloc in cpsw_ale_create()
      net: ethernet: ti: ale: fix port check in cpsw_ale_control_set/get

Guillaume Nault (1):
      l2tp: adjust comments about L2TPv3 offsets

Gustavo A. R. Silva (10):
      ath9k: dfs: use swap macro in ath9k_check_chirping
      mac80211: mark expected switch fall-throughs
      netfilter: mark expected switch fall-throughs
      rtlwifi: mark expected switch fall-through in rtl_make_smps_action
      netfilter: ipset: use swap macro instead of _manually_ swapping values
      netfilter: return booleans instead of integers
      bridge: return boolean instead of integer in br_multicast_is_router
      net/smc: return booleans instead of integers
      tcp_nv: fix potential integer overflow in tcpnv_acked
      openvswitch: meter: Use 64-bit arithmetic instead of 32-bit

Gustavo Padovan (1):
      Bluetooth: Remove myself from the MAINTAINERS file

Haishuang Yan (7):
      vxlan: speedup vxlan tunnels dismantle
      geneve: speedup geneve tunnels dismantle
      ip6_gre: fix a pontential issue in ip6erspan_rcv
      ip_gre: fix error path when erspan_rcv failed
      ip6_gre: fix error path when ip6erspan_rcv failed
      ip_gre: fix potential memory leak in erspan_rcv
      ip6_gre: fix potential memory leak in ip6erspan_rcv

Haiyang Zhang (3):
      hv_netvsc: Fix the receive buffer size limit
      hv_netvsc: Fix the TX/RX buffer default sizes
      hv_netvsc: Use the num_online_cpus() for channel limit

Hamad Kadmany (1):
      wil6210: abort properly in cfg suspend

Hangbin Liu (1):
      l2tp: fix missing print session offset info

Hans de Goede (6):
      Bluetooth: btusb: Add a Kconfig option to enable USB autosuspend by default
      Bluetooth: btusb: Fix BT_HCIBTUSB_AUTOSUSPEND Kconfig option name
      Bluetooth: hci_bcm: Add support for BCM2E72
      Bluetooth: btsdio: Do not bind to non-removable BCM43341
      Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a "rewritten" version
      Bluetooth: hci_bcm: For serdev case close serdev on failure to set power

Harini Katakam (1):
      net: macb: Handle HRESP error

Harsha Sharma (1):
      netfilter: nf_tables: allocate handle and delete objects via handle

Heiner Kallweit (15):
      net: phy: core: use genphy version of callbacks read_status and config_aneg per default
      net: phy: remove generic settings for callbacks config_aneg and read_status from drivers
      net: phy: core: remove now uneeded disabling of interrupts
      net: phy: core: don't disable device interrupts in phy_change
      net: phy: broadcom: re-add mistakenly removed config settings
      PCI: Add pcim_set_mwi(), a device-managed pci_set_mwi()
      r8169: switch to device-managed functions in probe
      r8169: remove netif_napi_del in probe error path
      r8169: remove unneeded rpm ops in rtl_shutdown
      r8169: improve runtime pm in rtl8169_check_link_status
      r8169: improve runtime pm in general and suspend unused ports
      net: phy: remove parameter new_link from phy_mac_interrupt()
      phy: add helpers for setting/clearing bits in PHY registers
      phy: use new helpers phy_set_bits/phy_clear_bits in phylib
      phy: realtek: use new helpers for paged register access

Himanshu Jha (4):
      qed: Use zeroing memory allocator than allocator/memset
      ethernet/broadcom: Use zeroing memory allocator than allocator/memset
      liquidio: Use zeroing memory allocator than allocator/memset
      brcmfmac: Use zeroing memory allocator than allocator/memset

Huazhong Tan (1):
      net: hns: Fix for variable may be used uninitialized warnings

Ian Molton (26):
      brcmfmac: Fix parameter order in brcmf_sdiod_f0_writeb()
      brcmfmac: Register sizes on hardware are not dependent on compiler types
      brcmfmac: Split brcmf_sdiod_regrw_helper() up.
      brcmfmac: Clean up brcmf_sdiod_set_sbaddr_window()
      brcmfmac: Remove dead IO code
      brcmfmac: Remove bandaid for SleepCSR
      brcmfmac: Remove brcmf_sdiod_request_data()
      brcmfmac: Fix asymmetric IO functions.
      brcmfmac: Remove noisy debugging.
      brcmfmac: Rename bcmerror to err
      brcmfmac: Split brcmf_sdiod_buffrw function up.
      brcmfmac: whitespace fixes in brcmf_sdiod_send_buf()
      brcmfmac: Clarify if using braces.
      brcmfmac: Rename / replace old IO functions with simpler ones.
      brcmfmac: Tidy register definitions a little
      brcmfmac: Remove brcmf_sdiod_addrprep()
      brcmfmac: remove unnecessary call to brcmf_sdiod_set_backplane_window()
      brcmfmac: Cleanup offsetof()
      brcmfmac: Remove unused macro.
      brcmfmac: Remove repeated calls to brcmf_chip_get_core()
      brcmfmac: Remove {r,w}_sdreg32
      brcmfmac: stabilise the value of ->sbwad in use for some xfer routines.
      brcmfmac: Correctly handle accesses to SDIO func0
      brcmfmac: Remove func0 from function array
      brcmfmac: Replace function index with function pointer
      brcmfmac: Clean up interrupt macros

Ido Schimmel (28):
      ipv6: Remove redundant route flushing during namespace dismantle
      ipv6: Mark dead nexthops with appropriate flags
      ipv6: Clear nexthop flags upon netdev up
      ipv6: Prepare to handle multiple netdev events
      ipv6: Set nexthop flags upon carrier change
      ipv6: Set nexthop flags during route creation
      ipv6: Check nexthop flags during route lookup instead of carrier
      ipv6: Check nexthop flags in route dump instead of carrier
      ipv6: Ignore dead routes during lookup
      ipv6: Report dead flag during route dump
      ipv6: Add explicit flush indication to routes
      ipv6: Teach tree walker to skip multipath routes
      ipv6: Export sernum update function
      ipv6: Take table lock outside of sernum update function
      ipv6: Flush multipath routes when all siblings are dead
      selftests: fib_tests: Add test cases for IPv4/IPv6 FIB
      selftests: fib_tests: Add test cases for netdev down
      selftests: fib_tests: Add test cases for netdev carrier change
      ipv6: Calculate hash thresholds for IPv6 nexthops
      ipv6: Use a 31-bit multipath hash
      ipv6: Use hash-threshold instead of modulo-N
      ipv6: Add support for non-equal-cost multipath
      mlxsw: spectrum: Fix typo in firmware upgrade message
      mlxsw: spectrum_router: Add support for IPv6 non-equal-cost multipath
      ipv6: Fix build with gcc-4.4.5
      mlxsw: spectrum_router: Use the nodes list as indication for empty FIB
      mlxsw: spectrum_router: Pass FIB node to LPM tree unlink function
      mlxsw: spectrum_router: Remove unnecessary prefix lengths from LPM tree

Igor Mitsyanko (8):
      qtnfmac: check that MAC exists in regulatory notifier
      qtnfmac: add support for radar detection and CAC
      qtnfmac: change default interface mode from AP to STA
      qtnfmac: check for passed channel being NULL in MGMT_TX command
      qtnfmac: modify GET_STA_STATS cmd format for back/forward compatibility
      qtnfmac: keeping track of "generation" for STA info
      qtnfmac: do not use mutexes in timer context
      qtnfmac: do not use bus mutex for events processing

Igor Russkikh (21):
      net: aquantia: Eliminate AQ_DIMOF, replace with ARRAY_SIZE
      net: aquantia: Cleanup status flags accesses
      net: aquantia: Cleanup hardware access modules
      net: aquantia: Remove duplicate hardware descriptors declarations
      net: aquantia: Add const qualifiers for hardware ops tables
      net: aquantia: Simplify dependencies between pci modules
      net: aquantia: Eliminate aq_nic structure abstraction
      net: aquantia: Fix register definitions to linux style
      net: aquantia: Prepend hw access functions declarations with prefix
      net: aquantia: Fix internal stats calculation on rx
      net: aquantia: Introduce new device ids and constants
      net: aquantia: Introduce new AQC devices and capabilities
      net: aquantia: Convert hw and caps structures to const static pointers
      net: aquantia: Cleanup pci functions module
      net: aquantia: Remove create/destroy from hw ops
      net: aquantia: Change confusing no_ff_addr to more meaningful name
      net: aquantia: Introduce firmware ops callbacks
      net: aquantia: Introduce support for new firmware on AQC cards
      net: aquantia: Introduce global AQC hardware reset sequence
      net: aquantia: Report correct mediatype via ethtool
      net: aquantia: bump driver version to match aquantia internal numbering

Ioan Moldovan (1):
      Bluetooth: Add a new 04ca:3015 QCA_ROME device

Ivan Khoronzhuk (1):
      net: ethernet: ti: cpdma: correct error handling for chan create

Jacob Keller (12):
      i40evf: don't rely on netif_running() outside rtnl_lock()
      i40evf: use spinlock to protect (mac|vlan)_filter_list
      i40evf: release bit locks in reverse order
      i40evf: hold the critical task bit lock while opening
      i40e: update VFs of link state after GET_VF_RESOURCES
      i40e: add helper conversion function for link_speed
      fm10k: cleanup unnecessary parenthesis in fm10k_iov.c
      fm10k: stop adding VLAN 0 to the VLAN table
      fm10k: don't assume VLAN 1 is enabled
      i40e: program fragmented IPv4 filter input set
      i40e: disallow programming multiple filters with same criteria
      i40e: fix reported mask for ntuple filters

Jaganath Kanakkassery (1):
      Bluetooth: Remove redundant disable_advertising()

Jakub Kicinski (113):
      nfp: fix old kdoc issues
      nfp: bpf: encode indirect commands
      net: xdp: avoid output parameters when querying XDP prog
      net: xdp: report flags program was installed with on query
      net: xdp: make the stack take care of the tear down
      netdevsim: add software driver for testing offloads
      netdevsim: add bpf offload support
      selftests/bpf: add offload test based on netdevsim
      netdevsim: add SR-IOV functionality
      net: dummy: remove fake SR-IOV functionality
      nfp: add nfp_cpp_area_size() accessor
      nfp: bpf: prepare for parsing BPF FW capabilities
      nfp: bpf: prepare for call support
      nfp: bpf: add basic support for adjust head call
      nfp: bpf: optimize the adjust_head calls in trivial cases
      nfp: bpf: correct printk formats for size_t
      libbpf: fix Makefile exit code if libelf not found
      nfp: set flags in the correct member of netdev_bpf
      selftests/bpf: add netdevsim to config
      netdevsim: declare struct device_type as static
      netdevsim: bpf: remove unused variable
      nfp: bpf: allocate vNIC priv for keeping track of the offloaded program
      bpf: offload: don't require rtnl for dev list manipulation
      bpf: offload: don't use prog->aux->offload as boolean
      bpf: offload: allow netdev to disappear while verifier is running
      bpf: offload: free prog->aux->offload when device disappears
      bpf: offload: free program id when device disappears
      nsfs: generalize ns_get_path() for path resolution with a task
      bpf: offload: report device information for offloaded programs
      tools: bpftool: report device information for offloaded programs
      selftests/bpf: test device info reporting for bound progs
      tools: bpftool: rename cgroup list -> show in the code
      tools: bpftool: alias show and list commands
      tools: bpftool: remove new lines from errors
      nfp: add basic multicast filtering
      net: use the right variant of kfree
      net: free RX queue structures
      nfp: don't try to register XDP rxq structures on control queues
      nfp: fix incumbent kdoc warnings
      nfp: bpf: round up the size of the stack
      nfp: bpf: don't allow changing MTU above BPF offload limit when active
      nfp: bpf: allow disabling TC offloads when XDP active
      nfp: bpf: move jump resolution to jit.c
      nfp: bpf: add helpers for modifying branch addresses
      nfp: bpf: relocate jump targets just before the load
      nfp: bpf: don't depend on high order allocations for program image
      nfp: bpf: use a large constant in unresolved branches
      nfp: hand over to BPF offload app at coarser granularity
      bpf: add map_alloc_check callback
      bpf: hashtab: move attribute validation before allocation
      bpf: hashtab: move checks out of alloc function
      bpf: add helper for copying attrs to struct bpf_map
      bpf: rename bpf_dev_offload -> bpf_prog_offload
      bpf: offload: factor out netdev checking at allocation time
      bpf: offload: add map offload infrastructure
      nfp: bpf: add map data structure
      nfp: bpf: add basic control channel communication
      nfp: bpf: implement helpers for FW map ops
      nfp: bpf: parse function call and map capabilities
      nfp: bpf: add helpers for updating immediate instructions
      nfp: bpf: add verification and codegen for map lookups
      nfp: bpf: add support for reading map memory
      nfp: bpf: implement bpf map offload
      net: remove prototype of qdisc_lookup_class()
      bpf: offload: make bpf_offload_dev_match() reject host+host case
      bpf: annotate bpf_insn_print_t with __printf
      nfp: bpf: print map lookup problems into verifier log
      net: sched: red: don't reset the backlog on every stat dump
      bpf: arraymap: move checks out of alloc function
      bpf: arraymap: use bpf_map_init_from_attr()
      bpf: offload: allow array map offload
      bpf: offload: report device information about offloaded maps
      tools: bpftool: report device information for offloaded maps
      netdevsim: bpf: support fake map offload
      selftest/bpf: extend the offload test with map checks
      nfp: bpf: add short busy wait for FW replies
      nfp: core: make scalar CPP helpers fail on short accesses
      nfp: release global resources only on the remove path
      nfp: register devlink after app is created
      nfp: add nfp_reprs_get_locked() helper
      nfp: protect each repr pointer individually with RCU
      nfp: improve app not found message
      nfp: add TLV capabilities to the BAR
      nfp: read ME frequency from vNIC ctrl memory
      nfp: read mailbox address from TLV caps
      nfp: split reading capabilities out of nfp_net_init()
      nfp: allow apps to disable ctrl vNIC capabilities
      nfp: bpf: disable all ctrl vNIC capabilities
      netdevsim: don't compile BPF code if syscall not enabled
      selftests/bpf: validate replace of TC filters is working
      net: sched: propagate extack to cls->destroy callbacks
      net: sched: prepare for reimplementation of tc_cls_common_offload_init()
      cls_bpf: remove gen_flags from bpf_offload
      cls_bpf: pass offload flags to tc_cls_common_offload_init()
      cls_bpf: propagate extack to offload delete callback
      cls_matchall: pass offload flags to tc_cls_common_offload_init()
      cls_matchall: propagate extack to delete callback
      cls_flower: pass offload flags to tc_cls_common_offload_init()
      cls_flower: propagate extack to delete callback
      cls_u32: pass offload flags to tc_cls_common_offload_init()
      cls_u32: propagate extack to delete callback
      net: sched: remove tc_cls_common_offload_init_deprecated()
      pkt_cls: add new tc cls helper to check offload flag and chain index
      netdevsim: use tc_cls_can_offload_and_chain0()
      nfp: use tc_cls_can_offload_and_chain0()
      cxgb4: use tc_cls_can_offload_and_chain0()
      mlx5: use tc_cls_can_offload_and_chain0()
      bnxt: use tc_cls_can_offload_and_chain0()
      ixgbe: use tc_cls_can_offload_and_chain0()
      i40e: use tc_cls_can_offload_and_chain0()
      mlxsw: use tc_cls_can_offload_and_chain0()
      selftests/bpf: check for spurious extacks from the driver
      selftests/bpf: check for chain-non-0 extack message

James Chapman (4):
      l2tp: revert "l2tp: add peer_offset parameter"
      l2tp: revert "l2tp: fix missing print session offset info"
      l2tp: remove configurable payload offset
      l2tp: add comment in API header that L2TP_ATTR_OFFSET is not used

James Hogan (1):
      ipmr: Fix ptrdiff_t print formatting

Jann Horn (1):
      bpf: selftest for late caller stack size increase

Jason Baron (1):
      virtio_net: propagate linkspeed/duplex settings from the hypervisor

Jason Wang (9):
      tun: add eBPF based queue selection method
      tuntap: fix possible deadlock when fail to register netdev
      tun/tap: use ptr_ring instead of skb_array
      tuntap: XDP transmission
      vhost_net: batch used ring update in rx
      tuntap: rename struct tun_steering_prog to struct tun_prog
      tun: allow to attach ebpf socket filter
      tun: add missing rcu annotation
      vhost_net: stop device during reset owner

Jassi Brar (3):
      dt-bindings: net: Add DT bindings for Socionext Netsec
      net: socionext: Add Synquacer NetSec driver
      MAINTAINERS: Add entry for Socionext ethernet driver

Jeff Kirsher (1):
      i40e: cleanup unnecessary parens

Jerome Brunet (7):
      net: phy: meson-gxl: check phy_write return value
      net: phy: meson-gxl: define control registers
      net: phy: meson-gxl: add read and write helpers for banked registers
      net: phy: meson-gxl: use genphy_config_init
      net: phy: meson-gxl: leave CONFIG_A6 untouched
      net: phy: meson-gxl: add interrupt support
      net: phy: meson-gxl: join the authors

Jesper Dangaard Brouer (24):
      xdp: base API for new XDP rx-queue info concept
      xdp/mlx5: setup xdp_rxq_info
      i40e: setup xdp_rxq_info
      ixgbe: setup xdp_rxq_info
      xdp/qede: setup xdp_rxq_info and intro xdp_rxq_info_is_reg
      mlx4: setup xdp_rxq_info
      bnxt_en: setup xdp_rxq_info
      nfp: setup xdp_rxq_info
      thunderx: setup xdp_rxq_info
      tun: setup xdp_rxq_info
      virtio_net: setup xdp_rxq_info
      xdp: generic XDP handling of xdp_rxq_info
      bpf: finally expose xdp_rxq_info to XDP bpf-programs
      samples/bpf: program demonstrating access to xdp_rxq_info
      net: fix xdp_rxq_info build issue when CONFIG_SYSFS is not set
      samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB
      bpf: simplify xdp_convert_ctx_access for xdp_rxq_info
      libbpf: install the header file libbpf.h
      libbpf: cleanup Makefile, remove unused elements
      libbpf: Makefile set specified permission mode
      samples/bpf: xdp2skb_meta comment explain why pkt-data pointers are invalidated
      bpf: add comments to BPF ld/ldx sizes
      bpf: Sync kernel ABI header with tooling header
      samples/bpf: xdp_monitor include cpumap tracepoints in monitoring

Jesus Sanchez-Palencia (1):
      igb: Clarify idleslope config constraints

Jia-Ju Bai (3):
      Bluetooth: Fix a possible sleep-in-atomic bug in bluecard_write_wakeup
      sky2: Replace mdelay with msleep in sky2_vpd_wait
      b43: Replace mdelay with usleep_range in b43_radio_2057_init_post

Jian Shen (19):
      net: hns: add ACPI mode support for ethtool -p
      net: hns3: Add ethtool interface for vlan filter
      net: hns3: Disable VFs change rxvlan offload status
      net: hns3: Unify the strings display of packet statistics
      net: hns3: Fix spelling errors
      net: hns3: Remove repeat statistic of rx_errors
      net: hns3: Modify the update period of packet statistics
      net: hns3: Mask the packet statistics query when NIC is down
      net: hns3: Fix an error of total drop packet statistics
      net: hns3: Fix a loop index error of tqp statistics query
      net: hns3: Fix an error macro definition of HNS3_TQP_STAT
      net: hns3: Remove a useless member of struct hns3_stats
      net: hns3: Add packet statistics of netdev
      net: hns3: Fix a response data read error of tqp statistics query
      net: hns3: Add more packet size statisctics
      net: hns3: add feature check when feature changed
      net: hns3: check for NULL function pointer in hns3_nic_set_features
      net: hns3: add ethtool -p support for fiber port
      net: hns3: add net status led support for fiber port

Jian-Hong Pan (1):
      doc: linux-wpan: Fulfill the description of missed 802.15.4 APIs

Jie Deng (1):
      net: dwc-xlgmac: Get rid of custom hex_dump_to_buffer()

Jingjing Wu (2):
      i40e: change ppp name to ddp
      i40e: track id can be 0

Jiong Wang (15):
      nfp: bpf: support backward jump
      nfp: bpf: record jump destination to simplify jump fixup
      nfp: bpf: flag jump destination to guide insn combine optimizations
      nfp: bpf: don't do ld/mask combination if mask is jump destination
      nfp: bpf: don't do ld/shifts combination if shifts are jump destination
      nfp: bpf: relax source operands check
      nfp: bpf: correct the encoding for No-Dest immed
      nfp: bpf: factor out is_mbpf_load & is_mbpf_store
      nfp: bpf: implement memory bulk copy for length within 32-bytes
      nfp: bpf: implement memory bulk copy for length bigger than 32-bytes
      nfp: bpf: detect load/store sequences lowered from memory copy
      tools: bpftool: add -DPACKAGE when including bfd.h
      bpf: add new jited info fields in bpf_dev_offload and bpf_prog_info
      nfp: bpf: set new jit info fields
      tools: bpftool: improve architecture detection by using ifindex

Jiri Pirko (20):
      mlxsw: spectrum: handle NETIF_F_HW_TC changes correctly
      net: sched: fix use-after-free in tcf_block_put_ext
      net: sched: don't set extack message in case the qdisc will be created
      net: sched: introduce support for multiple filter chain pointers registration
      net: sched: introduce shared filter blocks infrastructure
      net: sched: avoid usage of tp->q in tcf_classify
      net: sched: introduce block mechanism to handle netif_keep_dst calls
      net: sched: remove classid and q fields from tcf_proto
      net: sched: keep track of offloaded filters and check tc offload feature
      net: sched: use block index as a handle instead of qdisc when block is shared
      net: sched: introduce ingress/egress block index attributes for qdisc
      net: sched: allow ingress and clsact qdiscs to share filter blocks
      mlxsw: spectrum_acl: Reshuffle code around mlxsw_sp_acl_ruleset_create/destroy
      mlxsw: spectrum_acl: Don't store netdev and ingress for ruleset unbind
      mlxsw: spectrum_acl: Implement TC block sharing
      mlxsw: spectrum_acl: Pass mlxsw_sp_port down to ruleset bind/unbind ops
      net: sched: silence uninitialized parent variable warning in tc_dump_tfilter
      mlxsw: spectrum: Extend mlxsw_afa_ops for counter index and implement for Spectrum
      mlxsw: core: Convert fwd_entry_ref list to be generic per-block resource list
      mlxsw: core: Make counter index allocated inside the action append

Johannes Berg (9):
      iwlwifi: mvm: remove TCP wakeup support
      iwlwifi: mvm: remove superfluous flush_work()
      iwlwifi: mvm: request statistics when reading debugfs
      mac80211: avoid looking up tid_tx/tid_rx from timers
      mac80211: make __ieee80211_start_rx_ba_session static
      nl80211: add a few extended error strings to key parsing
      mac80211: don't warn on AID field without top two MSBs set
      Revert "mac80211: Add airtime account and scheduling to TXQs"
      Revert "mac80211: Add TXQ scheduling API"

John Fastabend (24):
      net: sched: cleanup qdisc_run and __qdisc_run semantics
      net: sched: allow qdiscs to handle locking
      net: sched: remove remaining uses for qdisc_qlen in xmit path
      net: sched: provide per cpu qstat helpers
      net: sched: a dflt qdisc may be used with per cpu stats
      net: sched: explicit locking in gso_cpu fallback
      net: sched: drop qdisc_reset from dev_graft_qdisc
      net: sched: use skb list for skb_bad_tx
      net: sched: check for frozen queue before skb_bad_txq check
      net: sched: helpers to sum qlen and qlen for per cpu logic
      net: sched: add support for TCQ_F_NOLOCK subqueues to sch_mq
      net: sched: add support for TCQ_F_NOLOCK subqueues to sch_mqprio
      net: skb_array: expose peek API
      net: sched: pfifo_fast use skb_array
      net: ptr_ring: otherwise safe empty checks can overrun array bounds
      bpf: sockmap remove unused function
      bpf: only build sockmap with CONFIG_INET
      bpf: refactor sockmap sample program update for arg parsing
      bpf: add sendmsg option for testing BPF programs
      bpf: sockmap sample, use fork() for send and recv
      bpf: sockmap sample, report bytes/sec
      bpf: sockmap sample add base test without any BPF for comparison
      bpf: sockmap put client sockets in blocking mode
      bpf: sockmap set rlimit

John Hurley (7):
      nfp: flower: do not assume mac/mpls matches
      nfp: flower: remove dead code paths
      nfp: flower: remove unused defines
      nfp: flower: remove unused tun_mask variable
      nfp: flower: read extra feature support from fw
      nfp: flower: compile Geneve match fields
      nfp: flower: compile Geneve encap actions

Jon Maloy (16):
      tipc: fall back to smaller MTU if allocation of local send skb fails
      tipc: some clarifying name changes
      tipc: simplify small window members' sorting algorithm
      tipc: a couple of cleanups
      tipc: let group member stay in JOINED mode if unable to reclaim
      tipc: adjustment to group member FSM
      tipc: create group member event messages when they are needed
      tipc: simplify group LEAVE sequence
      tipc: send out join messages as soon as new member is discovered
      tipc: add option to suppress PUBLISH events for pre-existing publications
      tipc: improve groupcast scope handling
      tipc: improve poll() for group member socket
      tipc: fix a potental access after delete in tipc_sk_join()
      tipc: fix bug during lookup of multicast destination nodes
      tipc: fix race condition at topology server receive
      tipc: fix race between poll() and setsockopt()

Jonas Gorski (4):
      bcm63xx_enet: just use "enet" as the clock name
      bcm63xx_enet: use platform data for dma channel numbers
      bcm63xx_enet: remove pointless mac_id check
      bcm63xx_enet: use platform device id directly for miibus name

Josef Bacik (6):
      add infrastructure for tagging functions as error injectable
      btrfs: make open_ctree error injectable
      bpf: add a bpf_override_function helper
      samples/bpf: add a test for bpf_override_return
      btrfs: allow us to inject errors at io_ctl_init
      trace: reenable preemption if we modify the ip

Jozsef Kadlecsik (2):
      netfilter: ipset: Fix "don't update counters" mode when counters used at the matching
      netfilter: ipset: Missing nfnl_lock()/nfnl_unlock() is added to ip_set_net_exit()

Julia Cartwright (3):
      net: macb: kill useless use of list_empty()
      net: macb: reduce scope of rx_fs_lock-protected regions
      net: macb: change GFP_ATOMIC to GFP_KERNEL

Julia Lawall (3):
      net: macb: change GFP_KERNEL to GFP_ATOMIC
      net: dccp: drop unneeded newline
      openvswitch: drop unneeded newline

Julian Wiedmann (17):
      s390/qeth: use ip*_eth_mc_map helpers
      s390/qeth: drop CONFIG_QETH_IPV6
      s390/qeth: don't keep track of MAC address's cast type
      s390/qeth: consolidate qeth MAC address helpers
      s390/qeth: use ether_addr_* helpers
      s390/qeth: align L2 and L3 set_rx_mode() implementations
      s390/qeth: robustify qeth_get_ip_version()
      s390/qeth: clean up l3_get_cast_type()
      s390/qeth: recognize non-IP multicast on L3 transmit
      s390/qeth: unionize next-hop field in qeth L3 header
      s390/qeth: streamline l3_fill_header()
      s390/qeth: pass full data length to l3_fill_header()
      s390/qeth: replace open-coded in*_pton()
      s390/qeth: improve error reporting on IP add/removal
      s390/qeth: use common helper to display rxip/vipa
      s390/diag: add diag26c support for VNIC info
      s390/qeth: support early setup for z/VM NICs

Junxiao Bi (1):
      qlcnic: fix deadlock bug

Jérémy Lefaure (1):
      wireless: use ARRAY_SIZE

Jörg Krause (1):
      Bluetooth: btbcm: Add entry for BCM4343A0 UART bluetooth

Kai-Heng Feng (1):
      Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"

Kalle Valo (14):
      Merge tag 'iwlwifi-next-for-kalle-2017-11-29' of git://git.kernel.org/.../iwlwifi/iwlwifi-next
      Merge tag 'iwlwifi-next-for-kalle-2017-12-05' of git://git.kernel.org/.../iwlwifi/iwlwifi-next
      Merge ath-next from git://git.kernel.org/.../kvalo/ath.git
      ath10k: remove deprecated fw_crash_dump debugfs file
      ath10k: refactor firmware crashdump code to coredump.c
      ath10k: detach coredump.c from debug.c
      ath10k: add coredump_mask module parameter
      ath10k: add memory dump support QCA988X
      ath10k: update copyright year
      Merge ath-next from git://git.kernel.org/.../kvalo/ath.git
      Merge tag 'iwlwifi-next-for-kalle-2017-12-20' of git://git.kernel.org/.../iwlwifi/iwlwifi-next
      ath10k: fix recently introduced checkpatch warnings
      Merge ath-next from git://git.kernel.org/.../kvalo/ath.git
      Merge ath-next from git://git.kernel.org/.../kvalo/ath.git

Kamal Heib (2):
      net/mlx5e: Merge per priority stats groups
      net/mlx5e: Extend the stats group API to have update_stats()

Kenneth Lu (2):
      ath6kl: remove redundant variable ies_len
      ath6kl: improve endianness handling

Kirill Tkhai (4):
      net: Convert atomic_t net::count to refcount_t
      net: Fix possible race in peernet2id_alloc()
      net: Remove spinlock from get_net_ns_by_id()
      net: Move net:netns_ids destruction out of rtnl_lock() and document locking scheme

Kristian Evensen (2):
      inet_diag: Add equal-operator for ports
      qmi_wwan: Add support for Quectel EP06

Kunihiko Hayashi (2):
      dt-bindings: net: add DT bindings for Socionext UniPhier AVE
      net: ethernet: socionext: add AVE ethernet driver

Larry Finger (3):
      rtlwifi: Convert individual interrupt results to struct
      MAINTAINERS: Change maintainer for rtlwifi
      rtlwifi: btcoex: Remove typedef statements

Laurence Evans (3):
      sfc: simplify RX datapath timestamping
      sfc: support separate PTP and general timestamping
      sfc: support Medford2 frequency adjustment format

Lawrence Brakmo (14):
      bpf: Add access to snd_cwnd and others in sock_ops
      bpf: Only reply field should be writeable
      bpf: Make SOCK_OPS_GET_TCP size independent
      bpf: Make SOCK_OPS_GET_TCP struct independent
      bpf: Add write access to tcp_sock and sock fields
      bpf: Support passing args to sock_ops bpf function
      bpf: Adds field bpf_sock_ops_cb_flags to tcp_sock
      bpf: Add sock_ops RTO callback
      bpf: Add support for reading sk_state and more
      bpf: Add sock_ops R/W access to tclass
      bpf: Add BPF_SOCK_OPS_RETRANS_CB
      bpf: Add BPF_SOCK_OPS_STATE_CB
      bpf: add selftest for tcpbpf
      bpf: clean up from test_tcpbpf_kern.c

Lazar Alexei (6):
      wil6210: run-time PM when interface down
      wil6210: get suspend reject reason and resume triggers from FW
      wil6210: fix PCIe bus mastering in case of interface down
      wil6210: remove suspend time statistics
      wil6210: update statistics for suspend
      wil6210: support 40bit DMA addresses

Leon Romanovsky (2):
      rtnetlink: Replace implementation of ASSERT_RTNL() macro with WARN_ONCE()
      net/rocker: Remove unreachable return instruction

Li RongQing (1):
      tcp: release sk_frag.page in tcp_disconnect

Liad Kaufman (3):
      iwlwifi: mvm: support MGMT frames in compressed BA
      iwlwifi: dbg: allow wrt collection before ALIVE
      iwlwifi: mvm: make init_dbg effective only on failure

Limin Zhu (1):
      mwifiex: cfg80211: do not change virtual interface during scan processing

Linus Walleij (4):
      Documentation: net: dsa: Cut set_addr() documentation
      net: ethernet: Add DT bindings for the Gemini ethernet
      net: ethernet: Add a driver for Gemini gigabit ethernet
      net: gemini: Depend on HAS_IOMEM

Lior David (8):
      wil6210: refresh FW capabilities during interface up
      wil6210: fix length check in __wmi_send
      wil6210: add block size checks during FW load
      wil6210: missing length check in wmi_set_ie
      wil6210: missing length check in wil_cfg80211_mgmt_tx
      wil6210: remove reference to preset_chandef
      wil6210: fix random failure to bring network interface up
      wil6210: enlarge FW mac_rgf_ext section for Sparrow D0

Loic Poulain (3):
      Bluetooth: hci_qca: Avoid setup failure on missing rampatch
      Bluetooth: btqcomsmd: Fix skb double free corruption
      wcn36xx: Add hardware scan offload support

Lorenzo Bianconi (16):
      l2tp: add peer_offset parameter
      mt76x2: init: disable APCLI by default
      mt76x2: init: fix rx filter default value during init
      mt76x2: eeprom: fix typo in mt76x2_get_power_info_5g()
      mt76: fix possible NULL pointer dereferencing in mt76x2_ampdu_action()
      mt76: fix possible NULL pointer dereferencing in mt76x2_mac_write_txwi()
      l2tp: double-check l2specific_type provided by userspace
      l2tp: remove l2specific_len dependency in l2tp_core
      l2tp: remove l2specific_len configurable parameter
      l2tp: mark L2TP_ATTR_L2SPEC_LEN as not used
      l2tp: remove switch block in l2tp_nl_cmd_session_create()
      mt76x2: fix WMM parameter configuration
      mt76x2: dfs: avoid tasklet scheduling during mt76x2_dfs_init_params()
      mt76x2: dfs: add set_domain handler
      mt76x2: dfs: take into account dfs region in mt76x2_dfs_init_params()
      mt76x2: init: disable all pending tasklets during device removal

Lorenzo Colitti (1):
      net: xfrm: allow clearing socket xfrm policies.

Luca Coelho (4):
      iwlwifi: rename the temporary name of A000 to the official 22000
      iwlwifi: bump FW API to 36 for 8000 and up
      iwlwifi: mvm: fix wrong #ifdef that uses a macro from backports
      mac80211: remove BUG() when interface type is invalid

Lucas Stach (1):
      net: fec: add necessary defines to work on ARM64

Luis de Bethencourt (5):
      samples/bpf: Fix trailing semicolon
      vxlan: Fix trailing semicolon
      net/mlx5e: Fix trailing semicolon
      netfilter: nf_tables: Fix trailing semicolon
      rtl8xxxu: Fix trailing semicolon

Lukas Wunner (18):
      net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching
      Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops
      net: ks8851: Support DT-provided MAC address
      Bluetooth: Avoid WARN splat due to missing GPIOLIB
      Bluetooth: hci_bcm: Streamline runtime PM code
      Bluetooth: Depend on rather than select GPIOLIB
      Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO
      Bluetooth: hci_bcm: Clean up unnecessary #ifdef
      Bluetooth: hci_bcm: Fix race on close
      Bluetooth: hci_bcm: Fix unbalanced pm_runtime_disable()
      Bluetooth: hci_bcm: Invalidate IRQ on request failure
      Bluetooth: hci_bcm: Document struct bcm_device
      Bluetooth: hci_bcm: Add callbacks to toggle GPIOs
      Bluetooth: hci_bcm: Handle errors properly
      Bluetooth: hci_bcm: Support Apple GPIO handling
      Bluetooth: hci_bcm: Silence IRQ printk
      Bluetooth: hci_bcm: Sleep instead of spinning
      Bluetooth: btbcm: Fix sleep mode struct ordering

Lyude Paul (1):
      igb: Free IRQs when device is hotplugged

Mahesh Bandewar (3):
      ipvlan: add L2 check for packets arriving via virtual devices
      Revert "ipvlan: add L2 check for packets arriving via virtual devices"
      ipvlan: remove excessive packet scrubbing

Manikanta Pubbisetty (2):
      ath10k: update tdls teardown state to target
      ath10k: handle tdls peer events

Marc Kleine-Budde (10):
      slip: sl_alloc(): remove unused parameter "dev_t line"
      can: rx-offload: can_rx_offload_add_timestamp: remove duplicate semicolon at return statement
      can: gs_usb: gs_cmd_reset(): remove unused parameter "struct gs_usb *gsusb"
      can: mcp251x: mcp251x_setup(): remove unused parameter "struct mcp251x_priv *priv"
      can: peak_usb: peak_usb_netif_rx(): remove unused parameter "u32 ts_high"
      can: slcan: slc_alloc(): remove unused parameter "dev_t line"
      can: raw: raw_bind(): bail out if can_family is not AF_CAN
      can: af_can: give struct holding the CAN per device receive lists a sensible name
      can: m_can: get rid of function free_m_can_dev()
      Documentation/devicetree: mpc5200.txt: fix pointer to location of fsl,mpc5200-mscan node

Marcelo Ricardo Leitner (1):
      sctp: removed unused var from sctp_make_auth

Marcin Wojtas (7):
      device property: Introduce fwnode_get_mac_address()
      device property: Introduce fwnode_get_phy_mode()
      device property: Introduce fwnode_irq_get()
      device property: Allow iterating over available child fwnodes
      net: mvpp2: simplify maintaining enabled ports' list
      net: mvpp2: use device_*/fwnode_* APIs instead of of_*
      net: mvpp2: enable ACPI support in the driver

Mark Bloch (8):
      net/mlx5: E-Switch, Refactor vport representors initialization
      net/mlx5: E-Switch, Refactor load/unload of representors
      net/mlx5: E-Switch, Simplify representor load/unload callback API
      net/mlx5: E-Switch, Move mlx5e only logic outside E-Switch
      net/mlx5: E-Switch, Create a dedicated send to vport rule deletion function
      net/mlx5e: Move ethernet representors data into separate struct
      net/mlx5: E-Switch, Create generic header struct to be used by representors
      net/mlx5e: E-Switch, Move send-to-vport rule struct to en_rep

Markus Elfring (5):
      can: vxcan: Use common error handling code in vxcan_newlink()
      Bluetooth: Use common error handling code in bt_init()
      rt2x00: Delete an error message for a failed memory allocation in rt2x00queue_allocate()
      i40e: Delete an error message for a failed memory allocation in i40e_init_interrupt_scheme()
      igb: Delete an error message for a failed memory allocation in igb_enable_sriov()

Martin Blumenstingl (9):
      net: phy: realtek: use the BIT and GENMASK macros
      net: phy: realtek: rename RTL821x_INER_INIT to RTL8211B_INER_INIT
      net: phy: realtek: group all register bit #defines for RTL821x_INER
      net: phy: realtek: use the same indentation for all #defines
      net: phy: realtek: add utility functions to read/write page addresses
      net: stmmac: dwmac-meson8b: only configure the clocks in RGMII mode
      net: stmmac: dwmac-meson8b: fix internal RGMII clock configuration
      net: stmmac: dwmac-meson8b: fix setting the RGMII TX clock on Meson8b
      net: stmmac: dwmac-meson8b: propagate rate changes to the parent clock

Martin Habets (6):
      sfc: handle TX timestamps in the normal data path
      sfc: add function to determine which TX timestamping method to use
      sfc: use main datapath for HW timestamps if available
      sfc: only enable TX timestamping if the adapter is licensed for it
      sfc: MAC TX timestamp handling on the 8000 series
      sfc: only advertise TX timestamping if we have the license for it

Martin KaFai Lau (5):
      inet: Add a count to struct inet_listen_hashbucket
      udp: Move udp[46]_portaddr_hash() to net/ip[v6].h
      inet: Add a 2nd listener hashtable (port+addr)
      tcp: Enable 2nd listener hashtable in TCP
      ipv6: Fix SO_REUSEPORT UDP socket with implicit sk_ipv6only

Masami Hiramatsu (11):
      net: tcp: Add trace events for TCP congestion window tracing
      net: tcp: Remove TCP probe module
      net: sctp: Add SCTP ACK tracking trace event
      net: sctp: Remove debug SCTP probe module
      net: dccp: Add DCCP sendmsg trace event
      net: dccp: Remove dccpprobe module
      tracing/kprobe: bpf: Check error injectable event is on function entry
      tracing/kprobe: bpf: Compare instruction pointer with original one
      error-injection: Separate error-injection from kprobe
      error-injection: Add injectable error types
      error-injection: Support fault injection framework

Masanari Iida (1):
      rt2x00: Fix a typo in printk

Mat Martineau (1):
      tcp: md5: Handle RCU dereference of md5sig_info

Matt Turner (2):
      e1000e: Set HTHRESH when PTHRESH is used
      e1000e: Alert the user that C-states will be disabled by enabling jumbo frames

Matthias Schiffer (2):
      ath9k: move spectral scan support under a separate config symbol
      ath10k: move spectral scan support under a separate config symbol

Maya Erez (9):
      wil6210: add platform capabilities bitmap
      wil6210: set platform features based on FW capabilities
      wil6210: prevent parallel suspend and dump collection
      MAINTAINERS: wireless: update wil6210 maintainer entry
      wil6210: add Talyn PCIe device ID
      wil6210: recognize Talyn JTAG ID
      wil6210: add support for Talyn AHB address map
      wil6210: configure OTP HW vectors in SW reset flow
      wil6210: support parsing brd file address from fw file

Michael Chan (18):
      bnxt_en: Don't print "Link speed -1 no longer supported" messages.
      net: Introduce NETIF_F_GRO_HW.
      net: Disable GRO_HW when generic XDP is installed on a device.
      bnxt_en: Use NETIF_F_GRO_HW.
      bnx2x: Use NETIF_F_GRO_HW.
      qede: Use NETIF_F_GRO_HW.
      net: Clarify dev_weight documentation for LRO and GRO_HW.
      bnxt_en: Update firmware interface to 1.9.0.
      bnxt_en: Refactor bnxt_close_nic().
      bnxt_en: Restore MSIX after disabling SRIOV.
      bnxt_en: Refactor hardware resource data structures.
      bnxt_en: Add the new firmware API to query hardware resources.
      bnxt_en: Set initial default RX and TX ring numbers the same in combined mode.
      bnxt_en: Implement new method to reserve rings.
      bnxt_en: Reserve resources for RFS.
      bnxt_en: Implement new method for the PF to assign SRIOV resources.
      bnxt_en: Expand bnxt_check_rings() to check all resources.
      bnxt_en: Add cache line size setting to optimize performance.

Michael Hennerich (5):
      net: ieee802154: adf7242: Add support for ADF7241 devices
      net: ieee802154: adf7242: Fix bug if defined DEBUG
      net: ieee802154: adf7242: Add additional DEBUG information
      net: ieee802154: adf7242: Avoid redundant RC_READY polling
      net: ieee802154: adf7242: Rework IRQ and packet handling

Michael S. Tsirkin (12):
      ptr_ring: keep consumer_head valid at all times
      ptr_ring: clean up documentation
      ptr_ring: READ/WRITE_ONCE for __ptr_ring_empty
      tap: fix use-after-free
      ptr_ring: disallow lockless __ptr_ring_full
      Revert "net: ptr_ring: otherwise safe empty checks can overrun array bounds"
      skb_array: use __ptr_ring_empty
      ptr_ring: prevent queue load/store tearing
      tools/virtio: switch to __ptr_ring_empty
      tools/virtio: more stubs to fix tools build
      tools/virtio: copy READ/WRITE_ONCE
      tools/virtio: fix smp_mb on x86

Michal Kosiarz (1):
      i40e: Add returning AQ critical error to SW

Michal Kuchta (1):
      i40e: Fix for blinking activity instead of link LEDs

Mickaël Salaün (2):
      bpf: Use the IS_FD_ARRAY() macro in map_update_elem()
      samples/bpf: Partially fixes the bpf.o build

Miroslav Lichvar (1):
      ixgbe: Don't report unsupported timestamping filters for X550

Mitch Williams (3):
      i40e: avoid divide by zero
      i40e: check for invalid DCB config
      i40e: simplify pointer dereferences

Moni Shoua (1):
      net/mlx4_en: Change default QoS settings

Mordechay Goodstein (2):
      iwlwifi: runtime: sync FW and host clocks for logs
      iwlwifi: add skb address to tx cmd in trace events data

Naresh Kamboju (1):
      selftests: bpf: Adding config fragment CONFIG_CGROUP_BPF=y

Nathan Fontenot (1):
      ibmvnic: Don't handle RX interrupts when not up.

Neal Cardwell (1):
      tcp: allow TLP in ECN CWR

Netanel Belgazal (2):
      net: ena: add detection and recovery mechanism for handling missed/misrouted MSI-X
      net: ena: increase ena driver version to 1.5.0

Ngai-Mint Kwan (3):
      fm10k: fix "failed to kill vid" message for VF
      fm10k: correct typo in fm10k_pf.c
      fm10k: clarify action when updating the VLAN table

Nic Viljoen (1):
      nfp: bpf: add signed jump insns

Nicolas Dichtel (2):
      dev: always advertise the new nsid when the netns iface changes
      dev: advertise the new ifindex when the netns iface changes

Nicolas Iooss (1):
      rtlwifi: always initialize variables given to RT_TRACE()

Niklas Cassel (2):
      net: stmmac: fix broken dma_interrupt handling for multi-queues
      net: stmmac: do not use a bitwise AND operator with a bool operand

Nikolay Aleksandrov (2):
      net: bridge: use rhashtable for fdbs
      ip6mr: fix stale iterator

Nogah Frankel (16):
      net_sch: red: Fix the new offload indication
      net: sched: Move offload check till after dump call
      mlxsw: spectrum: qdiscs: Move qdisc's declarations to its designated file
      net: sch: red: Change the name of the stats struct to be generic
      net: sch: red: Change offloaded xstats to be incremental
      mlxsw: spectrum: qdiscs: Clean qdisc statistics structs
      mlxsw: spectrum: qdiscs: Make the clean stats function to be for RED only
      mlxsw: spectrum: qdiscs: Add tclass number to the mlxsw_sp_qdisc
      mlxsw: spectrum: qdiscs: Unite all handle checks
      mlxsw: spectrum: qdiscs: Add an ops struct
      mlxsw: spectrum: qdiscs: Create a generic destroy function
      mlxsw: spectrum: qdiscs: Create a generic replace function
      mlxsw: spectrum: qdiscs: Remove qdisc before setting a new one
      net: sch: prio: Add offload ability to PRIO qdisc
      mlxsw: spectrum: qdiscs: Support PRIO qdisc offload
      mlxsw: spectrum: qdiscs: Support stats for PRIO qdisc

Or Gerlitz (12):
      net/mlx5: Add hairpin definitions to the FW API
      net/mlx5: Hairpin pair core object setup
      net/mlx5e: Basic setup of hairpin object
      net/mlx5e: Support offloading TC NIC hairpin flows
      net/mlx5e: Use vhca id as the hairpin peer identifier
      net/mlx5e: Set per priority hairpin pairs
      net/mlx5e: Refactor RSS related objects and code
      net/mlx5e: Enlarge the NIC TC offload steering prio to support two levels
      net/mlx5: Vectorize the low level core hairpin object
      net/mlx5e: Add RSS support for hairpin
      net/mlx5: Enable setting hairpin queue size
      net/mlx5e: Set hairpin queue size

Pablo Neira Ayuso (36):
      netfilter: nf_tables_arp: don't set forward chain
      netfilter: nf_tables: explicit nft_set_pktinfo() call from hook path
      netfilter: nf_tables: add nft_set_is_anonymous() helper
      netfilter: core: add nf_remove_net_hook
      netfilter: core: pass hook number, family and device to nf_find_hook_list()
      netfilter: core: pass family as parameter to nf_remove_net_hook()
      netfilter: core: support for NFPROTO_INET hook registration
      netfilter: nf_tables_inet: don't use multihook infrastructure anymore
      netfilter: nf_tables: remove multihook chains and families
      netfilter: nf_tables: remove hooks from family definition
      netfilter: move checksum indirection to struct nf_ipv6_ops
      netfilter: move checksum_partial indirection to struct nf_ipv6_ops
      netfilter: remove saveroute indirection in struct nf_afinfo
      netfilter: move route indirection to struct nf_ipv6_ops
      netfilter: move reroute indirection to struct nf_ipv6_ops
      netfilter: remove route_key_size field in struct nf_afinfo
      netfilter: remove struct nf_afinfo and its helper functions
      netfilter: remove defensive check on malformed packets from raw sockets
      netfilter: nf_tables: remove nft_dereference()
      netfilter: nf_conntrack: add IPS_OFFLOAD status bit
      netfilter: nf_tables: add flow table netlink frontend
      netfilter: add generic flow table infrastructure
      netfilter: flow table support for IPv4
      netfilter: flow table support for IPv6
      netfilter: flow table support for the mixed IPv4/IPv6 family
      netfilter: nf_tables: flow offload expression
      netfilter: nf_tables: remove nhooks field from struct nft_af_info
      netfilter: nf_tables: remove flag field from struct nft_af_info
      netfilter: nf_tables: no need for struct nft_af_info to enable/disable table
      netfilter: nf_tables: remove struct nft_af_info parameter in nf_tables_chain_type_lookup()
      netfilter: nf_tables: add single table list for all families
      netfilter: nf_tables: get rid of pernet families
      netfilter: nf_tables: get rid of struct nft_af_info abstraction
      netfilter: core: return EBUSY in case NAT hook is already in use
      netfilter: nf_tables: set flowtable priority and hooknum field
      netfilter: remove messages print and boot/module load time

Pankaj Bansal (6):
      can: flexcan: Remodel FlexCAN register r/w APIs for big endian FlexCAN controllers.
      can: flexcan: adding platform specific details for LS1021A
      Documentation: can: flexcan: Add big-endian property to device tree
      powerpc: dts: P1010: Add endianness property to flexcan node
      arm: dts: Remove p1010-flexcan compatible from imx series dts
      arm: dts: Add nodes for flexcan devices present on LS1021A-Rev2 SoC

Paolo Abeni (2):
      net/reuseport: drop legacy code
      openvswitch: do not propagate headroom updates to internal port

Patryk Małek (1):
      i40e: Fix for adding multiple ethtool filters on the same location

Paul Greenwalt (3):
      ixgbe: advertise highest capable link speed
      ixgbe: extend firmware version support
      ixgbe: add support for reporting 5G link speed

Pawel Jablonski (1):
      i40e/i40evf: Enable NVMUpdate to retrieve AdminQ and add preservation flags for NVM update

Paweł Jabłoński (2):
      i40evf: Allow turning off offloads when the VF has VLAN set
      i40e: Do not allow use more TC queue pairs than MSI-X vectors exist

Peng Li (19):
      net: hns3: add support to query tqps number
      net: hns3: add support to modify tqps number
      net: hns3: change the returned tqp number by ethtool -x
      net: hns3: free the ring_data structrue when change tqps
      net: hns3: get rss_size_max from configuration but not hardcode
      net: hns3: add a mask initialization for mac_vlan table
      net: hns3: add vlan offload config command
      net: hns3: add ethtool related offload command
      net: hns3: add handling vlan tag offload in bd
      net: hns3: add support for set_pauseparam
      net: hns3: add support to update flow control settings after autoneg
      net: hns3: add support for querying advertised pause frame by ethtool ethx
      net: hns3: Increase the default depth of bucket for TM shaper
      net: hns3: change TM sched mode to TC-based mode when SRIOV enabled
      net: hns3: remove redundant semicolon
      Revert "net: hns3: Add packet statistics of netdev"
      net: hns3: report the function type the same line with hns3_nic_get_stats64
      net: hns3: add ethtool_ops.get_channels support for VF
      net: hns3: remove TSO config command from VF driver

Peter Große (1):
      mac80211: Fix setting TX power on monitor interfaces

Phil Reid (2):
      net: dsa: lan9303: make lan9303_handle_reset() a void function
      net: dsa: lan9303: check error value from devm_gpiod_get_optional()

Pieter Jansen van Vuuren (1):
      nfp: flower: prioritize stats updates

Ping-Ke Shih (26):
      rtlwifi: Reduce IO in RX interrupt to boost throughput
      rtlwifi: fix the wrong size to calculate fifo space
      rtlwifi: cleanup the code that check whether TX ring is available
      rtlwifi: rtl_pci: 8822BE puts broadcast and multicast packet to HIQ
      rtlwifi: fix parenthesis alignment
      rtlwifi: rtl8723: Add error handling to no existing firmware
      rtlwifi: Improve debugging by using debugfs
      rtlwifi: btcoex: Use seq_file to dump btcoex status
      rtlwifi: fill FW version and subversion
      rtlwifi: Use mutex to replace spin_lock to protect IPS and LPS
      rtlwifi: fix scan channel 1 fail after IPS
      rtlwifi: btcoex: Add power_on_setting routine
      rtlwifi: btcoex: Remove global variables from btcoex
      rtlwifi: btcoex: Add common function for qeurying BT information
      rtlwifi: btcoex: add rfe_type parameter to btcoex
      rtlwifi: Support A-MSDU in A-MPDU capability
      rtlwifi: btcoex: extend get_wifi_bw to support bandwidth 80M
      rtlwifi: btcoex: Add switch band notify for btc
      rtlwifi: btcoex: Add variable ant_div_cfg to support antenna diversity
      rtlwifi: btcoex: add scan_notify within ips_notify if RFON
      rtlwifi: btcoex: Add wifi_only series ops to control solo card
      rtlwifi: btcoex: add boolean variables dbg_mode
      rtlwifi: 8822be has to report vht capability to mac80211
      rtlwifi: Add ratr_table for newer IC
      rtlwifi: Add spec_ver to check whether use new rate-id or not
      rtlwifi: btcoex: Fix some static warnings from Sparse

Prashant Bhole (3):
      rds: debug: fix null check on static array
      netdevsim: correctly check return value of debugfs_create_dir
      bpf: test_maps: cleanup sockmaps when test ends

Prashant Sreedharan (1):
      tg3: Add Macronix NVRAM support

Quentin Monnet (18):
      tools: bpftool: harmonise Makefile and Documentation/Makefile
      tools: bpftool: create "uninstall", "doc-uninstall" make targets
      net: sched: fix tcf_block_get_ext() in case CONFIG_NET_CLS is not set
      bpf: export function to write into verifier log buffer
      nfp: bpf: reuse verifier log for debug messages
      libbpf: fix string comparison for guessing eBPF program type
      nfp: bpf: reject program on instructions unknown to the JIT compiler
      net: sched: cls_flower: propagate extack support for filter offload
      net: sched: cls_matchall: propagate extack support for filter offload
      net: sched: cls_u32: propagate extack support for filter offload
      net: sched: cls_bpf: plumb extack support in filter for hardware offload
      net: sched: add extack support for offload via tc_cls_common_offload
      net: sched: create tc_can_offload_extack() wrapper
      nfp: bpf: plumb extack into functions related to XDP offload
      nfp: bpf: use extack support to improve debugging
      netdevsim: add extack support for TC eBPF offload
      selftests/bpf: add checks on extack messages for eBPF hw offload tests
      selftests/bpf: check bpf verifier log buffer usage works for HW offload

Radoslaw Biernacki (1):
      net: add support for Cavium PTP coprocessor

Rafal Ozieblo (3):
      net: macb: Added support for many RX queues
      net: macb: Added some queue statistics
      net: macb: Added support for RX filtering

Rahul Lakkireddy (14):
      cxgb4: collect on-chip memory information
      cxgb4: collect MC memory dump
      cxgb4: collect HMA memory dump
      cxgb4: skip TX and RX payload regions in memory dumps
      cxgb4: collect egress and ingress SGE queue contexts
      cxgb4: collect PCIe configuration logs
      cxgb4: collect TX rate limit info in UP CIM logs
      cxgb4: update dump collection logic to use compression
      cxgb4: use zlib deflate to compress firmware dump
      cxgb4: enable ZLIB_DEFLATE when building cxgb4
      cxgb4: properly initialize variables
      cxgb4: reset FW_OK flag on firmware crash
      cxgb4: fix incorrect condition for using firmware LDST commands
      cxgb4: use backdoor access to collect dumps when firmware crashed

Rajkumar Manoharan (1):
      ath10k: unify rx processing in napi_poll

Rakesh Pillai (6):
      ath10k: wmi: modify svc bitmap parsing for wcn3990
      ath10k: wmi: add management tx by reference support over wmi
      ath10k: wmi: get wmi init parameter values from hw params
      ath10k: wmi: add hw params entry for wcn3990
      ath10k: Add hw param for 64-bit address support
      ath10k: Add fw feature flag for non-bmi firmware load

Ramon Fried (1):
      wcn36xx: release DMA memory in case of error

Reizer, Eyal (1):
      wlcore: allow elp during wowlan suspend

Richard Leitner (6):
      net: phy: harmonize phy_id{,_mask} data type
      phylib: Add device reset delay support
      phylib: add reset after clk enable support
      net: phy: smsc: LAN8710/20: add PHY_RST_AFTER_CLK_EN flag
      net: fec: add phy_reset_after_clk_enable() support
      phylib: rename reset-(post-)delay-us to reset-(de)assert-us

Robert Schwebel (1):
      can: migrate documentation to restructured text

Rohit Visavalia (2):
      be2net: networking block comments don't use an empty /* line
      qed: code indent should use tabs where possible

Roman Gushchin (8):
      libbpf: add ability to guess program type based on section name
      libbpf: prefer global symbols as bpf program name source
      bpftool: implement prog load command
      bpftool: implement cgroup bpf operations
      tools/bpftool: use version from the kernel source tree
      tools/bpftool: fix bpftool build with bintutils >= 2.9
      bpftool: recognize BPF_PROG_TYPE_CGROUP_DEVICE programs
      bpftool: recognize BPF_MAP_TYPE_CPUMAP maps

Ronald Tschalär (1):
      Bluetooth: hci_bcm: Validate IRQ before using it

Roopa Prabhu (1):
      net: link_watch: mark bonding link events urgent

Russell Hu (1):
      ath9k: add MSI support

Russell King (46):
      phy: add phy_interface_mode_is_8023z() helper
      phylink: merge SGMII and 802.3z handling
      phylink: get rid of separate Cisco SGMII and 802.3z modes
      phylink: add support for 2500baseX and 10GbaseKR
      phylink: remove phylink_init_eee()
      phylink: restart 802.3z negotiation when starting net device
      phylink: add documentation for kernel APIs
      sfp: add documentation for kernel APIs
      sfp: fix sparse warning
      sfp: convert to fwnode
      phylink: convert to fwnode
      net: phy: marvell10g: remove XGMII as an option for 88x3310
      dt-bindings: add sff,sff binding for SFP support
      sfp: add sff module support
      sfp: fix non-detection of PHY
      sfp: fix EEPROM reading in the case of non-SFF8472 SFPs
      phylink: fix locking asserts
      phylink: avoid attaching more than one PHY
      net: phy: marvell10g: update header comments
      net: phy: marvell10g: add MDI swap reporting
      net: phy: marvell10g: clean up interface mode switching
      net: phy: add helper to convert negotiation result to phy settings
      net: phy: marvell10g: add support for half duplex 100M and 10M
      sfp: use precision to print non-null terminated strings
      sfp: don't guess support from connector type
      sfp: add support for 1000Base-PX and 1000Base-BX10
      sfp: improve support for direct-attach copper cables
      phylink: remove 'mode' variable from phylink_sfp_module_insert()
      net: mvneta: ensure PM paths take the rtnl lock
      net: mvneta: prepare to convert to phylink
      net: mvneta: convert to phylink
      net: mvneta: move port configuration
      net: mvneta: add 1000BaseX support
      net: mvneta: add flow control support
      net: mvneta: add EEE support
      net: mvneta: disable MVNETA_CAUSE_PSC_SYNC_CHANGE interrupt
      net: mvneta: add module EEPROM reading support
      net: phy: fixed-phy: remove fixed_phy_update_state()
      net: mdiobus: add unlocked accessors
      net: phy: use unlocked accessors for indirect MMD accesses
      net: phy: add unlocked accessors
      net: phy: add paged phy register accessors
      net: phy: marvell: fix paged access races
      net: phy: add phy_modify() accessor
      net: phy: convert read-modify-write to phy_modify()
      net: phy: fix wrong masks to phy_modify()

Ryan Hsu (1):
      ath10k: add sanity check to ie_len before parsing fw/board ie

Sabrina Dubroca (1):
      macsec: restore uAPI after addition of GCM-AES-256

Saeed Mahameed (1):
      net/mlx5: Fix build break

Salil Mehta (12):
      net: hns3: Refactor of the reset interrupt handling logic
      net: hns3: Add reset service task for handling reset requests
      net: hns3: Refactors the requested reset & pending reset handling code
      net: hns3: Add HNS3 VF IMP(Integrated Management Proc) cmd interface
      net: hns3: Add mailbox support to VF driver
      net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support
      net: hns3: Add HNS3 VF driver to kernel build framework
      net: hns3: Unified HNS3 {VF|PF} Ethernet Driver for hip08 SoC
      net: hns3: Add mailbox support to PF driver
      net: hns3: Change PF to add ring-vect binding & resetQ to mailbox
      net: hns3: Add mailbox interrupt handling to PF driver
      net: hns3: converting spaces into tabs to avoid checkpatch.pl warning

Samuel Mendoza-Jonas (1):
      net/ncsi: Don't take any action on HNCDSC AEN

Sara Sharon (5):
      iwlwifi: mvm: check for short GI only for OFDM
      iwlwifi: mvm: avoid dumping assert log when device is stopped
      mac80211: call synchronize_net once in the restart flow
      iwlwifi: mvm: support RX flags API change
      iwlwifi: mvm: don't warn on multiple packets when opening a queue

Sathya Perla (1):
      bnxt_en: export a common switchdev PARENT_ID for all reps of an adapter

Scott Branden (2):
      net: ethtool: add support for reset of AP inside NIC interface.
      bnxt_en: Add ETH_RESET_AP support

Sean Wang (5):
      net: dsa: mediatek: add VLAN support for MT7530
      net: dsa: mediatek: combine MediaTek tag with VLAN tag
      net: dsa: mediatek: update MAINTAINERS entry with MediaTek switch driver
      dt-bindings: net: mediatek: add condition to property mediatek, pctl
      net: mediatek: remove superfluous pin setup for MT7622 SoC

Sebastian Reichel (5):
      net: dsa: Support internal phy on 'cpu' port
      ARM: dts: imx6q-bx50v3: Add internal switch
      ARM: dts: imx6q-b850v3: Add switch port configuration
      ARM: dts: imx6q-b650v3: Add switch port configuration
      ARM: dts: imx6q-b450v3: Add switch port configuration

Sergei Shtylyov (7):
      phylib: Add device reset GPIO support
      macb: Kill PHY reset code
      ravb: kill redundant check in the probe() method
      sh_eth: kill redundant check in the probe() method
      sh_eth: remove sh_eth_plat_data::edmac_endian
      sh_eth: gather all TSU init code in one place
      sh_eth: get Ether port # only when needed

Sergey Matyukevich (7):
      cfg80211: cleanup signal strength units notation
      qtnfmac: pass complete channel data between driver and firmware
      qtnfmac: fix rssi data passed to wireless core
      qtnfmac: modify supported interface combinations
      qtnfmac: validate interface combinations on changes
      qtnfmac: fix STA disconnect procedure
      qtnfmac: remove redundant 'unlikely' checks

Shannon Nelson (15):
      xfrm: add documentation for xfrm device offload api
      xfrm: check for xdo_dev_state_free
      xfrm: check for xdo_dev_ops add and delete
      xfrm: wrap xfrmdev_ops with offload config
      xfrm: update the stats documentation
      ixgbe: clean up ipsec defines
      ixgbe: add ipsec register access routines
      ixgbe: add ipsec engine start and stop routines
      ixgbe: add ipsec data structures
      ixgbe: add ipsec offload add and remove SA
      ixgbe: restore offloaded SAs after a reset
      ixgbe: process the Rx ipsec offload
      ixgbe: process the Tx ipsec offload
      ixgbe: ipsec offload stats
      ixgbe: register ipsec offload with the xfrm subsystem

Shaul Triebitz (3):
      iwlwifi: mvm: force quota update upon NoA setting
      iwlwifi: mvm: adjust to quota offload
      iwlwifi: mvm: send the low latency command

Shiraz Saleem (1):
      i40e: Disable iWARP VSI PETCP_ENA flag on netdev down events

Shreeya Patel (1):
      rtlwifi: Remove unnecessary 'out of memory' message

Shrikrishna Khare (1):
      vmxnet3: increase default rx ring sizes

Shuah Khan (1):
      selftests: bpf: update .gitignore with missing generated files

Simon Horman (1):
      flow_dissector: dissect tunnel info outside __skb_flow_dissect()

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Soheil Hassas Yeganeh (2):
      ip: do not set RFS core on error queue reads
      net: revert "Update RFS target at poll for tcp/udp"

Sowmini Varadhan (9):
      rds: tcp: remove redundant function rds_tcp_conn_paths_destroy()
      rds: tcp: correctly sequence cleanup on netns deletion.
      rds: tcp: atomically purge entries from rds_tcp_conn_list during netns delete
      rds; Reset rs->rs_bound_addr in rds_add_bound() failure path
      rds: tcp: initialize t_tcp_detached to false
      rds: tcp: cleanup if kmem_cache_alloc fails in rds_tcp_conn_alloc()
      selftests/net: fix bugs in address and port initialization
      rds: Use atomic flag to track connections being destroyed
      rds: use RCU to synchronize work-enqueue with connection teardown

Stanislaw Gruszka (2):
      rt2x00: pause almost full queue early
      rt2x00: do not pause queue unconditionally on error path

Stefano Brivio (1):
      tcp: Split BUG_ON() in tcp_tso_should_defer() into two assertions

Steffen Klassert (5):
      xfrm: Separate ESP handling from segmentation for GRO packets.
      net: Add asynchronous callbacks for xfrm on layer 2.
      xfrm: Allow to use the layer2 IPsec GSO codepath for software crypto.
      xfrm: Allow IPsec GSO with software crypto for local sockets.
      esp: Don't require synchronous crypto fallback on offloading anymore.

Stephen Hemminger (15):
      hv_netvsc: drop unused macros
      hv_netvsc: don't need local xmit_more
      hv_netvsc: replace divide with mask when computing padding
      hv_netvsc: use reciprocal divide to speed up percent calculation
      hv_netvsc: optimize initialization of RNDIS header
      vmbus: make hv_get_ringbuffer_availbytes local
      rtnetlink: allow GSO maximums to be set on device creation
      veth: set peer GSO values
      rtnetlink: fix typo in GSO max segments
      hv_netvsc: copy_to_send buf can be void
      hv_netvsc: track memory allocation failures in ethtool stats
      hv_netvsc: simplify function args in receive status path
      hv_netvsc: pass netvsc_device to receive callback
      hv_netvsc: remove open_cnt reference count
      hv_netvsc: empty current transmit aggregation if flow blocked

Stephen Rothwell (1):
      tuntap: fix for "tuntap: XDP transmission"

Steven Rostedt (VMware) (1):
      tcp: Export to userspace the TCP state names for the trace events

Subash Abhinov Kasiviswanathan (18):
      net: qualcomm: rmnet: Remove the rmnet_map_results enum
      net: qualcomm: rmnet: Remove the some redundant macros
      net: qualcomm: rmnet: Allow only one rmnet dev per muxid per real dev
      net: qualcomm: rmnet: Process packets over ethernet
      net: qualcomm: rmnet: Allow to configure flags for new devices
      net: qualcomm: rmnet: Allow to configure flags for existing devices
      net: qualcomm: rmnet: Remove redundant check when stamping map header
      net: qualcomm: rmnet: Remove invalid condition while stamping mux id
      net: qualcomm: rmnet: Remove unused function declaration
      net: qualcomm: rmnet: Rename ingress data format to data format
      net: qualcomm: rmnet: Set pacing shift
      net: qualcomm: rmnet: Define the MAPv4 packet formats
      net: qualcomm: rmnet: Add support for RX checksum offload
      net: qualcomm: rmnet: Handle command packets with checksum trailer
      net: qualcomm: rmnet: Add support for TX checksum offload
      net: qualcomm: rmnet: Add support for GSO
      netfilter: nf_defrag: Skip defrag if NOTRACK is set
      netfilter: ipv6: nf_defrag: Pass on packets to stack per RFC2460

Sudheer Mogilappagari (2):
      i40evf: remove flush_scheduled_work call in i40evf_remove
      i40e/i40evf: Detect and recover hung queue scenario

Sudip Mukherjee (1):
      net: sch: api: fix tcf_block_get

Sunil Dutt (1):
      cfg80211: Scan results to also report the per chain signal strength

Sunil Goutham (3):
      net: thunderx: Add support for xdp redirect
      net: thunderx: Set max queue count taking XDP_TX into account
      net: thunderx: add timestamping support

Sven Eckelmann (24):
      dt: bindings: add new dt entry for ath10k calibration variant
      ath10k: search DT for qcom,ath10k-calibration-variant
      batman-adv: Add SPDX license identifier above copyright header
      batman-adv: Add SPDX license identifier to batman-adv.rst
      batman-adv: Add license header to Kconfig
      batman-adv: Change batman_adv.h license to MIT
      batman-adv: include gfp.h for GFP_* defines
      batman-adv: include build_bug.h for BUILD_BUG_ON define
      batman-adv: Include net.h for net_ratelimited_function
      batman-adv: include kobject.h for kobject_* functions
      batman-adv: Remove unused sched.h include
      batman-adv: Add missing kernel-doc to packet.h
      batman-adv: Use parentheses in function kernel-doc
      batman-adv: Use inline kernel-doc for enum/struct
      batman-adv: Fix kernel-doc references to struct members
      batman-adv: Add kernel-doc to structs in headers
      batman-adv: Add kernel-doc to enums in headers
      batman-adv: Add kernel-doc to functions in headers
      batman-adv: Add kernel-doc to externally visible functions
      batman-adv: Let packet.h include its headers directly
      batman-adv: Remove usage of BIT(x) in packet.h
      batman-adv: Remove kernel fixed width types in packet.h
      batman-adv: Convert packet.h to uapi header
      flow_dissector: Parse batman-adv unicast headers

Taehee Yoo (5):
      netfilter: nf_nat_snmp_basic: remove useless comment
      netfilter: nf_nat_snmp_basic: remove debug parameter
      netfilter: nf_nat_snmp_basic: replace ctinfo with dir.
      netfilter: nf_nat_snmp_basic: use nf_ct_helper_log
      netfilter: nf_nat_snmp_basic: use asn1 decoder library

Talat Batheesh (1):
      net/dim: Fix fixpoint divide exception in net_dim_stats_compare

Tariq Toukan (3):
      net/mlx4_en: RX csum, remove redundant branches and checks
      net/mlx4_en: RX csum, reorder branches
      net/mlx4_core: Cleanup FMR unmapping flow

Tedd Ho-Jeong An (5):
      Bluetooth: hci_intel: Update firmware filename for Intel 9x60 and later
      Bluetooth: btintel: Create common function for Intel Reset
      Bluetooth: btintel: Use boot parameter from firmware file
      Bluetooth: btintel: Create common Intel Read Boot Params function
      Bluetooth: btintel: Create common function for firmware download

Thomas Falcon (4):
      ibmvnic: Rename IBMVNIC_MAX_TX_QUEUES to IBMVNIC_MAX_QUEUES
      ibmvnic: Increase maximum number of RX/TX queues
      ibmvnic: Include header descriptor support for ARP packets
      ibmvnic: Wait for device response when changing MAC

Thomas Winter (1):
      ip_tunnel: Use mark in skb by default

Tina Ruchandani (1):
      atm: mpoa: remove 32-bit timekeeping

Tobias Brunner (1):
      ipv6: Reinject IPv6 packets if IPsec policy matches after SNAT

Tobin C. Harding (1):
      rtlwifi: use kcalloc instead of multiply

Toke Høiland-Jørgensen (3):
      ath10k: re-enable TXQs for all devices
      mac80211: Add TXQ scheduling API
      mac80211: Add airtime account and scheduling to TXQs

Tom Herbert (5):
      rhashtable: Change rhashtable_walk_start to return void
      rhashtable: Add rhastable_walk_peek
      rhashtable: abstract out function to get hash
      spinlock: Add library function to allocate spinlock buckets array
      rhashtable: Call library function alloc_bucket_locks

Tomer Tayar (4):
      qed*: Refactoring and rearranging FW API with no functional impact
      qed*: HSI renaming for different types of HW
      qed*: Utilize FW 8.33.1.0
      qed*: Advance drivers' version to 8.33.0.20

Tonghao Zhang (5):
      sock: Change the netns_core member name.
      sock: Move the socket inuse to namespace.
      sock: Hide unused variable when !CONFIG_PROC_FS.
      ixgbe: Remove an obsolete comment about ITR
      ipv4: Get the address of interface correctly.

Tony Nguyen (2):
      ixgbe: Fix kernel-doc format warnings
      ixgbevf: Fix kernel-doc format warnings

Toshiaki Makita (2):
      virtio_net: Disable interrupts if napi_complete_done rescheduled napi
      virtio_net: Add ethtool stats

Tova Mussai (1):
      cfg80211: IBSS: Add support for static WEP in driver for IBSS

Tsang-Shian Lin (2):
      rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.
      rtlwifi: unlink bss when un-association

Ulf Magnusson (1):
      net/sched: kconfig: Remove blank help texts

Ulrich Hecht (1):
      serdev: add method to set parity

Upasana Menon (1):
      i40e: Display LLDP information on vSphere Web Client

Ursula Braun (22):
      smc: make smc_close_active_abort() static
      smc: improve smc_clc_send_decline() error handling
      smc: no update for unused sk_write_pending
      smc: cleanup close checking during data receival
      smc: no consumer update in tasklet context
      smc: support variable CLC proposal messages
      net/smc: use local struct sock variables consistently
      net/smc: simplify function smc_clcsock_accept()
      net/smc: get rid of tx_pend waits in socket closing
      net/smc: make wait for work request uninterruptible
      net/smc: improve state change handling after close wait
      net/smc: continue waiting if peer signals write_shutdown
      net/smc: cancel tx worker in case of socket aborts
      net/smc: handle state SMC_PEERFINCLOSEWAIT correctly
      net/smc: terminate link group for ib_post_send problems
      net/smc: do not reuse a linkgroup with setup problems
      net/smc: wake up wr_reg_wait when terminating a link group
      net/smc: check for healthy link group resp. connections
      net/smc: handle device, port, and QP error events
      net/smc: smc_poll improvements
      net/smc: replace sock_put worker by socket refcounting
      net/smc: release clcsock from tcp_listen_worker

Vadim Lomovtsev (1):
      net: ethernet: cavium: Correct Cavium Thunderx NIC driver names accordingly to module name

Vakul Garg (1):
      tls: Add support for encryption using async offload accelerator

Varsha Rao (1):
      netfilter: nf_conntrack_h323: Remove unwanted comments.

Vasily Ulyanov (7):
      qtnfmac: fill wiphy's extended capabilities
      qtnfmac: support MAC address based access control
      qtnfmac: remove struct qlink_cmd_set_mac_acl
      qtnfmac: fix warnings when mBSS setup is stopped
      qtnfmac: support 64-bit network interface stats
      qtnfmac: get more hardware info from card
      qtnfmac: report hardware/firmware information via ethtool

Vasundhara Volam (2):
      bnxt_en: Add BCM5745X NPAR device IDs
      bnxt_en: Forward VF MAC address to the PF.

Vincent Legoll (1):
      ssb: make SSB a menuconfig to ease disabling it all

Vivien Didelot (11):
      net: dsa: remove trans argument from vlan ops
      net: dsa: remove trans argument from mdb ops
      net: dsa: add switch vlan bitmap functions
      net: dsa: add switch mdb bitmap functions
      net: dsa: introduce dsa_towards_port helper
      net: dsa: support cross-chip FDB operations
      net: dsa: mv88e6xxx: egress floods all DSA ports
      net: dsa: mv88e6xxx: helper to setup upstream port
      net: dsa: mv88e6xxx: setup global upstream port
      net: dsa: assign a CPU port to DSA port
      net: dsa: return per-port upstream port

Wang Dongsheng (1):
      net: qcom/emac: extend DMA mask to 46bits

Wang YanQing (1):
      bpf, doc: Correct one wrong value in "Register value tracking"

Wei Wang (1):
      ipv6: change route cache aging logic

Wei Yongjun (17):
      net: sched: fix skb leak in dev_requeue_skb()
      net: dsa: lan9303: Fix error return code in lan9303_check_device()
      netfilter: nf_tables: fix a typo in nf_tables_getflowtable()
      netfilter: core: make local function __nf_unregister_net_hook static
      netfilter: remove duplicated include
      net/mlx5e: fix error return code in mlx5e_alloc_rq()
      tcp: make local function tcp_recv_timestamp static
      net: socionext: Fix error return code in netsec_netdev_open()
      net: phy: mdio-bcm-unimac: fix potential NULL dereference in unimac_mdio_probe()
      mlxsw: spectrum: qdiscs: Make function mlxsw_sp_qdisc_prio_unoffload static
      bpf: cpumap: make some functions static
      mlxsw: spectrum: Make function mlxsw_sp_kvdl_part_occ() static
      devlink: Make some functions static
      nfp: fix error return code in nfp_pci_probe()
      net: aquantia: Fix error return code in aq_pci_probe()
      net: aquantia: make symbol hw_atl_boards static
      cxgb4: make symbol pedits static

Weixiao Zhang (1):
      mwl8k: Expand non-DFS 5G channels

Willem de Bruijn (6):
      tun: avoid unnecessary READ_ONCE in tun_net_xmit
      net: avoid skb_warn_bad_offload on IS_ERR
      skbuff: in skb_segment, call zerocopy functions once per nskb
      tcp: push full zerocopy packets
      tcp: place all zerocopy payload in frags
      tcp: do not allocate linear memory for zerocopy skbs

William Tu (22):
      ip_gre: Refector the erpsan tunnel code.
      ip6_gre: Refactor ip6gre xmit codes
      ip6_gre: Add ERSPAN native tunnel support
      ip6_gre: add ip6 gre and gretap collect_md mode
      bpf: allow disabling tunnel csum for ipv6
      samples/bpf: extend test_tunnel_bpf.sh with ip6gre
      bpf: move bpf csum flag check
      ip6_gre: add ip6 erspan collect_md mode
      samples/bpf: add ip6erspan sample code
      net: erspan: refactor existing erspan code
      net: erspan: introduce erspan v2 for ip_gre
      ip6_gre: add erspan v2 support
      samples/bpf: add erspan v2 sample code
      net: erspan: fix wrong return value
      net: erspan: reload pointer after pskb_may_pull
      selftests: rtnetlink: add gretap test cases
      net: erspan: remove md NULL check
      selftests: rtnetlink: add erspan and ip6erspan
      net: erspan: fix use-after-free
      net: erspan: use bitfield instead of mask and offset
      net: erspan: create erspan metadata uapi header
      openvswitch: add erspan version I and II support

Wojciech Dubowik (4):
      ath9k: Alternative EEPROM size for AR9003
      ath9k: Read noise floor calibration data from eeprom
      ath9k: Use calibrated noise floor value when available
      ath9k: Display calibration data piers in debugfs

Wright Feng (1):
      brcmfmac: enlarge buffer size of caps to 512 bytes

Xin Long (21):
      sctp: add stream interleave enable members and sockopt
      sctp: add asoc intl_enable negotiation during 4 shakehands
      sctp: add basic structures and make chunk function for idata
      sctp: implement make_datafrag for sctp_stream_interleave
      sctp: implement assign_number for sctp_stream_interleave
      sctp: implement validate_data for sctp_stream_interleave
      sctp: implement ulpevent_data for sctp_stream_interleave
      sctp: implement enqueue_event for sctp_stream_interleave
      sctp: implement renege_events for sctp_stream_interleave
      sctp: implement start_pd for sctp_stream_interleave
      sctp: implement abort_pd for sctp_stream_interleave
      sctp: add support for the process of unordered idata
      sctp: add basic structures and make chunk function for ifwdtsn
      sctp: implement generate_ftsn for sctp_stream_interleave
      sctp: implement validate_ftsn for sctp_stream_interleave
      sctp: implement report_ftsn for sctp_stream_interleave
      sctp: implement handle_ftsn for sctp_stream_interleave
      sctp: add stream interleave support in stream scheduler
      sctp: update mid instead of ssn when doing stream and asoc reset
      sctp: support sysctl to allow users to use stream interleave
      sctp: reset ret in again path in sctp_for_each_transport

Xinming Hu (5):
      mwifiex: do not support change AP interface to station mode
      mwifiex: refactor device dump code to make it generic for usb interface
      mwifiex: device dump support for usb interface
      mwifiex: debugfs: trigger device dump for usb interface
      mwifiex: cancel pcie/sdio work in remove/shutdown handler

Xiongwei Song (1):
      bpf: make function xdp_do_generic_redirect_map() static

Yafang Shao (6):
      net: tracepoint: replace tcp_set_state tracepoint with inet_sock_set_state tracepoint
      net: sock: replace sk_state_load with inet_sk_state_load and remove sk_state_store
      net: tracepoint: using sock_set_state tracepoint to trace DCCP state transition
      net: tracepoint: using sock_set_state tracepoint to trace SCTP state transition
      net/trace: fix printk format in inet_sock_set_state
      net: tracepoint: exposing sk_faimily in tracepoint inet_sock_set_state

Yan Markman (1):
      net: mvpp2: split the max ring size from the default one

Yang Shi (3):
      net: caif: remove unused hardirq.h
      net: ovs: remove unused hardirq.h
      net: tipc: remove unused hardirq.h

Yingying Tang (1):
      mac80211: enable TDLS peer buffer STA feature

Yonghong Song (14):
      bpf/tracing: allow user space to query prog array on the same tp
      bpf/tracing: add a bpf test for new ioctl query interface
      bpf/tracing: fix kernel/events/core.c compilation error
      bpf/cgroup: fix a verification error for a CGROUP_DEVICE type prog
      tools/bpf: adjust rlimit RLIMIT_MEMLOCK for test_dev_cgroup
      bpf: implement syscall command BPF_MAP_GET_NEXT_KEY for stacktrace map
      tools/bpf: add a bpf selftest for stacktrace
      bpf: change fake_ip for bpf_trace_printk helper
      bpf: implement MAP_GET_NEXT_KEY command for LPM_TRIE map
      tools/bpf: add a testcase for MAP_GET_NEXT_KEY command of LPM_TRIE map
      bpf: fix incorrect kmalloc usage in lpm_trie MAP_GET_NEXT_KEY rcu region
      tools/bpf: fix a test failure in selftests prog test_verifier
      bpf: fix kernel page fault in lpm map trie_get_next_key
      tools/bpf: add a multithreaded stress test in bpf selftests test_lpm_map

Yossef Efraim (3):
      xfrm: Fix xfrm_replay_overflow_offload_esn
      xfrm: Fix xfrm_dev_state_add to fail for unsupported HW SA option
      xfrm: Add ESN support for IPSec HW offload

Yuchung Cheng (3):
      tcp: pause Fast Open globally after third consecutive timeout
      tcp: avoid min-RTT overestimation from delayed ACKs
      tcp: avoid min RTT bloat by skipping RTT from delayed-ACK in BBR

Yuval Mintz (3):
      mlxsw: reg: add rdpm register
      mlxsw: spectrum_router: Configure default routing priority
      mlxsw: spectrum: Upper-bound supported FW version

Zhang Shengju (1):
      igb: add function to get maximum RSS queues

Zhu Yanjun (7):
      forcedeth: optimize the xmit with unlikely
      forcedeth: remove unnecessary structure member
      forcedeth: remove duplicate structure member in xmit
      forcedeth: optimize the rx with likely
      forcedeth: remove duplicate structure member in rx
      forcedeth: remove unused variable
      forcedeth: remove duplicate structure member in rx

kbuild test robot (2):
      net: hns3: hns3_get_channels() can be static
      sfc: mark some unexported symbols as static

weiyongjun (A) (1):
      mac80211_hwsim: fix possible memory leak in hwsim_new_radio_nl()

Łukasz Rymanowski (1):
      Bluetooth: Add support to advertise when connected

 Documentation/ABI/testing/devlink-resource-mlxsw                             |    33 +
 Documentation/ABI/testing/sysfs-class-net                                    |    24 +
 Documentation/bpf/bpf_devel_QA.txt                                           |   519 +++++
 Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt           |     5 +-
 Documentation/devicetree/bindings/net/can/can-transceiver.txt                |    24 +
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt                    |     6 +
 Documentation/devicetree/bindings/net/can/m_can.txt                          |     9 +
 Documentation/devicetree/bindings/net/can/rcar_can.txt                       |     7 +-
 Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt            |    92 +
 Documentation/devicetree/bindings/net/fsl-fec.txt                            |     4 +-
 Documentation/devicetree/bindings/net/ieee802154/adf7242.txt                 |     2 +-
 Documentation/devicetree/bindings/net/mediatek-net.txt                       |     2 +-
 Documentation/devicetree/bindings/net/phy.txt                                |    12 +
 Documentation/devicetree/bindings/net/sff,sfp.txt                            |    10 +-
 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt            |    48 +
 Documentation/devicetree/bindings/net/socionext-netsec.txt                   |    53 +
 Documentation/devicetree/bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt} |    18 +-
 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt             |    32 +
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt               |     3 +
 Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt                    |     2 +-
 Documentation/fault-injection/fault-injection.txt                            |    68 +
 Documentation/networking/00-INDEX                                            |     4 +-
 Documentation/networking/batman-adv.rst                                      |     2 +
 Documentation/networking/can.rst                                             |  1437 +++++++++++++
 Documentation/networking/can.txt                                             |  1308 ------------
 Documentation/networking/dsa/dsa.txt                                         |     5 -
 Documentation/networking/filter.txt                                          |     2 +-
 Documentation/networking/ieee802154.txt                                      |    40 +
 Documentation/networking/index.rst                                           |     1 +
 Documentation/networking/ip-sysctl.txt                                       |     1 +
 Documentation/networking/kapi.rst                                            |    24 +
 Documentation/networking/netdev-features.txt                                 |     9 +
 Documentation/networking/pktgen.txt                                          |    19 +-
 Documentation/networking/xfrm_device.txt                                     |   135 ++
 Documentation/networking/xfrm_proc.txt                                       |    20 +-
 Documentation/sysctl/net.txt                                                 |     4 +-
 MAINTAINERS                                                                  |    45 +-
 arch/Kconfig                                                                 |     3 +
 arch/arm/boot/dts/imx25.dtsi                                                 |     4 +-
 arch/arm/boot/dts/imx28.dtsi                                                 |     4 +-
 arch/arm/boot/dts/imx35.dtsi                                                 |     4 +-
 arch/arm/boot/dts/imx53.dtsi                                                 |     4 +-
 arch/arm/boot/dts/imx6q-b450v3.dts                                           |    52 +
 arch/arm/boot/dts/imx6q-b650v3.dts                                           |    52 +
 arch/arm/boot/dts/imx6q-b850v3.dts                                           |    75 +
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                                          |    62 +
 arch/arm/boot/dts/ls1021a-qds.dts                                            |    16 +
 arch/arm/boot/dts/ls1021a-twr.dts                                            |    16 +
 arch/arm/boot/dts/ls1021a.dtsi                                               |    36 +
 arch/arm/net/bpf_jit_32.c                                                    |    12 +-
 arch/arm64/net/bpf_jit_comp.c                                                |    86 +-
 arch/mips/bcm63xx/dev-enet.c                                                 |     8 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h                        |     4 +
 arch/mips/net/bpf_jit.c                                                      |     2 -
 arch/mips/net/ebpf_jit.c                                                     |    33 +-
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi                                  |     2 +
 arch/powerpc/net/bpf_jit_comp.c                                              |     2 -
 arch/powerpc/net/bpf_jit_comp64.c                                            |    12 +-
 arch/s390/include/asm/diag.h                                                 |    44 +-
 arch/s390/net/bpf_jit_comp.c                                                 |    14 +-
 arch/sh/boards/board-espt.c                                                  |     1 -
 arch/sh/boards/board-sh7757lcr.c                                             |     4 -
 arch/sh/boards/mach-ecovec24/setup.c                                         |     1 -
 arch/sh/boards/mach-se/7724/setup.c                                          |     1 -
 arch/sh/boards/mach-sh7763rdp/setup.c                                        |     1 -
 arch/sh/kernel/cpu/sh2/setup-sh7619.c                                        |     1 -
 arch/sparc/net/bpf_jit_comp_32.c                                             |     2 -
 arch/sparc/net/bpf_jit_comp_64.c                                             |    66 +-
 arch/x86/Kconfig                                                             |     1 +
 arch/x86/include/asm/error-injection.h                                       |    13 +
 arch/x86/include/asm/kprobes.h                                               |     2 +
 arch/x86/include/asm/ptrace.h                                                |     5 +
 arch/x86/lib/Makefile                                                        |     1 +
 arch/x86/lib/error-inject.c                                                  |    19 +
 arch/x86/net/bpf_jit_comp.c                                                  |   106 +-
 drivers/atm/eni.c                                                            |    18 +-
 drivers/base/property.c                                                      |   104 +-
 drivers/bcma/driver_pcie2.c                                                  |     3 +-
 drivers/bluetooth/Kconfig                                                    |    14 +
 drivers/bluetooth/bluecard_cs.c                                              |     8 +-
 drivers/bluetooth/bpa10x.c                                                   |     2 +-
 drivers/bluetooth/btbcm.c                                                    |     1 +
 drivers/bluetooth/btbcm.h                                                    |     2 +-
 drivers/bluetooth/btintel.c                                                  |   157 +-
 drivers/bluetooth/btintel.h                                                  |    33 +-
 drivers/bluetooth/btqcomsmd.c                                                |     3 +-
 drivers/bluetooth/btsdio.c                                                   |     9 +
 drivers/bluetooth/btusb.c                                                    |   162 +-
 drivers/bluetooth/hci_bcm.c                                                  |   243 ++-
 drivers/bluetooth/hci_intel.c                                                |   186 +-
 drivers/bluetooth/hci_ll.c                                                   |   107 +-
 drivers/bluetooth/hci_qca.c                                                  |     3 +
 drivers/bluetooth/hci_serdev.c                                               |     1 +
 drivers/hv/ring_buffer.c                                                     |    23 +
 drivers/infiniband/hw/qedr/main.c                                            |     2 +-
 drivers/infiniband/hw/qedr/qedr_hsi_rdma.h                                   |   125 +-
 drivers/net/Kconfig                                                          |    11 +
 drivers/net/Makefile                                                         |     1 +
 drivers/net/bonding/bond_options.c                                           |     6 +-
 drivers/net/caif/caif_hsi.c                                                  |     1 -
 drivers/net/can/c_can/c_can_pci.c                                            |     4 +-
 drivers/net/can/dev.c                                                        |    47 +-
 drivers/net/can/flexcan.c                                                    |   241 ++-
 drivers/net/can/m_can/m_can.c                                                |   183 +-
 drivers/net/can/rx-offload.c                                                 |     2 +-
 drivers/net/can/slcan.c                                                      |     4 +-
 drivers/net/can/spi/mcp251x.c                                                |     7 +-
 drivers/net/can/usb/gs_usb.c                                                 |     4 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c                                      |     9 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c                                 |    55 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h                                 |     7 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                                   |     9 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c                                  |     9 +-
 drivers/net/can/vcan.c                                                       |     2 +-
 drivers/net/can/vxcan.c                                                      |    16 +-
 drivers/net/dsa/Kconfig                                                      |     2 +-
 drivers/net/dsa/b53/b53_common.c                                             |    10 +-
 drivers/net/dsa/b53/b53_priv.h                                               |     7 +-
 drivers/net/dsa/bcm_sf2.c                                                    |    11 +-
 drivers/net/dsa/dsa_loop.c                                                   |     9 +-
 drivers/net/dsa/lan9303-core.c                                               |   138 +-
 drivers/net/dsa/microchip/ksz_common.c                                       |    12 +-
 drivers/net/dsa/mt7530.c                                                     |   288 ++-
 drivers/net/dsa/mt7530.h                                                     |    83 +-
 drivers/net/dsa/mv88e6xxx/chip.c                                             |    94 +-
 drivers/net/dsa/mv88e6xxx/chip.h                                             |     2 +
 drivers/net/dsa/mv88e6xxx/global1.h                                          |    16 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c                                      |    87 +
 drivers/net/dsa/mv88e6xxx/global1_vtu.c                                      |    74 +
 drivers/net/dummy.c                                                          |   215 +-
 drivers/net/ethernet/Kconfig                                                 |     2 +
 drivers/net/ethernet/Makefile                                                |     2 +
 drivers/net/ethernet/alteon/acenic.c                                         |    14 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c                                |    11 +
 drivers/net/ethernet/amazon/ena/ena_eth_com.h                                |     2 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c                                 |    68 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h                                 |     6 +-
 drivers/net/ethernet/amazon/ena/ena_regs_defs.h                              |     2 +
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                                     |    24 +-
 drivers/net/ethernet/aquantia/atlantic/Makefile                              |     1 +
 drivers/net/ethernet/aquantia/atlantic/aq_cfg.h                              |     8 +-
 drivers/net/ethernet/aquantia/atlantic/aq_common.h                           |    39 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h                               |    79 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c                         |    11 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h                         |     3 +
 drivers/net/ethernet/aquantia/atlantic/aq_main.c                             |   110 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.h                             |     2 +
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                              |   290 +--
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h                              |    62 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic_internal.h                     |    45 -
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                         |   413 ++--
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.h                         |    26 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                             |     4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h                             |     2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_utils.h                            |     6 -
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c                              |     5 +-
 drivers/net/ethernet/aquantia/atlantic/aq_vec.h                              |     4 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c                    |   472 ++---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.h                    |    18 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0_internal.h           |    65 -
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c                    |   506 +++--
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h                    |    28 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0_internal.h           |    64 -
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c                   |  1326 ++++++------
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h                   |   544 ++---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h          |  1521 ++++++-------
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c                 |   346 ++-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h                 |   133 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c            |   184 ++
 drivers/net/ethernet/aquantia/atlantic/ver.h                                 |     6 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c                                 |    27 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.h                                 |     3 -
 drivers/net/ethernet/broadcom/bcmsysport.c                                   |    12 -
 drivers/net/ethernet/broadcom/bgmac.c                                        |    15 -
 drivers/net/ethernet/broadcom/bnx2.c                                         |     4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                              |    29 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c                             |     8 +-
 drivers/net/ethernet/broadcom/bnxt/Makefile                                  |     2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                    |   814 +++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                    |    89 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c                                |     5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c                                |    32 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                            |    23 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h                            |     1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h                                | 11936 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                              |   221 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                                 |    22 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c                                |    33 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.h                                |     6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                                |     1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                               |     7 +-
 drivers/net/ethernet/broadcom/tg3.c                                          |    21 +-
 drivers/net/ethernet/broadcom/tg3.h                                          |    14 +-
 drivers/net/ethernet/cadence/macb.h                                          |   170 +-
 drivers/net/ethernet/cadence/macb_main.c                                     |   758 +++++--
 drivers/net/ethernet/cavium/Kconfig                                          |    13 +
 drivers/net/ethernet/cavium/Makefile                                         |     1 +
 drivers/net/ethernet/cavium/common/Makefile                                  |     1 +
 drivers/net/ethernet/cavium/common/cavium_ptp.c                              |   353 ++++
 drivers/net/ethernet/cavium/common/cavium_ptp.h                              |    70 +
 drivers/net/ethernet/cavium/liquidio/octeon_device.c                         |     7 +-
 drivers/net/ethernet/cavium/thunder/nic.h                                    |    36 +
 drivers/net/ethernet/cavium/thunder/nic_main.c                               |    58 +-
 drivers/net/ethernet/cavium/thunder/nic_reg.h                                |     1 +
 drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c                          |    31 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c                             |   297 ++-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c                           |    41 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h                           |     6 +
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c                            |    31 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h                            |     4 +
 drivers/net/ethernet/cavium/thunder/thunder_xcv.c                            |     2 +-
 drivers/net/ethernet/chelsio/Kconfig                                         |     1 +
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c                              |     1 +
 drivers/net/ethernet/chelsio/cxgb4/Makefile                                  |     2 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_common.c                            |    24 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h                            |   156 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h                                |    10 +
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c                               |  1173 +++++++++--
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h                               |    18 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib_common.h                        |     8 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.c                              |    82 +
 drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.h                              |    43 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h                                   |    46 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c                             |   117 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h                             |     4 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c                           |   304 +--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c                           |   107 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c                            |   140 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                              |   605 ++++--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c                         |    21 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c                            |     8 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c                                     |   221 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                                   |   269 ++-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.h                                   |    45 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h                                  |   164 ++
 drivers/net/ethernet/chelsio/cxgb4/t4_pci_id_tbl.h                           |     2 +
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h                                 |    35 +
 drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h                                |    45 +-
 drivers/net/ethernet/chelsio/cxgb4vf/adapter.h                               |     1 +
 drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c                          |    12 +-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c                                   |    38 +-
 drivers/net/ethernet/chelsio/cxgb4vf/t4vf_common.h                           |     1 +
 drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c                               |    28 +
 drivers/net/ethernet/cisco/enic/enic.h                                       |     2 +
 drivers/net/ethernet/cisco/enic/enic_ethtool.c                               |    12 +
 drivers/net/ethernet/cisco/enic/enic_main.c                                  |     5 +-
 drivers/net/ethernet/cortina/Kconfig                                         |    23 +
 drivers/net/ethernet/cortina/Makefile                                        |     4 +
 drivers/net/ethernet/cortina/gemini.c                                        |  2593 +++++++++++++++++++++++
 drivers/net/ethernet/cortina/gemini.h                                        |   958 +++++++++
 drivers/net/ethernet/emulex/benet/be_cmds.c                                  |     2 +-
 drivers/net/ethernet/emulex/benet/be_main.c                                  |     3 +-
 drivers/net/ethernet/freescale/fec.h                                         |     5 +-
 drivers/net/ethernet/freescale/fec_main.c                                    |    28 +-
 drivers/net/ethernet/freescale/gianfar.c                                     |     9 +-
 drivers/net/ethernet/hisilicon/Kconfig                                       |    28 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                            |     2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c                           |   109 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h                            |     7 +-
 drivers/net/ethernet/hisilicon/hns3/Makefile                                 |     7 +
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h                              |    88 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                                  |    14 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                                  |    32 +-
 drivers/net/ethernet/hisilicon/hns3/{hns3pf => }/hns3_dcbnl.c                |     2 +-
 drivers/net/ethernet/hisilicon/hns3/{hns3pf => }/hns3_enet.c                 |   405 +++-
 drivers/net/ethernet/hisilicon/hns3/{hns3pf => }/hns3_enet.h                 |    28 +-
 drivers/net/ethernet/hisilicon/hns3/{hns3pf => }/hns3_ethtool.c              |   347 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile                          |     8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h                       |   106 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                      |  1632 +++++++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h                      |   129 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c                       |   418 ++++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c                      |     5 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c                        |    64 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h                        |    12 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile                          |     9 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c                     |   342 +++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h                     |   248 +++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c                    |  1505 +++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h                    |   164 ++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c                     |   181 ++
 drivers/net/ethernet/ibm/emac/core.c                                         |    20 +-
 drivers/net/ethernet/ibm/emac/emac.h                                         |    13 -
 drivers/net/ethernet/ibm/emac/phy.c                                          |    10 +-
 drivers/net/ethernet/ibm/emac/rgmii.c                                        |    43 +-
 drivers/net/ethernet/ibm/emac/zmii.c                                         |    38 +-
 drivers/net/ethernet/ibm/ibmvnic.c                                           |    36 +-
 drivers/net/ethernet/ibm/ibmvnic.h                                           |     2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c                             |     4 +-
 drivers/net/ethernet/intel/e1000e/netdev.c                                   |     4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c                                 |     4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c                                |    14 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c                              |    54 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c                                  |     2 +-
 drivers/net/ethernet/intel/i40e/i40e.h                                       |    67 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c                                |    17 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h                            |    30 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c                                |    36 +-
 drivers/net/ethernet/intel/i40e/i40e_client.h                                |     2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c                                |    74 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                               |   192 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c                                  |   220 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                                   |   143 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h                             |    51 +-
 drivers/net/ethernet/intel/i40e/i40e_status.h                                |     1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                                  |    84 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h                                  |     7 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h                                  |    54 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                           |     5 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c                              |    15 +-
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h                          |    30 +-
 drivers/net/ethernet/intel/i40evf/i40e_common.c                              |    31 +-
 drivers/net/ethernet/intel/i40evf/i40e_prototype.h                           |    10 +-
 drivers/net/ethernet/intel/i40evf/i40e_status.h                              |     1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c                                |    66 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h                                |     4 +-
 drivers/net/ethernet/intel/i40evf/i40e_type.h                                |    54 +-
 drivers/net/ethernet/intel/i40evf/i40evf.h                                   |     9 +-
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c                           |    28 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c                              |   228 +-
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c                          |    83 +-
 drivers/net/ethernet/intel/igb/igb.h                                         |     1 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c                                 |    32 +-
 drivers/net/ethernet/intel/igb/igb_main.c                                    |    72 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c                                     |     9 +
 drivers/net/ethernet/intel/ixgbe/Makefile                                    |     1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                                     |    46 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c                               |     3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c                               |    11 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c                              |   121 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h                              |     6 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c                                 |    10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c                           |    22 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c                           |     5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c                              |     2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c                             |     2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                             |    56 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c                                |    10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c                               |   941 +++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h                               |    93 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c                                 |    76 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                |   589 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c                                 |    15 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c                                 |     8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                               |    63 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                                |    61 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                                |    21 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c                                 |     3 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h                                 |    16 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c                            |   372 ++--
 drivers/net/ethernet/intel/ixgbevf/vf.c                                      |    34 +-
 drivers/net/ethernet/marvell/Kconfig                                         |     2 +-
 drivers/net/ethernet/marvell/mvneta.c                                        |   687 +++---
 drivers/net/ethernet/marvell/mvpp2.c                                         |   253 ++-
 drivers/net/ethernet/marvell/sky2.c                                          |     2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                                  |    35 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                                  |     3 +
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c                               |     5 +
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c                              |    17 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c                               |    10 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c                                   |    69 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h                                 |     5 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c                                      |    40 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile                             |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h                                 |    85 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c                             |    48 +
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                         |    23 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c                              |   110 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                            |   291 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                             |   154 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.h                             |    14 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                              |    19 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c                           |   347 ---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                           |   282 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h                           |    12 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                              |   548 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c                            |    10 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                                 |    18 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                            |   147 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                            |    52 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                   |   216 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                            |   150 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h                            |     6 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c                        |     6 +
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c                      |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c                        |    27 +-
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h                        |     3 +-
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c                   |     7 +
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h                          |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c                           |   214 ++
 drivers/net/ethernet/mellanox/mlxsw/core.c                                   |    92 +-
 drivers/net/ethernet/mellanox/mlxsw/core.h                                   |    16 +-
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c                  |   255 ++-
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.h                  |    13 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c                                    |     5 +-
 drivers/net/ethernet/mellanox/mlxsw/item.h                                   |     2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c                                    |    98 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h                                    |    37 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                               |   602 +++++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h                               |   101 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c                           |   359 +++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_actions.c              |    66 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c                      |    44 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c                         |    81 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c                        |    49 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c                          |    26 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr_tcam.c                       |     3 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c                         |   551 ++++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c                        |   280 ++-
 drivers/net/ethernet/micrel/ks8851.c                                         |    13 +-
 drivers/net/ethernet/netronome/nfp/Makefile                                  |     3 +
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c                                |   453 ++++
 drivers/net/ethernet/netronome/nfp/bpf/fw.h                                  |   157 ++
 drivers/net/ethernet/netronome/nfp/bpf/jit.c                                 |   988 +++++++--
 drivers/net/ethernet/netronome/nfp/bpf/main.c                                |   248 ++-
 drivers/net/ethernet/netronome/nfp/bpf/main.h                                |   207 +-
 drivers/net/ethernet/netronome/nfp/bpf/offload.c                             |   198 +-
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c                            |   159 +-
 drivers/net/ethernet/netronome/nfp/flower/action.c                           |    79 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c                             |    75 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h                             |    71 +-
 drivers/net/ethernet/netronome/nfp/flower/main.c                             |   156 +-
 drivers/net/ethernet/netronome/nfp/flower/main.h                             |    16 +-
 drivers/net/ethernet/netronome/nfp/flower/match.c                            |   127 +-
 drivers/net/ethernet/netronome/nfp/flower/offload.c                          |    57 +-
 drivers/net/ethernet/netronome/nfp/nfp_app.c                                 |    14 +-
 drivers/net/ethernet/netronome/nfp/nfp_app.h                                 |    84 +-
 drivers/net/ethernet/netronome/nfp/nfp_asm.c                                 |    95 +-
 drivers/net/ethernet/netronome/nfp/nfp_asm.h                                 |    28 +-
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c                             |    12 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c                                |    24 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.h                                |    29 +
 drivers/net/ethernet/netronome/nfp/nfp_net.h                                 |    22 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c                          |   111 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.c                            |   135 ++
 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h                            |   210 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c                       |   811 +++++++
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c                         |   109 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_main.c                            |    76 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c                            |    89 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.h                            |    16 +-
 drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c                          |     6 -
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp.h                             |     2 +
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cpp.h                         |     1 +
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c                     |    62 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cpplib.c                      |    38 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_hwinfo.c                      |    10 +
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c                         |    72 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h                         |     1 +
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_rtsym.c                       |     4 -
 drivers/net/ethernet/nvidia/forcedeth.c                                      |    94 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c                                     |     4 +-
 drivers/net/ethernet/qlogic/Kconfig                                          |     1 +
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c                           |     4 +-
 drivers/net/ethernet/qlogic/qed/qed.h                                        |    12 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                                    |    49 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.h                                    |     4 +-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c                                   |     4 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c                                  |  1167 +++++-----
 drivers/net/ethernet/qlogic/qed/qed_dev.c                                    |    15 +-
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c                                   |    10 +-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h                                    | 10603 ++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 drivers/net/ethernet/qlogic/qed/qed_hw.c                                     |    68 +
 drivers/net/ethernet/qlogic/qed/qed_hw.h                                     |     4 +
 drivers/net/ethernet/qlogic/qed/qed_init_fw_funcs.c                          |  1091 ++++++----
 drivers/net/ethernet/qlogic/qed/qed_init_ops.c                               |    22 +-
 drivers/net/ethernet/qlogic/qed/qed_int.c                                    |     8 +-
 drivers/net/ethernet/qlogic/qed/qed_int.h                                    |     2 +-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c                                  |    58 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c                                  |    33 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.h                                  |     3 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c                                     |   119 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.h                                     |    33 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                                    |    28 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                                    |     2 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c                                   |    12 +-
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h                               |   190 +-
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c                            |     8 +-
 drivers/net/ethernet/qlogic/qed/qed_spq.c                                    |     8 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c                                  |    22 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.h                                  |    24 +
 drivers/net/ethernet/qlogic/qede/qede.h                                      |    10 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c                              |     3 +
 drivers/net/ethernet/qlogic/qede/qede_filter.c                               |    47 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c                                   |     1 +
 drivers/net/ethernet/qlogic/qede/qede_main.c                                 |    33 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c                          |    18 +-
 drivers/net/ethernet/qualcomm/emac/emac-mac.h                                |     3 +-
 drivers/net/ethernet/qualcomm/emac/emac.c                                    |     7 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c                           |    64 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h                           |     3 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c                         |    70 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h                              |    32 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c                      |    17 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c                         |   309 ++-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_private.h                          |    12 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c                              |     7 +
 drivers/net/ethernet/realtek/8139cp.c                                        |     4 +-
 drivers/net/ethernet/realtek/r8169.c                                         |   133 +-
 drivers/net/ethernet/renesas/ravb_main.c                                     |     3 +-
 drivers/net/ethernet/renesas/sh_eth.c                                        |    26 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c                                   |     1 -
 drivers/net/ethernet/sfc/ef10.c                                              |   363 +++-
 drivers/net/ethernet/sfc/ef10_regs.h                                         |    46 +-
 drivers/net/ethernet/sfc/efx.c                                               |    66 +-
 drivers/net/ethernet/sfc/efx.h                                               |     9 +-
 drivers/net/ethernet/sfc/ethtool.c                                           |     6 +-
 drivers/net/ethernet/sfc/farch.c                                             |    26 +-
 drivers/net/ethernet/sfc/io.h                                                |    19 +-
 drivers/net/ethernet/sfc/mcdi.h                                              |     3 +
 drivers/net/ethernet/sfc/mcdi_pcol.h                                         |  2453 +++++++++++++++++++--
 drivers/net/ethernet/sfc/mcdi_port.c                                         |   168 +-
 drivers/net/ethernet/sfc/net_driver.h                                        |    33 +-
 drivers/net/ethernet/sfc/nic.h                                               |    28 +
 drivers/net/ethernet/sfc/ptp.c                                               |   370 +++-
 drivers/net/ethernet/sfc/siena.c                                             |    12 +-
 drivers/net/ethernet/sfc/tx.c                                                |    21 +-
 drivers/net/ethernet/socionext/Kconfig                                       |    34 +
 drivers/net/ethernet/socionext/Makefile                                      |     6 +
 drivers/net/ethernet/socionext/netsec.c                                      |  1777 ++++++++++++++++
 drivers/net/ethernet/socionext/sni_ave.c                                     |  1736 +++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/common.h                                 |     2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c                          |   113 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c                            |     3 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c                         |    12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c                          |    15 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                            |    12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c                           |     6 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                               |     4 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c                              |     2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                            |    61 +-
 drivers/net/ethernet/synopsys/dwc-xlgmac-common.c                            |    24 +-
 drivers/net/ethernet/ti/cpsw.c                                               |    96 +-
 drivers/net/ethernet/ti/cpsw.h                                               |    23 +-
 drivers/net/ethernet/ti/cpsw_ale.c                                           |   109 +-
 drivers/net/ethernet/ti/cpsw_ale.h                                           |     1 -
 drivers/net/ethernet/ti/davinci_cpdma.c                                      |     2 +-
 drivers/net/ethernet/ti/davinci_emac.c                                       |    20 +-
 drivers/net/ethernet/ti/netcp_ethss.c                                        |     6 +-
 drivers/net/geneve.c                                                         |    24 +-
 drivers/net/hyperv/hyperv_net.h                                              |    60 +-
 drivers/net/hyperv/netvsc.c                                                  |    73 +-
 drivers/net/hyperv/netvsc_drv.c                                              |   111 +-
 drivers/net/hyperv/rndis_filter.c                                            |    44 +-
 drivers/net/ieee802154/adf7242.c                                             |    90 +-
 drivers/net/ipvlan/ipvlan_core.c                                             |    17 +-
 drivers/net/ipvlan/ipvlan_main.c                                             |    33 +-
 drivers/net/macsec.c                                                         |    68 +-
 drivers/net/netdevsim/Makefile                                               |    11 +
 drivers/net/netdevsim/bpf.c                                                  |   643 ++++++
 drivers/net/netdevsim/netdev.c                                               |   504 +++++
 drivers/net/netdevsim/netdevsim.h                                            |   109 +
 drivers/net/phy/amd.c                                                        |     2 -
 drivers/net/phy/at803x.c                                                     |    44 +-
 drivers/net/phy/bcm-cygnus.c                                                 |     2 -
 drivers/net/phy/bcm63xx.c                                                    |     4 -
 drivers/net/phy/bcm7xxx.c                                                    |     6 -
 drivers/net/phy/broadcom.c                                                   |    69 +-
 drivers/net/phy/cicada.c                                                     |     4 -
 drivers/net/phy/davicom.c                                                    |     5 -
 drivers/net/phy/dp83640.c                                                    |     2 -
 drivers/net/phy/dp83822.c                                                    |     2 -
 drivers/net/phy/dp83848.c                                                    |     2 -
 drivers/net/phy/dp83867.c                                                    |     2 -
 drivers/net/phy/fixed_phy.c                                                  |    31 -
 drivers/net/phy/icplus.c                                                     |     4 -
 drivers/net/phy/intel-xway.c                                                 |    12 -
 drivers/net/phy/lxt.c                                                        |     5 -
 drivers/net/phy/marvell.c                                                    |   600 +++---
 drivers/net/phy/marvell10g.c                                                 |   111 +-
 drivers/net/phy/mdio-bcm-unimac.c                                            |     2 +
 drivers/net/phy/mdio_bus.c                                                   |    99 +-
 drivers/net/phy/mdio_device.c                                                |    34 +-
 drivers/net/phy/meson-gxl.c                                                  |   186 +-
 drivers/net/phy/micrel.c                                                     |    24 -
 drivers/net/phy/microchip.c                                                  |     1 -
 drivers/net/phy/national.c                                                   |     2 -
 drivers/net/phy/phy-c45.c                                                    |    33 +
 drivers/net/phy/phy-core.c                                                   |   258 ++-
 drivers/net/phy/phy.c                                                        |    56 +-
 drivers/net/phy/phy_device.c                                                 |   108 +-
 drivers/net/phy/phylink.c                                                    |   448 +++-
 drivers/net/phy/qsemi.c                                                      |     2 -
 drivers/net/phy/realtek.c                                                    |   105 +-
 drivers/net/phy/rockchip.c                                                   |     1 -
 drivers/net/phy/sfp-bus.c                                                    |   221 +-
 drivers/net/phy/sfp.c                                                        |   119 +-
 drivers/net/phy/smsc.c                                                       |    11 +-
 drivers/net/phy/ste10Xp.c                                                    |     4 -
 drivers/net/phy/uPD60620.c                                                   |     1 -
 drivers/net/phy/vitesse.c                                                    |    12 -
 drivers/net/slip/slip.c                                                      |     4 +-
 drivers/net/tap.c                                                            |    42 +-
 drivers/net/tun.c                                                            |   459 +++-
 drivers/net/usb/qmi_wwan.c                                                   |     5 +-
 drivers/net/veth.c                                                           |     3 +
 drivers/net/virtio_net.c                                                     |   235 ++-
 drivers/net/vmxnet3/vmxnet3_int.h                                            |     8 +-
 drivers/net/vxlan.c                                                          |    26 +-
 drivers/net/wireless/ath/ath10k/Kconfig                                      |     9 +-
 drivers/net/wireless/ath/ath10k/Makefile                                     |     3 +-
 drivers/net/wireless/ath/ath10k/ahb.c                                        |     2 +-
 drivers/net/wireless/ath/ath10k/bmi.c                                        |     2 +-
 drivers/net/wireless/ath/ath10k/bmi.h                                        |     2 +-
 drivers/net/wireless/ath/ath10k/ce.c                                         |   636 +++++-
 drivers/net/wireless/ath/ath10k/ce.h                                         |    61 +-
 drivers/net/wireless/ath/ath10k/core.c                                       |   342 ++-
 drivers/net/wireless/ath/ath10k/core.h                                       |    36 +-
 drivers/net/wireless/ath/ath10k/coredump.c                                   |   993 +++++++++
 drivers/net/wireless/ath/ath10k/coredump.h                                   |   225 ++
 drivers/net/wireless/ath/ath10k/debug.c                                      |   293 +--
 drivers/net/wireless/ath/ath10k/debug.h                                      |    40 +-
 drivers/net/wireless/ath/ath10k/debugfs_sta.c                                |    29 +-
 drivers/net/wireless/ath/ath10k/hif.h                                        |     2 +-
 drivers/net/wireless/ath/ath10k/htc.c                                        |     2 +-
 drivers/net/wireless/ath/ath10k/htc.h                                        |     2 +-
 drivers/net/wireless/ath/ath10k/htt.c                                        |     9 +-
 drivers/net/wireless/ath/ath10k/htt.h                                        |   165 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c                                     |   365 +++-
 drivers/net/wireless/ath/ath10k/htt_tx.c                                     |   600 +++++-
 drivers/net/wireless/ath/ath10k/hw.c                                         |     4 +-
 drivers/net/wireless/ath/ath10k/hw.h                                         |    23 +-
 drivers/net/wireless/ath/ath10k/mac.c                                        |    72 +-
 drivers/net/wireless/ath/ath10k/mac.h                                        |     2 +-
 drivers/net/wireless/ath/ath10k/pci.c                                        |   230 +-
 drivers/net/wireless/ath/ath10k/pci.h                                        |     2 +-
 drivers/net/wireless/ath/ath10k/rx_desc.h                                    |    52 +-
 drivers/net/wireless/ath/ath10k/spectral.c                                   |     2 +-
 drivers/net/wireless/ath/ath10k/spectral.h                                   |     6 +-
 drivers/net/wireless/ath/ath10k/swap.c                                       |     2 +-
 drivers/net/wireless/ath/ath10k/swap.h                                       |     2 +-
 drivers/net/wireless/ath/ath10k/targaddrs.h                                  |     2 +-
 drivers/net/wireless/ath/ath10k/testmode.c                                   |     2 +-
 drivers/net/wireless/ath/ath10k/testmode_i.h                                 |     2 +-
 drivers/net/wireless/ath/ath10k/thermal.c                                    |     2 +-
 drivers/net/wireless/ath/ath10k/thermal.h                                    |     2 +-
 drivers/net/wireless/ath/ath10k/trace.h                                      |     2 +-
 drivers/net/wireless/ath/ath10k/txrx.c                                       |     2 +-
 drivers/net/wireless/ath/ath10k/txrx.h                                       |     2 +-
 drivers/net/wireless/ath/ath10k/wmi-ops.h                                    |    11 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c                                    |   146 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h                                    |   115 +-
 drivers/net/wireless/ath/ath10k/wmi.c                                        |    74 +-
 drivers/net/wireless/ath/ath10k/wmi.h                                        |    14 +-
 drivers/net/wireless/ath/ath10k/wow.c                                        |     2 +-
 drivers/net/wireless/ath/ath10k/wow.h                                        |     2 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c                                   |     2 -
 drivers/net/wireless/ath/ath6kl/txrx.c                                       |     2 +-
 drivers/net/wireless/ath/ath9k/Kconfig                                       |    14 +-
 drivers/net/wireless/ath/ath9k/Makefile                                      |     4 +-
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c                               |   133 +-
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.h                               |    10 +
 drivers/net/wireless/ath/ath9k/calib.c                                       |    38 +-
 drivers/net/wireless/ath/ath9k/common-spectral.h                             |     4 +-
 drivers/net/wireless/ath/ath9k/dfs.c                                         |     8 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c                                |     4 +
 drivers/net/wireless/ath/ath9k/hw.c                                          |    33 +-
 drivers/net/wireless/ath/ath9k/hw.h                                          |     5 +
 drivers/net/wireless/ath/ath9k/init.c                                        |    57 +
 drivers/net/wireless/ath/ath9k/mac.c                                         |    47 +
 drivers/net/wireless/ath/ath9k/pci.c                                         |    21 +-
 drivers/net/wireless/ath/ath9k/recv.c                                        |     4 +-
 drivers/net/wireless/ath/ath9k/reg.h                                         |    15 +
 drivers/net/wireless/ath/wcn36xx/dxe.c                                       |    46 +-
 drivers/net/wireless/ath/wcn36xx/hal.h                                       |   107 +-
 drivers/net/wireless/ath/wcn36xx/main.c                                      |    16 +-
 drivers/net/wireless/ath/wcn36xx/smd.c                                       |   126 +-
 drivers/net/wireless/ath/wcn36xx/smd.h                                       |     3 +
 drivers/net/wireless/ath/wil6210/boot_loader.h                               |     9 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c                                  |    85 +-
 drivers/net/wireless/ath/wil6210/debugfs.c                                   |   151 +-
 drivers/net/wireless/ath/wil6210/ethtool.c                                   |    15 +
 drivers/net/wireless/ath/wil6210/fw.h                                        |    18 +-
 drivers/net/wireless/ath/wil6210/fw_inc.c                                    |   234 +-
 drivers/net/wireless/ath/wil6210/interrupt.c                                 |    30 +-
 drivers/net/wireless/ath/wil6210/main.c                                      |   304 ++-
 drivers/net/wireless/ath/wil6210/netdev.c                                    |    20 +-
 drivers/net/wireless/ath/wil6210/pcie_bus.c                                  |   192 +-
 drivers/net/wireless/ath/wil6210/pm.c                                        |   121 +-
 drivers/net/wireless/ath/wil6210/pmc.c                                       |    11 +-
 drivers/net/wireless/ath/wil6210/txrx.c                                      |    14 +-
 drivers/net/wireless/ath/wil6210/wil6210.h                                   |   112 +-
 drivers/net/wireless/ath/wil6210/wil_crash_dump.c                            |    11 +
 drivers/net/wireless/ath/wil6210/wil_platform.h                              |    15 +-
 drivers/net/wireless/ath/wil6210/wmi.c                                       |   635 +++++-
 drivers/net/wireless/ath/wil6210/wmi.h                                       |   117 +-
 drivers/net/wireless/broadcom/b43/phy_n.c                                    |     2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c                      |    17 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c                    |   531 ++---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c                      |     1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c                   |    12 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c                      |    24 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c                    |    10 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c                      |    20 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h                     |    14 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c                      |   487 ++---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h                      |    73 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c                 |     3 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_n.c              |   462 +---
 drivers/net/wireless/intel/iwlwifi/Makefile                                  |     3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c                               |   216 ++
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c                                |     4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c                                |     2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/a000.c                                |   216 --
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h                            |     4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h                             |    30 -
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h                         |     2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h                         |    15 +
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h                            |     4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h                          |    19 +
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h                               |   262 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h                               |     4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                                  |    15 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c                              |   195 ++
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.h                              |    87 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h                                 |    38 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h                                  |     2 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c                                 |    13 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h                              |    14 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c                                 |     8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h                              |    20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h                    |     7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                                 |   110 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h                                  |    12 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h                               |    11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/Makefile                              |     2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c                                |    33 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                                  |   232 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c                             |    93 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                                  |    14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                            |    45 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                                 |    22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                                 |    15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/quota.c                               |     4 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c                               |   314 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                                  |   234 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h                                  |    48 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c                                  |     9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                                |    10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                                |    35 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                                 |    28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h                                 |     7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c                          |    15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                                  |    24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c                               |    40 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                                |    38 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h                           |     7 -
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c                         |     4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                              |    81 +-
 drivers/net/wireless/mac80211_hwsim.c                                        |   111 +-
 drivers/net/wireless/mac80211_hwsim.h                                        |    68 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                              |     7 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c                                |    11 +-
 drivers/net/wireless/marvell/mwifiex/debugfs.c                               |    13 +-
 drivers/net/wireless/marvell/mwifiex/fw.h                                    |    11 +
 drivers/net/wireless/marvell/mwifiex/init.c                                  |    10 +
 drivers/net/wireless/marvell/mwifiex/main.c                                  |    97 +-
 drivers/net/wireless/marvell/mwifiex/main.h                                  |    13 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c                                  |    18 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c                                  |    14 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c                               |     4 +
 drivers/net/wireless/marvell/mwifiex/sta_event.c                             |    61 +
 drivers/net/wireless/marvell/mwl8k.c                                         |     7 +-
 drivers/net/wireless/mediatek/Kconfig                                        |     1 +
 drivers/net/wireless/mediatek/Makefile                                       |     1 +
 drivers/net/wireless/mediatek/mt76/Kconfig                                   |    10 +
 drivers/net/wireless/mediatek/mt76/Makefile                                  |    15 +
 drivers/net/wireless/mediatek/mt76/agg-rx.c                                  |   258 +++
 drivers/net/wireless/mediatek/mt76/debugfs.c                                 |    78 +
 drivers/net/wireless/mediatek/mt76/dma.c                                     |   459 ++++
 drivers/net/wireless/mediatek/mt76/dma.h                                     |    38 +
 drivers/net/wireless/mediatek/mt76/eeprom.c                                  |   112 +
 drivers/net/wireless/mediatek/mt76/mac80211.c                                |   505 +++++
 drivers/net/wireless/mediatek/mt76/mmio.c                                    |    61 +
 drivers/net/wireless/mediatek/mt76/mt76.h                                    |   432 ++++
 drivers/net/wireless/mediatek/mt76/mt76x2.h                                  |   228 ++
 drivers/net/wireless/mediatek/mt76/mt76x2_core.c                             |    88 +
 drivers/net/wireless/mediatek/mt76/mt76x2_debugfs.c                          |   133 ++
 drivers/net/wireless/mediatek/mt76/mt76x2_dfs.c                              |   506 +++++
 drivers/net/wireless/mediatek/mt76/mt76x2_dfs.h                              |    82 +
 drivers/net/wireless/mediatek/mt76/mt76x2_dma.c                              |   184 ++
 drivers/net/wireless/mediatek/mt76/mt76x2_dma.h                              |    68 +
 drivers/net/wireless/mediatek/mt76/mt76x2_eeprom.c                           |   664 ++++++
 drivers/net/wireless/mediatek/mt76/mt76x2_eeprom.h                           |   185 ++
 drivers/net/wireless/mediatek/mt76/mt76x2_init.c                             |   875 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c                              |   839 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.h                              |   190 ++
 drivers/net/wireless/mediatek/mt76/mt76x2_main.c                             |   577 +++++
 drivers/net/wireless/mediatek/mt76/mt76x2_mcu.c                              |   453 ++++
 drivers/net/wireless/mediatek/mt76/mt76x2_mcu.h                              |   155 ++
 drivers/net/wireless/mediatek/mt76/mt76x2_pci.c                              |   110 +
 drivers/net/wireless/mediatek/mt76/mt76x2_phy.c                              |   740 +++++++
 drivers/net/wireless/mediatek/mt76/mt76x2_regs.h                             |   587 ++++++
 drivers/net/wireless/mediatek/mt76/mt76x2_trace.c                            |    23 +
 drivers/net/wireless/mediatek/mt76/mt76x2_trace.h                            |   144 ++
 drivers/net/wireless/mediatek/mt76/mt76x2_tx.c                               |   260 +++
 drivers/net/wireless/mediatek/mt76/trace.c                                   |    23 +
 drivers/net/wireless/mediatek/mt76/trace.h                                   |    71 +
 drivers/net/wireless/mediatek/mt76/tx.c                                      |   511 +++++
 drivers/net/wireless/mediatek/mt76/util.c                                    |    78 +
 drivers/net/wireless/mediatek/mt76/util.h                                    |    44 +
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c                            |   191 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.h                            |    19 -
 drivers/net/wireless/quantenna/qtnfmac/commands.c                            |   581 +++--
 drivers/net/wireless/quantenna/qtnfmac/commands.h                            |     5 +
 drivers/net/wireless/quantenna/qtnfmac/core.c                                |   152 +-
 drivers/net/wireless/quantenna/qtnfmac/core.h                                |    23 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c                               |    80 +-
 drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c                          |     7 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h                               |   351 ++-
 drivers/net/wireless/quantenna/qtnfmac/qlink_util.c                          |    78 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink_util.h                          |     4 +
 drivers/net/wireless/quantenna/qtnfmac/util.c                                |     8 +-
 drivers/net/wireless/quantenna/qtnfmac/util.h                                |     4 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c                               |     2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c                               |    32 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c                             |    12 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c                       |     5 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h                             |     2 +-
 drivers/net/wireless/realtek/rtlwifi/base.c                                  |   164 +-
 drivers/net/wireless/realtek/rtlwifi/base.h                                  |     2 +
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.c             |   203 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.h             |     3 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c             |   269 ++-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.h             |     3 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c             |   206 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.h             |     3 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c             |   285 ++-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.h             |     3 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c             |   177 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.h             |     3 +-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c                |   663 ++++--
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h                |   252 ++-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c                     |   325 ++-
 drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.h                     |    12 +-
 drivers/net/wireless/realtek/rtlwifi/core.c                                  |    52 +-
 drivers/net/wireless/realtek/rtlwifi/debug.c                                 |   483 ++++-
 drivers/net/wireless/realtek/rtlwifi/debug.h                                 |    12 +
 drivers/net/wireless/realtek/rtlwifi/efuse.c                                 |     4 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c                                   |    94 +-
 drivers/net/wireless/realtek/rtlwifi/pci.h                                   |     5 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c                                    |    29 +-
 drivers/net/wireless/realtek/rtlwifi/rc.c                                    |    16 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c                          |     2 +
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c                          |    11 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.h                          |     3 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c                          |    12 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.h                          |     3 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c                          |    12 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.h                          |     3 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c                          |    11 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.h                          |     3 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c                         |    57 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c                          |    12 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.h                          |     3 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c                          |     7 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.h                          |     3 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c                          |    22 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.h                          |     3 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c                         |    12 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/table.c                       |    14 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.c                  |     4 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c                          |    11 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.h                          |     3 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/table.c                       |    34 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c                                   |     1 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h                                  |    68 +-
 drivers/net/wireless/ti/wl1251/init.c                                        |     4 +-
 drivers/net/wireless/ti/wl1251/main.c                                        |     3 +-
 drivers/net/wireless/ti/wlcore/acx.c                                         |     2 +-
 drivers/net/wireless/ti/wlcore/acx.h                                         |     2 -
 drivers/net/wireless/ti/wlcore/main.c                                        |    41 +-
 drivers/net/wireless/ti/wlcore/tx.c                                          |     4 +-
 drivers/of/of_mdio.c                                                         |     5 +
 drivers/pci/pci.c                                                            |    25 +
 drivers/s390/net/Kconfig                                                     |     3 -
 drivers/s390/net/lcs.c                                                       |    10 +-
 drivers/s390/net/lcs.h                                                       |     3 +-
 drivers/s390/net/qeth_core.h                                                 |    42 +-
 drivers/s390/net/qeth_core_main.c                                            |   105 +-
 drivers/s390/net/qeth_core_mpc.h                                             |    13 +-
 drivers/s390/net/qeth_l2.h                                                   |     3 +-
 drivers/s390/net/qeth_l2_main.c                                              |    92 +-
 drivers/s390/net/qeth_l3.h                                                   |    15 +-
 drivers/s390/net/qeth_l3_main.c                                              |   510 ++---
 drivers/s390/net/qeth_l3_sys.c                                               |   114 +-
 drivers/scsi/qedf/drv_fcoe_fw_funcs.c                                        |    35 +-
 drivers/scsi/qedf/drv_fcoe_fw_funcs.h                                        |     2 +-
 drivers/scsi/qedf/qedf.h                                                     |     4 +-
 drivers/scsi/qedf/qedf_els.c                                                 |     2 +-
 drivers/scsi/qedf/qedf_hsi.h                                                 |    68 -
 drivers/scsi/qedf/qedf_io.c                                                  |    35 +-
 drivers/scsi/qedf/qedf_main.c                                                |    12 +-
 drivers/scsi/qedf/qedf_version.h                                             |     8 +-
 drivers/scsi/qedi/qedi_debugfs.c                                             |     4 +-
 drivers/scsi/qedi/qedi_fw.c                                                  |    59 +-
 drivers/scsi/qedi/qedi_fw_api.c                                              |   139 +-
 drivers/scsi/qedi/qedi_fw_iscsi.h                                            |     2 +-
 drivers/scsi/qedi/qedi_gbl.h                                                 |     5 +-
 drivers/scsi/qedi/qedi_iscsi.c                                               |     9 +-
 drivers/scsi/qedi/qedi_iscsi.h                                               |     2 +-
 drivers/scsi/qedi/qedi_main.c                                                |    29 +-
 drivers/scsi/qedi/qedi_version.h                                             |     8 +-
 drivers/ssb/Kconfig                                                          |     9 +-
 drivers/tty/serdev/core.c                                                    |    12 +
 drivers/tty/serdev/serdev-ttyport.c                                          |    24 +
 drivers/vhost/net.c                                                          |    68 +-
 fs/btrfs/disk-io.c                                                           |     2 +
 fs/btrfs/free-space-cache.c                                                  |     2 +
 fs/gfs2/glock.c                                                              |     7 +-
 fs/nsfs.c                                                                    |    29 +-
 include/asm-generic/error-injection.h                                        |    35 +
 include/asm-generic/vmlinux.lds.h                                            |    10 +
 include/linux/acpi.h                                                         |     3 +
 include/linux/bpf.h                                                          |    94 +-
 include/linux/bpf_types.h                                                    |     2 +-
 include/linux/bpf_verifier.h                                                 |    63 +-
 include/linux/brcmphy.h                                                      |     1 +
 include/linux/can/dev.h                                                      |     7 +
 include/linux/dsa/lan9303.h                                                  |     3 +-
 include/linux/error-injection.h                                              |    27 +
 include/linux/filter.h                                                       |    40 +-
 include/linux/hyperv.h                                                       |    22 -
 include/linux/if_link.h                                                      |     2 +
 include/linux/if_macvlan.h                                                   |     2 +-
 include/linux/if_tap.h                                                       |     6 +-
 include/linux/if_tun.h                                                       |    21 +-
 include/linux/inetdevice.h                                                   |     2 +-
 include/linux/mdio.h                                                         |     8 +
 include/linux/mlx5/fs.h                                                      |     4 +
 include/linux/mlx5/mlx5_ifc.h                                                |    46 +-
 include/linux/mlx5/transobj.h                                                |    23 +
 include/linux/module.h                                                       |     6 +
 include/linux/net.h                                                          |     1 -
 include/linux/net_dim.h                                                      |   380 ++++
 include/linux/netdev_features.h                                              |     3 +
 include/linux/netdevice.h                                                    |    54 +-
 include/linux/netfilter.h                                                    |   116 +-
 include/linux/netfilter/ipset/ip_set.h                                       |     6 +
 include/linux/netfilter/ipset/ip_set_counter.h                               |    25 +-
 include/linux/netfilter/x_tables.h                                           |     2 +
 include/linux/netfilter_defs.h                                               |    12 +-
 include/linux/netfilter_ipv4.h                                               |    46 +
 include/linux/netfilter_ipv6.h                                               |    19 +
 include/linux/pci.h                                                          |     1 +
 include/linux/phy.h                                                          |   145 +-
 include/linux/phy_fixed.h                                                    |     9 -
 include/linux/phylink.h                                                      |   201 +-
 include/linux/proc_ns.h                                                      |     3 +
 include/linux/property.h                                                     |    11 +
 include/linux/ptr_ring.h                                                     |    79 +-
 include/linux/qed/common_hsi.h                                               |  1264 ++++++-----
 include/linux/qed/eth_common.h                                               |   396 ++--
 include/linux/qed/fcoe_common.h                                              |   940 +++++----
 include/linux/qed/iscsi_common.h                                             |  1585 +++++++-------
 include/linux/qed/iwarp_common.h                                             |    17 +-
 include/linux/qed/qed_eth_if.h                                               |    38 +-
 include/linux/qed/qed_if.h                                                   |    36 +-
 include/linux/qed/qed_iscsi_if.h                                             |     2 -
 include/linux/qed/qed_ll2_if.h                                               |     2 +-
 include/linux/qed/rdma_common.h                                              |    25 +-
 include/linux/qed/roce_common.h                                              |    15 +-
 include/linux/qed/storage_common.h                                           |    91 +-
 include/linux/qed/tcp_common.h                                               |   165 +-
 include/linux/rhashtable.h                                                   |    38 +-
 include/linux/rtnetlink.h                                                    |    15 +-
 include/linux/sctp.h                                                         |    37 +
 include/linux/serdev.h                                                       |    10 +
 include/linux/sfp.h                                                          |    94 +-
 include/linux/sh_eth.h                                                       |     3 -
 include/linux/skb_array.h                                                    |     7 +-
 include/linux/skbuff.h                                                       |     5 +
 include/linux/spinlock.h                                                     |     6 +
 include/linux/tcp.h                                                          |    13 +-
 include/linux/trace_events.h                                                 |     7 +
 include/net/act_api.h                                                        |    15 +-
 include/net/addrconf.h                                                       |     2 +-
 include/net/caif/cfpkt.h                                                     |    27 +
 include/net/cfg80211.h                                                       |    17 +-
 include/net/devlink.h                                                        |   115 +
 include/net/dn_route.h                                                       |     1 +
 include/net/dsa.h                                                            |    61 +-
 include/net/dst.h                                                            |    39 +-
 include/net/erspan.h                                                         |   240 ++-
 include/net/gen_stats.h                                                      |     3 +
 include/net/inet_connection_sock.h                                           |     2 +
 include/net/inet_hashtables.h                                                |    29 +-
 include/net/inet_sock.h                                                      |    25 +
 include/net/inet_timewait_sock.h                                             |     4 +-
 include/net/ip.h                                                             |     9 +
 include/net/ip6_fib.h                                                        |    20 +-
 include/net/ip6_route.h                                                      |    11 +-
 include/net/ip6_tunnel.h                                                     |     4 +
 include/net/ip_tunnels.h                                                     |     5 +-
 include/net/ip_vs.h                                                          |     3 +-
 include/net/ipv6.h                                                           |    19 +
 include/net/mac80211.h                                                       |    10 +-
 include/net/net_namespace.h                                                  |    10 +-
 include/net/netfilter/ipv4/nf_conntrack_ipv4.h                               |    12 +-
 include/net/netfilter/ipv6/nf_conntrack_ipv6.h                               |    12 +-
 include/net/netfilter/nf_conntrack_count.h                                   |    17 +
 include/net/netfilter/nf_conntrack_l4proto.h                                 |    19 +-
 include/net/netfilter/nf_flow_table.h                                        |   122 ++
 include/net/netfilter/nf_queue.h                                             |     2 +-
 include/net/netfilter/nf_tables.h                                            |   129 +-
 include/net/netfilter/nf_tables_ipv4.h                                       |    27 +-
 include/net/netfilter/nf_tables_ipv6.h                                       |    29 +-
 include/net/netns/can.h                                                      |     4 +-
 include/net/netns/core.h                                                     |     5 +-
 include/net/netns/netfilter.h                                                |    12 +-
 include/net/netns/nftables.h                                                 |     8 +-
 include/net/netns/sctp.h                                                     |     5 +-
 include/net/pkt_cls.h                                                        |   113 +-
 include/net/pkt_sched.h                                                      |    17 +-
 include/net/route.h                                                          |     2 +-
 include/net/rtnetlink.h                                                      |     4 +-
 include/net/sch_generic.h                                                    |   150 +-
 include/net/sctp/constants.h                                                 |     9 +-
 include/net/sctp/sctp.h                                                      |     6 +-
 include/net/sctp/sm.h                                                        |    18 +-
 include/net/sctp/stream_interleave.h                                         |    61 +
 include/net/sctp/structs.h                                                   |    68 +-
 include/net/sctp/ulpevent.h                                                  |    23 +-
 include/net/sctp/ulpqueue.h                                                  |    10 +-
 include/net/sock.h                                                           |    57 +-
 include/net/tc_act/tc_csum.h                                                 |    16 +-
 include/net/tc_act/tc_mirred.h                                               |     6 +-
 include/net/tcp.h                                                            |    52 +-
 include/net/tls.h                                                            |     2 +
 include/net/vxlan.h                                                          |     2 +-
 include/net/wext.h                                                           |     4 +-
 include/net/xdp.h                                                            |    48 +
 include/net/xfrm.h                                                           |    79 +-
 include/trace/events/bridge.h                                                |     4 +-
 include/trace/events/net_probe_common.h                                      |    44 +
 include/trace/events/sctp.h                                                  |    99 +
 include/trace/events/sock.h                                                  |   117 +
 include/trace/events/tcp.h                                                   |    76 +-
 net/batman-adv/packet.h => include/uapi/linux/batadv_packet.h                |   269 +--
 include/uapi/linux/batman_adv.h                                              |    27 +-
 include/uapi/linux/bpf.h                                                     |   116 +-
 include/uapi/linux/bpf_common.h                                              |     7 +-
 include/uapi/linux/can/netlink.h                                             |     1 +
 include/uapi/linux/devlink.h                                                 |    25 +
 include/uapi/linux/erspan.h                                                  |    52 +
 include/uapi/linux/ethtool.h                                                 |     1 +
 include/uapi/linux/if_ether.h                                                |     1 +
 include/uapi/linux/if_link.h                                                 |     5 +
 include/uapi/linux/if_macsec.h                                               |     9 +-
 include/uapi/linux/if_tun.h                                                  |     2 +
 include/uapi/linux/if_tunnel.h                                               |     3 +
 include/uapi/linux/inet_diag.h                                               |     2 +
 include/uapi/linux/l2tp.h                                                    |     6 +-
 include/uapi/linux/netfilter/nf_conntrack_common.h                           |     6 +-
 include/uapi/linux/netfilter/nf_tables.h                                     |    76 +
 include/uapi/linux/netfilter/xt_connlimit.h                                  |     2 +-
 include/uapi/linux/netfilter_arp.h                                           |     3 +
 include/uapi/linux/netfilter_decnet.h                                        |     4 +-
 include/uapi/linux/netfilter_ipv4.h                                          |     1 +
 include/uapi/linux/netfilter_ipv6.h                                          |     1 +
 include/uapi/linux/netfilter_ipv6/ip6t_srh.h                                 |    57 +
 include/uapi/linux/nl80211.h                                                 |     4 +
 include/uapi/linux/openvswitch.h                                             |     1 +
 include/uapi/linux/perf_event.h                                              |    22 +
 include/uapi/linux/rtnetlink.h                                               |    12 +
 include/uapi/linux/sctp.h                                                    |     3 +
 include/uapi/linux/tipc.h                                                    |     7 +-
 include/uapi/linux/virtio_net.h                                              |    13 +
 kernel/Makefile                                                              |     1 +
 kernel/bpf/Makefile                                                          |     2 +
 kernel/bpf/arraymap.c                                                        |    49 +-
 kernel/bpf/cgroup.c                                                          |    15 +-
 kernel/bpf/core.c                                                            |   409 ++--
 kernel/bpf/cpumap.c                                                          |    31 +-
 kernel/bpf/devmap.c                                                          |     8 +-
 kernel/bpf/disasm.c                                                          |    63 +-
 kernel/bpf/disasm.h                                                          |    29 +-
 kernel/bpf/hashtab.c                                                         |   103 +-
 kernel/bpf/lpm_trie.c                                                        |    98 +-
 kernel/bpf/offload.c                                                         |   430 +++-
 kernel/bpf/sockmap.c                                                         |    16 +-
 kernel/bpf/stackmap.c                                                        |    34 +-
 kernel/bpf/syscall.c                                                         |   214 +-
 kernel/bpf/verifier.c                                                        |  1451 ++++++++++---
 kernel/events/core.c                                                         |    10 +
 kernel/fail_function.c                                                       |   349 +++
 kernel/module.c                                                              |     6 +-
 kernel/trace/Kconfig                                                         |     9 +
 kernel/trace/bpf_trace.c                                                     |    59 +-
 kernel/trace/trace_kprobe.c                                                  |    61 +-
 kernel/trace/trace_probe.h                                                   |    12 +
 lib/Kconfig.debug                                                            |    14 +
 lib/Makefile                                                                 |     3 +-
 lib/bucket_locks.c                                                           |    54 +
 lib/error-inject.c                                                           |   242 +++
 lib/rhashtable.c                                                             |   160 +-
 lib/test_bpf.c                                                               |   112 +-
 lib/test_rhashtable.c                                                        |     6 +-
 net/8021q/vlanproc.c                                                         |     2 -
 net/Kconfig                                                                  |    18 +-
 net/appletalk/aarp.c                                                         |     1 -
 net/appletalk/atalk_proc.c                                                   |     3 -
 net/atm/br2684.c                                                             |     1 -
 net/atm/common.c                                                             |     2 +-
 net/atm/lec.c                                                                |     1 -
 net/atm/mpc.c                                                                |     9 +-
 net/atm/mpoa_caches.c                                                        |    48 +-
 net/atm/mpoa_caches.h                                                        |     9 +-
 net/atm/mpoa_proc.c                                                          |    16 +-
 net/atm/proc.c                                                               |     1 -
 net/ax25/af_ax25.c                                                           |     1 -
 net/ax25/ax25_route.c                                                        |     1 -
 net/ax25/ax25_uid.c                                                          |     1 -
 net/batman-adv/Kconfig                                                       |    17 +
 net/batman-adv/Makefile                                                      |     2 +-
 net/batman-adv/bat_algo.c                                                    |    35 +-
 net/batman-adv/bat_algo.h                                                    |     1 +
 net/batman-adv/bat_iv_ogm.c                                                  |   107 +-
 net/batman-adv/bat_iv_ogm.h                                                  |     1 +
 net/batman-adv/bat_v.c                                                       |    51 +-
 net/batman-adv/bat_v.h                                                       |     1 +
 net/batman-adv/bat_v_elp.c                                                   |    29 +-
 net/batman-adv/bat_v_elp.h                                                   |     1 +
 net/batman-adv/bat_v_ogm.c                                                   |    39 +-
 net/batman-adv/bat_v_ogm.h                                                   |     1 +
 net/batman-adv/bitarray.c                                                    |     3 +-
 net/batman-adv/bitarray.h                                                    |    10 +-
 net/batman-adv/bridge_loop_avoidance.c                                       |   114 +-
 net/batman-adv/bridge_loop_avoidance.h                                       |     5 +-
 net/batman-adv/debugfs.c                                                     |    30 +-
 net/batman-adv/debugfs.h                                                     |     1 +
 net/batman-adv/distributed-arp-table.c                                       |    80 +-
 net/batman-adv/distributed-arp-table.h                                       |     9 +-
 net/batman-adv/fragmentation.c                                               |    25 +-
 net/batman-adv/fragmentation.h                                               |     3 +-
 net/batman-adv/gateway_client.c                                              |    67 +-
 net/batman-adv/gateway_client.h                                              |     1 +
 net/batman-adv/gateway_common.c                                              |    30 +-
 net/batman-adv/gateway_common.h                                              |     6 +-
 net/batman-adv/hard-interface.c                                              |    67 +-
 net/batman-adv/hard-interface.h                                              |    59 +-
 net/batman-adv/hash.c                                                        |    20 +-
 net/batman-adv/hash.h                                                        |    28 +-
 net/batman-adv/icmp_socket.c                                                 |    17 +-
 net/batman-adv/icmp_socket.h                                                 |     1 +
 net/batman-adv/log.c                                                         |    19 +
 net/batman-adv/log.h                                                         |    62 +-
 net/batman-adv/main.c                                                        |    54 +-
 net/batman-adv/main.h                                                        |   127 +-
 net/batman-adv/multicast.c                                                   |    83 +-
 net/batman-adv/multicast.h                                                   |    17 +-
 net/batman-adv/netlink.c                                                     |    27 +-
 net/batman-adv/netlink.h                                                     |     1 +
 net/batman-adv/network-coding.c                                              |   126 +-
 net/batman-adv/network-coding.h                                              |     1 +
 net/batman-adv/originator.c                                                  |   154 +-
 net/batman-adv/originator.h                                                  |    47 +-
 net/batman-adv/routing.c                                                     |    56 +-
 net/batman-adv/routing.h                                                     |     1 +
 net/batman-adv/send.c                                                        |    66 +-
 net/batman-adv/send.h                                                        |     8 +-
 net/batman-adv/soft-interface.c                                              |    66 +-
 net/batman-adv/soft-interface.h                                              |     1 +
 net/batman-adv/sysfs.c                                                       |    58 +-
 net/batman-adv/sysfs.h                                                       |    14 +
 net/batman-adv/tp_meter.c                                                    |    77 +-
 net/batman-adv/tp_meter.h                                                    |     1 +
 net/batman-adv/translation-table.c                                           |   234 +-
 net/batman-adv/translation-table.h                                           |     1 +
 net/batman-adv/tvlv.c                                                        |    43 +-
 net/batman-adv/tvlv.h                                                        |     1 +
 net/batman-adv/types.h                                                       |  1996 ++++++++++++------
 net/bluetooth/af_bluetooth.c                                                 |    38 +-
 net/bluetooth/cmtp/capi.c                                                    |     1 -
 net/bluetooth/hci_debugfs.c                                                  |   201 +-
 net/bluetooth/hci_request.c                                                  |    64 +-
 net/bridge/br_device.c                                                       |    10 +
 net/bridge/br_fdb.c                                                          |   392 ++--
 net/bridge/br_mdb.c                                                          |     6 +-
 net/bridge/br_netfilter_hooks.c                                              |     2 +-
 net/bridge/br_nf_core.c                                                      |     1 -
 net/bridge/br_private.h                                                      |    18 +-
 net/bridge/br_switchdev.c                                                    |     8 +-
 net/bridge/br_sysfs_br.c                                                     |    13 +-
 net/bridge/netfilter/Kconfig                                                 |     2 +
 net/bridge/netfilter/ebtables.c                                              |     2 -
 net/bridge/netfilter/nf_tables_bridge.c                                      |   120 +-
 net/caif/cfctrl.c                                                            |    50 +-
 net/caif/cfpkt_skbuff.c                                                      |     1 -
 net/caif/chnl_net.c                                                          |     1 -
 net/can/Kconfig                                                              |     2 +-
 net/can/af_can.c                                                             |    20 +-
 net/can/af_can.h                                                             |     2 +-
 net/can/bcm.c                                                                |     1 -
 net/can/gw.c                                                                 |    14 +-
 net/can/proc.c                                                               |    14 +-
 net/can/raw.c                                                                |     2 +
 net/core/Makefile                                                            |     2 +-
 net/core/dev.c                                                               |   260 ++-
 net/core/dev_ioctl.c                                                         |   132 +-
 net/core/devlink.c                                                           |   596 +++++-
 net/core/dst.c                                                               |    14 +-
 net/core/ethtool.c                                                           |    14 +-
 net/core/filter.c                                                            |   359 +++-
 net/core/flow_dissector.c                                                    |    69 +-
 net/core/gen_estimator.c                                                     |     4 +
 net/core/gen_stats.c                                                         |     9 +-
 net/core/link_watch.c                                                        |     2 +-
 net/core/neighbour.c                                                         |     1 -
 net/core/net-procfs.c                                                        |     4 -
 net/core/net-sysfs.c                                                         |    56 +-
 net/core/net_namespace.c                                                     |    83 +-
 net/core/pktgen.c                                                            |   281 +--
 net/core/rtnetlink.c                                                         |   482 +++--
 net/core/skbuff.c                                                            |    14 +-
 net/core/sock.c                                                              |    56 +-
 net/core/sock_reuseport.c                                                    |     4 +-
 net/core/sysctl_net_core.c                                                   |    60 +-
 net/core/xdp.c                                                               |    73 +
 net/dccp/Kconfig                                                             |    17 -
 net/dccp/Makefile                                                            |     5 +-
 net/dccp/ackvec.c                                                            |     2 +-
 net/dccp/minisocks.c                                                         |     7 +-
 net/dccp/probe.c                                                             |   203 --
 net/dccp/proto.c                                                             |     7 +-
 net/dccp/trace.h                                                             |    84 +
 net/decnet/af_decnet.c                                                       |     1 -
 net/decnet/dn_dev.c                                                          |    10 +-
 net/decnet/dn_fib.c                                                          |     6 +-
 net/decnet/dn_neigh.c                                                        |     1 -
 net/decnet/dn_route.c                                                        |    43 +-
 net/dsa/Kconfig                                                              |     9 +
 net/dsa/Makefile                                                             |     3 +-
 net/dsa/dsa2.c                                                               |     9 +-
 net/dsa/dsa_priv.h                                                           |    13 +-
 net/dsa/legacy.c                                                             |    24 +-
 net/dsa/port.c                                                               |   103 +-
 net/dsa/slave.c                                                              |    25 +-
 net/dsa/switch.c                                                             |   111 +-
 net/dsa/tag_brcm.c                                                           |    12 +
 net/dsa/tag_mtk.c                                                            |    38 +-
 net/ipv4/Makefile                                                            |     1 -
 net/ipv4/af_inet.c                                                           |    45 +-
 net/ipv4/arp.c                                                               |     1 -
 net/ipv4/devinet.c                                                           |    61 +-
 net/ipv4/esp4.c                                                              |    36 +-
 net/ipv4/esp4_offload.c                                                      |    75 +-
 net/ipv4/fib_frontend.c                                                      |     8 +-
 net/ipv4/fib_trie.c                                                          |     3 -
 net/ipv4/igmp.c                                                              |     2 -
 net/ipv4/inet_connection_sock.c                                              |     8 +-
 net/ipv4/inet_diag.c                                                         |     8 +
 net/ipv4/inet_hashtables.c                                                   |   186 +-
 net/ipv4/inet_timewait_sock.c                                                |    31 +-
 net/ipv4/ip_gre.c                                                            |   169 +-
 net/ipv4/ip_sockglue.c                                                       |     6 +-
 net/ipv4/ip_tunnel.c                                                         |    13 +-
 net/ipv4/ipconfig.c                                                          |    48 +-
 net/ipv4/ipmr.c                                                              |     4 +-
 net/ipv4/netfilter.c                                                         |    62 +-
 net/ipv4/netfilter/Kconfig                                                   |    13 +
 net/ipv4/netfilter/Makefile                                                  |     9 +
 net/ipv4/netfilter/arp_tables.c                                              |    27 +-
 net/ipv4/netfilter/ip_tables.c                                               |    27 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                                           |     1 -
 net/ipv4/netfilter/iptable_filter.c                                          |     6 -
 net/ipv4/netfilter/iptable_mangle.c                                          |     5 -
 net/ipv4/netfilter/iptable_nat.c                                             |     4 +
 net/ipv4/netfilter/iptable_raw.c                                             |    37 +-
 net/ipv4/netfilter/iptable_security.c                                        |     6 -
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c                               |     7 +-
 net/ipv4/netfilter/nf_conntrack_proto_icmp.c                                 |     4 +-
 net/ipv4/netfilter/nf_defrag_ipv4.c                                          |     2 +
 net/ipv4/netfilter/nf_flow_table_ipv4.c                                      |   284 +++
 net/ipv4/netfilter/nf_nat_l3proto_ipv4.c                                     |    10 -
 net/ipv4/netfilter/nf_nat_snmp_basic.asn1                                    |   177 ++
 net/ipv4/netfilter/nf_nat_snmp_basic.c                                       |  1286 -----------
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c                                  |   235 +++
 net/ipv4/netfilter/nf_tables_arp.c                                           |    62 +-
 net/ipv4/netfilter/nf_tables_ipv4.c                                          |    83 +-
 net/ipv4/netfilter/nft_chain_nat_ipv4.c                                      |     3 +-
 net/ipv4/netfilter/nft_chain_route_ipv4.c                                    |     8 +-
 net/ipv4/proc.c                                                              |     3 -
 net/ipv4/raw.c                                                               |    16 +-
 net/ipv4/route.c                                                             |     5 +-
 net/ipv4/tcp.c                                                               |    73 +-
 net/ipv4/tcp_bbr.c                                                           |     3 +-
 net/ipv4/tcp_diag.c                                                          |     2 +-
 net/ipv4/tcp_fastopen.c                                                      |    30 +-
 net/ipv4/tcp_input.c                                                         |    58 +-
 net/ipv4/tcp_ipv4.c                                                          |     5 +-
 net/ipv4/tcp_metrics.c                                                       |     7 +-
 net/ipv4/tcp_minisocks.c                                                     |     7 +-
 net/ipv4/tcp_nv.c                                                            |     4 +-
 net/ipv4/tcp_output.c                                                        |    18 +-
 net/ipv4/tcp_probe.c                                                         |   301 ---
 net/ipv4/tcp_timer.c                                                         |    24 +-
 net/ipv4/udp.c                                                               |    62 +-
 net/ipv4/udplite.c                                                           |     1 -
 net/ipv4/xfrm4_mode_tunnel.c                                                 |     7 +-
 net/ipv6/addrconf.c                                                          |    90 +-
 net/ipv6/addrlabel.c                                                         |    25 +-
 net/ipv6/af_inet6.c                                                          |    11 +-
 net/ipv6/anycast.c                                                           |     1 -
 net/ipv6/datagram.c                                                          |     3 +-
 net/ipv6/esp6.c                                                              |    36 +-
 net/ipv6/esp6_offload.c                                                      |    82 +-
 net/ipv6/ila/ila_xlat.c                                                      |     4 +-
 net/ipv6/inet6_hashtables.c                                                  |    77 +-
 net/ipv6/ip6_fib.c                                                           |    66 +-
 net/ipv6/ip6_flowlabel.c                                                     |     1 -
 net/ipv6/ip6_gre.c                                                           |   638 +++++-
 net/ipv6/ip6_output.c                                                        |    15 +-
 net/ipv6/ip6_tunnel.c                                                        |     5 +-
 net/ipv6/ip6_vti.c                                                           |    20 +
 net/ipv6/ip6mr.c                                                             |    12 +-
 net/ipv6/mcast.c                                                             |     4 -
 net/ipv6/ndisc.c                                                             |     5 +
 net/ipv6/netfilter.c                                                         |    44 +-
 net/ipv6/netfilter/Kconfig                                                   |    18 +
 net/ipv6/netfilter/Makefile                                                  |     4 +
 net/ipv6/netfilter/ip6_tables.c                                              |    27 +-
 net/ipv6/netfilter/ip6t_srh.c                                                |   161 ++
 net/ipv6/netfilter/ip6table_mangle.c                                         |     8 -
 net/ipv6/netfilter/ip6table_nat.c                                            |     4 +
 net/ipv6/netfilter/ip6table_raw.c                                            |    31 +-
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c                               |     7 +-
 net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c                               |     4 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c                                      |    15 +-
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c                                    |     3 +
 net/ipv6/netfilter/nf_flow_table_ipv6.c                                      |   277 +++
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c                                     |     8 -
 net/ipv6/netfilter/nf_tables_ipv6.c                                          |    82 +-
 net/ipv6/netfilter/nft_chain_nat_ipv6.c                                      |     3 +-
 net/ipv6/netfilter/nft_chain_route_ipv6.c                                    |     3 +-
 net/ipv6/netfilter/nft_fib_ipv6.c                                            |    12 +-
 net/ipv6/proc.c                                                              |     3 -
 net/ipv6/raw.c                                                               |     1 -
 net/ipv6/route.c                                                             |   567 +++--
 net/ipv6/seg6.c                                                              |     4 +-
 net/ipv6/seg6_local.c                                                        |     2 +-
 net/ipv6/tcp_ipv6.c                                                          |     6 +-
 net/ipv6/udp.c                                                               |    55 +-
 net/ipv6/udplite.c                                                           |     1 -
 net/ipv6/xfrm6_mode_tunnel.c                                                 |     7 +-
 net/ipv6/xfrm6_policy.c                                                      |     2 +-
 net/ipx/ipx_proc.c                                                           |     3 -
 net/kcm/kcmproc.c                                                            |     2 -
 net/l2tp/l2tp_core.c                                                         |    54 +-
 net/l2tp/l2tp_core.h                                                         |    16 +-
 net/l2tp/l2tp_debugfs.c                                                      |     4 +-
 net/l2tp/l2tp_netlink.c                                                      |    39 +-
 net/l2tp/l2tp_ppp.c                                                          |     1 -
 net/llc/llc_proc.c                                                           |     2 -
 net/mac80211/agg-rx.c                                                        |    26 +-
 net/mac80211/agg-tx.c                                                        |    34 +-
 net/mac80211/cfg.c                                                           |    31 +-
 net/mac80211/debugfs.c                                                       |     1 +
 net/mac80211/debugfs_sta.c                                                   |     4 +-
 net/mac80211/driver-ops.h                                                    |     3 +-
 net/mac80211/ht.c                                                            |     1 +
 net/mac80211/ieee80211_i.h                                                   |     4 -
 net/mac80211/iface.c                                                         |     4 +-
 net/mac80211/key.c                                                           |    12 +-
 net/mac80211/main.c                                                          |     3 +
 net/mac80211/mesh.c                                                          |     2 +
 net/mac80211/mesh_hwmp.c                                                     |     1 +
 net/mac80211/mesh_pathtbl.c                                                  |    34 +-
 net/mac80211/mesh_plink.c                                                    |     2 +-
 net/mac80211/mlme.c                                                          |    10 +-
 net/mac80211/offchannel.c                                                    |     4 +-
 net/mac80211/rx.c                                                            |    17 +-
 net/mac80211/tdls.c                                                          |     6 +-
 net/mac80211/tx.c                                                            |     4 +-
 net/mac80211/util.c                                                          |    19 +-
 net/mac80211/wme.c                                                           |     1 +
 net/mac80211/wpa.c                                                           |    16 +-
 net/mpls/af_mpls.c                                                           |    15 +-
 net/ncsi/ncsi-aen.c                                                          |    35 +-
 net/netfilter/Kconfig                                                        |    33 +
 net/netfilter/Makefile                                                       |     9 +-
 net/netfilter/core.c                                                         |   263 ++-
 net/netfilter/ipset/ip_set_bitmap_gen.h                                      |    10 +-
 net/netfilter/ipset/ip_set_bitmap_ip.c                                       |     8 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c                                    |     8 +-
 net/netfilter/ipset/ip_set_bitmap_port.c                                     |     8 +-
 net/netfilter/ipset/ip_set_core.c                                            |    36 +-
 net/netfilter/ipset/ip_set_hash_gen.h                                        |    38 +-
 net/netfilter/ipset/ip_set_list_set.c                                        |    21 +-
 net/netfilter/ipvs/ip_vs_app.c                                               |     1 -
 net/netfilter/ipvs/ip_vs_conn.c                                              |     4 +-
 net/netfilter/ipvs/ip_vs_core.c                                              |    12 +-
 net/netfilter/ipvs/ip_vs_ctl.c                                               |     3 -
 net/netfilter/ipvs/ip_vs_proto_tcp.c                                         |     1 +
 net/netfilter/ipvs/ip_vs_proto_udp.c                                         |     1 +
 net/netfilter/nf_conncount.c                                                 |   373 ++++
 net/netfilter/nf_conntrack_core.c                                            |    26 +-
 net/netfilter/nf_conntrack_expect.c                                          |     1 -
 net/netfilter/nf_conntrack_h323_asn1.c                                       |    40 +-
 net/netfilter/nf_conntrack_h323_main.c                                       |    77 +-
 net/netfilter/nf_conntrack_netlink.c                                         |    22 +-
 net/netfilter/nf_conntrack_proto.c                                           |    18 +-
 net/netfilter/nf_conntrack_proto_dccp.c                                      |    21 +-
 net/netfilter/nf_conntrack_proto_generic.c                                   |     4 +-
 net/netfilter/nf_conntrack_proto_gre.c                                       |     4 +-
 net/netfilter/nf_conntrack_proto_sctp.c                                      |    21 +-
 net/netfilter/nf_conntrack_proto_tcp.c                                       |    25 +-
 net/netfilter/nf_conntrack_proto_udp.c                                       |    10 +-
 net/netfilter/nf_conntrack_standalone.c                                      |    14 +-
 net/netfilter/nf_flow_table.c                                                |   429 ++++
 net/netfilter/nf_flow_table_inet.c                                           |    48 +
 net/netfilter/nf_internals.h                                                 |     2 +-
 net/netfilter/nf_log.c                                                       |     1 -
 net/netfilter/nf_queue.c                                                     |    96 +-
 net/netfilter/nf_synproxy_core.c                                             |     1 -
 net/netfilter/nf_tables_api.c                                                |  1668 ++++++++++-----
 net/netfilter/nf_tables_inet.c                                               |    88 +-
 net/netfilter/nf_tables_netdev.c                                             |    87 +-
 net/netfilter/nfnetlink.c                                                    |     4 -
 net/netfilter/nfnetlink_acct.c                                               |     2 -
 net/netfilter/nfnetlink_cttimeout.c                                          |     2 -
 net/netfilter/nfnetlink_log.c                                                |     1 -
 net/netfilter/nfnetlink_queue.c                                              |    10 +-
 net/netfilter/nft_cmp.c                                                      |     2 +
 net/netfilter/nft_compat.c                                                   |    26 +-
 net/netfilter/nft_ct.c                                                       |    16 +-
 net/netfilter/nft_dynset.c                                                   |     4 +-
 net/netfilter/nft_flow_offload.c                                             |   264 +++
 net/netfilter/nft_log.c                                                      |     4 +-
 net/netfilter/nft_masq.c                                                     |     2 +-
 net/netfilter/nft_meta.c                                                     |    45 +-
 net/netfilter/nft_nat.c                                                      |     2 +-
 net/netfilter/nft_redir.c                                                    |     2 +-
 net/netfilter/nft_rt.c                                                       |    15 +-
 net/netfilter/nft_set_hash.c                                                 |    10 +-
 net/netfilter/utils.c                                                        |    90 +
 net/netfilter/x_tables.c                                                     |    41 +-
 net/netfilter/xt_TCPMSS.c                                                    |     5 +-
 net/netfilter/xt_addrtype.c                                                  |    15 +-
 net/netfilter/xt_connlimit.c                                                 |   369 +---
 net/netfilter/xt_hashlimit.c                                                 |     5 +-
 net/netfilter/xt_ipcomp.c                                                    |     2 +-
 net/netfilter/xt_policy.c                                                    |     3 +-
 net/netfilter/xt_set.c                                                       |   119 +-
 net/netlink/af_netlink.c                                                     |    72 +-
 net/netlink/diag.c                                                           |     8 +-
 net/netrom/af_netrom.c                                                       |     1 -
 net/netrom/nr_route.c                                                        |     2 -
 net/openvswitch/conntrack.c                                                  |     4 +-
 net/openvswitch/flow.c                                                       |     6 +-
 net/openvswitch/flow_netlink.c                                               |    56 +-
 net/openvswitch/meter.c                                                      |     2 +-
 net/openvswitch/vport-internal_dev.c                                         |    10 +-
 net/packet/af_packet.c                                                       |     4 +-
 net/phonet/pn_netlink.c                                                      |    21 +-
 net/phonet/socket.c                                                          |     2 -
 net/qrtr/qrtr.c                                                              |     8 +-
 net/rds/bind.c                                                               |     1 +
 net/rds/cong.c                                                               |    10 +-
 net/rds/connection.c                                                         |    27 +-
 net/rds/rds.h                                                                |    10 +-
 net/rds/send.c                                                               |    37 +-
 net/rds/tcp.c                                                                |    81 +-
 net/rds/tcp.h                                                                |     1 +
 net/rds/tcp_connect.c                                                        |     2 +-
 net/rds/tcp_recv.c                                                           |     8 +-
 net/rds/tcp_send.c                                                           |     5 +-
 net/rds/threads.c                                                            |    20 +-
 net/rose/af_rose.c                                                           |     1 -
 net/rose/rose_route.c                                                        |     3 -
 net/rxrpc/proc.c                                                             |     2 -
 net/sched/Kconfig                                                            |     3 -
 net/sched/act_api.c                                                          |     2 +-
 net/sched/act_bpf.c                                                          |    10 +-
 net/sched/act_connmark.c                                                     |     8 +-
 net/sched/act_csum.c                                                         |    74 +-
 net/sched/act_gact.c                                                         |     8 +-
 net/sched/act_ife.c                                                          |    18 +-
 net/sched/act_ipt.c                                                          |    18 +-
 net/sched/act_mirred.c                                                       |    27 +-
 net/sched/act_nat.c                                                          |     8 +-
 net/sched/act_pedit.c                                                        |    10 +-
 net/sched/act_police.c                                                       |    12 +-
 net/sched/act_sample.c                                                       |    10 +-
 net/sched/act_simple.c                                                       |    10 +-
 net/sched/act_skbedit.c                                                      |     8 +-
 net/sched/act_skbmod.c                                                       |    10 +-
 net/sched/act_tunnel_key.c                                                   |    10 +-
 net/sched/act_vlan.c                                                         |    10 +-
 net/sched/cls_api.c                                                          |   695 ++++--
 net/sched/cls_basic.c                                                        |    16 +-
 net/sched/cls_bpf.c                                                          |    58 +-
 net/sched/cls_cgroup.c                                                       |    12 +-
 net/sched/cls_flow.c                                                         |    12 +-
 net/sched/cls_flower.c                                                       |    54 +-
 net/sched/cls_fw.c                                                           |    19 +-
 net/sched/cls_matchall.c                                                     |    35 +-
 net/sched/cls_route.c                                                        |    16 +-
 net/sched/cls_rsvp.h                                                         |     9 +-
 net/sched/cls_tcindex.c                                                      |    17 +-
 net/sched/cls_u32.c                                                          |   133 +-
 net/sched/sch_api.c                                                          |   305 ++-
 net/sched/sch_atm.c                                                          |    23 +-
 net/sched/sch_cbq.c                                                          |    78 +-
 net/sched/sch_cbs.c                                                          |    31 +-
 net/sched/sch_choke.c                                                        |     8 +-
 net/sched/sch_codel.c                                                        |     8 +-
 net/sched/sch_drr.c                                                          |    40 +-
 net/sched/sch_dsmark.c                                                       |    19 +-
 net/sched/sch_fifo.c                                                         |    11 +-
 net/sched/sch_fq.c                                                           |     8 +-
 net/sched/sch_fq_codel.c                                                     |    13 +-
 net/sched/sch_generic.c                                                      |   545 +++--
 net/sched/sch_gred.c                                                         |    13 +-
 net/sched/sch_hfsc.c                                                         |    28 +-
 net/sched/sch_hhf.c                                                          |     8 +-
 net/sched/sch_htb.c                                                          |    29 +-
 net/sched/sch_ingress.c                                                      |    99 +-
 net/sched/sch_mq.c                                                           |    42 +-
 net/sched/sch_mqprio.c                                                       |    76 +-
 net/sched/sch_multiq.c                                                       |    19 +-
 net/sched/sch_netem.c                                                        |    10 +-
 net/sched/sch_pie.c                                                          |     8 +-
 net/sched/sch_plug.c                                                         |     6 +-
 net/sched/sch_prio.c                                                         |    81 +-
 net/sched/sch_qfq.c                                                          |    22 +-
 net/sched/sch_red.c                                                          |    65 +-
 net/sched/sch_sfb.c                                                          |    20 +-
 net/sched/sch_sfq.c                                                          |     8 +-
 net/sched/sch_tbf.c                                                          |    21 +-
 net/sched/sch_teql.c                                                         |     3 +-
 net/sctp/Kconfig                                                             |    12 -
 net/sctp/Makefile                                                            |     5 +-
 net/sctp/associola.c                                                         |     2 +-
 net/sctp/chunk.c                                                             |     8 +-
 net/sctp/endpointola.c                                                       |     2 +-
 net/sctp/output.c                                                            |     5 +-
 net/sctp/outqueue.c                                                          |    12 +-
 net/sctp/probe.c                                                             |   244 ---
 net/sctp/proc.c                                                              |     7 +-
 net/sctp/sm_make_chunk.c                                                     |    72 +-
 net/sctp/sm_sideeffect.c                                                     |    51 +-
 net/sctp/sm_statefuns.c                                                      |    50 +-
 net/sctp/sm_statetable.c                                                     |     5 +-
 net/sctp/socket.c                                                            |   160 +-
 net/sctp/stream.c                                                            |    47 +-
 net/sctp/stream_interleave.c                                                 |  1334 ++++++++++++
 net/sctp/stream_sched.c                                                      |     3 +-
 net/sctp/sysctl.c                                                            |     7 +
 net/sctp/ulpevent.c                                                          |    15 +-
 net/sctp/ulpqueue.c                                                          |    23 +-
 net/smc/af_smc.c                                                             |   231 +-
 net/smc/smc.h                                                                |     5 +-
 net/smc/smc_cdc.c                                                            |    52 +-
 net/smc/smc_cdc.h                                                            |     1 -
 net/smc/smc_clc.c                                                            |    84 +-
 net/smc/smc_clc.h                                                            |    34 +-
 net/smc/smc_close.c                                                          |   208 +-
 net/smc/smc_close.h                                                          |     2 -
 net/smc/smc_core.c                                                           |    17 +-
 net/smc/smc_diag.c                                                           |     6 +-
 net/smc/smc_ib.c                                                             |    38 +-
 net/smc/smc_rx.c                                                             |     5 +-
 net/smc/smc_tx.c                                                             |    32 +-
 net/smc/smc_wr.c                                                             |    50 +-
 net/smc/smc_wr.h                                                             |     2 -
 net/socket.c                                                                 |   301 +--
 net/tipc/bcast.c                                                             |    12 +-
 net/tipc/core.h                                                              |     1 -
 net/tipc/group.c                                                             |   371 ++--
 net/tipc/group.h                                                             |    10 +-
 net/tipc/link.c                                                              |     2 +-
 net/tipc/msg.c                                                               |    51 +-
 net/tipc/msg.h                                                               |     3 +-
 net/tipc/name_table.c                                                        |    57 +-
 net/tipc/name_table.h                                                        |     9 +-
 net/tipc/server.c                                                            |    76 +-
 net/tipc/server.h                                                            |    13 +-
 net/tipc/socket.c                                                            |   114 +-
 net/tipc/subscr.c                                                            |    35 +-
 net/tipc/subscr.h                                                            |     2 +-
 net/tls/tls_sw.c                                                             |     8 +-
 net/unix/af_unix.c                                                           |     1 -
 net/wireless/ibss.c                                                          |     5 +
 net/wireless/mlme.c                                                          |     6 +-
 net/wireless/nl80211.c                                                       |    68 +-
 net/wireless/scan.c                                                          |     5 +
 net/wireless/trace.h                                                         |    12 +-
 net/wireless/wext-core.c                                                     |    13 +-
 net/wireless/wext-proc.c                                                     |     1 -
 net/xfrm/xfrm_device.c                                                       |   199 +-
 net/xfrm/xfrm_input.c                                                        |     1 -
 net/xfrm/xfrm_output.c                                                       |     2 +-
 net/xfrm/xfrm_policy.c                                                       |   137 +-
 net/xfrm/xfrm_proc.c                                                         |     1 -
 net/xfrm/xfrm_replay.c                                                       |     5 +-
 net/xfrm/xfrm_state.c                                                        |     7 +
 samples/bpf/Makefile                                                         |    14 +-
 samples/bpf/tcbpf2_kern.c                                                    |   170 +-
 samples/bpf/test_cgrp2_attach2.c                                             |    36 +-
 samples/bpf/test_override_return.sh                                          |    15 +
 samples/bpf/test_tunnel_bpf.sh                                               |   128 +-
 samples/bpf/tracex7_kern.c                                                   |    16 +
 samples/bpf/tracex7_user.c                                                   |    28 +
 samples/bpf/xdp2skb_meta.sh                                                  |   220 ++
 samples/bpf/xdp2skb_meta_kern.c                                              |   105 +
 samples/bpf/xdp_monitor_kern.c                                               |    96 +-
 samples/bpf/xdp_monitor_user.c                                               |   416 +++-
 samples/bpf/xdp_rxq_info_kern.c                                              |    96 +
 samples/bpf/xdp_rxq_info_user.c                                              |   531 +++++
 samples/sockmap/sockmap_user.c                                               |   392 +++-
 security/selinux/xfrm.c                                                      |     2 +-
 tools/bpf/Makefile                                                           |    29 +
 tools/bpf/bpf_jit_disasm.c                                                   |    14 +-
 tools/bpf/bpftool/Documentation/Makefile                                     |    30 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst                           |   118 ++
 tools/bpf/bpftool/Documentation/bpftool-map.rst                              |     8 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst                             |    16 +-
 tools/bpf/bpftool/Documentation/bpftool.rst                                  |    12 +-
 tools/bpf/bpftool/Makefile                                                   |    90 +-
 tools/bpf/bpftool/bash-completion/bpftool                                    |     8 +-
 tools/bpf/bpftool/cgroup.c                                                   |   308 +++
 tools/bpf/bpftool/common.c                                                   |   195 +-
 tools/bpf/bpftool/jit_disasm.c                                               |    23 +-
 tools/bpf/bpftool/main.c                                                     |    16 +-
 tools/bpf/bpftool/main.h                                                     |     9 +-
 tools/bpf/bpftool/map.c                                                      |    11 +-
 tools/bpf/bpftool/prog.c                                                     |   229 +-
 tools/build/feature/Makefile                                                 |     4 +
 tools/build/feature/test-disassembler-four-args.c                            |    15 +
 tools/include/uapi/linux/bpf.h                                               |   116 +-
 tools/include/uapi/linux/perf_event.h                                        |    22 +
 tools/lib/bpf/Makefile                                                       |    24 +-
 tools/lib/bpf/bpf.h                                                          |     2 +-
 tools/lib/bpf/libbpf.c                                                       |   200 +-
 tools/scripts/Makefile.include                                               |     1 +
 tools/testing/selftests/bpf/.gitignore                                       |     7 +
 tools/testing/selftests/bpf/Makefile                                         |    20 +-
 tools/testing/selftests/bpf/bpf_helpers.h                                    |     5 +-
 tools/testing/selftests/bpf/config                                           |     2 +
 tools/testing/selftests/bpf/sample_map_ret0.c                                |    34 +
 tools/testing/selftests/bpf/sample_ret0.c                                    |     7 +
 tools/testing/selftests/bpf/tcp_client.py                                    |    51 +
 tools/testing/selftests/bpf/tcp_server.py                                    |    83 +
 tools/testing/selftests/bpf/test_align.c                                     |   178 +-
 tools/testing/selftests/bpf/test_dev_cgroup.c                                |    11 +-
 tools/testing/selftests/bpf/test_l4lb_noinline.c                             |   473 +++++
 tools/testing/selftests/bpf/test_lpm_map.c                                   |   217 ++
 tools/testing/selftests/bpf/test_maps.c                                      |    32 +-
 tools/testing/selftests/bpf/test_offload.py                                  |  1085 ++++++++++
 tools/testing/selftests/bpf/test_progs.c                                     |   355 +++-
 tools/testing/selftests/bpf/test_stacktrace_map.c                            |    62 +
 tools/testing/selftests/bpf/test_tcpbpf.h                                    |    16 +
 tools/testing/selftests/bpf/test_tcpbpf_kern.c                               |   115 +
 tools/testing/selftests/bpf/test_tcpbpf_user.c                               |   126 ++
 tools/testing/selftests/bpf/test_tracepoint.c                                |    26 +
 tools/testing/selftests/bpf/test_verifier.c                                  |  2452 ++++++++++++++++++++-
 tools/testing/selftests/bpf/test_xdp_noinline.c                              |   833 ++++++++
 tools/testing/selftests/net/Makefile                                         |     1 +
 tools/testing/selftests/net/fib_tests.sh                                     |   429 ++++
 tools/testing/selftests/net/msg_zerocopy.c                                   |    21 +-
 tools/testing/selftests/net/rtnetlink.sh                                     |   229 ++
 tools/virtio/linux/kernel.h                                                  |     2 +-
 tools/virtio/linux/thread_info.h                                             |     1 +
 tools/virtio/ringtest/main.h                                                 |    59 +-
 tools/virtio/ringtest/ptr_ring.c                                             |     2 +-
 1666 files changed, 120609 insertions(+), 45689 deletions(-)
 create mode 100644 Documentation/ABI/testing/devlink-resource-mlxsw
 create mode 100644 Documentation/bpf/bpf_devel_QA.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt
 create mode 100644 Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 create mode 100644 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
 create mode 100644 Documentation/devicetree/bindings/net/socionext-netsec.txt
 rename Documentation/devicetree/bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt} (64%)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
 create mode 100644 Documentation/networking/can.rst
 delete mode 100644 Documentation/networking/can.txt
 create mode 100644 Documentation/networking/xfrm_device.txt
 create mode 100644 arch/x86/include/asm/error-injection.h
 create mode 100644 arch/x86/lib/error-inject.c
 delete mode 100644 drivers/net/ethernet/aquantia/atlantic/aq_nic_internal.h
 create mode 100644 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
 create mode 100644 drivers/net/ethernet/cavium/common/Makefile
 create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.c
 create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.h
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.c
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.h
 create mode 100644 drivers/net/ethernet/cortina/Kconfig
 create mode 100644 drivers/net/ethernet/cortina/Makefile
 create mode 100644 drivers/net/ethernet/cortina/gemini.c
 create mode 100644 drivers/net/ethernet/cortina/gemini.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
 rename drivers/net/ethernet/hisilicon/hns3/{hns3pf => }/hns3_dcbnl.c (97%)
 rename drivers/net/ethernet/hisilicon/hns3/{hns3pf => }/hns3_enet.c (89%)
 rename drivers/net/ethernet/hisilicon/hns3/{hns3pf => }/hns3_enet.h (94%)
 rename drivers/net/ethernet/hisilicon/hns3/{hns3pf => }/hns3_ethtool.c (70%)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/Makefile
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_rx_am.c
 create mode 100644 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
 create mode 100644 drivers/net/ethernet/netronome/nfp/bpf/fw.h
 create mode 100644 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.c
 create mode 100644 drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
 create mode 100644 drivers/net/ethernet/socionext/Kconfig
 create mode 100644 drivers/net/ethernet/socionext/Makefile
 create mode 100644 drivers/net/ethernet/socionext/netsec.c
 create mode 100644 drivers/net/ethernet/socionext/sni_ave.c
 create mode 100644 drivers/net/netdevsim/Makefile
 create mode 100644 drivers/net/netdevsim/bpf.c
 create mode 100644 drivers/net/netdevsim/netdev.c
 create mode 100644 drivers/net/netdevsim/netdevsim.h
 create mode 100644 drivers/net/wireless/ath/ath10k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath10k/coredump.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/22000.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/a000.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/debugfs.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/agg-rx.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/dma.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/dma.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mac80211.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mmio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_core.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_dfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_dfs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_dma.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_dma.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_eeprom.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_phy.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_trace.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_trace.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x2_tx.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/trace.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/trace.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/tx.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/util.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/util.h
 create mode 100644 include/asm-generic/error-injection.h
v create mode 100644 include/linux/error-injection.h
 create mode 100644 include/linux/net_dim.h
 create mode 100644 include/net/netfilter/nf_conntrack_count.h
 create mode 100644 include/net/netfilter/nf_flow_table.h
 create mode 100644 include/net/sctp/stream_interleave.h
 create mode 100644 include/net/xdp.h
 create mode 100644 include/trace/events/net_probe_common.h
 create mode 100644 include/trace/events/sctp.h
 rename net/batman-adv/packet.h => include/uapi/linux/batadv_packet.h (80%)
 create mode 100644 include/uapi/linux/erspan.h
 create mode 100644 include/uapi/linux/netfilter_ipv6/ip6t_srh.h
 create mode 100644 kernel/fail_function.c
 create mode 100644 lib/bucket_locks.c
 create mode 100644 lib/error-inject.c
 create mode 100644 net/core/xdp.c
 delete mode 100644 net/dccp/probe.c
 create mode 100644 net/dccp/trace.h
 create mode 100644 net/ipv4/netfilter/nf_flow_table_ipv4.c
 create mode 100644 net/ipv4/netfilter/nf_nat_snmp_basic.asn1
 delete mode 100644 net/ipv4/netfilter/nf_nat_snmp_basic.c
 create mode 100644 net/ipv4/netfilter/nf_nat_snmp_basic_main.c
 delete mode 100644 net/ipv4/tcp_probe.c
 create mode 100644 net/ipv6/netfilter/ip6t_srh.c
 create mode 100644 net/ipv6/netfilter/nf_flow_table_ipv6.c
 create mode 100644 net/netfilter/nf_conncount.c
 create mode 100644 net/netfilter/nf_flow_table.c
 create mode 100644 net/netfilter/nf_flow_table_inet.c
 create mode 100644 net/netfilter/nft_flow_offload.c
 create mode 100644 net/netfilter/utils.c
 delete mode 100644 net/sctp/probe.c
 create mode 100644 net/sctp/stream_interleave.c
 create mode 100755 samples/bpf/test_override_return.sh
 create mode 100644 samples/bpf/tracex7_kern.c
 create mode 100644 samples/bpf/tracex7_user.c
 create mode 100755 samples/bpf/xdp2skb_meta.sh
 create mode 100644 samples/bpf/xdp2skb_meta_kern.c
 create mode 100644 samples/bpf/xdp_rxq_info_kern.c
 create mode 100644 samples/bpf/xdp_rxq_info_user.c
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
 create mode 100644 tools/bpf/bpftool/cgroup.c
 create mode 100644 tools/build/feature/test-disassembler-four-args.c
 create mode 100644 tools/testing/selftests/bpf/sample_map_ret0.c
 create mode 100644 tools/testing/selftests/bpf/sample_ret0.c
 create mode 100755 tools/testing/selftests/bpf/tcp_client.py
 create mode 100755 tools/testing/selftests/bpf/tcp_server.py
 create mode 100644 tools/testing/selftests/bpf/test_l4lb_noinline.c
 create mode 100755 tools/testing/selftests/bpf/test_offload.py
 create mode 100644 tools/testing/selftests/bpf/test_stacktrace_map.c
 create mode 100644 tools/testing/selftests/bpf/test_tcpbpf.h
 create mode 100644 tools/testing/selftests/bpf/test_tcpbpf_kern.c
 create mode 100644 tools/testing/selftests/bpf/test_tcpbpf_user.c
 create mode 100644 tools/testing/selftests/bpf/test_tracepoint.c
 create mode 100644 tools/testing/selftests/bpf/test_xdp_noinline.c
 create mode 100755 tools/testing/selftests/net/fib_tests.sh
 create mode 100644 tools/virtio/linux/thread_info.h
