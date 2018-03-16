Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeCPCFt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:05:49 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:22931
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751791AbeCPCFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:05:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Thu, 15 Mar 2018 20:05:28 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>, Leon Romanovsky <leonro@mellanox.com>
Subject: Re: linux-next: manual merge of the net-next tree with the
 rdma-fixes tree
Message-ID: <20180316020528.GA27212@mellanox.com>
References: <20180316115610.3d7f232a@canb.auug.org.au>
 <1521163082.18703.191.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521163082.18703.191.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:301:5f::27) To VI1PR0501MB2862.eurprd05.prod.outlook.com
 (2603:10a6:800:9b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56d87732-6940-448d-367e-08d58ae26c7f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2862;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2862;3:gHL4IsiupT6iqojHMdHvVyrH9Iv8+eN/h//rOYOp6UzFvl4aVxZD11wLruxRZCo+OGX/hR/xHckswVh6HEejEI1nsOgPgtkwx9hX3crv9t4PgXRspAEsd4wLxRk5KTa4/8UMnAnd6pLlrIDIff6joaXWPXEEZ4sVNZwGEsxBGqqnS9REF8bjf60ob+oXvu4v/bJ1KDuiDlyMfxKvsBvaavx6UnIJwC7NCxbL9sC5Sqw0NTYsuA6+mAPT5jR21f2G;25:XZgKdbfKr8/uANwYPGsB/hjsVl8myoaMrbP005SpKNJUfDNO6z2w5uu7SKnjBYWrIYkwVR0sFMsxE6WEpDXHAT8npuMbBc9diGjM+T4z3Az5ar3U8PsiRlqRzNrBtPzR0X63fwuILc0VIAu/kCTVin/tbw+MJFRvYjKlha+36UDC7Nqe436lxgJ9Yz6QXUvr46hdWTZMXF2/paeboqimNZO6mMzrJ1MHpGZGSAGZ8wkKWFx/IGksJfXu7u8ootfPdkim0oRA83bZjoWkK6jZxJJteRn4xoq8jDXq0yrp6dAVZIpJpO92+aqkovWUk2TsQN4gu83D91meKsE6msA2yQ==;31:/0xrnWBbgRqpl7KfRWUE0bB/QE2TUlhOFDXHO7PVkNSRTD67IJHPDyW8B+uK4ALNoK3jmwTOyiVYQf99C0Rgd9+V1n3img/gYXHL16wDdzgsZjC9DIyY+TTwDu3ciVwde9eKg+H86awOs7NkwRL6GWcqy+Evc/XEGRM18E4eRnliSfcG81/qDcMkF2bkJd93e+E+Dyb3KrzrVyBJyOU6aC1Wk6gMHxy/ppMsXJ0tGDA=
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2862:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2862;20:sR3Q4lUjZKN3Cca2pY6oM9Mn9pb2ge6JQatDBH0po5l+J6miAr2F/x+bU0B1bI4QE5J8wHp3Q2l5u6CC3UW7z6KDpVBhy5D0/29sSN5gDGBy2rS/HQWuOtMA1KwVTNHs6DOZakWHkmnQpw9Oe7psfVYBfv4Z0L5PvdCW1aGZ2+5UIgpS4ot+XQLoXr1oU18tobL4sKBDtBjyOiqQhQVYypuOPZgHbXyOUmGfoZ0UgMqEksE5ZJkl25TzOwjoZtQO/sVNgMKthTiPfHV2BJnlsWKLFlbKd4CaQoZygUeiYmK6cBbVmkOFNdwBDwQoG3c3/UDgcs/tU7WaVgQWHSWzBtooUPoAAkApN+Hb7nfTtkPOocMncyvDox3UlcnGw6jmIky5iRcD5EUlLjKmHrTm7eLgkovYG53e+WTF2k0WTnVEm6Vi5AGuWDwG4ikM3aqMwDBJ/0zYfL78IP8AGQkb06q1v6re+tQjytkM7ziVvIGS0VeToUO2FWmNISjhPCpa;4:7yJjUaqQ8p25t3vwlNGS/xVzicmOs5P/m4eOpaS1gBc6U2d61AEwXWa5IOpenrquuVg/hILKXFVNtldPULNLewZH63t753+s7y7BFGRDcAHkrVFgMuOV2YLP+l+4G5yjDWjJlw5Vo0hB+k3uBL+LK8BBx0nY7qp3CiDXbv70INc9e9q5U8WpI27VAMJM2o/MpsJTxOWy4M+S2lromQI4JbrFdmkZRLQrxHAM/kKSzKRbAlZHpBaO8XWTXzaLbszX/VPu/uEujNoqe6RJyLNhdg==
X-Microsoft-Antispam-PRVS: <VI1PR0501MB28621E4298E0F7580AB4A381CFD70@VI1PR0501MB2862.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0501MB2862;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2862;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39380400002)(346002)(39860400002)(199004)(189003)(106356001)(229853002)(59450400001)(26005)(50466002)(76176011)(52116002)(478600001)(69596002)(53936002)(97736004)(6246003)(107886003)(68736007)(16586007)(36756003)(58126008)(3846002)(6116002)(122856001)(305945005)(7736002)(46656002)(386003)(66066001)(9746002)(86362001)(8936002)(8676002)(2906002)(105586002)(316002)(47776003)(9786002)(81156014)(81166006)(1076002)(54906003)(4326008)(5660300001)(186003)(6916009)(83796002)(33656002)(23726003)(2950100002)(57986006)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2862;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0501MB2862;23:qsqIOY2ENvEcL77ZXh3XEgdi5ZMxcvZ0c96qYR1?=
 =?us-ascii?Q?Yfz5hFndIKSCtp3uupnuJVUfAfm1CvfkNM/avrB9cOuCm4Nw+mdNVA/kpUnn?=
 =?us-ascii?Q?glWwz6H/j60L/AwGHrPFymH4LVT7r2+PB5W3NntibMaTM9B42OTo0V/Jv73K?=
 =?us-ascii?Q?DCcJFkEECnmVivkBfTYX8P7mUliC+c8QiDeiKxZhek3Wymawom32hWI4gxv/?=
 =?us-ascii?Q?JoryYqXBV4dcf869xtb4RPtxPSpv/QwUQkjARbjrlALXUnQCmUBD2qGR5JVr?=
 =?us-ascii?Q?rkRnsisO3jAogKW2vJdeE0mngZI71fPqtZ60N5O9260ZWYRpWNo915lLLxf8?=
 =?us-ascii?Q?asjmEBjQ4fzMaP+e7rBeHheCiSq1HFOUfR2H02fd08wcjmYieOy/XDroyth6?=
 =?us-ascii?Q?brze2+VWI/2RTidlbey4LJGllcuRPh+AOg4KVH89ePm743q67rFaBkDaveBO?=
 =?us-ascii?Q?5lMBLEZmnZmTlo92ENOVZT8+P39JmtgokmWJfSY1V/cAVRx7buVCNcWEbUOd?=
 =?us-ascii?Q?TnXycmC+9iGtBjyD65z1wrUSSYM3x5sPHMaSAZZxN3vR0cbFt7p8xOl9Ml9y?=
 =?us-ascii?Q?6BF8GP+YmYD2QkTZ9jPD7HG578aN1EDyI/qB2j8HQiDC6LZXdvXIltw2qtGu?=
 =?us-ascii?Q?c83kR+NSEHnMGDGlgetOF8neWUAhreLSj8as4QG1amS3IZGELWTv3GOKBHWM?=
 =?us-ascii?Q?5yaA1atlgUdoP9E6ju0/6kP/BxkL2ESm6HluUsNncD1RbiyACFwLTHJZbnL8?=
 =?us-ascii?Q?/Qp+qAFxaA0dbJgbruq6M14Haub2Li+4WR9BWVJrZZu3R/S94jOtO6kPzWma?=
 =?us-ascii?Q?LX9/YG8pDQ/rom55EseKzL1aoqX4GVwa5GiFTsfX+erg0YatEL9gGY2B6ksL?=
 =?us-ascii?Q?1JefUu+fZ98cr5I/vK5MHOG7Ib42c2zi7GzltK9mYybPmrBCWnGpp0zVnXjy?=
 =?us-ascii?Q?YiBgjwPkyBEVkJSaYWj1vudC1Vb+dwU528xAQLDHBYhYdP29XYgAS6ZASu1n?=
 =?us-ascii?Q?nDir86zYoJz+zaAGEVTheC56Dn0LPAKFCyWQQZwSRr9vni/Rry44Tma3SEyA?=
 =?us-ascii?Q?xE6k63WrUOzjAZFsLOW87HjJg6UWMXIO6+3BFSlYAHYS8l1LF6nwzArQy+dw?=
 =?us-ascii?Q?tNNFGXcj5+HBtzTaXfnkmB+w0byneD7TI5b/I67+ArJmKqBJBM/3Pnz6i4H2?=
 =?us-ascii?Q?VEHC+c+3YxhB3lownNa51kyoRbwR7yuV509do66HvejuoeT4XijNmnoTMHJY?=
 =?us-ascii?Q?yJB+ZaFPrl+5IA4kII3AeQCT77ZWd/jTPHRR1LzKd+k/F3fQhPsAhTI/gEdR?=
 =?us-ascii?Q?1lGt0T4lDxBAE1XrKDfy9CnlNtwbbmMhBMPdo/C4+czxQ?=
X-Microsoft-Antispam-Message-Info: 1tTBGV41OKcncOl1oreZgNQzopQzbyzHIRceocSILc5sUI7ndFiQy0TPvcsxmz92GhJmBAAG07CAm0MBBT+DrSX7E0lBi6yGjgXxmbkO6hHT9LzZ/r5btCJGoRd+Mo37m0miAz9rNQDNDD/8KttwiDxYDXUTOHIrskA5Tq5We5+Kl++0u7vXkEowSecUmRou
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2862;6:KB7YocommZhR30vMBO6qC87bfvo2+9WCZGo/zRS09q2vfMrQzY5DLTEccYlIubqWwWkNvMt51aSG9UogH6PxwQQab/M+VT173bKN0U03LdtcNAgQJMu//MbWXG1c5jRIzzO9CmCNqTegrYMSc9j3VilY6gWGR8H+QZbAajo+iRccn39uA/rtSqT7SsKdkGOgm0Vgq615ckH32nTR+Nx19cCvABrh3JtzXipn0JchEH4RBKEnL7bYW/ckRxWp1ayL/o57lis0mQPdJKsYFTKboyPzJMhyFhsGqyYM3Vpo3uvhrq6Ui5FZPbshTGxEtPoXEFjEV4cMnJrPdem0kiZ1fjKuu74r4qy5B4/uSyUncoM=;5:eHcop3SQIvGUYttJIxKEYlYm8PnpMUDkFglwug+D6M91jtbQ7cKBQ0/BjXQ1nS9cq47ulJ9D7VJnohw4XJ5Z2ObyCL7fktHvilA/l+A/cUuxo+Yavq+y4mVBnBtW7tCB2dUNaIe30FaLBDeoaO9GXBe16rK6M2/Sc7DHGr9Mo8s=;24:k6zU7dNh7o4YwMK/xn7tFEkewSNxo10359PYiK82sa/Akt3lV9zDoaIAL+aF7LHq9s0//ZYMudV6QNutZFTjibwXy00elPJ47UbaU1y6I4I=;7:f74ObIJspuCP5fndE/E7XnfO3wXZ9ydcGRTLX+I7Tlg3dBPx9ugvlQmdq4XhJA7GWURmERDTc3ynkLqC5dNypz1b8LQIGqzgwqSauF5lY3r54r0YLAOkSkAFf2Ippmz7yT/SviElPIwNswkHjQcjdjZ18Smh4LAFgMbWnUub3EL4sRv6zHeWXDOl31n/fIN7qrs/ouY5bQPwFldCUc1yFoHXbrqTb5H6AhT0TqrSWwFtsXaOVXU0q2QSjTAs3wrU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 02:05:42.8280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d87732-6940-448d-367e-08d58ae26c7f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2862
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 09:18:02PM -0400, Doug Ledford wrote:
 
> Here's the commit (from the rdma git repo) with the proper merge fix
> (although it also has other minor merge stuff that needs to be ignored):
> 
> 2d873449a202 (Merge branch 'k.o/wip/dl-for-rc' into k.o/wip/dl-for-next)

Stephen,

If you merge the branches in the order:
  rdma for-next, rdma for-rc, then net-next
you should not see a merge conflict as rdma for-next already has the
correct resolution.

Jason
