Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-68257-1521113112-2-8574266023407774889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521113112; b=pgoBTGkKgBC8Y82q+j5attqvTxy8PVYs8/6fDzwTeFzodma
    i+/U8uuQsddS1zRoN9S48OH7qsISg3+9pWO+g6yki5GDTZayUcfMYg3N/rN9CuUV
    zCu0th/Y4ly9BlxjDUrE1+7CK/EZydW5G5NR6NMzOnRRiDREqoc5lDT4qEQ6ynZO
    MUyxZkEH8tbR/kkUSoTI0+0LUNPHYxTh0vYvJudxj6tC7R3Pg5hG0rMXnep0q28w
    2qeHnecaJcFxmGhg1scTcgENL4iku/HV1nl2pLN/K/0kf+kewCwiL9GsKsZ2hsyi
    kRnjXYpU5MwCihOYxpY/y53QzUM2kACwJfF+mOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521113112; bh=S
    jvuezv8JL5/6RWBcxbIchyX3IkBKylw32eaMg/Mko4=; b=EZ3Nc3C7GS7cIP9DM
    Qxw9/D+6AvKJAGitU1J//uzd09Wtt2YVgUifrmbsBqAcX3XRPp/kX14hvXdAovy5
    6NON7oX/wlfkhw5nqzpwuCxww86k1Rdi6vvmCn/g9HxySy+BtwqvmAsZmWdJvj5k
    TE67RfBEEONZO+ce7N62twN/DSMoWHWU5K7xzFJK6picmGkViETjUK9T6OVnlP1i
    +MUoOBoQPupYJhRKgobMGJBoye45fVLdD+ErnGvnqMNffptRAf/I0Lf+xpI37fS9
    TyNCrETRW/tTv986lOfPtgvhlqt2Lep7scXy1Ar66K2Ump1jG72pRgPwlu0oyukd
    TktTg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=X2l5Sl7z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=X2l5Sl7z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 15 Mar 2018 14:24:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
Message-ID: <20180315112454.7p6gch4gq7jljk37@mwanda>
References: <152105892255.22262.1902152685410223215.stgit@noble>
 <20180315104853.bthffdd4hzklzo6d@mwanda>
 <87vadxbnwe.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87vadxbnwe.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=845
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150130
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 10:04:33PM +1100, NeilBrown wrote:
> On Thu, Mar 15 2018, Dan Carpenter wrote:
> 
> > This all seems fine.  Generally the requirements for staging are that it
> > has a TODO, someone to work on it, and it doesn't break the build.  But
> > some of the patches don't have commit message and those are required and
> > some of the commit messages are just the changes you have made not don't
> > describe the actual code...
> 
> Thanks for having a look.
> It seems odd to require detailed commit messages, when we don't require
> the same level of quality in the code.
> Naturally when the driver is moved out of staging a properly detailed
> commit message should be added, but is that needed on the way in to
> staging?  At this stage I don't know much more than is already there.
> After I've cleaned up the code I probably will.
> 
> For patch 01/13 you asked "what kind of device this is".  The subject
> line makes it clear that it is a "pcie driver".  What extra detail did
> you want?  Would it be sufficient to just copy the subject line so that
> it appears twice in the commit message?
> 

Ah...  Sorry.  It's literally a pcie driver.  For some reason I thought
it was a device that ran over pcie.

We don't require a detailed changelog, but you have to put something...
Probably just restating the subject and adding that it's for the gnubee1
is fine.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
