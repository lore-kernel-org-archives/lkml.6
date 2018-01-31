Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeAaCZO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:25:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753146AbeAaCZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:25:13 -0500
Subject: Re: [RFC] mm/migrate: Add new migration reason MR_HUGETLB
To: Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
 <20180130075949.GN21609@dhcp22.suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 31 Jan 2018 07:55:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180130075949.GN21609@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18013102-0040-0000-0000-0000040AA609
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013102-0041-0000-0000-0000260E3FB0
Message-Id: <b4bd6cda-a3b7-96dd-b634-d9b3670c1ecf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801310027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 01:29 PM, Michal Hocko wrote:
> On Tue 30-01-18 08:37:14, Anshuman Khandual wrote:
>> alloc_contig_range() initiates compaction and eventual migration for
>> the purpose of either CMA or HugeTLB allocation. At present, reason
>> code remains the same MR_CMA for either of those cases. Lets add a
>> new reason code which will differentiate the purpose of migration
>> as HugeTLB allocation instead.
> Why do we need it?

The same reason why we have MR_CMA (maybe some other ones as well) at
present, for reporting purpose through traces at the least. It just
seemed like same reason code is being used for two different purpose
of migration.
