Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2392938-1521186153-2-11854501463898990227
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
    t=1521186153; b=Y4aKbyUCWv4BYzYJk8V5ZYy4dLRtrGG36Mjgc+wfsbBPcw/
    GK+CEDmU8BCuR7RC7S4Pz6d60WNxxqR+BYGeyLDd1XrKMKpmUM4qRf8priJqrRyu
    u3r/NnydzxSwZ4mzNL52jLixVGTRDLEdPfYlIU/InbOMtt30zq6grGFhuBB78UyQ
    8FvYtcoHfpX/HDDxAuxT5L8zkjBKdOfqfiZSvnU8iiTWrsRz+ThVjC0NHQIfuKwx
    f2bRCrmBfI2UWHV9+2gFE2j8OQ1DP4V6Oz4EKCB+VlnYAM3VpYBWpCaGaOYc0+b7
    M6VtRS9tOGwyj9A6Z+n9ZDMXNzZCnsqqw3pwdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521186153; bh=s
    VAL8ly0l9UJev47xQPMz8Mx17CVMdoHGqlSmhaBUW4=; b=GZTH22Ziyg7vUtU/d
    gl5rzohfiF5EpIr4vSm8H1fUBc8I986VYmo9dHNqjioTwCYaiqbKU/oiWXuCdKlM
    BWPaHJ1AdIMWRYVEv6c0qz1jguRxDrmokTTWY+yriJUi1iILlXhbt3rWuH8FZhYS
    /bNcgm/Ga+zXWRN74l2bDa6WB5dnxb4fzHa64PvG6mdFqkuZek4yTojHXsHepN8q
    KAvk76CsiP/CXdV5hlfmcNxb0V0Yt9fWosTXYj6hzp3iShKakm8T0v7gtnxhVg23
    HlVQgQsNrrzrd3sKjmdh2z04EsArwEzcimJNkm1j0EmlSxaw+6isoua8bZdr7mhz
    UDYvg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=v2yzN3Vm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=v2yzN3Vm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Mar 2018 10:42:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
Message-ID: <20180316074211.aa3xjbiypzetsrgq@mwanda>
References: <152105892255.22262.1902152685410223215.stgit@noble>
 <20180315104853.bthffdd4hzklzo6d@mwanda>
 <87vadxbnwe.fsf@notabene.neil.brown.name>
 <20180315112454.7p6gch4gq7jljk37@mwanda>
 <87po45ayz8.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87po45ayz8.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160005
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

On Fri, Mar 16, 2018 at 07:02:51AM +1100, NeilBrown wrote:
> On Thu, Mar 15 2018, Dan Carpenter wrote:
> 
> > On Thu, Mar 15, 2018 at 10:04:33PM +1100, NeilBrown wrote:
> >> On Thu, Mar 15 2018, Dan Carpenter wrote:
> >> 
> >> > This all seems fine.  Generally the requirements for staging are that it
> >> > has a TODO, someone to work on it, and it doesn't break the build.  But
> >> > some of the patches don't have commit message and those are required and
> >> > some of the commit messages are just the changes you have made not don't
> >> > describe the actual code...
> >> 
> >> Thanks for having a look.
> >> It seems odd to require detailed commit messages, when we don't require
> >> the same level of quality in the code.
> >> Naturally when the driver is moved out of staging a properly detailed
> >> commit message should be added, but is that needed on the way in to
> >> staging?  At this stage I don't know much more than is already there.
> >> After I've cleaned up the code I probably will.
> >> 
> >> For patch 01/13 you asked "what kind of device this is".  The subject
> >> line makes it clear that it is a "pcie driver".  What extra detail did
> >> you want?  Would it be sufficient to just copy the subject line so that
> >> it appears twice in the commit message?
> >> 
> >
> > Ah...  Sorry.  It's literally a pcie driver.  For some reason I thought
> > it was a device that ran over pcie.
> >
> > We don't require a detailed changelog, but you have to put something...
> > Probably just restating the subject and adding that it's for the gnubee1
> > is fine.
> 
> I'll resend sometime next week with more words.  However could you
> please clarify a couple of things for me?
> 
> 1/ Why do you (sometimes) call the commit message a "change log".  When
>   I see the term "change log" in the context of a patch, my first
>   thought is that it it means a log of changes that have been made to
>   the patch - typically through the review cycle.  But that isn't what
>   you mean.  This has confused me a couple of times.
> 

Sorry.  Yeah.  I do use them interchangeably which is probably not the
right thing.


> 2/ Why don't you consider the first line of the commit message to be
>    part of the commit message?  Why is duplication required?
>    (You said "some of the patches don't have commit message[s]",
>    which isn't true, though some of the messages are only one line).
> 

First of all, you're a writer.  If you don't like to do things then you
need to keep those skills hidden away.  I never tell anyone that I know
how to program in COBOL (True story.  COBOL is great for formatting text
on dot matrix printers and for doing decimal math.)

This is a hard requirement from Greg, not something that specific to
*me* although I do agree with the requirement as well.  The idea of
forcing everyone to write a commit message is that we're hoping they
take a little time to tell a story about what the patch is.  Sometimes
they're not English majors or whatever and they just restate the subject
and whatever, that's fine.

The first patch I reviewed in this series was:
[PATCH 03/13] staging: mt7621-gpio: ralink: add mt7621 gpio controller
A good commit message might be:

    This adds Mediatek GPIO support for the mt7621 chip.  It's used on
    the Gnubee NAS hardware and a couple other MIPS SoCs.  This code
    originally came from the OpenWRT project.

That information was all there in the patch 0 commit but that gets
dropped.  It's feels a bit weird to put that boilerplate information in
every commit, but it means that it's there when we do a git log on the
file so I think it's a good idea.

Also, and this is my fault not yours of course, but my email client is
all text and looks exactly like marc.info:
https://marc.info/?l=linux-driver-devel&m=152105965413484&w=2

It's hard to see the subject so I normally don't even read it when I'm
looking at patches.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
