Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeDZSp6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:45:58 -0400
Received: from mail-dm3nam03on0099.outbound.protection.outlook.com ([104.47.41.99]:45518
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751481AbeDZSp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:45:56 -0400
From: Tom Talpey <ttalpey@microsoft.com>
To: Long Li <longli@microsoft.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v5] cifs: Allocate validate negotiation request through
 kmalloc
Thread-Topic: [PATCH v5] cifs: Allocate validate negotiation request through
 kmalloc
Thread-Index: AQHT3MOy/8ZS1Jl2Ek6lli1WtUatj6QTY3Sg
Date: Thu, 26 Apr 2018 18:45:53 +0000
Message-ID: <MWHPR2101MB08097B137B0C9CCEC2E902BDA08E0@MWHPR2101MB0809.namprd21.prod.outlook.com>
References: <20180425183005.9347-1-longli@linuxonhyperv.com>
In-Reply-To: <20180425183005.9347-1-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=ttalpey@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-26T18:45:52.3960344Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.218.182.144]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0810;7:Id9FQDG8IvGCnRL3jocYofqlMAXd8N1nN2o0sEIyDRRCWeq87NY29lqqO8pcOMxg0zdpHwCXM0GuWz7F9ooE419jFM1782wXWLTwKLk1pGXRhZMEsv5Fh2CZ4j5Ap+VxeLc8HbEJwqswmeCLO1Lal6Q3Okev1TR9kTho1AtC8Hd6TLJ5LKNYugHZc4HQ43HVGj7QBbiTB3RHRyJUPrXauPwlFSC4GU/Uj5XliB5itGns1lg6JgO/XCOVkiuP3a10;20:Me1j/lTeffGks37Vc7RJfmjeXZ9ECFnRxRW4VUAc3sOxtkt76S18jEYiD4bt1OOMd4dZAvHSDfNNyuQrJbbpe93E4WLe+3fwamCQHAWfUgWEeGztV7SmLV4p27a4JT9MLOUCKnKg5ur/iO8u3LScd8F+FXmXNUyrA4w/JKOJzqY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:MWHPR2101MB0810;
x-ms-traffictypediagnostic: MWHPR2101MB0810:
x-microsoft-antispam-prvs: <MWHPR2101MB0810774286C9268347A8C980A08E0@MWHPR2101MB0810.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR2101MB0810;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0810;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(366004)(376002)(396003)(39860400002)(199004)(189003)(13464003)(81166006)(305945005)(99286004)(5660300001)(76176011)(6246003)(3660700001)(11346002)(476003)(446003)(2906002)(7696005)(74316002)(81156014)(6116002)(9686003)(3846002)(6506007)(66066001)(86362001)(2201001)(55016002)(478600001)(53546011)(1511001)(68736007)(10290500003)(110136005)(10090500001)(33656002)(5250100002)(2900100001)(8990500004)(105586002)(316002)(15650500001)(7736002)(97736004)(102836004)(86612001)(14454004)(2501003)(26005)(6346003)(59450400001)(3280700002)(53936002)(486006)(8936002)(25786009)(22452003)(106356001)(6436002)(8676002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0810;H:MWHPR2101MB0809.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttalpey@microsoft.com;
x-microsoft-antispam-message-info: zaU0RZEjdGCLUhuZQeJsMD8ybDPFMBP4q9Yc3kQZqOVcFQScREgxg17tsYQJCIPR3ViFiqWO3uKnYuhXRY/gpDJJKnJpDcTKl2x0WwfHOCSE2rjS6dAskyPgmNWnukpZMwYzxmOxmLCBwu4vyFCQlff7Obl5xumyTflazSweX3+vkmqOpARJncNZsH1da60+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 25d167b8-6f16-4c5c-7985-08d5aba5f0c8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d167b8-6f16-4c5c-7985-08d5aba5f0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 18:45:53.9479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0810
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QIk5pg023343

> -----Original Message-----
> From: linux-cifs-owner@vger.kernel.org <linux-cifs-owner@vger.kernel.org> On
> Behalf Of Long Li
> Sent: Wednesday, April 25, 2018 2:30 PM
> To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org; samba-
> technical@lists.samba.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [PATCH v5] cifs: Allocate validate negotiation request through kmalloc
> 
> From: Long Li <longli@microsoft.com>
> 
> The data buffer allocated on the stack can't be DMA'ed, ib_dma_map_page will
> return an invalid DMA address for a buffer on stack. Even worse, this
> incorrect address can't be detected by ib_dma_mapping_error. Sending data
> from this address to hardware will not fail, but the remote peer will get
> junk data.
> 
> Fix this by allocating the request on the heap in smb3_validate_negotiate.
> 

Looks good.

Reviewed-By: Tom Talpey <ttalpey@microsoft.com>
 
