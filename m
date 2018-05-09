Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3711254-1525830018-2-14668044387457959769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525830018; b=cRbDRb1dZ+xl6W+x1wvj7k93rzR08HAivAKTFtDCQ5PFQ6VhsQ
    p/akCh6mU0w2LQpM3PXqdlfGGo4JyzB9pjn0pFr3jhzp1bZe2Lpc61fLcZPOoxsn
    1vMQdhikneYk7/H571Cl/OyjqrR4JrWLeip1DpxC2jvsfz9rN0IN931ObuRBVoLh
    ohDZGa7uoFN5+gQLxN7U0LNTAtbzorAj1CrDIgteKDh8dpKdwLcj1jvPgbRvpQLC
    PSlzLTLg0aKn49HTAqm71h+ji4smfSvfltf1CZQwcxE9k17mn9UN8g7dLr1cwp7n
    D/mIFgseopRKdGKZ4Pnb9fWNOzeU98EpjLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525830018; bh=Y2YIgUPxDcQRtXTkEzyHoZ07ICQ0rf
    RL1vsj6gyYrGs=; b=EYvcsBIwPJof04mD22A+/Ul7oqKRmRzZsXJIEDQ1KK0MaC
    WNS3eeXy4wBjFHGe3YA1OaPaOACJCT1XeZHoIfufE+rAiYJ9ck/ovBlFWO2skgc+
    V6qWsZ02/vKyvwUuVXGPY4QMngpwYJhmA8UWo9gBi4bjGbKfgD0p0H9LtEJhxsem
    1vbkW1AkMrNusn+0VCO04zr73WdZzknAHUFsWBJAujGqyQ0qT1hi+prIKDXECnbs
    t2YRYLvKijSXfCpivBAXwECspkw9NyUFuIiNj/MY520AgGlqIkVK+4MTF9VMBJMx
    cBNvrUDRsM4Tcqf3pqLehpwydh7xXLmSOtSgfWGw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=LIgfkWFU x-bits=2048
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=LIgfkWFU x-bits=2048
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
X-CM-Envelope: MS4wfG/BKxPQkgFIixeCFFc7pNt+bAarTgi6/mhXvnrCakqsAAIVIWMDbFiB1q15YKCZR5ZOR/ZTCLpCeHKoOGU661OibzWhpcoOG3VUpMGzbjsbwHEP4WF+
    sRDw3zGbahuNdv8EQKTGPuI4+zbR9ilb6ojFpb0SNzQD1styszp+37E3+5iXCt3gs6Zpvh373XGevNZOxnrcXQhG9uc24fuEi23HlpRV2LeNQQX0iMzbDlGu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=p1ftnfoK4DJL7WZUcx8A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933367AbeEIBkQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 21:40:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38954 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755400AbeEIBkP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 May 2018 21:40:15 -0400
Date: Tue, 8 May 2018 18:39:44 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, sandeen@sandeen.net,
        dhowells@redhat.com, tytso@mit.edu, fliu@suse.com, jack@suse.cz,
        jeffm@suse.com, nborisov@suse.com, jake.norris@suse.com,
        mtk.manpages@gmail.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] vfs: skip extra attributes check on removal for symlinks
Message-ID: <20180509013944.GE11261@magnolia>
References: <20180426234639.12480-1-mcgrof@kernel.org>
 <20180501172319.GK4127@magnolia>
 <20180501174512.GA27853@wotan.suse.de>
 <20180508003055.GC11261@magnolia>
 <20180509000327.GJ27853@wotan.suse.de>
 <20180509001741.GB11261@magnolia>
 <20180509003855.GK27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509003855.GK27853@wotan.suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=14 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=707
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090014
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 12:38:55AM +0000, Luis R. Rodriguez wrote:
> On Tue, May 08, 2018 at 05:17:41PM -0700, Darrick J. Wong wrote:
> > On Wed, May 09, 2018 at 12:03:28AM +0000, Luis R. Rodriguez wrote:
> > > Groovy, thanks, let's not forget the xfs_repair respective fix :) let me know
> > > if you have any feedback on that.
> > 
> > TBH I've lost any proposed xfs_repair patches to the mists of time
> > because some patch volcano keeps erupting on the lists. :P
> > 
> > Uh... I think it's fine for xfs_{repair,scrub} to clear the immutable
> > and append flags on any special inodes it finds, particularly since
> > neither flag has any real meaning for block/char/fifo/socket/symlinks
> > anyway.
> 
> Sure, my point during review of that series for xfs_repair in particular
> though was that for symlinks the justification is different (half of the
> commit log in this new patch), as such I'd prefer to deal with them in a
> separate follow up patch.

Ah, found it again finally[1].  ISTR the discussion petered out after
Dave asked if you had a map of inode mode
(file/dir/bdev/cdev/fifo/socket/symlink) to allowable flags.  That would
be a good general way to detect and clear stray flags.

--D

[1] https://marc.info/?l=linux-xfs&m=150948985429374&w=4

>   Luis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
