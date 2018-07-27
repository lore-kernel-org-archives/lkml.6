Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87B1208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87B1208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbeG0Sz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728713AbeG0Sz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RHNwLC025296
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 13:33:04 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kg77fswdk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 13:33:04 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jallen@linux.ibm.com>;
        Fri, 27 Jul 2018 11:33:03 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 11:33:00 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6RHWxL459310294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 10:33:00 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5093BE06A;
        Fri, 27 Jul 2018 11:32:59 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C491EBE05F;
        Fri, 27 Jul 2018 11:32:59 -0600 (MDT)
Received: from localhost (unknown [9.41.92.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 11:32:59 -0600 (MDT)
Date:   Fri, 27 Jul 2018 12:32:59 -0500
From:   John Allen <jallen@linux.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kamezawa.hiroyu@jp.fujitsu.com, n-horiguchi@ah.jp.nec.com,
        mgorman@suse.de, nfont@linux.vnet.ibm.com
Subject: Re: Infinite looping observed in __offline_pages
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180725200336.GP28386@dhcp22.suse.cz>
User-Agent: NeoMutt/20180622-63-e52393
X-TM-AS-GCONF: 00
x-cbid: 18072717-0036-0000-0000-00000A15C94F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009439; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066959; UDB=6.00548217; IPR=6.00844823;
 MB=3.00022356; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 17:33:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072717-0037-0000-0000-0000484098E5
Message-Id: <20180727173259.htdxpn4i2fxprpaj@p50.austin.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=745 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 10:03:36PM +0200, Michal Hocko wrote:
>On Wed 25-07-18 13:11:15, John Allen wrote:
>[...]
>> Does a failure in do_migrate_range indicate that the range is unmigratable
>> and the loop in __offline_pages should terminate and goto failed_removal? Or
>> should we allow a certain number of retrys before we
>> give up on migrating the range?
>
>Unfortunatelly not. Migration code doesn't tell a difference between
>ephemeral and permanent failures. We are relying on
>start_isolate_page_range to tell us this. So the question is, what kind
>of page is not migratable and for what reason.
>
>Are you able to add some debugging to give us more information. The
>current debugging code in the hotplug/migration sucks...

After reproducing the problem a couple times, it seems that it can occur 
for different types of pages. Running page-types on the offending page 
over two separate instances produced the following:

# tools/vm/page-types -a 307968-308224
             flags	page-count       MB  symbolic-flags			long-symbolic-flags
0x0000000000000400	         1        0  __________B________________________________	buddy
	     total	         1        0

And the following on a separate run:

# tools/vm/page-types -a 313088-313344
             flags	page-count       MB  symbolic-flags			long-symbolic-flags
0x000000000000006c	         1        0  __RU_lA____________________________________	referenced,uptodate,lru,active
             total	         1        0

The source of the failure in migrate_pages actually doesn't seem to be 
that we're hitting the case of the permanent failure, but instead the 
-EAGAIN case. I traced the EAGAIN return back to 
migrate_page_move_mapping which I've seen return EAGAIN in two places:

mm/migrate.c:453
	if (!mapping) {
		/* Anonymous page without mapping */
		if (page_count(page) != expected_count)
                        return -EAGAIN;

mm/migrate.c:476
	if (page_count(page) != expected_count ||
                radix_tree_deref_slot_protected(pslot,
                                        &mapping->i_pages.xa_lock) != page) {
                xa_unlock_irq(&mapping->i_pages);
                return -EAGAIN;
	}

So it seems in each case, the actual reference count for the page is not 
what it is expected to be.

