Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="C7Goe5qL"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A03C9606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeFFQBV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:01:21 -0400
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:48634
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752042AbeFFQBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:01:20 -0400
From: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: "Tran, Quinn" <Quinn.Tran@cavium.com>,
        "William.Kuzeja@stratus.com" <William.Kuzeja@stratus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Li Wang <liwang@redhat.com>
Subject: Re: qla2xxx cause BUG on kernel-4.17-rc6
Thread-Topic: qla2xxx cause BUG on kernel-4.17-rc6
Thread-Index: AQHT+VlWebSsauP2jUycx2vUO1XVIqRTa1NGgAABKYA=
Date: Wed, 6 Jun 2018 16:01:17 +0000
Message-ID: <7988FB77-4AE4-4935-B7B7-F7584674981B@cavium.com>
References: <CAEemH2dj3SVsNZOsZSjGZ0nF=a3YZp=i9z11vYTHByRQzpFkfQ@mail.gmail.com>
 <yq1a7s7ewmw.fsf@oracle.com>
In-Reply-To: <yq1a7s7ewmw.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Himanshu.Madhani@cavium.com;
x-originating-ip: [173.186.134.106]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR0701MB3751;7:CZeRsEvGgMl7u9nLDLGXNX4B3Qqu+84A77YBvhIJ01ROvC50Ewh5KXfY023iSFF5OMQCM4wra4sfb31Qs5b3Q8cTaFafrC5mNPlGN3aJqgEBYW+/YZ3sIUmKu8Xd5rZex33pcl6pw55uNomDbKe0q/vejuq7aDBB/1GCzbi9VQmKP+BSSrd7CD8PJ6DKwr2ArpvTvqHqkm6nzXHA/iO+MeHavex0Mkxnv01ztX/RfzEGTNW2huIWYDH3Wm8DlwXQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(189003)(51234002)(199004)(6116002)(8656006)(33656002)(81156014)(54906003)(81166006)(8936002)(53936002)(106356001)(316002)(8676002)(7736002)(305945005)(6916009)(5250100002)(4326008)(72206003)(3280700002)(6436002)(105586002)(2906002)(6486002)(3660700001)(6246003)(6512007)(97736004)(229853002)(25786009)(14454004)(478600001)(83716003)(66066001)(86362001)(45080400002)(2616005)(3846002)(11346002)(76176011)(36756003)(5660300001)(59450400001)(53546011)(2900100001)(82746002)(6506007)(476003)(186003)(68736007)(26005)(99286004)(486006)(446003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3751;H:DM5PR0701MB3750.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR0701MB3751;
x-ms-traffictypediagnostic: DM5PR0701MB3751:
x-microsoft-antispam-prvs: <DM5PR0701MB375193819F7462587AF1CEB0F5650@DM5PR0701MB3751.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR0701MB3751;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0701MB3751;
x-forefront-prvs: 06952FC175
x-microsoft-antispam-message-info: fQ5UPah8agNFCyG9L6uQYkL72AJp/IB89POFnHWWimGy8zcLydEtLPzVhZ+hE00/gaInYnjcwTE9/nUPdclM3T/Vzl7aAuV+VwVpBRGKPbp6ZXK5TLBXxPkoc3O9zufu+HIFwwx8V4l9cRRLGsQlPQTLJd/0Wur0cKozKdhrvJJKaenzl2CrX5d6Ad/NtEmHsp3CECSdX0on8kLelzUjEQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96640673BBA383408570CFAB1CCAEA79@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7f5dc6a1-ffe5-4b63-3097-08d5cbc6bcde
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5dc6a1-ffe5-4b63-3097-08d5cbc6bcde
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 16:01:17.3673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3751
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 6, 2018, at 8:56 AM, Martin K. Petersen <martin.petersen@oracle.co=
m> wrote:
>=20
>=20
> Himanshu,
>=20
> Ping?
>=20

Will look at this one. Sorry, somehow fell thru cracks.=20


>> Hi scsi experts,
>>=20
>> Not sure who is the right person to ask, I just hit this bug on my HP
>> DL385 platform, can any one of you take a look?
>>=20
>> system config:
>> -----------------
>> HP ProLiant DL385 G7
>> AMD Opteron(TM) Processor 6234
>> 16384 MB memory, 369 GB disk space
>>=20
>>=20
>> [   24.539274] qla2xxx [0000:0c:00.7]-500a:5: LOOP UP detected (10 Gbps)=
.
>> [   24.577259] BUG: unable to handle kernel NULL pointer dereference
>> at 0000000000000102
>> [   24.623133] PGD 0 P4D 0
>> [   24.636760] Oops: 0000 [#1] SMP NOPTI
>> [   24.656942] Modules linked in: i2c_algo_bit drm_kms_helper
>> sr_mod(+) syscopyarea sysfillrect sysimgblt cdrom fb_sys_fops
>> ata_generic ttm pata_acpi sd_mod ahci pata_atiixp sfc(+) qla2xxx(+)
>> libahci drm qla4xxx(+) nvme_fc hpsa mdio libiscsi qlcnic(+)
>> nvme_fabrics scsi_transport_sas serio_raw mtd crc32c_intel libata
>> nvme_core i2c_core scsi_transport_iscsi tg3 scsi_transport_fc bnx2
>> iscsi_boot_sysfs dm_multipath dm_mirror dm_region_hash dm_log dm_mod
>> [   24.887449] CPU: 0 PID: 177 Comm: kworker/0:3 Not tainted 4.17.0-rc6 =
#1
>> [   24.925119] Hardware name: HP ProLiant DL385 G7, BIOS A18 08/15/2012
>> [   24.962106] Workqueue: events work_for_cpu_fn
>> [   24.987098] RIP: 0010:__queue_work+0x1f/0x3a0
>> [   25.011672] RSP: 0018:ffff992642ceba10 EFLAGS: 00010082
>> [   25.042116] RAX: 0000000000000082 RBX: 0000000000000082 RCX:
>> 0000000000000000
>> [   25.083293] RDX: ffff8cf9abc6d7d0 RSI: 0000000000000000 RDI:
>> 0000000000002000
>> [   25.123094] RBP: 0000000000000000 R08: 0000000000025a40 R09:
>> ffff8cf9aade2880
>> [   25.164087] R10: 0000000000000000 R11: ffff992642ceb6f0 R12:
>> ffff8cf9abc6d7d0
>> [   25.202280] R13: 0000000000002000 R14: ffff8cf9abc6d7b8 R15:
>> 0000000000002000
>> [   25.242050] FS:  0000000000000000(0000) f9b5c00000(0000)
>> knlGS:0000000000000000
>> [   25.977565] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   26.010457] CR2: 0000000000000102 CR3: 000000030760a000 CR4:
>> 00000000000406f0
>> [   26.051048] Call Trace:
>> [   26.063572]  ? __switch_to_asm+0x34/0x70
>> [   26.086079]  queue_work_on+0x24/0x40
>> [   26.107090]  qla2x00_post_work+0x81/0xb0 [qla2xxx]
>> [   26.133356]  qla2x00_async_event+0x1ad/0x1a20 [qla2xxx]
>> [   26.164075]  ? lock_timer_base+0x67/0x80
>> [   26.186420]  ? try_to_del_timer_sync+0x4d/0x80
>> [   26.212284]  ? del_timer_sync+0x35/0x40
>> [   26.234080]  ? schedule_timeout+0x165/0x2f0
>> [   26.259575]  qla82xx_poll+0x13e/0x180 [qla2xxx]
>> [   26.285740]  qla2x00_mailbox_command+0x74b/0xf50 [qla2xxx]
>> [   26.319040]  qla82xx_set_driver_version+0x13b/0x1c0 [qla2xxx]
>> [   26.352108]  ? qla2x00_init_rings+0x206/0x3f0 [qla2xxx]
>> [   26.381733]  qla2x00_initialize_adapter+0x35c/0x7f0 [qla2xxx]
>> [   26.413240]  qla2x00_probe_one+0x1479/0x2390 [qla2xxx]
>> [   26.442055]  local_pci_probe+0x3f/0xa0
>> [   26.463108]  work_for_cpu_fn+0x10/0x20
>> [   26.483295]  process_one_work+0x152/0x350
>> [   26.505730]  worker_thread+0x1cf/0x3e0
>> [   26.527090]  kthread+0xf5/0x130
>> [   26.545085]  ? max_active_store+0x80/0x80
>> [   26.568085]  ? kthread_bind+0x10/0x10
>> [   26.589533]  ret_from_fork+0x22/0x40
>> [   26.610192] Code: 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
>> 00 41 57 41 89 ff 41 56 41 55 41 89 fd 41 54 49 89 d4 55 48 89 f5 53
>> 48 83 ec 0 86 02 01 00 00 01 0f 85 80 02 00 00 49 c7 c6 c0 ec 01 00 41
>> [   27.308540] RIP: __queue_work+0x1f/0x3a0 RSP: ffff992642ceba10
>> [   27.341591] CR2: 0000000000000102
>> [   27.360208] ---[ end trace 01b7b7ae2c005cf3 ]---
>=20
> --=20
> Martin K. Petersen	Oracle Linux Engineering

Thanks,
- Himanshu
