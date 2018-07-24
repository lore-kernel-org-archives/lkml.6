Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768CFECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2457220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2457220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbeGXOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:41:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388321AbeGXOlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:41:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ODTSl3048653
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:35:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ke3r5vh70-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:35:10 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 24 Jul 2018 14:35:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 14:35:03 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6ODZ27K42991762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 13:35:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B8134C05E;
        Tue, 24 Jul 2018 16:35:18 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9912C4C040;
        Tue, 24 Jul 2018 16:35:16 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.84.53])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 16:35:16 +0100 (BST)
Subject: Re: [PATCH 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Udit Agarwal <udit.agarwal@nxp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Sahil Malhotra <sahil.malhotra@nxp.com>,
        Ruchika Gupta <ruchika.gupta@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Date:   Tue, 24 Jul 2018 09:34:50 -0400
In-Reply-To: <AM5PR0401MB2660B8C1DD5ED9989239EF009E550@AM5PR0401MB2660.eurprd04.prod.outlook.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
         <1532302451.6206.22.camel@linux.ibm.com>
         <AM5PR0401MB2660B8C1DD5ED9989239EF009E550@AM5PR0401MB2660.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072413-0020-0000-0000-000002AA7AED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072413-0021-0000-0000-000020F70D76
Message-Id: <1532439290.3277.52.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-24 at 12:31 +0000, Udit Agarwal wrote:
> Yes the secure keys and CAAM are correlated. Secure keys depends on
> NXP CAAM crypto HW accelerator.  Secure key is a random data of
> length X (passed using keyctl command) & derived using CAAM. Blob of
> this data is also created using CAAM. Only blob is visible to user
> space.

The term "secure keys" is really generic.  What makes the "secure
keys" secure?  We introduced "trusted keys", because TPM 1.2 didn't
support symmetric keys.  We shouldn't just duplicate "trusted keys"
for different HW, but improve upon it (eg. symmetric keys never leave
the device).

The new key type should define generic methods, which are implemented
for NXP CAAM rypto HW accelerator as an example.

Mimi

