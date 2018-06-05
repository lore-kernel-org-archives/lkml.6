Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2547981-1528207580-2-2558989581467978113
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528207580; b=d3MeFal8Zw6RcNsLYY9d73phd8XOMl98mH8kD846G8jPspeYvF
    m9lyU6Qi3hPGk1IArJjEPIY/5+dUitQ/dum1+64b6Sr4KjXseGHkIMNn8Ds2hpp/
    Nfw/1knxaia8MP2wMY7mdpS95BZePx78XU+nEfFcPgtQuPXVIiLfLqVsCMt0PtvQ
    fmwjz5RKF84AA9yXZNSJgZNsmsZlAp1xkKB/QPgtFEGhWAPoNlvgg0E8LbLGMmwk
    tBXzVZsLMnPaNlDcazZxosqUCkXKU9NTP5YZCcPMpe7B17ZfRhb3gyY/WHMn9cy0
    ssox8owUAq+dFFcdLddsDONGiuPeGrlQrqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1528207580; bh=naKFJgHc9N88
    ItfJfsA78Dh+aYxt19PUTyn23RHWD6Q=; b=ZlM2ISRFk8XOUPP1YbilJPDVQXEE
    kaKPkGfw3EyVov7ftg/e52qcqEPW7iNOlxakaACRafZZ0dLd/jmyMxaHR9f+Oet7
    gNqWy7WICOgInyHkXLxsVhU1JofY7PbmJ84SEt2DDhLYLDftACK4LRGLG5foILCT
    926Cn0lgr57v0J32p4I64hUPmLZi3z9PEdnxnTqTsJpD3FIhILCfV5LojXU7culC
    tfEz9wO4iJG3h3WJ12xRHILL6OHpVwF54NBYe81XT2exQDuxgurzJLuc+Cyv2PA8
    +PfwYlr9ApgwLIJhHVzpFz+pmy3a6yKdDagXMjQHbsAhT4VJv7neSShCBA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNO+x+1xNX0UHrPjodU+j5fvgKb4oQZtFDN3VNA086gRhZeuQMFFsCSAErF2p+LWXYBhxzLnDLGqkCYACl+l7kbTew8CjxNpJYyA2ov6TMPXpT96O3wB
    Cu/aspxB7ISVuIS2ppGZ/MtMc2ZLJUw2UzS5EpqRfL2btkqB1xUE0Afgrbm6+/jjJhJs3JCjb0d0HrWpAcagIAxC7ipJJmghJJ2suG2y2jqwSChrE2CxY5wb
    10sOuz68SJbZSCyaCmoOdQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=hBqU3vQJAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=fyU5vZewpGDD9P8KC8gA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=WLjMIN4s_96MqnBbPenP:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeFEOGQ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 10:06:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752178AbeFEOGO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jun 2018 10:06:14 -0400
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>, James Morris <jmorris@namei.org>
Date: Tue, 05 Jun 2018 10:05:49 -0400
In-Reply-To: <CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1528121025.3237.116.camel@linux.vnet.ibm.com>
         <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
         <20180605040920.GA19747@mail.hallyn.com>
         <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
         <20180605132542.GA26722@mail.hallyn.com>
         <CAGXu5j+vsYHBpH75i=GxVfi0HgvsAW6zgz6V-eO8ZD13ykq2mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18060514-0020-0000-0000-0000029762C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060514-0021-0000-0000-000020E36A06
Message-Id: <1528207549.3237.149.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050162
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-06-05 at 06:43 -0700, Kees Cook wrote:
> On Tue, Jun 5, 2018 at 6:25 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Quoting Kees Cook (keescook@chromium.org):
> >> On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> >> > Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> >> > enough about it to keep bikeshedding, but since this set already exists,
> >> > it seems like the way to go.
> >>
> >> And the new hook is "load stuff without a file descriptor"?
> >
> > Yes.  Load stuff based on my own credentials not those attached
> > to a file.
> 
> Okay, I can live with that. :)

Can I get your Ack on the loadpin changes in v4a patch 8/8?

Mimi

