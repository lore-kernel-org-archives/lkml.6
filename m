Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D199C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A8E215F1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yOPfwluk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A8E215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeHGXYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:24:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55404 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGXYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:24:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w77KwqYS019096;
        Tue, 7 Aug 2018 21:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dJyam29PDDE6QitvWGmyy6aSietkx742fIB5ZI2T0FA=;
 b=yOPfwluk/19TwVY0p+g5plCW7CvBB3SV7w/oU3+/KEh8Qpx4yufGVAm2uXlNmKCC8loN
 cBXuJ9rTuNJYCCiJAI9VaGlRHsily2ftseEmYnFngtpk9Ig0gPVeKFRE4+/0D/ObnEee
 A9HiYYOqjZVPy6a6SBgAfluhXI6/Gx4zPvjWjlq9iflfnIjxGZ0++uyP6CDcfprNSSiI
 vZSiZFI+lmpwAZROfGkEU0QcJkQrZpRNDJQycZwlL5cpYsSWg7tc6zaGfrDUJ/ENOVU+
 zBOiit3dL8tdKplwzzvR7N++LjbifC/wrMx80JHCMI6G5SnP/5uXdYMbw33jWKfdps5e HQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2kn1nd3cuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Aug 2018 21:07:55 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w77L7rUe031852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Aug 2018 21:07:54 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w77L7riK006215;
        Tue, 7 Aug 2018 21:07:53 GMT
Received: from oracle.com (/10.154.176.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Aug 2018 14:07:53 -0700
Date:   Tue, 7 Aug 2018 17:07:54 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     syzbot <syzbot+52140d69ac6dc6b927a9@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in rds_wake_sk_sleep
Message-ID: <20180807210754.GE23593@oracle.com>
References: <000000000000fb5cd90572de7ebd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fb5cd90572de7ebd@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8978 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=566
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808070211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/07/18 13:47), syzbot wrote:
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&rm->m_rs_lock)->rlock);
>                                lock(&rs->rs_recv_lock);
>                                lock(&(&rm->m_rs_lock)->rlock);
>   lock(&rs->rs_recv_lock);
> 
>  *** DEADLOCK ***

looks like a valid find, I think the deadlock should be avoided
by having rds_clear_recv_queue do something like

 get rs_recv_lock
 un-tether the rs_recv_queue into a temporary list 
 releease rs_recv_lock
 purge the rds_incoming  temporary list

I can give this a shot later this week.

--Sowmini
