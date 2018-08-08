Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDDDC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151C721700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K52nNDP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151C721700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeHHLpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:45:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57140 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeHHLpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:45:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w789NvZi098337;
        Wed, 8 Aug 2018 09:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=LRlPYFctom86ObOq5zLtrx8ZNfLhMFRyEj42E3Kme80=;
 b=K52nNDP/rZmmaoMelquP0d212afZ1SvVQeQT8bG/EiTJZmS1kUCu3XiKaIXw7FKIvxD4
 +KyKRYbv7YJiDzlJmSp7yxv3e+qSyYBpIBH57c6n8VhL5k3P6YPxfSdKV/2+4DsqLWad
 EUSbvicM0E/tB1MlEjnRkTMLHTv9h53LSsdTIcvQB5BTSVm4ufisEyoB3PR6XYNM0AfS
 ZGox0f6OkAxepOpL8TKEPSFg31e1N6BWP2SO6jiStXazy/VmlJiYN5PKJCn3ADmS0A4p
 Q70LBFuWW39YJ5K1g/j+W5ueNZdt3jLpJUUBxI/R1U6VfVzP0fjMdRawaeJAuMUf/Kon 4Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kn4spvxw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 09:26:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w789Qr33026015
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 09:26:53 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w789Qqfd028350;
        Wed, 8 Aug 2018 09:26:52 GMT
Received: from oracle.com (/10.154.176.211)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 02:26:51 -0700
Date:   Wed, 8 Aug 2018 05:26:52 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     syzbot <syzbot+c6369755db236fb370e7@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in __rhashtable_lookup
Message-ID: <20180808092652.GB15195@oracle.com>
References: <00000000000097dba80572e7931d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000097dba80572e7931d@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8978 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=286
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


#syz dup: KASAN: use-after-free Read in rds_find_bound

