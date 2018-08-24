Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7808BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F55C208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F55C208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHXVwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:52:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726535AbeHXVwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:52:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OIEFcS034240
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 14:16:39 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m2p9rj0du-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 14:16:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Fri, 24 Aug 2018 19:16:37 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 19:16:33 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7OIGUgF37224672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 18:16:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 334A552051;
        Fri, 24 Aug 2018 21:16:29 +0100 (BST)
Received: from ram.oc3035372033.ibm.com (unknown [9.80.218.12])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 7DA3B52059;
        Fri, 24 Aug 2018 21:16:26 +0100 (BST)
Date:   Fri, 24 Aug 2018 11:16:24 -0700
From:   Ram Pai <linuxram@us.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 00/11] Secure Virtual Machine Enablement
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
 <20180824163330.GA15438@lst.de>
MIME-Version: 1.0
In-Reply-To: <20180824163330.GA15438@lst.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18082418-0020-0000-0000-000002BB51AB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082418-0021-0000-0000-00002108B41F
Message-Id: <20180824181624.GM5905@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 06:33:30PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 24, 2018 at 01:25:24PM -0300, Thiago Jung Bauermann wrote:
> > [ Some people didn't receive all the patches in this series, even though
> >   the linuxppc-dev list did so trying to send again. This is exactly the
> >   same series I posted yesterday. Sorry for the clutter. ]
> 
> I'm still only getting six of the patches.

We are all receving the entire series.  And I see that the mails have
also landed on the mailing lists.  Some filter on your side
is dropping the mails?

-- 
Ram Pai

