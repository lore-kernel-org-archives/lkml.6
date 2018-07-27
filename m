Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52E5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4870F208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="q8D9Mjgn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XTSCjBmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4870F208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbeG0SgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:36:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730771AbeG0SgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:36:03 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w6RH7Z7W002993;
        Fri, 27 Jul 2018 10:12:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=QD3rg/gXqJ+Zc9g5z3V2WA2XigUW15BwGQCfYKKl0zs=;
 b=q8D9MjgnH00fIfR5UjMwazFXDNOYXO2THWacMQ2UTHKsIYKCK9JcWr0JtCvao8y7jBxA
 NkHokCGgJYx5cXhi1VWvDsJCR8PnnXBKCxy54SycVf3qTb5buKYXc8nl2TRR7Ff+NQPT
 ruYP5WogX3nDd4NQ3MfsiXRCK9jKQcvMd9s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2kg6v7r4k9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 10:12:53 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 13:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD3rg/gXqJ+Zc9g5z3V2WA2XigUW15BwGQCfYKKl0zs=;
 b=XTSCjBmx1+ieJiXp7DbZgH0SN09p8cQWracrIDoA1uE1JN/f44TgvbEv8OalAAoOd53bUN9b8jHhosSuMV4VSe1v7NqomAv8DdsgUdvXh6AO+Qg/XIIACqMyvtdcbJ4lo4igp2y4qVEPE4ujuLXJMaHI6AS4reOK4eA7NPucvGw=
Received: from castle (2620:10d:c090:200::5:d753) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 27 Jul
 2018 17:12:48 +0000
Date:   Fri, 27 Jul 2018 10:12:43 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 02/14] bpf: introduce cgroup storage maps
Message-ID: <20180727171239.GA9128@castle>
References: <20180720174558.5829-1-guro@fb.com>
 <20180720174558.5829-3-guro@fb.com>
 <a7bbd507-3de9-e574-7187-f7915add7474@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a7bbd507-3de9-e574-7187-f7915add7474@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:d753]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49dcbf6d-ec56-4bf9-f52c-08d5f3e42dfb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:3TcsLNMRfXzYI1YM0G/RMQXQNwob7RH0P/8vsTXajCPm8mSVG8bDz83SY9d5NTgUPgLO9J8aQAvlO1Jfnlg9tpBjk2Xt3hwt4K5BylAjD3K84OT3IYfeKlTcCZI5oO9jyqgY4W3G+oa4BDY9jxBMusIoQISCNJcdrpIQUv3y+3MyxwPr0n6C1nO0QToicalboPtmuVAm+uQpcvz1KxjvDGyMMcfh8QEjiH+xUGzWAYMzkbQA2/p0WXuLbFKI+72A;25:AAck6L+QthYuEXTHb6uMTfzhZVOeAgpuXDmTxGCe6BwwQqOmMYh3qO3XHWeb4eNzZsaAhid4ufc/2sfVsu83N7E1b9xvZdXDZCbq18CaF+cHcVQUyGop9IcPXX1GjYIzK1abNNc+3THIshcCRVWQpLR0R7Q9rgPFDdDmsfg9PEZTiLvT7gLqORMZLPCYEMBPSd5ZLN/2/iDKn65NLbNeSzqr5IXe6GM9nmqtjwqbEeM66rbD4CChZaJ2+E3luCvSfUnozRmwW1xbQaNJ7elG3m9HY+M13FKPQ1kNs37pGddRDOPwKvhYjiwcIFVLHkRl1+KOH7aYjxbDpQeIXvDdVw==;31:PeuAjmL/4p5n+Luwa8JTCUEP64bFRCYxA6dZhBNM5+Or1n+Au5AczKS68yPiFxuGTIdXrxisjduP8JrKeUixs2pL5+fn3rJQlTALKfSKFBBLZ8IGOc5oEHhPQWxad+Ixs2s51qzVr7ZPk4IbQ49LWBpzWNrHOUsNAAwN6BYe6kWSFnENyOoB8bYJORTbxEDAe7mYXAC8q2vBvv43vPYKCR8C2cNWwt+zCzop59OEhUE=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:33q4RNBrk2a97Lw5xCqA/zsW7NNVG8ScMMxylTSDw2TP5U4CFEJxCWFf8rAiat4rVHPayqQ2EIRkMq2ZfL3TY8nirSUwoMskjiiDRF4JSlEkj002ppaNpQPIBqnzoXCgQ8RNO4ONQxMav8Dfmz3yPMRpVTwBsnHtnt8E1X2zEMtj6Up9YqoaCq/xMz6+SoI95gPnUMPYgXrV7SSpqeTfBFI0+8rxyOVYKwK8TSNQB0IOZLq7p+39Q9Bkso7iEh3yRSx5balntlbofb6t1ypUxw2zRot6xcAbsJZIogoz4qXSvpGxikaLHIiPUwuBjrBpc9zvTw0bMiH+SEw9riJns6fnb5+nQm0/rqYu9a68v7KDJIR9rz4h1YOQseatuQGKbIAmnlYESE5f8u+oNUBYo3KLu+xgSynFemXJQ7b+VjoF17xtoQ2kfaZYtiJFTqGpXDHWNrmnxfiePs+Fd8eXvXBoHCYOrzWQ3P/p9cZihXC7vHM9UoFitj9sSkrRVK0U;4:Yv8KqCzEKfcHNnecb2lFWzQIXabLUTLusLB7K9+u9Nhsuz4ey8h89QMYZQgUpUylYyEifMGjK2OgmonSjqg8aZCHUPbJkn0dYGFnsdh5R079a4a6voNWD9Yhbu875r3GX27AW/IHH7yALGGfU8PVssXUwjY2HCuCgBQZ85ryWwrlyE/fELv5GKdzX6Zza9DResWF3wgjhf3n6MrCTjtTKYNuVliyh5YfU17s3I7vbtyfodnrKQXUEkshoTjSVhgEKHGvvKL4viWPi2Tl7QHE8Oi8L6/6PKzDKtskB672a2LY+nmlAmvWnWE8AGRRrtEbFsN+JqG0bSpquYochtgOSAmWwetMB2LlHyngHlxuSn4=
X-Microsoft-Antispam-PRVS: <SN1PR15MB0176A090B3F3C44BD59FDCC9BE2A0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(11346002)(446003)(25786009)(4326008)(58126008)(50466002)(2906002)(76176011)(305945005)(97736004)(46003)(52116002)(6116002)(7736002)(575784001)(86362001)(478600001)(316002)(6246003)(16586007)(229853002)(52396003)(53936002)(476003)(8676002)(16526019)(5660300001)(81156014)(81166006)(186003)(14444005)(5024004)(6496006)(6666003)(105586002)(47776003)(486006)(6916009)(106356001)(33656002)(9686003)(33716001)(68736007)(386003)(8936002)(345774005)(53546011)(23726003)(55016002)(33896004)(1076002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:64iDHaZMvfyttgefJJrJyfSRcOR9NJBl8gXqptXfZ?=
 =?us-ascii?Q?qIZZ+/oR4eunOEXU3VS0PCGCXjYlLQ7TAFrm6x+/vDI9P0N2wWIDk0e1VoC2?=
 =?us-ascii?Q?cieSIudCOaiGKRgBh7BYwhNSB9nBmqBJiIJcGTHC476DzQo6MnfJ1XOBYbJN?=
 =?us-ascii?Q?S9N0JlNRzSp/UVCtOEwZOiViHj5lmIntY47ByrPjOldoa+C6xUb4+KX4rprp?=
 =?us-ascii?Q?81RyjWWMxPC5FIw1t9IBB9ure04KHfOY5NT/k+RllYCAbHITxw+IEblwhxCu?=
 =?us-ascii?Q?YU1Sv29ucnYczVUDvMPBD1ySkyS0cw1HAbnSZLTwqIQMwbKSTFHbma+Y/iBM?=
 =?us-ascii?Q?A6Z8+DLye24tMYEiKMXQshxlf1ZS3JCLgWnF074tcV3rP1U+dKspuzMDRXFG?=
 =?us-ascii?Q?pSYLWHRx5e0nnFPzXQxjN6U42L/bzpIl/yfM1CzRb1rdSoDkxwEDggxT21g4?=
 =?us-ascii?Q?TxPJr/adyDsfMlKej6g51WWwt3QyW4y7x7bNBnS8UbZhbDTsSns0fQS63urh?=
 =?us-ascii?Q?11iGleg+NZgcSaSimQSNLRvQuByIS7fg1oS1dFWS/C8ocFaLE7wcqwaEZsbg?=
 =?us-ascii?Q?35yeab6NEczaxSowdn8R1TAjoHpVNgte94XsbD3ZiYbbw6HD1zuG/gZpmf3l?=
 =?us-ascii?Q?0XBuS9a5Zt+n8lQVLE0DMFIZOyzY51uK1DWJKQ/Ks7tQjjxH3VUMAcoIt+Mk?=
 =?us-ascii?Q?tveiZpSl25FmoyN+qi0xuIyxk0rKH5WQg4soXRV1OtB40uWgAhy8c3idugSC?=
 =?us-ascii?Q?XHYXgVX8hrNCOkXjPsoE4PPRKRStmnLQkIRATvq5jegUsRxf0PAWKJSmqpBN?=
 =?us-ascii?Q?MzbuoxlTI4MD11OCehLGbooIZK/j0MXfqGcEAZd5Mt7/a4MmFbkjnLbEtPcH?=
 =?us-ascii?Q?sxEaPC2/iYv6AEikO4ztZDJefGHllamRKHAp2eFEyHWZkGGUdZ286lLeKFbM?=
 =?us-ascii?Q?dFUJ1V35H1dWOQG/YIMQn/XtX9tDnxFXpEZ1rRTgwf8wEW3WkNS/4TBDrVaY?=
 =?us-ascii?Q?1CKTlQOselbdca3ne47Gul6GxTnQ/SJwEvJQxwg/I+8PNxUCFfwamMrNYuwD?=
 =?us-ascii?Q?nPd1UCZUG0MFlk7FoxMg6kors95L5eNDv+7yjIVp4Perfch0Vw2zKNyG0Kum?=
 =?us-ascii?Q?5mqa/OaH4RNicF9QShvKGCyctKITVK28z33dkXVqdkkiHFUm523HowyE3qyJ?=
 =?us-ascii?Q?gCre7nleVXrdcEqHrvc4KY4MIVqMBNk74+HC6imlpRs3s+JXJrTYhfY7RAg0?=
 =?us-ascii?Q?aLuR1A+UJZTRNDi7cW61HCadGUju5sfR3mZy7UA3hV4UBlqGYQyMaMvOP/Kp?=
 =?us-ascii?Q?tMSI+Y17svZ2UGMzu44oXkQw174du5d98QyJ5SSkqL9w7Jkxrrru2TUg3IG9?=
 =?us-ascii?Q?R+biQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: PvAns7NQKXFlSlSUtE1jO0gRyA6bw3kHdadMGegu+O0Qs8dRMNW+LKtyTYMX8dGEqE/rCRZF2Z2Nq47399EOpchOPX4PeJwAmno5dF3xbQPpo8fQkXVr7f+GRIpqk2MKG5twspaG9to76r0MceWwnTfKkQ558TXxhuZiv42R5EFWg0eLVihmbNnsD2CCwM67VATXn9iAEKTF5bCCCL3HqwWjIlIRSDR00P6dp1FZd3DjjQmdfZNHbk26Mln5/SQApl2mIwR71f3LAJGmzrCdTvJ5KAUztbGiwhjlbO5VKlLENighC6LJEuf74P8qhMHUJNo7g1GJQr75IwS/cLVuGiTED01cCynNSCpervNe9xU=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:kCyCOvn3H24IW/A+q1swtVeszMd1B7L7riAObTHNhwWbWpIBB4ksmzFRr3Ei4oqtf6VSK0neWOlJe5JpfgjZ5mZwM69CxI3TPQq0rNasro+nMm5p/2HA5LIQ3wg3plinvKs5iBn3a0dlCTYu7KqWyDPt79vCFCxTF20MegBORntzkiOT1zX/I3M7bh5WhLn0RJRDJqTL95aVwx2ELgenT59J7o/X7A6gpw932S42u2r6GE0g9H9auhD7zHMfVsbwcomZRUO1zxR3P5TwQSXrR7TD/7UO67RLkj8lU6nxBjn5XbDAeXWnkmc0p/XSeRhXT8yPw4M1qxe6ESUxyti+UaRDq7Re8jBuGiCYHX1MOX2PfIJ8nHTiJSNeW/vK6oFFVB7awAmMTzeoZuLepIhlk1+ldvQtLfJEzdbBtnLPXQoPVlvKWNDFcxGpFal7Q2Iwvqc+2i+8Q6+GxELj4LVB4Q==;5:CRANfq9DgfapUhxuI9XiZVK/wq87J/+IbbWPz87eXpOW738Jy9niYQmMHfShwUSanh67BISftzx9OcmtjfuvgeGW0KWFIDkSZBAesgqb70KO3Gz+CtSAeQ0Q4bEZK7lKYPbcEdXwZBc7t6p37uoX5eqdck/vg4YCctJIP2PVS5w=;7:5l4YnxncSji5k33b5khPW6+gl5cmG+5O4rX17mXwWji5QXMPwhpvM7DoORhYUpnWJ3QFroiTtLbklMtsDlVVsYI/9WtnqVW4/9kgQW04GMUecn5TxHeIZBdG7Z+o7siH6LsXHEsyWP2h/gcPaSDrYkfyqRaogmwiFkgeBN2XmMNt/T/qjt1RlxzNMspeie8gQyk3YEVN8lwN8Y+P4tAXt0CbI6tkKjBqs/a6eG+fxlKdtPxI+CFsbmufBnhiTPX3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:crKhcpHVYvtrGnesRwF7G0k5oqpighH6KXg8B6wuvgCh8y8BFhKVMQ/9t1bJIT+7jIwxClb8xic3nUORt7QGTKnB9gOlzH+tg3ToWzGAT3KOM99EDGf6KlQmi08DHOvYza7eD2jPKqssYaHIZnnsZbJUKuCBnAVyQUex4Ql4XWI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 17:12:48.6748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dcbf6d-ec56-4bf9-f52c-08d5f3e42dfb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 06:11:31AM +0200, Daniel Borkmann wrote:
> On 07/20/2018 07:45 PM, Roman Gushchin wrote:
> > This commit introduces BPF_MAP_TYPE_CGROUP_STORAGE maps:
> > a special type of maps which are implementing the cgroup storage.
> > 
> > From the userspace point of view it's almost a generic
> > hash map with the (cgroup inode id, attachment type) pair
> > used as a key.
> > 
> > The only difference is that some operations are restricted:
> >   1) a user can't create new entries,
> >   2) a user can't remove existing entries.
> > 
> > The lookup from userspace is o(log(n)).
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> 
> (First of all sorry for the late review, only limited availability this week
>  on my side.)

Np, thank you for the review!

> 
> > ---
> >  include/linux/bpf-cgroup.h |  38 +++++
> >  include/linux/bpf.h        |   1 +
> >  include/linux/bpf_types.h  |   3 +
> >  include/uapi/linux/bpf.h   |   6 +
> >  kernel/bpf/Makefile        |   1 +
> >  kernel/bpf/local_storage.c | 367 +++++++++++++++++++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c      |  12 ++
> >  7 files changed, 428 insertions(+)
> >  create mode 100644 kernel/bpf/local_storage.c
> > 
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index 79795c5fa7c3..6b0e7bd4b154 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -3,19 +3,39 @@
> >  #define _BPF_CGROUP_H
> >  
> >  #include <linux/jump_label.h>
> > +#include <linux/rbtree.h>
> >  #include <uapi/linux/bpf.h>
> >  
> [...]
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 15d69b278277..0b089ba4595d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5140,6 +5140,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
> >  				return -E2BIG;
> >  			}
> >  
> > +			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
> > +			    bpf_cgroup_storage_assign(env->prog, map)) {
> > +				verbose(env,
> > +					"only one cgroup storage is allowed\n");
> > +				fdput(f);
> > +				return -EBUSY;
> > +			}
> > +
> >  			/* hold the map. If the program is rejected by verifier,
> >  			 * the map will be released by release_maps() or it
> >  			 * will be used by the valid program until it's unloaded
> > @@ -5148,6 +5156,10 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
> >  			map = bpf_map_inc(map, false);
> >  			if (IS_ERR(map)) {
> >  				fdput(f);
> > +				if (map->map_type ==
> > +				    BPF_MAP_TYPE_CGROUP_STORAGE)
> > +					bpf_cgroup_storage_release(env->prog,
> > +								   map);
> 
> I think this behavior is a bit strange, meaning that we would reset the map via
> bpf_cgroup_storage_release() in this case, but if we error out and exit in any
> later instruction the prior bpf_cgroup_storage_assign() is not undone, meaning
> at this point we have no other choice but to destroy the map since any later
> BPF prog load with bpf_cgroup_storage_assign() attempt would fail with -EBUSY
> even though it's not assigned anywhere, is that correct? Same also on any other
> errors along the prog load path. E.g. say, as one example, your verifier buffer
> is too small, so any retry with the very same program from loader side would fail
> above due to different prog pointers?

Yeah, I see...
We should call bpf_cgroup_storage_release() from the generic verifier error path.
I'll fix this and the leak in the other patch and resend soon.

Thanks!
