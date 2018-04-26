Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbeDZH4v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:56:51 -0400
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com ([104.47.41.54]:7392
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754281AbeDZH4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:56:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Thu, 26 Apr 2018 15:56:19 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Bhadram Varka <vbhadram@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jingju Hou <Jingju.Hou@synaptics.com>
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180426155619.2c5d87d1@xhacker.debian>
In-Reply-To: <be2addb5-b3fd-13cb-ad33-f0527931a0d2@nvidia.com>
References: <20180419160232.519d15be@xhacker.debian>
        <20180419121801.GC17888@lunn.ch>
        <4273f766-a017-b336-7d14-a28901d274b9@nvidia.com>
        <20180426141508.6660a633@xhacker.debian>
        <be2addb5-b3fd-13cb-ad33-f0527931a0d2@nvidia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0016.jpnprd01.prod.outlook.com (2603:1096:404::28)
 To CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2632;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;3:OCtFo9gm+3CtazODWfNKfNxNgdA39+TBsPRk/ItIJlu2q+Inm+KcTxO5/dSSx6ZE+iqQFXIwJlXQ+iols0tb7PVMoU6X1gbG8gS+y5mwz/ndxzeZjSewcNuTdjjPJcd+5UBhMXBslJ7dVZuJTaYvtVVC1QVaLxKcWmuH7HzPMY4ju4AZdV815rYqK4pHeQep2+enXyUKClvAG+Kl0gIbttXT3j6EIqiJo3jxq2IH+6NpyA+XjvRbvL3+vMxE0BWF;25:0HYLb1oOoP253IdpNTh5VdO5FXCvASFBIhLDl+kd22jzWERIKLsqh5eNjCZn3qC1UOjNqWoJxNtlkyZYgVGBaWtTfXPdzVW/3AC9zxH60E6h3KpcGDemzzrS6w5if6jgqofWQmEahGbirBf7be2fz8QPpnfq7iIMI+5AmWjA/VS+i2NbolfjN2ICaiCy902MeAomy35z55pro97xxvEfxm1UWhp8dJwTpH5ojHZlOAp9khOofCKyFRxa69NpMXlZOzF0FtafEyhkxwajro3T8Y7BTAQk6qaExJJbvKYXVuWr73CH/jVm3ldcnLF7u0eZELL3W7mRHNZUIN0bqWo2sw==;31:bJrrQf61uJaUF7Papd5A7Xzknh/RxUXf8olpP6ne8CUbpbk5l0+PMO6sZeB6aX7Hl1yapSujVxpLcd2g0Pq4tG8kRBFBsMS6Zpt+aYCBKIwmLu2XkxiAcEbyEWDWwAnSxxhg5iVOMbw526HTr1AipzNZdNAgpHhJOjag7wDOTbda7SFO2euudtSYkE7kr85soLcXoFtdqwKcVYwgtRBjU2IHDebhvM34XzwuHexoVy8=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2632:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;20:QmDUFrWfBk2WTYwpBwcYNUU0+r2f65brBVSYXzSnoSrGC9kHMBfKC3E974vo5eYHk0PKD/9HobjEbI+oBnCg3dlquCmVYI7pScxpjrfxq/obQexPTHCN1LrWA7DR7tiEI0vkIdEUpYJm+JgmfpUsG/tV4CFfPVfNFHgI83atMmY5rdEdOgT7mXFo769MTn5X4YHE/5qxbpUx6UrSu7M3vUwLQEzcRJeNjxFib8oQz5Gby9mOA9Mk8D3jiuHvk4+XnOEbIeYl20me+PO6LXlvOu3INJQN4MF2SFPYVtkyjDzzbCcNBztMXGAAKQg66zEJKdzrUo3RjF4rHr5507yhEBNErS/IwEPhlStO//uk3A7hc8XVApSDfbNLCb/abM/msarBM0Gy7nVeYP+ONIMewh6ubb07HJBx9Z8+lDqSOkQ2mNMxIf7FQWDakGA+3GHReMPD0m1t2RDzELbbzNV9g+ImoJ4+FcymEXa9YweM8inMeLISJwAD7npXJPVZj6fL;4:xxi+Xuv0oMf03nBUCUe674jgB2vovIxRY/X5Y65Qh0eBG10RNKyG70FBBemzwfBtmxMfX4bjY40SZcCge//O9jgGU890jttVq2frnl+ldbupH5GAyHleElQ7/urBrAHA+WNa8bVhSPiD/9t22vSeEc54w12ZIG0T+sTwJlPh5ORmSZ52HCPmKbayVVo6sbUClD6qXP7HDZAD+BeSbYZ/G1ei7zVk2Buvr3hzU3LHWbAMZ0ORzLnDVuC1H0YjFaEaqGNax8bGJ0hqW+Mia4vLzA==
X-Microsoft-Antispam-PRVS: <CY4PR03MB263268A54AC6386CB0F18E54ED8E0@CY4PR03MB2632.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR03MB2632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2632;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(9686003)(8936002)(66066001)(4326008)(2906002)(47776003)(53936002)(76176011)(72206003)(305945005)(50226002)(107886003)(39060400002)(93886005)(81156014)(478600001)(316002)(6916009)(81166006)(55016002)(6246003)(54906003)(105586002)(106356001)(186003)(8676002)(230700001)(25786009)(97736004)(50466002)(6666003)(53546011)(6506007)(26005)(68736007)(5660300001)(33896004)(476003)(52116002)(7696005)(486006)(3846002)(386003)(1076002)(229853002)(7736002)(23726003)(6116002)(11346002)(446003)(956004)(16526019)(86362001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2632;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2632;23:zvtYi38N5GrX0LsvtYsHE+jlQ2W9N5FzULO3JSD2H?=
 =?us-ascii?Q?p+H85stK1Kd+ATnLcgJgqkWt//R+KwzywOXCeoIAK/VtkDFZImIwzG+ZZJvh?=
 =?us-ascii?Q?FiJo8r8mB4c+eVWn1YaCN0dOJ7O9lSPFRmPu+BWw3EAH8DFfSbgUgG2Tp/Hc?=
 =?us-ascii?Q?KSxsfsEhEPd45NIjvMfcXl8QcyE/U2hK717AtWevq3zH3ESg6yH9nR4rFOoe?=
 =?us-ascii?Q?dFMes2AieYRhcDoOLg+QTyhCumtmlK2kU11FCT8aF9+krHYvXr9MkS8xO09c?=
 =?us-ascii?Q?F62oquNOw6FxkWVcAQ8kgZ8rTa/oBSQr+KyG5s+A+I3x0uPZh5HoYKn1zQBu?=
 =?us-ascii?Q?g6rmPp1JQqCsW5DtN1ck0kItvp4IRUJpwFeA0BJBar9T/TShB9ENoXCOoQg+?=
 =?us-ascii?Q?yP5lyM6MB0fZs8MndZN4KkXU04OqDkanoZ08V+Na93LBjoAeNTWrH/hTaMss?=
 =?us-ascii?Q?fJwjHxrPrVB+EKOWHSm74W0enFDxeE3dGE0iteyNJeARIDa2T8NxqvG+GLME?=
 =?us-ascii?Q?dQcU0typxiY6lALnqM5Ysd3V/BQX2ywAoWdkY3KXSw6JFAi2+KDF9RPSiVKX?=
 =?us-ascii?Q?l4XbybmlPJCq1y9qfxVA+415E1SC3VdzvXZ1/I0nhLaE9fVmMMFV0doUwkvs?=
 =?us-ascii?Q?M1547VuZ9J/r4pvvUnW76UgCS5MXDcy9xe6CwIqCXbc7csczboXaSBxVtPGp?=
 =?us-ascii?Q?SOPxz/VvgjDL59Xz3dr02LRU4JbWnYY06X/pSWll51dXPRxk+DVpEbnpVVCq?=
 =?us-ascii?Q?DHaliYrlkhkjds4TAA3sd7+RwE8TspvflqTNBvySo+6QoToxeRy0aUkW8Z/l?=
 =?us-ascii?Q?jffYfys/AARjRmCaxCxVNmsRi5DevmKWbJTK59T5F05PhOCBiCXSWEpEozY+?=
 =?us-ascii?Q?4ezlcHftm8kAxWTnOeEPBuS4ma42A0uPdLDnAIXqea42z3W2AhVKMR16eN3r?=
 =?us-ascii?Q?35q73mhFNyCQx4p2/bJroikhZVQ3OoO6B2pGO7KTB6YJ4pA5UZr69t3aU/YK?=
 =?us-ascii?Q?mKAETFr8a3Ieg6XPMnWOTxNtMsVhlyjIdB96KFbXa9q6NWRsH+q8sEf3Ekcm?=
 =?us-ascii?Q?1Ku9kpD2nFqOMfxNvCEmrRtGliUhkSIGVbZf4USKw3BdYji4g/7BRsyfwol7?=
 =?us-ascii?Q?nWbAOl0+E91NgRt/qdcF2hGAm1HwoA0wWD4qwbA3Xomqcme4kDnAPb3rTV9Q?=
 =?us-ascii?Q?+Q4s8NbY3JP6R/VnlkJeZdFAegz5AIY9X/+Wpel7qiQMBwBnpOGFo6SCkCcZ?=
 =?us-ascii?Q?QVnLAO3yUnTZysf/mfF048/e2F2djDNDyZxnkimk5/xV4sV3rWR7Y4F8i9rg?=
 =?us-ascii?Q?uRhikVx+psh/ENiNlO/rzswStseOTDczFUm2cTJNXLhH/SqoUsiqm90UL+29?=
 =?us-ascii?Q?gRKMvl5ki0Ukpm/em+oZJrFq48=3D?=
X-Microsoft-Antispam-Message-Info: hYwGhYm2kQ62Pz2EbzOdCXHjVYcQUQ/wCI9sfgc/Qzy1WgDgwA1OE8IPjPukt0yS+1ZwRcPkr6Zpp5+H9k8IlmCppj0IOxBztfL06ZkveW7FAFvXx9oNBvhMbHrGhmwg6bx6W2316MsAxj1Rw1WZt+zqDM9VbTKs7bJ079qrzpaEKeAXDwbLaPxEqOzoSf1a
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;6:NcA0jiciLMXFR0fERBXEyMHPlBvlLSodYlMcqFCE0DQUnnWsiTXt3RR/vZVm3j3QzgsA2Ku9CUJ7pYYNjmgDB/Ri/3O2ZpgYcGAzRn4AJD9DXxGvoK3oQ1rjXNUuRIYBuYb4gLLoh8EcsurQ50Vbm5JtnvegMSnI5l3CQanWtSz/KqujGcvxfrLZrBQKogtMGRTAL10K+Nmid/sIqo0RnOZgoDePilRMu9Mcdu41hxUYuYfwwogUG/P/R5IQt5cBpq3fAC4dsny/UuUNyxM1+uBYiC2f72slCyXRwrhnGUGbLec5+ihecPLXli4loEr26ZJbK6kysuLf318XNnd7MHk8SGGifmj+8A9M+vQY4me50wr4OHX/kna81lSS0YWC0bK9sO/lz9KST863qrtw+dP/zW/e47EJBiQ+wGwHTn6gtyp7uCbnK8uvqwYtW4sk26vuLUgygU2QSjLoeUgFdw==;5:oHegjMdCdBPoIaN3DNwjH7GBmU3wa5+gver5ErggysnUL/FPj1jVKAuZyRIvz3jmS40csjqBcm/WkbBuQQpwGPm3DyxyXNpew4T/GLmeRmaoyTBSJ3DAzczgscTengwSKRvgc+wh14izilU5baAPoewVk7PF2XHOSUD2dbkcJ+c=;24:hfU6kSR5ElO4vs0IXndHWW64XDSxeCvkeR2viBKnqp9r8cfWWYzaUjtwJpHBBXlCqfciBdlo+vT4WM2n2UbfG+2rRTd3jjtcvAmR2ww1aI4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;7:ej41VS7RpTzgPeVMbYJxw69WHI+ftruQYLcmfRLvSCL2Itkjq9FUFSm5KtsWFPbnztDbNjNHxVxA4SK+p1XSW8ugTPj7hvM/nP8xnhl4eFtFfX8ec9aojGY49SNB9CjwcCjoZmr3Sgund8Lq1Q1DXH3tnAvu0vyzVuNmD1J2UNp78Dn7DDu40n7VZJsw4OyRl1mZFCY5o8U3uSJa33HNMZta3dPtkGIcUQ7wMFIGIQiviHkRR3T1g7eRudulO46t
X-MS-Office365-Filtering-Correlation-Id: 36f6e0c7-12f8-4a7c-ae71-08d5ab4b4111
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 07:56:42.6930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f6e0c7-12f8-4a7c-ae71-08d5ab4b4111
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2632
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Apr 2018 11:56:33 +0530 Bhadram Varka wrote:

> Hi,
> On 4/26/2018 11:45 AM, Jisheng Zhang wrote:
> > Hi,
> >
> > On Thu, 26 Apr 2018 11:10:21 +0530 Bhadram Varka wrote:
> >  
> >> Hi,
> >>
> >> On 4/19/2018 5:48 PM, Andrew Lunn wrote:  
> >>> On Thu, Apr 19, 2018 at 04:02:32PM +0800, Jisheng Zhang wrote:  

<snip>

> >>>>    		if (err < 0)
> >>>>    			goto error;
> >>>>    
> >>>> +		/* If WOL event happened once, the LED[2] interrupt pin
> >>>> +		 * will not be cleared unless reading the CSISR register.
> >>>> +		 * So clear the WOL event first before enabling it.
> >>>> +		 */
> >>>> +		phy_read(phydev, MII_88E1318S_PHY_CSISR);
> >>>> +  
> >>> Hi Jisheng
> >>>
> >>> The problem with this is, you could be clearing a real interrupt, link
> >>> down/up etc. If interrupts are in use, i think the normal interrupt
> >>> handling will clear the WOL interrupt? So can you make this read
> >>> conditional on !phy_interrupt_is_valid()?  
> >> So this will clear WoL interrupt bit from Copper Interrupt status register.
> >>
> >> How about clearing WoL status (Page 17, register 17) for every WOL event ?
> >>  
> > This is already properly done by setting MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS
> > in m88e1318_set_wol()  
> This part of the code executes only when we enable WOL through ethtool 
> (ethtool -s eth0 wol g)
> 
> Lets say once WOL enabled through magic packet - HW generates WOL 
> interrupt once magic packet received.
> The problem that I see here is that for the next immediate magic packet 
> I don't see WOL interrupt generated by the HW.

hmm, so you want a "stick" WOL feature, I dunno whether Linux kernel
requires WOL should be "stick".
