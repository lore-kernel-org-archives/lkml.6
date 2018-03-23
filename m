Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeCWEdd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 00:33:33 -0400
Received: from mail-ve1eur01on0063.outbound.protection.outlook.com ([104.47.1.63]:52272
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751175AbeCWEda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 00:33:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Thu, 22 Mar 2018 22:33:15 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: David Miller <davem@davemloft.net>
Cc: dledford@redhat.com, sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        markb@mellanox.com, leonro@mellanox.com
Subject: Re: linux-next: manual merge of the net-next tree with the
 rdma-fixes tree
Message-ID: <20180323043315.GB13185@mellanox.com>
References: <20180316115610.3d7f232a@canb.auug.org.au>
 <1521163082.18703.191.camel@redhat.com>
 <20180323.001900.849305099701511845.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323.001900.849305099701511845.davem@davemloft.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YQXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::40) To AM6PR05MB4453.eurprd05.prod.outlook.com
 (2603:10a6:209:43::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82293915-9fae-45d7-4005-08d5907738bf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4453;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;3:XP2Qg4IwDPZFiF/VtlOOoNyiXcJytvWGq4Vtu9lERfuxxDQ6vjNa8rfSM9MXKIWOChcfWbSPvv+5HR104OA0ZDiPBsETbqSk+QNDkC3c4xXl4VuWcj1W9vg5SkqmJ9GH2wXlYSXFbLWsMJnWfu7P1smKiJvR16Y8McUQuL05OphzwEo9w75WZBnNLfJKDvvIA2Hr4A37AMOlb8AB86u5M0t/A/AAngPxumMzfizltiMfPE550CU+MqCnZwUa4a4Q;25:KE9blSmkPXclDiMhf0LgjRu0wvqIN8V30U7mPi4Z5Uwx2ouH283UDWqm/7TslQq0GA2EMgZUaw52poVJIQO8XjzDbWoMzzdAJggXdIGE5+GQUPOGIYRsXUD6Ou1/i2NwBJ4Q2qhGQF5pDZW+sGN9A+0drQgUSfRpRyAu+f2cB6bc9WfQtWc74PI5Jcb9SFyZ0EPcTEy7UCXLkSoJhY9dn5eteF9OYsNXQqZyiCYzpNAkp17z23AMnscxCDAPyyd5JpRR5H7ngh2qj6AsXBa5yDWsoLTbcra0mmdg52vCJlInNrsmq2S21vHLxL40jJiIReSGtHaOyPcj3hOCdr04PA==;31:KubHv0+D9IOonRWhcGuu6FfD/nzt7lizfQCRFjdIJ7RgSY4wy/y6Lj7zI9DKQHpOtJN6/RuqMmFYxSxyeMV0ODkeWBnQcNro491FoiYB0wwSNvblxduiNtaBmnKNp5H80SfTo7JKVMWwXggzCvpp0OwYpO7YmOjO+JeV3vEoVQX85mKbgMeXoYMWYmyLc9gaxEEBgZ8kWBfjgFrYn70OfwbRcLROk4jrgBuDUOA+FUY=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4453:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;20:EWBCYH99g25L9ORugY7+ZOa5kMM2Y9D7yik0RrLQnxMalOOn8MRE0pY6YgFPXBN4xLWBAL4+oBETuyyxS0MWCjtlYIPODohKYkw+Akmqw/uj7xiGTHH1Shk5jCLqMqxm/F0rV2HKxiSGJp/ya25MXfHlVEfjXWDN8FQ2rXB4MdW9mp/aXEBb3WSKOv2UX052/GGMdCAHqUmK8481cWcwm15gigBlO2S2PTpZHiXN1VATRkiMlmp6tlZ70OAHmVrA0VIOw3OXB55IcKFEZ7hr3WQN3Ud1K6GZ8IuwUgfdG8Hf6cbOocNqCZa7X4DBLd0XlFrc15qoDuUtWled6ryhX07dV+dARW+B8wsaCYHr2o3lv0wcdelg/MfK26ZJxGDKeWHXb2NtBFDAUsOjLG0vOk8oJ3Dk7DfSsbMps+CUPjLlsoR044MO/3BJgv+cLPJf8Jhd8Ea7lNJzkX/IsC/zOeH+fU8vecZEJMhKT3u95xG7HuoZAT5uNijKoJrzF0ld;4:dx2gnro40/gzlrxBc3afwZBALG7+bZ8kUqz3WdTnM95owvBn6zkchwtEFmRMC8437MaTNV1QR4BrZbKReHLfsYdYb2g6/rcw4G/JBTgpl/YHhhcm1cIOe8gbn7RkgWS1rdMHQujWcpI6y4+A0JmBW4LHwyo6JjiWmtGw3wMirzZ6nb1hnKJi5Tlae3MaJ0z9mnnk5AHHKH41IgZNE9Nf1SVdO50OscghGOZPcSTrT88EgPQaxzwe7u0mbPCMCiidlYsa2ovuu+dJ5lh//xPOeBFqOfYCwEFkeT6mRcET9HkVMetsPojgFJbVCSHiarGhY6Utajvk5EkFsIhkJjrX8KaXvCfzCoX1mb+SLKVqEUs=
X-Microsoft-Antispam-PRVS: <AM6PR05MB44535F2CEE56A5F4056142CCCFA80@AM6PR05MB4453.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR05MB4453;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4453;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(199004)(189003)(47776003)(478600001)(58126008)(16586007)(33656002)(57986006)(186003)(305945005)(4326008)(106356001)(83796002)(26005)(229853002)(122856001)(8676002)(105586002)(6246003)(69596002)(11346002)(81166006)(52116002)(966005)(316002)(81156014)(76176011)(6306002)(53936002)(50466002)(9746002)(9786002)(97736004)(107886003)(36756003)(5660300001)(46656002)(3846002)(23726003)(66066001)(2906002)(8936002)(1076002)(7736002)(6916009)(86362001)(6116002)(386003)(446003)(68736007)(575784001)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4453;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4453;23:Ee5P4UOI52BwJA++c80qv/Q82z3f1thBp2FQZQtnh?=
 =?us-ascii?Q?DWrL1x7RJeNwxlcUv6yn612/OIGYK1wZR+rctdGN8arU22YmMRwPZgf9IOdK?=
 =?us-ascii?Q?WcR60PWbEvLceZhEAP0/Zh7loHGzmMyVgmeIvs7bvzl2iRAaayi0fXHQ5xgy?=
 =?us-ascii?Q?s20Pr205tbqJh1bvvsarmhDi3/xm/DaN0d2c25Z97M9yDLH+YXi0i1JpNwcd?=
 =?us-ascii?Q?l8mtqzBX76uOKba7fu69uCbyO3OkHXQneQ7hr4FYeVn7tQA7ao9/BhLuBJJ8?=
 =?us-ascii?Q?cS7QbvfnvKglhv/Xd4sP1xc7SOQd7IyZwH0tWu5U8RBdZHOzEgP19oSg8vjb?=
 =?us-ascii?Q?fGdY2YcwcezlvYIA919JterjsttoHShPwF1mEfXNO4NkU+5m911VoPfiiQkm?=
 =?us-ascii?Q?7wq+mBq4euomeew2hNGA0FAQJ7LTZHaH6uC/6aBmJO34pl6mwNmJN15H2Fmc?=
 =?us-ascii?Q?xHkY37ajuT5Gjn400NDB8CvuTDfCfRZyGYW5iPIhXzkQRc2h3r+IBkal/AuE?=
 =?us-ascii?Q?Gh50hlUuX32IyR1IRAZ7F+D9WP4NsBGuiNMZID7FpEmPi+BA2AdwC6BrUL0F?=
 =?us-ascii?Q?10GRXMJP51HdmREgoSkU9WlqTEKaP+KhDhC7wy1N5lkRzAPDC11bAMBrPvb7?=
 =?us-ascii?Q?n7BbBJKIYKPjwvPsJsip6zeTdFLZ2Z/8FvZ2vUkKwErY/cX4kWzNqDG5dXAG?=
 =?us-ascii?Q?0g1wvZ7RTAlzW8iKY6EkzmNqoZPqVzqByIrJAfPxElsqr3HfrYtzYEp9K1AT?=
 =?us-ascii?Q?k9ZvHVGsZPmPCZ71xp9Iv2C90hVdSR2JWvLDrlrsCMVg6qhLETrP/sydjKqC?=
 =?us-ascii?Q?tKqDB3JKxn4F6qzO348QXtgL2ldrV+4TD+kD7tJlUxQBkSHxHlYWJ4K3OcLc?=
 =?us-ascii?Q?9/6B2nhDEDHStkF1kyy8AdcxCVe1QqinodwL03GPlwkC03+hoaIGkDMURTk/?=
 =?us-ascii?Q?EZgPbCNHBorz7VDx/VXWcPY54V0c9uw3UmPg+aJlnb1ugTOtD6hULCRB6JDz?=
 =?us-ascii?Q?LqK4SN6QXsDD52hQea++r/bgYTWKzf9ukWAjKyXje9y1ytmWoAUpx465I+fK?=
 =?us-ascii?Q?GvJMZi67kNLRTZRLiZJoEctX0ViZLJGpzmsy1l5AH2ZxIgD9gIjFtAlgXKiE?=
 =?us-ascii?Q?+5eBeZ6/dp62Uwo9CsHZRzbYzrj4NV6d80P11OfKgyAtlZoXI+Wbv7VILeH/?=
 =?us-ascii?Q?yayt/1ADvF/JpjgGPWWPm3oRHTKqqvPfd3nFx6VSX6aj8bWL5E/r7gcFR+rB?=
 =?us-ascii?Q?SoMO2ws26/7R8Rq8/CVCdwEZbWS9oPJIikct0BOs96M8FpQ3kqVtv0RHbzPn?=
 =?us-ascii?Q?B6tqO/tHduySyy+gRU0B7eXaYwNJhaWoK8bnVWwnYbjWVO5ib7fMsYz19mds?=
 =?us-ascii?Q?7iqEw=3D=3D?=
X-Microsoft-Antispam-Message-Info: PCkvWetaf6IS0vw/8CH/iHeivsFUcmROgItxlEtEF/6uPL1wnEu1oo8gvo1H8cHZT2f8L7y2YiOIRMJMwQVDoE6PzfUb0lX3H3nZS8MvchFaXJmykCDLYO1AIFS6cXB3L1bPsVZag/lU9xonuSCLb7CwOl6Gxjkss4P3EyrsHuHlkmgWvDqowTf1M0K41FTv
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;6:yhljncmAN7kom/jtKe14m7gz5fOCa89FSr0WQugqdsUUE/DSXKe7lCB733MjjxMnmk22HMUzcdUAMQuB2+QRE595dEqQwzPedpZMY0jfH4a7YzSATL3f9L3taK3rrd0Lh+IXrXpFdUL6uetYj+1Zaf6+SMt8K2aKCNndq48tKxLLmRS7VifjPexBsRcQvH3gqmzE2ykdqYMn01rU367gx9oNBfxsS1+DuTa0QfsXMbZJsGxVZaGuvKYfMsXyaQ66pynyuFTfF6duLVXRjx/fRgsynFSmAJ/A5zk8cknPA2WOforSf8zvd+PnFOhAD7AGB4DXp+94vhlsdKrpz05+XED4ZToPF61D/QR9YIwkdt+evfkcvt7GozcezStF1s2kr/Hi6OrjGXnO3PjykEV0iiP8H6UQDOlajZhum1k7wxwoT06ox4INoPOlK1dg1o5CRwaTQQga5LFTtJJ3V2WMQQ==;5:T/sRwG3TAG/FmIsBdH2bSiXDGrJKYa+m+T6Z3m2Yp6nuT+sV2qOThYR5yZU93v2Uv+KTrddvx3HVvJgO83VhWHgVRjOWF4sT6LbGt9DNGAmen4IO9/ijdKimRraG5GySJPw4PAvwLUZVQbT2EHJeE8nGllE/ViViuKlLwYDwS5Y=;24:bwliWVUdPru8CxzAQA1vSQYWbLh5hMFMrURmBXFsuPGnot+7psbXtY8lC0Cp00k1YeDf+rTL4HLRWR+lf3/MN3eFPs4fcDKClVhI3JyvHhM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4453;7:ES5nQfqfFXBPvFnfxPOCIQyFlUb/sJOja+8yWG98WYv9cEiX/XYFfscMXRfyV0/Cz1MEXwqG2bh+i1PESxQxosoy6FOJK58sRXj/LKnmimuhpsk4GxcQDBWQx7BOvCVdXv1GRecOOlgV43GxWHOdc+IS6vt2ahSigESgkd+/LGK6UnqXOfliqRHFZZye40SvuRyYCMeC5ogpHFRK/weWcoYOmNlZ+l3wIXnpOLWvwV8L2g4CkTXxXZxJOTYw86Xl
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 04:33:26.8484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82293915-9fae-45d7-4005-08d5907738bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4453
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 12:19:00AM -0400, David Miller wrote:
> From: Doug Ledford <dledford@redhat.com>
> Date: Thu, 15 Mar 2018 21:18:02 -0400
> 
> > Here's the commit (from the rdma git repo) with the proper merge fix
> > (although it also has other minor merge stuff that needs to be ignored):
> > 
> > 2d873449a202 (Merge branch 'k.o/wip/dl-for-rc' into k.o/wip/dl-for-next)
> 
> Really?
> 
> [davem@localhost GIT]$ git clone --reference linux/.git git://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma.git
> Cloning into 'rdma'...

Doug and I moved to a shared repo location when we started maintain it
as a team:

git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git

The commit is here:

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-next&id=2d873449a202d02e0c4d90009fb2beb7013ac575

Jason
