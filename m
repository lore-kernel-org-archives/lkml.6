Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43AFC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72ABD21848
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="vvCBhUEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbeLXWQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:16:27 -0500
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:51954
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725803AbeLXWQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kquintremM/lKlAJki5H02sUU/wuVmHbd37euO1sRyg=;
 b=vvCBhUEHM6MdKg5IMQz+yt/mxudw1QapAMiynb2gsuptpaqIwW5hk4wkeHGWMXPlXrvDZ8SH+Z3p5DLKGQEzfpHIexmQ2D+i6J9sThpcdvii/S6n3Wg4zZZotbiB1x4tsNk5qmvyTTBCtajGCaV6Dw5Bafqd56heQMkaiVGVDLY=
Received: from DB6PR0501MB2183.eurprd05.prod.outlook.com (10.168.55.140) by
 DB6PR0501MB2343.eurprd05.prod.outlook.com (10.168.56.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 22:16:14 +0000
Received: from DB6PR0501MB2183.eurprd05.prod.outlook.com
 ([fe80::95e9:6204:950c:76bf]) by DB6PR0501MB2183.eurprd05.prod.outlook.com
 ([fe80::95e9:6204:950c:76bf%7]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 22:16:14 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHUm9ZIWZd+wCX90EmhckDXQW+kwg==
Date:   Mon, 24 Dec 2018 22:16:14 +0000
Message-ID: <20181224221606.GA25780@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0007.namprd22.prod.outlook.com
 (2603:10b6:301:28::20) To DB6PR0501MB2183.eurprd05.prod.outlook.com
 (2603:10a6:4:4b::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2343;6:i9QrtMpADNNEXRBRPHZukaaz7ye/5CEcxXMw44vlGwU15A59TR3OAjooqTdWwIcuDEeLh9AxvtLg5nklfMbZc1eQVbat3qHiNr4mDRe/C6JRy4PpW3y4h0NSXmyfeJw2ZSQMqzaD7N3r9Mpbmi+M2/0FofKF70DRLD8iKxoy07XuvlNwDNP7lGc/gyp+7bJdC949LiFg+oYvLmN9Yok2SDHk4Q3JUpxn0kBDWjqrxs4hJwcssHRbSiUPO2UNAJG4BOVGWUTdR+boPqfgEW863NPju1quWan44YSCb0cNN/VevvdCh9M1RQ5eu63yAFs5EYwZwAUAnMg5OYyT23IYU5u+gW/Eb57xSYxYbLFSBP0g+E+tluv4IoexhfCEFHEJi9I3C7cpOZ+TKmeg52n+JVkMT95PWZj1s+OPboy48aE/pA6UPA/3DP4jkiBxFPI7Uhi58siUSxx76HegP8Y+dg==;5:rE9uZVii4IHrWC9ChuvVFSP4slvMbSexhrluJg1jOGBOyqvDAnp2ESs9RDgjjS70sZiFCjuCkf1yn/29/aECiiSsdmSQnZIMQBdNJ5RdufNnoXVHMO3aT74oaX7qDeiYChCqpKGMfAxaJTVWvDSQ2uSgp10Rwcq3NGjYEy/F3TY=;7:v7KHD203+DlHX4eD2+fezvUfUOJ5bOODXVg+iPwObxTA2V9t3C0jpXiT7dU8+AAybOWKjH9SsWryr5cDzgTHHh9betqs8Io3oFwcHzxUoi7k1w97NIeLTyXjGIAo6hl+t3NxSP1n5tl95jBdnAWRcg==
x-ms-office365-filtering-correlation-id: d6babace-19de-4f64-4d8e-08d669ed6a95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2343;
x-ms-traffictypediagnostic: DB6PR0501MB2343:
x-microsoft-antispam-prvs: <DB6PR0501MB2343593E42B4B093A2112DE7CFBB0@DB6PR0501MB2343.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(102415395)(6040522)(2401047)(8121501046)(3231475)(944501520)(4983020)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0501MB2343;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2343;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(2906002)(102836004)(3846002)(33656002)(6116002)(14454004)(4744004)(99286004)(6506007)(386003)(26005)(186003)(478600001)(486006)(36756003)(476003)(106356001)(14444005)(256004)(5024004)(71200400001)(71190400001)(105586002)(25786009)(66066001)(99936001)(81166006)(33896004)(7736002)(86362001)(6486002)(8676002)(81156014)(97736004)(9686003)(5660300001)(52116002)(8936002)(4001150100001)(6436002)(305945005)(4326008)(316002)(54906003)(53946003)(110136005)(6512007)(53936002)(1076003)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2343;H:DB6PR0501MB2183.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RQ106mWdhO/myvF7qbFS1SbIaV71GtmYiNGorTHthLm0OtTlnwc4pSlPgrzQfj/kG3jc/kk69v280WO8X/s5dTHioUtbm+6EyQq/Jyc9N4cc30CpE9/MAeVTNvya6ozlubp2/e9/C15ftrTZdcxossw5kDM3/n/PkUcpiOMLzQGrShWglj0uG/3JC+kPXzleHYRa7Qcp66Ot5UXommQaAL72dxiDmbe58t556JPjk+lhZ+kjs4K6cieMTCNsIOT5ub5WB4BW6nExALp7Bocd3g17XkuPhdWsyxoPBlHYXmrvC+vh6mOvZyPZsOfwjiMu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6babace-19de-4f64-4d8e-08d669ed6a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 22:16:14.1824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 4.21.

There is a conflict with the net tree merged in 4.20 and the Mellanox shared
tree. DaveM has a resolution for this in his net-next tree already, but if you
merge RDMA first, here is the resolution:

  struct mlx5_ifc_flow_table_eswitch_cap_bits {
-       u8      reserved_at_0[0x1c];
-       u8      fdb_multi_path_to_table[0x1];
-       u8      reserved_at_1d[0x1];
+       u8      reserved_at_0[0x1a];
        u8      multi_fdb_encap[0x1];
-       u8      reserved_at_1f[0x1e1];
+       u8      reserved_at_1b[0x1];
+       u8      fdb_multi_path_to_table[0x1];
+       u8      reserved_at_1d[0x3];
+
+       u8      reserved_at_20[0x1e0];

There is also a conflict in -next with the NFS tree, in this case the correct
resolution is to continue to delete net/sunrpc/xprtrdma/fmr_ops.c

Things got a bit busy in a rush up to the US holiday season, so we may see a
busier early -rc cycle, I've seen a few thing that suggest there are some new
bugs now. The major changes to the uapi will hopefully encourage all the
driver maintainer do to early testing.

This PR is generated off v4.20, typically we've waited until net-next is
merged. For this reason you will see below a large number of patches that
duplicate ones in net-next from the Mellanox shared branch.

The tag for-linus-merged with my merge resolution to your tree is also
available to pull.

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to f617e5ffe04fd46010b618c9eeadaa04588704c9:

  RDMA/srpt: Use kmem_cache_free() instead of kfree() (2018-12-22 16:07:47 -0700)

----------------------------------------------------------------
4.21 merge window pull request

This has been a fairly typical cycle, with the usual sorts of driver
updates. Several series continue to come through which improve and
modernize various parts of the core code, and we finally are starting to
get the uAPI command interface cleaned up.

- Various driver fixes for bnxt_re, cxgb3/4, hfi1, hns, i40iw, mlx4, mlx5,
  qib, rxe, usnic

- Rework the entire syscall flow for uverbs to be able to run over
  ioctl(). Finally getting past the historic bad choice to use write()
  for command execution

- More functional coverage with the mlx5 'devx' user API

- Start of the HFI1 series for 'TID RDMA'

- SRQ support in the hns driver

- Support for new IBTA defined 2x lane widths

- A big series to consolidate all the driver function pointers into
  a big struct and have drivers provide a 'static const' version of the
  struct instead of open coding initialization

- New 'advise_mr' uAPI to control device caching/loading of page tables

- Support for inline data in SRPT

- Modernize how umad uses the driver core and creates cdev's and sysfs
  files

- First steps toward removing 'uobject' from the view of the drivers

----------------------------------------------------------------
Alex Vesker (1):
      IB/mlx5: Enable TX on a DEVX flow table

Allen Pais (1):
      RDMA/hns: prefer dma_zalloc_coherent to dma_alloc_coherent/memse

Andrew Boyer (2):
      RDMA/rxe: Distinguish between down links and disabled links
      RDMA/rxe: Add link_down, rdma_sends, rdma_recvs stats counters

Artemy Kovalyov (1):
      IB/mlx5: Allow modify AV in DCI QP to RTR

Ashutosh Dixit (1):
      IB/hfi1: Consider LMC in 16B/bypass ingress packet check

Bart Van Assche (15):
      include/scsi/srp.h: Move response flag definitions into this file
      include/scsi/srp.h: Add support for immediate data
      RDMA/srp: Document srp_parse_in() arguments
      RDMA/srp: Handle large SCSI CDBs correctly
      RDMA/srp: Propagate ib_post_send() failures to the SCSI mid-layer
      RDMA/srp: Move srp_rdma_ch.max_ti_iu_len declaration
      RDMA/srp: Rework handling of the maximum information unit length
      RDMA/srp: Add support for immediate data
      RDMA/srpt: Fix a use-after-free in the channel release code
      RDMA/srpt: Improve coding style conformance
      RDMA/srpt: Join split strings
      RDMA/srpt: Make kernel-doc headers complete
      RDMA/srpt: Remove driver version and release date
      RDMA/srpt: Rework the srpt_alloc_srq() error path
      RDMA/srpt: Add support for immediate data

Chuck Lever (1):
      rxe: IB_WR_REG_MR does not capture MR's iova field

Colin Ian King (3):
      IB/qib: fix spelling mistake "colescing" -> "coalescing"
      RDMA/drivers: Fix spelling mistake "initalize" -> "initialize"
      IB/usnic: fix spelling mistake "miniumum" -> "minimum"

Dan Carpenter (4):
      IB/qib: Fix an error code in qib_sdma_verbs_send()
      RDMA/hns: Fix an error code in hns_roce_create_srq()
      IB/uverbs: Signedness bug in UVERBS_HANDLER()
      RDMA/mlx5: Signedness bug in UVERBS_HANDLER()

Daniel Jurgens (1):
      net/mlx5: When fetching CQEs return CQE instead of void pointer

Danit Goldberg (3):
      net/mlx5: Expose packet based credit mode
      IB/mlx5: Add packet based credit mode support
      IB/mlx5: Report packet based credit mode device capability

Devesh Sharma (1):
      RDMA/bnxt_re: Increase depth of control path command queue

Doug Ledford (4):
      Merge branch 'write-handler-consistent-flow' into for-next
      Merge 'mlx5-next' into mlx5-devx
      Merge branch 'mlx5-devx' into wip/dl-for-next
      IB/mlx5: Fix compile issue when ODP disabled

Eli Britstein (3):
      net/mlx5: Introduce extended destination fields
      net/mlx5: E-Switch, Change vhca id valid bool field to bit flag
      net/mlx5: Support extended destination format in flow steering command

Eyal Davidovich (1):
      net/mlx5: Add monitor commands layout and event data

Gal Pressman (7):
      net/mlx5: Fix offsets of ifc reserved fields
      RDMA/vmw_pvrdma: Use atomic memory allocation in create AH
      RDMA/mlx5: Fix function name typo 'fileds' -> 'fields'
      RDMA: Mark if create address handle is in a sleepable context
      RDMA: Mark if destroy address handle is in a sleepable context
      RDMA/bnxt_re: Make use of create AH sleepable flag
      RDMA/bnxt_re: Make use of destroy AH sleepable flag

Guy Levi (2):
      IB/mlx5: Use fragmented SRQ's buffer for in-kernel users
      IB/mlx5: Use fragmented QP's buffer for in-kernel users

Huy Nguyen (1):
      IB/mlx5: Fix long EEH recover time with NVMe offloads

Jason Gunthorpe (38):
      Merge branch 'mlx5-next' into rdma.git
      RDMA/mlx5: Do not generate the uabi specs unconditionally
      RDMA/uverbs: Use a linear list to describe the compiled-in uapi
      RDMA/uverbs: Factor out the add/get pattern into a helper
      RDMA/uverbs: Add helpers to mark uapi functions as unsupported
      RDMA/mlx5: Use the uapi disablement APIs instead of code
      RDMA/uverbs: Require all objects to have a driver destroy function
      RDMA/verbs: Store the write/write_ex uapi entry points in the uverbs_api
      RDMA/uverbs: Convert the write interface to use uverbs_api
      RDMA/uverbs: Make all the method functions in uverbs_cmd static
      RDMA/uverbs: Check for NULL driver methods for every write call
      RDMA/uverbs: Add missing driver_data
      RDMA/uverbs: Replace ib_uverbs_file with uverbs_attr_bundle for write
      RDMA/uverbs: Make write() handlers return 0 on success
      RDMA/uverbs: Do not pass ib_uverbs_file to ioctl methods
      RDMA/uverbs: Add structure size info to write commands
      RDMA/uverbs: Prohibit write() calls with too small buffers
      RDMA/uverbs: Use uverbs_attr_bundle to pass udata for write_ex
      RDMA/uverbs: Use uverbs_attr_bundle to pass udata for write
      RDMA/uverbs: Use uverbs_attr_bundle to pass udata for ioctl()
      RDMA/uverbs: Remove out_len checks that are now done by the core
      RDMA/uverbs: Use uverbs_attr_bundle to pass ucore for write/write_ex
      RDMA/uverbs: Get rid of the 'callback' scheme in the compat path
      RDMA/uverbs: Use uverbs_response() for remaining response copying
      RDMA/uverbs: Use uverbs_request() for request copying
      RDMA/uverbs: Use uverbs_request() and core for write_ex handlers
      RDMA/uverbs: Fill in the response for IB_USER_VERBS_EX_CMD_MODIFY_QP
      RDMA/uverbs: Simplify ib_uverbs_ex_query_device
      RDMA/uverbs: Add a simple iterator interface for reading the command
      RDMA/uverbs: Use the iterator for ib_uverbs_unmarshall_recv()
      RDMA/uverbs: Do not check the input length on create_cq/qp paths
      RDMA/uverbs: Use only attrs for the write() handler signature
      Merge branch 'mlx5-packet-credit-fc' into rdma.git
      Merge tag 'v4.20-rc6' into rdma.git for-next
      RDMA/uverbs: Implement an ioctl that can call write and write_ex handlers
      RDMA/uverbs: Add a method to introspect handles in a context
      Merge branch 'mlx5-next' into rdma.git
      IB/mlx5: Fix wrong error unwind

Kaike Wan (4):
      IB/hfi1: Dump pio info for non-user send contexts
      IB/hfi1: Ignore LNI errors before DC8051 transitions to Polling state
      IB/hfi1: Unreserve a reserved request when it is completed
      IB/hfi1: Add OPFN and TID RDMA capability bits

Kamal Heib (20):
      RDMA/core: Introduce ib_device_ops
      RDMA/bnxt_re: Initialize ib_device_ops struct
      RDMA/cxgb3: Initialize ib_device_ops struct
      RDMA/cxgb4: Initialize ib_device_ops struct
      RDMA/hfi1: Initialize ib_device_ops struct
      RDMA/hns: Initialize ib_device_ops struct
      RDMA/i40iw: Initialize ib_device_ops struct
      RDMA/mlx4: Initialize ib_device_ops struct
      RDMA/mlx5: Initialize ib_device_ops struct
      RDMA/mthca: Initialize ib_device_ops struct
      RDMA/nes: Initialize ib_device_ops struct
      RDMA/ocrdma: Initialize ib_device_ops struct
      RDMA/qedr: Initialize ib_device_ops struct
      RDMA/qib: Initialize ib_device_ops struct
      RDMA/usnic: Initialize ib_device_ops struct
      RDMA/vmw_pvrdma: Initialize ib_device_ops struct
      RDMA/rxe: Initialize ib_device_ops struct
      RDMA/rdmavt: Initialize ib_device_ops struct
      RDMA: Start use ib_device_ops
      RDMA/i40iw: Make sure to initialize ib_device_ops

Leon Romanovsky (22):
      RDMA/qib: Remove all occurrences of BUG_ON()
      RDMA/restrack: Track ucontext
      RDMA/uverbs: Annotate alloc/deallloc paths with context tracking
      RDMA/nldev: Export to user space number of contexts
      net/mlx5: Align SRQ licenses and copyright information
      net/mlx5: Remove dead transobj code
      net/mlx5: Remove not-used lib/eq.h header file
      net/mlx5: Remove references to local mlx5_core functions
      net/mlx5: Move SRQ functions to RDMA part
      RDMA/mlx5: Remove SRQ signature global flag
      RDMA/mlx5: Use stages for callback to setup and release DEVX
      RDMA/mlx5: Update SRQ functions signatures to mlx5_ib format
      RDMA/mlx5: Initialize SRQ tables on mlx5_ib
      RDMA/mlx5: Unfold create RMP function
      RDMA/mlx5: Unfold modify RMP function
      RDMA/uverbs: Fix typo in string concatenation macro
      RDMA/mlx5: Fail early if user tries to create flows on IB representors
      RDMA/uverbs: Optimize clearing of extra bytes in response
      RDMA/ocrdma: Use PCI-ID as an identification in debugfs
      net/mlx5: Continue driver initialization despite debugfs failure
      RDMA/mlx5: Delete unreachable handle_atomic code by simplifying SW completion
      net/mlx5: Add shared Q counter bits

Lijun Ou (9):
      RDMA/hns: Eanble SRQ capacity for hip08
      RDMA/hns: Init SRQ table for hip08
      RDMA/hns: Add SRQ support for hip08 kernel mode
      RDMA/hns: Add SRQ asynchronous event support
      RDMA/hns: Init qp context when modify qp from reset to init
      RDMA/hns: Encapsulate and simplify qp state transition
      RDMA/hns: Fix the bug while use multi-hop of pbl
      RDMA/hns: Update posting & querying mailbox
      RDMA/hns: Bugfix for RoCE loopback test

Mark Bloch (2):
      RDMA/mlx5: Attach a DEVX counter via raw flow creation
      IB/mlx5: Unify e-switch representors load approach between uplink and VFs

Michael Guralnik (9):
      IB/core: Add CapabilityMask2 to port attributes
      IB/core: Add 2X port width
      IB/core: Add new IB rates
      IB/mlx5: Report CapabilityMask2 in ib_query_port
      IB/mlx5: Add HDR speed support to query port
      IB/mlx5: Add 2X width support to query_port
      IB/core: uverbs copy to struct or zero helper
      RDMA/nldev: Expose port_cap_flags2
      IB/core: Move query port to ioctl

Michael J. Ruhl (2):
      IB/hfi1: Limit VNIC use of SDMA engines to the available count
      IB/hfi1: Incorrect sizing of sge for PIO will OOPs

Mike Marciniszyn (3):
      IB/hfi1: Allow the driver to initialize QP priv struct
      IB/hfi1: Close VNIC sdma_progress sleep window
      IB/hfi1: Reduce lock contention on iowait_lock for sdma and pio

Mikhael Goikhman (3):
      net/mlx5: Rework handling of port module events
      net/mlx5: Add support for PCIe power slot exceeded error in PME
      net/mlx5: Add support for plugged-disabled cable status in PME

Mitko Haralanov (1):
      IB/hfi1: Correctly process FECN and BECN in packets

Moni Shoua (10):
      net/mlx5: Release resource on error flow
      net/mlx5: Add interface to hold and release core resources
      net/mlx5: Enumerate page fault types
      IB/mlx5: Lock QP during page fault handling
      net/mlx5: Return success for PAGE_FAULT_RESUME in internal error state
      net/mlx5: Use multi threaded workqueue for page fault handling
      IB/mlx5: Improve ODP debugging messages
      IB/uverbs: Add helper to get array size from ptr attribute
      IB/uverbs: Add support to advise_mr
      IB/mlx5: Add advise_mr() support

Or Gerlitz (2):
      net/mlx5: Remove the get protocol device interface entry
      IB/mlx5: Simplify netdev unbinding

Oz Shlomo (1):
      net/mlx5: Revise gre and nvgre key formats

Parav Pandit (11):
      RDMA/core: Remove unused header files mm.h, socket.h, scatterlist.h
      RDMA/cma: Move cma module specific functions to cma_priv.h
      RDMA/core: Sync unregistration with netlink commands
      RDMA/core: Delete RoCE GID in hw when corresponding IP is deleted
      RDMA/uverbs: Add an ioctl method to destroy an object
      IB/rxe: Make counters thread safe
      IB/umad: Simplify and avoid dynamic allocation of class
      IB/umad: Avoid destroying device while it is accessed
      IB/umad: Refactor code to use cdev_device_add()
      IB/umad: Use class_groups and let core create class file
      IB/umad: Start using dev_groups of class

Parvi Kaustubhi (2):
      MAINTAINERS: Update usnic driver maintainers
      IB/usnic: Fix potential deadlock

Qian Cai (1):
      mlx4: Use snprintf instead of complicated strcpy

Rami Rosen (1):
      IB/uverbs: fix a typo

Roi Dayan (2):
      net/mlx5: Split the activate lag function into two routines
      net/mlx5: Add lag affinity info to log

Sabyasachi Gupta (2):
      infiniband/hw/cxgb3/cxio_hal.c: Use dma_zalloc_coherent
      infiniband/hw/cxgb4/qp.c: Use dma_zalloc_coherent

Saeed Mahameed (38):
      net/mlx5: EQ, Use the right place to store/read IRQ affinity hint
      net/mlx5: EQ, Remove unused fields and structures
      net/mlx5: EQ, No need to store eq index as a field
      net/mlx5: EQ, Remove redundant completion EQ list lock
      net/mlx5: EQ, Move all EQ logic to eq.c
      net/mlx5: EQ, Create all EQs in one place
      net/mlx5: EQ, irq_info and rmap belong to eq_table
      net/mlx5: EQ, Privatize eq_table and friends
      net/mlx5: EQ, Different EQ types
      net/mlx5: EQ, Generic EQ
      {net,IB}/mlx5: Move Page fault EQ and ODP logic to RDMA
      net/mlx5: EQ, Make EQE access methods inline
      net/mlx5: EQ, Introduce atomic notifier chain subscription API
      net/mlx5: FWTrace, Use async events chain
      net/mlx5: FPGA, Use async events chain
      net/mlx5: Clock, Use async events chain
      net/mlx5: E-Switch, Use async events chain
      net/mlx5: FWPage, Use async events chain
      net/mlx5: CmdIF, Use async events chain
      net/mlx5: Resource tables, Use async events chain
      net/mlx5: CQ ERR, Use async events chain
      net/mlx5: Device events, Use async events chain
      net/mlx5: Improve core device events handling
      net/mlx5: Driver events notifier API
      net/mlx5: Allow port change event to be forwarded to driver notifiers chain
      net/mlx5e: Use the new mlx5 core notifier API
      net/mlx5: Forward all mlx5 events to mlx5 notifiers chain
      IB/mlx5: Use the new mlx5 core notifier API
      net/mlx5: Remove unused events callback and logic
      IB/mlx5: Handle raw port change event rather than the software version
      net/mlx5: Allow forwarding event type general event as is
      IB/mlx5: Handle raw delay drop general event
      net/mlx5: Remove all deprecated software versions of FW events
      net/mlx5: Forward QP/WorkQueues resource events
      net/mlx5: Forward SRQ resource events
      net/mlx5: Debug print for forwarded async events
      net/mlx5: Move flow counters data structures from flow steering header
      net/mlx5: Use lowercase 'X' for hex values

Sagi Grimberg (3):
      rxe: fix error completion wr_id and qp_num
      mlx5: remove support for ib_get_vector_affinity
      i40iw: remove support for ib_get_vector_affinity

Selvin Xavier (1):
      RDMA/bnxt_re: Query HWRM Interface version from FW

Shahar Klein (2):
      net/mlx5: E-Switch, Introduce flow counter affinity
      net/mlx5: Fold the modify lag code into function

Shamir Rabinovitch (2):
      RDMA/restrack: Resource-tracker should not use uobject pointers
      RDMA: Cleanup undesired pd->uobject usage

Steve Wise (2):
      iw_cxgb4: only reconnect with MPAv1 if the peer aborts
      RDMA/iwcm: Don't copy past the end of dev_name() string

Tariq Toukan (2):
      net/mlx5: Use helper to get CQE opcode
      IB/mlx5: Use helper to get CQE opcode

Ursula Braun (1):
      mlx4: trigger IB events needed by SMC

Wei Yongjun (1):
      RDMA/srpt: Use kmem_cache_free() instead of kfree()

Yishai Hadas (11):
      net/mlx5: Update mlx5_ifc with DEVX UCTX capabilities bits
      IB/core: Introduce UVERBS_IDR_ANY_OBJECT
      IB/core: Enable getting an object type from a given uobject
      IB/mlx5: Enable modify and query verbs objects via DEVX
      IB/mlx5: Enforce DEVX privilege by firmware
      IB/mlx5: Update the supported DEVX commands
      IB/mlx5: Allow XRC usage via verbs in DEVX context
      IB/mlx5: Introduce uid as part of alloc/dealloc transport domain
      IB/mlx5: Use uid as part of alloc/dealloc transport domain
      IB/mlx5: Use the correct commands for UMEM and UCTX allocation
      IB/mlx5: Allocate the per-port Q counter shared when DEVX is supported

Yue Haibing (1):
      IB/srpt: Drop pointless static qualifier in srpt_make_tpg()

YueHaibing (3):
      IB/mlx5: Remove duplicated include from mlx5_ib.h
      net/mlx5: Remove duplicated include from eswitch.c
      IB/mlx4: Remove set but not used variable 'pd'

Yuval Shaia (9):
      IB/core: Make function ib_fmr_pool_unmap return void
      IB/rxe: Make function rxe_pool_cleanup return void
      IB/rxe: Utilize generic function to validate port number
      RDMA/core: Validate port number in query_pkey verb
      IB/rxe: Fix incorrect cache cleanup in error flow
      IB/{mlx5,ocrdma,qedr,rxe}: Omit port validation from IB verbs
      IB/mlx4: Remove unneeded NULL check
      IB/mlx4: Utilize macro to calculate SQ spare size
      IB/rxe: Reuse code which sets port state

Zhu Yanjun (3):
      IB/rxe: clean skb queue directly
      IB/rxe: move the variable into the function that uses it
      IB/rxe: make rxe_unregister_device void

kbuild test robot (1):
      RDMA/uverbs: fix ptr_ret.cocci warnings

 MAINTAINERS                                        |    2 +
 drivers/infiniband/core/Makefile                   |    2 +-
 drivers/infiniband/core/agent.c                    |    4 +-
 drivers/infiniband/core/cache.c                    |   17 +-
 drivers/infiniband/core/cm.c                       |    6 +-
 drivers/infiniband/core/cma.c                      |    2 +-
 drivers/infiniband/core/cma_configfs.c             |    3 +
 drivers/infiniband/core/cma_priv.h                 |   28 +
 drivers/infiniband/core/core_priv.h                |   47 +-
 drivers/infiniband/core/cq.c                       |    8 +-
 drivers/infiniband/core/device.c                   |  166 +-
 drivers/infiniband/core/fmr_pool.c                 |    8 +-
 drivers/infiniband/core/iwcm.c                     |   12 +-
 drivers/infiniband/core/mad.c                      |   22 +-
 drivers/infiniband/core/mad_rmpp.c                 |   11 +-
 drivers/infiniband/core/nldev.c                    |   34 +-
 drivers/infiniband/core/opa_smi.h                  |    4 +-
 drivers/infiniband/core/rdma_core.c                |   54 +-
 drivers/infiniband/core/rdma_core.h                |   79 +-
 drivers/infiniband/core/restrack.c                 |   51 +-
 drivers/infiniband/core/sa_query.c                 |    5 +-
 drivers/infiniband/core/security.c                 |    8 +-
 drivers/infiniband/core/smi.h                      |    4 +-
 drivers/infiniband/core/sysfs.c                    |   28 +-
 drivers/infiniband/core/ucm.c                      |    2 +-
 drivers/infiniband/core/umem_odp.c                 |   14 +-
 drivers/infiniband/core/user_mad.c                 |  244 +--
 drivers/infiniband/core/uverbs.h                   |   86 +-
 drivers/infiniband/core/uverbs_cmd.c               | 2074 ++++++++++----------
 drivers/infiniband/core/uverbs_ioctl.c             |   59 +-
 drivers/infiniband/core/uverbs_main.c              |  242 +--
 drivers/infiniband/core/uverbs_std_types.c         |  118 +-
 .../infiniband/core/uverbs_std_types_counters.c    |   20 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |   23 +-
 drivers/infiniband/core/uverbs_std_types_device.c  |  224 +++
 drivers/infiniband/core/uverbs_std_types_dm.c      |   17 +-
 .../infiniband/core/uverbs_std_types_flow_action.c |   31 +-
 drivers/infiniband/core/uverbs_std_types_mr.c      |   76 +-
 drivers/infiniband/core/uverbs_uapi.c              |  514 ++++-
 drivers/infiniband/core/verbs.c                    |  194 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   17 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |    3 +-
 drivers/infiniband/hw/bnxt_re/main.c               |  128 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   34 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   59 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |    1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   10 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |    6 +-
 drivers/infiniband/hw/cxgb3/cxio_hal.c             |    3 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c        |   66 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |    3 +-
 drivers/infiniband/hw/cxgb4/provider.c             |   74 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |    7 +-
 drivers/infiniband/hw/hfi1/Makefile                |    1 +
 drivers/infiniband/hw/hfi1/chip.c                  |   47 +-
 drivers/infiniband/hw/hfi1/chip_registers.h        |    4 +
 drivers/infiniband/hw/hfi1/common.h                |   19 +-
 drivers/infiniband/hw/hfi1/debugfs.c               |   49 +
 drivers/infiniband/hw/hfi1/driver.c                |   72 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |   35 +-
 drivers/infiniband/hw/hfi1/mad.c                   |    2 +-
 drivers/infiniband/hw/hfi1/pio.c                   |   31 +-
 drivers/infiniband/hw/hfi1/pio.h                   |    5 +
 drivers/infiniband/hw/hfi1/qp.c                    |   20 +-
 drivers/infiniband/hw/hfi1/rc.c                    |   32 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |   10 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |    1 +
 drivers/infiniband/hw/hfi1/tid_rdma.c              |   48 +
 drivers/infiniband/hw/hfi1/tid_rdma.h              |   13 +
 drivers/infiniband/hw/hfi1/uc.c                    |    2 +-
 drivers/infiniband/hw/hfi1/ud.c                    |   33 +-
 drivers/infiniband/hw/hfi1/user_sdma.c             |    5 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |   28 +-
 drivers/infiniband/hw/hfi1/verbs.h                 |    2 +
 drivers/infiniband/hw/hfi1/vnic_main.c             |    4 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |   18 +-
 drivers/infiniband/hw/hns/Makefile                 |    2 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c            |    3 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |    2 +
 drivers/infiniband/hw/hns/hns_roce_cmd.h           |    4 +
 drivers/infiniband/hw/hns/hns_roce_common.h        |    3 -
 drivers/infiniband/hw/hns/hns_roce_device.h        |   97 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |   41 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h           |    2 +
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   13 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  574 +++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  142 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |  185 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  141 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   37 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |  457 +++++
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |    2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |  127 +-
 drivers/infiniband/hw/mlx4/ah.c                    |    6 +-
 drivers/infiniband/hw/mlx4/alias_GUID.c            |    2 +-
 drivers/infiniband/hw/mlx4/mad.c                   |   28 +-
 drivers/infiniband/hw/mlx4/main.c                  |  205 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |    5 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   31 +-
 drivers/infiniband/hw/mlx4/srq.c                   |   10 +-
 drivers/infiniband/hw/mlx4/sysfs.c                 |   12 +-
 drivers/infiniband/hw/mlx5/Makefile                |    4 +-
 drivers/infiniband/hw/mlx5/ah.c                    |    4 +-
 drivers/infiniband/hw/mlx5/cmd.c                   |   19 +
 drivers/infiniband/hw/mlx5/cmd.h                   |    2 +
 drivers/infiniband/hw/mlx5/cq.c                    |  114 +-
 drivers/infiniband/hw/mlx5/devx.c                  |  233 ++-
 drivers/infiniband/hw/mlx5/flow.c                  |   73 +-
 drivers/infiniband/hw/mlx5/ib_rep.c                |   15 +-
 drivers/infiniband/hw/mlx5/mad.c                   |   18 +-
 drivers/infiniband/hw/mlx5/main.c                  |  602 +++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   77 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   42 +-
 drivers/infiniband/hw/mlx5/odp.c                   |  454 ++++-
 drivers/infiniband/hw/mlx5/qp.c                    |  447 +++--
 drivers/infiniband/hw/mlx5/srq.c                   |   73 +-
 drivers/infiniband/hw/mlx5/srq.h                   |   73 +
 .../core/srq.c => infiniband/hw/mlx5/srq_cmd.c}    |  302 +--
 drivers/infiniband/hw/mthca/mthca_dev.h            |    9 +-
 drivers/infiniband/hw/mthca/mthca_mad.c            |    7 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |  158 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |   22 +-
 drivers/infiniband/hw/mthca/mthca_srq.c            |   29 +-
 drivers/infiniband/hw/nes/nes_cm.c                 |    2 +-
 drivers/infiniband/hw/nes/nes_verbs.c              |   71 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c           |    4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h           |    4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |   92 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c        |    5 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |   19 +-
 drivers/infiniband/hw/qedr/main.c                  |  103 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   25 +-
 drivers/infiniband/hw/qedr/verbs.h                 |    4 +-
 drivers/infiniband/hw/qib/qib_iba6120.c            |    1 -
 drivers/infiniband/hw/qib/qib_iba7220.c            |    2 -
 drivers/infiniband/hw/qib/qib_iba7322.c            |    3 -
 drivers/infiniband/hw/qib/qib_init.c               |    1 -
 drivers/infiniband/hw/qib/qib_mad.c                |    3 +-
 drivers/infiniband/hw/qib/qib_pcie.c               |    2 +-
 drivers/infiniband/hw/qib/qib_sdma.c               |    5 +-
 drivers/infiniband/hw/qib/qib_ud.c                 |    1 -
 drivers/infiniband/hw/qib/qib_user_sdma.c          |    1 -
 drivers/infiniband/hw/qib/qib_verbs.c              |   13 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |   63 +-
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c      |    2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |   14 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h       |    3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |   82 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |    8 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |    4 +-
 drivers/infiniband/sw/rdmavt/ah.c                  |    5 +-
 drivers/infiniband/sw/rdmavt/ah.h                  |    3 +-
 drivers/infiniband/sw/rdmavt/mad.c                 |    3 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |    9 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |  299 +--
 drivers/infiniband/sw/rxe/rxe.h                    |    6 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |    6 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.c        |    9 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h        |    3 +
 drivers/infiniband/sw/rxe/rxe_loc.h                |    7 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   16 +-
 drivers/infiniband/sw/rxe/rxe_pool.c               |   30 +-
 drivers/infiniband/sw/rxe/rxe_pool.h               |    2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   11 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |    3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   33 +-
 drivers/infiniband/sw/rxe/rxe_sysfs.c              |   18 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  129 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |    8 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    4 +-
 drivers/infiniband/ulp/iser/iser_memory.c          |    9 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c  |    8 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    |    8 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  159 +-
 drivers/infiniband/ulp/srp/ib_srp.h                |   20 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  283 ++-
 drivers/infiniband/ulp/srpt/ib_srpt.h              |   44 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   54 +-
 drivers/net/ethernet/mellanox/mlx5/core/cq.c       |   15 +-
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c  |   11 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  162 +-
 .../mellanox/mlx5/core/diag/fs_tracepoint.c        |    8 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   27 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.h   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   51 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       | 1260 ++++++------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   44 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    3 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/events.c   |  325 +++
 .../net/ethernet/mellanox/mlx5/core/fpga/conn.c    |    2 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/core.c    |   38 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/core.h    |   11 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   83 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   23 -
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |   23 +
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag.c      |   59 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   24 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.h    |    3 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h   |   98 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |   36 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  351 +---
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   39 +-
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |   44 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |   57 -
 drivers/net/ethernet/mellanox/mlx5/core/qp.c       |   86 +-
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c |  109 -
 drivers/net/ethernet/mellanox/mlx5/core/wq.h       |    2 +-
 fs/cifs/smbdirect.c                                |    2 +-
 include/linux/mlx5/cq.h                            |    2 +-
 include/linux/mlx5/device.h                        |   23 +-
 include/linux/mlx5/driver.h                        |  254 +--
 include/linux/mlx5/eq.h                            |   72 +
 include/linux/mlx5/fs.h                            |    8 +-
 include/linux/mlx5/mlx5_ifc.h                      |  229 ++-
 include/linux/mlx5/port.h                          |    3 -
 include/linux/mlx5/qp.h                            |    5 +
 include/linux/mlx5/srq.h                           |   72 -
 include/linux/mlx5/transobj.h                      |   11 -
 include/rdma/ib_fmr_pool.h                         |    2 +-
 include/rdma/ib_mad.h                              |   10 +
 include/rdma/ib_verbs.h                            |  584 +++---
 include/rdma/rdma_vt.h                             |    7 +
 include/rdma/restrack.h                            |   17 +-
 include/rdma/uverbs_ioctl.h                        |  251 ++-
 include/rdma/uverbs_named_ioctl.h                  |   13 +-
 include/rdma/uverbs_std_types.h                    |   73 +-
 include/scsi/srp.h                                 |   26 +-
 include/uapi/rdma/hfi/hfi1_user.h                  |    6 +-
 include/uapi/rdma/hns-abi.h                        |    6 +
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   84 +
 include/uapi/rdma/ib_user_ioctl_verbs.h            |   16 +
 include/uapi/rdma/ib_user_verbs.h                  |   18 +-
 include/uapi/rdma/mlx5-abi.h                       |    2 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |    1 +
 include/uapi/rdma/rdma_netlink.h                   |    3 +
 net/rds/ib.c                                       |    4 +-
 net/sunrpc/xprtrdma/fmr_ops.c                      |    2 +-
 247 files changed, 10427 insertions(+), 6528 deletions(-)
(diffstat from tag for-linus-merged)

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlwhWqMACgkQOG33FX4g
mxo3Lw/+LTRwczcD17JX0U781SbNdZn1m+Pncidhqt4H0Pkv67hnizIxxRd4lhgO
tFuN3iKaBymVPxfz6T0E2ao5lSNR4FuAWjh4nN4+2LPNPz1hk6ljbiJWwVMMBPDC
mnx7KebBU1iOfVTJ12iprh6P7gCAOz0H1Hi008gIPAJrmKd4kmZtqaWOBoSuEZUZ
hLeQw15p30lJzRLP8hNU0DJ2aFmIQ96vJ3G3RcsEBIcCNXoAoY2zTcsUL7RtINds
KJHVMBjwT1LfDkmJWxn/Ip5lbVlITU6jzpXQDuRlAfghcKdzcFolo3lSQkuyGoPP
Djz6wan2g/rS85+fre/aj0gAImAQWWQox4fXcwYcP60hTykZaP3mCHet8qr/q81o
jFuIk+p2QuxxwkNOYQV75HoKB5gBWWTy+zP1wBbC/8U1+8UJXLK9XblAICMRbQ9n
cfsIpgVKpEz9SE8jqdVduLCOuPrK/dqUe+5UkdF8OtIMzTUleH0YO/NA/cwrv6FH
Qk+p1cOVE++aAMN5h8FVSf2oUOZOAtF+Ta8d0JAais8GyGP99gIzzoz2vOMoNjM1
AVHuZ19XPEf/DI3+cdWBpBzp5f1BWJprRH2p4L2O3pcPt2fzrYmp8fOGRqNQT1nb
pq672gXFEh+6MDEHF7wUK7FL2MsVGtqA4fVWz0ptsi5+N2QyLmM=
=e+Nq
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
