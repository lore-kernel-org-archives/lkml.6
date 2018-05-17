Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeEQOfH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:35:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37814 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbeEQOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:35:04 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [RFC] mm, THP: Map read-only text segments using large THP pages
From: William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20180517075740.GA31969@dhcp22.suse.cz>
Date: Thu, 17 May 2018 08:34:56 -0600
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-fsdevel@vger.kernel.org
Message-Id: <59D5F452-4710-4CE9-9072-E587551D4862@oracle.com>
References: <5BB682E1-DD52-4AA9-83E9-DEF091E0C709@oracle.com>
 <20180517075740.GA31969@dhcp22.suse.cz>
To: Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.8.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8895 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4HEZBWF015246



> On May 17, 2018, at 1:57 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> [CCing Kirill and fs-devel]
> 
> On Mon 14-05-18 07:12:13, William Kucharski wrote:
>> One of the downsides of THP as currently implemented is that it only supports
>> large page mappings for anonymous pages.
> 
> There is a support for shmem merged already. ext4 was next on the plan
> AFAIR but I haven't seen any patches and Kirill was busy with other
> stuff IIRC.

I couldn't find anything that would specifically map text pages with large pages,
so perhaps this could be integrated with that or I may have simply missed changes
that would ultimately provide that functionality.

> 
>> I embarked upon this prototype on the theory that it would be advantageous to 
>> be able to map large ranges of read-only text pages using THP as well.
> 
> Can the fs really support THP only for read mappings? What if those
> pages are to be shared in a writable mapping as well? In other words
> can this all work without a full THP support for a particular fs?

The integration with the page cache would indeed require filesystem support.

The end result I'd like to see is full R/W support for large THP pages; I
thought the RO text mapping proof of concept worthwhile to see what kind of
results we might see and what the thoughts of the community were.

Thanks for the feedback.

  -- Bill
