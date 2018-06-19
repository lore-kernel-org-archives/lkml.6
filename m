Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45643C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF27520836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tAamnR+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF27520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030579AbeFSTHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:07:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49526 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030474AbeFSTHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:07:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JJ3W8p144955;
        Tue, 19 Jun 2018 19:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=u+Mk1XpLcR7MAZvCS/UqqitgJUrgq38AEz/QxTgMceA=;
 b=tAamnR+yMn5n0iFy+JAz0QH6qQQSTnr0vVqiOhUPePI2aICO/4X8hqpmq0A9097o0eYG
 tpx2TaPKRiMfV1h8ah6i0EuVfUVHbs9KBycz0xLG+DzNPAtSdVmPY/nMktLLvbT0DFrT
 tkQswssDxicFalFAajS9ovNIPsEmoCYaucCmwp4FB3PjIzNrzWkwdLGuHA9kqMrOFUqa
 Xe8gWv71YuTOPx7OaWXgFoVfph0WCszuzaEv7/rlAeTQL+of+7nFVDieAxKMHYkqW1sa
 kFIyATUxBuuanVDjUKiX0pqfQukrocCstmjpgb3+xft4u6b308sD+XLL7djyWFThfHJW Gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jmu6xsfur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 19:06:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5JJ6m2f029382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 19:06:48 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5JJ6mjv023981;
        Tue, 19 Jun 2018 19:06:48 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 12:06:48 -0700
Subject: Re: [PATCH] jfs: use time64_t for otime
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180619155110.3950450-1-arnd@arndb.de>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <ca7ae8eb-c458-dc3e-be3f-37cb22e3052c@oracle.com>
Date:   Tue, 19 Jun 2018 14:06:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619155110.3950450-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=744
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 10:51 AM, Arnd Bergmann wrote:
> The file creation time in the inode uses time_t which is defined differently
> on 32-bit and 64-bit architectures and deprecated. The representation in
> the inode uses an unsigned 32-bit number, but this gets wrapped around
> after year 2038 when assigned to a time_t.
> 
> This changes the type to time64_t, so we can support the full range of
> timestamps between 1970 and 2106 on 32-bit systems like we do on 64-bit
> systems already, and matching what we do for the atime/ctime/mtime stamps
> since the introduction of 64-bit timestamps in VFS.
> 
> Note: the otime stamp is not actually used anywhere at the moment in
> the kernel, it is just set when writing a file, so none of this really
> makes a difference unless we implement setting the btime field in the
> getattr() callback.

This looks good to me. I'll push it to linux-next and target the next
merge window.

Thanks,
Shaggy

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/jfs/jfs_incore.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
> index 1f26d1910409..d5c46f86b2ef 100644
> --- a/fs/jfs/jfs_incore.h
> +++ b/fs/jfs/jfs_incore.h
> @@ -43,7 +43,7 @@ struct jfs_inode_info {
>  	pxd_t	ixpxd;		/* inode extent descriptor	*/
>  	dxd_t	acl;		/* dxd describing acl	*/
>  	dxd_t	ea;		/* dxd describing ea	*/
> -	time_t	otime;		/* time created	*/
> +	time64_t otime;		/* time created	*/
>  	uint	next_index;	/* next available directory entry index */
>  	int	acltype;	/* Type of ACL	*/
>  	short	btorder;	/* access order	*/
> 
