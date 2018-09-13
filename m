Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59058FC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6552086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a1/L/Miw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6552086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeINDos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:44:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45286 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeINDor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:44:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8DMTqY5102328;
        Thu, 13 Sep 2018 22:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 references : to : cc : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kUHhMLrexydgspIrCsIZbD9E1DzJgge6Gm0siA7CP+A=;
 b=a1/L/MiwMnD7/eacNglAT5G7rNPsYHhman5+OvqbU/AB9qPglG4DF2hAbH2Db8qrfGH0
 ieZekF4UxE/3bvn2GX00u0Jw7NsoJHjVomurKgvSkgOxRLi9ivQ1Gn38W0m34EGVDQwY
 Qu/r5Wp1jbeNAFMG1IpLnx9H4naOw6QrSFHVqUaAh215MgQYuOUyXhtVMcn8DlutlUEn
 0anQzXxfL7t0pbPrkFEMLw4//sCKGOXChc7lTpbMxbQYs7UaGY1Wqi+tJPaCCqpiiAzb
 RBlyC0yKre9f7TrM4vc/QUU2NCHe9cGrZOCxsJZpteFXUjkKAoIQTRjFW8XkLxTK6aGQ iQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mc72r3yqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Sep 2018 22:33:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8DMXAmY031889
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Sep 2018 22:33:10 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8DMX8fl008158;
        Thu, 13 Sep 2018 22:33:08 GMT
Received: from [10.132.93.61] (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Sep 2018 15:33:08 -0700
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [PATCH V2 0/6] VA to numa node information
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
 <20180913084011.GC20287@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com, steven.sistare@oracle.com
From:   "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
Date:   Thu, 13 Sep 2018 15:32:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180913084011.GC20287@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809130222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/13/2018 01:40 AM, Michal Hocko wrote:
> On Wed 12-09-18 13:23:58, Prakash Sangappa wrote:
>> For analysis purpose it is useful to have numa node information
>> corresponding mapped virtual address ranges of a process. Currently,
>> the file /proc/<pid>/numa_maps provides list of numa nodes from where pages
>> are allocated per VMA of a process. This is not useful if an user needs to
>> determine which numa node the mapped pages are allocated from for a
>> particular address range. It would have helped if the numa node information
>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>> exact numa node from where the pages have been allocated.
>>
>> The format of /proc/<pid>/numa_maps file content is dependent on
>> /proc/<pid>/maps file content as mentioned in the manpage. i.e one line
>> entry for every VMA corresponding to entries in /proc/<pids>/maps file.
>> Therefore changing the output of /proc/<pid>/numa_maps may not be possible.
>>
>> This patch set introduces the file /proc/<pid>/numa_vamaps which
>> will provide proper break down of VA ranges by numa node id from where the
>> mapped pages are allocated. For Address ranges not having any pages mapped,
>> a '-' is printed instead of numa node id.
>>
>> Includes support to lseek, allowing seeking to a specific process Virtual
>> address(VA) starting from where the address range to numa node information
>> can to be read from this file.
>>
>> The new file /proc/<pid>/numa_vamaps will be governed by ptrace access
>> mode PTRACE_MODE_READ_REALCREDS.
>>
>> See following for previous discussion about this proposal
>>
>> https://marc.info/?t=152524073400001&r=1&w=2
> It would be really great to give a short summary of the previous
> discussion. E.g. why do we need a proc interface in the first place when
> we already have an API to query for the information you are proposing to
> export [1]
>
> [1] http://lkml.kernel.org/r/20180503085741.GD4535@dhcp22.suse.cz

The proc interface provides an efficient way to export address range
to numa node id mapping information compared to using the API.
For example, for sparsely populated mappings, if a VMA has large portions
not have any physical pages mapped, the page walk done thru the /proc file
interface can skip over non existent PMDs / ptes. Whereas using the
API the application would have to scan the entire VMA in page size units.

Also, VMAs having THP pages can have a mix of 4k pages and hugepages.
The page walks would be efficient in scanning and determining if it is
a THP huge page and step over it. Whereas using the API, the application
would not know what page size mapping is used for a given VA and so would
have to again scan the VMA in units of 4k page size.

If this sounds reasonable, I can add it to the commit / patch description.

-Prakash.





