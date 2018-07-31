Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6AAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B7020844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eBGHA+T9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XXtsi8js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B7020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbeGaTGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:06:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50566 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729636AbeGaTGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:06:52 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6VHO9dC000305;
        Tue, 31 Jul 2018 10:25:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=vqCT8cjYkJ7br6DQutaXNO/3K9QaE7v/5fCp1oS8JJc=;
 b=eBGHA+T92lrTCfIvJGk6rp1ppZmnDwLxAJn57eOL949cRCeN6PbaysSyPvaJDlYRM+KP
 vIh/tvUsLtpNCWc7BF6lADF5KgOVL2bvqm3xCLKoj8VbEIrOSZJWJRHk2ps8Yn70Ys4W
 imTQyVnlUZSD7nj7rIed6ZRKv1a6X15Hkzc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kjshm0p2t-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 31 Jul 2018 10:25:10 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 31 Jul 2018 10:25:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqCT8cjYkJ7br6DQutaXNO/3K9QaE7v/5fCp1oS8JJc=;
 b=XXtsi8js1Lg5Et0Ej2wUqtdmhuoAw2Tm3TIgQKG0MW2rgkaZ+8L/6X6GSkNEJM9AGqyooYrfOhrxTgLOfZErJuBxFVuzz8tmsj1zYthtwi67Inp0LT9Q+WEUUKOGzuf+VZctawfkWAsfh9PIA6bOPy5e+IKxZKBsMruM6YqmDs4=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::7:6a14) by
 BLUPR15MB0161.namprd15.prod.outlook.com (2a01:111:e400:5248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.18; Tue, 31 Jul
 2018 17:25:04 +0000
Date:   Tue, 31 Jul 2018 10:24:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v4 bpf-next 08/14] bpf: introduce the
 bpf_get_local_storage() helper function
Message-ID: <20180731172455.GA7535@castle.DHCP.thefacebook.com>
References: <20180727215243.3850-1-guro@fb.com>
 <20180727215243.3850-9-guro@fb.com>
 <f07d5417-4a55-c92f-800c-4950f4dc8aee@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f07d5417-4a55-c92f-800c-4950f4dc8aee@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::7:6a14]
X-ClientProxiedBy: MWHPR21CA0061.namprd21.prod.outlook.com
 (2603:10b6:300:db::23) To BLUPR15MB0161.namprd15.prod.outlook.com
 (2a01:111:e400:5248::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6ec0fa9-4a31-4976-f65f-08d5f70a8e2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0161;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;3:Y/cGpwLEY2VzPGv9/OcaW9GaR+hVOvo4sRqO4YJu5yXjVnVxUcuHAXq4+MNpY8isrm5fdUrzZZbdM+GTeUqY/Cy7aC3LvRTDeQ7iVmwjJHh58RA/06qgb1cUQftt6R7dXTbeNj3/JDIlCIF6xFpWFcu39oB8L85IqCGJo0R8Bj1tah/M8hpyJNdxs2KyTt4tiEZBGuJCK4JvIKdc/HaStjxXyobRdaatXtGyv7/JMSJiNg+ImpshBE3hsk45kYIC;25:qNxT7cskxcAUW3/wxds+z3apXEMKCtHytwUGFST5IE6HxSxQ3RaGxxJY77Dy9sSbOMqtqwROxfdEGT8dZapgAsR51pfA316nGCbZO3vkyphMdAxM/KDIWe1YuBDlh69gw1Xys+O1BCLQrldDd6Lc5bI8vgYEYnkJHYnzjxTpD4K/ObZf4+Z5XLvWeWTpTXnxD19Pn4vVCpsyi33pvbR3JBFfmwSk+nbAc+pdS7PW6FLFMx1+OmaAt0JzmaCDzRNbK9kKPnE1PWq2Mmoz1Q9T60iSra1IgzFdD2Ej6u4ZLP8Nu+z28srvPF54ycqb+tlP1rSleMfnyceavUVvYNB5kQ==;31:Daeod/GPl9AkvGWTZFDK7tdvtXzkKRGtSvV4K+3yDHlKWWMhO6s0/v37vUtIjvSbWlVAOBsagLydbaMv6vfwR7Hgn9mhqnz3zQ7Maq+mTIqCphJu1AlycXFu65nzbWwNND5657jXpFzIBo8VNv/MtNAgEQMB5e0T0ZV2bddQ0456KZZVjlwJJyytk3ydDlaIuwphl2aYk7iEJMLCkrKp8LX4QSW9CsiTjEP/GE9KPkg=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0161:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:/FMqwYgJjbXzIuErvUJ9FuRcMeOzrj0k8gLKUZJULWAc5a5p5e4zzXgT6Z9hsfDWWqXnILmFcjCaQwOqVABxhj9bLzZmE07PRUHYeD5u/be2cXu6wS8VeBowvC11n9m3VsNfMzZgwFiJn68zpbkXtKVGS4WybcU5RbvBSqixgM7eQxNkgGQctZNz0lGe3oHgLbD7F4I+m8g8d7jjh98ljRVp+5iiJwWHEGzUblf//aSSuRT6dSrJwLWBA7KvnRQtHIoZuaIRotj6KGpoR8ANff3vKp2F8pPMQ/4zYPRbwW+y2YhU153N9rSLei/DaURuPVc0jWvuYG2BKd5SrCccLkCBwSMosmvNiOH0zT9b44o4RGutzF7dqwbPIYT/FpBS+ZQpOM6qOc28IABMFvNHIQEwkVrLVTOMuoeJ1g6TRakoC3ZQunheivU72Y6ZxY4bCd7EYlwYEvGz0ncrXMa7LuqFb21lJm7T9dPK/waX0NT7WRWWunotq/n606XewpHz;4:dvftJiJgMy4b5ieS7sbsWSLXpz0jhDVD7NqqwfnKdLQFqXw5GobGsf8mcyR1ijnQX5dLWlhCoOfdl0yEwjzT8ZlfTyN88j1AQAuc83V7OsLMs2ASJNMzaBEWx3kJ3PMef5+EiqblRNrn/nJU8LTlUYCKrUlrerillsavT/bRaEPSMGgHlrpO1KeoSBzqSc/gBITKSMpa5cLMieG8jy6wviX/9q9lyFpCx+AfBTpAnzdxI9XZxbtA2Dz5PXZrDMlixvmcKFgoYHV/znef1aMbVlCiaK3VJ/oNe7zIzoIcOt4EWT1OUVMOBeJZ9JfnFP17
X-Microsoft-Antispam-PRVS: <BLUPR15MB0161C8B43DFC92A03BA43929BE2E0@BLUPR15MB0161.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201703061421075)(201703161042150)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6042181)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0161;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0161;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(106356001)(2906002)(47776003)(7736002)(33656002)(5660300001)(25786009)(8936002)(498600001)(97736004)(23726003)(4326008)(305945005)(81166006)(81156014)(8676002)(105586002)(50466002)(16586007)(58126008)(6246003)(575784001)(14444005)(86362001)(6116002)(52396003)(186003)(486006)(16526019)(7696005)(52116002)(446003)(386003)(9686003)(76176011)(6506007)(53546011)(46003)(68736007)(6916009)(53936002)(6666003)(55016002)(476003)(229853002)(11346002)(1076002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0161;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0161;23:0Ia+e0wL/5TtlMO2wRvnnhbJJdSAtAgNYAukE9fhs?=
 =?us-ascii?Q?Q7XVxteK5A1aEbHysTlHFop6ndZV5SOCOmMg4ilwzxIidJDh+AKSravrhrO+?=
 =?us-ascii?Q?ffTQtLCUoBRMXpwmHOGh5e186EPf3ojd/p+rhMspSF3TBo3PIiTUEtZfptTt?=
 =?us-ascii?Q?cjmdnzsPFcjOQKBq47/4NeiEECfGmSuy2eWyS/dbi6fnjkFazuU3dOMHCa+H?=
 =?us-ascii?Q?h3lj9pxv5ZQANAfUgAVoZaIldEQ1+RGW5Zo4M92E97W8W9Huyx99I37Jmc2p?=
 =?us-ascii?Q?l8rtux71ZdqQF+wvANQ4nZz6q90O5qjToKQGUdH6FtqriqvQDyvv35LDm7a2?=
 =?us-ascii?Q?M6Lmr6pUSHO+YYVZ76iAbydCPqbqeAhAlGHIl5g0nhmThAVl2GuZbt303Pml?=
 =?us-ascii?Q?t27L6GZuftI3Kt3dRFDM/1a184Te/4PnqTY2SMTXPmsgIS78mug+tC8I6+xy?=
 =?us-ascii?Q?tRLFQ8zkSph2uUDIHs2UwfOZMLmi6tVw73MSIBUSMt13kXwRmwz8UDXXhJg0?=
 =?us-ascii?Q?tPioj6qFV/vGbI8THoOBR7/DqRp42Zq4vrZ9Qn3qh8KQsWbrn2/Pj0lxPmA7?=
 =?us-ascii?Q?RO+pUL3qxtsKxumYOBs7pu5A9PNySRvkXamiyhRsF67mmwjXCDy2MTe7R3LQ?=
 =?us-ascii?Q?uIViMJIHGStbcfwj+Lb79+pUu7RN+NAi3yCE4VFsWgC08yppF0pI8KNb8+OT?=
 =?us-ascii?Q?eZlFPPrIqFlrqGGrEa8y/1oJdxzUqyleeUB1bIq0WFfMs98Qi9f0B2C0htJf?=
 =?us-ascii?Q?T6brD7ETUSQd15tG3FWZRWydTiddzqYvJxA2mFbxrxGOfbRNW8d3DR4zB5Tq?=
 =?us-ascii?Q?nJhPqSDqq5NjF/XWvJogQlkvO4+mPG5zZMYbFzIxR70Iwni//lGbsCeEaQMB?=
 =?us-ascii?Q?UM76d9YnB2JyBwbW9zlxWdNLDZX0Lv7LvXF4lK3lnylKtklgh8M+bxVd8yp/?=
 =?us-ascii?Q?67DNZdvyt/pf+8fsJ7BJwhdfC7I9G2HlSn9g6Uwgds81/qJwzwCprVBBBZae?=
 =?us-ascii?Q?dp80yddhPAfq8QfYktVxS3Ozue9J0+mxhwhD6C4r6grARqfrNaQvnDM0ZzEQ?=
 =?us-ascii?Q?ByEkbmGsK6Qphx8taVTZXOrJR3nOvenGZNxo46fJ2OhZmxEHZe240lr+7nfU?=
 =?us-ascii?Q?usZ51wS95GwE/yN3dq6e/Q3aJefUdApUuuGmHMXuodZ464gGLjjzNuWElRn5?=
 =?us-ascii?Q?xHRsk8oGGTW4m0=3D?=
X-Microsoft-Antispam-Message-Info: NJS5aiCz5ZRzQ3i07RNXcgamvkQkOBA3YgcMUXDD+zCYZ3+GkOQUS3qhdvReMofk5kbMK6Ei0YfPXTdOSQQkcksF5cdZD8YgUwBBjAOsLFL1+5pbSlo5bgct2siiDigJD2uAT/GwR+jvyYRMC9NJo5fu+n+zXJugQ1ykusExfltXCAbC/IfFx5dpAU/LFxp+6HC+NNe2pYbtJTtDjWnpHITCzc9JgqqkAw37nCx47zBUOVUEODwk5OjPMAf8C3l3Dkeyki0BbWv3Hp0VZZcLMTEv4f8Fx74TC+ZehTvS0/0K3tG5BLbQOJyfxv4AfsWakoUq+B1L/d+oAXxECAEFquADyb4WVdMItDTXOWuFXxI=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;6:UNEbR5MIBrsLCvp8uXr0bfP8oKNqjEiV284gGGMzrHsVjWHKKYUaCedJqxsBiOGZKePkUYqsQ/Co81QwDLQjKfNgC8RzbrPgRXms4peyz4WM3DqkbSnaPc6ZJw4sb/4e69hp63eoET3W3O3XvpAJTa1By7wBiFxq8JndSzC/l2GHtgOU/xzxUrgrz7mux4jjRWA3wE8NJjRfd11tgDKpLpwZGo2w32wI9eiixcAkuP/oav/aDCVNk3l1VIN+8OXdbDxxPaI220NAQRBSz+kXPLwY97HnQPkdapW4T6cwnuUiZ8rJ7tlBLMD3pLVYnh892SkSsFyH9d/zPNxSh40dnT7ySDVtXfxcK58OkkD8CWN5TBiJ8odz7riWqMa1n7NlXhBqEtXL5p2yhUhDG5FXrmeCHiKf79tbMTWgczKPEnJ5J6V6+6RNJgrxGd5uyPbTD6bxIJOBfv4Ufnj8zzW4xQ==;5:JwOoc6b3mtGOKI+ZBOfvgP/PTWIIrRli1gBAFnpEka7om40NvwJ/uIxtYyh8APRQWGT0k9pAYIdOj5jbeqiZT1XbKFuvSQ9WsGiB+oakdlJJbAby4ONefhyRlpuN+hEXj1+07X7l+6LEbmosnGF1CT5gniUUW2dKn2h7nzhrKKw=;7:4KlL2BTjdxg0N4Bf3ikjvL+Bfr/YgINRWWgwqn2WV43gBfAitPN/TC6SSS0gpdYTQPIUII986K6tnd4luYU9VnNSFHhup59einQv3s5QyzXWsOIWpfJcYfR8VtHZhX1PU5CoawEn9oPpb5rlDQqqQeCRudhM85DZ/I68/x+HJ49Y60VbWx5ahB/8b7rtMv+q8xpxNYz09pipnjGj3MOZYisuyxT42QkRom+aNxPMhz667H9LEpy/133Agq8dXLux
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:XGFt7mmgs4R9nCBxgTI4c50Xq04OHYq3to/Dza3oaDaPCU0gke/YXjLnoOo70q6wkupJG01GrKioCuCizAF/U/ET7KfQyIicSidtxMSbghJVTS/BR/yxEEuiIcpS2Zn3mD7RzvO+sC5IMjqYAL26iDjujL9O5FeN88O4y+9b5SA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 17:25:04.1781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ec0fa9-4a31-4976-f65f-08d5f70a8e2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0161
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:34:06PM +0200, Daniel Borkmann wrote:
> Hi Roman,
> 
> On 07/27/2018 11:52 PM, Roman Gushchin wrote:
> > The bpf_get_local_storage() helper function is used
> > to get a pointer to the bpf local storage from a bpf program.
> > 
> > It takes a pointer to a storage map and flags as arguments.
> > Right now it accepts only cgroup storage maps, and flags
> > argument has to be 0. Further it can be extended to support
> > other types of local storage: e.g. thread local storage etc.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > ---
> >  include/linux/bpf.h      |  2 ++
> >  include/uapi/linux/bpf.h | 13 ++++++++++++-
> >  kernel/bpf/cgroup.c      |  2 ++
> >  kernel/bpf/core.c        |  1 +
> >  kernel/bpf/helpers.c     | 20 ++++++++++++++++++++
> >  kernel/bpf/verifier.c    | 18 ++++++++++++++++++
> >  net/core/filter.c        | 23 ++++++++++++++++++++++-
> >  7 files changed, 77 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index ca4ac2a39def..cd8790d2c6ed 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -788,6 +788,8 @@ extern const struct bpf_func_proto bpf_sock_map_update_proto;
> >  extern const struct bpf_func_proto bpf_sock_hash_update_proto;
> >  extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
> >  
> > +extern const struct bpf_func_proto bpf_get_local_storage_proto;
> > +
> >  /* Shared helpers among cBPF and eBPF. */
> >  void bpf_user_rnd_init_once(void);
> >  u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a0aa53148763..495180f229ee 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2081,6 +2081,16 @@ union bpf_attr {
> >   * 	Return
> >   * 		A 64-bit integer containing the current cgroup id based
> >   * 		on the cgroup within which the current task is running.
> > + *
> > + * void* get_local_storage(void *map, u64 flags)
> > + *	Description
> > + *		Get the pointer to the local storage area.
> > + *		The type and the size of the local storage is defined
> > + *		by the *map* argument.
> > + *		The *flags* meaning is specific for each map type,
> > + *		and has to be 0 for cgroup local storage.
> > + *	Return
> > + *		Pointer to the local storage area.
> >   */
> 
> I think it would be crucial to clarify what underlying assumption the
> program writer can make with regards to concurrent access to this storage.
> 
> E.g. in this context, can _only_ BPF_XADD be used for counters as otherwise
> any other type of access may race in parallel, or are we protected by the
> socket lock and can safely override all data in this buffer via normal stores
> (e.g. for socket related progs)? What about other types?
> 
> Right now nothing is mentioned here, but I think it must be clarified to
> avoid any surprises. E.g. in normal htab case program can at least use the
> map update there for atomic value updates, but those are disallowed from
> the cgroup local storage, hence my question. Btw, no need to resend, I can
> also update the paragraph there.

Fair enough.

Mid- to long-term we want to add a per-cpu version of the cgroup local storage,
and, possible, some locking API. But right now XADD is what should be used.

I think something like this should work here:

--

Depending on the bpf program type, a local storage area can be shared between
multiple instances of the bpf program, running simultaneously.
A user should care about the synchronization by himself. For example,
by using BPF_STX_XADD instruction to alter the shared data.

--

Please, feel free to change/add to the text above.

Also, it might be good to change the example to use STX_XADD:

index 0597943ce34b..dc83fb2d3f27 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -18,9 +18,9 @@ int main(int argc, char **argv)
                BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
                BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
                             BPF_FUNC_get_local_storage),
+               BPF_MOV64_IMM(BPF_REG_1, 1),
+               BPF_STX_XADD(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
                BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-               BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-               BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
                BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x1),
                BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
                BPF_EXIT_INSN(),


Thank you!

Roman
