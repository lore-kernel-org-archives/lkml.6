Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeBBJdx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:33:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751788AbeBBJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:32:59 -0500
Subject: Re: [RFC] mm/migrate: Consolidate page allocation helper functions
To: Hugh Dickins <hughd@google.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <20180130050642.19834-1-khandual@linux.vnet.ibm.com>
 <20180130143635.GF21609@dhcp22.suse.cz>
 <53cf5454-405b-a812-1389-af4fd7527122@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1801302000200.8014@eggly.anvils>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 2 Feb 2018 15:02:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1801302000200.8014@eggly.anvils>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020209-0040-0000-0000-0000042BB65E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020209-0041-0000-0000-000020CF5A74
Message-Id: <2fe9bab9-d35d-e3fe-418a-41ab8f981ce8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020114
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 09:56 AM, Hugh Dickins wrote:
> On Wed, 31 Jan 2018, Anshuman Khandual wrote:
>> On 01/30/2018 08:06 PM, Michal Hocko wrote:
>>> On Tue 30-01-18 10:36:42, Anshuman Khandual wrote:
>>>> Allocation helper functions for migrate_pages() remmain scattered with
>>>> similar names making them really confusing. Rename these functions based
>>>> on the context for the migration and move them all into common migration
>>>> header. Functionality remains unchanged.
> 
> I agree that their names could be made less confusing (though didn't
> succeed very well when I tried); and maybe a couple of them are general
> enough to be used from more than one callsite, and could well live in
> mm/migrate.c.
> 
> But moving all of page migration's (currently static) new_page allocator
> functions away from the code that relies on their special characteristics
> (probably relayed to them through a private argument), and into a single
> header file, just seems perverse to me.  And likely to be a nuisance when
> adding more in future: private structures having to be made public just
> to make them visible in that shared header file.
> 
> Would it make sense to keep the various functions that may be called by
> rmap_walk() together in one rmap_walk.h?  The different filesystems'
> writepage methods together in one writepage.h?  I don't think so.

Makes sense. Will probably just change the helper names to something
more meaningful (from previous suggestions in this thread) next around.
