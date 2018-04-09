Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeDIJnK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:43:10 -0400
Received: from mail-bn3nam01on0053.outbound.protection.outlook.com ([104.47.33.53]:14778
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752812AbeDIJnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:43:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Mon, 9 Apr 2018 02:42:59 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: David Miller <davem@davemloft.net>
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com, robin.murphy@arm.com,
        hch@infradead.org, gustavo@embeddedor.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH v4] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180409094259.GA21694@localhost.localdomain>
References: <20180406140443.15181-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180408.124200.2204489876311923873.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408.124200.2204489876311923873.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY4PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:910:4f::39) To DM5PR07MB3003.namprd07.prod.outlook.com
 (2603:10b6:3:e3::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de84f983-feb1-4285-bd87-08d59dfe49ba
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3003;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3003;3:8cbIvcR2H0CmozwFFl/woilV40LA4AjiHC6Js/P6mTlvg+F5IEVwz0SWkYjgWIKGsOaS0amUIaz7hHUhFZd1FKbzk2pDwWHIccYPy8MHLW1xKJ/tb0BbkIelPiirDlF7aKHptoj/cnBKqcJ7khQRvNDRU6EkO488XsnSEzkcz0gjBtEcWS+qP5MOx19af7vhjte5VCCNmXnz6pn6b3PaU/mrb3STyY1dwy4qjFbowS/Bcm78bhx6KalYZ7s+tpgE;25:biZ0Q5gvXl7nI1dmeqlGVrW75TD+WlK7nT40gbctYMbbQauMiytkIWtpEFYksTnBYKOe9soqY0s7Jg/Uiu1KR/WqMUSuhgJZzZviGkIzP4PJ0Sm940PBPxJi+J9lFfZyz3N88F1GuwAik8TWRvYPKSJwXwfCXHiAyeXdwrCKg/HhRUNHB6b/tv7+Z5L4DQ/ukob3SPzftvxsSY8XCE95z+44XFmIs9rIPZO/sroK29ZkQqAjO3j4wHooFQxGVBxm25rGGH4zSRlkQOlzt5BfTnnsew8L5fFW/Dz6e99ibNK1HfJ+8pe4PcO+0uEnbrN2gduF/BQsXXPv5iwZx5kMYQ==;31:G8jnpnEmnsOYz14skfgFYr2I1c6MT31TsF+pW9qrhRBzWByl5bplN2clShL2nHsDV0sbKgWNuey1obwlykTCLwkgr1cqJQ13ZsbWmgnx0EIAnz8hZcVVGx6/mMs1bdJ4Zr1Q39k+CuT0yqBTa2yB9CeZn9VQhSo3fqs4gsiAAPEUxCREVBPbuRq9w4Iwrbxliriln8oJ1zIBhwNKiaLmz0/Ct0EVIINPvhzkxLcXrDc=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3003:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3003;20:1wBafOzJ1rCg9+JtasBPCHgNKnCsV000jTnyyPL3Bgci76wNZbsHH1mmAXCs+qKOroYb7pphbw2y3gc+iOaEYaGPlC3xsdnwKssibLzuU3oXg5CeYoHXtLffWMsDsCtIgYjD1WrrfyNgKpxek+ofSj4p5qCknL95JIK6XL8B9disYVOqyNGHBCV4XGqN8RATEiT7Uqdm7E03zs+v7G0Edz03vXx0l1CiXGb9zFUcRZY1zFLJ/aOk62I1qeZttyj9AqSs4XY3f3OBE9wzyHQto2Z6YG13XGAPsShsjY5x0EUzAFmRrDN52INtvwOfsCQJgLBi+xWWuTG6r98uLWWKzlf/R8GRZumCZQq88egwlxR8WbYP42N/r10lhm+aGWSKJfppnncujULGDE4ggHeCZgWxtf5Wu0Ws7Td5tKMX5S2B36eb+hy6B3p1GGDGWoJhZSQvqFn/Iau8dAlx4e5xjliB0OHA6kvjTzJ0G0REi15FDtxKT8rH/RkOSOU0P68f7SoP4EuFwMMQBMxwlUPCF+P9MdFqajQ1rHybDIs3IixRsfgRcPI8Mi0VeBFaT/WIizvQA8YSYoAQVnS2Fx2dRJ8Y+AAdN8o5Ammjrh72ChE=
X-Microsoft-Antispam-PRVS: <DM5PR07MB30039C2A46F64322484FD3A18ABF0@DM5PR07MB3003.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(277106579953875)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR07MB3003;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3003;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3003;4:C8D7aAOqq5obsIXhJTJt4OmiRoZtAaQV4QrbK/MY2HhQ77XcrzVTzcJ35K6f2S4A/vJNeWqRBt2Rv2ywycRmp0Do6Tf6l09PjfhK1rko3GPODF3641yUtmAsa9Pv0p9QISamDlo1jFVDt+e7Yf9GTguy9qS+/OQqLwrK4YO3HLqosVHqRtapmjcXwkaHo5/Arl5HQWKvGno1O6005kTTl2HsjzRYhqhRNEQSUNu9AHef2vew3YyeKeI3UY0FrTpKqgdrHkjflG3lZ+OA8Gd+ESlv1cxHosZHDzpijn8aoJCfAGsHKNgvMJelNq3qR+tna4yzWUUhUX41yiQ/fX1dnjyIS0vEDlexdWIq/D2EXno=
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(366004)(346002)(396003)(39850400004)(376002)(189003)(199004)(486006)(16526019)(50466002)(107886003)(42882007)(186003)(16586007)(316002)(9686003)(97736004)(55016002)(68736007)(6246003)(6116002)(58126008)(7416002)(72206003)(5660300001)(106356001)(6666003)(229853002)(6916009)(26005)(33656002)(3846002)(39060400002)(2906002)(11346002)(7696005)(52116002)(1076002)(476003)(25786009)(76176011)(61506002)(53936002)(105586002)(23726003)(386003)(8936002)(6506007)(446003)(4326008)(305945005)(7736002)(81156014)(81166006)(956004)(47776003)(8676002)(478600001)(33896004)(66066001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3003;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3003;23:nixP/03eLHUO++weFPXk8TAibB4AQ+Ea6NoiJN9M7?=
 =?us-ascii?Q?yGziw6bKSLMWvXSO/WexBSE4pkbryhn+ZKbvIDgHiKjBrRLr7NC4W6TOew6r?=
 =?us-ascii?Q?xXJc3lOdoLn2he1DqZrFjejtKlJ3YeBEQCLEko6jOuZS1uDZamaIqKSdvL0M?=
 =?us-ascii?Q?ITbFai0w4+dr4UkmiQSEnZ4Pjr3R9dBjq3ykNQU71t28yg6NwATZEAKFWHJH?=
 =?us-ascii?Q?Eh3HXYBFTRNz94r3jtzlfWEXJldPrCsyDsL8cZUF8NwsrIVvkAycSXNILXuD?=
 =?us-ascii?Q?1fncA2PVgAqZeRTcRwTxgeVAGm0OCcJd/TCaF2XFTN4wFiSHhKwY5+ceOJLB?=
 =?us-ascii?Q?pvonjyNztWlBN7BcYPA3U6UJQbmOi6lRAWphf3Yu5a0zlYL4SWKts5uHON87?=
 =?us-ascii?Q?yy39x6L9EWggRUxEVLQf/QiuU88W2mNMO1ZArpg7rgKtMwFn0Tp5iudjZ27k?=
 =?us-ascii?Q?QYzNfm9Z3F75mJ6u1WQhIwE8+fR7kJSNKxokqAkAGDEjoubqMFqU9EQDySn8?=
 =?us-ascii?Q?fwxzcn1tDBeD+8M95GUMxfzDpkqlr4080snv0F3LS5dAQAOQRodvqGp0UNIL?=
 =?us-ascii?Q?SmdCKiC/1OU0p8XgmqhwCJCdFJ+hH/CgBpkJ4Isx2F19JuVLbrY2LqKTs/my?=
 =?us-ascii?Q?lkpPB17JH2qDzazv2PhHdV3lQbiM7UJ5Rqpc3Jd70AB0+u5SLzMI91750OVk?=
 =?us-ascii?Q?NAit8GPVsHhTkGGhr/8mTBOBwco0eM+2jZXRTLRN2qqd8RZJaeL2NReww5Hr?=
 =?us-ascii?Q?izmI7dmJzVsosvHrXFXgtPohUIz8JdHT+kYuPxWCIKjFVWR7CTPmPtH5LqXG?=
 =?us-ascii?Q?f+E3gXJFxPrbw/U4LQv23W61X00W3D1wPGTZjUgq9HdDzFWSKmbZ0qe/ZHGf?=
 =?us-ascii?Q?OVb9eJwsx66xnWSs6ZGWMSKq6F4+xirtvOHMbFMBNuy9CWPCz9tPJMh5Xm1X?=
 =?us-ascii?Q?po5QfqTVvSc+n/4q7e1O8r0h6TZcA7fpvhb4GFV/IYDybRyYYK70xjCim1me?=
 =?us-ascii?Q?j/eiCDGr8eNzJaiWNfvxf3rDgSN0xx3pJ5Xam5B+vq9kMEnPB5XE6sVSgH35?=
 =?us-ascii?Q?rwk+7xzj3+7bMvDimqlVEaTDsSRsuBDSDVRyVO9gX0wUfb6cygG/tV+jwKs8?=
 =?us-ascii?Q?+2wYritRnQkugtIy/gqnlVRTXC/LtQE879WbjMnyOgFqvBsACv90h5C5n2/j?=
 =?us-ascii?Q?65V0HJsQyp1vo/fHiDF6dvipTD3dREvN+uVGTbMMvyhNJqkMQcuLaosApag5?=
 =?us-ascii?Q?uRTIvhNYIQnsPrSLQANjOCf3FXYk2hRkvNw4lj53GtsEsrCk6DR6+Pu4KKrO?=
 =?us-ascii?Q?AVaPuzwxIopj5NRQ1L509QiaHFgmRUAesy98hXTeizxWdmw73Yixp3Y3MLd6?=
 =?us-ascii?Q?DEKlCgXFhpGe9Rnb/ZPkxVSFHnY0WyR1b2zK9DFKcpius1e?=
X-Microsoft-Antispam-Message-Info: hfYmssPbZjeq5oqtAmPnuUkSENGZl7VAABwx395ON8+VsOSXbFqcR1YgGJRj0e3ANJ2nWdzWWVVfxv0je4KYZwVg0aCejgZzVYxCENLRbTourQbU1YM9ezrZaUxY26fVW7es86rvv2vYxyet4eDloX3ItjegO4n6Zh10lChZd/fuGxiDPvm4bHgk8i8pWtqW
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3003;6:k4lhfAaS1zgZJsvOVjM9ZZ9Am61cIawnpZeXM0ieD8ePIozmAWxZTDCBicAHe+ZKi/6s5TI5lC1uZ/5NRgf7WMROFZSeCKNczVmmynvUNC7cPmrj/gj4r968L5sn67rHN5uXAza8H61dM+s0v6fN7NF2B3D9Q29T2aj+GFP9glcuykMOiXxBUaGuBchNbE1JKqdHVZxX4N5C/qg6qlP+Yc2FgCnI0suRMYN58BlTbs3+1OZJtJP8YtGuX5pzx9ude3XoA+4e7bwEYgAnyptr7DhXi0q6ey1U1hHli0qjooQKdD4aOoUt98cIqvXTgvlCXLvsx8kWiBC4JZDDlKptULluBWxKKWXAVsXsTft5Q2uSucjlBxNDjFduKyC2NL05EEimQduRrgMb6c5AJ01KXQZJ6wB9eGYJg5cF7ayQcXoSAjNwxFD11ofedpuLFIDXWws1lM6Bnseg9wKJ4E09nw==;5:KT06K7QcPF3Aedxp++T9L3ll+GGAud2IyY186gNN+X+mIMxqiuq3gGlUnwh2kpEzTerte4T8sYWySbScVCJWXE/JaytPrmFWkOIkBuE7zbpDdGo5Gyr0mjxf9KVfD+tsvn31Gi/7AcJxnDvo5cuI7oiJBJah22VqjqXncOKC6j4=;24:/q5lrwxPcRbuwd7/miXCwlccSVCinSOwWksvLuHmI7vUaDNTNsTtpBWA7f4TUPeLutK/2iYUE3HF24Bv9CDwvOHNZIOzpHDmQJT3E+whKYs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3003;7:24VRVZ85BeMyLQ9M+DZXeUfrGm5CvNlVWiEl5t0Wmo6/CW4KAfAFVq5qlc5/fudq5pjmbAmoUfGEk9qRFaha9p8L9FbHu4VLncu5nVAVFRbsAZcWdRFqsF2K05bi1LQuFA6vIM4wTwPHTeOY7JruDJRA1OWDSUnsWp1C+lZMnZRXE4E8cAGmtnVZAXomZsBGCJzl/B1M+faeePAv5LlrwWrvp2J8mOuNllX6CYwe/21EM2hXbbH7m+EIVAZMzxSF
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 09:43:02.0286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de84f983-feb1-4285-bd87-08d59dfe49ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3003
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 12:42:00PM -0400, David Miller wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Date: Fri,  6 Apr 2018 12:53:54 -0700
> 
> > @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >  						  work.work);
> >  	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
> >  	union nic_mbx mbx = {};
> > -	struct xcast_addr *xaddr, *next;
> > +	int idx = 0;
> 
> No need to initialize idx.
> 
> > +		for (idx = 0; idx < vf_work->mc->count; idx++) {
> 
> As it is always explicitly initialized at, and only used inside of,
> this loop.

Ok, will post next version shortly.
Thanks for your time.

Vadim
