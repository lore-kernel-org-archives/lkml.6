Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbeAaCqI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:46:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60588 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeAaCqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:46:07 -0500
Subject: Re: [RFC] mm/migrate: Add new migration reason MR_HUGETLB
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
 <20180130075949.GN21609@dhcp22.suse.cz>
 <b4bd6cda-a3b7-96dd-b634-d9b3670c1ecf@linux.vnet.ibm.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <069a5533-2689-6764-2ec5-9ef0a1351860@oracle.com>
Date: Tue, 30 Jan 2018 18:40:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <b4bd6cda-a3b7-96dd-b634-d9b3670c1ecf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=839
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310031
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 06:25 PM, Anshuman Khandual wrote:
> On 01/30/2018 01:29 PM, Michal Hocko wrote:
>> On Tue 30-01-18 08:37:14, Anshuman Khandual wrote:
>>> alloc_contig_range() initiates compaction and eventual migration for
>>> the purpose of either CMA or HugeTLB allocation. At present, reason
>>> code remains the same MR_CMA for either of those cases. Lets add a
>>> new reason code which will differentiate the purpose of migration
>>> as HugeTLB allocation instead.
>> Why do we need it?
> 
> The same reason why we have MR_CMA (maybe some other ones as well) at
> present, for reporting purpose through traces at the least. It just
> seemed like same reason code is being used for two different purpose
> of migration.
> 

I was 'thinking' that we could potentially open up alloc_contig_range()
for more general purpose use.  Users would not call alloc_contig_range
directly, but it would be wrapped in a more user friendly API.  Or,
perhaps it gets modified and becomes something else.  Still just thinking
as part of "how do we provide a more general purpose interface for
allocation of more than MAX_ORDER contiguous pages?".

Not sure that we should be adding to the current alloc_contig_range
interface until we decide it is something which will be useful long term.
-- 
Mike Kravetz
