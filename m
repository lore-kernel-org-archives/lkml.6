Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2818068-1525785982-2-4914752428556500550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525785982; b=bPXz+Al+1B5uuKoEjMwH2JL3/pIBMt1rGorVKb2LVuPXvrmfx5
    N5DlhPmdgxmCdGzdzf+OsDBImQXs6/oZxExfdTuZtjvdZ6WL3VR/K08v76259yKr
    mRq7/xaV+pgRy8WeqZkIReHFY6qHFSs8spw3iXxYt2PTiqFGz4cWhLt625e+vcuv
    mD1sDDsfev3IKx3IPe+uV1Q3J8HSiGPjNAagmSukXJBAciUhWjWYKDOOV/z911ij
    oMFivmpw5dzuK1DazdXuUfY3kedsxYL0nRQtJzQxxvgGp8c8Vj6FpfT3hO6i58o0
    0jbOw5Ns5KMH6uDsIHmkZR065kd9yfgCBY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525785982; bh=GO+DR
    CbX60Dc8bn7V2PXpd5qn0eRScfUUprqcIxI998=; b=crfpkog3RMuBsemoxpaff
    20U7hhhCB5BMCnKkye1GHo1TgnTfH1erqpSRpBLtm+jXr8msqjHbtzScD84QHCKT
    w8wDC1UZ/FfWw+Edd1S6HgRP8ng0MbBuPqFokoG/diwEQKtePI7yCOagMy/WU2f5
    PEACkDbpPAg3N3i1Sxjw8BrVK5DjxzIAkWPsDKGTLAwn6e51Fmy/IsyUhKH3vN3h
    GaqVUrF8PfanTouS7GtLlWm6hQ6reDGjhNrY1HEDqjiBxwtuywTTu45GQJpyZcO5
    FDEtO/xGYFw3lFpbezx9T9Ruaz5NRbjkHuxSqYyz0SvivwW1zHhx8lUUWjny9R60
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linux.intel.com
    header.result=pass header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linux.intel.com
      header.result=pass header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL/LAp4fvRLUdXl2smjQo/09qo9tJDDmzfpYnkJAzzrwD+hiDTlKBrUg1r/sqmkjE0etCWGqFGMYRFjLmRbezgAPcAbd/gXsAmU/BkT7XszXL7bok8fB
    GduuHKLy/j7/cVVX+qGnInvAjBVgXzPDdT4ZhRR6ZnG77ISGm2ln8/VXdrO9amJ2wjZru9Z1sF/Gdp/Q4ELcENIDmjJQsPEXe5uP8KiQg+bSZIqv8VB4sgnj
    bQmMpMrLYKbk30+jrbYQmQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8 a=OLL_FvSJAAAA:8
    a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8 a=EEaJKVT0s2co3c8qBu4A:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=-03WJYN85n3jmj2l:21 a=Jjy-RHIWu4bpFmbP:21
    a=CjuIK1q_8ugA:10 a=u0PVVxz_57gA:10 a=qlc6ooN6es4A:10
    a=oIrB72frpwYPwTMnlWqB:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,378,1520924400"; d="scan'208";a="197679526"
Date: Tue, 8 May 2018 16:26:10 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH] media: staging: atomisp: fix a potential missing-check bug
Message-ID: <20180508132610.4wr5vtduy4fjrqm7@kekkonen.localdomain>
References: <1525300731-27324-1-git-send-email-wang6495@umn.edu>
 <20180508121635.mdw4jikv66iyprie@mwanda>
 <CAAa=b7dZFqKxFg=ez5Q7H=94HvqrO16pWH6sEmwrWgx60xCxNw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAa=b7dZFqKxFg=ez5Q7H=94HvqrO16pWH6sEmwrWgx60xCxNw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Alan Cox <alan@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kangjie Lu <kjlu@umn.edu>,
 open list <linux-kernel@vger.kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 "open list:STAGING - ATOMISP DRIVER" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 08:04:54AM -0500, Wenwen Wang wrote:
> On Tue, May 8, 2018 at 7:16 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Wed, May 02, 2018 at 05:38:49PM -0500, Wenwen Wang wrote:
> >> At the end of atomisp_subdev_set_selection(), the function
> >> atomisp_subdev_get_rect() is invoked to get the pointer to v4l2_rect. Since
> >> this function may return a NULL pointer, it is firstly invoked to check
> >> the returned pointer. If the returned pointer is not NULL, then the
> >> function is invoked again to obtain the pointer and the memory content
> >> at the location of the returned pointer is copied to the memory location of
> >> r. In most cases, the pointers returned by the two invocations are same.
> >> However, given that the pointer returned by the function
> >> atomisp_subdev_get_rect() is not a constant, it is possible that the two
> >> invocations return two different pointers. For example, another thread may
> >> race to modify the related pointers during the two invocations.
> >
> > You're assuming a very serious race condition exists.
> >
> >
> >> In that
> >> case, even if the first returned pointer is not null, the second returned
> >> pointer might be null, which will cause issues such as null pointer
> >> dereference.
> >
> > And then complaining that if a really serious bug exists then this very
> > minor bug would exist too...  If there were really a race condition like
> > that then we'd want to fix it instead.  In other words, this is not a
> > real life bug fix.
> >
> > But it would be fine as a readability or static checker fix so that's
> > fine.
> 
> Thanks for your response. From the performance perspective, this bug
> should also be fixed, as the second invocation is redundant if it is
> expected to return a same pointer as the first one.

The arguments are unchanged so the function returns the same pointer.

Btw. this driver is being removed; please see discussion here:

<URL:https://www.spinics.net/lists/linux-media/msg133223.html>

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
