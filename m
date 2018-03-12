Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750988AbeCLEET (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:04:19 -0400
Received: from mx0b-00272701.pphosted.com ([208.86.201.61]:58586 "EHLO
        mx0b-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750725AbeCLEEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:04:16 -0400
Date: Sun, 11 Mar 2018 23:04:02 -0500
From: Nick French <naf@ou.edu>
To: Ian Armstrong <mail01@iarmst.co.uk>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: ivtv: use arch_phys_wc_add() and require PAT disabled
Message-ID: <20180312040401.GA4814@tivo.lan>
References: <20180301171936.GU14069@wotan.suse.de>
 <DM5PR03MB303587F12D7E56B951730A76D3D90@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180307190205.GA14069@wotan.suse.de>
 <DM5PR03MB30352350D588A81D2D02BE93D3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180308040601.GQ14069@wotan.suse.de>
 <20180308041411.GR14069@wotan.suse.de>
 <DM5PR03MB3035CCBF9718D7E42B35357FD3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
 <MWHPR03MB30402C0F8B8F457F5F760412D3DD0@MWHPR03MB3040.namprd03.prod.outlook.com>
 <CAB=NE6VvDNbe=XsfG0tYeFcxcXzsRkHnZxVHM79-V+1t6foU5g@mail.gmail.com>
 <20180311232438.2b204c51@spike.private.network>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311232438.2b204c51@spike.private.network>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [155.94.246.64]
X-ClientProxiedBy: MWHPR2201CA0058.namprd22.prod.outlook.com
 (2603:10b6:301:16::32) To DM5PR03MB3036.namprd03.prod.outlook.com
 (2603:10b6:3:11e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38663999-dfa6-4756-c1c6-08d587ce4e4b
X-Microsoft-Antispam: UriScan:(275421118447822);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7167020)(7153060)(7193020);SRVR:DM5PR03MB3036;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3036;3:sVAK9TLk+DK+oA7B5zIkFQGY/xzS1+8EasLzr4qF/3z4CI2P+ajPO51FX1EW8nbznMKoDsh+DQwlpVoVH2rqLZ885jr/7qFvMpXF2uvNFu9CNGEUUDbolH0fX8ktNn84usAL9UAiM9KqXdbR7Segg+y+wB53J5Cc5nzj/PW877USvhkbNkdqpHYdp8gAPrfau+rSsM/M2cA+u5wvDUAzYhhmo3rUlI7w+ycpJ77wDYYaPM2SbNFhi0EcU3f4ck+Rr7A61TXKK9YWhXY/T4Z7Dbx6FTYSq6HG6WaJULEK1OI=;25:MfCCUCYXB7P5rQQPLC6RtWahuI/3QGzJ1C+p1aYwuAXIYuT/4YX3sqK+a02u1d0iMVD7LGtmI5w7ulwYspPlMjz1n/MdxZnkQCrhNmHIx6yenPxnfXpK/EFvmQ6WMBvd81IDYqO8etwcCmSW44neatjkWs8QGFKQmyxdl5e+pHZqFjM1Rjtg5zn0a4BM4HxOYTTb8dxS4PnvFnaK1ZLHUseY8GghJygttQZN+KcWgMZLQSv4+988thhBDZB+32h/gJIfhrrpZJKyh0z7mmS7Hm0gvt0CS2zwqnAhSewGG1/Sq9mwCaJPimRgL42wO5c0JRJFvgp8QRHRDs+2s/fZ+Q==;31:Od4A6l3wkn09jXRu6CgSBNXJ2mRlR0Ugujc5vUJS7j0Dj1PuXi6UlLBiXuqht9G05JsG/akG1OLfJJdd8P5UAxS3+svgzsQa7u5pLAXsegM1xdbckra50qiaEe5fce0zNcKMcOj5xQAFJvGgjNKSdXJpK712vUH5gpa56rh7QbLhlfgmwi7VUBEHOgJ6Pw1yn9DrNowKTDvqnacP91UeZgNiC+uddttRvDpaJZlMpRE=
X-MS-TrafficTypeDiagnostic: DM5PR03MB3036:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3036;20:MQ2gh571DnqInaY3BHrwfen8RdNOTQvtwSgay27IF+BChCp58AWNihg/dy0NP3Cg+OqWrNCp7TVFAkHilx+PwAxmXXhLM1PEMArlTTravpmaUvfOLZoSa7bhIdS2LxITLEIPg53BmKaPFPOw2Dq3ABHrhkZNqBEGsrog+OdktJgcVSxitmIwvYmzoctcxCg9l7BOVhwmKbBIB1UW5ubZ55Qi7Y293eRhu7L1dXQjCxshAKsLel0DkN2RB9VPnNZUjBUh/DocsVAiU/4xN2sv23AYFsO7g89DtbkAb8VYvYprDc5qIKMTVF5c5VOP0j2Y3V6Nhd5cd9AD+ZWMLRL6s0upPvFYAd6G9uQ/umO/dKS4J2Lpoc9zvseqywPLJE+OSxlZAu8BmyYUCiqjPgAFVD7cBLBNHbMn6xmIjzQ/vIBycq4KMhdiJqiAYHDDdHrTV6x2AOQiDUmhY8+D7EWB5sE8W/bz2IwgBPvfL+REmRDdfeoLnMTvPcqEGHoTFupS;4:lIvY8bAjX8vWWlFX3i6E54IqtHLoz2u1wnCuYlgX5ua5/yJS38Gx2n7gOyWN3Svpgt+fh4Nrny2r75w3WaUKf3ZNEx/ru1Hc1SBOE2LmGi2uZfSaTdDCe6V7Y7F0G1/VEKlvsOYNShAxwsExth97CCkqoU31GUrXAHTaPSljp7vNEWxuqyM6XcGmPRR3/WuqcQ6Jijl/vbfsmemX5Y1q/fgl2vUBd6Bk2hSDikCjT4RZZwRKqHFb+/zBkbWF9toHkwAH+J9H2Ei22LYTvERrzy44Q3WRTG89nhVOC/Vk8w3/oykV4WBfYmSOD6lUOswLnG9Iex911jsd5WlLzVSCrr/xfarbO+OEMLnzafx4Mpo=
X-Microsoft-Antispam-PRVS: <DM5PR03MB30362BE48B28041B15F00929D3D30@DM5PR03MB3036.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(179259710895377)(275421118447822);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR03MB3036;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3036;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(39860400002)(366004)(396003)(189003)(199004)(23726003)(97736004)(16586007)(8936002)(88552002)(786003)(316002)(7696005)(52116002)(81156014)(76176011)(81166006)(4326008)(229853002)(53936002)(66066001)(6246003)(1250700005)(86362001)(36756003)(1076002)(55016002)(93886005)(58126008)(2906002)(54906003)(9686003)(69596002)(8676002)(6116002)(3846002)(25786009)(47776003)(478600001)(33656002)(21086003)(106356001)(5660300001)(386003)(16526019)(305945005)(75432002)(186003)(6506007)(55236004)(105586002)(2950100002)(6916009)(68736007)(50466002)(6666003)(26005)(7736002)(2320200001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR03MB3036;H:tivo.lan;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3036;23:dXHUZ2yfCT22UMcTm5z6mLmxs2nj+RWA8uql2kGM8?=
 =?us-ascii?Q?Hbmuqolr5wNl5bHcOztOMA1AmDqLOHujsynCEYkMm65XEzo1i5fKbj0c/0ci?=
 =?us-ascii?Q?RbQv4Frtwe3mA+TY7+zHS2Wb4x294m0EF70Tg3NQQaWJH0pyqDI7Di+8CeXH?=
 =?us-ascii?Q?Cxr8hAN+E6OTMaOcVPxRNZSAC8gBnbGA97L9D09P/zxgdTIBGdCztoiQSts9?=
 =?us-ascii?Q?XjN/MGIyKgaUXMx4UwteLMnRpEK3ytefe0tiQsT5tYOo9MJLlGerW/oqoVzN?=
 =?us-ascii?Q?M4dxf0lsm45psmPGJErrnh/pqlr2wXnb5SJVZs6mm5v+a2gcH7s2AFBfM2K2?=
 =?us-ascii?Q?+/wkB+N6bjeoCXtg2ou+PdubHF9QbcweBmp+oxFgxeH6CkhmjxL1KfJ4gL78?=
 =?us-ascii?Q?TYclm7b9Ga2mSHCxzRloPwNvTq9cKKPGzkJgO3BZV0JSG19uZWmb8fqKG6TC?=
 =?us-ascii?Q?VkbFwtNw6kwCq8RqYbUPuNylxxH9JYhVCO0eQTLNRiwrv9YLOpj7tDJS1Ruv?=
 =?us-ascii?Q?vKyqz2UyKOnnmzfzlBuJkXd/6vQMJQ0bAdRSwf9QsM0z1awO9sWTz7If/4NG?=
 =?us-ascii?Q?H0bPmo3yLja5xswpSGlgvFass3jXxYQ6jq1jjaFG7YZsAgz+uQk7OGrT3PIL?=
 =?us-ascii?Q?YFc4HTp+F+dC3cH9yOTJKCB92T+l9bg481EaTj4in8FC/Wt/I0RumelLQ3wR?=
 =?us-ascii?Q?HrEhF14o8bFq7ddYzEoMp81hgKLXe8Ohf+PAVZAV6PgZWnYLo/jWyGbUdxhb?=
 =?us-ascii?Q?glKK7ALpigA3PN1O0Tu8Ymgl7+M4v8eoOtNoAfSkmWRhQ+h09uAeblMAX+BV?=
 =?us-ascii?Q?7cgzzTz2Dz1UvGOx0d9UOcs0Yd9BHUfSxy3rwdz46JdmhAJVdW7dlpDDMyiL?=
 =?us-ascii?Q?oJikH9fuqJex3/FjihgPxrLSFQYVPCFMDQuWw7jA/HexSW/91dyU9DWKVPuB?=
 =?us-ascii?Q?65eBnzXzHi2EtfuixC5XcdQAt2u6jVWDTd2igXpvDn4t8IXYfTBaxQ3VaJBo?=
 =?us-ascii?Q?4DIZ/i2Q0l6efWplaF8hLkOgVjEIX2byYZfoNsMHrXFa0MO1+6VUAVFz77sV?=
 =?us-ascii?Q?NrZc9pOHdu58VghQ7Y3xizuhVCXKx001tEnVO5sEbdSn9k5XBh67INcYD95g?=
 =?us-ascii?Q?t0bZ954B4v3I7gOTXcVQOmiQTDaGA34Lja4bRQz5ZJiY5dE5om7PpUGdh5on?=
 =?us-ascii?Q?gAOwYxmsIrLXdpRbRti/zArJh2Gjg/AmhqpmeE1oWEMILqxBjZTQJBfS7y+K?=
 =?us-ascii?Q?dX00lXrsSTIDJW9B55DC6ryvmBVeefPDwyZw6XCNkYdSM+k6EUFxznXQjsbk?=
 =?us-ascii?Q?4iPjH5LCFfZdB+QKgtmaaNeRHLT3bJk6Z3G2+eGthdWcyJ67ivxlOIJt6cM5?=
 =?us-ascii?Q?3c+pY5CaNF2ck7XGVNulVGYEI2F2RQDUiPovXvb0+nDzc5NizDE0q9nnQP10?=
 =?us-ascii?Q?r7qMu+ohZLaSl4j1Kxkn7k5nsgpt5U=3D?=
X-Microsoft-Antispam-Message-Info: 2Qf5BQN/kDfwH9aJOrFTDEvsqmF5Rm5d1JRM7fr31Z4syW0DuzG4MCqxaCCBpWYqeeGFN1Lt0cNo7w1AjddsGdcbHl9l1ybHwlgHcL+w7iojoEAyVKQ/qzkseK9mvULBvFMTfRKWp5yVuTEvJuy/ijTJ9rfgI1Gto+AmSHCRwJR1+XjijqgSwYLqZh07fi+7
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3036;6:59sjDZr15MqjsHb24I3AsJi9yvy3snjdxfn45//Fk0emPbzghyY7rdQIVvYnp6W4HMWHwub9axImH+e+0i18pQaSuEp+xMyPHUcc1D0FRefEIKXhZw/TGXI9licHJN/7uQ+sun8lwBM2o+WNrgAh+tlCpAVyhiCzR7NQZt7Y92FY1CrVuKxYmm8IHkiknwo8/rG+bfgsFR5vBIdyhf7WA7ByqSrZarKl9T/YLEGlzq70FTQj6dQ/KED16uk3d/C+nEAg9/mi5QEj1vo1IPqufdllzswCEwOU/aM/2rsLco+o07qX+sIxUv1blyUJDLUe9/u3fBawHhCppbJShts0VXLszA4ccjYOIPaKUZKqImQ=;5:zL3NtdSxXQRhcuP5qHh2Tt2jWGXs7xW58naWfR2fxbjklhwCBH9XGZbr3TGDg0FtyvoUspy5oeYUrS+PTpN5Nxtntevb8WklCoBcZuR3oWnN2UK5bUqfAYg7FUSKbNWtJMlcfK+6luNyWT6xPFbQictDAmPC9DsGEAuk1b7e9FA=;24:vrh7z8w0CAOl3kPWfbTCqPmrOI4Ju8jMSK4T8cbHgNzxrQa+by27LFxpEohbsco4Uv7BHBBo0I4Y01eSo9Rs1Dg2IBI96SJu21BRmzwq/98=;7:g9rEOkONz1sooHIDEHLy2bncskLKIejHgCrlVAsy9lxlrDNL/TO7Nx+p+bPekBuJ7O1VGGbdTpOPgUmqBKNMgRu8hjg6vQC/9V5BMCWfGMMC4Hf1qE7bIKLFWLEGHY8KA8U9/svutzjP3z3uORLgYWtP/DA6eJ4HM6rwjvGvH1oydQar6L3CEYiLckwRCV298CGDqW4InYGnd4K+xrbUfIgRhYC0Gr0AkNe6La6LoVgwUgLNkGMLhKqSp8EM8HZq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3036;20:cjlgsWF83/nLj0/dbLEYd/oabLB6INy1nHldpOKRIeA6rX+BoUHO8mk8zhZVWhPC4YnIY3a7/cAoxuKVv6STxVU9JEpxX4rZ/5EKjcmIuKDw0MH79U0sbgeRHBdLlhkf934bjimKxWAa8feYzmmR5mo00Zw3lfbmjvhiJQg+YQY=
X-OriginatorOrg: ou.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 04:04:07.5956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38663999-dfa6-4756-c1c6-08d587ce4e4b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9c7de09d-9034-44c1-b462-c464fece204a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3036
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803120046
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 11:24:38PM +0000, Ian Armstrong wrote:
> On Sat, 10 Mar 2018 16:57:41 +0000
> "French, Nicholas A." <naf@ou.edu> wrote:
> 
> > > > No what if the framebuffer driver is just requested as a
> > > > secondary step after firmware loading?  
> > >
> > > Its a possibility. The decoder firmware gets loaded at the
> > > beginning of the decoder memory range and we know its length, so
> > > its possible to ioremap_nocache enough room for the firmware only
> > > on init and then ioremap the remaining non-firmware decoder memory
> > > areas appropriately after the firmware load succeeds...  
> > 
> > I looked in more detail, and this would be "hard" due to the way the
> > rest of the decoder offsets are determined by either making firmware
> > calls or scanning the decoder memory range for magic bytes and other
> > mess.
> 
> The buffers used for yuv output are fixed. They are located both before
> and after the framebuffer. Their offset is fixed at 'base_addr +
> IVTV_DECODER_OFFSET + yuv_offset[]'. The yuv offsets can be found in
> 'ivtv-yuv.c'. The buffers are 622080 bytes in length.
> 
> The range would be from 'base_addr + 0x01000000 + 0x00029000' to
> 'base_addr + 0x01000000 + 0x00748200 + 0x97dff'. This is larger than
> required, but will catch the framebuffer and should not cause any
> problems. If you wanted to render direct to the yuv buffers, you would
> probably want this region included anyway (not that the current driver
> supports that).

Am I correct that you are talking about the possibility of re-ioremap()-ing
the 'yuv-fb-yuv' area *after* loading the firmware, not of mapping ranges
correctly on the first go-around?

Because unless my math is letting me down, the decoder firmware is already
loaded from 'base_addr + 0x01000000 + 0x0' to 'base_addr + 0x01000000 + 0x3ffff'
which overlaps the beginning of the yuv range.

- Nick
