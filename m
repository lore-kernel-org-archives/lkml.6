Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeERTAm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:00:42 -0400
Received: from mail-co1nam03on0094.outbound.protection.outlook.com ([104.47.40.94]:22539
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751577AbeERTAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:00:41 -0400
From: Long Li <longli@microsoft.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC PATCH 09/09] Introduce cache=rdma moutning option
Thread-Topic: [RFC PATCH 09/09] Introduce cache=rdma moutning option
Thread-Index: AQHT7j52S1OAMuhyN0W+dltAndCFj6Q1FpiAgADBiMA=
Date: Fri, 18 May 2018 19:00:39 +0000
Message-ID: <MWHPR2101MB07297B07D495D66A1C9416FACE900@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
 <20180518002214.5657-10-longli@linuxonhyperv.com>
 <20180518072631.GA19250@infradead.org>
In-Reply-To: <20180518072631.GA19250@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:e::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0810;7:5VVSqGHFmKYwek4lwvMZj9FF/IhoeNmoFbTks7j20BUbTgIrxUtymgjlicIhHnRErQ3Jrc/FJYpjb0S9FpgGGKDmrqRZkYtgl/z5wkIPLJzgAbHHt+cbYxUqOs4a+DBPp1sNQbLVr40zIwMQoUoYZ0CrNK5q9PqL731JZFSz2BZkKIjy5IHmY/sNuOE+jg9NFGLgz1++pxiBSdqjby44Vy2B8myK2J3TVInZCJXiCrQnUP7z6t1EeGVwkLerTDCH;20:bJqOQ626y9dzEFUt7odYDpGvGvjsmpBRTfQoPHdfpvInoIEgcuHwzGHemN+AO5luVVtJ/LggZ9HTRQB8wqDJqJTqXyWkcO+i3C1RxbL7Hcu7KRFGCQTp1tM6CyEBzjKGIQgSlkpnImVQSrg8DM45/7QsNzUwfQyr7L2vA+acnlo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:MWHPR2101MB0810;
x-ms-traffictypediagnostic: MWHPR2101MB0810:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB0810500D8A428638D5394003CE900@MWHPR2101MB0810.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR2101MB0810;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0810;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(39860400002)(366004)(189003)(199004)(76176011)(7696005)(6916009)(8936002)(68736007)(446003)(6506007)(186003)(11346002)(6436002)(55016002)(229853002)(46003)(7736002)(305945005)(2906002)(5250100002)(5660300001)(81156014)(86612001)(54906003)(86362001)(316002)(476003)(3660700001)(22452003)(81166006)(486006)(3280700002)(102836004)(8676002)(99286004)(74316002)(33656002)(97736004)(10090500001)(10290500003)(478600001)(14454004)(8990500004)(2900100001)(9686003)(53936002)(4326008)(6246003)(6116002)(25786009)(106356001)(105586002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0810;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: l8JrO5FhF1WGevmCLQ31NJrW2wtiOJzUjG1PaFQMKl3I0/XyCVhau/fdcgvawLqsv+dcPrK2fwUzA/PsTJS6Zb5eOUKtFyjsxg1go3YdXWY/H3/x/vZQmZZfPHwtX+kXoeteH9Prl2x5uUAkglYWopKmOkNc3nL2jbm61LLf9wksi1jR3VtX1IFbTCmZntyX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 54deae2a-1e09-4cbf-d64e-08d5bcf1a587
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54deae2a-1e09-4cbf-d64e-08d5bcf1a587
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 19:00:39.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0810
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4IJ0ovr014535

> Subject: Re: [RFC PATCH 09/09] Introduce cache=rdma moutning option
> 
> On Thu, May 17, 2018 at 05:22:14PM -0700, Long Li wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > When cache=rdma is enabled on mount options, CIFS do not allocate
> > internal data buffer pages for I/O, data is read/writen directly to user
> memory via RDMA.
> 
> I don't think this should be an option.  For direct I/O without signing or
> encryption CIFS should always use get_user_pages, with or without RDMA.

Yes this should be done for all transport. If there are no objections, I'll send patches to change this.
