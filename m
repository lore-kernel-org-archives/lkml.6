Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeERGDO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:03:14 -0400
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:26944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751588AbeERGDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:03:12 -0400
From: Long Li <longli@microsoft.com>
To: Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC PATCH 00/09] Implement direct user I/O interfaces for RDMA
Thread-Topic: [RFC PATCH 00/09] Implement direct user I/O interfaces for RDMA
Thread-Index: AQHT7j5z7ZPBhQKH/kKEIU/Pi9st66Q0i+MAgABrgwA=
Date: Fri, 18 May 2018 06:03:09 +0000
Message-ID: <MWHPR2101MB0729BFF8F0A397805087C3A4CE900@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
 <d5eaf67d-4b0d-9206-a016-67cb3b5a0df8@talpey.com>
In-Reply-To: <d5eaf67d-4b0d-9206-a016-67cb3b5a0df8@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:e::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0809;7:nVOFwf12NbQXW0YyIq2/SdF13JfRnItQLW6Q+3dYVlIbzo4eg6AouqO3PxvacF1AZ2AoJAK1tVkpj3PVX0lcsBIpbtRCl4wyixpn9rAwu6AMZTgF653YxqksKoR6NtDHVZKE4FhV+OWyjY+9YwohVVfUh/+UflCJpwJtDjusdRmvde7jbnKyRwl9QYGvHf2jW7GyJjyWZLa5rLPIlMhv67jvgZCgKMsTxPa0cfabBeGqNKXLwvYWZP6PLTjG9Wn4;20:cGK4dTmQ+M21eF54uFTJ5ItOmK+f8P+SBzsqz1Kc3H3iqJy74w64GoD19L5AzM7sSh1pda6k3ubEikoe7VJ45SUWtwkIZ6gLgnQR7aDYRhWkkYo1ki+7gQLZcRSpcoRQvxRuVykoiRza2k5nVBxToIAwxaCN2x0ZmSyDgi60mzo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:MWHPR2101MB0809;
x-ms-traffictypediagnostic: MWHPR2101MB0809:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB08096DCF16E772746AEB98E2CE900@MWHPR2101MB0809.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR2101MB0809;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0809;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(39380400002)(366004)(199004)(189003)(74316002)(486006)(476003)(86362001)(86612001)(186003)(53936002)(53546011)(59450400001)(6506007)(446003)(14454004)(10290500003)(478600001)(2900100001)(6436002)(11346002)(5660300001)(81166006)(229853002)(305945005)(6246003)(8936002)(10090500001)(7696005)(102836004)(2201001)(6116002)(9686003)(76176011)(7736002)(81156014)(55016002)(33656002)(8676002)(68736007)(5250100002)(8990500004)(105586002)(99286004)(106356001)(25786009)(316002)(3660700001)(2501003)(2906002)(3280700002)(46003)(22452003)(110136005)(97736004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0809;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nu6JvSjJCgJWmPV5MkhiPmUAuWI8dzzYEtjTokzj5kqgBl4fk0EhPcOYRdoGF8nBTrk1GnkORqQ5xvpbSVQV9AGwxPZqDi4lD/id2GdnrQLnNjyeqAM2hJCs2TFjG3wOWYbzsr8nRFY0WESEEfqjp7E4tbAY//68E81EjdNBdgclbc9o31dfI9AKSTTMwnG8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 49e249b7-7390-4b2a-c856-08d5bc85086a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e249b7-7390-4b2a-c856-08d5bc85086a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 06:03:10.0000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0809
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4I63Ijj023452

> Subject: Re: [RFC PATCH 00/09] Implement direct user I/O interfaces for
> RDMA
> 
> On 5/17/2018 8:22 PM, Long Li wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > This patchset implements direct user I/O through RDMA.
> >
> > In normal code path (even with cache=none), CIFS copies I/O data from
> > user-space to kernel-space for security reasons.
> >
> > With this patchset, a new mounting option is introduced to have CIFS
> > pin the user-space buffer into memory and performs I/O through RDMA.
> > This avoids memory copy, at the cost of added security risk.
> 
> What's the security risk? This type of direct i/o behavior is not uncommon,
> and can certainly be made safe, using the appropriate memory registration
> and protection domains. Any risk needs to be stated explicitly, and mitigation
> provided, or at least described.

I think it's an assumption that user-mode buffer can't be trusted, so CIFS always copies them into internal buffers, and calculate signature and encryption based on protocol used.

With the direct buffer, the user can potentially modify the buffer when signature or encryption is in progress or after they are done.

I also want to point out that, I choose to implement .read_iter and .write_iter from file_operations to implement direct I/O (CIFS is already doing this for O_DIRECT, so following this code path will avoid a big mess up).  The ideal choice is to implement .direct_IO from address_space_operations that I think eventually we want to move to.

> 
> Tom.
> 
> >
> > This patchset is RFC. The work is in progress, do not merge.
> >
> >
> > Long Li (9):
> >    Introduce offset for the 1st page in data transfer structures
> >    Change wdata alloc to support direct pages
> >    Change rdata alloc to support direct pages
> >    Change function to support offset when reading pages
> >    Change RDMA send to regonize page offset in the 1st page
> >    Change RDMA recv to support offset in the 1st page
> >    Support page offset in memory regsitrations
> >    Implement no-copy file I/O interfaces
> >    Introduce cache=rdma moutning option
> >
> >
> >   fs/cifs/cifs_fs_sb.h      |   2 +
> >   fs/cifs/cifsfs.c          |  19 +++
> >   fs/cifs/cifsfs.h          |   3 +
> >   fs/cifs/cifsglob.h        |   6 +
> >   fs/cifs/cifsproto.h       |   4 +-
> >   fs/cifs/cifssmb.c         |  10 +-
> >   fs/cifs/connect.c         |  13 +-
> >   fs/cifs/dir.c             |   5 +
> >   fs/cifs/file.c            | 351
> ++++++++++++++++++++++++++++++++++++++++++----
> >   fs/cifs/inode.c           |   4 +-
> >   fs/cifs/smb2ops.c         |   2 +-
> >   fs/cifs/smb2pdu.c         |  22 ++-
> >   fs/cifs/smbdirect.c       | 132 ++++++++++-------
> >   fs/cifs/smbdirect.h       |   2 +-
> >   fs/read_write.c           |   7 +
> >   include/linux/ratelimit.h |   2 +-
> >   16 files changed, 489 insertions(+), 95 deletions(-)
> >
