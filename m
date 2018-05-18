Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeERQlj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:41:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39970 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeERQlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:41:36 -0400
Subject: Re: [PATCH -mm] mm, huge page: Copy to access sub-page last when copy
 huge page
To: Michal Hocko <mhocko@kernel.org>, "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andi Kleen <andi.kleen@intel.com>,
        Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>
References: <20180518030316.31019-1-ying.huang@intel.com>
 <20180518062430.GB21711@dhcp22.suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <64430ed4-4019-d597-ccb3-8bf6b04ee464@oracle.com>
Date: Fri, 18 May 2018 09:41:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180518062430.GB21711@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 11:24 PM, Michal Hocko wrote:
> On Fri 18-05-18 11:03:16, Huang, Ying wrote:
> [...]
>> The patch is a generic optimization which should benefit quite some
>> workloads, not for a specific use case.  To demonstrate the performance
>> benefit of the patch, we tested it with vm-scalability run on
>> transparent huge page.
> 
> It is also adds quite some non-intuitive code. So is this worth? Does
> any _real_ workload benefits from the change?

One way to 'add less code' would be to create a helper routine that
indicates the order in which sub-pages are to be copied.  IIUC, you
added the same algorithm for sub-page ordering to copy_huge_page()
that was previously added to clear_huge_page().  Correct?  If so,
then perhaps a common helper could be used by both the clear and copy
huge page routines.  It would also make maintenance easier.

-- 
Mike Kravetz
