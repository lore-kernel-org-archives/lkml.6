Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09545C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF4F20851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="chnI1qYj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="doFo8nX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF4F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbeHACL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 22:11:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58150 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732866AbeHACL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 22:11:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w710Sl2H022423;
        Tue, 31 Jul 2018 17:28:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=+6iWu5BOwJNxQoTg96J6YBQopPupGMUkcmHNwTOvqq4=;
 b=chnI1qYjoMIErIx/z5a4x9ttx4rfiwqbN3ZyyzXYe+zbVE6zlEC0NuAVdiUVmU/r8a+k
 sLdOIKZSQwy8k/XMdTYgl/dk9vMj3doMHLUHoBVYPyv69sbhXDVoSJDMxccuCokuTrcL
 Gd6ZopTmytPzH+E6A50CaNgXpoVgrOJ2q6A= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kjxqn8m23-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 31 Jul 2018 17:28:47 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 31 Jul 2018 20:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6iWu5BOwJNxQoTg96J6YBQopPupGMUkcmHNwTOvqq4=;
 b=doFo8nX7q9eTTo71vl10V5R6qa0HLA5j889XqMOScJ0+k1ee032vZATHsEHDw643eXJ8cr2IDAIXgZBbSt5JS8uvyCaZA48KQQniRjjNDw9kRYbwpAX2n/su7NmXtUi/BwsdDKLPInb0D/WpY3OiOpaWWsud6JOB9Fkanuslq1g=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:ec7a) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 00:28:40 +0000
Date:   Tue, 31 Jul 2018 17:28:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v4 bpf-next 08/14] bpf: introduce the
 bpf_get_local_storage() helper function
Message-ID: <20180801002831.GA25953@castle.DHCP.thefacebook.com>
References: <20180727215243.3850-1-guro@fb.com>
 <20180727215243.3850-9-guro@fb.com>
 <ad6c58e3-08a8-aa9c-2d69-528007fe126e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad6c58e3-08a8-aa9c-2d69-528007fe126e@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:ec7a]
X-ClientProxiedBy: MWHPR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:300:13d::32) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb097fb-8ea6-4ef5-75d0-08d5f745bb83
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:nq8XcmgheMMIDTYY6gdQroohaxRGe+FRMCfH8K/yBJyHzJVscMCXSL1T99+xud62WvMqsmPKj5ZswPzJwlisd0vmh6Hi7FX99yvf512H7cUcbXS7i46z1ovqZgruJ3Js6UcnQRJGAu/PgLRBg3i3yLF6ZM7YIoGlvoa9BWCGaVSEZyGr2ib0dW9hBe8nB9QXIgkakBSchziEpM++cmHOT3/67iNX66jDOktVF7fFgCg1Xcnt3c0pXXq29Z7jWF7p;25:3pAyztzLLcMw2GnMq1SgyDN4DrXuHn/dYng2F0R7GKPu7nBFP9axdLbK0evj5i76++7y5DolS3Vf/N0hEeZeo5e07se8wpMh0YdC0dv9m6rrxxQnjobI/rDcqBJmPVjkeZgHBYpiwWG5QxaLraJFLQmaczrsfYPLmF3ALsKEqAkiLqHiLCV6y3N3juALTWfYB8A4sqtYdNqzuSwyrTajhvfK5KkZppVV6JpDbmFePGmlqwuJhxjDSY22VzZeIiJV/ZRBOS7n/dfVBb7NRqcVv1eVBDhKKhrCuDKbgCtYpMt1wL6rB1F9NlaEWU6lZ1a3xrRcNZiIap7AFPpZm7oN3Q==;31:GQ3aXi75tJHQje9A1SZ0jMnGSeHPC7fFBYHzdpWTj6D6cXoqG8+4tOrqmBkmyCkVfQjsoPed1LKHnuyg2RSPwAZ76rXQVehkhAdG3s0gdTcVacyR8cPUFuVwMRwOp9oVRsz+7xeGowCHVszLbbXwOcZ+XaG49Z1NfXBUOxyLYiiEZMpglRore4z4uEqS+V3kv7GAiBV1OduOAgphPu9+6j5mhrZrdJTrPVxmW3yM8oA=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:uyf2cOc/yF5QtS/5LILcr2I1w94RqB+ZGsLESm/rS8shIEyZhBIjQJ9kFhUHV6UQBdP+QBSxejcXfM7uzaXCUvwwhh6NhS4p9L076ROTYDcog+Plqnrf4l+j377MCuI1/Pjs+exjRm4W0m2u1n7u9bIia63KNKA9ovMnUAOm4ytprdzRdfHjLCdfHEr0ASYo/g5zge98ozTmw8gxRxGpHTJ2AyK7kN47bCRC/Ji4FcbXYpRq5mU+LvEpr4P9Z/m0rmQmWXFNzvar1AcSGhV4omhs+vktzL+6dKJRAx13pBE2uysb1iT5ojCEofwsNqAkm8kXSTiL2XTXE/fCy8jDpciA5j1lsas3tzRKZQ+diynf47g/jogp2DaD88TobF5HrkZ/yw7eAjhKvabpd4EBVZlS2sVUSspoNBAa0/RkBqkJvdcpzPkWsdbRsoU9pgITKbAv0+FpWQTBoB94jt7giwz/14aoyh0Uj8POP2vFOiKOU/NcNdGXyMff2DPlS/ST;4:u2GcS83tUnd6O5jdl8BEZ3zgHZWVHQctreT8lJuUY6iIEdINGm/+y+YTYkn7D7u4FRSCN0QSJTQwmK+PygkeyPUT/4jMAUs8wnkqXH/qys1Rukrjq95AuAJxIfAjWmquZyvQ9AX09aQccwKw9GXFkE100pzWgDVED8Exde/Yz3KCALS3yQLeC59wzeh65yNyzsjWqY64XRjHTlRFtC7wvHbUAqZWMrr2N/dr9fk0B92KkroRsbFVD8TjrGrz/ca8VFU7ynQ2tpfbQVVJzKA0dA==
X-Microsoft-Antispam-PRVS: <BY2PR15MB016721C8371384D3A5A74267BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(5660300001)(53546011)(52396003)(25786009)(52116002)(6246003)(58126008)(68736007)(16586007)(316002)(7696005)(53936002)(229853002)(76176011)(55016002)(9686003)(50466002)(33656002)(386003)(6506007)(4326008)(11346002)(6916009)(1076002)(23726003)(305945005)(476003)(6116002)(486006)(6666003)(7736002)(478600001)(8676002)(97736004)(446003)(2906002)(186003)(46003)(86362001)(8936002)(47776003)(81166006)(16526019)(14444005)(81156014)(105586002)(106356001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:CxxYTQibyXbtBye16ZZz6n0FPFFCpIc3z0lfO3mlU?=
 =?us-ascii?Q?xSAqpoE45T4e6vMEM4FDGNSNfBK+BWfQ4bW99iJOWWEO59AlCmr3tcD64XbP?=
 =?us-ascii?Q?pi3w32r5rBd0vGqj8fXDMHYEf5nCJ+KRaZSGaulBhDvSWCXZCk+5h6XjKQ/4?=
 =?us-ascii?Q?kbe/lrl72FuyX3Dx7cYd0BLKnktYkFnDLt64r554l85sMsfr1YLy8LpxmTiN?=
 =?us-ascii?Q?vw2YhvT9Tty/3tR4vez3QXpCCVFDHWwDIFrm6Z2b3pmfUueSsfmPYn0qzOhv?=
 =?us-ascii?Q?v1LmkTGkyC4lGmf/XhLjBGOGyti5OCcoHpJdyC72Oh1BvxQNHtmOvoaPqnOP?=
 =?us-ascii?Q?zL3U4epmijtCSgBGpL6sCDvb2Qcry5betwkiuwCnsImnjTqQjLqggnMlTG2o?=
 =?us-ascii?Q?oQLU5eZicDjx6th0yekHC41ym9Vi8f2oCdAWsurZb0OEsXf+ruCGF2oDO7L3?=
 =?us-ascii?Q?+x3pjN4rN4SwOUJYpaX9bNQ+UHSeFjTxCPbxP/KCURyKwvK4yvIbyc9POtpv?=
 =?us-ascii?Q?WwdMvzPI4znOJ+y7SM3Qek4nJ3CGu7TnJRzZKSHbl5ScZU54FRMya3SZpNJT?=
 =?us-ascii?Q?QYiKV3dvnvT894AqTn/9MSoSeFunq+R0lcSE4RM/INQs9mb+hok5iskKyOwb?=
 =?us-ascii?Q?lykesn63jCBfBVTFDGCrP+A0kR79tkl3q15DXBptXQg08vATbyzcPL+lUr6H?=
 =?us-ascii?Q?enuUfvNifhoQ13NfPbbOeW+Y0YfKFNx8/0Bzh7xY+s7Ha6HuBDnwlW1qJJpy?=
 =?us-ascii?Q?8ixLXUFlbuSC7MWSbxJu+saZGIhXmDvHgrCosgyZjJz0qGL/c8mSf4jBPT0T?=
 =?us-ascii?Q?j0S4ga59L+2Qwq/JuBPCc8oEqLLeSJJpF0om0LJg0DI5Kb2IwDW/MK1/Uaw2?=
 =?us-ascii?Q?O/GIk19R4HMh6o8RdAtLUI8+NA4uA/Q477UnGKioKvKL1xHuFdh0GV3StATc?=
 =?us-ascii?Q?OvEyyxfPZv8NYQOEE4LKtYOs4aYNRX9FKk47DWqqIUJKdJfjXy3vOfu2iKNf?=
 =?us-ascii?Q?IQHC/gmXjOsE/1hnQo0HVtG0Jbw/qQ/3c58vP86Sa7Z/RkioaI9pCaK78OOy?=
 =?us-ascii?Q?3xqY9CuyMDpobZncn9cPjo7bsWlQK50iIvUQ1n8idJkHshf/KNXDlQFUwlm6?=
 =?us-ascii?Q?vVgte3SDdvT+DY1Axx36jhbhDgcwMnZcecW8qgxH9d6lgky7i51PBpRrDLmz?=
 =?us-ascii?Q?Jli03tgRre7n5J6LyJsE2nhjWzHdwZkA+pWWnwno3l50rpOJMISOL8qTfBqz?=
 =?us-ascii?Q?MHsKqluFDcpQXIHXbaKLe8q55LidiMw0Men65O9?=
X-Microsoft-Antispam-Message-Info: J3heqeG1V7KQgAvRTEGJw7O4eZlw6EFX3n85+cqMsuwYsSWkn1CrCuWIwsjkE4ZcBhnEvOdKae9Pu3a3YSOiS8rxLeHUiC9VM7DlowaFnkEoUQjAfUDryDNUj3rkZpPRpNwAoPN439XQJddZFLcVO9t0dcuimj+KJVLTD0eOEGUqIvSPsB88I5lAkYjerMBMfaiOhzD103eZ8I8uo+UG1siNpHYhmdynERIDKaIeHiv+IggY46a9ohEhUm+sBGAnSXkO6ODdr0n3wbo9bOo0Ip479UJxzE9tzGFglXxVT62Agjdg+IaQSkgET9ZVtCra9nPSgAG6OcliK8ZbzhhEAkPSL/R+oJOdDJQHZeg4yz8=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:CHX0il0OZq4X531o3NWf/9sfC9Vf35B8RitBHqU+GRb4V0dlylVJPLx7e+84bYYkUH20sJb8V58yl34QlLKYrdzxes9IyNBb+5oHYrF7tVrMllZ9DkxUwDpLdw0fEGWZeVl1grELmJx67BaAChflAQYmzv7xEVfuYYQNvpkVh9utmuqOMhiSIv7OefOGyhRqX2DLWkjPqUC66f6jjs1XFEcPxg8LJtRRJ2CMTF5kdiePfwdhHJ/GaaHohUq3hHwmRGH9v3LOGUoiX/1JYAEDtGq/mXQ1mY9OL86cQb8Lr1qN8/A3n9bp6w7SAP83aRK8lmVsBvGcw1CuTmL/b5Kz9S/sVgy8JjpVleNlEcukD3cb0M3cN5MEZwIEQ6UjPDUHIx4wwO64FnaqSfvgdRESUuxZqUbhy3B2b7qg6ZkDl+Xxna7YNpEQHQehyMrPuzbV4cBPunLN+ZzeSFJsSpjarw==;5:nvTCGKGbh8krWiyFxU6b0qZ+e401+0lPnSgL2/RrXrreP3rCoKF/tRbTGtc7X21tjNqBIN4DXgJqd6G3UKSdPVPVJbqJYAbewKUiVagBZ0HO+KbHhMwAB4XLqTnBLXOj/sqcL+h4yLU909MSSPLN9wiZ8mH2VGw24eEuW+hdL5g=;7:EnIswKSLiiI7BrdxcGkQ0Z6kXciP47/JDPCFlLPi0qAum5QbukLBVs4lHUK+/cuyDWP4K3rTrJ+IXYgCHkIBaEjoDwV5YfYg2/TBvcYvr8q9hJ7ThwQYtLxIH8m35ek1FbNdcQOQPYEz/NJsyiqpGMWMaNsBCCoMet21kjZtz+rfs2kUu88+LiJoYT2z8zwrc6myIvJtPD+xw7742mgOQP/17/D4swBV9f13oNfoDzuPXiQ0E3ToOgZemL1X3GZG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:SmITzADDylRfwafoeIX/N9UNMPpDCDCiJMqZBsxYM8OpPp8jOpD9uS5ij6oARMpcY9RISPDq+yibD/Z4WX/HL3oBLJ7nGiWbMBJbtbXTR1lB89STxMB/rsvrgENxvCMKauDlfC45yvHqj8nJoEj9qmCRGQB8yGmwgU++z7/daQ8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 00:28:40.7366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb097fb-8ea6-4ef5-75d0-08d5f745bb83
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 12:50:16AM +0200, Daniel Borkmann wrote:
> On 07/27/2018 11:52 PM, Roman Gushchin wrote:
> [...]
> > @@ -2533,6 +2541,16 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
> >  	}
> >  
> >  	regs = cur_regs(env);
> > +
> > +	/* check that flags argument in get_local_storage(map, flags) is 0,
> > +	 * this is required because get_local_storage() can't return an error.
> > +	 */
> > +	if (func_id == BPF_FUNC_get_local_storage &&
> > +	    !tnum_equals_const(regs[BPF_REG_2].var_off, 0)) {
> > +		verbose(env, "get_local_storage() doesn't support non-zero flags\n");
> > +		return -EINVAL;
> > +	}
> 
> Hmm, this check is actually not correct. You will still be able to pass non-zero
> values in there. arg2_type from the helper is ARG_ANYTHING, so the register type
> could for example be one of the pointer types and it will still pass the verifier.
> The correct way to check would be to use register_is_null().
> 
> > +
> >  	/* reset caller saved regs */
> >  	for (i = 0; i < CALLER_SAVED_REGS; i++) {
> >  		mark_reg_not_init(env, regs, caller_saved[i]);

Oh, perfect catch!
The diff is below. Please, let me know if you prefer me to resend
the whole patch/patchset.

Thank you!

Roman

--

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f69f827ff9f..4547e07ab3db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2546,7 +2546,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
         * this is required because get_local_storage() can't return an error.
         */
        if (func_id == BPF_FUNC_get_local_storage &&
-           !tnum_equals_const(regs[BPF_REG_2].var_off, 0)) {
+           !register_is_null(&regs[BPF_REG_2])) {
                verbose(env, "get_local_storage() doesn't support non-zero flags\n");
                return -EINVAL;
        }
