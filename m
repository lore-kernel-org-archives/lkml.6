Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B5C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ED820684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BJEmtJ+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2ED820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeJCDIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:08:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48534 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCDIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:08:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w92KIfvE156428;
        Tue, 2 Oct 2018 20:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ezfSUjIYQSfz0i9wFQmM9wym077xB1TQPo9DY+AHyhU=;
 b=BJEmtJ+1YykY1y34PZVNxY30kkRNDWARxgp78O1AwqVs9CmD8FNDeRZYOKqtABkLPl5M
 OL0m7pNxLs3cZLrDWSPxzfkrd1Xt43DOxvXZcAY16f39c8nRp1cLbs+nE1lylZo0beTb
 59EUfSZLiepQqE/39X7gYyM6a/IxAeiHOJjzpa9GeDFRhVihdBl14q5rHQRWqgpPIAMM
 +sqtQWWbPNi2t7c15OVg2+6S6RdNogz6AvIoFn0dm/zKUDRn2RCLGNmysZUhgPcuAyrw
 UADW1w3zk+KQFGiDtoHeGEuhcmDjI+znpUX+hE07A+w0qFVkHpT0O9nqAilze8TdIdjK Vw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mt21qyxnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Oct 2018 20:23:07 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w92KN1pg019733
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Oct 2018 20:23:02 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w92KMxSO012939;
        Tue, 2 Oct 2018 20:23:00 GMT
Received: from oracle.com (/23.233.26.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Oct 2018 13:22:59 -0700
Date:   Tue, 2 Oct 2018 16:22:57 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Dhaval Giani <dhaval.giani@gmail.com>
Cc:     alexander.levin@microsoft.com, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, alice.ferrazzi@gmail.com,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>, dvyukov@google.com,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@Oracle.com>, willy@infradead.org,
        knut.omang@Oracle.com
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
Message-ID: <20181002202256.vchh4j5k2wfjqdry@oracle.com>
Mail-Followup-To: Dhaval Giani <dhaval.giani@gmail.com>,
        alexander.levin@microsoft.com, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, alice.ferrazzi@gmail.com,
        Kevin Hilman <khilman@baylibre.com>, Tim Bird <tbird20d@gmail.com>,
        dvyukov@google.com, Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        knut.omang@oracle.com
References: <CAPhKKr9vWJ4d8yV7N4=XqaEyKEjC_ZiPX_2RJSR9ZiR9k6yS1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhKKr9vWJ4d8yV7N4=XqaEyKEjC_ZiPX_2RJSR9ZiR9k6yS1w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9034 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810020192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dhaval Giani <dhaval.giani@gmail.com> [180919 13:15]:
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


Hello,

I have a new way to analyze binaries to detect specific calls without
the need for source.  I would like to discuss Machine Code Trace
(MCTrace) at the Testing and Fuzzing LPC track.  MCTrace intercepts the
application prior to execution and does not rely on a specific user
input. It then decodes the machine instructions to follow all control
flows to their natural conclusions.  This includes control flows that go
beyond the boundaries of the static executable code into shared
libraries. This new technique avoids false positives which could be
produced by static analysis and includes paths that could be missed by
dynamic tracing.  This type of analysis could be useful in both testing
and fuzzing by providing a call graph to a given function.

MCTrace was initially designed to help generate the seccomp() filter
list, which is a whitelist/blacklist of system calls for a specific
application. Seccomp filters easily become outdated when the application
or shared library is updated. This can cause failures or security
issues [ 1 ].  Other potential uses including examining binary blobs,
vulnerability analysis, and debugging.

Thank you,
Liam R. Howlett

[1] https://lwn.net/Articles/738750/



