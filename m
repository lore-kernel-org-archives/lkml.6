Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeCZTf1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:35:27 -0400
Received: from mail-he1eur01on0040.outbound.protection.outlook.com ([104.47.0.40]:19541
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750983AbeCZTfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:35:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Mon, 26 Mar 2018 13:35:02 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Wehage <Eric.Wehage@huawei.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180326193502.GI15530@mellanox.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <20180326121138.00005e30@huawei.com>
 <20180326164129.GF15530@mellanox.com>
 <6ead7f19-c0e5-5584-2518-1e1889a007e4@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ead7f19-c0e5-5584-2518-1e1889a007e4@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: DB6P193CA0001.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::11)
 To AM6PR05MB4455.eurprd05.prod.outlook.com (2603:10a6:209:43::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10b99577-3716-4601-741c-08d59350b3ea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4455;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;3:zMn9Hxr1/SRoAS+kaDPfvE67FS+dAlhNW23jOeVXli+PPrg8Iga4kv+VTsTl5Gen5SofuFLhk8qc0nOylPTd1VQtGMFoyfrzBXxw66R373dbA/o0xpRXz3Xfd2mqTIOIh/1GJVg5ItbXHCmRGYFPXPG15jofFVn7RdIhpeuBMh/+6BnNUde5dBTLGSk+6/nMgBAzRSa0p2VZZM9F5p6pujPp/3U8rrdagcY3bp6gGwbHtzOZYOj8hTyfdi7hL9zP;25:WbHAAYbp2KElvK8PusA4OGY4y7DKHla/jv1LQgBwtuLHxQGeByGB8Ym9jM44WTWA5WtBVDAJ4JD6cA324JgjsT5sRuRueP8VwzNz/CH4ZHWN6mt4/9K+g4KDsrnB+lgDwWdfJyaVkF0FRXBg3SOScnzwHiwVdLbJdoC5QJ8vLBqldIONKvN22CQYV2lzvMbUCvRFXUdnqdiGM6GHuHNpAGovLzH3Xo6JTusCyNXj7x5iEPRwd0bg/HlCN6pROXywwN6g63g1pstf2jUAvRA8flNtQngNiYYgHdrPD4FkadOuduWH0x68tWHbpwma4NBn4X2bJal6XnQUgEXszEVueg==;31:86pRn7EtcXEBO6i0no3VU9GjVSbGSL9YF0O2JgLO+ytnK5CdZHPZeEwWWE1PRX3L4ztMT4XkQOKNLCkIcLYIPoKkEeJ2peAn/toRmmCvDfxFwLx1WBpFiepdixAV4qM9QasvpjIE8szDLMDzWZanAwbSu0i2pXmQp1ZY4ub6sWStJv+qP9mEe4L75kzqqg3vjKWRguB/wpsaFBKSj7dmrroSP4m6fVVPVl8y/7WOBWQ=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4455:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;20:JwxUqNqbUKWdW2DNNPuLmucrpN5rZQrxQAvcQ2qLCz9DLRUBEeNWOeuRwJj0ZSUFqCRogGxe1udmyphXTUHIp5YEHD2L4mPpk3JgwNHHFaVsEooljpna8GwzGjsmqQrenzXJmUSRb+DbDczDL0EdJLk7jwVgppWH9ceQ/yYhYV2yPtNtT1Gi/RApGcCt22tJP01E7HJ277FCpYt4+B6/7hPCEW7xa7cA6BbXxyYea2rEwhy8KgDMF3AW1YhgaS0+hogi0zCybJVbOsqdbYqqiSOTpMHqwpuPqm6SfhpIPq4ftv/XsO3fNRY+k4MXSHP4s9y3Lo5hagP03JrBr/TJtlcIeHH6GYav7zIqS1PI/o4FTv7nSOkRC9x4ral/FW3o7/rvIkiaVxuGkmS1GWOuPrOIN8uDzIldpLVMIeBKk/KkrGWmlqaSRxJhhdZ1zFU1guCXJLnDwjNkUO35uWFTsoTiYvVSU0B5naYID9Z1Jww/upu2o1CZA8qMPUH/ywhk;4:zmDSS3WfKhP7lfQSDuKGJxv7gFVlaMt5jolVfyGr4cGdevXxgqEVfpdK0kXSUod1iF3JRhy53DZ8h4sY7uCIJFIHoU7STi5fX6lqLnhdkDMeu4chNwh8TTzNKMzQtIY+nIMCH+lo1GdQDwIMSLS+gAli1DxI330L72ZFp0aPS4uPBNm9KvnqHbdV9gelOeYxrVTc2poxMReIobWkeQrBi7VBpAsQTgKnpG9Tqz2TmK7RcJO/DO+/547u92kOt2hTZcRM5cyoJZJ8ltaz66j7Pg==
X-Microsoft-Antispam-PRVS: <AM6PR05MB445573378988861913C50524CFAD0@AM6PR05MB4455.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR05MB4455;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4455;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(68736007)(305945005)(5660300001)(2616005)(11346002)(50466002)(76176011)(122856001)(106356001)(1076002)(53546011)(386003)(316002)(59450400001)(58126008)(23726003)(16586007)(52116002)(7736002)(486005)(486005)(2906002)(86362001)(97736004)(36756003)(69596002)(93886005)(446003)(6916009)(6246003)(186003)(26005)(4326008)(229853002)(478600001)(46656002)(57986006)(47776003)(105586002)(66066001)(7416002)(9746002)(9786002)(54906003)(6116002)(3846002)(8676002)(81156014)(8936002)(81166006)(33656002)(53936002)(83796002)(476003)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4455;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4455;23:9JlVFcVc+LWOGEWMbpm1KYpd0ciCwXyegyfDnxYKW?=
 =?us-ascii?Q?qdAh3oAJ86LzqOcCR4MJeEyRIkfjh98TVMPF4Ju+gT6bPGwhHm9jTNf2MCe/?=
 =?us-ascii?Q?ZHBaGM7LFqpDia8P6udGSopEPe2tDYTGmG/tTLtht4MxOnW5P+27com7HD86?=
 =?us-ascii?Q?ZGvWKZh37+lBgf160Ynh1k7SFL+gy9fCv3qvkLwpn95mhyMoyZFoVAtRqQrI?=
 =?us-ascii?Q?+YzyLdk5D6inOGKw5BX57Fwu3UFoIqEqn3O+45sURZOgGFwhxiVINZLGlfnf?=
 =?us-ascii?Q?W/CghUoSybxEoW4NJeiPLfX0kuxgl8BjdJIjf/cCPXHd7/RxEVk3tLOl/EiF?=
 =?us-ascii?Q?LEEPAGFEA1ygAPM94O+13WYuEcHY7iG/mxp68p4Jnb/EpiXC9MpLl+/aMvh7?=
 =?us-ascii?Q?pCd9c3dLwA7Cnj3KZXd6BP8aGqKgMqG3LWFgAqaydeuvmTJ9QHoKWM2gWiDc?=
 =?us-ascii?Q?oSjo5HFEAvrqAKN/IfaQ7s+foztwcESiAPeqVM8CvwN3T3TeCIWArUaAsISM?=
 =?us-ascii?Q?o1I+HbHcHhTJg0hTGWWRkMvwU5HnUVeVugQINgQYa7W5yCOsN4ThXLPvpVDF?=
 =?us-ascii?Q?guG5kDu2XQO31V658I1yB3U+UAy52OHzEhsyVTJDt3148/8mFfV/X37nDZaQ?=
 =?us-ascii?Q?QL7qf53CGZW1splhwSSpqaoKANC8zKXlf2QwnN5hOGXuayItpwyi9RY6J6A4?=
 =?us-ascii?Q?9wf/MPomKHVe9XuqVo508XR51GrhQLWEYiIJyrEPcwM2+h8kkyKmoEae52RU?=
 =?us-ascii?Q?06j2e51d074wNRfiAMJQsUHs1UVL7b1VPn/3OGtvQQqp426QsLBIkrwLA9FT?=
 =?us-ascii?Q?K4Uxz+8B/fX+bCMdXvoA+aDJjQGnVsAynX6Ns4PrbCq2I46tqd8mgDsOlpIu?=
 =?us-ascii?Q?K8sQ+px+icVRcKjrK3PUnNGixVysoyMwG9+qdLqADAb/5/6mJQeTOiSuStID?=
 =?us-ascii?Q?uLssDTw2PF5bFlQX0tQ7TeXckNjG+jF4ueyd6gM4tt4n+sLYP63eIlrZ25dj?=
 =?us-ascii?Q?65XX3OzOuI+UL4oM6x6yhUiuqSVyvNrjHEhPMXt+ovUQ6/CpzHoIqD+gALy3?=
 =?us-ascii?Q?2KyP6Uc+DEceMmLwgWEStwr7bAUQjadQ2LihbNzVT6e78zSZN5fIFM+8RyBM?=
 =?us-ascii?Q?xz6EOcQT48AUNZNArE/e75c1r4+3hM48WlEZRtecdhh5KWJsBo4kKI0uFw9E?=
 =?us-ascii?Q?J9pF7IwausHFcxYPtJyn/JIX6ZgYfApkFLLWdMe1b+FKDFCk200sWKZeTa+u?=
 =?us-ascii?Q?D2Y2MY8BoiVP7iMdnZypNDDqe7I7rcMj834Hn/CbukeR2Ck9eh+cCi2+eek4?=
 =?us-ascii?Q?ehmYMNjYubcR6Bdsqu7T/HTsWqgJHH+muM84xZVqfJlrOEq3F3IPLFLqc3m0?=
 =?us-ascii?Q?apOcCT+HGhBK1SQZ04r1znHxR/U+0S+3bohC8QpPnU4CDdFH1VnKWMqydMBI?=
 =?us-ascii?Q?UHu3CIATqyumTPM+tWsDjCLEEhI7SduX4rSAXwnY9p2VWVYaqiB?=
X-Microsoft-Antispam-Message-Info: oABAJtm2W/aY4xMN56mII0zAKkwboMwtToRtfzwCZKWIvLRazFB/WXLRxuBPbypFxILdeFLWcPC6cSHFSSdXRBIBcEz74M8Yt4mcVvMZK21raY1hR6bxB4cxA0cpbr8qkvCaRTskxgqisv0ihR3nkm0kXgu/7yyfNGrduKcj2bKNxWfr91RxRuWM/TBJGYbJ
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;6:kmmCwi2/oTptupA6UpvF7JCOHGa7Z+4TBdREiE6I4PO0RR6o24EHJLzBtyhtI4wY7jNE2lWx4a4r29PVOkFhmc8/8upYp8eSIoBgve03LNiweBt7MRjhQpkYmrwHWV+/y0AnNbFC4JuF4WomaROjr9Csh41bhEgtebhDBFLxe9/h12BXIc2n7U4pegfBz9/+C4bP+9Qfcnn3aMnIpVYboMwonUkv9/jWqi1+uOq3JKknAHRD6k1UDUCkjoFpKB8VdDckXbi4sA9tgdo6+NQUHocLzI0vbU1nEoSr4ELBokd4van17d/1syCJg25E6mzZHiIoXmHZRVziH7sKn7StmNB3LaZBzDjwmSkpr4RTk/meptsGgA1MNsV0Gw+TrYIl9yMGc3GSk4c5jKzTtVlepI9+w4M4a+2R+BFO8DFefvILwX9sWS6IlBEbNCIPVXQi9cujgUlAF86ocRyN11ttYw==;5:oZ3YrQabFFsawgYGKl3O7InEMe9WloRNKJQeCrkKQ4dWQlluH6sfU7Vga4ay6uLWc2QFZnlJCrnFKPIaCBTacFkpFuYCM2gsABDUaYi4YCrTT3MjysVwgqsfSMQTsFF6kszXD7c8Ad9o1s+kAowH9K9mMAUqI6DxlHoiWzAsygE=;24:wh5Qj16qEsqRWqxUkyLemCA9jLAEL3P5k9UsiMM6zVQxBbmNmmqlR+VsKwSNEHkCQEJUrzRu5tTiqeOwiQ2dA1i+dFNINLruQBrivMpAYDc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4455;7:bA0hTQHOXHxI+RoqgXRRzm4nInKbUhmgpFhbKGt/OpWstAaOycgwWJYLC5KanuJnnW9Al9oxVSxsVRElMPhdjUXhC0ZPGLiVH8WOKxeLO9FbLGgr2/X9mK1H5yyKM2ICundkPLxCWwLu2aT56V5qM1RnG3RflGJljAJuFOoc4cHgZ26HIp/m5LGE8AjlGocEQ19z874EFnBjCmIOJwC3NBEC9D6uuXA2NlCveQ0r7pSU4kZN9guEK1jU2BcBDw98
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 19:35:16.6071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b99577-3716-4601-741c-08d59350b3ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4455
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 11:30:38AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 26/03/18 10:41 AM, Jason Gunthorpe wrote:
> > On Mon, Mar 26, 2018 at 12:11:38PM +0100, Jonathan Cameron wrote:
> >> On Tue, 13 Mar 2018 10:43:55 -0600
> >> Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >>> On 12/03/18 09:28 PM, Sinan Kaya wrote:
> >>>> On 3/12/2018 3:35 PM, Logan Gunthorpe wrote:
> >>>> Regarding the switch business, It is amazing how much trouble you went into
> >>>> limit this functionality into very specific hardware.
> >>>>
> >>>> I thought that we reached to an agreement that code would not impose
> >>>> any limits on what user wants.
> >>>>
> >>>> What happened to all the emails we exchanged?  
> >>>
> >>> It turns out that root ports that support P2P are far less common than 
> >>> anyone thought. So it will likely have to be a white list.
> >>
> >> This came as a bit of a surprise to our PCIe architect.
> > 
> > I don't think it is a hardware problem.
> 
> The latest and greatest Power9 CPUs still explicitly do not support
> this.

I think this is another case of the HW can do it but the SW support is
missing. IOMMU configuration and maybe firmware too, for instance.

If I recall I saw a presentation that Coral was expected to use P2P
between the network and GPU.

> And, if I recall correctly, the ARM64 device we played with did
> not either -- but I suspect that will differ depending on vendor.

Wouldn't surprise me at all to see broken implementations in
ARM64.. But even there it needs IOMMU enablement to work at all if I
recall.

Bascially, this is probably not a HW problem that needs a HW bit, but
a OS/firmware problem to do all the enablement..

Jason
