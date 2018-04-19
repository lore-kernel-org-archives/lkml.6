Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDSJJ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:09:59 -0400
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com ([104.47.36.82]:18795
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751168AbeDSJJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:09:57 -0400
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=synaptics.com;
Date: Thu, 19 Apr 2018 17:09:32 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Bhadram Varka <vbhadram@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jingju Hou <Jingju.Hou@synaptics.com>
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180419170932.7a0b88fb@xhacker.debian>
In-Reply-To: <e1409c9493f64188a71b44f69ccb24cf@bgmail102.nvidia.com>
References: <20180419160232.519d15be@xhacker.debian>
        <96e77eac86794bef9a5b772147527c67@bgmail102.nvidia.com>
        <20180419165351.5388021e@xhacker.debian>
        <e1409c9493f64188a71b44f69ccb24cf@bgmail102.nvidia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0141.jpnprd01.prod.outlook.com
 (2603:1096:402:1::17) To BN6PR03MB2626.namprd03.prod.outlook.com
 (2603:10b6:404:59::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2626;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;3:0S+R85KhAp7uRSTEd3kbDBthzZWl1Fm/2EoSvDS6OrpG4IkJ8pHhtxl4OjZqwHRXulBJvriXrDDPr2WqbU9+R7Y4CGI3ZohyD/RlOmg2DQIDq8Cq4ZVWAdBVaVe1KFcEjqmuheF9xGbZpIrucaCr6CWSL4MAAqDoqLDKD3otlUtFI0o6xHGfLMuXsOss3XMK3Ol1E67AzogygtWS6KzSJnnpR/aU9IRBB5C8Glsu8d20zsaudATD/iV7o1x4HENd;25:a/Tm0WsrLMcAGxbd4vlP+PaMdZUl990+COQuW6Cj3paclCq7DO1TqJYUvThUrS5uIrswI9lBp9IQjN3pKBHj6TlPys0BspxcR6QXVIrW8b6hRRwu2deFdVDvrr/qtoI7SDXW54FPYjyZtbfqsoX3N0zkmRVWd3qRvshbPefbn0Ur6cPvzsmPYNXO46cMYNDfgxXbK03gFEiWKFTNZZhBdehQAuIOG4mZ09QQ8Vo8PN/piKAACiHJqwpqAhwNNIglGr7wYF3irhOiRfngCu49FH8hae5k2fSkgXcfoBCc0Mla8WtaKWimhbThBta71UwOauan1maSwOTg3Tjdx45bHA==;31:7iQizyeR0WZntZ6yGYidzeU1yLB+T+F47rCGQ2zLFFZXQDSgRpok+sguYaIKpRYGZIWCAZDDiWjZeq8ngMfzmcT3bJU8nbI4d0Moewx6YSBMPU4YWYrxKJ4d2C7XWst2ToqJMkPKDTB93frbyZbzM0C4wCYiG9Zm2bof9L4Phl+n/jlwzIwvhUWQZqXcqBdqY0BBH5rZaFgVV2oVuE0laJN0K5zSecs7do2b6bUjeGE=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2626:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;20:xQUvQDBcC+7i8ctYQtYFzGPfCILkmIEe4DEDkQXAfGgZ3wSHpzC8Goalk/yo1HP6GH01Oaxk8/P3WjAx3FeMKHWXstRBy4RB86weXOSy/Sk26apKp/jZrXhJ4zUMKFOjOQEg7Ya5aerzypxFlCeGa6/BuG7yrydVf4MgbDfT4Nn99lNE1GVH3o94woAO27c1Z5anwvEnO37Tz7LwZT+i2KKokKxSHyZ8YefIgMkaXDfw3PvMJCdf7/ABpXqbwWl2KbE8Tmal4tccYZO40PSyP5+ylX5O6gAgy0rnUjePnc3bg1OL4RPlc6amHbRfgm7tRHFvP1ru/TVYhN14Ilaq70qtWz8+HU1XG8VXrEsLQYOKvTZvHQV8abPBLzNurha/I2i/0RGY+f5nb5SaX+oPavqlM15kX8F6883oqwU66vzOZ1MrYhiTygTECRacbKr+68veIW7ZEKR6gAQPpATVAAJ0KXChztWtncIHXvqDhqaOCw9OoAQl1sKHFzbC+HBH;4:JaSvaCqVhg1Tmi+PFB3AsWwIQNjkv83Ub0O7BHZi9bso9wOGh3GOn3XNajuMOF9v0HB/S+noQHcqkCFEAhEa9BjlMUg+HOOLTMqWhU5ov1Ej9MMz70pUsxY49HhLYkV2+4J+THyP3RFBwwKz9zfhVQ3/iJeAzyMSnB0YDvPFB0KVNDlqBguk4HdaHeZ3R0fB4TFiC2Ma1B7lfGkqJbOcmFGrdoJmI2XKk8Jvq3jbU4Mn+Un32GAHjvAevEOoBDB9RV77YZH1f69TmDenORQ5Y+tANdRmW82O7lKXv6GzBtWQv0ewgLNjv/i6bEgFU5JJ8BATu+deeJH2fgnChklSkeoDQGtGX54SiAi3STfbuor2LcH2ynvxXrLMzoS8rVAo
X-Microsoft-Antispam-PRVS: <BN6PR03MB2626C3BDB1B7ED80A10EA4CBEDB50@BN6PR03MB2626.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(18589796830644);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2626;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2626;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(43544003)(13464003)(25786009)(4326008)(86362001)(8936002)(53546011)(6506007)(76176011)(52116002)(5660300001)(26005)(7696005)(6666003)(45080400002)(81166006)(54906003)(50226002)(386003)(316002)(59450400001)(33896004)(93886005)(50466002)(47776003)(53936002)(6246003)(55016002)(16526019)(478600001)(186003)(6116002)(305945005)(39060400002)(230700001)(8676002)(66066001)(9686003)(1076002)(476003)(446003)(2906002)(11346002)(72206003)(7736002)(6916009)(107886003)(229853002)(3846002)(23726003)(956004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2626;H:xhacker.debian;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2626;23:5cFiOa+cQpxhDTKkpGTPZX9aDPoy6y5RhKVSjtPpN?=
 =?us-ascii?Q?TgP2PFjKwWRfNDc/s6iwnI3/sabk0O3SRBOZSLHmDoza2qqidpSit+vjFvJ3?=
 =?us-ascii?Q?NejZgxfcOoKF1wAWPg0NrkTWIMV5gnmRiXxX5i/o1SnqKkgJoQAkPKGvCB+R?=
 =?us-ascii?Q?zBFXXHlKLlmwqMLih78Y93E9z1hBj02PEnqGJEdO3B5JqB6eveoJdOPDqNYD?=
 =?us-ascii?Q?dyouiRvbcNJrvHGIfv7Py9HWH4OuyLsj5agjAm3xa5rkQs/dpGK0sp88o5Jv?=
 =?us-ascii?Q?5MjZ6gGnVPjODjEl7waSDR09S3YMEOx5LiJDg2P8XPE6KtoWFuSTJHD6zKQk?=
 =?us-ascii?Q?wjtRCI42L10J1QlWjxrHQw4UFDqsLh7GSE8zsQqvg1zPfVRr3qxSGPa4qtO8?=
 =?us-ascii?Q?5qBKz0MQSlOu+oQDgJ1NhabtemoW9GHf3/cHMaq1UVjt582p7jmMCFLeDhVf?=
 =?us-ascii?Q?lc2q7nhwzuwl9kEiUXPwVWvcE4m+Wv2g9IDWqA/QJRY8NE/76+hPQAK1MWoA?=
 =?us-ascii?Q?/IpBtd/25ymCuyzPjCnSgVbqd7V+tLlCUa81vHI5BnFKWBk01MYoBVCT9woU?=
 =?us-ascii?Q?IJrda0maIv0AkCAO1iJF4nZoxwoCzCvSjCGtyeLUJ2MQua9kIu7Qzy8qblHU?=
 =?us-ascii?Q?HlQPtkRimFCEQ8UpT3+wCWh2ZLRArLXJydAO7gWDdMPbpvAZPkVhCGlkB+nz?=
 =?us-ascii?Q?fGCcTJUupewASLGL1MI+Ybd1O+v25ATnzR/RTFhJrhAE5lNS9SBmmROWi6KC?=
 =?us-ascii?Q?+XdAg8NkXUNCuZo69cKxOxrRjb/AO3I3yktL/CyFEBWq9L3jiZDybveyE9GS?=
 =?us-ascii?Q?0kDeEZe0wPF/zKTOLv1YsXBG7V/wakxSqDEWUORcVywPnB9FBk2/8v6Fptwu?=
 =?us-ascii?Q?fepQ899U/uTmfg+RHCGdec+0Ly/VkYPbb4JbYr46CVRA7OHRhwlxQEr0nOlw?=
 =?us-ascii?Q?E5+MBOcKtzfk3faAaRZnBHu/NOYagfeFHdbpuTef3QopXS8UWiLWYw9lA4ik?=
 =?us-ascii?Q?D7p0DLXjSGYWVET1V9kNDfn5KRlnHheekINmo/RJvfy9OlW6sj369VJTIImn?=
 =?us-ascii?Q?EwAoj8xEkgl5fc2ZUhHx6C9gr6UONBJTMDW88tCQ0lLGTO63AWRzofdIvgMp?=
 =?us-ascii?Q?04vGvUXYuLo+gV1d6MLLAXoidp7wV+rjTOa6aijyXND9rf3JVPsnnFUN8+S7?=
 =?us-ascii?Q?2ZzQ/w4wqUj3QhC9anCMHJ54sTYF+ynohfUloHNB3/7zLo6tsGGhLhBJcfa3?=
 =?us-ascii?Q?dRcY+mroaVtfIvtv5tsXEDKu7HxHK+LzROkMDSEyR9ZGyETDlNfUN9xBEwp3?=
 =?us-ascii?Q?oERTXKvxC6CPJVPTb+Xm9E=3D?=
X-Microsoft-Antispam-Message-Info: 8BRDmc4tjcPuoeOyYA6Dzwwnzc+fr5rmoI93t0klrFMZlGcEA5ohavREu0I6Xfq/66fCX+rwQPsGAYZCpxlWuYIJmamfAMjpfADg42Y5ANPInMhKQWzs/UgTTUj6WK0YBLBUzjlcJ0Y66T6vHyQyDiXYZC/4lZCGmluSRlaQMmQlwcP2we6nhD60BdioFKOg
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;6:OqX9q5K25N7dk0WYwNpqJdbL6K8Elo6VEYmNmez6PFVvoPuOxEKt693dQq/PwbXwMZpBR+sEAIq9x2OB2KamZxEK091/8mswZzR+gBkFAFl6jQ69fdFuHRn812GYz3vhqqPQ8wn/iJoPkooq5ex/gDAeHDGsj93UAVs2uIb98+TQbd/qf7V7S2xTQReVXiedXRFAxqAqyUs7iqhajvm5DZrMA2+N93l5wYro2vYi1k6VFz3ugKKcBOVdOj6NCArxl5WZRsqtmaGnne/e/BIqB+036kKNgwlHeqr2Hz5fN5BV+CNvrnNuGinzD93uExTOZsX+X8kCU88cMte83OoyI3ADLf6nwHu6S9pu37hmzgJRlIjws+EwfWWOIekO/+nd35OiBJzueMH+pA7z/eFP/yCd0dhuyY8jFB76cVbww6/4Lvjtc7QgdA6N5IdmnMh7LkPoxUji3pQsSydxMaIj7g==;5:RIV6SpBtpFTxUx9e0WJWHUiNQFC3gsN8AeCuW+TTHZiNKmRNd2Tka1GjwfQqaa06lwWShLc/AE6FxZ4Ark5ths+jwBrEzGvSGyS3WgNAl7aFibMzbvBqyQNANWd13sDS7WbOkqqDq2pv0KGq88gZeUpZGOky0p+I/TUSl6AJIJk=;24:HcXNvkY2Sqd5Jyu+CtQ/1/5hvlYH5hlCHwRGtAIT8835vqKAjcJ++/yI303HWaobZl58tNzOmS3+EkA1gAY7LovvXtR6x57Jau4cKVWHc54=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;7:oGo1PBDTrL5yBsSkQNi6HG0cWY0yqw6vy1NxrsFi2ie5PcHGABZNC0ih1Kh1qfspMOETVe/BtEbpbErv/RGENE6+GHdJXuxs8+BGCSyKNcbOUoJ79fb/FkJ7DoA7O7HlwTEBv79sHZBTammDAQ+7jRTo76IdoHRfQm+e7ge72XnF/kEroAr9RacKZyT8sV6k3V8GTD9s6TdVYPpK0+78ixS2T4ZYTQY9nMgHJPEmOlF6WKGuXjhScBMSVsLCsOHS
X-MS-Office365-Filtering-Correlation-Id: 461542c2-46e6-40f2-4f53-08d5a5d5512a
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 09:09:53.0160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461542c2-46e6-40f2-4f53-08d5a5d5512a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2626
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 09:00:40 +0000 Bhadram Varka wrote:

> Hi,
> 
> > -----Original Message-----
> > From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > Sent: Thursday, April 19, 2018 2:24 PM
> > To: Bhadram Varka <vbhadram@nvidia.com>
> > Cc: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>;
> > David S. Miller <davem@davemloft.net>; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Jingju Hou <Jingju.Hou@synaptics.com>
> > Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
> > 
> > Hi,
> > 
> > On Thu, 19 Apr 2018 08:38:45 +0000 Bhadram Varka wrote:
> >   
> > > Hi,
> > >  
> > > > -----Original Message-----
> > > > From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On
> > > > Behalf Of Jisheng Zhang
> > > > Sent: Thursday, April 19, 2018 1:33 PM
> > > > To: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli
> > > > <f.fainelli@gmail.com>; David S. Miller <davem@davemloft.net>
> > > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Jingju Hou
> > > > <Jingju.Hou@synaptics.com>
> > > > Subject: [PATCH] net: phy: marvell: clear wol event before setting
> > > > it
> > > >
> > > > From: Jingju Hou <Jingju.Hou@synaptics.com>
> > > >
> > > > If WOL event happened once, the LED[2] interrupt pin will not be
> > > > cleared unless reading the CSISR register. So clear the WOL event before  
> > enabling it.  
> > > >
> > > > Signed-off-by: Jingju Hou <Jingju.Hou@synaptics.com>
> > > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > > ---
> > > >  drivers/net/phy/marvell.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> > > > index c22e8e383247..b6abe1cbc84b 100644
> > > > --- a/drivers/net/phy/marvell.c
> > > > +++ b/drivers/net/phy/marvell.c
> > > > @@ -115,6 +115,9 @@
> > > >  /* WOL Event Interrupt Enable */
> > > >  #define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
> > > >
> > > > +/* Copper Specific Interrupt Status Register */
> > > > +#define MII_88E1318S_PHY_CSISR				0x13
> > > > +  
> > >
> > > There is already macro to represent this register - MII_M1011_IEVENT. Do we  
> > need this macro ?
> > 
> > Good point. Will use MII_M1011_IEVENT instead in v2.
> >   
> > >  
> > > >  /* LED Timer Control Register */
> > > >  #define MII_88E1318S_PHY_LED_TCR			0x12
> > > >  #define MII_88E1318S_PHY_LED_TCR_FORCE_INT		BIT(15)
> > > > @@ -1393,6 +1396,12 @@ static int m88e1318_set_wol(struct phy_device
> > > > *phydev,
> > > >  		if (err < 0)
> > > >  			goto error;
> > > >
> > > > +		/* If WOL event happened once, the LED[2] interrupt pin
> > > > +		 * will not be cleared unless reading the CSISR register.
> > > > +		 * So clear the WOL event first before enabling it.
> > > > +		 */
> > > > +		phy_read(phydev, MII_88E1318S_PHY_CSISR);  
> > >
> > > This part of the operation already taken care by ack_interrupt and
> > > did_interrupt [....] .ack_interrupt = &marvell_ack_interrupt,
> > > .did_interrupt = &m88e1121_did_interrupt, [...]
> > >
> > > If at all WOL event occurred marvell_ack_interrupt will take care of clearing the  
> > interrupt status register.  
> > > Am I missing anything here ?  
> > 
> > If there's no valid irq for phy, the ack_interrupt/did_interrupt won't be called.  
> 
> Which means that the PHY is not having Interrupt pin ?

No valid irq doesn't mean "not having interrupt pin". they are different

> 
> Generally through PHY interrupt will wake up the system right. If there is no interrupt pin then how the system will wake up the from suspend for the magic packet.?
> 

IIRC, the phy irq isn't necessary for WOL. The phy interrupt pin isn't
necessarily taken as "interrupt"

PS: Did you use outlook as your email client? it's not suitable
for kernel mail list.

Thanks
