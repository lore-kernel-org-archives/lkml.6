Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8490CC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520002082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520002082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeKBB1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:27:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728790AbeKBB1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:27:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1GIsrc067522
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 12:23:26 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ng47st77n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:23:26 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 1 Nov 2018 16:23:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 16:23:21 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1GNKjl1769958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 16:23:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A103F11C054;
        Thu,  1 Nov 2018 16:23:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6C4A11C04A;
        Thu,  1 Nov 2018 16:23:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.26])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 16:23:19 +0000 (GMT)
Subject: Re: [PATCH v3 4/5] tpm: retrieve digest size of unknown algorithms
 with PCR read
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 01 Nov 2018 12:23:09 -0400
In-Reply-To: <1541088173.4035.26.camel@linux.ibm.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
         <20181030154711.2782-5-roberto.sassu@huawei.com>
         <1541088173.4035.26.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18110116-0012-0000-0000-000002C1BC54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110116-0013-0000-0000-000020F5EE46
Message-Id: <1541089389.4035.34.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-01 at 12:02 -0400, Mimi Zohar wrote:
> On Tue, 2018-10-30 at 16:47 +0100, Roberto Sassu wrote:

 
> > +static int tpm2_init_bank_info(struct tpm_chip *chip,
> > +			       struct tpm_bank_info *bank)
> > +{
> > +	struct tpm_digest digest = {.alg_id = bank->alg_id};
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> > +		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
> > +
> > +		if (bank->alg_id != tpm2_hash_map[i].tpm_id)
> > +			continue;
> > +
> > +		bank->digest_size = hash_digest_size[crypto_algo];
> > +		bank->crypto_id = crypto_algo;
> > +		return 0;
> > +	}
> > +
> > +	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);

Somewhere there needs to be a check to verify that the returned digest
size is equal to or less than the maximum digest size defined in
tpm_digest structure.

Mimi

