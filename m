Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeERU6N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:58:13 -0400
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:35376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751298AbeERU6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:58:10 -0400
From: Long Li <longli@microsoft.com>
To: Steve French <smfrench@gmail.com>
CC: Christoph Hellwig <hch@infradead.org>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC PATCH 09/09] Introduce cache=rdma moutning option
Thread-Topic: [RFC PATCH 09/09] Introduce cache=rdma moutning option
Thread-Index: AQHT7j52S1OAMuhyN0W+dltAndCFj6Q1FpiAgADBiMCAAB19AIAAASJw
Date: Fri, 18 May 2018 20:58:08 +0000
Message-ID: <MWHPR2101MB0729D163B903A0198A85AB4BCE900@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
 <20180518002214.5657-10-longli@linuxonhyperv.com>
 <20180518072631.GA19250@infradead.org>
 <MWHPR2101MB07297B07D495D66A1C9416FACE900@MWHPR2101MB0729.namprd21.prod.outlook.com>
 <CAH2r5mtzUJUakbPr_kzrDcqVPC9QuS7K8MXejNz7F=Uii6K5Kg@mail.gmail.com>
In-Reply-To: <CAH2r5mtzUJUakbPr_kzrDcqVPC9QuS7K8MXejNz7F=Uii6K5Kg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:e::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0812;7:xmOGkwyeyiMJoowka/VMY6sDW7s59pam69Flbg5ncw7tM2bhRUtXJw7ls7Yb6400dGUtCkg5bIpJC9Tr2dewQtCs4Y0wx27PPRvWfVnLgQjuflsXI1CxTUy/wxrG6n6UrQJvYXxz16hd3OkwF7rkgASCjiyYDRUZmJeGC9YtmIPajkxEMeZfoszGDWsmfQ4t2U0NuWuhlZvaXOo2pY/zIJ4GN6PTvGFPNs9ljxZ5PKLqyudQP38psNX0ZtAdGSHF;20:2b+OeZB+hq2WzAdwFMWunfA9peY76Kpdbc+h0mZusFYs/d6oyjWiqrGTAPtX2NWnmOGIplVEaI5c2NSYFrJLuydZTC7GF6QITt9GTMzAg4szaawkwoiL3oQ2FIOUxRaK0Jvyvkyk4Wrx+izzZBHuDGJjloXKgtPVR4t1A/IcSCA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:MWHPR2101MB0812;
x-ms-traffictypediagnostic: MWHPR2101MB0812:
x-microsoft-antispam-prvs: <MWHPR2101MB08127728BCB52DEBB71502FACE900@MWHPR2101MB0812.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR2101MB0812;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0812;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(39860400002)(396003)(189003)(199004)(53546011)(102836004)(6506007)(76176011)(7696005)(22452003)(93886005)(316002)(97736004)(99286004)(186003)(6346003)(8676002)(3280700002)(3660700001)(25786009)(81166006)(81156014)(10090500001)(8936002)(4326008)(2906002)(2900100001)(8990500004)(54906003)(5250100002)(86612001)(10290500003)(6916009)(5660300001)(478600001)(33656002)(6246003)(105586002)(106356001)(86362001)(39060400002)(229853002)(68736007)(305945005)(7736002)(46003)(14454004)(446003)(11346002)(1411001)(6436002)(6116002)(486006)(55016002)(9686003)(74316002)(476003)(53936002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0812;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-message-info: kWzVwclyFK8SsoF2Pi3B1dnVx9Nvm81p/HTHcQMc4GmjhK5AjHBNlDtsZqAk5vpJQ3VRG08YOLoUa53KpyLeduSfCl2MtfnchJsK/wtcP1+PHoLq6t3ISH7yZCejf5LEkbhJPXnD52PNFGgOO/QfSCaWOXmJO2/CEMP3pIEQnNwAc18xsi0QzXhGGK7Mvcol
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 37d31709-4534-420b-cf1a-08d5bd020efe
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d31709-4534-420b-cf1a-08d5bd020efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 20:58:08.0376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0812
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IKwKog021933

> Subject: Re: [RFC PATCH 09/09] Introduce cache=rdma moutning option
> 
> On Fri, May 18, 2018 at 12:00 PM, Long Li via samba-technical <samba-
> technical@lists.samba.org> wrote:
> >> Subject: Re: [RFC PATCH 09/09] Introduce cache=rdma moutning option
> >>
> >> On Thu, May 17, 2018 at 05:22:14PM -0700, Long Li wrote:
> >> > From: Long Li <longli@microsoft.com>
> >> >
> >> > When cache=rdma is enabled on mount options, CIFS do not allocate
> >> > internal data buffer pages for I/O, data is read/writen directly to
> >> > user
> >> memory via RDMA.
> >>
> >> I don't think this should be an option.  For direct I/O without
> >> signing or encryption CIFS should always use get_user_pages, with or
> without RDMA.
> >
> > Yes this should be done for all transport. If there are no objections, I'll send
> patches to change this.
> 
> Would this help/change performance much?

On RDMA, it helps with I/O latency and reduces CPU usage on certain I/O patterns.

But I haven't tested on TCP. Maybe it will help a little bit.

> 
> 
> 
> --
> Thanks,
> 
> Steve
