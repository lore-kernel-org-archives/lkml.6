Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3126266-1526005275-2-2825001970060377975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526005274; b=KeDdso3BaT+SGgBn626cXPG+uvmMI7VVLyUqAcyz7beCavH8YY
    4cU2EPijc3blGlR3Y7XBFSozmNh15u+pmILlZa1C3DzPh1AMn5QkJDy7Fb3IKihn
    yYfKvO1nQiBQ2+cihKyrsH5wCMEl17aHpSXPJKIw8GgRm+W+DXkKKL0BJR3Xciqa
    EyrS3dvTmdh5maLA604Pv+CrMxoSewme5jrr1vwGzG2vhTBAr2gDOR7FIXr8SQ2R
    EQRIec4jU7EBzONbf4uz+DyTrJIyAG4w/mKlU5Lb4Sq0Drm2xeFnscHXnLRgDxOk
    9UBquJwqFRmItE0mv6nc/EHoEMe4uXTKbyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526005274; bh=2ELWvK8DBOJKDUJnlr1aB9ZD7478Qk
    3y3PR8dI2ib74=; b=DcBLh0J7kOKtsbtbOvmziP2AFOZKucVORVo8cHT7zF1gSM
    I6HrpYT9sHK/+lNdY2zX1YA8H1VIcfSHynW3fc2K0US08KV1UCp5v9pwslW2/yPc
    HwZwi6eVZ5L6jmfSz0MvYfsUQgf8MzZwqupHyJn1WnhZI9coWBzSI7uqc062kaHH
    sKhpvBNcm+N2QwVVlSZX096NX5+s67wGxYcCngga7OZLW7F34CcKdE0oM5qcBFaL
    P7t79RZV1KTVBgp/uVS/nZFMZublidrRyTSnJD8EaGcDLO8U2W9ctioKbd1U/3FR
    hsnAJGKkVeVW1oZWHZ1+mDBD8KFYuhKQQFkDLgEA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=gPD8W6zV x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=gPD8W6zV x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC6MyMtnQPWAl5SFh3IexV3SycrclNjZ8yucFEEG+wsgj5g31MGEBeQglJTl7HIOU3rC/xIeGO0RJ3NG6onng4I44tkqJROhaa04lalkKB4DAB4JFlDF
    WHXhul/mfkhOVgeY6RDYiw57SPjPCfI5wblySA438+GAYYN2ajbjCIsYgEA+XqP4nzc+wTC/tu8tgnjiIxBgeiqc7usrpf2QN25x7rEFuIXchZCiiPksiMMb
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Aaf4PiTlr0jFMKj0QpIA:9 a=MVFviL0qI-NEJctP:21
    a=QZt1MQ3tMbvCqncn:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeEKCVA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 22:21:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56440 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKCU6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 May 2018 22:20:58 -0400
Date: Thu, 10 May 2018 19:20:20 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, tytso@mit.edu, adilger.kernel@dilger.ca,
        clm@fb.com, jbacik@fb.com, dsterba@suse.com, sandeen@sandeen.net,
        dhowells@redhat.com, fliu@suse.com, jack@suse.cz, jeffm@suse.com,
        nborisov@suse.com, jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/4] xfs: add verifier check for symlink with
 append/immutable flags
Message-ID: <20180511022020.GG11261@magnolia>
References: <20180510231359.16899-1-mcgrof@kernel.org>
 <20180510231359.16899-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231359.16899-3-mcgrof@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8889 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=587
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805110015
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 04:13:57PM -0700, Luis R. Rodriguez wrote:
> The Linux VFS does not allow a way to set append/immuttable attributes
> to symlinks, this is just not possible. If this is detected we can
> correct this with xfs_repair, so inform the user.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_symlink_remote.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_symlink_remote.c b/fs/xfs/libxfs/xfs_symlink_remote.c
> index 5ef5f354587e..42dd81ede3d6 100644
> --- a/fs/xfs/libxfs/xfs_symlink_remote.c
> +++ b/fs/xfs/libxfs/xfs_symlink_remote.c
> @@ -242,5 +242,10 @@ xfs_symlink_shortform_verify(
>  	/* We /did/ null-terminate the buffer, right? */
>  	if (*endp != 0)
>  		return __this_address;
> +
> +	/* Immutable and append flags are not allowed on symlinks */
> +	if (ip->i_d.di_flags & (XFS_DIFLAG_APPEND | XFS_DIFLAG_IMMUTABLE))
> +		return __this_address;

This belongs in xfs_dinode_verify so that it checks all symlinks, not
just the one shortform ones.

--D

> +
>  	return NULL;
>  }
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
