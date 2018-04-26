Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeDZGPj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:15:39 -0400
Received: from mail-co1nam03on0053.outbound.protection.outlook.com ([104.47.40.53]:30752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751465AbeDZGPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:15:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Thu, 26 Apr 2018 14:15:08 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Bhadram Varka <vbhadram@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jingju Hou <Jingju.Hou@synaptics.com>
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180426141508.6660a633@xhacker.debian>
In-Reply-To: <4273f766-a017-b336-7d14-a28901d274b9@nvidia.com>
References: <20180419160232.519d15be@xhacker.debian>
        <20180419121801.GC17888@lunn.ch>
        <4273f766-a017-b336-7d14-a28901d274b9@nvidia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:402:b::26) To MWHPR03MB2639.namprd03.prod.outlook.com
 (2603:10b6:300:46::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2639;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;3:/eMzxoWuCRLcFiRWudnQvyalkXzszXyCky0rQtOhnj6b/KT42uCpaExH520TOupPqaGpEcnBVlQBkOOEbr9u3LtJ3wv1JFN7FIQRKm4MlaAfXnFHO3aTljDAQXiA/tsvOOo64oqkdxd+yrS+VG9lMhVjeqjrJzbHvlyOcXtrEYcn2oqqEsUx1gAw0aB3keH48O0IFuCK4oNNXj7MDBxJCeviXJ7vsTGfO2uce2qgavwnFQ2tAxGJUBtR6JRklgVG;25:5KPYJfxARjR20g2mnoIM8rCSl5wWfB/Ug7a5Z+KHrJk8sKWmrbKX3iTbd7CK255oaf6zpUEynswTEJFvg1/Y81Ts7SUy7F0r8i02N+6egJ0rnpC+EW24Jh6LhxqYZ5X+c0BDT9iHRf4uJ3pTSEIjWU/IcH9rQGy11k43BIs7hZTcD4phho3YkDc4zAe8Ze700fPb/JVT9XQYZwdNAXl578rueLmORqnJCPAYIB16QupSsFsMQezxCvm0wwcQrbvMVp3ST5iNf+enGmPmLR2+RoOJZf6zmcKcjndJOjJtN1Wnqtafm9t9uJgydLiYlWyRKTS1Uy//+joeTDD7n8C1Lg==;31:Q8sp+kNUqbOtcyfqwcMaRiWYTKWc9zENvWLh3md9j3TeG70C9VCOy1wAe7/GYhz5yvJ5Ru5qwpp+GBGi63aoyLaeg11lSMETRtGAtc/ZaYOMr3g0cJ0gaFN4tuA7kAwzI/MkZO2ryjmbiST8gz4EOBCglssaPaSAOUfjNHO5GJuAjW7iccbVvhmj/BuC9cQn2xYXkppI7jML1BS2htavrLqaY7ATlZCs9lp+iqRP4eM=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2639:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;20:lfxdMucXABrje4O5JLoKkWBs5ohY6TgNoqW/y4gV0YteAYdZTZziKKJ3XV8F+VBDUjIIHwG2K03mgBOSaKA8Al4/h6a2TCfJvuqhkKqNxTU5U1GwrcBjSMYd+MIeEt9nUcTC7KwPB23UyPwwwTuBwo0CtOjoxbLtZOtGtr+vejzfkZjTmbVr7YBo+0UwScilHQIrEy6Zmbwyt7A9KpQMb2sbvxhoXILdqzc1JIexNqZe4t5RZ8niGg9H5PYhTYG2UbYBXe2Sho1F9ENqwVsoFCwrxY3cdxR3o1peI8m+cYUVolDcvDGHNlarzUxYuuHbjHIbld1CbZUFbN9bbeVaYxw0QcKJSBBnJkx/qQOokUfW5SXmxeTG1fCJPbc/tYX+Mdyy75uvcmHWqLfJETfEICNOSphc/tBdSaYm/urh0DFPFn1gf2ttk1BuuHo46yVtrbtb/5K+VeRC4/JmvWK7SLPS5wKW/d+aWflG5VkVDQlMzinXgcEUCrquzDfkTluL;4:c/i5mcJCfcIPXqXKXoRrcV7wF55Yq7Hv+aexa+2zkwoUDa7/RtMS1hqBzgNAQdMO7VJ4WCO0tb8JzYoJ6CMax77l2Dqp2dUAZakm5ql3MFT+Yg2dBqLxkmXjVUwejI13PHzaT4pREOHx07lVzXaPGk4jgb9QDHQruDpxRQF67GbTm9+wXVtzTGByZxOkbynDnuFMs1PLTm7n8TscmYdmd1Sf4a8g7vOkYU3ntcqGlj+buSzruqugVKDknCpHeN5mD9aoh+Th11QdpeKQv5lx+w==
X-Microsoft-Antispam-PRVS: <MWHPR03MB2639FECDDC13CF9E037E6542ED8E0@MWHPR03MB2639.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR03MB2639;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2639;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(189003)(199004)(956004)(66066001)(476003)(53936002)(11346002)(8936002)(6116002)(23726003)(3846002)(50466002)(50226002)(68736007)(486006)(4326008)(2906002)(478600001)(106356001)(5660300001)(72206003)(81166006)(39060400002)(186003)(16526019)(107886003)(316002)(446003)(81156014)(8676002)(7736002)(1076002)(105586002)(305945005)(6246003)(229853002)(54906003)(86362001)(7696005)(52116002)(47776003)(230700001)(25786009)(53546011)(386003)(6506007)(26005)(76176011)(33896004)(9686003)(97736004)(55016002)(6916009)(6666003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2639;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2639;23:PXhIEMxvndlyGCb88ny9K9w8AKu8gjskO+6v4/38u?=
 =?us-ascii?Q?rXuHWBqM4bFnCknv2+bmq3U3O1ImXTeLc79IdIUVKh2Doby7wuZIxuAOJhgV?=
 =?us-ascii?Q?B70VeiFq6U3ywyb2qWSAvR+GZ3XC6DcQsUCdpCls9wi82Nm44VJYL3SiWXEC?=
 =?us-ascii?Q?AhvRXJnwD3Lwc0C2RgqyZyLt5b+Q5Pf3zn9hqpQt7y55md8C8nLIzs8TwU7d?=
 =?us-ascii?Q?wTPTbSafSsP6SBB17+CAv2q8DLVDjmwsBkdicJHSUqjtiCxVAmPI+1WvFJT4?=
 =?us-ascii?Q?6okNDYHkQ0i2bXdzLnzN5m1K2JriBVlPayGGZm9xqPvWerkN24kJ70o52yUp?=
 =?us-ascii?Q?wmuW7chgGSGSEnoy0mdYb0VYaIsk+SZhbszr/QZDVeRp/yX7lB7z3N5eeiJv?=
 =?us-ascii?Q?ky4vc+qKZBu8NruOIE/n8HqLfGtixgzYIPDVTThSQit1tgB0INSkJXi7IGRB?=
 =?us-ascii?Q?FHOIBFIwDQqzY6u8PhsfVU+id+8YIBzQ2BXv0eNEQQg4ln063T18V8QTkiD+?=
 =?us-ascii?Q?hf3Zu1LZ49WHKavQkPfqtXBtBNXuv8kDKzx21bs4f2cHBwfrl5LxVwX7Z4NC?=
 =?us-ascii?Q?RV8mo56BldgEoc3a4lqeMWBxL4o1fTRK16sD/Xz2WY8VZES8v2/dQvjLXOqc?=
 =?us-ascii?Q?MpvOdytpRWqHGVnUV+eny2e9/vu6hQOsL/DMeXGKSI6iqg1Uu3z3Ox8037xT?=
 =?us-ascii?Q?T8xHcwhtu5FSkFnOU7u9cjZEbBSTwFYIc9l29OdJyc3+ObJ7uaCdLTRBcOC3?=
 =?us-ascii?Q?bve1A0sCa7gGFuwVHu11Tr8HH4idn2WXntJjknRYfUxCPas2lXmVFnOvTH15?=
 =?us-ascii?Q?UWZDwsyWo6M/o0nwUuscDSW2irKBdO8Z7HHxCgqycvhQjp9FPnSSeL0mDxYD?=
 =?us-ascii?Q?4EzVY/z+SZl6teLC8aQG8VXCnPcvg0YZ7u1MKH8gmBLahXhlgwa+VGssjcNp?=
 =?us-ascii?Q?jJOVPMDFUalEZBRiVoealGlDIUERgASk+2FEkdGK4/AsZtIBCg/xq2XBBD/F?=
 =?us-ascii?Q?yNXjlu38NzjSDRJ+RTt0RggXNf03/MaQTGD8cTY3vCJpoSruyo4gDGYQAjd1?=
 =?us-ascii?Q?Wfvi9ONMls1qZPmg0ac7phhXbHlxFLf5HQv3ucZpohWMshjW9yKjQKLCCqja?=
 =?us-ascii?Q?Gd3yXACKDQ2bksaFlUBBrobrnnLPEeZCWgpqvEMAjrLx/ONMkp/YkLjUK/Ii?=
 =?us-ascii?Q?c77zZ3W61Fj19xKto22Y2XXcmDcaMWdcV8MeablZDWZpakrQno12cHY5rdhh?=
 =?us-ascii?Q?snXqwDw05v2VqlHnBd7Ry68aWDFCz/x2mC7T3/Idj5J4Zp7c36/lRJ7T6Zt0?=
 =?us-ascii?Q?Ci1ljNeNx19aLTjslpCID+Sfy3r26f8YNDjvqgUZp5yegosXDbgBjFskOgJw?=
 =?us-ascii?Q?VjT+A=3D=3D?=
X-Microsoft-Antispam-Message-Info: tUhOvngxxcBozP1oYjRoa1uOTd1mRLkoW+chElunKEUvUAgBA7kTVeCPehwTHzm3VS1WzfVczaf3vz5Z1kmibtMQ8dX5l/0sdx4VWYGtsaQ6TWaAwBzLNg+Hn4PWt4HTf8E3+iofhKA7Vpv93LOJXCFRoBrTPnQroHabYN1OKp2Tk9eHD+5wrDf0ggno6W6x
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;6:1Q7sXnbIhcnwlTfiJsbn4OlVXsGimGi9sPzgj2Eo/vNHyugTCr2UmrusMa6B4V8ldnNHTXXQQwAM4k3N7ciRd6ps5rGNpSj6F7/KgTgcLjGlMVnG4dyJpvLkPtVc7TcusTRJKRnfNoPNJSAfKe0KwhJANS4BEhwnGUZ06aZ/YIHPca9ff0gQgm84TP0k+7t3EkP7bpuG95RJgBCHqrAIHdU7VZmLGdzzwxhXV1LKUch2g1vl+lS66hRt9gBgKugbRZcCIRQpdQLu3rl9105imX9z2RjBPo8dXPvwnfg69YUpjEEldJDxVYLmQzdqEMrHr2YgU/1dv3DMIYW8300WHbo5MDOUf2MgJ/rtj2KA4EJ2lAQLzUqeJ8L3NLMIdFCUSH7u/RnRHNzEYXeJZo0VXZtaEwKIgiSsLkQStCHPHq9CxGcI5+U5kxozCRD5MkbylJ2h2dj7j5FxGrRONeIdww==;5:iHGB57kknWzQAAStJ6EAtGHjtTPmHRSR+9wv9VmOPbot+0yzucvxlF0OcutsoQ0Gwwas6qrRNyF7wOTtCPXYfgVtGZTtpo4Wcp2Zw2NS54pwNVEPoiYeHpxDBrAPk1L1Ujb9v+WehMbPLv+2oVDxH7gK1KWhMdnDYzvNxa/V888=;24:1o9fE6vHveme0I5JRsKhrRxxy0CWd8NQ/2dbcAEbl6NMHP4eg2Cgu38mcEuVFQwYWmhkuxgi6XbjnLS+pW8L3Ms0rA3PYjrz1I9gwoboK9w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;7:Vwkogd5izyloFk2xCYFypaXr14zG7OIAxENJKxULs62ZlNpZGCq3/v2dMgEGhsCCDuZI0c0Qi0MVcK98HMFG4QCinuYhCWItPy2Xu75ban3v7LTY5RCT5P2MrBcXUzBPaooXfBlCWY5NMU9iiEIfUjapYcy3DoiAT8UW+9N7L+j5rDrVYwTBt7IP8of677eSkIXj6UbwFUj0tz3BQ6D/ox8KoL/bIs665v5bzEFum+7w8TvMrWNOkRR6bRekfRRt
X-MS-Office365-Filtering-Correlation-Id: 02e2f4b1-98d0-49f5-0b09-08d5ab3d1e21
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 06:15:31.3067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e2f4b1-98d0-49f5-0b09-08d5ab3d1e21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2639
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Apr 2018 11:10:21 +0530 Bhadram Varka wrote:

> Hi,
> 
> On 4/19/2018 5:48 PM, Andrew Lunn wrote:
> > On Thu, Apr 19, 2018 at 04:02:32PM +0800, Jisheng Zhang wrote:  
> >> From: Jingju Hou <Jingju.Hou@synaptics.com>
> >>
> >> If WOL event happened once, the LED[2] interrupt pin will not be
> >> cleared unless reading the CSISR register. So clear the WOL event
> >> before enabling it.
> >>
> >> Signed-off-by: Jingju Hou <Jingju.Hou@synaptics.com>
> >> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> >> ---
> >>   drivers/net/phy/marvell.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> >> index c22e8e383247..b6abe1cbc84b 100644
> >> --- a/drivers/net/phy/marvell.c
> >> +++ b/drivers/net/phy/marvell.c
> >> @@ -115,6 +115,9 @@
> >>   /* WOL Event Interrupt Enable */
> >>   #define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
> >>   
> >> +/* Copper Specific Interrupt Status Register */
> >> +#define MII_88E1318S_PHY_CSISR				0x13
> >> +
> >>   /* LED Timer Control Register */
> >>   #define MII_88E1318S_PHY_LED_TCR			0x12
> >>   #define MII_88E1318S_PHY_LED_TCR_FORCE_INT		BIT(15)
> >> @@ -1393,6 +1396,12 @@ static int m88e1318_set_wol(struct phy_device *phydev,
> >>   		if (err < 0)
> >>   			goto error;
> >>   
> >> +		/* If WOL event happened once, the LED[2] interrupt pin
> >> +		 * will not be cleared unless reading the CSISR register.
> >> +		 * So clear the WOL event first before enabling it.
> >> +		 */
> >> +		phy_read(phydev, MII_88E1318S_PHY_CSISR);
> >> +  
> > Hi Jisheng
> >
> > The problem with this is, you could be clearing a real interrupt, link
> > down/up etc. If interrupts are in use, i think the normal interrupt
> > handling will clear the WOL interrupt? So can you make this read
> > conditional on !phy_interrupt_is_valid()?  
> So this will clear WoL interrupt bit from Copper Interrupt status register.
> 
> How about clearing WoL status (Page 17, register 17) for every WOL event ?
> 

This is already properly done by setting MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS
in m88e1318_set_wol()

Thanks
