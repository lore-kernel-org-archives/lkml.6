Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960C6C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1689E20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="I5GG56mC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1689E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeG1JZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 05:25:02 -0400
Received: from mail-ve1eur01on0062.outbound.protection.outlook.com ([104.47.1.62]:58426
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbeG1JZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 05:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nswW7bD3qGYEiWZ0EbTsnrzXtbq1azQ0usVXMi6eg3U=;
 b=I5GG56mCJxE4tZ0Vw84J3yvqhBHdRifHygwWEe7aL6rDXmQ2ffEhvVO3h6WQ5hF0B7Aw890S3fQjT06jaJtmEMRGivTMQT/VSYn/5ykB+/yAkTBBdm03r4JlsxbxKE+LJFZeSR3tmTR16hUVx6Wh02tOIUYy5TnGM3L8LK1pI6k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from localhost (213.57.183.250) by
 HE1PR0501MB2699.eurprd05.prod.outlook.com (2603:10a6:3:cd::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Sat, 28 Jul 2018 07:59:21 +0000
Date:   Sat, 28 Jul 2018 10:59:13 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "Ofer Levi(SW)" <oferle@mellanox.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: arch/arc/ allmodconfig
Message-ID: <20180728075913.GA7157@mtr-leonro.mtl.com>
References: <e074d0ae-6d79-d21a-2278-15d516bb943e@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075012B0724EB@US01WEMBX2.internal.synopsys.com>
 <AM0PR05MB42600653CF591791731CCCD8DA510@AM0PR05MB4260.eurprd05.prod.outlook.com>
 <DB6PR05MB4597A63819F227B17652B5B2B2560@DB6PR05MB4597.eurprd05.prod.outlook.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B07F319@us01wembx1.internal.synopsys.com>
 <20180723165110.GR3189@mtr-leonro.mtl.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B08679D@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B08679D@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [213.57.183.250]
X-ClientProxiedBy: HE1PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::20) To HE1PR0501MB2699.eurprd05.prod.outlook.com
 (2603:10a6:3:cd::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4330dcbf-bcd5-4909-877c-08d5f4600726
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0501MB2699;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2699;3:R3q4VFx5eZ0GYICPUzvRRy3mzNPPEgWgQ7wGAVBsoZItfPVjPTZ4qJs3Kc9E3KCmDFg4OjUOmrPISsCynIfTpRaTtxAP0eUwTzpysgimRq9zont5TeO7WXMz+2ampHxvgvTTJxhP7lEteNpB2zyvi/T7udgNlneT/qwD7IZemhlhmnj3BHTvPMY9zqWEz6KCZ0NTOVzDP7efcPs5cbkvTCyoSvw87GVdIBTr8AVYvIvcFdQd5mwBCBM/FDYGqA/Q;25:reb26/o/2ml9CDwwnKeqVNIUkVQdV1UnrVZGYJWuHyiBxwlRLSHp2qyziAwssvNm53He7GsOr5qGohI1R1l/DUtZ52zASDrpOH7KPKSJYqoQhRPOE+sRSrUkvuadhYvAdn6wZM79W0x9ALuWrNXEUCkVwuB5iOHuXMmz6ENC39a/fttmJpAl/i+Xw/CNinVld1pKHvxNvC/SVurw9hT8M4dDi/Dgjtrc0soPmSPr0BC7Irj6Mp1RZasKGZ/ZBl1/7eGCe0ydYqeW4NQgq7bhnFqYuqCvygS5mZcy3bBSlatuEtfSUcCSJ6ogsGBxlVZQ/SPqpdEqI3LWlY5hyrANIw==;31:QAbH+efCzJJziAZHnkEN1iPTXwk/PBVxoPkICb3vtbt8ZPpxwE8M/SXOKaZFr8XK+eRxl2sp38ln+K6NYlyU/fRDOgtZ6k1VSqg6KN+TMnWNme83UqlUrHliEi57L+YnY2BUIUsEr2OsArncAXwZmbGRUGeg/KNn0k5X3TiHAQ38YJlV5AG68TAFzbrEEz8bI5b+2+nmHkN1jLXRKPxrDrIEaOeaI97NdfXPYo70xFg=
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2699:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2699;20:p8Y/Am+knNcWWUmlQwoQJbWtNChwYxJtVTFKyJ1SRo8Nxl89KXHu/GlCz/UQFTEtL3kSuT2yb7UDHyuhC45+MMhvf6opv2PPU/0OXtr6KarByKzsqRx0FKfAxK74qwUhcva9tXcoYgXf/hAlBqq9+7kPao0eBVkYn/r4Z9i0HEfM9UDnlFHcILK56X4YkzRBJUx+JFRtmGVYP0AGsqJI7dpcFHg1nBLVQ03lg+/2owr04YD5Y8LE+GDXRwuwvptmoUVT6nLXOiuPiVbI7vVmwfeQBAPr8KQD+O+PKDhS/ISbfOzalMfW7rhVfPADBS8PIM69ApW12AW/RocAvZRCsLzUJKp40Wvq6+eH4x/kcpXDLrJeiae5xPdhXn4xnYA/ilSXENy0jSfQK+zKVC5HHdm8JKs2SBgvbOMKB07S3WNFs60lSRR2LgO35ffgs0vJ3iWbAHzwzmQ7v6gTtchcODcswKUmDTflTNurHnlqqpO6+cUS2AazSa6ii3zax0ic;4:6xFL4Sz6Z0Z11Qz+Kv0ji5BzgX5zM85tNjpIFfL2tp9AUOyDqpD0xzXeBEbFaUbfo+k0LGVYp5UtEgtNlULayYq6RyRUFv7eZYl3z7Ff2E+U0puXp+YGGc1qz+Oib3F6QrfrKbZL6NhZwAglqsCgIIHKbaeZ9tmqq9czOhdvFSLCDTYlj7jiil8tvtnh7zuzLTdNSILp0RdFXaAB5OimmlzMTegC95OhRPDzRZlZfyHG3xoSe/4c1ORhXMOI7gSk/tu+bmHBmaP2Gv8Yu4dmSMUTsWLEEuISuS0tkQqTrSrxgP1Y8IFyksv3DvrrgC0f0AOkTEMkK2snns0jH/IcL6Tb9dY5lS4m5pWkvaKJlkM=
X-Microsoft-Antispam-PRVS: <HE1PR0501MB26999AEEFF46FBD3E486D4F1B0290@HE1PR0501MB2699.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335)(278021516957215);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0501MB2699;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2699;
X-Forefront-PRVS: 07473990A5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(39860400002)(136003)(346002)(376002)(396003)(54534003)(199004)(189003)(486006)(86362001)(47776003)(6496006)(5660300001)(966005)(956004)(33896004)(6486002)(478600001)(1076002)(11346002)(476003)(9686003)(6666003)(8936002)(53936002)(446003)(76506005)(6306002)(25786009)(4326008)(6916009)(6246003)(68736007)(54906003)(93886005)(16526019)(105586002)(66066001)(386003)(186003)(106356001)(26005)(53546011)(229853002)(81156014)(7736002)(50466002)(8676002)(16586007)(52116002)(81166006)(33656002)(2906002)(316002)(6116002)(58126008)(305945005)(76176011)(97736004)(23726003)(3846002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0501MB2699;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0501MB2699;23:YsdOght1k3TUw1h3UIBkYDfwUxKv8ewvmhnn/cA?=
 =?us-ascii?Q?aEkzhYB0Wm/FGkcdJpAclLprnUjzDn1lr81I0YyqKizn6IzjHgFdBhNoOjcZ?=
 =?us-ascii?Q?bIPp6xhrqIBBf7qqfv71myh7+fP3bK2dt8hygrabUxLogE1WHSqnIidSmCHR?=
 =?us-ascii?Q?+Wmy7MIXDvaAzohqbGrpLnvqg+FRN1mGpkSYOBfwj4NmpTWxGzAO9ZkWMVQC?=
 =?us-ascii?Q?akAL1nige9VFbkKEY/QZ1o9FSZZ3PTxeydlL8So7M802pFqCUXL5JRfe60Ms?=
 =?us-ascii?Q?39SYM0zi3DSZcDJCwgCxF9ISe/31Wvvdel2A3I/TE0pGj+RIAACfyPqZPKLx?=
 =?us-ascii?Q?YvXuPsanVDob1+7zOZtzy5t6WQatsCF5MK0QjWLpVmWUq14wywDBpSFL+1WW?=
 =?us-ascii?Q?KhaHaSLlhoI0BsdEy92bj3mfTFi9cxiEqGc+VbXZ/r8PwoDY1Un0bYXM+Nl/?=
 =?us-ascii?Q?2iiGRzSrApJ/PL5rph0rDhzS+K9erKu14vMmi38bOmVtaMV7zaDYDP3hpaCe?=
 =?us-ascii?Q?9JP/b0+n1l/Qwot2t6F+cWWjQNC0UFsSdqQbPaxEqyjR1XLocXDMhpMxQkpW?=
 =?us-ascii?Q?3kuuOFVm+HrhCn/RJkfoG33S0mg/5D3VKibRCQUagZ7QyYZOdOGLe8GEvSH0?=
 =?us-ascii?Q?PbTAY2cQ2SHo0IBqUCehiPQb8FCD3XWlCzt+PqNkBrG1WOd/JUwEHF2pN4/+?=
 =?us-ascii?Q?/Y+jypE8gFa6opwyO0VK62bCcc+gTawwLto19+Y4AAufFFbuZJp7oyyJ/6+p?=
 =?us-ascii?Q?l7j6ePJlq/b++gxfzeHb/y9S6UZIlWGJoqw8zA+l1HXW1NcZBOWh9n5CusT4?=
 =?us-ascii?Q?75IhWPzjtz9DK/gbrA0y/x1Xs5lGoVi3fI7IPWH57T4oyAH0ICHPNllzx7Yj?=
 =?us-ascii?Q?ntvBUn8s9TMOFl5qIuxi8s0xFKVjKNG96H6hv2upeayapaIPOzqQSVOrgujw?=
 =?us-ascii?Q?HlM4QKcB6JqDc3kiL4E+QHOLnXb+sMoKnzHMw1SrVJYkIiG2qIszXN7nlLib?=
 =?us-ascii?Q?g/WsrnqTO/WeQl7xfFNTIVyZ3oJihFLpFpkqJKZKqffkhEbzCZfvEVHeaAhP?=
 =?us-ascii?Q?PcSL+Yhz/oQv5pIMP+6YK46NApcL598T0VZ2FxHl6q4Dm0kOIrkiWqJ6HRzu?=
 =?us-ascii?Q?w/ps2Mc0pCsrqTbDMOn5dbCieoGXhw64gyMJ+HC/jOTghlCXDkwcpPv1Uteu?=
 =?us-ascii?Q?6UEk2zmRY49nFb3m1VmOQ75McHNo8hkJ3cQakKez/r76igEQfh4mA5Vjf2Rx?=
 =?us-ascii?Q?lkNGbi4wWaWbTnHS0P+/QMaa5PXIoYB+YyWVkF0Rtg167hmsK6kw4KHlDDr3?=
 =?us-ascii?Q?1T3JNSzXAy3xyKnqGN6S8e7AcUKcyBY3KjfpgEeJn6mRlFEFajL83ASJdpMR?=
 =?us-ascii?Q?LUg2FvotBqQDPfJ7D7pYOU8ZghNQBOy1/ZEp3w0oS987gKnPM?=
X-Microsoft-Antispam-Message-Info: HTAtB2s78dRB2bhg1oRqyTFjDfrsXYaV+UJoPZtkkQHAlwXt1VQrJroXKjkXPWirQSXU4t4iKFKZnkBGX7u4ddK2Vw3/gL1uEV5M3smV5Km5I7YJzyfA30peBpAOnXmJgNqQZwxaFPW0Np0qBTMyqPZVKlf2fKhf6SncHG8wW8I0Eo9fut4UwbT8VvwMvm3Vy0Xg6M7/aMGMSlds7F8RlRy4Ini9zn25AlDXTaddbFr2Aia2y72liUCLVWJ+a4Y5Pb1Gq6/RofTh1HGA1FDa9GIVFzEtr49faePb/x1GAg/n2piXRrxVP9Ke4B9T5m3JMTUuEMYuujzLEu59XUYaguQuo7h5NjF5iy4yV5HrRls=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2699;6:pIWgWqYol0Sk6d7fna1Pg5/3oN4YWE2p0yILMZqoKErDFGFXBLr1YQNhArtvxoHWMHOkW+hwmIqtMt4JYAWAkj2Uhosq2MT7dck1OuWyJorrwRzzr5Cp4p62eJgBgsrZtbXkxvDaq5NVCSLkyDu9b8SfvTqC7dPyOhD5H82SC34WubVwjEJiXK8m7zd//phbZ9M3YdaMmVtwgIHdRDwiUh4yKkTnilY3tocgjPC8GYtQlm4XYXmNggO6Q74MPx2jQxEQDW+BDBdcONjaYtUeiN90DDTE8G1iPCMTbddJoauGP6nd6qAjrU96GtvewgW/DqPaht9CWupNuKrEZuwZukIRQNU4PbDHCCONnnSoKRz79595upmqSha+28ndV+07DHwKa6ipBn8y2ejF418rxkhPsxiy+6bTIyq54brdN27BCSpWZBN9/48djCOKzJQkx0QJPvN3MZHNV8b39ahNEA==;5:tDx7Z7qavL/iqhifmjIk6OhH8qdYsctjZjI2kj29ctfTfYSqlkKGIGa5FFh7hM7CktXmA6jF5Ef0Z2RqSbVP4WKXe8VYryZqsx++mHlTrSMv33/UiyxSGotC8DxfoO7H4dWO+T+PKQTdPvLD1gAYHGpoXNB7Ae70uavYdezvhJk=;7:IFHDcI3cqjP606qPEWYx1W5n/aPTiwSY/5aJUuBnlcwS9EKaxH1q19rlEP5ZkO59dpYmjLJc/QAVFBp1dCc7DeaCSqm3hTckZWPQ4aRUzUvYFH4m7yC48iU3I0hUpvkvkJ7NlEPO+akzmACrED6bSoFQB0Hj+ynHh02ICYa6uZuQyLLVzo++xriIdlgHtKSfsC+51+6IgHIAAKgW85ypb95wHPAAcLVqQacxkBItY8zBx8ffUPLI5LRqvEYQOz/y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2018 07:59:21.1952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4330dcbf-bcd5-4909-877c-08d5f4600726
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2699
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 08:14:31PM +0000, Vineet Gupta wrote:
> On 07/23/2018 10:02 AM, Leon Romanovsky wrote:
> >>> diff -uprN linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h linux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h
> >>> --- linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h    2018-07-22 16:16:09.000000000 +0300
> >>> +++ linux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h        2018-07-23 11:18:12.179402620 +0300
> >>> @@ -143,6 +143,15 @@ struct nps_host_reg_gim_p_int_dst {
> >>>  };
> >>>
> >>>  /* AUX registers definition */
> >>> +struct nps_host_reg_aux_dpc {
> >>> +       union {
> >>> +               struct {
> >>> +                       u32 ien:1, men:1, hen:1, reserved:29;
> >>> +               };
> >>> +               u32 value;
> >>> +       };
> >>> +};
> >>> +
> >>>  struct nps_host_reg_aux_udmc {
> >>>         union {
> >>>                 struct {
> >> Thx for this change. Can you please send a proper patch with changelog, citing the
> >> issue as Reported-by etc.
> >> Also if Mellanox is interested in maintaining the NPS port going fwd, someone (you
> >> ?) should add their name to MAINTAINERS file under arch/arc/plat-eznps and send
> >> that patch as well.
> > Hi Vineet,
> >
> > Thanks for your feedback, I'll work with Ofer to make it happen.
>
> Ping, folks can one of you please send a formal patch for this ?

Vineet,

We sent the fix almost at the same day, but for some reason, the emails
from Ofer didn't arrive to ML.

I resent it,
https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03899.html
https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03864.html

And we will check with IT the reason why Ofer's email didn't work.

Thanks

>
> -Vineet
