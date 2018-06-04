Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2012686-1528150687-2-3990639186890901150
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528150687; b=IUfSYTK2LZxsoO57ZbOYm+jRz/UAUSGdQ0mUJNG/Pq4IFPgUJo
    +D285w7lwvpyyv1BGLHucdIvgGO1mjpYnnvAYSSZSLDYj/kvmyky8aXT5gk2wXfZ
    xAJ+Y/qncIleKREgb0dKzaCajO/IhC/FuwWqNBMVocM++EiHlkAE7SlO3bEAC0E/
    QUVYX4H6fteWuDSzYlx7HwkKU6Txv63zq+iXVOwWiXlfePxFKn82wOjb8HU6hYf8
    eHM2mxheiVqfcPAU2ARvp+7eV1KthmJbJQHYpcSZ9AHB88I3I0I2SUDQqwC01Ljs
    hj0A3E3ObnPRFgjQZotacsKiOLn/m5wrDD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528150687; bh=PfXuydpnoriE4Ne0bCu4GrJCpHGnlf
    4QfZm6wMbWX3g=; b=cF9n7QQxLmTNF/0HcHpvhZculP5xrJqric1Y2rj0J5XpDL
    tROxoduPNIZRYE8uyaRenAUCElfZOlwn1rhSD20raA5lnkWisiqglBivzZZdlwAp
    j5Yx8brGiK8d2HNM8dHsKx7+W1z/7qyj6tAF6wROA/YhTpetxO1sHXJyAJG2x8kN
    whDU+6m36dPP5iDvzZZTtxGn5xpAmH7etQ29CWlTOyrIPZzIO9zSWXnNwrJF73NE
    7jLFpdRkW31k4zs9mhjc4RUdrcjt6TGyPeSnzVa5uXwxmKGAjCJbjZJ7nlfAURna
    CdXoSxdoP0KX1irSx0R7fDenQzpNtlzP/OPVfM1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=dC7jd/eX
    header.a=rsa-sha256 header.s=corp-2017-10-26 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=dC7jd/eX
      header.a=rsa-sha256 header.s=corp-2017-10-26 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN0vX2CyQ4JTDf4L6aVNO5wXuwY2eCdCM7lXyiz4BBRY7+T46R8k3yCNL/2hy1OYJct3JSSkbrdaCKH+K3BBwGQk9WPy6mPukbaSu3sqCxF6TSNLv0Wd
    spftF6A8vkCiK8uq08KQtmZCw3Ss/YNUXtjNR8tUZAzcTlyIIa1qLe02AzgmM/PaqZKgwtB3PfYhMwyeQiiP+05VKV3LFdD4QPupHgBtkSeNLrP2UVcJQGjy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=QisB4bsDsoRB25_cBu4A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeFDWSF (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 18:18:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37134 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeFDWSE (ORCPT
        <rfc822;linux-next@vger.kernel.org>); Mon, 4 Jun 2018 18:18:04 -0400
Date: Mon, 4 Jun 2018 15:17:56 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xfs tree
Message-ID: <20180604221756.GQ7825@magnolia>
References: <20180605080340.7e579d9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605080340.7e579d9d@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8914 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040253
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jun 05, 2018 at 08:03:40AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   1e7fb5893364 ("xfs_repair: check and repair quota metadata")
> 
> is missing a Signed-off-by from its committer.

Oops, yeah, I just backported that over from xfsprogs, will fix it up.

Thanks for catching this.

--D

> 
> -- 
> Cheers,
> Stephen Rothwell


