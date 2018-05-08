Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756089AbeEHWQ2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:16:28 -0400
Received: from mail-sn1nam01on0139.outbound.protection.outlook.com ([104.47.32.139]:24192
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755915AbeEHWQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:16:26 -0400
From: Long Li <longli@microsoft.com>
To: kbuild test robot <lkp@intel.com>, Long Li <longli@linuxonhyperv.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 5/7] cifs: smbd: Protect memory registration using RCU
Thread-Topic: [PATCH 5/7] cifs: smbd: Protect memory registration using RCU
Thread-Index: AQHT5lHHHy3rRNqouEKp7QeKSvXn/qQlYP8AgAEGeVA=
Date: Tue, 8 May 2018 22:16:23 +0000
Message-ID: <MWHPR2101MB0729D64EBD5E4BAE67C26E7CCE9A0@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180507222006.20781-5-longli@linuxonhyperv.com>
 <201805081349.MX5qQDch%fengguang.wu@intel.com>
In-Reply-To: <201805081349.MX5qQDch%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:e::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0809;7:WO5UUZuhRHevEN3uCcyEKdei4c6a47plX0J1AriK0dDIzbht6zSMpC++psP46FTKyE9/BI6dWqqSsmb0QHZsy23lcNy1Kg1sqMCeiL5UTtBMyf/kNDgNnnd0EbfTGXRp4XNX77vpx9SR4/mp2/+CwYrPEclw8fh6wH7KwvoY9yC6OcA8dnj1XPcQk9TreBRIZmh+R+JtWErgxQd80lTtK0+fz8TUGgEfjYYtHwqFA9smKztU4VQYfuW4ahoYaEi6;20:xW+7oQwi7MFR+kHeU9l+rdEVGjoUfGnSULMHboBT/L7KFhIDAbbOF7olnZ2sHrOO+LVJO2GeC1rjW2TPskKRodVgeVaBJ5L4qhlQQ/4OrYji2ZUwML6AVliSRiNvU8UAD9wS1SZZysHpCYxG5OPwmTExAiTEaxg86k+OIXbpNhM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MWHPR2101MB0809;
x-ms-traffictypediagnostic: MWHPR2101MB0809:
x-microsoft-antispam-prvs: <MWHPR2101MB0809F21376AD7723857D4E34CE9A0@MWHPR2101MB0809.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(9452136761055)(189930954265078)(219752817060721)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR2101MB0809;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0809;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(346002)(376002)(199004)(13464003)(189003)(106356001)(54906003)(25786009)(6436002)(8990500004)(33656002)(345774005)(229853002)(68736007)(97736004)(316002)(6246003)(2906002)(14454004)(59450400001)(110136005)(105586002)(74316002)(6116002)(22452003)(446003)(10290500003)(76176011)(11346002)(6306002)(9686003)(6346003)(305945005)(3660700001)(46003)(102836004)(6506007)(7736002)(99286004)(4326008)(53546011)(53936002)(86612001)(81166006)(575784001)(8676002)(476003)(81156014)(7696005)(86362001)(186003)(486006)(478600001)(10090500001)(2900100001)(3280700002)(55016002)(5250100002)(5660300001)(966005)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0809;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-message-info: 8HGD3VksKv+F0+ho0TAM66sjsVsrf9KwEH5xZDl3H9UUF6ecZk3FpFpgXv3Ud+4bv4G0LfxWZ8asaymOhHjpQcVgro7sbG8fow3emv1KzD7cTp7HWdphMfG2A/2XIqepvOgOXvGGi02dWG+kFjqDDAJKAh5vZPRAedRKTwiYbzpH8uswq6VCO9TvdR/INbJv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 455faebc-3027-4ad3-b072-08d5b5315559
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455faebc-3027-4ad3-b072-08d5b5315559
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 22:16:23.0707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0809
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48MGaxD017231

Hi Steve

Please drop this patch. I will find another solution.

The other patches in the series can be reviewed and applied.

Long

> -----Original Message-----
> From: kbuild test robot <lkp@intel.com>
> Sent: Monday, May 7, 2018 11:36 PM
> To: Long Li <longli@linuxonhyperv.com>
> Cc: kbuild-all@01.org; Steve French <sfrench@samba.org>; linux-
> cifs@vger.kernel.org; samba-technical@lists.samba.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Long Li
> <longli@microsoft.com>
> Subject: Re: [PATCH 5/7] cifs: smbd: Protect memory registration using RCU
> 
> Hi Long,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on cifs/for-next] [also build test WARNING on
> v4.17-rc4 next-20180507] [if your patch is applied to the wrong git tree,
> please drop us a note to help improve the system]
> 
> url:
> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub
> .com%2F0day-ci%2Flinux%2Fcommits%2FLong-Li%2Fcifs-smbd-Make-upper-
> layer-decide-when-to-destroy-the-transport%2F20180508-
> 110150&data=02%7C01%7Clongli%40microsoft.com%7C56045b01aeae4e53b1
> 9408d5b4ae0502%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6366
> 13581873868980&sdata=a1Ds3qI7sRrLCE77Eoasifonm1rUQYi7rdUEnLnGOB4%
> 3D&reserved=0
> base:   git://git.samba.org/sfrench/cifs-2.6.git for-next
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    fs/cifs/smb2pdu.c:110:47: sparse: expression using sizeof(void)
>    fs/cifs/smb2pdu.c:681:26: sparse: expression using sizeof(void)
> >> fs/cifs/smb2pdu.c:2613:17: sparse: incompatible types in comparison
> >> expression (different address spaces)
>    fs/cifs/smb2pdu.c:2993:17: sparse: incompatible types in comparison
> expression (different address spaces)
>    fs/cifs/smb2pdu.c:3251:23: sparse: expression using sizeof(void)
>    fs/cifs/smb2pdu.c:3251:23: sparse: expression using sizeof(void)
>    fs/cifs/smb2pdu.c:3252:23: sparse: expression using sizeof(void)
>    fs/cifs/smb2pdu.c:3713:17: sparse: expression using sizeof(void)
>    fs/cifs/smb2pdu.c:3713:17: sparse: expression using sizeof(void)
> 
> vim +2613 fs/cifs/smb2pdu.c
> 
>   2565
>   2566	/*
>   2567	 * To form a chain of read requests, any read requests after the first
> should
>   2568	 * have the end_of_chain boolean set to true.
>   2569	 */
>   2570	static int
>   2571	smb2_new_read_req(void **buf, unsigned int *total_len,
>   2572		struct cifs_io_parms *io_parms, struct cifs_readdata *rdata,
>   2573		unsigned int remaining_bytes, int request_type)
>   2574	{
>   2575		int rc = -EACCES;
>   2576		struct smb2_read_plain_req *req = NULL;
>   2577		struct smb2_sync_hdr *shdr;
>   2578		struct TCP_Server_Info *server;
>   2579
>   2580		rc = smb2_plain_req_init(SMB2_READ, io_parms->tcon, (void
> **) &req,
>   2581					 total_len);
>   2582		if (rc)
>   2583			return rc;
>   2584
>   2585		server = io_parms->tcon->ses->server;
>   2586		if (server == NULL)
>   2587			return -ECONNABORTED;
>   2588
>   2589		shdr = &req->sync_hdr;
>   2590		shdr->ProcessId = cpu_to_le32(io_parms->pid);
>   2591
>   2592		req->PersistentFileId = io_parms->persistent_fid;
>   2593		req->VolatileFileId = io_parms->volatile_fid;
>   2594		req->ReadChannelInfoOffset = 0; /* reserved */
>   2595		req->ReadChannelInfoLength = 0; /* reserved */
>   2596		req->Channel = 0; /* reserved */
>   2597		req->MinimumCount = 0;
>   2598		req->Length = cpu_to_le32(io_parms->length);
>   2599		req->Offset = cpu_to_le64(io_parms->offset);
>   2600	#ifdef CONFIG_CIFS_SMB_DIRECT
>   2601		/*
>   2602		 * If we want to do a RDMA write, fill in and append
>   2603		 * smbd_buffer_descriptor_v1 to the end of read request
>   2604		 */
>   2605		if (server->rdma && rdata && !server->sign &&
>   2606			rdata->bytes >= server->smbd_conn-
> >rdma_readwrite_threshold) {
>   2607
>   2608			struct smbd_buffer_descriptor_v1 *v1;
>   2609			bool need_invalidate =
>   2610				io_parms->tcon->ses->server->dialect ==
> SMB30_PROT_ID;
>   2611
>   2612			rcu_read_lock();
> > 2613			rcu_dereference(server->smbd_conn);
>   2614			rdata->mr = smbd_register_mr(
>   2615					server->smbd_conn, rdata->pages,
>   2616					rdata->nr_pages, rdata->tailsz,
>   2617					true, need_invalidate);
>   2618			rcu_read_unlock();
>   2619			if (!rdata->mr)
>   2620				return -ENOBUFS;
>   2621
>   2622			req->Channel =
> SMB2_CHANNEL_RDMA_V1_INVALIDATE;
>   2623			if (need_invalidate)
>   2624				req->Channel = SMB2_CHANNEL_RDMA_V1;
>   2625			req->ReadChannelInfoOffset =
>   2626				cpu_to_le16(offsetof(struct
> smb2_read_plain_req, Buffer));
>   2627			req->ReadChannelInfoLength =
>   2628				cpu_to_le16(sizeof(struct
> smbd_buffer_descriptor_v1));
>   2629			v1 = (struct smbd_buffer_descriptor_v1 *) &req-
> >Buffer[0];
>   2630			v1->offset = cpu_to_le64(rdata->mr->mr->iova);
>   2631			v1->token = cpu_to_le32(rdata->mr->mr->rkey);
>   2632			v1->length = cpu_to_le32(rdata->mr->mr->length);
>   2633
>   2634			*total_len += sizeof(*v1) - 1;
>   2635		}
>   2636	#endif
>   2637		if (request_type & CHAINED_REQUEST) {
>   2638			if (!(request_type & END_OF_CHAIN)) {
>   2639				/* next 8-byte aligned request */
>   2640				*total_len = DIV_ROUND_UP(*total_len, 8) *
> 8;
>   2641				shdr->NextCommand =
> cpu_to_le32(*total_len);
>   2642			} else /* END_OF_CHAIN */
>   2643				shdr->NextCommand = 0;
>   2644			if (request_type & RELATED_REQUEST) {
>   2645				shdr->Flags |=
> SMB2_FLAGS_RELATED_OPERATIONS;
>   2646				/*
>   2647				 * Related requests use info from previous
> read request
>   2648				 * in chain.
>   2649				 */
>   2650				shdr->SessionId = 0xFFFFFFFF;
>   2651				shdr->TreeId = 0xFFFFFFFF;
>   2652				req->PersistentFileId = 0xFFFFFFFF;
>   2653				req->VolatileFileId = 0xFFFFFFFF;
>   2654			}
>   2655		}
>   2656		if (remaining_bytes > io_parms->length)
>   2657			req->RemainingBytes =
> cpu_to_le32(remaining_bytes);
>   2658		else
>   2659			req->RemainingBytes = 0;
>   2660
>   2661		*buf = req;
>   2662		return rc;
>   2663	}
>   2664
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.01
> .org%2Fpipermail%2Fkbuild-
> all&data=02%7C01%7Clongli%40microsoft.com%7C56045b01aeae4e53b19408
> d5b4ae0502%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63661358
> 1873868980&sdata=y3BYFeKEayhIfrs6hodamCPCyz8n3YQdN1yX3yXKs80%3D
> &reserved=0                   Intel Corporation
