Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD87C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4752081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4752081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeKBWk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:40:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbeKBWk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:40:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2DUH15019951
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 09:33:15 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ngqg4874h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:33:15 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Nov 2018 13:33:13 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 13:33:10 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2DX9FQ38273190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 13:33:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A08DBB206C;
        Fri,  2 Nov 2018 13:33:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A5A8B2065;
        Fri,  2 Nov 2018 13:33:09 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.148.108])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 13:33:09 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 94F4116C36E4; Fri,  2 Nov 2018 06:33:09 -0700 (PDT)
Date:   Fri, 2 Nov 2018 06:33:09 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     NeilBrown <neil@brown.name>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Reply-To: paulmck@linux.ibm.com
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181024121622.GA10942@localhost>
 <87ftwt6850.fsf@notabene.neil.brown.name>
 <20181027011010.GA29769@localhost>
 <20181101164544.GA31540@linux.ibm.com>
 <8736sk31t8.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736sk31t8.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110213-2213-0000-0000-0000030FF0CB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009971; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111588; UDB=6.00576069; IPR=6.00891680;
 MB=3.00024005; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-02 13:33:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110213-2214-0000-0000-00005C1D5582
Message-Id: <20181102133309.GQ4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 08:50:11AM +1100, NeilBrown wrote:
> On Thu, Nov 01 2018, Paul E. McKenney wrote:
> 
> > On Sat, Oct 27, 2018 at 02:10:10AM +0100, Josh Triplett wrote:
> >> On Fri, Oct 26, 2018 at 08:14:51AM +1100, NeilBrown wrote:
> >> > On Wed, Oct 24 2018, Josh Triplett wrote:
> >> > 
> >> > > On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
> >> > >> On Sun, Oct 21 2018, Josh Triplett wrote:
> >> > >> 
> >> > >> > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
> >> > >> >> I call on you, Greg:
> >> > >> >>  - to abandon this divisive attempt to impose a "Code of Conduct"
> >> > >> >>  - to revert 8a104f8b5867c68
> >> > >> >>  - to return to your core competence of building a great team around
> >> > >> >>    a great kernel
> >> > >> >> 
> >> > >> >>  #Isupportreversion
> >> > >> >> 
> >> > >> >> I call on the community to consider what *does* need to be said, about
> >> > >> >> conduct, to people outside the community and who have recently joined.
> >> > >> >> What is the document that you would have liked to have read as you were
> >> > >> >> starting out?  It is all too long ago for me to remember clearly, and so
> >> > >> >> much has changed.
> >> > >> >
> >> > >> > The document I would have liked to have read when starting out is
> >> > >> > currently checked into the source tree in
> >> > >> > Documentation/process/code-of-conduct.rst .
> >> > >> 
> >> > >> I'm curious - what would you have gained by reading that document?
> >> > >
> >> > > I would have then had rather less of a pervasive feeling of "if I make
> >> > > even a single mistake I get made an example of in ways that will feed
> >> > > people's quotes files for years to come".
> >> > 
> >> > Thanks for your reply.  Certainly feeling safe is important, and having
> >> > clear statements that the community values and promotes psychological
> >> > safety is valuable.
> >> > 
> >> > The old "code of conflict" said
> >> >    If however, anyone feels personally abused, threatened, or otherwise
> >> >    uncomfortable due to this process, that is not acceptable. 
> >> > 
> >> > would you have not found this a strong enough statement to ward off that
> >> > pervasive feeling?
> >> 
> >> Not when that document started out effectively saying, in an elaborate
> >> way, "code > people".
> >
> > Interesting.
> >
> > I am curious what leads you to your "code > people" statement.  Of course,
> > one could argue that this does not really matter given that the code of
> > conflict is no longer.  However, I would like to understand for future
> > reference, if for no other reason.
> >
> > One possibility is that you are restricting the "people" to only those
> > people directly contributing in one way or another.  But those using the
> > kernel (both directly and indirectly) are important as well, and it is
> > exactly this group that is served by "the most robust operating system
> > kernel ever", the chest-beating sentiment notwithstanding.  Which is in
> > fact why I must reject (or rework or whatever) any patch that might result
> > in too-short RCU grace periods:  The needs of the patch's submitter are
> > quite emphatically outweighed by the needs of the kernel's many users,
> > and many of the various technical requirements and restrictions are in
> > fact proxies for the needs of these users.
> >
> > But you knew that already.
> >
> > Similarly for the Linux kernel's various code-style strictures, which
> > serve the surprisingly large group of people reading the kernel's code.
> > Including the stricture that I most love to hate, which is the one
> > stating that single-line do/for/if/while statements must not be enclosed
> > in braces, which sometimes causes me trouble when inserting debug code,
> > but which also makes more code fit into a window of a given size.  ;-)
> >
> > But you knew that already, too.
> >
> > The maintainability requirements can be argued to mostly serve the
> > maintainers, but if the code becomes unmaintainable, future users
> > will be inconvenienced, to say the least.  So even the maintainability
> > requirements serve the kernel's many users.
> >
> > But you also knew that already.
> >
> > So what am I missing here?
> >
> 
> Hi Paul,
>  thanks for contributing your thoughts.  It is nice to have a new voice
>  in the conversation, it helps me to maintain my illusion that this
>  issue is relevant to the whole community.

I am not sure whether I should feel Australia-style chastened,
American-style encouraged, or what, but either way, good show on that
paragraph.  ;-)

>  I cannot, of course, speak to why Josh wrote what he did, but I can
>  give some insight into why I had no disagreement with that part of his
>  statement.
>  A key insight, worth your time to consider and unpack I think, is
> 
>       People won't care what you know, until they know that you care.
> 
>  I won't dwell on that here, but will make some more obviously relevant
>  observations.
> 
>  Firstly, you gave an analytical response to what was, in my view, an
>  emotional observation.  While I agree with your analysis, it is largely
>  irrelevant.  It is not how people *feel* about kernel development.
> 
>  You say that the code of conflict is gone, but in fact much of it is
>  preserved in the code-of-conduct-interpretation.  If you reflect on the
>  focus of the second para of that document (which I think was directly
>  lifted from the code-of-conflict) you will see that value is placed
>  squarely on the code (kernel code, not code of conduct).  The code is
>  put forward as the thing of primary importance.  People (you, me) are
>  only mentioned in the context of being the authors of code that will be
>  criticised  - because (it almost says this) we care about the code, but
>  not about you.
> 
>  So I think it is beyond argument that the value system presented by
>  this paragraph is
>       code > people
> 
>  I think this is particularly unfortunate as it is not really how the
>  community works, and not really how Linus works, except in those
>  occasional outbursts that are publicised so much.
> 
>  I recall two specific events (there were probably others) from early in
>  my Linux experience where Linus said/did things which said to me that
>  he valued me, not just the code that I wrote.  I think he did that a
>  lot (and probably still does).  As I knew that he "cared", I was much
>  more interested in what he knew/thought.
> 
>  I think that the fact that Linus is now acknowledging every "pull"
>  request is brilliant.  It doesn't really help the process much (we all
>  have plenty of visibility into what Linus has pulled) and doesn't help
>  the code (directly) at all.  But it tells people that Linus can see
>  them, and has seen them.  It also allows people to see that they have
>  an email from Linus without expecting it to be a criticism.  Certainly
>  he still criticises and is right to do so, and he doesn't say "Pulled,
>  thanks", which would be my preference, but the fact that he responds at
>  least says "me responding to you matters" and by implication "you
>  matter".
> 
>  (The code-of-conflict only acknowledged that you matter once you feel
>  personally abused).

I agree that Linus's acknowledging pull requests is a good thing.  I have
long appreciated my upstream maintainer doing the same, and I do try to
acknowledge patch submissions myself.  And yes, motivating people is an
underappreciated art, and an art made more difficult by the wide variety
of mindsets, even within a relatively like-minded community such as the
Linux kernel community.  So I agree that improvements are welcome, and
further believe that there always will be room for improvement.

But I am still not seeing "code > people" in the interpretation document.
For me, it is all about people.

Back to "People won't care what you know, until they know that you care."

Fortunately for me, it is not necessary for all that many people to care
what I know, given that I have the usual human limitations on the number
of individuals that I can directly relate to, and this number is way
less than the billions that have some relationship to the Linux kernel,
unwitting though that relationship is in the common case.

In contrast, back in the late 70s, my software had two users, and I
frequently chatted with both of them.  This is clearly not possible in
the case of the Linux kernel.  Nor would it be all that helpful, given
that all they really need from me is to keep RCU working properly.
So I instead create an abstraction of those users' needs in the form
of requirements.  These requirements might seem dull and uninspiring,
but they are in fact a proxy for the needs of the users.

In short, instead of "code > people", I am seeing "our users need us".

							Thanx, Paul

> Thanks,
> NeilBrown
> 
> 
> > 							Thanx, Paul
> >
> >>                       (Leaving aside that the more important detail
> >> would be the community actually acting consistently with the code of
> >> conduct it espoused.)
> >> 
> >> > In the current code, would The "Our Pledge" section have been
> >> > sufficient, or do you think the other sections would have actually
> >> > helped you?
> >> 
> >> "Our Standards" would have been at least as important to me personally,
> >> as would "Enforcement" (and more importantly, examples of that applying
> >> in practice and not just as empty words).
> >> _______________________________________________
> >> Ksummit-discuss mailing list
> >> Ksummit-discuss@lists.linuxfoundation.org
> >> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
> >> 


