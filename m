Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A134C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A96D206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A96D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeKUAfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:35:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729179AbeKUAfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:35:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAKDtehA130336
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:06:35 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nvj59vthc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:06:34 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 20 Nov 2018 14:06:30 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Nov 2018 14:06:27 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAKE6QDK57344198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 14:06:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A135CAE04D;
        Tue, 20 Nov 2018 14:06:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A51D7AE055;
        Tue, 20 Nov 2018 14:06:24 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.151])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Nov 2018 14:06:24 +0000 (GMT)
Date:   Tue, 20 Nov 2018 15:06:21 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] cgroup: document cgroup v2 freezer interface
References: <20181117003830.15344-1-guro@fb.com>
 <20181117003830.15344-8-guro@fb.com>
 <20181117080227.GA22672@rapoport-lnx>
 <20181119174241.GA7273@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119174241.GA7273@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112014-0012-0000-0000-000002CD65AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112014-0013-0000-0000-000021028EAE
Message-Id: <20181120140621.GC24627@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811200126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:42:48PM +0000, Roman Gushchin wrote:
> On Sat, Nov 17, 2018 at 12:02:28AM -0800, Mike Rapoport wrote:
> > Hi,
> > 
> > On Fri, Nov 16, 2018 at 04:38:30PM -0800, Roman Gushchin wrote:
> > > Describe cgroup v2 freezer interface in the cgroup v2 admin guide.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: linux-doc@vger.kernel.org
> > > Cc: kernel-team@fb.com
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst | 26 +++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > > 
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 184193bcb262..a065c0bed88c 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -862,6 +862,8 @@ All cgroup core files are prefixed with "cgroup."
> > >  	  populated
> > >  		1 if the cgroup or its descendants contains any live
> > >  		processes; otherwise, 0.
> > > +	  frozen
> > > +		1 if the cgroup is frozen; otherwise, 0.
> > > 
> > >    cgroup.max.descendants
> > >  	A read-write single value files.  The default is "max".
> > > @@ -895,6 +897,30 @@ All cgroup core files are prefixed with "cgroup."
> > >  		A dying cgroup can consume system resources not exceeding
> > >  		limits, which were active at the moment of cgroup deletion.
> > > 
> > > +  cgroup.freeze
> > > +	A read-write single value file which exists on non-root cgroups.
> > > +	Allowed values are "0" and "1". The default is "0".
> > > +
> > > +	Writing "1" to the file causes freezing of the cgroup and all
> > > +	descendant cgroups. This means that all belonging processes will
> > > +	be stopped and will not run until the cgroup will be explicitly
> > > +	unfrozen. Freezing of the cgroup may take some time; when the process
> > 
> > "when the process is complete" sounds somewhat ambiguous, it's unclear
> > whether freezing is complete or the process that's being frozen is
> > complete.
> > 
> > Maybe "when this action is completed"?
> > 
> > > +	is complete, the "frozen" value in the cgroup.events control file
> > > +	will be updated and the corresponding notification will be issued.
> > 
> > Can you please clarify how exactly cgroup.events would be updated?
> > 
> > > +	Cgroup can be frozen either by its own settings, either by settings
> > 
> >       ^ A cgroup ... and maybe there are more "a" and "the" that should be
> > fixed, it's hard for me to tell.
> > 
> > Also, I believe "either ..., or ..." sounds better than "either ...,
> > either ..."
> > 
> > > +	of any ancestor cgroups. If any of ancestor cgroups is frozen, the
> > > +	cgroup will remain frozen.
> > > +
> > > +	Processes in the frozen cgroup can be killed by a fatal signal.
> > > +	They also can enter and leave a frozen cgroup: either by an explicit
> > > +	move by a user, either if freezing of the cgroup races with fork().
> > 
> > ditto
> > 
> > > +	If a cgroup is moved to a frozen cgroup, it stops. If a process is
> > 
> >             ^ process?
> > 
> > > +	moving out of a frozen cgroup, it becomes running.
> > 
> >        ^ moved
> 
> Hello, Mike!
> 
> Thanks for the review! I agree with all comments above; fixes queued for v4.
> 
> > 
> > > +	Frozen status of a cgroup doesn't affect any cgroup tree operations:
> > > +	it's possible to delete a frozen (and empty) cgroup, as well as
> > > +	create new sub-cgroups.
> > 
> > Maybe it's also worth adding that freezing a process has no effect on its
> > memory consumption, at least directly.
> 
> Hm, isn't it the expected behavior?

You'd be surprised ;-)
Just recently I had a couple of questions about the memory consumption of
the frozen processes.
 
> In any case, I assume that cgroup.freeze knob description is not the best place
> for a such explanations. Maybe it's better to add a standalone paragraph with
> the description of the frozen process state, what's expected to work, what's
> not, etc. I'd return to this question a bit later, when we'll agree on the user
> interface and the implementation.

Sure.
 
> Thanks!
> 

-- 
Sincerely yours,
Mike.

