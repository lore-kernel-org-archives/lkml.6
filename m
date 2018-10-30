Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4DEC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1E920827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KclyDx3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1E920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJaHBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:01:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeJaHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:01:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UM4KnS154756;
        Tue, 30 Oct 2018 22:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=6xSVb8Vt+7NSROjVDgnE/B0nk+n1WEetAZ0Z3mh+kjQ=;
 b=KclyDx3VRZjRSBgfGlBHsUiZMdVhHAKEw49F8CIfXQSUJGcO1tcDXP8ZXN/Ue2nDq4+4
 4Jx6P2pYEy4GmcxHYDSUjbgS/EMfT826V3/5d5NYRfAF0HmGwWA+hAXkjZ4BM17lvPq4
 a+yyGL+ir3ZCkocvJFpJUbzqNWy2YmMMlZ44hXlJjaJJHkc3YT4nixowyv6oVd5H50ro
 2QJEwpcDdRMnkf7Uqf+NdgDz79wdqZWrBYLsQ7ICOrcvO/VCE3kRJumnt5D2mlzlAVvp
 M1W9kAD5lZAghnOPsgyfAjB26hG9+QTfRmF5YDsZ3WBnVXeBEpjSISZaMsZGxBCgQcEf sA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ncfypybac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 22:05:54 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9UM5mgM010105
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 22:05:48 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9UM5lDk012336;
        Tue, 30 Oct 2018 22:05:47 GMT
Received: from asu.omang.mine.nu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 15:05:46 -0700
Message-ID: <1540937143.4680.229.camel@oracle.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
From:   Knut Omang <knut.omang@oracle.com>
To:     Dhaval Giani <dhaval.giani@gmail.com>,
        alexander.levin@microsoft.com, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, alice.ferrazzi@gmail.com,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>, dvyukov@google.com,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org
Date:   Tue, 30 Oct 2018 23:05:43 +0100
In-Reply-To: <CAPhKKr9vWJ4d8yV7N4=XqaEyKEjC_ZiPX_2RJSR9ZiR9k6yS1w@mail.gmail.com>
References: <CAPhKKr9vWJ4d8yV7N4=XqaEyKEjC_ZiPX_2RJSR9ZiR9k6yS1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-19 at 10:14 -0700, Dhaval Giani wrote:
> Hi folks,
> 
> Sasha and I are pleased to announce the Testing and Fuzzing track at
> LPC [ 1 ]. We are planning to continue the discussions from last
> year's microconference [2]. Many discussions from the Automated
> Testing Summit [3] will also continue, and a final agenda will come up
> only soon after that.
> 
> Suggested Topics
> 
> - Syzbot/syzkaller
> - ATS
> - Distro/stable testing
> - kernelci
> - kernelci auto bisection
> - Unit testing framework
> 
> We look forward to other interesting topics for this microconference
> as a reply to this email.
> 
> Thanks!
> Dhaval and Sasha
> 
> [1] https://blog.linuxplumbersconf.org/2018/testing-and-fuzzing-mc/
> [2] https://lwn.net/Articles/735034/
> [3] https://elinux.org/Automated_Testing_Summit

Hi,

I'd like to make a short case for my "runchecks" enhancement to 'make C={1,2}' which is
the result of a discussion on the kernel mailing list last winter, to see how it can be
brought forward. It allows simple configuration to run one or more tools like checkpatch,
sparse, smatch and documentation checking with selective suppression of certain classes of
issues, to enable automated testing even when not all issues have been resolved - see
mailing list threads here:

https://lkml.org/lkml/2017/12/16/135
https://patchwork.kernel.org/patch/10174967/

Thanks,
Knut

