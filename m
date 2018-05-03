Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209120-1525337872-2-17881457456365324202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525337871; b=VJj8IKiyIN7TJN6O7QuTSpflN0szDfIfhOOPz3/lhlBxI9PKqN
    aoG133NqhdjtSb9XUGQGkGl9ZS2ivRPT6o3o5VU4DvDunAr+yH3TJI+6pDnMcgEv
    Cisc7J54Wk/6VDYOYYtoFbT/Q/a7womu3Ubna1mVYSQqZQFMVsTyMOnnVvMuLtPG
    wdeiLoYZoICAhwOCj7CKl9DpqGGLpDGTdPJVaPfG2ONjJpN4OhTOApFL3DjNvKIw
    CaKdXSfyjCIYHZBKosBxlznZT4GK6aK8mIdI1GLj97+h/Ju/SOw2Vp563CRpZuVR
    XJ1Y0Hu9GzEP3geK7EqtXHbgW7bh5BM246bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525337871; bh=4j6runfhy/v77uVPK6+yGuwDMp1z8A
    Cg4Lkl3lEbmyM=; b=BATyeSyuLrcCMKKZE4Q+tNVp8x2i1ndWCyfBqUHk7SboOW
    I5lGeHM/mBl8pSgSxYo6BFbTbgDgHNTb1hOVwDvuzQYeiy+WwN6qaOH8hZ5kIVsP
    3irGlvoayIKaIEoHko0aHX46YaJEtyBt36nzglNyjhm+lMKaQI9ol52NEGqFin7o
    1/Hl+1HhSreif7We1DG4hRtCV+PHGb1k+CBHI7KBWoUTYrPive88dN+HOiXH1OK0
    QcxVbzgz6CLThOqJQL2N1TOoI1mUXyIrGf0QJFW/Wd4xslaCz7UbOGpuYwyENUrk
    JjG7xN3kfLXiQUzh3r0jVeNse9OwXDE1a6MG11fQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGRdXnrZsPAzfyipC8EbiNlKUaL9pcu1mZgbK7wolmaYxjIh6DEotGNzDQrI+7mujZsXnqbx9XAb6rqo/NQr8Ri2EeMi8mRLnMADGBpN/Fumj4lmgubU
    XNkWUt3QNF8pMFKEJ/Pbi+TuqhNWoZBuXiW4g1MGtiJnxC05pbFM0v0ib6nn1XxFcy3Fv/WZ2hRjaFL6r6Q2vzMQxxBEfuZWL1s360+fS2yQfklDN893U57i
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=JfmvthuO-e7s0lxLa04A:9
    a=zksiyL_pIVoVOcw0:21 a=YL-T8Y09Wc_dEQmm:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbeECI5t (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 04:57:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40015 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbeECI5q (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 May 2018 04:57:46 -0400
Date: Thu, 3 May 2018 10:57:41 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "prakash.sangappa" <prakash.sangappa@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
Message-ID: <20180503085741.GD4535@dhcp22.suse.cz>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <cac754ee-efb9-0259-a50b-4efa11783058@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac754ee-efb9-0259-a50b-4efa11783058@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 02-05-18 16:43:58, prakash.sangappa wrote:
> 
> 
> On 05/02/2018 02:33 PM, Andrew Morton wrote:
> > On Tue,  1 May 2018 22:58:06 -0700 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
> > 
> > > For analysis purpose it is useful to have numa node information
> > > corresponding mapped address ranges of the process. Currently
> > > /proc/<pid>/numa_maps provides list of numa nodes from where pages are
> > > allocated per VMA of the process. This is not useful if an user needs to
> > > determine which numa node the mapped pages are allocated from for a
> > > particular address range. It would have helped if the numa node information
> > > presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
> > > exact numa node from where the pages have been allocated.
> > > 
> > > The format of /proc/<pid>/numa_maps file content is dependent on
> > > /proc/<pid>/maps file content as mentioned in the manpage. i.e one line
> > > entry for every VMA corresponding to entries in /proc/<pids>/maps file.
> > > Therefore changing the output of /proc/<pid>/numa_maps may not be possible.
> > > 
> > > Hence, this patch proposes adding file /proc/<pid>/numa_vamaps which will
> > > provide proper break down of VA ranges by numa node id from where the mapped
> > > pages are allocated. For Address ranges not having any pages mapped, a '-'
> > > is printed instead of numa node id. In addition, this file will include most
> > > of the other information currently presented in /proc/<pid>/numa_maps. The
> > > additional information included is for convenience. If this is not
> > > preferred, the patch could be modified to just provide VA range to numa node
> > > information as the rest of the information is already available thru
> > > /proc/<pid>/numa_maps file.
> > > 
> > > Since the VA range to numa node information does not include page's PFN,
> > > reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
> > > 
> > > Here is the snippet from the new file content showing the format.
> > > 
> > > 00400000-00401000 N0=1 kernelpagesize_kB=4 mapped=1 file=/tmp/hmap2
> > > 00600000-00601000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
> > > 00601000-00602000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
> > > 7f0215600000-7f0215800000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
> > > 7f0215800000-7f0215c00000 -  file=/mnt/f1
> > > 7f0215c00000-7f0215e00000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
> > > 7f0215e00000-7f0216200000 -  file=/mnt/f1
> > > ..
> > > 7f0217ecb000-7f0217f20000 N0=85 kernelpagesize_kB=4 mapped=85 mapmax=51
> > >     file=/usr/lib64/libc-2.17.so
> > > 7f0217f20000-7f0217f30000 -  file=/usr/lib64/libc-2.17.so
> > > 7f0217f30000-7f0217f90000 N0=96 kernelpagesize_kB=4 mapped=96 mapmax=51
> > >     file=/usr/lib64/libc-2.17.so
> > > 7f0217f90000-7f0217fb0000 -  file=/usr/lib64/libc-2.17.so
> > > ..
> > > 
> > > The 'pmap' command can be enhanced to include an option to show numa node
> > > information which it can read from this new proc file. This will be a
> > > follow on proposal.
> > I'd like to hear rather more about the use-cases for this new
> > interface.  Why do people need it, what is the end-user benefit, etc?
> 
> This is mainly for debugging / performance analysis. Oracle Database
> team is looking to use this information.

But we do have an interface to query (e.g. move_pages) that your
application can use. I am really worried that the broken out per node
data can be really large (just take a large vma with interleaved policy
as an example). So is this really worth adding as a general purpose proc
interface?
-- 
Michal Hocko
SUSE Labs
