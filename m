Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2592411-1520409425-2-9122201211808901395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520409425; b=jLxHYoEds6mryePvrLydsxPL121WBkq//ir+0/VwBpUEpfS
    +JSjcbAyVyP2/D21/HbQ2VrKN9fqxvmsmh8WOEpDeQeyjJD20haE/l1gMXl4gmc9
    AvZq9TvlVStj6j2H4PBnplcq6QE5x6syCQlj3gCWQwVnrVdoxJNw4y5zxolaTy9n
    aVHvWRK5hIQ2ZS60pmGFaC5ag7wXBZozPI0Fit1DgZbDIULjEA8oetA9DdJ8kMZs
    Fi2f6HDWstQmHJwJaLyzWTMtai1r3ld84LO4YUKTjA45LjeOnZm/PHQHrpwUTNmP
    k/Sr5U2X8Q/tpzfRJj/tgtyIdwcuyDKnr6Su9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=arctest; t=1520409425; bh=YqTGh1DjesvaEP3uo3C
    gdaz2m/Ro5OSgzDNyKH3+z5s=; b=j/dMsmhKE/VUQNmTPxYTbJhhTTAGGNWRvoP
    2T3nVRjVaCtskOaPFQWxIcFuJfByoSpt8Me4IbO7pM3iQ+iu4UwkQrAI+9hakVtv
    s8hcVxUhvOearrwm6krCZO8xfAF1z+Kh6Bonvd30qsdrHDV7Uq/WAL2zw/b7E7jQ
    IoLGjPxnNAVcPgvoVbZA5WUoJWEy3aRhDZhp6KO3wOBPNS1KavxMGBa0tukM0y/s
    gzkUjAx69oxUUTpwSx69/zuFMTYtDZun4teqn8G05+xE7aGQjxtnsXVTKeSG89Yr
    GNd7XJNBuEf3aAaieYDjOACWPtK+zaAW9ebfe9xiA7mdzzBKPQQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeCGH5D (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 02:57:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751090AbeCGH5C (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 02:57:02 -0500
Date: Wed, 7 Mar 2018 13:26:53 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, stable@vger.kernel.org
Subject: Re: [RESEND][PATCH] cpuidle/powernv : Restore different PSSCR for
 idle and hotplug
Reply-To: svaidy@linux.vnet.ibm.com
References: <1519846389-29414-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1519854022.2520.12.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1519854022.2520.12.camel@au1.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 18030707-0016-0000-0000-0000052DCB6E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030707-0017-0000-0000-0000286AE50A
Message-Id: <20180307075653.GB26738@drishya.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Benjamin Herrenschmidt <benh@au1.ibm.com> [2018-03-01 08:40:22]:

> On Thu, 2018-03-01 at 01:03 +0530, Akshay Adiga wrote:
> > commit 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> > states via stop API.") uses stop-api provided by the firmware to restore
> > PSSCR. PSSCR restore is required for handling special wakeup. When special
> > wakeup is completed, the core enters stop state based on restored PSSCR.
> > 
> > Currently PSSCR is restored to deepest available stop state, causing
> > a idle cpu to enter deeper stop state on a special wakeup, which causes
> > the cpu to hang on wakeup.
> > 
> > A "sensors" command which reads temperature (through DTS sensors) on idle
> > cpu can trigger special wakeup.
> > 
> > Failed Scenario :
> > Request restore of PSSCR with RL = 11
> > cpu enters idle state (stop5)
> >   user triggers "sensors" command
> >    Assert special wakeup on cpu
> >      Restores PSSCR with RL = 11  <---- Done by firmware
> >       Read DTS sensor
> >    Deassert special wakeup
> >   cpu enters idle state (stop11) <-- Instead of stop5
> > 
> > Cpu hang is caused because cpu ended up in a deeper state than it requested
> > 
> > This patch fixes instability caused by special wakeup when stop11 is
> > enabled. Requests restore of PSSCR to deepest stop state used by cpuidle.
> > Only when offlining cpu, request restore of PSSCR to deepest stop state.
> > On onlining cpu, request restore of PSSCR to deepest stop state used by
> > cpuidle.
> 
> So if we chose a stop state, but somebody else does a special wakeup,
> we'll end up going back into a *deeper* one than the one we came from ?

Unfortunately yes.  This is the current limitation.  If we are in stop4
and above and we had not set a PSSCR to be restored, then the hardware
will default to all bits set (stop15) leading to entry into stop11
after the special wakeup is removed.  The requirement is such that we
need to have a correct PSSCR restore value set using stop-api.

We need to set a restore PSSCR value that represents one in a group
like stop4,5,6,7 will have identical state loss, hence we can either
set a PSSCR of 7 or 4 or 5 for any of this stop state entry and not
have to use stop-api to set exact value of stop4 or 5 at every entry.
 
> I still think this is broken by design. The chip should automatically
> go back to the state it went to after special wakeup, thus the PPE
> controlling the state should override the PSSCR value accordingly
> rather than relying on those SW hoops.

Special wakeup de-assertion and re-entry hits this limitation where we
have lost the original content of PSSCR SPR and hence CME does not know
what was requested.

Additional stop-api calls from software could have been avoided, but
practically we have only cpu hotplug case that uses stop11 and needs
this stop-api.  We can default the system to stop4 or stop5 and then
make stop-api call to explicitly set stop11 and then hotplug out the
cpu. We have to restore the deepest cpuidle state (stop4/5) back
during online.  As such this is not much of software overhead. But we
need an elegant method to control these calls from OPAL flags so that
kernel behaviour can be more closely controlled.

If we want to use stop11 in cpuidle (despite being very slow) for
evaluation reasons, then we will need to make more stop-api call to
choose between stop4/5 vs stop11 since they belong to different group.
Even in this case, since stop11 is the slow path, we would want to set
stop11 before entry and restore to stop4/5 after wakeup.  This way we
still completely avoid stop-api call in fast-path stop4/5 entry/exit.

--Vaidy
