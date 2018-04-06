Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDFPOi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:14:38 -0400
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:43563
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751435AbeDFPOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:14:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Fri, 6 Apr 2018 08:14:25 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: David Miller <davem@davemloft.net>
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com,
        gustavo@embeddedor.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH v2] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180406151425.GA15317@localhost.localdomain>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406.110603.978796669734920248.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406.110603.978796669734920248.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: MWHPR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:301:4c::13) To BN6PR07MB2993.namprd07.prod.outlook.com
 (2603:10b6:404:a7::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 884f6c47-ac61-4524-4d1e-08d59bd119c9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB2993;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;3:x3JO7KD9FvaZY4XWM6P47CBCAxaHiWNURgE16oGNK52QHUYX1lZcEAPMwjoHoLY0pB4u3bcHKlwTEA7zGjVm54f14oqOkWR9qt/9SPq3BKVhV3GGZ7xRtMD6xp2yIvdZz1++EUs+b8LHxZIL8aZvorvOecXLvmTpsZfHp/rOiUe2VCjV3Fri2HIG7uRKubbEOu7zDXsSeX2lDetUpN5spe2m419+utPiKjgdxLLY3q8KD+wH9IigB78RTixcNu+U;25:qLLGqZ+kRx/BikE/ugAjDrQVn9asUobRuTkNrM6UTa50qDrNhnyPtIoYLXQwnlgoq9uHgIqL7ZZ/J5xopZUMHRG0+ZLNE7VkCngUv6rER//XDSc4Ru1IN3qfpRVvffT47E1jjRJAfCqdiXd5rbHoqxpAgg03Wn3HqFvhMB2KxOAb9hr2awL5TKtrEpHVna/o4nUy/Jl69jxbSj9Hph6TUN0sSudzSPQ/UgYBtv/3XiSFKO6PBN7ApP3bAiIvgQ85KYBYOzQSXKoSb1Hi43hZ3SwT/eSmCSwKW3mAImaDO805zF4zNQe5Hz+so3xDohs09Y6ieePHgJY1ayOOrBSsFQ==;31:wOSc0wv95mBmeWt+tQHojEUb8CDpBobFc/USoMRg0YZ3vejuYJkmiA6Dp0vW0AIUmJXX6BJP0n91mpfPGJhf/WzuiVaajtpQTSv2oIKmFGk6W/if4GH7eIuxsG4IHbceTZk7xFumaNYd/gsWdIBVZQg1wPohgxOzf91NuJt3pp7GXSw67jl69ask1Aq80+Bt+1LfXmuTnXMNu0mXhjeJIgk8mantNYNO9yVAbafDk1k=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2993:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;20:rxPx42UxJsQEEOBEWgKizaB+Vyc+ggr1UO6FqNlk5Mt3RnegIRmHSvB3o1Pqn/Dd4HIHhUqUw6WrxvjagY29i2rUvVIq99NIgo9nJtfzyBqh3slNHeQ0gTcgyCF3a3jETkU87pkz0xBwA9TKTWddSIu1LD9Or10KsbyRdo7mZU4KICnhAwlOozUmI1s608okGTKU6u1S/mmOyFELBI68Nb6yxN+GpxytirX/2Rf6xB3xUR/hc15RRpqYfO5e0vToAJ77ZkLhm2M6iGvRlHjH0LIdrfF43hzvLz558G4qFaPiCtL7dMjJSoVj/IEQfLgh7870/spuYTlBDFxEBfm3Vzh5uokCFw0G4OF1XzZDGmtfdtABHaOOj7xneB3j4zVdetal1PdFf06RQUj9My9oqy42/xt0oPPETVeDRehk6bMIqY+wN+8F9HJx5jlMwg+3n0BpBrXDBdWL/h5NtqcmiOJcjMrmyrViVBVW1hvb2ALzrCV/IE2FQH0wuHSyhfAZyKQWYOYGd3PKgMxq7LpEVOvi7G+gosg1aOJQc6ct5V0cD3S7e7cGbVBq8+Nhof5RRumqX3eG1RVJGpYagbtRJSkUl9hCzUaa52d9T6TNYBA=;4:LCNRGS0+SmkMzSMClGcyDVjt7xz13RXNV0WDW5ljTXpaIWFVX1lXO3nJiKoiJ599miRlPIcRaXkrrM+jSFLZaO9eKfHoFz5W5qi1C7LRl3AbDwiJ8YDuoykoMX6XqYf1S0+Q9vTpUhLQy1spOfMBgAAMvAL0bPMMrx9O5yZmwcBs4WMobMyI03jn72NDmkr7EeEzeEbsjGzccs4BwVhSBBkfD/Zi7cuyISU3TLGIRQc4GVrTcKMhdz203hQeJ04pauvRfJ23y9hn1Ivo5ELPjhrHa7ho6fGsjLVEiX77bJdiM3ywQgkltcL1s7wB5LeV
X-Microsoft-Antispam-PRVS: <BN6PR07MB2993E3EEDA77E99A7813B4C08ABA0@BN6PR07MB2993.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(3002001)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR07MB2993;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2993;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(376002)(396003)(366004)(346002)(189003)(199004)(25786009)(68736007)(8676002)(42882007)(47776003)(72206003)(81156014)(5660300001)(106356001)(7696005)(9686003)(61506002)(4326008)(107886003)(305945005)(7736002)(53936002)(105586002)(52116002)(6666003)(81166006)(3846002)(6916009)(186003)(16526019)(33896004)(8936002)(58126008)(66066001)(26005)(2906002)(23726003)(6246003)(97736004)(39060400002)(55016002)(50466002)(1076002)(6116002)(446003)(33656002)(956004)(478600001)(476003)(6506007)(486006)(229853002)(386003)(16586007)(316002)(11346002)(76176011)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2993;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2993;23:TU0z0lsy4UI4NY/hwOij2mB1aiKRxuYfV3cNlC6Tj?=
 =?us-ascii?Q?7eSeeSzmTdfGtKWlN3MAV5BouyrLMRkyNOl9B2pWdc3y1R2SU10N8ql9AGHq?=
 =?us-ascii?Q?Yw7c3KJrOn3107DD63ISsaBiV27dsPYSKgT01DXVSRUNJpO4FLHf0DEJdzsB?=
 =?us-ascii?Q?2ksrrhL8BJGIjnISkAv1KHeo7u5C6tDa/EdYH/65Q7vbZXlokTRmcRrAaxjC?=
 =?us-ascii?Q?BmNavgPsM2MPLGTDpFpuCK9A6LpIwLaYJeiSc/AAZMIJXdLIh2TlDGPSN3FT?=
 =?us-ascii?Q?y7RuPfhtjbSo5WM3aCEIcThKu6X2rUhPJ5wAmAoKVKUMeHTVushh4CCMMBJ+?=
 =?us-ascii?Q?HUaXOtDTDv1qEdDoSHPWuKR6VwWmnCqHigiIug1eqAF3wHb91uQh6qp+Z+gU?=
 =?us-ascii?Q?QEWtbq6az2POZkDp8+mduD+nPAtEy38b6vdyBZG76opkoXnStT5pnZyVxZtc?=
 =?us-ascii?Q?lCHZ9RJ7+6z1xqQfDJZYz+cPSNgyP7BjJGrItnaPkLVeSSEdR6BZcV/UFu0u?=
 =?us-ascii?Q?8/NajPieoF1Yqcow8FceojgQ9Vvg3v4/AGvLxa+6hRQtMuZAa0Cc05KhZjco?=
 =?us-ascii?Q?bBEaw/xy1zZwsyizlB78qP/Pq3L1ww29SuDOGpUwhnBmxkJxCUnx0SbAGqty?=
 =?us-ascii?Q?d6lEiT6L6wNTKnT7tLrhdfvehEhObUNeV6/dwjnzJnHkzIV6EMHeuOsyPdnw?=
 =?us-ascii?Q?mwKmmDaeorhBvSssvItNuPvP7fjPvoMVJwZW1Wn1rlIqXQfdQ1ouwISlqBB2?=
 =?us-ascii?Q?+pDMkKk6ajkr9EqPxhsXEnG+9OxiW7RbcP4qjXIk9OGRn8ncgQnfDAt3wpmJ?=
 =?us-ascii?Q?yV1IeCEnQzMp2/oWV4V/asE4QfR/86oKT0BLgvHnUQgPZYZWBsqnkqVg3oPd?=
 =?us-ascii?Q?LZ0AEJu7NXHdqg/IULgbnVxnKoaUhU0V+jAFv96m3zLbW6gJaUZuBiESZBsw?=
 =?us-ascii?Q?6w69nMGXRcigOV9laUxPbfyatyr+LWbQ6BNXdFDjTTr3KaAbqqjjUXHvYLdE?=
 =?us-ascii?Q?pAqXpWYGp4NWNEPqwCOSMbzr4UFFz+bE9xr0eihHqkdPaqQwfq1TJf97AU3F?=
 =?us-ascii?Q?QdtLervn43fR6z1wb8zbEOpjRWFZKG0ZF5o/IXKwAeuwWHFizWPbdIbCUsMa?=
 =?us-ascii?Q?zG8ABVseMrf+RctzXRA0ak8HGsPSCCYUGxuHmuUPbNfx6P6+9BEANzDvonRQ?=
 =?us-ascii?Q?V3Y2oveKCg/l/hpoiHMHGAWV622OaxepT6P8QC0vY2iYafUGRaoZoSyrKmWU?=
 =?us-ascii?Q?CvCJyQgsvYs/sWdiH8AQUNMmOZomL5YFtyXoATBtRaNh1rRtdHQ9cONtXonv?=
 =?us-ascii?Q?GnhF1wzNAE9VioFtwU9yd4eBTnylBpbf2RuyxP3/TwGMu2MNqVURg0vb//bL?=
 =?us-ascii?Q?RDGxU8zOa/g9443ULwbNtcYRwI=3D?=
X-Microsoft-Antispam-Message-Info: FzzAglzysR4kqRwqsZLEMU9Z+yIfl6gGgIqo9H+adITGV1dVXSW9dACrMKLT7vXy4OOcqD8ZMkrEPzAC42Mdn8sWFNLBrqhVJ/coE/atzvD8G6I/gvR8wOQiiai4R0tchRu/wRqavsiebYXZHtLyRc+qt8mTxQjmWldK5A6JleBCWztTZFiDkdyOC1lEODHC
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;6:ZKKI4R22Nd1w0v4vkahuwMZNANTShwC8oqh+8NT2GOYd/gnxEbhoowuZ2Ksxjoai74HkMbrugVpQJTruhE74SZo18QMNzuPTx31xF21GRrZ4uUOJNmN2PZqN6qYm6aScd5RG3rdEVawSKKQCCPPf1tPeV5c54dtqsBVjDU3N+kSdMGRhgOyddenO+svGRZsJSAumUqvtTwLm5V/iGWxVttQCqlCQ1faWn+AZzswX0XfTSmTqP4n81IgX1DEiW0m2yoTBe5XTdh+PFvhVuIfgPM23tMIT5gV50ZvEsbmCkLnSkLvQ84kvb2vlpFSCXQjFqIW1z3Ak/DQ/tkJRIVLwgX02iMC6g4FbTVvAcMRek0XAM6iiA6kS/nWJxwLOFrKBWR5nsO0sNSXyI74CTWqG+QWYJtks9siqbJUgp3KOvIOyIFn/jdzzV2jdB9Y5s5mNPQ9xFVV0Nnm/vbg8QMA2oA==;5:hLAKZjXg1mv98h/ENu5cTBdwfE3wFTMWUFruyMqxKj+sWgv/5P8HRoJ7QBWFOfGUKk+u5Z+i0hZRg0ISNiq0lpC4B+WHoUne6WcYnITiW/6nW1wEUbmbUzBwQ8jxvQsuCBAnt4ENFLEC0863RXijs8ABo7oZHQpbJZxr8TAe6NY=;24:SqLDb2WF/Un20tq9jDAYsWciqSF7J4t12Pcw3I1bAuL6nYL0/fOJ4nJYWA4RweMQqGo0AuhuKD7l8a1CwEwavJGlbxgPZI0PJIoxgKOyP8M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2993;7:zX7mfQ/ju7L0XOKdwmqlU72BvasDUTFZQ1mGTljHfj6tkP7uyR3iJieom4vKkObLOUJJ36Z6zlmGcjkQn70SwK6TeeklYpU9nu1RYTDtibSP0oQEKHM8kbi41foUxS4IQ9cn5Rnf5ysSI7nUFzqSjbRXcUMw0I8uNzEZ62IlYRNQNLGg32OhkH+nVKCV2IfworZdaF2UJlKaVcQ47buKU/KXZmzdqORYpDF4d7bJrVK79wZZZZns5E61ZGb3OdWb
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 15:14:31.1023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 884f6c47-ac61-4524-4d1e-08d59bd119c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2993
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 11:06:03AM -0400, David Miller wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Date: Fri,  6 Apr 2018 04:14:25 -0700
> 
> > diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> > index 5fc46c5a4f36..448d1fafc827 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nic.h
> > +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> > @@ -265,14 +265,9 @@ struct nicvf_drv_stats {
> >  
> >  struct cavium_ptp;
> >  
> > -struct xcast_addr {
> > -	struct list_head list;
> > -	u64              addr;
> > -};
> > -
> >  struct xcast_addr_list {
> > -	struct list_head list;
> >  	int              count;
> > +	u64              mc[];
> >  };
> >  
> >  struct nicvf_work {
> > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > index 1e9a31fef729..a26d8bc92e01 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >  						  work.work);
> >  	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
> >  	union nic_mbx mbx = {};
> > -	struct xcast_addr *xaddr, *next;
> > +	u8 idx = 0;
>         ^^^^^^^^^^^
> 
> >  
> >  	if (!vf_work)
> >  		return;
> > @@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >  	/* check if we have any specific MACs to be added to PF DMAC filter */
> >  	if (vf_work->mc) {
> >  		/* now go through kernel list of MACs and add them one by one */
> > -		list_for_each_entry_safe(xaddr, next,
> > -					 &vf_work->mc->list, list) {
> > +		for (idx = 0; idx < vf_work->mc->count; idx++) {
> 
> vf_work->mx->count is an 'int' therefore 'idx' should be declared 'int' as well,
> not a 'u8'.

My bad, sorry.
Will post v4 shortly then.


WBR,
Vadim
