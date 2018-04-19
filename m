Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeDSIyO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:54:14 -0400
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:36341
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeDSIyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:54:10 -0400
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=synaptics.com;
Date: Thu, 19 Apr 2018 16:53:51 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Bhadram Varka <vbhadram@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jingju Hou <Jingju.Hou@synaptics.com>
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180419165351.5388021e@xhacker.debian>
In-Reply-To: <96e77eac86794bef9a5b772147527c67@bgmail102.nvidia.com>
References: <20180419160232.519d15be@xhacker.debian>
        <96e77eac86794bef9a5b772147527c67@bgmail102.nvidia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:402:b::24) To CY4PR03MB2632.namprd03.prod.outlook.com
 (2603:10b6:903:75::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2632;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;3:nTKTosVyZ/RlwQ3d3LugLfGvjnEPI6ClIuWDg/xumP9W9MXUaxrGvXCR0VwqfUrucMGMmvyFTVg8jDq0ZXj9vtsvcM7IDUcOHfb+h3vIew/RJ3fP2dK8nTvNymICH/EjVBKBqINR0TDTytQGKGcd0aBUeHBTP++37qFuNIF1fi+2dU93xTe/TLKAbmaHhvhakY8jCh5jBENibbCzF8RbN+i3MoY6WxbYdZ7vXtJTea+m+yRojpMW4Ul1C/rGa5y/;25:gqB8tq0RRAwTAthYRW6LmZ1GSqDe2FpSFeaKVSOa75m61fOw0O3o/o1MpqbX2+SPaiUGySrZKPcCRZsOxxxGomaAQ3TrAcKY3IeoZghcu3CekwjP3oKLayFfbX+pei/DAMQZBNw/8ctj/ZHBJdvHZtvDntO2HnTmvXRnkBICdT9LlyCfz2saptTZ04/wF7s2IQtDyTQgBtcvR+yJ5sinMsNCI6Vay9FlCkTclx6waoyyMqMs62BlFoEFVtd6jRk3ljzRsvTQ5FWBwF0A2eVqImEfSNVkOc3K6hDgd4xydzGrdA87Aw7b4Ju8pxT8R8gIntdbTiz/Fwli5QXYClWr6A==;31:PO7vV6nZ6GVpmMsWKCTyYCBxnRFRqa4PzSpfzFhynAdllX0OtGzHR8wNEYGwzMnZ7lqyVAYcGP1kDqepSk1arwuU3Zw+RfDeBtqce7KLC2q0RBRPHLBW9UH7XUwf73AVAjnV6bvj8KZ2krMjRDfksjpF5QY3EmzqzheBpwHptw0Y8FM9gtf9b3Q+GkubBNP+5u1/fpmtdeJHp2k7gLmsWHM1XlSO/58LTB1nINq9DSM=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2632:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;20:aOxXbhCBF6jqAG/SntY3x6ds0XGmndq2xbvNDo/iXuyhuTG1jLZcneTW2d89kgw+FIcr0KSPjQZ2B/dEmkm5aDK4LTh+HYKTnLusLC7OmV6odhVT7gpBk382k2BSHw5xTD0cRVlVg1/A2Iywh20gNQN7LTy8B5NkSiayHeoqFn4qAODsCAvJfg2oHYPrz8qMAOa0ZBGdNMKRD72yEb+swSGj/dz4Jlch+5tffFlK347IV7IgEczSU4zgoKUCA9+COjtWQi7VPmQqVjrQPypk3oxofXWC2iwfxAq0PQ4tsAqW9732uBpdBWtcea+ncEx3OdYEcEm2wWZWmZVVlv7DLKvxAWBTijJATc+9qlkMSxgufPpy+IWK/GS8W5j4qj/xlPAiwMeQtSh5JM9GJLBrtLD31zPuhFyllu9HhGsEUiQ621iYQ8XFk7YvO/QtJ1bB6BF/qPNXpjktXfaTI7BbzRTiD79sYFROOZOShpI1OmoviOf5saXZcPyWIQ+NEYvT;4:ag0QXpe4kJtPukiLW47DiCJ6ZzRfVTGho7WSXOEW2i3ZrTU6LFRgBLWt83yBh70bT83Iawh1MzrWh0AnsHsirQZCeDRjuwP+HBrn3hX1xmSSnUrqz5niv05MZxSUOOAZoaGdTuTGf0G0rf3xdXi8geriMPqb6uUm+UpTF0ewvwY8oLQ8PcAjtd6IJAvDN2DThRDqck6mXaoolILMHl2f1l7GW/22QVTIyJsourjTg07VVkfeimcs7Ui6E2SpqXo4vODRHMZf78T1SF8wm1v2IGCSweQf/kRRe8J+ZeW6RAop8XJHsKXinlPHiwH0JWQLbhdIm3J7y0Tjp9yghpZYeRffireP5ciJNGFXznF52dM=
X-Microsoft-Antispam-PRVS: <CY4PR03MB263226C4200F872E34925237EDB50@CY4PR03MB2632.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501382)(52105095)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR03MB2632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2632;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39380400002)(346002)(39860400002)(13464003)(57704003)(43544003)(53936002)(26005)(7736002)(66066001)(50226002)(25786009)(47776003)(50466002)(4326008)(5660300001)(6666003)(6506007)(53546011)(8936002)(386003)(8676002)(6916009)(86362001)(229853002)(81166006)(11346002)(478600001)(72206003)(23726003)(16526019)(476003)(1076002)(3846002)(107886003)(6116002)(230700001)(76176011)(52116002)(7696005)(33896004)(446003)(956004)(2906002)(55016002)(305945005)(54906003)(316002)(9686003)(39060400002)(186003)(6246003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2632;H:xhacker.debian;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2632;23:EcM+QmQOQNHPQ1dCt6fUY8nttj3pr0BuY2uOZ1/PW?=
 =?us-ascii?Q?5dBc8i+Kk0JKbpc4ykqX6sLA59fyz7aD0Vy74UPwsxm6/lkZS343W9qqE8DO?=
 =?us-ascii?Q?Eu1hYZN783pVZUJDBfmGDeoQP+7QWHe9S2ixTjLYFqHrqPvkDQVcEGuMkTHp?=
 =?us-ascii?Q?p0Rs0htgTXQKPeC2fasYRQ6Ry5SnJGiBWs2JAXz5JW9vA+mUUpZ4iIto1DjI?=
 =?us-ascii?Q?0oGWKLiwDoW+inAFsmSxziMvhmCYNvB+Ms46K0jU33oqCQjwcGAgSmxGvTnr?=
 =?us-ascii?Q?X+y8WRqKMri+DdN5owzr/fvIH+FSdKb7NxL+w5MsQawy0ksaNKb+p0STtIVv?=
 =?us-ascii?Q?uOTN3nQL1qX0fxt5nAgWouZp4ipFHenXnOV2fAqfdaJ8CB5Ac9xld4gN6UcW?=
 =?us-ascii?Q?FCXQCuqNTz96zC4U/whLWP4qgzHNOLZx1WAnMyyX/CiwXC2B+2spPIfA/UHW?=
 =?us-ascii?Q?ix8Oexss1I+hiRX7EiDrwnYH8xnJqdkBhBNhoBWQuVxNV6lAlX/i96O76Yma?=
 =?us-ascii?Q?i9lDr/+RJoGeX+hl6YeLL3agxzRtOb5s3FKMFrgPC1EyqMxH60atVyCvMEOG?=
 =?us-ascii?Q?AgQVXUskqUg9C9yu5Jcbavo3au+1EjAxFTePiYS/NdbP6v5fNbLQ7B21KEI1?=
 =?us-ascii?Q?x+SOvuNC8/by1HVMqpWbRUP1fHROM92g6sQMP9eVQtHezQuvJfbT99tJIC8M?=
 =?us-ascii?Q?8FZAD1/YK1PvMSH+Z88+NeLg56I8DeZ7ZLxP6BDAvIPVDVg3Oqqs5D/o2Oz/?=
 =?us-ascii?Q?h6NOQsKF7+HY+lVJelgdeXQ3Cerc8GCdvVUHwfSfyofYPp/A6wMYfcCsoIKy?=
 =?us-ascii?Q?KIKiV3BS/UOG0tOErnoSq82gTqEanpVIG/teo90BHyfggAcl7bJyEcL4fOfv?=
 =?us-ascii?Q?whOrI9Z8sHIb2CwTwswZwRdHNxIAdVVISvFyppTgOH9pA4Z2EEFXUwpeqI6j?=
 =?us-ascii?Q?fEKTJkmW0557+SO/PIfFKq1O2rhGRxsTkw/eaqPQhITE5lPrApE3JxMabEPh?=
 =?us-ascii?Q?/mUYPtqOITiGUexJHHq51HQ7AyAWVuW37p1/1+MxMuWsVckh1cRpW4J4iF/z?=
 =?us-ascii?Q?tqseVtYBc/RcTJa7hBWu+PUg3TUlEG2t5WVK1/oA4cvoow7pyGZugLxUCWDW?=
 =?us-ascii?Q?ry9B6wfWt3IL0HnNQAEVuQiekJcK+Q7ykJTBxJa4MAWNH5xZY3UOVBJ4NL/S?=
 =?us-ascii?Q?tIMo62vJB7i14ld3PXgrcx099iNG3KdtZXl7lX/g8uMX04zHehOkHiKs1Fj1?=
 =?us-ascii?Q?g4A6Ja65KvslvuZr/SRGEbT75udJNp5bRkdI7p7?=
X-Microsoft-Antispam-Message-Info: Li1t04d5gsvzCj1JFXnuoGlyfXtrV10DmE0hHtp8XmOFzDV7/0YU0JyEkNchYMhEl4n80O20sNXnQq2BFcGhG83fWLTylghzlZY+sRTOma28UcpAdWrEWzIUk2y29HIGC9vPv6mY8YnX4UdUFm0RWMVANooga1N1Ift+t775SkyybkP6twxnlgoSFD//WRyy
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;6:hGZmB3FT8rw5TwgHrQtkZZ56PvewS1PXt+4CBIec1E96Qgxd+BdNFdivx83+Feu/MJa/WLb+CoDsJ11nRHfGp8EqyG2OkzXUEC6XXGfdqpdK8TyO+iFIGyfv9+X5R196nBSKNehuU0yE7KHjqNplU0hvmUjE/vVnZFiCDAHjnAnmGJdb7v91QBOb4wixnn84EB2tx0lDPUF1OQgmn3CK8R48i35IQHtYIdVlP36UMMnGkG1tpIOjtne+ha0cYZpL+ZnYk84tL1mjq0IM3vTCe7O2HoLCVt3L0IQFFAEW4ZNmNT5kZ0yhcnS+nBnaqerVdvRSYy8zcyKANAKykHi41NtUzH7VUXL3IVKTf1KzUhdZ+RC902p+jogn40G/yrFF2WAiOdH6Qpbr0APukfofwD1LFTJmG+1znME29HFRwtnkAajUpU88kED6M9gAqLOBmimVdnJEMc+0zZbNg8Z2Ng==;5:AqXUtz9XOVpt0NX/bfA1ZMPkpc6oOoeXrl88jG4RDfEI0CPI3SNbA7ROb/yxPUXWxa9uonO3qHcApn3JiVyLmCR70+pguf832zWg1BQQ8Idfv7fZmF4wwy1XTOXQHkjM7PT1zDEZFzaeCg2hJJoFoUspPqlBFjcgJnc2VvHajuE=;24:yM1mIguscEbhR63lGODdr7ay178A46lViEmvVZcX0pfvWAEjV2PUfX7myi1bn5TIL2HHyo8H065fIXHm1/HOLwzgr+ypcVJ+IqgmzHbagww=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;7:4+JaExVdFsorn5s8yXnJ2L2VIDwccdeDB5mFXUiRTyX67Hjx/sb7NnAjn4C7EUA3bBfqz0MTmqJVPdb3TI5ZSJnwmFGNoDMCiS+UUVrAwnqQwAUmywY85WuMLYMpRn66zHeb2EKbV2JzhAKvLmqFYjZ524rSbKgraCrq/5dyVsL0zFnCx3Lw01M+5QcTjZQ253Eddui0kvaiUHpoQl5lbqFD5m2VIKul0Q8EKbFR89Px+NxXvA3kribZ0nzDNy+S
X-MS-Office365-Filtering-Correlation-Id: d799be03-f614-426e-d060-08d5a5d31c32
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 08:54:05.3973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d799be03-f614-426e-d060-08d5a5d31c32
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2632
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 19 Apr 2018 08:38:45 +0000 Bhadram Varka wrote:

> Hi,
> 
> > -----Original Message-----
> > From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On
> > Behalf Of Jisheng Zhang
> > Sent: Thursday, April 19, 2018 1:33 PM
> > To: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>;
> > David S. Miller <davem@davemloft.net>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Jingju Hou
> > <Jingju.Hou@synaptics.com>
> > Subject: [PATCH] net: phy: marvell: clear wol event before setting it
> > 
> > From: Jingju Hou <Jingju.Hou@synaptics.com>
> > 
> > If WOL event happened once, the LED[2] interrupt pin will not be cleared unless
> > reading the CSISR register. So clear the WOL event before enabling it.
> > 
> > Signed-off-by: Jingju Hou <Jingju.Hou@synaptics.com>
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/net/phy/marvell.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c index
> > c22e8e383247..b6abe1cbc84b 100644
> > --- a/drivers/net/phy/marvell.c
> > +++ b/drivers/net/phy/marvell.c
> > @@ -115,6 +115,9 @@
> >  /* WOL Event Interrupt Enable */
> >  #define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
> > 
> > +/* Copper Specific Interrupt Status Register */
> > +#define MII_88E1318S_PHY_CSISR				0x13
> > +  
> 
> There is already macro to represent this register - MII_M1011_IEVENT. Do we need this macro ?

Good point. Will use MII_M1011_IEVENT instead in v2.

> 
> >  /* LED Timer Control Register */
> >  #define MII_88E1318S_PHY_LED_TCR			0x12
> >  #define MII_88E1318S_PHY_LED_TCR_FORCE_INT		BIT(15)
> > @@ -1393,6 +1396,12 @@ static int m88e1318_set_wol(struct phy_device
> > *phydev,
> >  		if (err < 0)
> >  			goto error;
> > 
> > +		/* If WOL event happened once, the LED[2] interrupt pin
> > +		 * will not be cleared unless reading the CSISR register.
> > +		 * So clear the WOL event first before enabling it.
> > +		 */
> > +		phy_read(phydev, MII_88E1318S_PHY_CSISR);  
> 
> This part of the operation already taken care by ack_interrupt and did_interrupt
> [....]
> .ack_interrupt = &marvell_ack_interrupt,
> .did_interrupt = &m88e1121_did_interrupt,
> [...]
> 
> If at all WOL event occurred marvell_ack_interrupt will take care of clearing the interrupt status register.
> Am I missing anything here ?

If there's no valid irq for phy, the ack_interrupt/did_interrupt won't
be called.


Thanks
