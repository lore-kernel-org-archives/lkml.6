Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeD0H00 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:26:26 -0400
Received: from mail-co1nam03on0084.outbound.protection.outlook.com ([104.47.40.84]:43472
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757469AbeD0H0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:26:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 27 Apr 2018 15:25:55 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Bhadram Varka <vbhadram@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jingju Hou <Jingju.Hou@synaptics.com>
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180427152555.5e8efb9c@xhacker.debian>
In-Reply-To: <73e21c83-f78a-8b22-a421-f179ef6adef1@nvidia.com>
References: <20180419160232.519d15be@xhacker.debian>
        <20180419121801.GC17888@lunn.ch>
        <4273f766-a017-b336-7d14-a28901d274b9@nvidia.com>
        <20180426141508.6660a633@xhacker.debian>
        <be2addb5-b3fd-13cb-ad33-f0527931a0d2@nvidia.com>
        <73e21c83-f78a-8b22-a421-f179ef6adef1@nvidia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:402:c::32) To DM5PR03MB2633.namprd03.prod.outlook.com
 (2603:10b6:3:43::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2633;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;3:2jJAmyx+ZUGoEyI1IveW+p2Jccqw8CWkAuWDw3cnw6uvX685wi7XvojyOUtRLSib5fKIHAeHtYwCvn8IjS6MC1gB32MI+vNRnOE5VgxnD/JFKPktXzO/7WZXlBPFHbQ37UIgtmuL5FRQjWOIuwrIuVPz5qz0bQ6SZ2m/fwv/LzX1A5nZxu8nJ3CwP0O0Hgw0GoiSIHDzxFnJFEqpX/4N+yrTaR5oOjKBCdfSrahNUclNgceYgCZpaOxsxYYxTqnx;25:ZXzBOAmLcmZB1Tm2ITn7idXml8/HfbBO0KqLz2Npk9kBvlBMBfAt6PvhtLM5oMcABFkWZh3pxXryUAOaLihqlo+bIVgP2iMK4fP+bUbpH/09Ft64NYUabzP12QQRRovCGFm2E19XbTlPR2WPeqvGimp5o9ip8Ve82Gp4ZD/NMwAcoUILAth97iUqUECcR5xdsdKdCrj0gqKuN3MJQGfeehIx1Z7nV2URYYJ6fUGkfy+FVixPhnmjoNeHgaKrgXXw4RAuS4m4aDGw2oJb1NcDKPDQbPOCjdEftMsHOdqA67/lp0uqRc84xXti1uPbvhcwjKgVQ7KNehgfHXNafngSEA==;31:nsJVlHCw7zckRFJrrNyEvhdDzJcnwaHiAk9Jkmm+Gwka/NXGxCsL32z3DK2pxLJXVj60M55SLLHcQQB682osXcy9ncaH0zc0GHbgQ8hQiKLXgByf9ANwvA0Em/Kj7pHJ9LfZ4Tlg1RNNwrPiOuuMEmMgbQwEFPmZavy7xJ0BO/dX0Fs4y6mMYMB2IEtBgX5iehVFoq2t/AamxDmRNE/8bzBj4PoefTD2faVWo4GldZE=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2633:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;20:L2BRB93BSJNMTSl6UlvOU+k1mnc824cTCwhQVR/QByOjVYGgZWVUhZdKatqITEYbz+iLrRVvXyKEIknagGvriWFVeJwTzvT4wPGdaw7yw9oRipqmZ9yBdI6rGkdxKjgild7Uy1LdcW8KMETPJO12FZusgw/HShb4xGotYloaC/BwUZCFUxCX0VR1lzPj9ZjjZTF0T9Qckm0g2v0PlGV+u81u6yAqESVNTwH6u1eqOHYxAZcTluwiStkLfqqYP05I58kCr6mibuvtyGpY1yFScD36q2AYau3zdBpbIIn+8pIPlUZbDCAC4Uhi4sCPFv8i6ONtSn37WxwUxDxapxbzkMNj/tML67NK+QFeDuQs/RdyhYYWZS1fNLPLrLdS7O6zS3qeAk4R+rUkLN30tA5lwsqU+ilepACgy4fv2MRvDN8CHckEBEoLDjEthVXvDtbdmYsUHrM30d9PT1VDt6qoCzxO4qcpid9be+0ed6cmVd9OAYpTKvg+qJosP6C7WfDd;4:ICZhlul1r2NmQ3UQ0J+0+aBgNbjb28PnSWG0LtdoV71YZgp8IaHsak3xjZItvLn7GNVp8ngg7YE5i6TrLXr6kAcLZtECwwcywiIimAQOWQ1prEQSwpVt9Y/zVuz+wfv8+YvKW688mGCDMe+Sn6q6M8Sd1DK6czxH2iru/WogXxAbN23thdw46PgJ+FpRVFUjCnoEId/QsXZP61Plt4PvNNv5qpXM29dGlo3Fs1310z3p8qU5yI9eb50cbBtDj4XWPjNyJBkIfah4vl99m0+zAA==
X-Microsoft-Antispam-PRVS: <DM5PR03MB2633EC69F97E2B3C9CA9511BED8D0@DM5PR03MB2633.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR03MB2633;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2633;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(3846002)(6116002)(47776003)(86362001)(93886005)(1076002)(186003)(16526019)(66066001)(68736007)(97736004)(50466002)(476003)(105586002)(39060400002)(6246003)(956004)(107886003)(11346002)(486006)(53936002)(446003)(229853002)(25786009)(305945005)(5660300001)(50226002)(4326008)(72206003)(2906002)(55016002)(9686003)(6916009)(6666003)(7736002)(76176011)(6506007)(386003)(316002)(7696005)(52116002)(33896004)(26005)(23676004)(8676002)(81166006)(81156014)(478600001)(8746002)(8936002)(54906003)(106356001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2633;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIyNjMzOzIzOjdTM0Z0Q1gvakpZc2RXazFaSHlsblBCcjVG?=
 =?utf-8?B?a2NUNjM1a0F0eFVTWGlLcUZjY0ZSZFphdmJrR1p1ZXJ2cEJjWnJmYWk4TTVq?=
 =?utf-8?B?cXl2K3YyL0xhN2FTRHJVMy9SY2Z6OHRpaG0wL3ZEMTJ6UnRJTjQ5Q3JvMTJL?=
 =?utf-8?B?d1EyY3lQdEpaeFh0TEJIME1ucitVNmp2K3FzSnBpSGVIdHlnSXlPK3YzSTJ4?=
 =?utf-8?B?VUZ0V0NIUVFaZjRRWldXeTIweVlLL2dMMHZXejlXUndWNmZ1cEJKVENlbmJ5?=
 =?utf-8?B?RjNmdWxOeUpLR1NoK1N4aFJ6QU9GbXBCdHJWS1FEZU5wdFl0RU1SVkVpNlFu?=
 =?utf-8?B?a0NKSzh4QzhQTUF2alRmcWl6ZFpxZDMrQzdUOVBBajBNdVNIS3dwUmU1bExK?=
 =?utf-8?B?VEZVdE5RN09RM1daNVJ4TkZYYjVmZGMrdHVxS2RhSHBvNU84NExlR2J6ZERY?=
 =?utf-8?B?NDgzRS8vMzJxVVRZRUQ4TnFxY0V1NEJTMWM2OGd6a09haTJLdFQzWWZZQUJK?=
 =?utf-8?B?MjBjb3NqKzdjZ3EyRkdOSFk1Y09ManBRKzhYU0YzZW9MeWluVTQ4YzM5ZlZM?=
 =?utf-8?B?TWY0NmZ1ZSsyVzI5M2RXeURFZHpIa1JYQUI3MHIyZmpiRFgwSGRUMkg5ZDFq?=
 =?utf-8?B?a2htQldodEdqdW0xNmJUS2g4Y1gwYWN1RmNGMldjNjJIcXFqQUVNUW5yMTJ5?=
 =?utf-8?B?WGtGYk1oUkZ3UHhxWjIwMWpUWHpmbEJyVUljVkZTUmNyMXhLU2pTZTVZcXZs?=
 =?utf-8?B?REV3YlB1c1FvUjVMcmVIcTZuU2d0eURtYmRPL1hNdG1XWHU3UThlZU03aXQ3?=
 =?utf-8?B?NXZxYkY4RUNRT1BDQzgxaUJuZUU3ZGtGOW9mcVVBSWE1TWtleVJnd2tPK0Zh?=
 =?utf-8?B?VEN4aDVvK0JwcTZ1MHFhbUdRaS92V3ZaeTlIUkJyMkVYM0N5emRKV3VKTytM?=
 =?utf-8?B?c29NU1BzaTA4RFRHb1k2Tys5eXFWRWR3ZldveWxuZ0dscDJXSHBKYjlVc0F5?=
 =?utf-8?B?OUFUaUN4dzRzUEZoM3BGZVVPRzF1MHhza0xxd2UyWFRmeHBCZnRLL28zY3ZD?=
 =?utf-8?B?QTF6dWcybjJMYWoyYU52MkJaUGw5L3krY2ViVlpuREh2eTZvVG1qbXNYR0I1?=
 =?utf-8?B?Y3lmS3hncUYrbFdadzRvSU9ydFFwV0l0TThqbEd1bDdhaDJudkxnRHZ4bWR5?=
 =?utf-8?B?ZXhJZ1FqQ3ZQSERINzd2VkJ3ay9XRENTdUNNVFgvcVpZNEI5VDQ0MFF6RFhq?=
 =?utf-8?B?Mkw0ZWxyVzJxYko1d3JydGQ3M051Yk04QXVnMFN0MUU5R2pWR0NOVmgvQ2ZC?=
 =?utf-8?B?ZWNtSTczb0g0MGUxdWZTTnVQcForSXBuTTE0djkyUHhxNDRiUDZUaDRHeVRj?=
 =?utf-8?B?eDEzem9GWkMwcXlIYjdXSElhVEJpOWpaMXBOOG56R05Fb0xNR2lIZjFjbTk5?=
 =?utf-8?B?ZXI3blVDemo1T2tMZVEzYTNkZnhEVUhoWWJNbThLTytQMzN5bzVyUHhaMGNw?=
 =?utf-8?B?cnlheEZCQkR5TmdoN2FsS3pkV1A0TnBhMDVDU003aWJRaFBlUml0aHNWbTVP?=
 =?utf-8?B?WTh1dCtRQUNrK28wR2J5Q2FHM3F0bUY3b0h5dVp6UXVDN2NlT241MGJldzg3?=
 =?utf-8?B?ZXREQzQ2bjVReHNKSi9LdVd5QTNLSFVib05oMFhkSG9lZWF0SkFQclZvMHA5?=
 =?utf-8?B?QUd2UHVuS2RZNHhpb2w4Y1lCNkh5T0xEaXBzT25JQ0VTS1hFY1J2Yzk1L09B?=
 =?utf-8?B?NWNKYVQ2K29rTklXNVQ0Mkc0OHNtRDMyNGZESGFaOWlVM0NaV0xkZ2R3eElw?=
 =?utf-8?B?VnZJellvZmFHUllnTlc0QUdMZmRUZnRLeW9DR283b2hWamc9PQ==?=
X-Microsoft-Antispam-Message-Info: PNYA/0xC6zUzCchvhRuq7hN+FpVOTS5BOMk0mHCG25P0eQ6CntHRIEILHMoFK9hGaG7vk+VYHa2OKl7hU7utHDfMoo2y8FNBYXVJP1grakVar1B8LMGrrwiGD/KHZDL1WEqIJ2F67dD6M8/zGp3XA67WJ0+cUmv/zq68aQXhfrMxBnpuc6zDhwx/0h89D84S
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;6:pI5y4Xf3hxHagzUFmYn2XhM4CakU2f1YfCAJ+6AEEKafdSKtdvEM/wvM+EPMHq93SkphGzX2s6jdZN7nMYA4CqyIlUwZ23OGNM1O5mkJpLvBpJft6rdCuTsa3BphMHFFWPwgcfQmwJc8Rg/b8/Kj71YF/R9nWrEHAz6j2S7M6gY8qu32DajcnnMWxn9eHnLJpy5lg1yJDqwVQFLE+SOr5u6Fuw06VY6QGynZBl5SOTLcPDFTNdedgs00r2BpLh1XUQMi2ZEjRp90PuG2eZER+WltmDkykk22ls13juzaIBD+JBVV5S72Z1TneuhCc94RnaSGkdHQV9/AjLLJFmm9Dk+ZH0cboY9j8uv4+noZqdsHWD5WUd/f8O5/m890ofxbq/WX4CiKGOxJZk3vL+QZrQGvzTcFIkYm808CUr/5l2eLOV17HKcCcF6SRjyZALtuWjhZiOAV7Rnu9wYGb9raCQ==;5:18LPqr0DXkAluWtrJQOfWsgbyWlpnzlbkglqTfBBcnQyhMSYqejPMTcy9wViHBsSEkv+aKW34NKYZfHpS1ncOjFAlNlKgUGTHjlB+i5O77Q7VBtsvwvQNFCm7FQfzAdlZXTtpxni7fYPEdvcWPHXAvvU/nax7OJpx8GpR2Etbs8=;24:WKYPlQ8IEaPRoT2ytfCjvfkuRilLUzY5ipHDont2BEJbOd5EBDfeOCpnggAiidUMu1WhgMV/k8a1QzIiBT5clq6drke+/FQ6qFNXSpoQJn4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;7:idx3jAUNmWXSnCFTsgvO7RQOJq1q70i6ugpc6HCEyRENm3N00DAJAWvW1fE1jG+UAQ4/Msr3HYzTk5DNrMw/AsLWabcIC0rDw4uN5kz0OUjd/OcVlFTiuElawLOjDw63Y388cok9zdJep3udD88W/8Hvkai6DcGW+6WXkUsazZuv/ruaLugQ9FHUV9b/6GSt/VMON81Xrq2iDdvQZaFzFjJ1uEJPZf9wPULq0fraTJ1cyj21Ek7pdYXZN7dbyp6d
X-MS-Office365-Filtering-Correlation-Id: 9554471e-032f-437a-1085-08d5ac102d7a
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 07:26:20.5534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9554471e-032f-437a-1085-08d5ac102d7a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2633
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3R7QYek024941

On Thu, 26 Apr 2018 12:39:59 +0530 Bhadram Varka wrote:

> >>>>>
> >>>>> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> >>>>> index c22e8e383247..b6abe1cbc84b 100644
> >>>>> --- a/drivers/net/phy/marvell.c
> >>>>> +++ b/drivers/net/phy/marvell.c
> >>>>> @@ -115,6 +115,9 @@
> >>>>>    /* WOL Event Interrupt Enable */
> >>>>>    #define MII_88E1318S_PHY_CSIER_WOL_EIE BIT(7)
> >>>>>    +/* Copper Specific Interrupt Status Register */
> >>>>> +#define MII_88E1318S_PHY_CSISR                0x13
> >>>>> +
> >>>>>    /* LED Timer Control Register */
> >>>>>    #define MII_88E1318S_PHY_LED_TCR            0x12
> >>>>>    #define MII_88E1318S_PHY_LED_TCR_FORCE_INT BIT(15)
> >>>>> @@ -1393,6 +1396,12 @@ static int m88e1318_set_wol(struct 
> >>>>> phy_device *phydev,
> >>>>>            if (err < 0)
> >>>>>                goto error;
> >>>>>    +        /* If WOL event happened once, the LED[2] interrupt pin
> >>>>> +         * will not be cleared unless reading the CSISR register.
> >>>>> +         * So clear the WOL event first before enabling it.
> >>>>> +         */
> >>>>> +        phy_read(phydev, MII_88E1318S_PHY_CSISR);
> >>>>> +  
> >>>> Hi Jisheng
> >>>>
> >>>> The problem with this is, you could be clearing a real interrupt, link
> >>>> down/up etc. If interrupts are in use, i think the normal interrupt
> >>>> handling will clear the WOL interrupt? So can you make this read
> >>>> conditional on !phy_interrupt_is_valid()?  
> >>> So this will clear WoL interrupt bit from Copper Interrupt status 
> >>> register.
> >>>
> >>> How about clearing WoL status (Page 17, register 17) for every WOL 
> >>> event ?
> >>>  
> >> This is already properly done by setting 
> >> MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS
> >> in m88e1318_set_wol()  
> > This part of the code executes only when we enable WOL through ethtool 
> > (ethtool -s eth0 wol g)
> >
> > Lets say once WOL enabled through magic packet - HW generates WOL 
> > interrupt once magic packet received.
> > The problem that I see here is that for the next immediate magic 
> > packet I don't see WOL interrupt generated by the HW.
> > I need to explicitly clear WOL status for HW to generate WOL interrupt.  
> 
> With the below patch I see WOL event interrupt for every magic packet 
> that HW receives...
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index ed8a67d..5d3d138 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -55,6 +55,7 @@
> 
>   #define MII_M1011_IEVENT               0x13
>   #define MII_M1011_IEVENT_CLEAR         0x0000
> +#define MII_M1011_IEVENT_WOL_EVENT     BIT(7)
> 
>   #define MII_M1011_IMASK                        0x12
> - #define MII_M1011_IMASK_INIT           0x6400
> + #define MII_M1011_IMASK_INIT           0x6480
> 
> @@ -195,13 +196,40 @@ struct marvell_priv {
>          bool copper;
>   };
> 
> +static int marvell_clear_wol_status(struct phy_device *phydev)
> +{
> +       int err, temp, oldpage;
> +
> +       oldpage = phy_read(phydev, MII_MARVELL_PHY_PAGE);
> +       if (oldpage < 0)
> +               return oldpage;
> +
> +       err = phy_write(phydev, MII_MARVELL_PHY_PAGE,
> +                        MII_88E1318S_PHY_WOL_PAGE);
> +       if (err < 0)
> +               return err;
> +
> +       /*
> +        * Clear WOL status so that for next WOL event
> +        * interrupt will be generated by HW
> +        */
> +       temp = phy_read(phydev, MII_88E1318S_PHY_WOL_CTRL);
> +       temp |= MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS;
> +       err = phy_write(phydev, MII_88E1318S_PHY_WOL_CTRL, temp);

is it better to reuse __phy_write()?

> +       if (err < 0)
> +               return err;
> +
> +
> +       phy_write(phydev, MII_MARVELL_PHY_PAGE, oldpage);
> +
> +       return 0;
> +}
> +
>   static int marvell_ack_interrupt(struct phy_device *phydev)
>   {
>          int err;
> 
>          /* Clear the interrupts by reading the reg */
>          err = phy_read(phydev, MII_M1011_IEVENT);
> -
>          if (err < 0)
>                  return err;
> 
> @@ -1454,12 +1482,18 @@ static int marvell_aneg_done(struct phy_device 
> *phydev)
> 
>   static int m88e1121_did_interrupt(struct phy_device *phydev)
>   {
> -       int imask;
> +       int imask, err;
> 
>          imask = phy_read(phydev, MII_M1011_IEVENT);
> 
> -       if (imask & MII_M1011_IMASK_INIT)
> +       if (imask & MII_M1011_IMASK_INIT) {
> +               if (imask & MII_M1011_IEVENT_WOL_EVENT) {
> +                       err = marvell_clear_wol_status(phydev);
> +                       if (err < 0)
> +                               return 0;
> +               }
>                  return 1;
> +       }
> 
>          return 0;
>   }
