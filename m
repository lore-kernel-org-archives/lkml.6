Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01F6C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FB520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FB520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=supermicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeGZUjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:39:39 -0400
Received: from mga.supermicro.com ([207.212.57.84]:39512 "EHLO
        mga.supermicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbeGZUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:39:39 -0400
Received: from pps.filterd (MGA.supermicro.com [127.0.0.1])
        by MGA.supermicro.com (8.16.0.22/8.16.0.22) with SMTP id w6QJLN7x025258;
        Thu, 26 Jul 2018 12:21:23 -0700
Received: from ex2013-mbx1.supermicro.com ([10.2.1.36])
        by MGA.supermicro.com with ESMTP id 2kc4esa19c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Jul 2018 12:21:23 -0700
Received: from [172.16.95.100] (10.2.0.41) by EX2013-MBX1.supermicro.com
 (10.2.1.36) with Microsoft SMTP Server (TLS) id 15.0.1236.3; Thu, 26 Jul 2018
 12:20:26 -0700
Subject: Re: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
From:   patrickg <patrickg@supermicro.com>
To:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "Du, Alek" <alek.du@intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Tang, Feng" <feng.tang@intel.com>
References: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
 <1A7043D5F58CCB44A599DFD55ED4C94849A1AACF@FMSMSX126.amr.corp.intel.com>
 <c7582a8c-8cc1-eff3-2452-a8d42d23fea1@supermicro.com>
 <cb798dcd-8cd6-8a92-9f6c-50bec0afe204@supermicro.com>
Message-ID: <94bebaa1-992b-572b-0d24-e08037611358@supermicro.com>
Date:   Thu, 26 Jul 2018 12:21:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cb798dcd-8cd6-8a92-9f6c-50bec0afe204@supermicro.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.2.0.41]
X-ClientProxiedBy: EX2013-CA1.supermicro.com (10.2.1.31) To
 EX2013-MBX1.supermicro.com (10.2.1.36)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=589
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tsc_khz still zero with production CPU's, so it's reassigning tsc_khz to the cpuid-acquired cpu_khz value.
