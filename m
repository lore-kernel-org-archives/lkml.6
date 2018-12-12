Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D79C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277E320811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cqDLKBGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277E320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeLLUa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:30:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35796 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLLUa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:30:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBCKTNpb087509;
        Wed, 12 Dec 2018 20:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=I/26KTv2J9LPddzizI4smRj8pqjuXWgPzELJ9SbZZlk=;
 b=cqDLKBGN4p1zCWuSs6QoNw0zPrgH88BXPvIVRADJYUx1e/Kv0SK4EmRUX/WWD/OTlCzy
 ni9+UAiYnxLyC3xZvDNFI52rziVmAHD4eOcmQDH8RMvxTrWoL5gIAqoPG/Xmgxxt/E9q
 747N2Vyljv1SUI3NbukW3h7HWM+L7DWnWG/BaSs1CK2jkZfR1uTHQSVzPq/ODHRJblX0
 sWvn2gIvo4mKbfyLogtKkHDmLsDmnIiUlFN0H68nQEZoR82be5DVycgeIshmV3g6IYb5
 bi4AXt6QRk978obwLi0NvCzePjc3U6vHEJ4dPKjdh81+zTw6IPJJEga2Fw4JJHa4lWbK jQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pb3n724tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 20:30:51 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBCKUpsr031323
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 20:30:51 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBCKUoOB016344;
        Wed, 12 Dec 2018 20:30:51 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 12:30:50 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 35DC16A00BA; Wed, 12 Dec 2018 15:30:49 -0500 (EST)
Date:   Wed, 12 Dec 2018 15:30:49 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 00/52] [RFC] virtio-fs: shared file system for virtual
 machines
Message-ID: <20181212203049.GH9077@char.us.oracle.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=935
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 12:12:26PM -0500, Vivek Goyal wrote:
> Hi,
> 
> Here are RFC patches for virtio-fs. Looking for feedback on this approach.
> 
> These patches should apply on top of 4.20-rc5. We have also put code for
> various components here.
> 
> https://gitlab.com/virtio-fs
> 
> Problem Description
> ===================
> We want to be able to take a directory tree on the host and share it with
> guest[s]. Our goal is to be able to do it in a fast, consistent and secure
> manner. Our primary use case is kata containers, but it should be usable in
> other scenarios as well.
> 
> Containers may rely on local file system semantics for shared volumes,
> read-write mounts that multiple containers access simultaneously.  File
> system changes must be visible to other containers with the same consistency
> expected of a local file system, including mmap MAP_SHARED.
> 
> Existing Solutions
> ==================
> We looked at existing solutions and virtio-9p already provides basic shared
> file system functionality although does not offer local file system semantics,
> causing some workloads and test suites to fail. In addition, virtio-9p
> performance has been an issue for Kata Containers and we believe this cannot
> be alleviated without major changes that do not fit into the 9P protocol.
> 
> Design Overview
> ===============
> With the goal of designing something with better performance and local file
> system semantics, a bunch of ideas were proposed.
> 
> - Use fuse protocol (instead of 9p) for communication between guest
>   and host. Guest kernel will be fuse client and a fuse server will
>   run on host to serve the requests. Benchmark results (see below) are
>   encouraging and show this approach performs well (2x to 8x improvement
>   depending on test being run).
> 
> - For data access inside guest, mmap portion of file in QEMU address
>   space and guest accesses this memory using dax. That way guest page
>   cache is bypassed and there is only one copy of data (on host). This
>   will also enable mmap(MAP_SHARED) between guests.
> 
> - For metadata coherency, there is a shared memory region which contains
>   version number associated with metadata and any guest changing metadata
>   updates version number and other guests refresh metadata on next
>   access. This is still experimental and implementation is not complete.

What about Windows guests or BSD ones? Is there a plan to make that work with them as well?

What about the Virtio spec? Plans to make changes there as well?
