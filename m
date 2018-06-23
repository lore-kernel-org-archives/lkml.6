Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67862C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E65D24B95
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 09:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E65D24B95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeFWJpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 05:45:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751782AbeFWJpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 05:45:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5N9iCG1130275
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 05:45:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jsjbxj6sj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 05:45:38 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sebott@linux.ibm.com>;
        Sat, 23 Jun 2018 10:45:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 23 Jun 2018 10:45:33 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5N9jWRl28836068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 23 Jun 2018 09:45:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9DDB4C04E;
        Sat, 23 Jun 2018 10:45:29 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38BA74C040;
        Sat, 23 Jun 2018 10:45:29 +0100 (BST)
Received: from icon-9-164-182-229.megacenter.de.ibm.com (unknown [9.164.182.229])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 23 Jun 2018 10:45:29 +0100 (BST)
Date:   Sat, 23 Jun 2018 11:45:30 +0200 (CEST)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To:     Daniel Borkmann <daniel@iogearbox.net>
cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: panic with 9facc33687 "bpf: reject any prog that failed read-only
 lock"
In-Reply-To: <a85dd2e0-0063-f94f-8afa-1c3e3e9309de@iogearbox.net>
References: <alpine.LFD.2.21.1806231116400.1746@schleppi> <a85dd2e0-0063-f94f-8afa-1c3e3e9309de@iogearbox.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18062309-4275-0000-0000-0000029102A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062309-4276-0000-0000-000037985837
Message-Id: <alpine.LFD.2.21.1806231144260.1746@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=741 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806230119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018, Daniel Borkmann wrote:
> On 06/23/2018 11:23 AM, Sebastian Ott wrote:
> > With commit 9facc33687 ("bpf: reject any prog that failed read-only lock")
> > s390 panics:
> 
> Sorry about that, this is fixed by:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=9262478220eac908ae6e168c3df2c453c87e2da3

That one helped. Thanks!

Sebastian

