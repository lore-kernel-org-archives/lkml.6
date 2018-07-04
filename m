Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9DF21917
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9DF21917
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934773AbeGDMiV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:38:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934587AbeGDMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:37:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64CXWeF096474
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 08:37:54 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0utephwm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:37:53 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Wed, 4 Jul 2018 13:37:50 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 13:37:47 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64CbjRr39321788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 12:37:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B8B411C05B;
        Wed,  4 Jul 2018 15:38:10 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E3911C04A;
        Wed,  4 Jul 2018 15:38:09 +0100 (BST)
Received: from [9.124.31.156] (unknown [9.124.31.156])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 15:38:09 +0100 (BST)
Subject: Re: [lkp-robot] [perf tests] 32a4debc7c:
 perf-sanity-tests.probe_libc's_inet_pton_&_backtrace_it_with_ping.fail
To:     kernel test robot <xiaolong.ye@intel.com>
Cc:     acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        tmricht@linux.ibm.com, lkp@01.org
References: <20180704065721.GF23907@yexl-desktop>
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Wed, 4 Jul 2018 18:07:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180704065721.GF23907@yexl-desktop>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070412-0012-0000-0000-00000286AF34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070412-0013-0000-0000-000020B83236
Message-Id: <3a9f820a-46b7-ad80-0ac7-5679bb0f3267@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaolong,

On 07/04/2018 12:27 PM, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f ("[PATCH] perf tests: Fix regex for record+probe_libc_inet_pton.sh")
> url: https://github.com/0day-ci/linux/commits/Sandipan-Das/perf-tests-Fix-regex-for-record-probe_libc_inet_pton-sh/20180521-130408
> 
> 
> in testcase: perf-sanity-tests
> with following parameters:
> 
> 	perf_compiler: gcc
> 
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu kvm64,+ssse3 -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 2018-05-22 17:41:14 sudo /usr/src/linux-perf-x86_64-fedora-25-32a4debc7c89ee5e29c0bbdfdd3ae0ce0e01057f/tools/perf/perf test 62
> 62: probe libc's inet_pton & backtrace it with ping       : FAILED!
> 
> 

This patch has the following dependencies which seem to be missing from your source tree.

7903a7086723 ("perf script: Show symbol offsets by default")
19610184693c ("perf script: Show virtual addresses instead of offsets")

Output without these patches:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 10323
  ping 10340 [001] 888647.764907: probe_libc:inet_pton: (7fe66cbc2220)
  132220 __GI___inet_pton (/usr/lib64/libc-2.25.so)
  FAIL: expected backtrace entry 1 ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc-2.25.so|inlined\)$" got "132220 __GI___inet_pton (/usr/lib64/libc-2.25.so)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!


Output with these patches:

  62: probe libc's inet_pton & backtrace it with ping       :
  --- start ---
  test child forked, pid 13155
  ping 13172 [000] 888783.582767: probe_libc:inet_pton: (7f2afe5ce220)
  7f2afe5ce220 __GI___inet_pton+0x0 (/usr/lib64/libc-2.25.so)
  7f2afe593ebd getaddrinfo+0x11d (/usr/lib64/libc-2.25.so)
  55b725fd8c71 main+0x891 (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok


--
With Regards,
Sandipan

