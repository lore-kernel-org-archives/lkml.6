Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeDBRNW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:13:22 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:43750 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbeDBRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:13:18 -0400
X-Google-Smtp-Source: AIpwx48ienUNgXgoE7cHZ3nJwKs9FCXCt4sHWre3+rV6KqQ4plsUmoTFrDDMSLEr5vlGH55EWuCjYg==
Date: Mon, 2 Apr 2018 10:13:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute 4.16
Message-ID: <20180402101315.2de41a60@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w32HDSVO024670

Release of iproute2 for Linux 4.16

Lastest version iproute2 utility to support new features in Linux 4.16.
This release covers a wide range of small changes. Lots of changes to:
bpf, vrf, devlink, flower, and rdma support. Also more changes to
ss and JSON support enhancements.

The tarball can be dowloaded from:
  https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-4.16.0.tar.gz

The upstream repositories for master and net-next branch are now
split. Master branch is at:
  git://git.kernel.org/pub/scm/network/iproute2/iproute2.gti

and patches for next release are in (master branch):
  git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

There are symlinks so that old paths still work.


Report problems (or enhancements) to the netdev@vger.kernel.org mailing list.

---
Adam Vyskovsky (1):
      tc: fix an off-by-one error while printing tc actions

Alexander Alemayhu (4):
      man: add examples to ip.8
      man: fix man page warnings
      tc: bpf: add ppc64 and sparc64 to list of archs with eBPF support
      examples/bpf: update list of examples

Alexander Aring (5):
      tc: m_ife: allow ife type to zero
      tc: m_ife: print IEEE ethertype format
      tc: m_ife: report about kernels default type
      man: tc-ife: add default type note
      tc: m_ife: fix match tcindex parsing

Alexander Heinlein (1):
      ip/xfrm: Fix deleteall when having many policies installed

Alexander Zubkov (5):
      iproute: list/flush/save filter also by metric
      iproute: "list/flush/save default" selected all of the routes
      treat "default" and "all"/"any" addresses differenty
      treat "default" and "all"/"any" addresses differenty
      arrange prefix parsing code after redundant patches

Alexey Kodanev (1):
      fix typo in ip-xfrm man page, rmd610 -> rmd160

Amir Vadai (14):
      libnetlink: Introduce rta_getattr_be*()
      tc/cls_flower: Classify packet in ip tunnels
      tc/act_tunnel: Introduce ip tunnel action
      tc/pedit: Fix a typo in pedit usage message
      tc/pedit: Extend pedit to specify offset relative to mac/transport headers
      tc/pedit: Introduce 'add' operation
      tc/pedit: p_ip: introduce editing ttl header
      tc/pedit: Support fields bigger than 32 bits
      tc/pedit: p_eth: ETH header editor
      tc/pedit: p_tcp: introduce pedit tcp support
      pedit: Fix a typo in warning
      pedit: Do not allow using retain for too big fields
      pedit: Check for extended capability in protocol parser
      pedit: Introduce ipv6 support

Amritha Nambiar (4):
      tc/mqprio: Offload mode and shaper options in mqprio
      flower: Represent HW traffic classes as classid values
      man: tc-mqprio: add documentation for new offload options
      man: tc-flower: add explanation for hw_tc option

Andreas Henriksson (1):
      ss: fix help/man TCP-STATE description for listening

Antonio Quartulli (2):
      ss: fix crash when skipping disabled header field
      ss: fix NULL pointer access when parsing unix sockets with oldformat

Arkadi Sharshevsky (15):
      devlink: Change netlink attribute validation
      devlink: Add support for pipeline debug (dpipe)
      bridge: Distinguish between externally learned vs offloaded FDBs
      devlink: Make match/action parsing more flexible
      devlink: Add support for special format protocol headers
      devlink: Add support for protocol IPv4/IPv6/Ethernet special formats
      devlink: Ignore unknown attributes
      devlink: Change empty line indication with indentations
      devlink: mnlg: Add support for extended ack
      devlink: Add support for devlink resource abstraction
      devlink: Add support for hot reload
      devlink: Move dpipe context from heap to stack
      devlink: Add support for resource/dpipe relation
      devlink: Update man pages and add resource man
      devlink: Fix error reporting

Asbjørn Sloth Tønnesen (2):
      testsuite: refactor kernel config search
      testsuite: search for kernel config in /boot

Baruch Siach (3):
      tc: add missing limits.h header
      ip: include libc headers first
      lib: fix multiple strlcpy definition

Benjamin LaHaise (2):
      f_flower: don't set TCA_FLOWER_KEY_ETH_TYPE for "protocol all"
      tc: flower: support for matching MPLS labels

Boris Pismenny (1):
      ip xfrm: Add xfrm state crypto offload

Casey Callendrello (1):
      netns: make /var/run/netns bind-mount recursive

Chris Mi (3):
      tc: fix command "tc actions del" hang issue
      lib/libnetlink: Add a new function rtnl_talk_iov
      tc: Add batchsize feature for filter and actions

Christian Brauner (1):
      netns: allow negative nsid

Christian Ehrhardt (2):
      tests: read limited amount from /dev/urandom
      tests: make sure rand_dev suffix has 6 chars

Christoph Paasch (1):
      ip: add fastopen_no_cookie option to ip route

Craig Gallek (2):
      gre6: fix copy/paste bugs in GREv6 attribute manipulation
      iplink: Expose IFLA_*_FWMARK attributes for supported link types

Cyrill Gorcunov (2):
      libnetlink: Add test for error code returned from netlink reply
      ss: Add inet raw sockets information gathering via netlink diag interface

Daniel Borkmann (19):
      bpf: make tc's bpf loader generic and move into lib
      bpf: check for owner_prog_type and notify users when differ
      bpf: add initial support for attaching xdp progs
      {f,m}_bpf: dump tag over insns
      bpf: test for valid type in bpf_get_work_dir
      bpf: add support for generic xdp
      bpf: update printing of generic xdp mode
      bpf: dump error to the user when retrieving pinned prog fails
      bpf: indicate lderr when bpf_apply_relo_data fails
      bpf: remove obsolete samples
      bpf: support loading map in map from obj
      bpf: dump id/jited info for cls/act programs
      bpf: improve error reporting around tail calls
      bpf: fix mnt path when from env
      bpf: unbreak libelf linkage for bpf obj loader
      bpf: minor cleanups for bpf_trace_pipe
      bpf: consolidate dumps to use bpf_dump_prog_info
      json: move json printer to common library
      bpf: properly output json for xdp

David Ahern (46):
      Makefile: really suppress printing of directories
      lib bpf: Add support for BPF_PROG_ATTACH and BPF_PROG_DETACH
      bpf: export bpf_prog_load
      bpf: Add BPF_ macros
      move cmd_exec to lib utils
      Add filesystem APIs to lib
      change name_is_vrf to return index
      libnetlink: Add variant of rtnl_talk that does not display RTNETLINK answers error
      Introduce ip vrf command
      Fix compile warning in get_addr_1
      ip vrf: Move kernel config hint to prog_load failure
      ip vrf: Refactor ipvrf_identify
      ip vrf: Fix reset to default VRF
      ip netns: Reset vrf to default VRF on namespace switch
      ip vrf: Fix run-on error message on mkdir failure
      ip vrf: Improve cgroup2 error messages
      ip vrf: Improve bpf error messages
      Add support for rt_protos.d
      rttable: Fix invalid range checking when table id is converted to u32
      ip route: error out on multiple via without nexthop keyword
      ip route: Make name of protocol 0 consistent
      ip vrf: Handle vrf in a cgroup hierarchy
      ip netns: refactor netns_identify
      ip vrf: Handle VRF nesting in namespace
      ip vrf: Detect invalid vrf name in pids command
      ip: Add support for MPLS netconf
      ip route: Add missing space between nexthop and via for mpls multipath routes
      netlink: Add flag to suppress print of nlmsg error
      ip netconf: Show all address families by default in dumps
      ip netconf: show all families on dev request
      ip vrf: Add command name next to pid
      ip vrf: Add command name next to pid
      ip: mpls: fix printing of mpls labels
      ip: add support for more MPLS labels
      netlink: Change rtnl_dump_done to always show error
      ip address: Export ip_linkaddr_list
      ip address: Move filter struct to ip_common.h
      ip address: Change print_linkinfo_brief to take filter as an input
      ip vrf: Add show command
      lib: Dump ext-ack string by default
      libnetlink: Fix extack attribute parsing
      libnetlink: Handle extack messages for non-error case
      Update headers from 4.15-rc3
      Restore --no-print-directory option for silent builds
      Update kernel headers to 4.15-rc8
      libnetlink: __rtnl_talk_iov should only loop max iovlen times

David Forster (1):
      ip6tunnel: Align ipv6 tunnel key display with ipv4

David Lebrun (9):
      ip: add ip sr command to control SR-IPv6 internal structures
      iproute: add support for SR-IPv6 lwtunnel encapsulation
      man: add documentation for IPv6 SR commands
      iproute: fix compilation issue with older glibc
      iproute: add helper functions for SRH processing
      iproute: add support for SRv6 local segment processing
      man: add documentation for seg6local lwt
      iproute: add support for seg6 l2encap mode
      man: add documentation for seg6 l2encap mode

David Michael (1):
      tc: make tc linking depend on libtc.a

Davide Caratti (4):
      tc: m_csum: add support for SCTP checksum
      tc: fix typo in tc-tcindex man page
      tc: bash-completion: add missing 'classid' keyword
      tc: fix parsing of the control action

Donald Sharp (2):
      ip: mroute: Add table output to show command
      ip: Properly display AF_BRIDGE address information for neighbor events

Eli Cohen (1):
      iplink: Update usage in help message

Eric Dumazet (2):
      ss: print tcpi_rcv_mss and tcpi_advmss
      tc: fq: support low_rate_threshold attribute

Filip Moc (1):
      ip fou: pass family attribute as u8

Gal Pressman (3):
      iplink: Validate minimum tx rate is less than maximum tx rate
      ipaddress: Make sure VF min/max rate API is supported before using it
      man: Document the meaning of zero in min/max_tx_rate parameters

Girish Moodalbail (2):
      vxlan: Add support for modifying vxlan device attributes
      geneve: support for modifying geneve device

Greg Greenway (1):
      Add "show" subcommand to "ip fou"

Hadar Hen Zion (4):
      tc/cls_flower: Add dest UDP port to tunnel params
      tc/m_tunnel_key: Add dest UDP port to tunnel key action
      tc/cls_flower: Add to the usage encapsulation dest UDP port
      tc/m_tunnel_key: Add to the usage encapsulation dest UDP port

Hangbin Liu (12):
      iplink: bridge: add support for IFLA_BR_FDB_FLUSH
      iplink: bridge: add support for IFLA_BR_VLAN_STATS_ENABLED
      iplink: bridge: add support for IFLA_BR_MCAST_STATS_ENABLED
      iplink: bridge: add support for IFLA_BR_MCAST_IGMP_VERSION
      iplink: bridge: add support for IFLA_BR_MCAST_MLD_VERSION
      iplink: bridge_slave: add support for IFLA_BRPORT_FLUSH
      man: ip-link.8: Document bridge_slave fdb_flush option
      man: ip-link.8: Document bridge_slave fdb_flush option
      ip neigh: allow flush FAILED neighbour entry
      utils: return default family when rtm_family is not RTNL_FAMILY_IPMR/IP6MR
      lib/libnetlink: re malloc buff if size is not enough
      lib/libnetlink: update rtnl_talk to support malloc buff at run time

Ido Schimmel (1):
      iproute: Display offload indication per-nexthop

Ivan Delalande (2):
      utils: add print_escape_buf to format and print arbitrary bytes
      ss: print MD5 signature keys configured on TCP sockets

Ivan Vecera (2):
      lib: make resolve_hosts variable common
      devlink: add batch command support

Jakub Kicinski (22):
      bpf: print xdp offloaded mode
      bpf: add xdpdrv for requesting XDP driver mode
      bpf: allow requesting XDP HW offload
      bpf: initialize the verifier log
      bpf: pass program type in struct bpf_cfg_in
      bpf: keep parsed program mode in struct bpf_cfg_in
      bpf: allocate opcode table in struct bpf_cfg_in
      bpf: split parse from program loading
      bpf: rename bpf_parse_common() to bpf_parse_and_load_common()
      bpf: expose bpf_parse_common() and bpf_load_common()
      bpf: allow loading programs for a specific ifindex
      {f, m}_bpf: don't allow specifying multiple bpf programs
      tc_filter: resolve device name before parsing filter
      f_bpf: communicate ifindex for eBPF offload
      iplink: communicate ifindex for xdp offload
      ip: link: add support for netdevsim device type
      tc: red: allow setting th_min and th_max to the same value
      bpf: support map offload
      tc: red: JSON-ify RED output
      tc: prio: JSON-ify prio output
      ip: address: fix stats64 JSON object name
      tc: fix second printing of requeues

Jakub Sitnicki (1):
      iproute: Remove useless check for nexthop keyword when setting RTA_OIF

Jamal Hadi Salim (6):
      utils: make hex2mem available to all users
      actions: Add support for user cookies
      tc actions: Improved batching and time filtered dumping
      actions: update the man page to describe the "since" time filter
      tc/actions: introduce support for jump action
      tc: Fix filter protocol output

Jean-Philippe Brucker (1):
      ss: fix NULL dereference when rendering without header

Jesus Sanchez-Palencia (1):
      man: Clarify idleslope calculation for tc-cbs

Jiri Benc (3):
      Revert "man pages: add man page for skbmod action"
      tc: m_tunnel_key: reformat the usage text
      tc: m_tunnel_key: add csum/nocsum option

Jiri Kosina (2):
      iproute2: tc: introduce build dependency on libnetlink
      iproute2: add support for invisible qdisc dumping

Jiri Pirko (28):
      devlink: use DEVLINK_CMD_ESWITCH_* instead of DEVLINK_CMD_ESWITCH_MODE_*
      tc_filter: add support for chain index
      tc: actions: add helpers to parse and print control actions
      tc/actions: introduce support for goto chain action
      tc: flower: add support for tcp flags
      tc: gact: fix control action parsing
      tc: add support for TRAP action
      tc: don't print error message on miss when parsing action with default
      tc: move action cookie print out of the stats if
      tc: remove action cookie len from printout
      tc: jsonify qdisc core
      tc: jsonify stats2
      tc: jsonify fq_codel qdisc
      tc: jsonify htb qdisc
      tc: jsonify filter core
      tc: jsonify flower filter
      tc: jsonify matchall filter
      tc: jsonify actions core
      tc: jsonify gact action
      tc: jsonify mirred action
      tc: jsonify vlan action
      man: add -json option to tc manpage
      tc: fix json array closing
      tc: introduce tc_qdisc_block_exists helper
      tc: introduce support for block-handle for filter operations
      tc: implement ingress/egress block index attributes for qdiscs
      devlink: fix port new monitoring message typo
      man: fix devlink object list

Joe Stringer (1):
      bpf: Print section name when hitting non ld64 issue

Jon Maloy (1):
      tipc: change family attribute from u32 to u16

Julien Fortin (31):
      ip: vfinfo: remove code duplication for IFLA_VF_RSS_QUERY_EN
      color: add new COLOR_NONE and disable_color function
      ip: add new command line argument -json (mutually exclusive with -color)
      json_writer: add new json handlers (null, float with format, lluint, hu)
      ip: ip_print: add new API to print JSON or regular format output
      ip: ipaddress.c: add support for json output
      ip: iplink.c: open/close json obj for ip -brief -json link show dev DEV
      ip: iplink_bond.c: add json output support
      ip: iplink_bond_slave.c: add json output support (info_slave_data)
      ip: iplink_hsr.c: add json output support
      ip: iplink_bridge.c: add json output support
      ip: iplink_bridge_slave.c: add json output support
      ip: iplink_can.c: add json output support
      ip: iplink_geneve.c: add json output support
      ip: iplink_ipoib.c: add json output support
      ip: iplink_ipvlan.c: add json output support
      ip: iplink_vrf.c: add json output support
      ip: iplink_vxlan.c: add json output support
      ip: iplink_xdp.c: add json output support
      ip: ipmacsec.c: add json output support
      ip: link_gre.c: add json output support
      ip: link_gre6.c: add json output support
      ip: link_ip6tnl.c: add json output support
      ip: link_iptnl.c: add json output support
      ip: link_vti.c: add json output support
      ip: link_vti6.c: add json output support
      ip: link_macvlan.c: add json output support
      ip: iplink_vlan.c: add json output support
      ip: ipaddress: fix missing space after prefixlen
      lib: json_print: rework 'new_json_obj' drop FILE* argument
      lib: json_print: rework 'new_json_obj' drop FILE* argument

Khem Raj (1):
      tc: include stdint.h explicitly for UINT16_MAX

Krister Johansen (3):
      iptunnel: document mode parameter for sit tunnels
      iptunnel: add support for mpls/ip to sit tunnels
      iptunnel: add support for mpls/ip to ipip tunnels

Leon Romanovsky (30):
      devlink: Call dl_free in early exit case
      utils: Move BIT macro to common header
      rdma: Add basic infrastructure for RDMA tool
      rdma: Add dev object
      rdma: Add link object
      rdma: Add json and pretty outputs
      rdma: Implement json output for dev object
      rdma: Add json output to link object
      rdma: Add initial manual for the tool
      ip: Fix compilation break on old systems
      rdma: Reduce scope of _dev_map_lookup call
      rdma: Protect dev_map_lookup from wrong input
      rdma: Move per-device handler function to generic code
      rdma: Fix misspelled SYS_IMAGE_GUID
      rdma: Check that port index exists before operate on link layer
      rdma: Print supplied device name in case of wrong name
      rdma: Get rid of dev_map_free call
      rdma: Rename free function to be rd_cleanup
      rdma: Rename rd_free_devmap to be rd_free
      rdma: Move link execution logic to common code
      rdma: Add option to provide "-" sign for the port number
      rdma: Make visible the number of arguments
      rdma: Add filtering infrastructure
      rdma: Set pointer to device name position
      rdma: Allow external usage of compare string routine
      rdma: Add resource tracking summary
      rdma: Add QP resource tracking information
      rdma: Document resource tracking
      rdma: Check return value of strdup call
      rdma: Avoid memory leak for skipper resource

Lorenzo Colitti (3):
      ip: support UID range routing.
      iproute: build more easily on Android
      iproute2: fixes to compile on some systems.

Lubomir Rintel (1):
      lib/namespace: don't try to mount rw /sys over a ro one

Luca Boccassi (6):
      man: drop references to Debian-specific paths
      man: add more keywords to ip.8 short description
      man: ip-address: document 15-char limit for LABEL
      man: routel/routef: don't mention filesystem paths
      man: fix small formatting errors
      Drop capabilities if not running ip exec vrf with libcap

Lucas Bates (2):
      man page: add page for skbmod action
      Add new man page for tc actions.

Lukas Braun (1):
      man: ip-route.8: Mention that lower metric means higher priority

Mahesh Bandewar (1):
      ip/ipvlan: enhance ability to add mode flags to existing modes

Martin KaFai Lau (1):
      bpf: Add support for IFLA_XDP_PROG_ID

Masatake YAMATO (1):
      ss: prepare rth when killing inet sock

Matteo Croce (3):
      tc: fix typo in manpage
      netns: avoid directory traversal
      netns: more input validation

Matthias Schiffer (1):
      devlink, rdma, tipc: properly define TARGETS without HAVE_MNL

Michal Kubecek (4):
      iplink: check for message truncation in iplink_get()
      iplink: double the buffer size also in iplink_get()
      ip xfrm: use correct key length for netlink message
      ip maddr: fix filtering by device

Michal Kubeček (1):
      routel: fix infinite loop in line parser

Michal Privoznik (1):
      tc: util: Don't call NEXT_ARG_FWD() in __parse_action_control()

Mike Frysinger (2):
      mark shell scripts +x
      ifcfg/rtpr: convert to POSIX shell

Neal Cardwell (1):
      ss: print new tcp_info fields: delivery_rate and app_limited

Nicolas Dichtel (1):
      link_gre6: really support encaplimit option

Nikhil Gajendrakumar (1):
      bridge: this patch adds json support for bridge mdb show

Nikolay Aleksandrov (7):
      bridge: fdb: add state filter support
      ipmroute: add support for RTNH_F_UNRESOLVED
      iplink: add support for xstats subcommand
      iplink: bridge: add support for displaying xstats
      iplink: bridge_slave: add support for displaying xstats
      ip: bridge_slave: add support for per-port group_fwd_mask
      ip: bridge_slave: add neigh_suppress to the type help and

Nishanth Devarajan (1):
      tc: B.W limits can now be specified in %.

Nogah Frankel (4):
      ifstat: Includes reorder
      ifstat: Add extended statistics to ifstat
      ifstat: Add "sw only" extended statistics to ifstat
      ifstat: Add xstat to ifstat man page

Oliver Hartkopp (3):
      ip: link add vxcan support
      ip: add vxcan to help text
      ip: add vxcan/veth to ip-link man page

Or Gerlitz (4):
      tc: matchall: Print skip flags when dumping a filter
      tc/pedit: p_udp: introduce pedit udp support
      tc: Reflect HW offload status
      tc: flower: add support for matching on ip tos and ttl

Paul Blakey (2):
      tc: flower: support matching flags
      tc: flower: Refactor matching flags to be more user friendly

Petr Vorel (8):
      ip: fix igmp parsing when iface is long
      color: use "light" colors for dark background
      tests: Remove bashisms (s/source/.)
      tests: Revert back /bin/sh in shebang
      color: Fix ip segfault when using --color switch
      color: Fix another ip segfault when using --color switch
      color: Cleanup code to remove "magic" offset + 7
      color: Rename enum

Phil Dibowitz (1):
      Show 'external' link mode in output

Phil Sutter (113):
      ss: Mark fall through in arg parsing switch()
      ss: Drop empty lines in UDP output
      ss: Add missing tab when printing UNIX details
      ss: Use sockstat->type in all socket types
      ss: introduce proc_ctx_print()
      ss: Drop list traversal from unix_stats_print()
      ss: Eliminate unix_use_proc()
      ss: Turn generic_proc_open() wrappers into macros
      ss: Make tmr_name local to tcp_timer_print()
      ss: Make user_ent_hash_build_init local to user_ent_hash_build()
      ss: Make some variables function-local
      ss: Make slabstat_ids local to get_slabstat()
      ss: Get rid of useless goto in handle_follow_request()
      ss: Get rid of single-fielded struct snmpstat
      ss: Make unix_state_map local to unix_show()
      ss: Make sstate_name local to sock_state_print()
      ss: Make sstate_namel local to scan_state()
      ss: unix_show: No need to initialize members of calloc'ed structs
      tc: m_xt: Fix segfault with iptables-1.6.0
      tc: m_xt: Drop needless parentheses from #if checks
      man: tc-csum.8: Fix example
      man: ip-route.8: Fix 'expires' indenting
      testsuite: Generate nlmsg blob at runtime
      testsuite: Search kernel config in modules dir also
      man: ss.8: Add missing protocols to description of -A
      ip: link: bond: Fix whitespace in help text
      ip: link: macvlan: Add newline to help output
      ip: link: Unify link type help functions a bit
      ip: link: Add missing link type help texts
      man: ip-link: Specify min/max values for bridge slave priority and cost
      man: ip-rule.8: Further clarify how to interpret priority value
      man: ip.8: Document -brief flag
      tc: m_xt: Prevent a segfault in libipt
      man: Collect names of man pages automatically
      bpf: Make bytecode-file reading a little more robust
      Really fix get_addr() and get_prefix() error messages
      tc-simple: Fix documentation
      examples: Some shell fixes to cbq.init
      ifcfg: Quote left-hand side of [ ] expression
      tipc/node: Fix socket fd check in cmd_node_get_addr()
      iproute_lwtunnel: Argument to strerror must be positive
      iproute_lwtunnel: csum_mode value checking was ineffective
      ss: Don't leak fd in tcp_show_netlink_file()
      tc/em_ipset: Don't leak sockfd on error path
      ipvrf: Fix error path of vrf_switch()
      ifstat: Fix memleak in error case
      ifstat: Fix memleak in dump_kern_db() for json output
      ss: Fix potential memleak in unix_stats_print()
      tipc/bearer: Fix resource leak in error path
      devlink: No need for this self-assignment
      ipntable: No need to check and assign to parms_rta
      iproute: Fix for missing 'Oifs:' display
      lib/rt_names: Drop dead code in rtnl_rttable_n2a()
      ss: Skip useless check in parse_hostcond()
      ss: Drop useless assignment
      tc/m_gact: Drop dead code
      ipaddress: Avoid accessing uninitialized variable lcl
      iplink_can: Prevent overstepping array bounds
      ipmaddr: Avoid accessing uninitialized data
      ss: Use C99 initializer in netlink_show_one()
      netem/maketable: Check return value of fstat()
      tc/q_multiq: Don't pass garbage in TCA_OPTIONS
      iproute: Check mark value input
      iplink_vrf: Complain if main table is not found
      devlink: Check return code of strslashrsplit()
      lib/bpf: Don't leak fp in bpf_find_mntpt()
      ifstat, nstat: Check fdopen() return value
      tc/q_netem: Don't dereference possibly NULL pointer
      tc/tc_filter: Make sure filter name is not empty
      tipc/bearer: Prevent NULL pointer dereference
      ipntable: Avoid memory allocation for filter.name
      lib/fs: Fix format string in find_fs_mount()
      lib/inet_proto: Review inet_proto_{a2n,n2a}()
      lnstat_util: Simplify alloc_and_open() a bit
      tc/m_xt: Fix for potential string buffer overflows
      lib/ll_map: Choose size of new cache items at run-time
      ss: Make struct tcpstat fields 'timer' and 'timeout' unsigned
      ss: Make sure scanned index value to unix_state_map is sane
      netem/maketable: Check return value of fscanf()
      lib/bpf: Check return value of write()
      lib/fs: Fix and simplify make_path()
      lib/libnetlink: Don't pass NULL parameter to memcpy()
      ss: Fix for added diag support check
      link_gre6: Fix for changing tclass/flowlabel
      link_gre6: Print the tunnel's tclass setting
      utils: Implement strlcpy() and strlcat()
      Convert the obvious cases to strlcpy()
      Convert harmful calls to strncpy() to strlcpy()
      ipxfrm: Replace STRBUF_CAT macro with strlcat()
      tc_util: No need to terminate an snprintf'ed buffer
      lnstat_util: Make sure buffer is NUL-terminated
      lib/bpf: Fix bytecode-file parsing
      utils: strlcpy() and strlcat() don't clobber dst
      ipaddress: Fix segfault in 'addr showdump'
      ip-route: Fix for listing routes with RTAX_LOCK attribute
      ip{6, }tunnel: Avoid copying user-supplied interface name around
      tc: flower: No need to cache indev arg
      Check user supplied interface name lengths
      ss: Distinguish between IPv4 and IPv6 wildcard sockets
      ss: Detect IPPROTO_ICMPV6 sockets
      tc_util: Drop needless pointer check
      tc_util: Silence spurious compiler warning
      link_gre6: Detect invalid encaplimit values
      man: tc-csum.8: Fix inconsistency in example description
      tc: Optimize gact action lookup
      Remove leftovers from removed Latex documentation
      ip-link: Fix use after free in nl_get_ll_addr_len()
      man: ip-route.8: ssthresh parameter is NUMBER
      man: tc-vlan.8: Fix for incorrect example
      ssfilter: Eliminate shift/reduce conflicts
      ss: Allow excluding a socket table from being queried
      ss: Put filter DB parsing into a separate function
      ss: Drop filter_default_dbs()

Philip Prindeville (1):
      iproute2: add support for GRE ignore-df knob

Quentin Monnet (2):
      README: update location of git repositories, remove broken info link
      README: re-add updated information link

Ralf Baechle (1):
      ip: HSR: Fix cut and paste error

Remigiusz Kołłątaj (1):
      ip: add handling for new CAN netlink interface

Robert Shearman (6):
      iplink: add support for afstats subcommand
      man: Fix formatting of vrf parameter of ip-link show command
      iproute: Add support for ttl-propagation attribute
      iproute: Add support for MPLS LWT ttl attribute
      gre: Fix ttl inherit option
      vxlan: Make id optional when modifying a link

Roi Dayan (10):
      devlink: Add usage help for eswitch subcommand
      devlink: Add option to set and show eswitch inline mode
      tc: flower: Fix typo and style in flower man page
      tc: tunnel_key: Add tc-tunnel_key man page to Makefile
      tc: flower: Fix flower output for src and dst ports
      tc: flower: Add missing err check when parsing flower options
      tc: flower: Fix incorrect error msg about eth type
      tc: flower: Fix parsing ip address
      devlink: Add json and pretty options to help and man
      devlink: Add option to set and show eswitch encapsulation support

Roman Mashak (24):
      tc: pass correct conversion specifier to print 'unsigned int' action index.
      tc: fixed man page fonts for keywords and variable values
      tc: updated man page to reflect filter-id use in filter GET command.
      tc: distinguish Add/Replace action operations.
      tc: print skbedit action when dumping actions.
      tc: fix Makefile to build skbmod
      tc: fixed typo in usage text.
      tc: updated tc-u32 man page to reflect skip_sw and skip_hw parameters.
      tc: updated ife man page.
      ss: initialize 'fackets' member of tcpstat structure
      bridge: isolate vlans parsing code in a separate API
      bridge: dump vlan table information for link
      bridge: request vlans along with link information
      ip: added missing newline in man page
      ip netns: use strtol() instead of atoi()
      tc: distinguish Add/Replace qdisc operations
      ss: remove duplicate assignment
      ss: add missing path MTU parameter
      tc: added tc monitor description in man page
      tc: updated tc-bpf man page
      tc: print actual action for sample action
      tc: use get_u32() in psample action to match types
      tc: print actual action for connmark action
      tc: print index, refcnt & bindcnt for nat action

Roopa Prabhu (6):
      ip: extend route get to return matching fib route
      iproute: extend route get for mpls routes
      iplink: new option to set neigh suppression on a bridge port
      iplink: bridge: support bridge port vlan_tunnel attribute
      bridge: vlan: support for per vlan tunnel info
      bridge: fdb: print NDA_SRC_VNI if available

Sabrina Dubroca (1):
      man: ip-link.8: document bridge options

Serhey Popovych (57):
      ip/tunnel: Unify setup and accept zero address for local/remote endpoints
      ip/tunnel: Use get_addr() instead of get_prefix() for local/remote endpoints
      ip: gre: fix IFLA_GRE_LINK attribute sizing
      iplink: Improve index parameter handling
      iplink: Process "alias" parameter correctly
      iplink: Kill redundant network device name checks
      ip/tunnel: Use tnl_parse_key() to parse tunnel key
      link_ip6tnl: Use IN6ADDR_ANY_INIT to initialize local/remote endpoints
      link_vti6: Always add local/remote endpoint attributes
      utils: ll_addr: Handle ARPHRD_IP6GRE in ll_addr_n2a()
      ip/tunnel: No need to free answer after rtnl_talk() on error
      gre,ip6tnl/tunnel: Fix noencap- support
      gre6/tunnel: Do not submit garbage in flowinfo
      vxcan,veth: Forbid "type" for peer device
      ip/tunnel: Document "external" parameter
      link_iptnl: Kill code duplication
      link_iptnl: Print tunnel mode
      link_iptnl: Open "encap" JSON object
      ip6/tunnel: Fix tclass output
      ip6tnl/tunnel: Do not print obscure flowinfo
      ip6/tunnel: Unify tclass printing
      ip6/tunnel: Unify flowlabel printing
      ip6/tunnel: Unify encap_limit printing
      gre6/tunnel: Output flowlabel after tclass
      ip6tnl/tunnel: Output hoplimit before encapsulation limit
      ipaddress: Use family_name() for better code reuse
      iplink: Fix "alias" parameter length calculations
      iplink: Use ll_index_to_name() instead of if_indextoname()
      ip/tunnel: Correct and unify ttl/hoplimit printing
      ip/tunnel: Simplify and unify tos printing
      ip/tunnel: Use print_0xhex() instead of print_string()
      ip/tunnel: Abstract tunnel encapsulation options printing
      gre/tunnel: Print erspan_index using print_uint()
      vti/tunnel: Unify ikey/okey printing
      vti6/tunnel: Unify and simplify link type help functions
      tunnel: Return constant string without copying it
      utils: Always specify family for address in get_addr_1()
      utils: Always specify family and ->bytelen in get_prefix_1()
      utils: Fast inet address classification after get_addr()
      iplink_geneve: Get rid of inet_get_addr()
      iplink_vxlan: Get rid of inet_get_addr()
      ip: Get rid of inet_get_addr()
      gre/gre6: Post merge fixes
      tunnel: Add space between encap-dport and encap-sport in non-JSON output
      iptnl/ip6tnl: Unify ttl/hoplimit parsing routines
      vti/vti6: Minor improvements
      iplink: Use ll_name_to_index() instead of if_nametoindex()
      ip/tunnel: Be consistent when printing tunnel collect metadata
      gre/gre6: Unify attribute addition to netlink buffer
      utils: Introduce get_addr_rta() and inet_addr_match_rta()
      ipaddress: Use inet_addr_match_rta()
      iprule: Use inet_addr_match_rta()
      ipmroute: Use inet_addr_match_rta()
      ipneigh: Use inet_addr_match_rta()
      ipl2tp: Use get_addr_rta()
      tcp_metric: Use get_addr_rta()
      ip/tunnel: Unify local/remote endpoint address printing

Shmulik Ladkani (2):
      tc: m_mirred: Add support for ingress redirect/mirror
      ip: link_ip6tnl.c/ip6tunnel.c: Support IP6_TNL_F_ALLOW_LOCAL_REMOTE flag

Simon Horman (20):
      tc: flower: Support matching on SCTP ports
      tc: flower: remove references to eth_type in manpage
      tc: flower: document SCTP ip_proto
      tc: flower: correct name of ip_proto parameter to flower_parse_port()
      tc: flower: make use of flower_port_attr_type() safe and silent
      tc: flower: introduce enum flower_endpoint
      tc: flower: support matching on ICMP type and code
      tc: flower: document that *_ip parameters take a PREFIX as an argument.
      tc: flower: Allow *_mac options to accept a mask
      tc: flower: document that *_ip parameters take a PREFIX as an argument.
      tc: flower: Allow *_mac options to accept a mask
      tc: flower: Update dest UDP port documentation
      tc: ife: correct spelling of prio in example
      tc: flower: Support matching ARP
      tc: flower: use correct type when calling flower_icmp_attr_type
      tc: flower: Update documentation to indicate ARP takes IPv4 prefixes
      tc: flower: provide generic masked u8 parser helper
      tc: flower: provide generic masked u8 print helper
      tc: flower: support masked ICMP code and type match
      tc actions: store and dump correct length of user cookies

Simon Ruderich (3):
      man: document ip route get mark
      man: document ip fou show
      man: document ip xfrm policy nosock

Solio Sarabia (1):
      iplink: validate maximum gso_max_size

Stefan Hajnoczi (2):
      ss: allow AF_FAMILY constants >32
      ss: add AF_VSOCK support

Stefano Brivio (8):
      ss: Remove useless width specifier in process context print
      ss: Streamline process context printing in netlink_show_one()
      ss: Fix width calculations when Netid or State columns are missing
      ss: Replace printf() calls for "main" output by calls to helper
      ss: Introduce columns lightweight abstraction
      ss: Buffer raw fields first, then render them as a table
      ss: Implement automatic column width calculation
      ss: Fix rendering of continuous output (-E, --events)

Stephen Hemminger (177):
      update kernel headers to 4.9-net-next
      update net-next headers
      tc: flower checkpatch cleanups
      Update kernel headers for XDP and tcp_info
      update kernel headers from net-next
      update kernel headers from net-next
      update to net-next headers (pre 4.10 rc)
      lwtunnel: style cleanup
      libnetlink: break up dump function
      utils: cleanup style
      ipvrf: cleanup style issues
      configure: fix elftest when warnings enabled
      update kernel headers
      Revert "tc: flower: document that *_ip parameters take a PREFIX as an argument."
      Revert "tc: flower: Allow *_mac options to accept a mask"
      minor kernel header update
      whitespace cleanup
      kernel headers update
      add more uapi header files
      include: remove unused header
      update kernel headers (from 4.10-rc4)
      update kernel headers from 4.10 net-next
      update kernel headers from net-next
      tcp: header file update
      update headers from bridge tunnel metadata
      tc: add missing sample file
      update headers from net-next
      update headers from 4.10-rc8
      utils: hex2mem get rid of unnecessary goto
      v4.10.0
      add missing iplink_xstats.c
      update headers from net-next
      Update headers based on 4.11 merge window
      netlink route attribute cleanup
      xfrm: remove unnecessary casts
      tc: use rta_getattr_u32
      bpf: remove unnecessary cast
      pie: remove always false condition
      update headers from 4.11-rc2
      update kernel headers from net-next
      update headers from net-next
      update headers from 4.11-rc3
      update headers from net-next (post 4.11-rc3)
      update kernel headers from net-next
      netem: fix out of bounds access in maketable
      Update kernel headers from 4.11 net-next
      add seg6.h kernel headers
      update kernel headers from net-next
      remove unused header file sysctl.h
      iplink: whitespace cleanup
      pedit: fix whitespace
      update headers to 4.11 net-next
      v4.11.0
      update kernel headers during 4.12 merge window
      update headers from 4.12-rc2
      include: remove no longer used iptables_common.h
      update to current net-next headers
      update headers to get changes for TCA_FLOWER
      update headers to get IFLA_EVENT
      updated headers from net-next
      update headers from net-next (bpf and tc)
      more bpf header updates
      xfrm: get #define's from linux includes
      update headers to get TCA_TUNNEL_CSUM
      update kernel headers from net-next
      v4.12.0
      update kernel headers from net-next
      update headers to 4.13-rc1
      remove duplicated #include's
      Update headers from net-next
      ip: change flag names to an array
      update headers from 4.13-rc4
      tc: fix m_simple usage
      update headers from 4.13 net-next
      iproute: Add support for extended ack to rtnl_talk
      ss: enclose IPv6 address in brackets
      lib: fix extended ack with and without libmnl
      lib: need to pass LIBMNL flag
      include: update headers from net-next
      tc, ip: more Makefile updates for LIBMNL
      vti6: fix local/remote any addr handling
      change how Config is used in Makefile's
      vti: print keys in hex not dotted notation
      more BPF headers update
      seg6: add include/linux/seg6_local.h
      include: add pfkeyv2.h drop ipv6.h
      update kernel headers from net-next
      config: put CFLAGS/LDLIBS in config.mk
      add ERSPAN headers
      rdma: fix duplicate initialization in port_names
      libnetlink: drop unused parameter to rtnl_dump_done
      bpf: drop unused parameter to bpf_report_map_in_map
      tc: use named initializer for default mqprio options
      devlink: header update
      update headers from net-next
      update headers from 4.14 merge
      v4.13.0
      BPF: update headers from 4.14-rc1
      tc: flower remove unused variable
      doc: remove obsolete ip-tunnels documentation
      doc: remove outdated ss documentation
      doc: remove outdated arpd documentation
      doc: remove outdated nstat/rtstat documentation
      ignore generated Config file
      doc: remove outdated tc-filters documentation
      doc: remove outdated IPv6 flow label document
      doc: drop old ip command documentation
      update headers from net-next rc
      tipc: don't need custom CFLAGS
      update uapi headers from 4.14-rc4 net-next
      rdma: move headers to uapi
      uapi: add include linux/vm_sockets_diag.h
      netem: fix code indentation
      update headers for TC and TIPC from net-next
      bpf: update header file
      include: add TCP fastopen option
      update kernel headers
      iproute: source code cleanup
      bridge: checkpatch related cleanups
      Update kernel headers based on 4.14-rc7
      Update kernel headers from net-next (4.14-rc6)
      update kernel headers from 4.14-rc7 net-next
      Update kernel headers from 4.14-rc8 nete-next
      Update kernel headers with new SPDK identifier
      netem: use fixed rather than floating point for scaling
      update kernel headers
      update kernel headers from 4.14 net-next
      drop unneeded include of syslog.h
      v4.14.0
      utils: remove duplicate include of ctype.h
      v4.14.1
      update headers from 4.15-rc1
      ila: fix formatting of help message
      update bpf header from net-next
      tc: replace magic constant 16 with #define
      tc: break long lines
      SPDX license identifiers
      m_vlan: style cleanups
      m_action: style cleanup
      m_gact: whitespace cleanup
      m_mirred: style cleanups
      update bpf header from net-next
      update headers from 4.15-rc2
      iplink: allow configuring GSO max values
      uapi: add access to snd_cwnd and other sock_ops
      uapi: tun add eBPF based queue selection method
      iplink: add definitions for GSO_MAX
      include: qdisc offload defines
      ip: validate vlan value for vlan info
      ss: fix crash with invalid command input file
      utils: fix makeargs stack overflow
      include: update ethernet headers
      tc: remove no longer relevant README
      v4.15.0
      include: update uapi with BPF from 4.15-rc1
      include: update netfilter headers from 4.15-rc1
      include: update rdma uapi from 4.15-rc1
      include: update interface UAPI from 4.15-rc1
      include: update UAPI types.h
      include: update rdma header from 4.16-rc1
      uapi: update if_ether compat headers
      ip: remove dead code
      json_writer: add SPDX Identifier (GPL-2/BSD-2)
      Revert "iproute: "list/flush/save default" selected all of the routes"
      tc: help and whitespace cleanup
      rdma: fix man page typos
      bridge: avoid snprint truncation on time
      pedit: fix strncpy warning
      ip: use strlcpy() to avoid truncation
      tunnel: use strlcpy to avoid strncpy warnings
      tc_class: fix snprintf warning
      ematch: fix possible snprintf overflow
      misc: avoid snprintf warnings in ss and nstat
      bpf: avoid compiler warnings about strncpy
      namespace: limit the length of namespace name to avoid snprintf overflow
      uapi/if_ether: add definition of ether type field
      v4.16.0

Tariq Toukan (1):
      ip-address: Fix negative prints of large TX rate limits

Thomas Egerer (3):
      xfrm_policy: Add filter option for socket policies
      xfrm_policy: Do not attempt to deleteall a socket policy
      xfrm_{state, policy}: Allow to deleteall polices/states with marks

Thomas Graf (2):
      bpf: Fix number of retries when growing log buffer
      lwt: BPF support for LWT

Thomas Haller (1):
      man: fix documentation for range of route table ID

Timothy Redaelli (2):
      ip-route: Prevent some other double spaces in output
      bridge: Prevent a double space in bridge mdb show

Tom Herbert (5):
      ila: Fix reporting of ILA locators and locator match
      ila: added csum neutral support to ipila
      ila: support to configure checksum neutral-map-auto
      ila: support for configuring identifier and hook types
      ila: create ila_common.h

Vincent Bernat (2):
      vxlan: use preferred address family when neither group or remote is specified
      color: disable color when json output is requested

Vinicius Costa Gomes (2):
      tc: Add support for the CBS qdisc
      man: Add initial manpage for tc-cbs(8)

Vlad Yasevich (1):
      ip: Add IFLA_EVENT output to ip monitor

Wei Wang (1):
      ss: print tcpi_rcv_ssthresh

William Tu (5):
      gre: add support for ERSPAN tunnel
      ip6_gre: add support for ERSPAN tunnel
      gre6: add collect metadata support
      erspan: add erspan version II support
      erspan: add erspan usage description

Wolfgang Bumiller (1):
      tc/lexer: let quotes actually start strings

Yotam Gigi (10):
      tc: man: matchall: Fix example indentation
      tc: Add support for the sample tc action
      tc: man: Add man entry for the tc-sample action
      tc: man: matchall: Update examples to include sample
      tc: bash-completion: Add the _from variant to _tc_one* funcs
      tc: bash-completion: Prepare action autocomplete to support several actions
      tc: bash-completion: Make the *_KIND variables global
      tc: bash-completion: Add support for filter actions
      tc: bash-completion: Add support for matchall
      ip: mroute: Print offload indication

Yuchung Cheng (1):
      ss: print new tcp_info fields: busy, rwnd-limited, sndbuf-limited times

Yulia Kartseva (1):
      tc: fix ipv6 filter selector attribute for some prefix lengths

Yuval Mintz (1):
      qdisc: print offload indication

Zhang Shengju (1):
      iplink: add support for IFLA_CARRIER attribute

yupeng (1):
      man: add additional explainations for ss

Élie Bouttier (1):
      ip route: replace exits with returns
