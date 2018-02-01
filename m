Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754996AbeBAUXO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:23:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37424 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754949AbeBAUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:22:50 -0500
Date: Thu, 1 Feb 2018 20:22:04 +0000
From: Roman Gushchin <guro@fb.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <edumazet@google.com>, <hannes@cmpxchg.org>, <tj@kernel.org>
Subject: Re: [PATCH net] net: memcontrol: charge allocated memory after
 mem_cgroup_sk_alloc()
Message-ID: <20180201202158.GA11477@castle.DHCP.thefacebook.com>
References: <20180125001911.15597-1-guro@fb.com>
 <20180125.120302.1117695034222616751.davem@davemloft.net>
 <20180131215401.GA8956@castle>
 <20180201.101655.1316424669256047119.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180201.101655.1316424669256047119.davem@davemloft.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [2620:10d:c092:200::1:e1d4]
X-ClientProxiedBy: AM5PR06CA0002.eurprd06.prod.outlook.com
 (2603:10a6:206:2::15) To SN2PR15MB1087.namprd15.prod.outlook.com
 (2603:10b6:804:22::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fb296d5-4bb0-426e-d45a-08d569b18031
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN2PR15MB1087;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;3:cCR6KGHrSW1x34kQLKhC2xpb1+re3rzl8ssukCcVxLItHrrSOhdWWNQnhkT3UAbJzCbweCv5RSFHLTGQJCvX7tAUkScGwgOwucKzBxhv2OpIgEH23JHq3S7ttYBp8kXFGHUWaq+e4nUK9l1KuwcHxF7j4/pq3IeerBtXlvvAS2jc+Y9T1YI9iJZQej3YuHxU+MbS4TqJsk8WVdIVOCD5PA/mwMmtge1ed2O5vvQCZcGQkGpCbF/rUvMY9ElDz77r;25:B5Sxrk+8u9rO3QdhNuz6/QbPEE+dKBQANmVBl7yTOlGvJtUr9S5kKAJ/8iEY8lZx0X4VDvWZbExEHW+vsYIgoDBdVuPdIfbp8SUrNCq4p55k7+5UZBlMx4d4dkh7sbeQG0OZxDgxDLV4yZJziZ3LpbjoRYD2nipxEZKB87k0DRCHLhVVQRmeqNi8RWvWoVpIDb+uerHldRLXNZxu38No53bCTY9PEOoBGgPgAMlk/0UYKrp69dGCdKpjVqM1Dv+u6qSguCox3Ti5itoRUSP8K0QxMUDaX1W3y+EGPrLFb/oJ8ROtyzA0/7vBopVaAdcSazTzvzDUd1zM+BgmF1lmYw==;31:sSQZwThd54wz5lfNpD5bteiQ+txkWUQId8Z/7tSEPB7wMK1YXyLmQLFZI2twPapN/4gBnCFkirQTYZ6HBMlJNoULkBwtISrjNraP8qGN87rExJMaRTqkuXaF3oRnkw1uvjpZxvZtXjkb7l4xjlIn5XD5Y8rR1ctvtFomy55UUkdeLv6ZJJhIGKvhBe1oFZ1r88nrmViNfR31COvMoOBM8Z/W0BPNjAZQVaHsZO+YyXs=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1087:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:cAC0NlogGrqJqLmC/Ecmhcs2FXnTiKMIAhJlaNduelasl1sRqDwdyxwlj67AMkLhBRGdB//um3qjmlsoiBp4iPEpVR5yGK5rOUn441B0rb8neptV2Ovsob8vGXJLySLxa4gVBpGfb4aPXqfjT+iFB0cRFLQy0hShh70WZo2b6LkzL+3zMIIbErvd9O0n7bbrQaOmgi+Ozi22P1nQphamUYwo6PZIEBjmmexEFk9eygbgB0Ou0NmMscLZWetDY8c5IzQ2g2h10Iw09iEqxf6G1a7EqQ0w/8hTd+Qz5vgqn1nfWy1sGkESe/tGQS6MWYbqzKOsY9pu/ugKjno/4p1LIACDRSV4uJO3aXTeIbtN4+6gKdKsHTq4cqY+8W0SFZak1kGijlfSCRBkeT/Ccx33sDbOhggj1qErdZIWslcWa64tGFrkt5c5PFDC4PIZ//8OAHS41ua4c2sjQN6cmcDG0MtU/d3FfQ3Yu4QZY71SJsdje+HhYPtX3Q31do64OePB;4:lVU2UFCI2KXmrVvY7yx1BDXoOXsCA5+PAlqedhXUYaNtlzFvwb87tFIf6VPRdQjfthDVukSvPTGEq4kJ27Z+5qzpZCGFCZ1mXbDn/RHngdAz45NUqmbhhoC8SutAYK+UPTO5GPoEat7KiYksxIIEEPKUZP09r7R5ItfQuPpGLtOxu0q7z1vQrBdMSJ7D2luO2c58oLg3q/tf7knvMJlKblXhAM/DCMj/osz9eQoHOqynF0mxu4P+e1zSVqKZQ7lts0+aUxNNnDX8OUjxNo9+c4Ob4K+CIf0VxoFnb+mwfDCRXUh0ugZuS2UZLhSymhfO
X-Microsoft-Antispam-PRVS: <SN2PR15MB10874F0EAB273E67ACFA698DBEFA0@SN2PR15MB1087.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(11241501184)(2400082)(944501161)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:SN2PR15MB1087;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1087;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(366004)(396003)(39860400002)(346002)(189003)(199004)(8936002)(47776003)(25786009)(105586002)(33656002)(6666003)(5660300001)(6506007)(93886005)(6916009)(4326008)(2906002)(52396003)(7696005)(6246003)(386003)(186003)(76176011)(478600001)(106356001)(52116002)(58126008)(16526019)(2950100002)(97736004)(68736007)(23726003)(9686003)(53936002)(81156014)(7736002)(229853002)(6116002)(8676002)(305945005)(55016002)(16586007)(316002)(81166006)(83506002)(86362001)(1076002)(50466002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1087;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1087;23:2g7aTdkpbrTF775CF/zb+5aK7pJY5t+l4zbkKQAww?=
 =?us-ascii?Q?1jcvG4kDVyYfwsozTFlfnQMLaFV0HjZ5rsvFsm+8WSt4YOg4FBGEJrjcNszm?=
 =?us-ascii?Q?SXMzzILaNr9RqxQ9a7HBjJmtvG2sg7CwygRUWY79QuIVEJfgY9c9+je/PTm+?=
 =?us-ascii?Q?MUj0ojBVxoD1YlWpW1c628b5FgYpBPggc8vc5Fk4h5q+Uh/egcYK7Q3fk8Nk?=
 =?us-ascii?Q?A+Z73aKZOP81Sl4NjET0Ws9RWHxAZFuZJimMwLX65GD4ptkwLHeXfKIoBxA7?=
 =?us-ascii?Q?PmnL3WEcs/+gCYAiAxGjaDcMK1AB7FAjbNJywZjJEL3ntogyYcLhjuApm1IQ?=
 =?us-ascii?Q?kom0wGpFHR79cM52AblR3uI8rSCPohzUL82uj0ie8qunDoYsVsAaZhUdlJK4?=
 =?us-ascii?Q?jpjRzzS1qwsVE+oM7jb/j9YahUKAyD7yRfKiXYqiWPucucZINaq1tOTixpf9?=
 =?us-ascii?Q?37ntSz1AuqOqL+Xg6921N37z2N80H2bL2m144d+VJluuT05qdctvFn+EaDL0?=
 =?us-ascii?Q?zwf5GW3mDHacIs0FXin9P65BCEv4hwXTBwbbhBVBx3+brX3O3pCRIlAgoklN?=
 =?us-ascii?Q?wW7Oh5+zQmF9cXxXvDZh14L03aLFJJC9DWS+1ILs5r+eKOGy7mJw6Hm5x/F8?=
 =?us-ascii?Q?KSrPSRigrbnWernFNlalWVgujj8876amSWrCaZP0XdiqTZzjwmAMMX6TEbx5?=
 =?us-ascii?Q?+ltySid/l8gS91KdJ991gGNd1cegai0fdWCmTULCenLipfkQcUqj1augLOtq?=
 =?us-ascii?Q?NX2K3SvZNZ2whgLTBIY33XQpLUZOk4c01D2CoYZutoyMLvvsmBXDZESdUFZG?=
 =?us-ascii?Q?BHeTJgwpSvfND1xWVh7NaVJDCc9MBBYhufvw5qRkmFzXyJs+jEzGQY24p4et?=
 =?us-ascii?Q?xejrqxPg8ubHNJV6bF+ll0skE0h+de0axhLLMwO1pgr4/UPhApV2yKWrD+Be?=
 =?us-ascii?Q?1IpbYSXSMqGnheplXmQu3vjgd83siarHO5KQDD2mFnH8TBEHQJmSK2XNlJvv?=
 =?us-ascii?Q?OfJ5kzEqR5tuCuMpI/x+a6YEGJk8ThvIL2CJgdmPvikMNLgY0i7GQ5TvhfJI?=
 =?us-ascii?Q?vC9e1WTnqtmaxe3V5P7RFb1suRcsVNdd/DMiPQqjZoZJ++rFHNyDOWG3H/lN?=
 =?us-ascii?Q?edm4VPcAxaDnc1Pul+U5pTkF7n46DW/LkIQ7RkukjKccgc0RVTDW2J0eke9H?=
 =?us-ascii?Q?tZbwrXnXOTR1wy/vj0adp8h7zj4y48XjMGUHtNnOKJKNlVjyo6mFIDaSA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;6:/BgR/odOFaNR5E8ULRS9uK6xagaepts/PO5ONYXg1L62k6uczfKpgxH711wjfokLvJxGPPXqCijldYzy2UfQJCMuO30eeiMmXUrCNF2Rlta4ItfTNDIoUUfD82zx5WInXyKIY5FyB6dh/9PywaZVzrai8S8Lvth4cyQka7HWtfwLdSQqx04lfgaXoOzmDVBSluXbxJGd5SQlK3+XxtjJHkPFF6mzeGAIpYbbZG3pe909B7/5nZ9iBdXQJetZSij1JDzQAvKQ+JukR1u6ZaivqZ63l0bTHe4HqLDxXaroH+gNfHagrZvoXHJl9T3J5CYweves3zXHDH8+KTO9CyF20NdfEx51waf5jwsZUlU9+5k=;5:Jya5rMSW+KNZKQwJ9tTM0o7ioXE2xcf0dMI6Guq2tf0aqaEzoBHfe5eufIm2VVPzQV5WWKpt56bnJpjVPmHryZ+tmdVOibacwSNLynvCXjMdIxZlB//ELvB9oTG9QI156fGRnoo0XMjmmOpGRyQEJXUDX5gq+wMvLu638YYwimc=;24:h+2PczfW9y4XzMz43nv5Xwm1JracK3NcjOXUY4wJcX1QNwdFcJBufcuR4zJUxL2PMGAo4IsY5gAdU/gsbN4+ImFosNL6hFL/wkjTSqZcVrE=;7:fhVd81F4K8ZuXTpLEUYCX13OJGk+t3v4pV+dtSsPBd3kAI3kfvoVCu8wdLp1LuUjMxrgVPFIipFQeBPQnBnXsMJf7BuTjeQRHpRP4D+XDI58QuABv9k+8ghu4CGXOAdhJHPyBMRshAorQnQbuoFqoBJ/UYZ8vGfWvp3wap2/hAXRdm+Yr5iFtjAzFaqjK9jAroAZ5DwFJkQC3T1lXVY5Q810p3ZxfLeNosxsueX/EVSdsFW3MMbMe6qFYKYqvEaB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:O4N4GxQfXCr6GlpVitLR3lGiPSaeAgk8kSUS8JlkDQAbXY8oVa8Ngw+HlEpVmFNQsJGk+8axs/L/gWJWTFRb/UWkgwrvhkQGOeHYk7pJqzPaUaHKNyeUe12p0evGp6mpo4DP7ele2IZzPT+9omp78ycuxbs0NP38c+Q1BHhxcpo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 20:22:15.9762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb296d5-4bb0-426e-d45a-08d569b18031
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1087
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 10:16:55AM -0500, David Miller wrote:
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 31 Jan 2018 21:54:08 +0000
> 
> > So I really start thinking that reverting 9f1c2674b328
> > ("net: memcontrol: defer call to mem_cgroup_sk_alloc()")
> > and fixing the original issue differently might be easier
> > and a proper way to go. Does it makes sense?
> 
> You'll need to work that out with Eric Dumazet who added the
> change in question which you think we should revert.

Eric,

can you, please, provide some details about the use-after-free problem
that you've fixed with commit 9f1c2674b328 ("net: memcontrol: defer call
to mem_cgroup_sk_alloc()" ? Do you know how to reproduce it?

Deferring mem_cgroup_sk_alloc() breaks socket memory accounting
and makes it much more fragile in general. So, I wonder, if there are
solutions for the use-after-free problem.

Thank you!

Roman
