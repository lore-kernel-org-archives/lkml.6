Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BADCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687220661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OcUAtAlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B687220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH3XeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:34:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51078 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3XeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:34:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UJSgIY034322;
        Thu, 30 Aug 2018 19:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ba0gvJdQunrL+N3Qj6D42iZOAW4kzW7CWoUnIQoKM10=;
 b=OcUAtAlILscyKRLdrFnghdUZoCLg1yBKgXZhlr+htnzoG6lN9HdhLEYTaLGIjXIEkjkQ
 XnpZH4/pS9x31Z3qN8CzeANpGaVZ6zye/m9KQnATg4LaJg2tYiX9Bbd+REJogRRWnm8i
 XkTPySOKMGMPs58pq4w2dBccsyRlZO8WrQkOkUsr3MR4XeFrBIpMaf9uxM5EUazSqTz5
 hKQvhW954oJr3XTiSk4DHTjAO8elLk4ndqX11IPpf36Fjc4meLJChETo/LMk+WS+lICa
 hiuM6+a3ElONW6MOPbUwP5OGhy3ZGsic8yKs5iXO1J7jd2JdyKcuNmZhN82WzfjkKT4l Ug== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2m2y2pxpug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 19:30:31 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7UJUTJl014728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 19:30:29 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7UJUSMf005784;
        Thu, 30 Aug 2018 19:30:28 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 12:30:28 -0700
Subject: Re: KMSAN: uninit-value in rds_connect
To:     syzbot <syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com
References: <00000000000005859b0574ab47e5@google.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <d3a92af1-cbdd-b727-bd57-6c1895e72238@oracle.com>
Date:   Thu, 30 Aug 2018 12:30:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00000000000005859b0574ab47e5@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9001 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=634
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2018 11:31 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    2dca2cbde67a kmsan: fix build warnings with CONFIG_KMSAN=n
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=1519734a400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=820d6393634b55e3
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=0049bebbf3042dbd2e8f
> compiler:       clang version 8.0.0 (trunk 339414)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com
> 
OK. Will send the fix to address this.

Regards,
Santosh
