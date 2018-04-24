Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932579AbeDXKMC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:12:02 -0400
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:28576
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932197AbeDXKMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:12:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
Date: Tue, 24 Apr 2018 11:11:56 +0100
From: Ayan Halder <ayan.halder@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v2 6/8] drm/arm/malidp: Enable/disable the scaling engine
 interrupts with memory writeback
Message-ID: <20180424101156.GA17307@arm.com>
References: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
 <1524495051-3891-7-git-send-email-ayan.halder@arm.com>
 <20180423153647.GF14661@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423153647.GF14661@e110455-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: AM4PR0701CA0037.eurprd07.prod.outlook.com
 (2603:10a6:200:42::47) To DB7PR08MB3035.eurprd08.prod.outlook.com
 (2603:10a6:5:1d::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3035;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3035;3:2eQZuEK1XrfWYntGO97gYwrMkYSU36BEPXejrlH+xPmggfCRyynwJqizXrp3mb/Vm/mn5+0XLtKcmqwishohClOI6XFlv7cPwuEAXCsj3Z8YJp1tTA7E6+eGcZ6/hMK3gYjKhMJqZ3ThMvuMMXTOfNsMkePz0rgogJRnKsl3Kw3OQCF2b7vW66BV7FQaWCHK66d7OcyZBvWL2uO/d1O6Y8wyVpycdq2hjY4gCwuuXdbA9BGMjSupTmLfV3JBDP/j;25:b1+fN0MQehx1kGQYBzXRRjwo1iu607571lr5p2jMmJYRihpH/FDSdERY9dDApY2VoNAASiv02Da8kUr61iSKyyoixpeJoyXKOfc03PeQOdQq385qZ17rvMoPEa7IziVcMkpOuX6GipkjFSCNJdbs3XiUWzYtQbXQSQ2+I6/vDZySjiS+ERln62Lr5U3N6ZHuQYDAEBh43/UTZXHEoOrxsKhqI7C6TB7iDGZEiDaI983LzWWZOsv+88G1NCgkcpKBzxl/L+0j1jz6uQ8Kr97mS6zfMCd/MqHROEmbQj/QyK9NI+cOkMR9/IQeksX3k6LrctTqlaKFoh8llwuUmWoFwg==;31:/8he495+i901SEahRXU73dQhLwZz7s6S2Zly1wsTrKJ9vIGgME8yHGtNYQPKS58QV3wR63wUq8J62Z6CXeS84wHSQ6ULeugi9oqTe+MIg7AYQUWRcgEBHphrwQVt2+Nb9l8k00yku3ctlZDOhKW8FWeEjqW+0aBvXdQgbhzifO/2cOPnsx/7YeNj6UNQRVjxDyeo2hNY6AeSUaXFg/2T8lBWuPNi+cYZgqo4gwevtrc=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3035:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3035;20:sbqGWknnrI3EbVlgofSRr1eX3TKNZL2z6bJKj2SRGrs8F9dDU8bkIXZ3Frzu8BMi0/dM837rqEw7IMtC4ghPBGhDwBjZ4c7ejoHRwGYWIotLL9gGHPWOANRjMHrpuFJLX6iWnM9Zth9v+IawoPhKqQbSePGHqrI2BQd2r5RVeFlc4bgVyo6NzXkRll3uCctONx6/rOrnS59cxevyw9k1QisFgxRGHLH+RfPTBgD0cVPBdoG4DiAm95YtBKzXFrW1;4:lZGlBuCwYVZ//zIGcCpUgr9LyEp+j0YqEs/pguNxhk37/pXA+1WsDjgNGR9lJpVWwLRN2QNNGzRWElQak+10+jQag9U1DSBiWERgnpGjxF3UAS2lwrNrNPbR1ny5WFtqnMGz3sd7VnkPcjjjrmm6o5nPJ/4Cix3ZLdLCpkcjVa0mKPEte+c15Qevyk/4X9rAPqg3AUZu5SIfRPKAvZXYn5DeBbZn5LCJIWVxHFu9IGr4l1QccgC9t+0Lar3VQuD/KD+pqm1+Z5xFGfMpqQqva8pn3thkn7qN3Y52CWEBRMwtkokaUg/eNslJpWlEpvP9
X-Microsoft-Antispam-PRVS: <DB7PR08MB30359B211ED337C6EDC3C783E4880@DB7PR08MB3035.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3035;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3035;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(366004)(346002)(396003)(376002)(189003)(199004)(3846002)(5660300001)(26005)(52116002)(66066001)(1076002)(6496006)(44832011)(50466002)(106356001)(6246003)(6306002)(6636002)(6486002)(105586002)(478600001)(476003)(36756003)(2616005)(86362001)(53936002)(25786009)(33656002)(6862004)(81156014)(16586007)(11346002)(316002)(956004)(68736007)(486006)(446003)(76506005)(59450400001)(8676002)(16526019)(81166006)(76176011)(386003)(72206003)(4326008)(229853002)(6116002)(8936002)(966005)(7736002)(23726003)(37006003)(2906002)(305945005)(58126008)(47776003)(97736004)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3035;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3035;23:j2woyMNyi4PwE0/iB56+6dfWFb1fYB1sl6JglH4Ct?=
 =?us-ascii?Q?V9HzqNbOO5F/ivVssZ1jb9yXDd6Wtyy5hHKiers54wH0N6QGMwP5w2LkMbn8?=
 =?us-ascii?Q?NGEnchWkZCphwgAGFF+jHG85NVKLWiuYHIOwnxUFHbiNDFJs2HfXZ1lJtQf4?=
 =?us-ascii?Q?Gqb7iliuYHgtRHqq4A6zhW5ykXtxKXbV1Nje5d5frExPF5VATMrTvAwyek7h?=
 =?us-ascii?Q?zSw1+NtVPoLbNw4uV2yAMVGwp27A/pXdNHwWgH1ST3ZDGwNANFR17dRu1INC?=
 =?us-ascii?Q?HX28V20l2bRglkD7PeTiKoW994/8SVg7iyiDio3UQuIayinOmmG0OeXMghtY?=
 =?us-ascii?Q?ebZdtpqaOUx4FbX6lcAtc2Y3CmpS1GUO1pRWE/c2GNsYkGisz3NQVG37PJyY?=
 =?us-ascii?Q?x7bzw8D64En5k12Ur08Cj80VLbtcuBTPe3YKUxiEdlAoAGtq801YBgjM2jI2?=
 =?us-ascii?Q?C5v3pK38M2MqreHKMk4vtQtoSKTg/Sy0E0ZoInzi9S2zUXu0lqtVtgoK7ON2?=
 =?us-ascii?Q?kCJC6AeaAw7x523YYSOSWq2DdMyl+mliBpbHOMjvWlD5qJvs1jGpUrMPTnoA?=
 =?us-ascii?Q?4wz/ArxOuvL5vDGHVTg+XUGZbRmv+zE9sEttg9V0STartJkLX/2LGDwYdq9v?=
 =?us-ascii?Q?4gyCMiaHkgceTDKyZ6NgcLa7TjsOsjemZt5mQH05d/2SJwHrpX6W0ySH+dty?=
 =?us-ascii?Q?WuFhsTn27gI+qY28gMGHe6W0gPt3Py+/xWetWuw5o4xp6qG+EEylvct2OT8f?=
 =?us-ascii?Q?oOkUNbEncAnaIY9rnB1SubD+3Dv+lSkqgM/mghclcpwe0HQ8+uttCrUu/tUX?=
 =?us-ascii?Q?UFZjwWWHF8/GnTMzYH0hddT79CD5YRsNxVGZVA8yLlRsDk2iofcNcIhbBChn?=
 =?us-ascii?Q?wqbb2DT4lEatpEqXroeVoL0wJPBYdeE8U4pE69mGgZoZxFpYeESkN+D8Jy1J?=
 =?us-ascii?Q?ZxpoBAvr0MGT2lj0GVlWkBT/eOOOVCe+MhM0zvFHcDP4R2FGcBBfe1AmxVFq?=
 =?us-ascii?Q?XIjL2ECEh2BfdJqU7UeFqsqY8IpxmcQLpgdvg/oJW72EqG3GQmEsSUocGoot?=
 =?us-ascii?Q?TsMgwSRTo7uxirg/5Ym7GTkSDIZHMd1kXsw9MsU3hUrRjAkMh/GiOtkF4TdM?=
 =?us-ascii?Q?03KrDluRGL3hEYvafoIWNd8ORK9lSAecfiwYcH/z1N0tGrtCFJzu0BymmdmT?=
 =?us-ascii?Q?BTzeYu9B7InANr03py0F24Rz+G02dCnv8yLVa23xo45cpjerhFw/daNlfarK?=
 =?us-ascii?Q?GFD4RB2wheUVC2hWgwHzP9xatNRs48//sCXJ2zciX1gczWyrjZn3iczOj+AP?=
 =?us-ascii?Q?J6lgZ3oaed8EXndQWyiUz/0jMy9fy6j4bE3Ba7QBXGxqxc1w3GOxnVBsL5rX?=
 =?us-ascii?Q?37/iqhpNwZ6jUsscyJw0lhbLvwyu4f8DKijcpNEQxFYkriV?=
X-Microsoft-Antispam-Message-Info: uT5z4TgaCVAFNnKa9CEtvh2iBe8rKWxD6BMuq5JnxRvQb+mJHa1wLOvtqMIdEGOaEUbh+rShTAJ1eZ96X6S1LLuRwrWyYEv40mcvgmQ+eysNbMf5MTO1NVbVB+4UeSqRLT65XMVSWoyCYyMQ2SIGBPwNowaWumLli8zNtSuRDDkwb7K6U+Mkoo7VofnOEUtb
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3035;6:R3IKZrciehnQitT0koqHGzxs5R2HTMl5NsYjgZdXugWFeH4AL4iO5xBDQnpWJY2cD3Umj7kaY/qU0fGRxS5daRM+x2J/Q888vLgG3VRs/0+wNAjVrwf7ZkuhsiIXI5QFvuPmI0dnHWdPvtKSB3K/hfVlTwdOb1D2aIlE/GaWtAIWDY3yNelxq489GjNXKfTgGRxScAbZ1nCeOXlu+wakOvLbEdg+6BfjLv7QMhkwhiNT71u/k70jKdjXCUsdTXzBjyPZ+76qZgO0StS2l/VzaTtWg2PZnt0GtQ4T/U57+ZkAY3EJY1ELr1vryN99w+p1nJnJzjFoYWa5OcbfDZ0PgP4BDUPMvclnnNc/Man5YwK9EjehLafQTG9zHnJMbYhwUIyJhAqvY2RSHaBr0+fQMDDHi1otZho++3QOUqQV9ummZSnnfXyJmMZQ7qTFr2V93mLGTplkWQTQLbmHzupnPw==;5:dL6GniKuWV0pOBtkzrzdYpZ1yYjkckFEZyCTtcrVNqLGNRgotWOcakZzaUKuKxSPRe0QG5g+i/xUpiQpNHRo5GeMciY3/VcOpculEb+NHKkGLPCbCkyA88VECW084mMdtLeJMkeHAWihWX/bW7HIYF5mULG+yy+P9ZxWVN4Us5w=;24:5RZvUyZ8fVodcT6zxwsiczCy0hN9X7IDBmeSX5h8zubiHNneAbdfSgv778JEh4w/0YbP+LaN4oXAFF4ePY5r+2JEk4ymUp0JZTWS7Ml+Tis=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3035;7:OcVw3Qn1Ju2sA/kUTPcEVKt8hrbw8FbUhkMff6mILKqxQZw5meLfwAPw3o0rzmfPP6Ygtmwz1l16CZoKS/of07JGXvNcRMxun4Ht/MuCelYcgX6n53jApAw+ZdQUCmBH53sHXLTjmB4uL5pUcfM2wPjtvWIhnLksH1cNOhpJ5fMRxMuFq/7S3HtykK0AjjQQoQXVnlrhSAvNnUXpS3+a9GSP4tIHf2CRsOYcr6IUo97lxiC3ZmXd8SPm5D9HrkXo
X-MS-Office365-Filtering-Correlation-Id: 01bb07fd-1601-4d25-6b8f-08d5a9cbd0bb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 10:11:58.7254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bb07fd-1601-4d25-6b8f-08d5a9cbd0bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3035
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

On Mon, Apr 23, 2018 at 04:36:47PM +0100, Liviu Dudau wrote:
> On Mon, Apr 23, 2018 at 03:50:49PM +0100, Ayan Kumar Halder wrote:
> > Scaling engine interrupts need to be enabled/disabled as and when memwrite
> > is enabled and disabled. The reason being scaling engine interrupts are
> > used only by the memory writeout layer.
> > 
> > This patch depends on:
> > https://lkml.org/lkml/2017/5/15/695
> > 
> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > 
> > ---
> > Changes in v2:-
> > - Removed the change id and modified the commit message
> > ---
> >  drivers/gpu/drm/arm/malidp_hw.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> > index f5633bc..90d76e4 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > @@ -621,12 +621,14 @@ static int malidp550_enable_memwrite(struct malidp_hw_device *hwdev,
> >  	malidp_hw_setbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
> >  			  MALIDP550_SE_CONTROL);
> >  
> > +	malidp_se_irq_hw_init(hwdev);
> >  	return 0;
> >  }
> >  
> >  static void malidp550_disable_memwrite(struct malidp_hw_device *hwdev)
> >  {
> >  	u32 base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
> > +	malidp_se_irq_fini(hwdev);
> >  	malidp_hw_clearbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
> >  			    MALIDP550_SE_CONTROL);
> >  	malidp_hw_clearbits(hwdev, MALIDP_SCALE_ENGINE_EN, base + MALIDP_DE_DISPLAY_FUNC);
> 
> We now know that this patch is broken, because it disables interrupts
> for the writeback after a previous commit has enabled them but before
> the writeback engine has finished writing, so the better place for
> enabling and disabling the SE IRQs is in the malidp_pm_{suspend,resume}
> functions, not here.
>
Sorry, I missed this issue. I will send an updated v3 patch for this
only.

Thanks,
Ayan Kumar Halder
> Only for this patch: NACK.
> 
> Best regards,
> Liviu
> 
> > -- 
> > 2.7.4
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ??\_(???)_/??
