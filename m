Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeA3FQn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 00:16:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752385AbeA3FQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 00:16:42 -0500
Subject: Re: [RFC] mm/migrate: Add new migration reason MR_HUGETLB
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 30 Jan 2018 10:46:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18013005-0040-0000-0000-0000042A4715
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013005-0041-0000-0000-000020CDDE0A
Message-Id: <7c99fbcd-bb9f-38ed-fbf1-e5481c59968c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801300067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 08:37 AM, Anshuman Khandual wrote:
> @@ -7621,8 +7622,13 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  							&cc->migratepages);
>  		cc->nr_migratepages -= nr_reclaimed;
>  
> +		if (migratetype == MIGRATE_CMA)
> +			migrate_reason = MR_CMA;
> +		else
> +			migrate_reason = MR_HUGETLB;
> +
>  		ret = migrate_pages(&cc->migratepages, new_page_alloc_contig,

Oops, this is on top of the changes from the other RFC regarding migration
helper functions.
