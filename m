Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754884AbeCHDzp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 22:55:45 -0500
Received: from mx0a-00272701.pphosted.com ([67.231.145.144]:57288 "EHLO
        mx0a-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750761AbeCHDzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 22:55:43 -0500
From: "French, Nicholas A." <naf@ou.edu>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: ivtv: use arch_phys_wc_add() and require PAT disabled
Thread-Topic: ivtv: use arch_phys_wc_add() and require PAT disabled
Thread-Index: AQHTsXBOQGvUe478EUWv+ObGTFYl4qO7oBEAgAgWYqaAAXQ9gIAAhKi/
Date: Thu, 8 Mar 2018 03:16:29 +0000
Message-ID: <DM5PR03MB30352350D588A81D2D02BE93D3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
References: <DM5PR03MB3035EE1AFCEE298AFB15AC46D3C60@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180301171936.GU14069@wotan.suse.de>
 <DM5PR03MB303587F12D7E56B951730A76D3D90@DM5PR03MB3035.namprd03.prod.outlook.com>,<20180307190205.GA14069@wotan.suse.de>
In-Reply-To: <20180307190205.GA14069@wotan.suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.185.212.125]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR03MB3210;20:f+Zt4epi7X2vKABeBPlZ9AhFo/zL5oZ7Dl3BtvBkRUGWmkuASt7LqAlxAHqqkTcSCq0GHFn7fQosteW3Jng6HU0/kWsp4lDt3m40s/yiwagB9ayBXGRxMAAmUh4NvK9FmR2NL4J5sTSKWSozK+1OFOVyRi2qQGmbsnwNOL1liZo=
x-ms-office365-filtering-correlation-id: 69198aa1-3527-4d6d-2acb-08d584a2fc1a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB3210;
x-ms-traffictypediagnostic: DM5PR03MB3210:
x-microsoft-antispam-prvs: <DM5PR03MB321023434343A8CA269EBB24D3DF0@DM5PR03MB3210.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041288)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR03MB3210;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3210;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(5890100001)(6916009)(2900100001)(8936002)(59450400001)(97736004)(6246003)(478600001)(81156014)(81166006)(88552002)(4326008)(6506007)(305945005)(5660300001)(105586002)(3280700002)(229853002)(25786009)(74316002)(53936002)(33656002)(7736002)(106356001)(6436002)(14454004)(75432002)(76176011)(786003)(186003)(2906002)(66066001)(7696005)(68736007)(54906003)(2950100002)(8676002)(55016002)(93886005)(5250100002)(6116002)(3660700001)(99286004)(3846002)(86362001)(316002)(26005)(102836004)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR03MB3210;H:DM5PR03MB3035.namprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: WF8+hOUkyxu24U1uhWx22Q7lqJCcyVkGDzhI5aJnVMzYIxmPB5J02qKTaKi3K0fPX+iPxdiPJAjZdXyCLa9aSHmvjiPws1+o4KHkUgk70TYcTWQIyIxduaaOPQ3K6Ab9UO7sFg39NMatzmmBq8VnoOx5GUaxCBoT9XsIN99WHIoGzLlJ2uG2sjx9qzCwfQxfpu7bL2n4KS3wPrqFvvD0hWQRFEalNcgc1A9QYBHd7SE1VleTelkSDX3iZV38PzmyTIkQsEqk+Ngd2K8fVObN2ZPkMCYzk3h0plzMHeHBbb4eJa9SbhSgt3/hxu2EJLQQ4cKZ4jBAyGgyvk9HK1fdMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: ou.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 69198aa1-3527-4d6d-2acb-08d584a2fc1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 03:16:29.0372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9c7de09d-9034-44c1-b462-c464fece204a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3210
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=758 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803080037
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w283tqWI025170

On Wed, Mar 07, 2018 at 07:02:05PM +0000, Luis R. Rodriguez wrote:
> On Tue, Mar 06, 2018 at 09:01:10PM +0000, French, Nicholas A. wrote:
> > any reason why PAT can't be enabled for ivtvfb as simply as in the attached
> > patch?
>
> Prior to your change the OSD buffer was obtained using the itv->dec_mem + oi->video_rbase
> given itv->dec_mem was initialized via [...]
>         itv->dec_mem = ioremap_nocache(itv->base_addr + IVTV_DECODER_OFFSET - oi->video_buffer_size,
>                                 IVTV_DECODER_SIZE);

Ah, I see. So my proposed ioremap_wc call was only "working" by aliasing the ioremap_nocache()'d mem area and not actually using write combining at all.

> So what I'd do is change the ioremap_nocache()'d size by substracting
> oi->video_buffer_size -- but then you have to ask yourself how you'd get
> that size. If its something you can figure out then great.

Size is easy since its hardcoded, but unfortunately getting the offset of the framebuffer inside the decoders memory to remove from the ioremap_nocache call is a chicken and egg problem: the offset is determined by querying the firmware that has been loaded to the decoder. the firmware itself will be loaded after the ioremap_nocache call at an offset from the address it returns.

So unless there is a io-re-remap to change the caching status of a subset of the decoder's memory once we find out what the framebuffer offset is inside the original iremap_nocache'd area, then its a no go for write combining to the framebuffer with PAT.

On the other hand, it works fine for me with a nocache'd framebuffer. It's certainly better for me personally to have a nocache framebuffer with PAT-enabled than the framebuffer completely disabled with PAT-enabled, but I don't think I would even propose to rollback the x86 nopat requirement in general. Apparently the throngs of people using this super-popular driver feature haven't complained in the last couple years, so maybe its OK for me to just patch the pat-enabled guard out and deal with a nocache'd framebuffer.

- Nick    
