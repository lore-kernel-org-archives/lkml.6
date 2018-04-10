Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3323945-1523348952-2-1805622153781474683
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523348951; b=tkV0HBDw2v5D7tMFYX/bZqM/7HRS7HuozZXR97oMqCHrwCBgqq
    P1WVEBq8fC73AJyNyKrN2yFl539aFYm4a7vRw0j5V2kCYvejXi452NHnvdwKYhOo
    rdjR+aPZGdGFtp8TQZ/TFMROTOriboU6Z/r/lV0kf88s2xXb0WBBl5epw+70xTFd
    xTxiiszHRPWF3uJQYwnrX/MD58LFT38vdxGrJ6BkwTnPQuZcp8LBfbyn1gVchSJT
    6vt6VABYvLK8wCWNDFhtrY66LhA9ctApYgat90wLTbi2ZchNuVmk3TPH+uaGvKj8
    z4QHbvKpBKZCFfPXK2c+Rl95SP/sTC/mmzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523348951; bh=J84Yue4zvyGKXs+iGLaM7WfvPaTAXi
    Cg6+wSitlNE2I=; b=u6m4zKkZ693Bt5qhtFfYTcVCXAx0XOd2ZamGfND3T2OG4F
    o4w+q7h3yaR/9anNIjJnHJiNlufF7rDK8KmkrkWpnfngQ5z94CWoXmUl5tuDx1jE
    Cl2LdzkuBOL2bIbSIWJygeDFz12wSnDagfyJkp9tuKFiMOR5Cvyoa2LaCHhRmHB0
    YUNBi0Zmp0cBc5hzZTmi66EVk0XWfG/y+IjGpE28sQ2T7BhjMGoUtKSAYwI0c+UC
    gSYvbZQXVFK787unsitKVBuYi0C5f51J70cuyoqObwY4fJDR9BlYJeP+nKUPr1s5
    /8vYUPqFOeW8hJyhlyuYIObw7/ivcC3HYc4/FFtg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC0RoXC1soy8+rY28VgI9itJSJn9wf57Qd/Z24tEApDPBKxk82YJuNBNr/l/iA9X8ttx1uJrlyHnvKRUB9SFfx6hemwxpKBXfgmegXSpcO2heSM5SfAp
    spCTeXV9HoVd0nsEfFSYlnDzO9rwkeTgz/YXMCLN2VV5gTc62epmSX+UvTroFmS1Kb44i/jXa989fDLGn2AWKSrwC3FG8fTxtqdYGQOkH7ru7F4VX37CXCK5
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=QT4TUvpHHPK0yr-yoKcA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeDJI3J (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 04:29:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbeDJI3J (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 04:29:09 -0400
Date: Tue, 10 Apr 2018 10:29:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 3.18.104
Message-ID: <20180410082901.GA12968@kroah.com>
References: <20180410071346.GA31194@kroah.com>
 <4656CE49-AAA7-4698-B71D-A968DBABD27A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4656CE49-AAA7-4698-B71D-A968DBABD27A@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 12:58:11PM +0530, Harsh Shandilya wrote:
> 
> 
> On 10 April 2018 12:43:46 PM IST, Greg KH <gregkh@linuxfoundation.org> wrote:
> >I'm announcing the release of the 3.18.104 kernel.
> >
> >Only users who had build errors in 3.18.103 need to upgrade, this is a
> >single-bugfix-only release.
> >
> >The updated 3.18.y git tree can be found at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> >linux-3.18.y
> >and can be browsed at the normal kernel.org git web browser:
> >	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> 
> OnePlus3T doesn't use the fec so nothing there to really test, but this builds fine.

Thanks for at least test-building this :)

greg k-h
