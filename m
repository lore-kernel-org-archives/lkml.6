Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B81ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F5F206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0jzO73Gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F5F206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeGRAcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:32:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54344 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729805AbeGRAcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:32:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HNtrD6080973;
        Tue, 17 Jul 2018 23:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kWgMpjgAyGvsHOcSsz5YNDAwKQ9v4suG10H4i7xzeI8=;
 b=0jzO73GmYS5nOFIFq68XAKGoAv8flPdFbPeN1oGwU9dRx5GG1kRFtdgY7p/6TLkm0xsV
 m8CF43QOU4OcVraKXicNMVMNgFZMFA4X0Sp15hAsJkhdFrBGM/A2PJ/S8FoS0Jvcyq6H
 PTg1ywvmjCwbdS5exGT1iq1n2EOd0Y4Hs4JcEmuJJ6BK/t8vOhke656FWnHKYTnyu10R
 F2OjVrkZ6vkKwdzFFI/0dPtg8WOSM1B+lZFgamvgrsWi7tZiFZXe2W4LFpb0jA14m2KR
 bfUYogsvrDiZIsVEQyzmPVDqKwl+ITgvkOR68M1ugIoVyCOkTcCYoxptFlGk8Ehb9dXz jQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k7a3tavmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 23:56:56 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6HNutq3030719
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 23:56:55 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6HNusIi004135;
        Tue, 17 Jul 2018 23:56:54 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 16:56:54 -0700
Subject: Re: mmap with huge page
To:     David Frank <david_frank95@yahoo.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <115606142.5883850.1531854314452.ref@mail.yahoo.com>
 <115606142.5883850.1531854314452@mail.yahoo.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3b40325e-a75e-017d-920e-83e090153621@oracle.com>
Date:   Tue, 17 Jul 2018 16:56:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <115606142.5883850.1531854314452@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 12:05 PM, David Frank wrote:
> Hi,
> According to the instruction, I have to mount a huge directory to hugetlbfs and create file in the huge directory to use the mmap huge page feature. But the issue is that, the files in the huge directory takes up the huge pages configured through
> vm.nr_hugepages =
> 
> even the files are not used.
> 
> When the total size of the files in the huge directory = vm.nr_hugepages * huge page size, then mmap would fail with 'can not allocate memory' if the file to be  mapped is in the huge dir or the call has HUGEPAGETLB flag.
> 
> Basically, I have to move the files off of the huge directory to free up huge pages.
> 
> Am I missing anything here?
> 

No, that is working as designed.

hugetlbfs filesystems are generally pre-allocated with nr_hugepages
huge pages.  That is the upper limit of huge pages available.  You can
use overcommit/surplus pages to try and exceed the limit, but that
comes with a whole set of potential issues.

If you have not done so already, please see Documentation/vm/hugetlbpage.txt
in the kernel source tree.
-- 
Mike Kravetz
