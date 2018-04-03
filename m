Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1765435-1522767255-2-2194881247271444991
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
    1522767254; b=gFIEQUIUjti3z0khw2aUT842QJg3FWxkGwgU0K2rmp1KlVchj+
    K9P+2KAFGPIidXYnU4MGKm/k62F3rfSFwGp2Pe8ID9U7gHzuly+pFZfRaF7xPFxj
    W7WvvWHtDFzse9Czpouul5tKaCXX9Bj5bmmGMAFXSqQmX3iRDPvcR3CtxNxARaX2
    O4f8lKm2u+2KVN+lVXryMsurQc1Qwc2DyYNJwOm7X3/M+53ee4yChmHYHgkvrqAG
    hlIFE1ZHu3+b7ws4ZXB1H7O7dhmoHWoXA1XO6cibm5InMYpOKUWnODWH+wIoZd+l
    q6XfB2mVPTvMVsQwmJorxGgDcdUmOxsk5jfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522767254;
    bh=jMTb3vFzLX4o+QJn/m4aXR6CwxZ+Kyb4qT9lIQROLYI=; b=hhsJ29jomLFi
    Tk5Rc4D6W9ETgpeUANZ8+hf4dK2lcsyLjz6PDbzSQ1U09OpHrLPi+XQ+3CCdkYGh
    yNv33cobBa7EHedfZ7kyHVh/ynIePUCQuWlrEDhuNznC4VmSSEQE0G1VwarkYA/s
    36Wfk/P10LIIp/WkE6bacDDg8PU4PfX0eZIJmGsLcBX72hVA1m7yrbro6oPTkwrN
    lhYNMC3OIRJ0aZ5Ml99HSJiGOTATsDPLoTCVOtbi4uRzqCbIyTG7t0eBQnVTMB1i
    rMcG8zmIJexauNt16GL/FPV5nzyHuSsRLmfCsK8StkbSIVGVNQDCbVnER71RsN+g
    KnbroZnjTg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfAZS4Ygnfa+y8V7aCekw4uq2di6nEMOCPnfb+NoBdn2JLzBHjv1r5cDuys52BFTum9jRMMOlaFz9pd0fwVV+rLi5ZSKRgChqWgi7usDx3+hiSotoO/mx
    CPBQOVzv43JRRKyjPDUFBBimPAkdkTkpQW2DLTcFvr/Q24eeSmwyYjLj57oKM5v5ymq4wtUvn2BFgl1DAX+xnYP8bC0ChA/uNvXT/TlwMiaBlAoftH3CxDq0
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=xRsK6Ehpj9F3wmsJmaAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeDCOyM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 10:54:12 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56313 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeDCOyL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 10:54:11 -0400
Message-ID: <1522767248.2654.105.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 22/97] scsi: virtio_scsi: Always try to read VPD
 pages
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Tue, 03 Apr 2018 15:54:08 +0100
In-Reply-To: <20180323094158.812011199@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094158.812011199@linuxfoundation.org>
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
> From: David Gibson <david@gibson.dropbear.id.au>
> 
> 
> [ Upstream commit 25d1d50e23275e141e3a3fe06c25a99f4c4bf4e0 ]
[...]

This is an incomplete fix as it only touches the single-queue host
template.  The other part is:

commit a680f1d463aeaeb00d22af257a56e111967c2f18
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Jul 5 10:30:56 2017 +0200

    scsi: virtio_scsi: always read VPD pages for multiqueue too

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
