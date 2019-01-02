Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151F0C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C89218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RqbKQ7nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfABQya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:54:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60068 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfABQy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:54:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02GmvBI070945;
        Wed, 2 Jan 2019 16:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=/ypah8wJvDvd6wm0z/IV+9XsHXGEoTAmaF/xx1029j0=;
 b=RqbKQ7nP7SR2gqW45H8h8O5NFSXMm1za9oezSnCLbEev8WzmcwHAWt3torTggun6XVH7
 6tpJ778QG2C07aes9iHSFpAy20kFuZaY7hEe2r8JqTUmOl3w7bqzSgb3wZu1wrFMqqeg
 lWBUa5YAiR5uRYMy7VXbJBILp8UzR7O+nhGTjvjOU6vaZiF5TmTbL57pNOcgG5LTSPKU
 ZwOYqlkOgpwezkjkoF7E3Njb9fA3AWSXIOK7HSsXn16+m2fiKMyM2eDUPGNifdWPV/iN
 vPbGP09e5EQ/aNtuLuypERyEHXb/IkVRk/r5IjTRoHDgNnfltkT8kbi5EAbBfTwf2P7U +Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2pnxee35qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 16:54:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x02GsBWP006289
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 16:54:11 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x02Gs9Ki026431;
        Wed, 2 Jan 2019 16:54:09 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 08:54:09 -0800
Subject: Re: [LKP] [hugetlbfs] 9c83282117: vm-scalability.throughput -4.3%
 regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, lkp@01.org
References: <20181228142608.GA17624@shao2-debian>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <21117eab-862e-562b-0c86-ec2ccc1f68e4@oracle.com>
Date:   Wed, 2 Jan 2019 08:54:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181228142608.GA17624@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9124 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=917
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/18 6:26 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -4.3% regression of vm-scalability.throughput due to commit:
> 
> 
> commit: 9c83282117778856d647ffc461c4aede2abb6742 ("[PATCH v3 1/2] hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization")
> url: https://github.com/0day-ci/linux/commits/Mike-Kravetz/hugetlbfs-use-i_mmap_rwsem-for-better-synchronization/20181223-095226
> 
> 
> in testcase: vm-scalability
> on test machine: 104 threads Intel(R) Xeon(R) Platinum 8170 CPU @ 2.10GHz with 64G memory
> with following parameters:
> 
> 	runtime: 300s
> 	size: 8T
> 	test: anon-cow-seq-hugetlb
> 	cpufreq_governor: performance
> 	ucode: 0x200004d

I'll take a closer look.

The patch does introduce longer i_mmap_rwsem hold times for the sake of
correctness.  Need to more fully understand the test and results to determine
if this is expected.

-- 
Mike Kravetz
