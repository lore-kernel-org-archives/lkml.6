Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7419CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4F420842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4F420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeIZTeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:34:02 -0400
Received: from uphb19pa11.eemsg.mail.mil ([214.24.26.85]:41128 "EHLO
        USFB19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726802AbeIZTeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:34:02 -0400
X-EEMSG-check-008: 84295363|USFB19PA14_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2018 13:21:03 +0000
X-IronPort-AV: E=Sophos;i="5.54,306,1534809600"; 
   d="scan'208";a="18684909"
IronPort-PHdr: =?us-ascii?q?9a23=3AENA4uROSzKllhP4hTcsl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/77oMbcNUDSrc9gkEXOFd2Cra4c1KyO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhjexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnWttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZq43VJd8Aq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiCpkyOrYPr3gH5rANXbDkK3mfb?=
 =?us-ascii?q?Z47E5c0hE8zdFD555OFr4BJ/fzUFfrtNPEFh85LxC0w+H/BdR8yoMeXmSPAq?=
 =?us-ascii?q?CCPaPMrV+E/PwgLPSRZIUNojbyN+Al5+LyjX8+gVISYLOm3YENaHC5AvtmIF?=
 =?us-ascii?q?+VYHTrgtcHHmcHpQ0+TPbwh1KeVT5ceWy+UL475jE+EIimF5vMRpixgLyd2y?=
 =?us-ascii?q?e2BplWZmFAClCRHnbkboqFW/kXaC+JPM9hnSILVaK7R48iyx6urgn6xKRjLu?=
 =?us-ascii?q?bO/S0Yr53j3sBv5+LPjREy6SB0D8OF3mGJTmF0mH4IRjAv0KB8v0N90FGD3r?=
 =?us-ascii?q?Z8g/FDC9xT6O1GUh0gOZ7f0eN6EdbyVRzFftuTT1amWNqmCykrTt0t298Of1?=
 =?us-ascii?q?p9G9K6gxDH3iqqBaIVlrOSCJwv7K3Tw2XxJ9x8y3ba1KgtllwmQsxSOm27gq?=
 =?us-ascii?q?5w6RPeB5DGk0qHjaamb6cc0zDX9GeF02WOuFtUUAlqUaXKRXoffFfZrczl5k?=
 =?us-ascii?q?PeSL+jEa8nMgtfxs6EJKpFdNvpgk5BRPf4PdTeYmaxlHmrCBaHw7ODdovqe2?=
 =?us-ascii?q?EH0CrBD0gEllNbwXHTGQEgC2+Ko2PYCjF0XQbjal3t/cFwsnS+SVU+zh3MZE?=
 =?us-ascii?q?pkgf79xhkTis6cQvUcluYWpCAnpB1qABCw08+AWPSaoA80R7lRedMw5h980G?=
 =?us-ascii?q?vdswFsdsi7I7tKmk8VcwMxuVjnkRpwFNMTwoARsHo2wV8qeuqj21RbembdhM?=
 =?us-ascii?q?qoNw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AZAAB2hqtb/wHyM5BaDgsBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QEBgVSBYSqBZIQclEZQAQEGgQgtiGmNeoFmNgGEQAKDfSE3FQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII1JAGCXwEFIxVBEAsOCgICJgICVwYBDAgBAYJeP4F1DaMWgS6Ed4Uig?=
 =?us-ascii?q?QuJcBd5gQeBOYJrhDoRAQwGAYMgglcCiGaFWo5HCZAnBhePNJZpImRxKwgCG?=
 =?us-ascii?q?AghDzuCbZAZViOBKwEBiXsOF4ImAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Sep 2018 13:21:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8QDKxhB030987;
        Wed, 26 Sep 2018 09:21:00 -0400
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
To:     Dave Chinner <david@fromorbit.com>, TongZhang <ztong@vt.edu>
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
 <20180926013329.GD31060@dastard>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <dc3bf978-1b98-bebd-6f35-9b2795693ea7@tycho.nsa.gov>
Date:   Wed, 26 Sep 2018 09:23:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926013329.GD31060@dastard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 09:33 PM, Dave Chinner wrote:
> On Tue, Sep 25, 2018 at 08:51:50PM -0400, TongZhang wrote:
>> Hi,
>>
>> I'm bringing up this issue again to let of LSM developers know the situation, and would like to know your thoughts.
>> Several weeks ago I sent an email to the security list to discuss the issue where
>> XFS's ioctl interface can do things like vfs_readlink without asking LSM's
>> permission, which we think is kind of weird and this kind of operation should be
>> audited by LSM.
> 
> These aren't user interfaces. They are filesystem maintenance and
> extension interfaces.  They are intended for low level filesystem
> utilities that require complete, unrestricted access to the
> underlying filesystem via holding CAP_SYSADMIN in the initns.
> 
> i.e.  they are used to perform filesystem maintenance and extension
> operations that need to be completely invisible to users from
> userspace. e.g.  online file defragmentation (xfs_fsr), data
> migration (e.g. HSM products), efficient backup of data (xfsdump),
> metadata and data scrubbing, online repair, etc.
> 
> IOWs, I really don't think these interfaces are something the LSMs
> should be trying to intercept or audit, because they are essentially
> internal filesystem interfaces used by trusted code and not general
> user application facing APIs.

If they are interfaces exposed to userspace, then they should be 
mediated via LSM.  We only omit the LSM hook when the usage is purely 
kernel-internal.  Security modules are often used to limit even 
"trusted" applications to least privilege and protect them from 
untrustworthy inputs, moving from binary trust notions to only trusting 
them for what they must be trusted to do.  CAP_SYS_ADMIN doesn't 
necessarily indicate that they are trusted to override any given MAC 
policy restrictions.

Wondering why we don't perform the security_inode_readlink() call inside 
of vfs_readlink() currently.  The general pattern is that we do perform 
security_inode_*() calls inside the other vfs_*() helpers, so 
vfs_readlink() is an exception currently.



