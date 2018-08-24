Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2DB2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mUBKkvQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2DB2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeHYClq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:41:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49198 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeHYCln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:41:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7ON488a052646;
        Fri, 24 Aug 2018 23:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YsuY/5kP+jEx7RLy9YINeQ6h0glLLrCo7MztrKqyj/s=;
 b=mUBKkvQmS6A/SPI/yJe7vhzinYENpVx1oIOYF4F2NFwzwy9Y5clQV4EfE6j2U97G+6rd
 NEk/qQqfoRD35KYFrbIfNIfx/Vg7xUAufJDUXNVLoTBRGU3vki/kdM1OnV1HX3nfOGNA
 d+A+qQu4z/p/dVAZe/J3SEj14G5tWJxIQ6FEK8p3+Z9p81GJTqRMg8Bahpa/xpxhm1Ik
 mFwWezuCPdBvvrAME7zu2uynYXN+U1BjlrYdeRhvBz7AB/lTfE3J5DnvbN+tdsbLd4Q3
 LXDAbSp6AbnOkU9RQPc2HqLY8chn+Jn0Ny1z4m/Zim9YTuxIqHyCT8yLLn23okfSuzZn Hw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kxbdqjf61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 23:04:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7ON4oEL000382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 23:04:50 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7ON4nAa021818;
        Fri, 24 Aug 2018 23:04:49 GMT
Received: from oracle.com (/10.154.122.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Aug 2018 16:04:49 -0700
Date:   Fri, 24 Aug 2018 19:04:46 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     syzbot <syzbot+8967084bcac563795dc6@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in __rhashtable_lookup (2)
Message-ID: <20180824230446.GA16891@oracle.com>
References: <00000000000027a1e605741b2afa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000027a1e605741b2afa@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8995 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=299
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



#syz dup KASAN: use-after-free Read in rds_find_bound

The problem is a missing synchronize_net() in rds_release.
References:
  https://www.spinics.net/lists/netdev/msg475074.html
  https://www.spinics.net/lists/netdev/msg507908.html
