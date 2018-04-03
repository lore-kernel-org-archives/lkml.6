Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2496537-1522791992-2-4983399337720901381
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522791992; b=YRJXKOdGgMZevBaVMY9nFEFIgaYMIo3Df/U78SPgbSZqD90AAe
    Mri+RFdxIwmy301EF+sWEdoQ0/d2LJ+B+O4INBX1DWbqXIO57uiSbc1CoGEEBb46
    VjsVCRjT9bQWVmJLkD+c8cXlmTkD6Z9NKL8ZMXdGVkq96KCudauSQVmxdjBsVSV0
    5YGhUGMdClO1uKJXb2JoQzShAic+AcXK2CnLQYL8r18DlDOXMmsLkbfqjBpIUb+J
    ohGOFBSq9IpRdpF7KsaUEBaPPhBDOVShVReMPySWCH4yNAIRoSxW3d1fHOrsKmMR
    fq3/dglW96TMs1v8qGoYHVvqMGKplas4DFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522791992;
    bh=+L5ea0qDgzGj1aSA/SiUFSyS+pNRI1kxzCfqcNKPV+g=; b=CMSXK7pMjCzk
    1/hFb7ed7Dv+S5AzGOy1RyOcyRhrX6l601QHiHHU1keMYYX6ga9IKCzy4sJ6JkCk
    fZkU+uCkRIo2ZuKRHmNLyCiPV3/vNrX6S2ajwpdAp4LHgIGxb2bdH//OugwfIIuD
    IDbold/EDsQc2bSs55EwPqqbQfHPp19ySFBolrRztVzJPNlR/I4igi5lrBxWnuaa
    fESa1t95AVPBgzxdTwnHlxe4wIe/U8O2Vj6aVvLX0M7B382idy9NIVxTWh3stb6X
    1cZ5ndWBIi6j/WsUDlE8nj3DMdgoEYFcaQsrLvKdFDhTqcHog4VoFfX+Fs1kKqMU
    VzQbA2hjpQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBpNyWawDHueVkZfIqaVh6bF8WAbLumBEdAxa0wnjBhzL05VppHXcRralWlPLMH8iq5hKmFn2SeIE3egw/KL/pdqT0QkCT8asKgJfoV201iFZbWVNJqi
    m+pzHv3rx4lgy/JF8bf0gJHARRr6JZdRmSxpPN+CGJl3UYmPAgsBHwaM7T8qgbM6kNldbF3JTNR1CN065P4raHFzACwzZoDeDt4kGi85v45QRnf9EIWFB+bA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Csv93wv4BVeGjb8N8akA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbeDCVq3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 17:46:29 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34082 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeDCVq2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 17:46:28 -0400
Message-ID: <1522791985.2654.142.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 70/97] rtc: ds1374: wdt: Fix issue with timeout
 scaling from secs to wdt ticks
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Moritz Fischer <mdf@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Tue, 03 Apr 2018 22:46:25 +0100
In-Reply-To: <20180323094201.536829633@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094201.536829633@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Moritz Fischer <mdf@kernel.org>
> 
> 
> [ Upstream commit 453d0744f6c6ca3f9749b8c57c2e85b5b9f52514 ]
> 
> The issue is that the internal counter that triggers the watchdog reset
> is actually running at 4096 Hz instead of 1Hz, therefore the value
> given by userland (in sec) needs to be multiplied by 4096 to get the
> correct behavior.
[...]

The wdt_margin module parameter has the same problem.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
