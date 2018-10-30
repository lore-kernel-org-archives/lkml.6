Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA77C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6229E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uCVnlT2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6229E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJaEdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:33:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53448 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeJaEdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:33:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UJXxZV030956;
        Tue, 30 Oct 2018 19:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=KEIjtm5bgNeDYYr0dcUriss0t4duB+ZqE6yc7CFPKUg=;
 b=uCVnlT2+c79XjTLtHaZWq9tEYBqdxYgtrZTfPTNFhmJgKaNNbeFjrFXU+ujQ+U5rP6uc
 lUFYiY8K8nkCAr1ZJqEnMsWy9kGTfIexi3LacB8QZc+UTQBSNBnQgEQea8lk1Hsb4xPM
 T4XJ5WYDrcNYJ4B4kqW61Ed+Qrljw0MlwazWT37zcQQYDctwN+zHrBwLPghC9zjE5nrR
 HHtrqslMsMNvzGBS63O4Ve82JaKL2RsbuWf7ovU8yHWk9PHLFqISu3oM6fbt3RqRESpY
 VGX8IyezK89PQREJ2JV1UgU3JT/nlaUf/C9QxSM7+4hIiaWarxYtlHBniQA9znEi4Yad +g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nducm3bcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 19:38:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9UJc4L2013086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 19:38:05 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9UJc4QC021767;
        Tue, 30 Oct 2018 19:38:04 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 12:38:04 -0700
Subject: Re: WARNING in rds_message_alloc_sgs
To:     syzbot <syzbot+26de17458aeda9d305d8@syzkaller.appspotmail.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com
References: <0000000000003c6b7b0579772ff3@google.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <a7a834e0-c300-b5b9-67b5-78fa3eba8ebb@oracle.com>
Date:   Tue, 30 Oct 2018 12:38:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000003c6b7b0579772ff3@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=907
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2018 12:28 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    6201f31a39f8 Add linux-next specific files for 20181030
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1397d06d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2a22859d870756c1
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=26de17458aeda9d305d8
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bb52eb400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118bdfc5400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+26de17458aeda9d305d8@syzkaller.appspotmail.com
> 
> WARNING: CPU: 0 PID: 19789 at net/rds/message.c:316 
> rds_message_alloc_sgs+0x10c/0x160 net/rds/message.c:316
> Kernel panic - not syncing: panic_on_warn set ...
Looks like this kernel build has panic on warn enabled which
triggers panic for " WARN_ON(!nr_pages)" case. Will look into
it. Thanks !!

Regards,
Santosh
